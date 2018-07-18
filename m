Return-Path: <SRS0=35zj=KC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CBF0ECDFBB
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 17:17:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D9D6F20673
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 17:17:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ciwf1J8+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D9D6F20673
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731586AbeGRRz6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Jul 2018 13:55:58 -0400
Received: from mail-oi0-f66.google.com ([209.85.218.66]:36029 "EHLO
        mail-oi0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728000AbeGRRz6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jul 2018 13:55:58 -0400
Received: by mail-oi0-f66.google.com with SMTP id r16-v6so10227814oie.3
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jul 2018 10:17:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=/IAjABMMMoL0ik3vfv6PvvJ4hCS9txLnzfBLjK1OF3g=;
        b=ciwf1J8+YPzQY3qtCRKhe9J6BkjB08EdRNF9Ctk8RD2Dh54tk72hXxu4pLwAI1dkYM
         EH5XyOJQG1prli+Ysk/7SBsdkwonOjmE+zqApvBOpBF2oJC6riPSMqDilwUTV1SX9FKS
         JnCLaVSTwBKElX7kJ++C4MmWzNYSfEFv+4QIFNHCyYIDPbnWav8RtNOC+d6UgXOR6F1c
         QKoj1+3vDNyG4GHldFJ9EHzvOZMBwoAwsKihD1XoZtWK9KUAdVxrL7dPagXspRRlR/6M
         weh/rE9u3qOvCV8drxc0nTF8cOXkbNYdv4fxhKf6/kWPGZ2JgHrUSC8aArogh/06U+ff
         3kyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=/IAjABMMMoL0ik3vfv6PvvJ4hCS9txLnzfBLjK1OF3g=;
        b=JP0tcLrjMGNHCmkvOrgZqBaeesU8gnQfdXHJpuAkJmS8DLDdKhEeDGz7zc3n559ID9
         mGEFLkMKa9T8WVRiJc7SVkD20rtpkAT1Hwzid6sgmd1tI7z+YwkAhKW3v7mSoEaNnTM4
         /LLEVBSc4ChMluGjowjDD11ev2uVhXNlehWZEsKT8pj7SCdKeRoPQDaMqpOnP7nmb/FA
         BP2cgo2ZVswIu94JokcChPk0s9uWYckwwnR85oF7ClX3zsih3c6cQN7VE63AJBqX+gjg
         sfQAVi3T0FRlu2HwPOOBCYs3uW5W/fE0EYv1cLDS0B6Z5KJz2es1pYzVpTcSVyt3jJ+d
         GFbQ==
X-Gm-Message-State: AOUpUlGtrPoOdTJkE5ikNgcMrupxsFTclap3/v4Mf0Mw7ZQ4J1Fcs+nj
        U3S6+EbKZiL+DpGEnZIVrXE=
X-Google-Smtp-Source: AAOMgpdsMJkTDjp7LcVZqujz2j2I2uCa2+zF9W3lMjaNYZ0/41HPmxcT2C/I+GzhcOroctzrAjpd2A==
X-Received: by 2002:aca:b585:: with SMTP id e127-v6mr7497742oif.119.1531934225443;
        Wed, 18 Jul 2018 10:17:05 -0700 (PDT)
Received: from localhost ([12.130.117.108])
        by smtp.gmail.com with ESMTPSA id r133-v6sm3223371oia.33.2018.07.18.10.17.03
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 18 Jul 2018 10:17:04 -0700 (PDT)
Date:   Wed, 18 Jul 2018 17:16:47 +0000
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     ning.a.zhang@intel.com
Cc:     gregkh@linuxfoundation.org, rafael.j.wysocki@intel.com,
        linux-kernel@vger.kernel.org, mark.gross@intel.com
Subject: Re: [PATCH] driver core: support bus manage deferred probe
Message-ID: <20180718171647.xa3nyhvlwwejht7l@penguin>
References: <20180629070226.24506-1-ning.a.zhang@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180629070226.24506-1-ning.a.zhang@intel.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, Jun 29, 2018 at 03:02:26PM +0800, ning.a.zhang@intel.com wrote:
> From: Zhang Ning <ning.a.zhang@intel.com>
> 
> deferred probe will be hanlded by deferred_probe_initcall,
> starts at late_initcall.
> 
> this is too late to handle deferred probe, this will block kernel exec
> to userspace, make kernel initial time longer.
> 
> if we know when required resources are ready for a list of devices,
> related deferred drivers can be probe earlier.
> 
> add these kinds of drivers into logical list,
> eg, bus_type->deferred_probe_pending_list,
> then it can be easily handled by bus driver.

I do not see why bus driver would have a better knowledge about its
device dependencies to accelerate deferred probe retries; it all depends
on the platform. On some platform PCI is essential and devices on PCI
bus are needed early, on others we can push PCI initialization to the
very end as there only a couple devices hanging off PCI bus.

You need to find a better way to decide when to reprobe a device, and
that requires analyzing and tracking the dependencies between devices.

Thanks.

-- 
Dmitry
