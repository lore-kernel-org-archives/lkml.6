Return-Path: <SRS0=0E8K=OK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1D4CC64EB4
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Dec 2018 00:00:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 655D920867
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Dec 2018 00:00:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lixom-net.20150623.gappssmtp.com header.i=@lixom-net.20150623.gappssmtp.com header.b="BJYu+dsz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 655D920867
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lixom.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726936AbeLALL2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 1 Dec 2018 06:11:28 -0500
Received: from mail-lf1-f68.google.com ([209.85.167.68]:39373 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726871AbeLALL1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Dec 2018 06:11:27 -0500
Received: by mail-lf1-f68.google.com with SMTP id n18so5321693lfh.6
        for <linux-kernel@vger.kernel.org>; Fri, 30 Nov 2018 16:00:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lixom-net.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=bog9RbcReh2TVfdmWMrAjFIKK/3eT2sGrZ7SIoXfH34=;
        b=BJYu+dszxS+cHNB42uEF5A2YssZuQV6Syt4kU9F7fARv7G2JMIj3nabq22rtHkt/Qv
         eE2X+jDFuWCX9CdhrqrVV5lPAVFZF4lOOaj3kFfqD7AuZG0iCN6gTH1LYtX5S+/YSkww
         UiSAJvnzj2fveTFKLAUywPtDR5vSqjjWs+GJX8ssya8djaj5Hn+dwHUYaU+lpOiYq/fk
         aEkUNepj/y55vddXcfp1+caiE1imY2NL8cBOxHNk/ZN/BUnRCRb0ONx2xC4jsQE35qR5
         RNfVU9mJJY0sFrOWQ0uAAm0dgmsoSZAGJeDcFJglpnPd8p5MRGC+4WnQCedD71b2A9KJ
         0Wjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=bog9RbcReh2TVfdmWMrAjFIKK/3eT2sGrZ7SIoXfH34=;
        b=tuAOAZ6MuCKnsqaFpBp8QaEf5Xekemgr3tVtdCXOunh4DACqgJEJ2gaF5KNawzEYYd
         ZgGkQhMfTwB73maAwFm+O0iOtQepCGpuj1wDvRGj8J+xFsbVK4teUnWuSsT9zq9m3sI8
         jTU19Qrqlix/xU64TxOA85d6cIoRq4AB7SCqHvs0vK8EgJ3VYoCffYPhdkaJw5xWABqK
         kYZiuFkvou8tTEqpnw7uXKIT9MRq7YRmnXBMGXbLzVZezTVDQhUqwZesqtlvm/9/3r8n
         54yeToRJG9YQQBd7+/lkBUfVlQ7agRxlXefG623+cPdNgVHXw2JAOjVQu6zZEPSllq5R
         xwmw==
X-Gm-Message-State: AA+aEWb4Nb5oNGGK1H3d7EYOY2iFoll+kn6a/HCXW07Zbr/v6vyf4NwF
        A4PSpqt58ZAgvwzL/woo096Ty023bA1U6Q==
X-Google-Smtp-Source: AFSGD/XcWYyHGW2FeDYHNRSdBA9P52a0xBk6V5RFy+QXFCm9xOk5/OjJkHflcvWNFb3iXBImNld1sA==
X-Received: by 2002:a19:789:: with SMTP id 131mr982957lfh.11.1543622421717;
        Fri, 30 Nov 2018 16:00:21 -0800 (PST)
Received: from localhost (h85-30-9-151.cust.a3fiber.se. [85.30.9.151])
        by smtp.gmail.com with ESMTPSA id x29-v6sm1029636ljb.97.2018.11.30.16.00.20
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 30 Nov 2018 16:00:20 -0800 (PST)
Date:   Fri, 30 Nov 2018 15:59:48 -0800
From:   Olof Johansson <olof@lixom.net>
To:     Lubomir Rintel <lkundrak@v3.sk>
Cc:     arm@kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Eric Miao <eric.y.miao@gmail.com>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        Pavel Machek <pavel@ucw.cz>, James Cameron <quozl@laptop.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 17/20] ARM: mmp: add a pxa-usb-phy device
Message-ID: <20181130235948.o22ywxk4e6ixfh3s@localhost>
References: <20181128175324.163202-1-lkundrak@v3.sk>
 <20181128175324.163202-18-lkundrak@v3.sk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181128175324.163202-18-lkundrak@v3.sk>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 28, 2018 at 06:53:21PM +0100, Lubomir Rintel wrote:
> This is to replace the USB PHY initialization code (pxa_usb_phy_init(),
> pxa_usb_phy_deinit()) with a proper PHY driver.
> 
> Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>
> ---
>  arch/arm/mach-mmp/devices.c | 21 +++++++++++++++++++++
>  arch/arm/mach-mmp/pxa910.h  |  1 +
>  2 files changed, 22 insertions(+)

Applied to next/soc. Thanks!


-Olof
