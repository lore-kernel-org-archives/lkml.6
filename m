Return-Path: <SRS0=sczE=Q3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7244DC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 03:01:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3C87421738
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 03:01:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=netronome-com.20150623.gappssmtp.com header.i=@netronome-com.20150623.gappssmtp.com header.b="GxymP3jd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730386AbfBTDA6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Feb 2019 22:00:58 -0500
Received: from mail-qk1-f195.google.com ([209.85.222.195]:38230 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727576AbfBTDA6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Feb 2019 22:00:58 -0500
Received: by mail-qk1-f195.google.com with SMTP id p15so1064073qkl.5
        for <linux-kernel@vger.kernel.org>; Tue, 19 Feb 2019 19:00:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=netronome-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :organization:mime-version:content-transfer-encoding;
        bh=juX1wN76JP94B/uHGj0u1Ad0DYR0Ddi6aWyIbgfKSxw=;
        b=GxymP3jdrGjPk+sfYHPqDVIcIx0onxqNTj6n/0OlNf6JAuXQes2k7Sr+2TU7g22vV6
         0RN0q94XJwBKjPHT8jPgTKjhKnzXgXRwLgQyMW/W99mufJN4lNRswNGDcKfVBagpiARa
         AP3GVeprDmksaNq+3MhsFtNq3JKQy9q5AcPZE+olELYluoZO/h4DC3oaosalUMeKkGmK
         V9Syd9+TJq6WQrzm/iRHA03w3lMNU26Riuk2frMNec+LWHactJqlWtj8S10mYQyDt0Ab
         M6qTmVc1ovPIZ9WwTa9JVZKEtyJvjQ0tqZ5ev+pl34wtDsvA854+PFwftjyO/v1lLw/q
         1PhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:organization:mime-version:content-transfer-encoding;
        bh=juX1wN76JP94B/uHGj0u1Ad0DYR0Ddi6aWyIbgfKSxw=;
        b=EFWNijkKYONED1pr2W75tYVbZB7WUM+ahwhl9QPbKfLt4THXGbSNSRwConVrvsUuqh
         vH/A5uEcOGTA5sY/0Q06vUswyNYm4s0H2Nqtm7rDoMOYMIyMIM1Kw0V9udk1gfHi/EFu
         bFb1tNt8SzkaohJ5/+gNho7u7C5boI6KcNS+nKgCzhHkPPbe+yhLdnfzkj5C9B1Iqfn7
         G1ezVAUNvWDiNbUpf2ygRYlB+cmGeiOb1dDMJKExnGcy0iV/O9S5HicdHITyeNGbiF/y
         738YfNXlJTqJDfqNmnj4wD9qoh0xK+FrFp+6IX7YjHBXZ31kp3Mc/olOo5+nm5KgBMKx
         zzVA==
X-Gm-Message-State: AHQUAuaBi1dgb+wS+6JXFvbeXrTiaOEtSebB7t2ljifvMREeKdan6CAQ
        22D3KYkUWR7V5bAOOZzRbw1O8Q==
X-Google-Smtp-Source: AHgI3IYhwqGp1qTspf2ZvhDfwEPSpMOjoEZWbONu/Qax0bpZrM+mObTxMI3b2lVsZSzwv7sHlCs44w==
X-Received: by 2002:ae9:e203:: with SMTP id c3mr22705458qkc.270.1550631657241;
        Tue, 19 Feb 2019 19:00:57 -0800 (PST)
Received: from cakuba.netronome.com ([66.60.152.14])
        by smtp.gmail.com with ESMTPSA id 55sm8914249qtq.25.2019.02.19.19.00.56
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 19 Feb 2019 19:00:57 -0800 (PST)
Date:   Tue, 19 Feb 2019 19:00:48 -0800
From:   Jakub Kicinski <jakub.kicinski@netronome.com>
To:     Michal Kubecek <mkubecek@suse.cz>
Cc:     netdev@vger.kernel.org, David Miller <davem@davemloft.net>,
        Andrew Lunn <andrew@lunn.ch>, Jiri Pirko <jiri@resnulli.us>,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH net-next v3 13/21] ethtool: provide timestamping
 information in GET_INFO request
Message-ID: <20190219190048.1c8a4482@cakuba.netronome.com>
In-Reply-To: <790ee93d90931278b6e4fc51da712aadfcb8ec90.1550513384.git.mkubecek@suse.cz>
References: <cover.1550513384.git.mkubecek@suse.cz>
        <790ee93d90931278b6e4fc51da712aadfcb8ec90.1550513384.git.mkubecek@suse.cz>
Organization: Netronome Systems, Ltd.
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 18 Feb 2019 19:22:29 +0100 (CET), Michal Kubecek wrote:
> Add timestamping information as provided by ETHTOOL_GET_TS_INFO ioctl
> command in GET_INFO reply if ETH_INFO_IM_TSINFO flag is set in the request.
> 
> Add constants for counts of HWTSTAMP_TX_* and HWTSTAM_FILTER_* constants
> and provide symbolic names for timestamping related values so that they can
> be retrieved in GET_STRSET and GET_INFO requests.

What's the reason for providing the symbolic names?

> Signed-off-by: Michal Kubecek <mkubecek@suse.cz>
