Return-Path: <SRS0=v2je=OV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40A5AC65BAF
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 22:18:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 021C02084E
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 22:18:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lixom-net.20150623.gappssmtp.com header.i=@lixom-net.20150623.gappssmtp.com header.b="Cp2SQtA5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 021C02084E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lixom.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728824AbeLLWSH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Dec 2018 17:18:07 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:35117 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728520AbeLLWQ5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Dec 2018 17:16:57 -0500
Received: by mail-lj1-f193.google.com with SMTP id x85-v6so19932ljb.2
        for <linux-kernel@vger.kernel.org>; Wed, 12 Dec 2018 14:16:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lixom-net.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=hY3w+zeFS5PopVQkS3rMiZg3FrfXLFppwOIOWZ3z/sA=;
        b=Cp2SQtA5AmKnLCr14GgkRYJMZZDLRdIQqfmvLhrlyftI8cBVOG8DZ1H9n1tZdEa7aG
         vDO92gjMtkmzJfTpmCu413NgkWP6UukkvLMdOx4Tfr0K1c9Ys85uKxfmq14k3Td8JAGH
         pp31qGDtZNzR0JvFBAakIXnSplR0772q4BUn1yNulfblbc68ed9FvthTbUZBaiKFCBTE
         e79DGVHJ1bmA6QsU/Y8SjPj6clz0XvLoJCJSwlYWvV25yelmf66e4oVeoEz+n8vQ8XLm
         5KprPPaBCH2ixRnbyfXd2X2grRi249KUXVydK2O/w4aDxFUUqis4gQ6kx7rmn9HOAKKe
         zu4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=hY3w+zeFS5PopVQkS3rMiZg3FrfXLFppwOIOWZ3z/sA=;
        b=rV9GMpSGUiwS0nAqCecxBITj0wkjIQi03dLmZqdfwd3rBud9P0nYMxQIGe0nUMSfHz
         FgPzx2rSaHCk075IWL9NFvB99VrF28VxJU6LRt3ONNA+wZ+QYtKMGqL28BySCOxGp9VP
         FO4vt9TkokGfJM3WECOa3WAunrfuHGY/VpqSuaVhXLa749k+5TnGa0amSRziXZI9gbpp
         dtSvzyTRtJZ+3u+nm5IUOhJa5Wqy3o/bWeFi6lSM8YXpbDD/nWeTia423pWFBTcQa2uC
         iN60V2s67cRtMmuYjWTlvYi/f+z2p7asXLjDEGk8WbNh6u41R5WwUydxHkKFj8uTym3X
         oCQA==
X-Gm-Message-State: AA+aEWYyRo7o1zFo/84EAMzxK65hxe8y9XDQp4OcRg5ko04LXLhailr5
        7d3vxb4QMtMznKewwufs7+IJlg==
X-Google-Smtp-Source: AFSGD/VTyXzkeN/3f4is+SKZQr7L93PQj9FWMssgLruF3XyK2SJ4IuO9iftrHHYtHIIIqlvVhHkYxg==
X-Received: by 2002:a2e:4601:: with SMTP id t1-v6mr14478280lja.111.1544653014877;
        Wed, 12 Dec 2018 14:16:54 -0800 (PST)
Received: from localhost (h85-30-9-151.cust.a3fiber.se. [85.30.9.151])
        by smtp.gmail.com with ESMTPSA id x204sm6284lfa.5.2018.12.12.14.16.53
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 12 Dec 2018 14:16:53 -0800 (PST)
Date:   Wed, 12 Dec 2018 13:55:35 -0800
From:   Olof Johansson <olof@lixom.net>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     arm@kernel.org, Lubomir Rintel <lkundrak@v3.sk>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] ARM: mmp: fix pxa168_device_usb_phy use on aspenite
Message-ID: <20181212215535.5evv7fk7ed57gw7s@localhost>
References: <20181210204340.2269622-1-arnd@arndb.de>
 <20181210204340.2269622-2-arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181210204340.2269622-2-arnd@arndb.de>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 10, 2018 at 09:43:02PM +0100, Arnd Bergmann wrote:
> This one ended up in the wrong header file, causing a build failure
> on at least one platform:
> 
> arch/arm/mach-mmp/aspenite.c: In function 'common_init':
> arch/arm/mach-mmp/aspenite.c:260:28: error: 'pxa168_device_usb_phy' undeclared (first use in this function); did you mean 'pxa168_device_ssp5'?
> 
> We can just include both the pxa168.h and pxa910.h headers to make
> that work, which gets us to the next failure:
> 
> arch/arm/mach-mmp/aspenite.o: In function `common_init':
> aspenite.c:(.init.text+0x1c0): undefined reference to `pxa168_device_usb_phy'
> 
> This is solved by using the matching ifdef check around the
> USB device registration, enabling them only when either USB
> host or gadget mode are enabled.
> 
> Fixes: a225daf72ee7 ("ARM: mmp: add a pxa-usb-phy device")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Applied to next/soc. Thanks!


-Olof

