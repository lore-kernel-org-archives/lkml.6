Return-Path: <SRS0=sczE=Q3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C35BC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 18:37:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3039521841
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 18:37:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=netronome-com.20150623.gappssmtp.com header.i=@netronome-com.20150623.gappssmtp.com header.b="0O9WHSUJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726751AbfBTShR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Feb 2019 13:37:17 -0500
Received: from mail-qk1-f193.google.com ([209.85.222.193]:39472 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726013AbfBTShQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Feb 2019 13:37:16 -0500
Received: by mail-qk1-f193.google.com with SMTP id x6so2627864qki.6
        for <linux-kernel@vger.kernel.org>; Wed, 20 Feb 2019 10:37:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=netronome-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :organization:mime-version:content-transfer-encoding;
        bh=hj98M0pVz1mNdgLxy5nvbvxoQiWtuOkUSUyUgnwHDuo=;
        b=0O9WHSUJCwKGibZnw2t5buz4ju2QNdIs6EsNj6Jw8JPOpq8sk9+c2GiUmjinTF3pFE
         +agCzMnEi9NI6sHakxvrV662y/gDNVw7DcBAkPhzr7xXrx7HCpTOMJrnZJSVC7fuqteL
         MMWGkXTlBEY7DmRL+G9ewA1U+7zM/ssl9QjRWXtziowvRrd66+HSNeo+0WHGIPgn9Mdd
         AKpvc/Z2R6P9J8eqvRnK+9F1ydndIgrB885Gu8idI2n4blcVS3vdMlQRxewv0Nik4xjt
         rege1w+mZP8IXLtS54H7xsce0nBHMlx3EJd7Wla1lJi2zKI0knhXux9AgpcC359JuKv3
         B8KA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:organization:mime-version:content-transfer-encoding;
        bh=hj98M0pVz1mNdgLxy5nvbvxoQiWtuOkUSUyUgnwHDuo=;
        b=PaC67AQlvJHt1DEzL7ER2+M/Yy0jXTm2/BpguLxx1RvSz0wftdmwYDnyy/NRQBS0IL
         K3twkUWXaWa5AiEPjNhhoYNqYkvZZz7bI/EsVcccxCMHbzoaq+2j05NL5gjGxQ3g4NhB
         +f62UACAIWe1paL5mlME6eO0p8YefWzOlGD/UdTYvyzLGmuWUYw9M+19MwSjQ3Ihu99v
         4a3JVY7yREOi4QGbC6eyFJPXyFwMMmDcqMs+JbBySjKSdSVhN/7EY8r+GLR8LVp0JVAA
         uPBX8MuNLL0SBYsZ/F4ksgwlk/VhQU7yqAvikr7d/M8J23O/CUQ4rRK8E9p9gC2txudF
         7adQ==
X-Gm-Message-State: AHQUAua7L8/cnf9Gw9jwDCzruwEoqaj/Uppsx2VVqoed4ft54KeOjuh5
        q82w418UMG+cu6fpRlutj8K8mQ==
X-Google-Smtp-Source: AHgI3IbzjbXu8SzOl5/hCI02CBUfiKea+YDIe5WHlxZ2aRD34lT+P+ABKME0qeRna2YC0vjJTgky3w==
X-Received: by 2002:a37:aec5:: with SMTP id x188mr16723354qke.320.1550687835271;
        Wed, 20 Feb 2019 10:37:15 -0800 (PST)
Received: from cakuba.netronome.com ([66.60.152.14])
        by smtp.gmail.com with ESMTPSA id u32sm25580143qtc.54.2019.02.20.10.37.14
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 20 Feb 2019 10:37:15 -0800 (PST)
Date:   Wed, 20 Feb 2019 10:37:09 -0800
From:   Jakub Kicinski <jakub.kicinski@netronome.com>
To:     Michal Kubecek <mkubecek@suse.cz>
Cc:     netdev@vger.kernel.org, David Miller <davem@davemloft.net>,
        Andrew Lunn <andrew@lunn.ch>, Jiri Pirko <jiri@resnulli.us>,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH net-next v3 13/21] ethtool: provide timestamping
 information in GET_INFO request
Message-ID: <20190220103709.122260d6@cakuba.netronome.com>
In-Reply-To: <20190220130007.GI23151@unicorn.suse.cz>
References: <cover.1550513384.git.mkubecek@suse.cz>
        <790ee93d90931278b6e4fc51da712aadfcb8ec90.1550513384.git.mkubecek@suse.cz>
        <20190219190048.1c8a4482@cakuba.netronome.com>
        <20190220130007.GI23151@unicorn.suse.cz>
Organization: Netronome Systems, Ltd.
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 20 Feb 2019 14:00:07 +0100, Michal Kubecek wrote:
> On Tue, Feb 19, 2019 at 07:00:48PM -0800, Jakub Kicinski wrote:
> > On Mon, 18 Feb 2019 19:22:29 +0100 (CET), Michal Kubecek wrote:  
> > > Add timestamping information as provided by ETHTOOL_GET_TS_INFO ioctl
> > > command in GET_INFO reply if ETH_INFO_IM_TSINFO flag is set in the request.
> > > 
> > > Add constants for counts of HWTSTAMP_TX_* and HWTSTAM_FILTER_* constants
> > > and provide symbolic names for timestamping related values so that they can
> > > be retrieved in GET_STRSET and GET_INFO requests.  
> > 
> > What's the reason for providing the symbolic names?  
> 
> One of the the goals I had was to reduce the need to keep the lists of
> possible values in sync between kernel and userspace ethtool and other
> users of the interface so that when a new value is added, we don't have
> to update all userspace tools to be able to use or present it.
> 
> This already works in ethtool for some newer commands (e.g. features)
> and obviously for those where the list of available options depends on
> the device (e.g. private flags or statistics). I would like to extend
> the principle also to older commands and new ones which do not work like
> this (e.g. device reset).

Let me try to argue that's the wrong direction.  People should learn to
update their user space tooling if they want access to new features.  
In my (limited) experience trying to solve forward compatibility leads
to short term gains, and long term warts in the APIs and increased
maintenance burden in the kernel.
