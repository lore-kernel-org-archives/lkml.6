Return-Path: <SRS0=0E8K=OK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CD5AC04EB8
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Dec 2018 00:00:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BFB8B21479
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Dec 2018 00:00:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lixom-net.20150623.gappssmtp.com header.i=@lixom-net.20150623.gappssmtp.com header.b="V+m3djvo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BFB8B21479
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lixom.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726887AbeLALL0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 1 Dec 2018 06:11:26 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:33079 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725867AbeLALLY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Dec 2018 06:11:24 -0500
Received: by mail-lj1-f195.google.com with SMTP id v1-v6so6504379ljd.0
        for <linux-kernel@vger.kernel.org>; Fri, 30 Nov 2018 16:00:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lixom-net.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=DzZrpkj9SH92CVO4vfiT66aL5a4djCSa5PWRrqMJ5bM=;
        b=V+m3djvobi4ISBeMIDH5i14yQZadnsKpppHy5V9tFR3q9DAIO8dLw0hx0DgUAlBnuH
         ObnDD2JHVBOonbyp5jRaO0yshfPgnjgDlCyDX1flkLr9vA/0K0XIecqtOunPPCvEivzH
         zfcQeLbOqSaPJFls1L2aMO0HvShJlai9Pk9Iel4tMpGNTJbKV1UgqgKatFW7RKYrar71
         yL43cipjC0hIPy8bPh1v9d4NUB9rVb/81l4NQjDH2HNTGmOVhnl/exvQd+R2fH0iZCLZ
         xsQxpcatSMdJ2Wb1u8GAQnReam006kqbjWfNS3jHoccvSLdGHaPbY+x2qOEgz1Oig5O/
         nACQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=DzZrpkj9SH92CVO4vfiT66aL5a4djCSa5PWRrqMJ5bM=;
        b=iIyEd8k/CI5+VGPC3QVnld5Xz6UMQagorFUVbYrQDlWrIXraYVqYVGpe7NUC8baLsI
         C5txY8pv0hdo452Nl96p39oiDFPNDz55VmChaPI/5qXN8R7sgOkjcYSe5RXxdi9kHiIn
         fuUT8ARGmDWBvuIsMRxgtu2PnGBWT+hfRdlaeFz13qdjBtZULC2yiw/4asmaoD7sNoEz
         fhnJ/RCf+hNbAjH36eHYvlQSSQZqVKcKfimMLbfQ6XnCs6R4Jd6uzFaVKknRdDoPTRV6
         mMsOl9l6/0QVqjzZE92fcg5MrKL1L2sB03ihS5QY7s/NH/ktslO3cw71RWYnCqlNRVNf
         pIdQ==
X-Gm-Message-State: AA+aEWaUYP+cXo4Ya58Pwmk85k3qp0f9uIJfhMI7Ke8nNRKS8ReHsMBX
        UADgFNgF8Tks8p8czdk8vUb04A==
X-Google-Smtp-Source: AFSGD/X/ljl9IQkMxzl8Uu423qdCmOEBzAyLIchlatcmeNsrvNMGPkMis0sFrzm4eydGMM8zQ/QQAg==
X-Received: by 2002:a2e:8ec8:: with SMTP id e8-v6mr5054280ljl.162.1543622419567;
        Fri, 30 Nov 2018 16:00:19 -0800 (PST)
Received: from localhost (h85-30-9-151.cust.a3fiber.se. [85.30.9.151])
        by smtp.gmail.com with ESMTPSA id d75sm1165327lfe.0.2018.11.30.16.00.18
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 30 Nov 2018 16:00:18 -0800 (PST)
Date:   Fri, 30 Nov 2018 15:59:38 -0800
From:   Olof Johansson <olof@lixom.net>
To:     Lubomir Rintel <lkundrak@v3.sk>
Cc:     arm@kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Eric Miao <eric.y.miao@gmail.com>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        Pavel Machek <pavel@ucw.cz>, James Cameron <quozl@laptop.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 16/20] ARM: mmp/mmp2: dt: enable the clock
Message-ID: <20181130235938.zcxljgb4babgjflj@localhost>
References: <20181128175324.163202-1-lkundrak@v3.sk>
 <20181128175324.163202-17-lkundrak@v3.sk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181128175324.163202-17-lkundrak@v3.sk>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 28, 2018 at 06:53:20PM +0100, Lubomir Rintel wrote:
> The device-tree booted MMP2 needs to enable the timer clock, otherwise
> it would stop ticking when the boot finishes.
> 
> It can also use the clock rate from the clk, the non-DT boards need to
> keep using the hardcoded rates.
> 
> Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>
> Acked-by: Pavel Machek <pavel@ucw.cz>

Applied to next/soc, thanks!


-Olof
