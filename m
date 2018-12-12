Return-Path: <SRS0=v2je=OV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 103E9C67839
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 22:17:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C97262086D
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 22:17:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lixom-net.20150623.gappssmtp.com header.i=@lixom-net.20150623.gappssmtp.com header.b="FulObfOW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C97262086D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lixom.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728783AbeLLWRf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Dec 2018 17:17:35 -0500
Received: from mail-lf1-f65.google.com ([209.85.167.65]:33784 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728121AbeLLWRd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Dec 2018 17:17:33 -0500
Received: by mail-lf1-f65.google.com with SMTP id i26so28107lfc.0
        for <linux-kernel@vger.kernel.org>; Wed, 12 Dec 2018 14:17:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lixom-net.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=pvkDH88DFEKX+nlI5rRYs99WCfwACxaTtGEVX/qvs+I=;
        b=FulObfOWgF7Hp2vGWadFKffj8xHPEtWOj/mE64WJlh3Zj8+BvhgX4GGpaJm/w+qFfI
         lgKIAjF33+8osO/KG8LPfg+IipmShFumCE1s2YavhLLfASiJdE2WfjsSGKWd77vVhgBX
         xrvmZkekbJ4rGPE24aesliUpdm0KQllBHqQ/2hjnewaki8b5nagvIbNa5DzXN4q2CVJo
         55RnTfmbB019TudGgc5GbCuHLnEMoia0oXfFog0g51X8dGM1k7aBZYtwLnJCRNA8oUr+
         Dx5F0mJ5H7xrY8BOcpyr0h8+FZ8gNH//CzMS+L+JjIwYScNArgNvVY3C/eDsys6ysqXI
         uEQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=pvkDH88DFEKX+nlI5rRYs99WCfwACxaTtGEVX/qvs+I=;
        b=i1xW3uwOqvhpG3WB0dGxrbOcl3RI8srfjz3eLOw5aHOAfXVjdV1YXZlGgeMDSFtups
         qDvID1Zj2S+rsFTcSXo1Pm6khnV0+x+EQ2/FBHYIQCmMucy6Ns5tdCHcsW7U6LaA/uRQ
         kYDW0kFNeBaXI3aRMmSADAcEt2N5AkB3q+Wv2mZkb2ApTz2vvsPrxzyT+6bZT0mw06B6
         qBCW5OFnEwaE0oQb+1ouP2okTjCio5fHF7qKBDQlHjKgSr737mcxrzP179pxnhgn+yPw
         AYtnAI9aeHc2sTr0JXVV7fhR+xyOepAGvgqy8cTq8v4HqrtMtT18Ks7dR4kjT1Lv52H+
         l7Eg==
X-Gm-Message-State: AA+aEWYfPihZydDoSYIxSlthi4/f1o101CcrE0jxrBBrLvfSjwTshiLt
        CxcE7dK0zrn1mJW7PecQ9ijqZq+gxZheqg==
X-Google-Smtp-Source: AFSGD/XCcYUUXPt6DMdnRVXjMZNM4P5h0/BQnFz7QwYh0YMWMTYTUsDrzH6FU6S7CQ/4Px87+LTQ4w==
X-Received: by 2002:a19:5d42:: with SMTP id p2mr13639219lfj.83.1544653051362;
        Wed, 12 Dec 2018 14:17:31 -0800 (PST)
Received: from localhost (h85-30-9-151.cust.a3fiber.se. [85.30.9.151])
        by smtp.gmail.com with ESMTPSA id p23sm2673lfh.47.2018.12.12.14.17.28
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 12 Dec 2018 14:17:29 -0800 (PST)
Date:   Wed, 12 Dec 2018 13:56:26 -0800
From:   Olof Johansson <olof@lixom.net>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     arm@kernel.org, Daniel Mack <daniel@zonque.org>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        Linus Walleij <linus.walleij@linaro.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Igor Grinberg <grinberg@compulab.co.il>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/4] ARM: pxa: avoid section mismatch warning
Message-ID: <20181212215626.p5otg6g7l5lut5n4@localhost>
References: <20181210215856.2238253-1-arnd@arndb.de>
 <20181210215856.2238253-4-arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181210215856.2238253-4-arnd@arndb.de>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 10, 2018 at 10:58:39PM +0100, Arnd Bergmann wrote:
> WARNING: vmlinux.o(.text+0x19f90): Section mismatch in reference from the function littleton_init_lcd() to the function .init.text:pxa_set_fb_info()
> The function littleton_init_lcd() references
> the function __init pxa_set_fb_info().
> This is often because littleton_init_lcd lacks a __init
> annotation or the annotation of pxa_set_fb_info is wrong.
> 
> WARNING: vmlinux.o(.text+0xf824): Section mismatch in reference from the function zeus_register_ohci() to the function .init.text:pxa_set_ohci_info()
> The function zeus_register_ohci() references
> the function __init pxa_set_ohci_info().
> This is often because zeus_register_ohci lacks a __init
> annotation or the annotation of pxa_set_ohci_info is wrong.
> 
> WARNING: vmlinux.o(.text+0xf95c): Section mismatch in reference from the function cm_x300_init_u2d() to the function .init.text:pxa3xx_set_u2d_info()
> The function cm_x300_init_u2d() references
> the function __init pxa3xx_set_u2d_info().
> This is often because cm_x300_init_u2d lacks a __init
> annotation or the annotation of pxa3xx_set_u2d_info is wrong.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Applied to next/soc.


-Olof
