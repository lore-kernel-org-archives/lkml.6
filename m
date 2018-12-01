Return-Path: <SRS0=0E8K=OK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B623C64EB4
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Dec 2018 00:00:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C438720867
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Dec 2018 00:00:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lixom-net.20150623.gappssmtp.com header.i=@lixom-net.20150623.gappssmtp.com header.b="qb3C7yAB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C438720867
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lixom.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726964AbeLALLd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 1 Dec 2018 06:11:33 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:39844 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725867AbeLALL3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Dec 2018 06:11:29 -0500
Received: by mail-lj1-f196.google.com with SMTP id t9-v6so6474918ljh.6
        for <linux-kernel@vger.kernel.org>; Fri, 30 Nov 2018 16:00:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lixom-net.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=nOU3GfuFFAcBmABFv3gNX6G3EYqrF4u+sfkYBqaoHcA=;
        b=qb3C7yABYNZCkIUZ6XOqo+f0QtUy/W/muH1tbTqWGMBCp3hrlr5QFyWYbuzytnm0OH
         i08NBSo0aAeSRYAWKAQUv1hKGfVexQVty+zhPwfbuc16g0GZ85OC11Q+quo1xiKtiz/6
         dtFf5ckgRHCDztQcXfMMgE7VWokoM8SfM/C2d4VUhEnwDclT19f+mz2peNsxhTQPOyOM
         6+jnIbkvXzQ3AJt1f9qxmISDSit8Qk9a7+anFlUlQlUCjRmPomIqYjw3q0hxUwNt2egp
         i40YH/QGe7hnVggeFDECzdCBpAUPFul25wLNHqvikM/bp3DvXJnLTCJBifq81nqRiyA9
         ojgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=nOU3GfuFFAcBmABFv3gNX6G3EYqrF4u+sfkYBqaoHcA=;
        b=LmD2kfKeooDS5rphEscpQx7oSl/jXzY/zC+smVnGQ0DRiibNi9S1Pw4rYnvNfhKaoD
         mJkBKc4upt8d45ZN3Y0Ko+VcfWvBK5evAKnpi9iCH5IV1Fgz5UyOL7Lvib1IGIojaxH4
         r8hOd0df2pZiLwPaflYMucJfbv5uCId9nwkfKqFugQ0IncWXxDoLzDQvwnyny1pXY2KZ
         BbcMgm5GWvYjAhjhxERyBIkDLEmdLPErZsm1RM5BnMaewMtlL/2dEXgTIAKbkZFZRwKb
         vfVuZra/VoWKOqepyjKY8/H5F1vVQP3rmV3tJfZvG8PeSDp1522ao29Ygk2XWLc2r4LJ
         FQgQ==
X-Gm-Message-State: AA+aEWaIJKAnr+PvzYAeFatRnsJVthIOVdlhJYdzp/jRHAOxarZxn2Cw
        cIAQI/dE9x1SlJlqXk2utII5UQ==
X-Google-Smtp-Source: AFSGD/WFbkSBo3GBQZQP1SUh/9a2T0RTCbcKuJEJyAcDfQs/GXsYGlqRdX0d1K+Imvw4KuB9dYasBQ==
X-Received: by 2002:a2e:2b85:: with SMTP id r5-v6mr4914402ljr.91.1543622423561;
        Fri, 30 Nov 2018 16:00:23 -0800 (PST)
Received: from localhost (h85-30-9-151.cust.a3fiber.se. [85.30.9.151])
        by smtp.gmail.com with ESMTPSA id p23sm1050955lfh.47.2018.11.30.16.00.22
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 30 Nov 2018 16:00:22 -0800 (PST)
Date:   Fri, 30 Nov 2018 16:00:04 -0800
From:   Olof Johansson <olof@lixom.net>
To:     Lubomir Rintel <lkundrak@v3.sk>
Cc:     arm@kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Eric Miao <eric.y.miao@gmail.com>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        Pavel Machek <pavel@ucw.cz>, James Cameron <quozl@laptop.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 18/20] ARM: mmp: add an instance of pxa-usb-phy to
 ttc_dkb and aspenite
Message-ID: <20181201000004.jxm6kwks4x5p5ejq@localhost>
References: <20181128175324.163202-1-lkundrak@v3.sk>
 <20181128175324.163202-19-lkundrak@v3.sk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181128175324.163202-19-lkundrak@v3.sk>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 28, 2018 at 06:53:22PM +0100, Lubomir Rintel wrote:
> This will replace the *_pdata.phy_{de,}init()
> 
> Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>
> 
> ---
> Changes since v1:
> - Squashed patches with ttc_dkb and aspenite changes together.
> 
>  arch/arm/mach-mmp/aspenite.c | 4 ++++
>  arch/arm/mach-mmp/ttc_dkb.c  | 4 ++++
>  2 files changed, 8 insertions(+)

Applied to next/soc. Thanks!


-Olof
