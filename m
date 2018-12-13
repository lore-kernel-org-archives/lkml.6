Return-Path: <SRS0=yjy/=OW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 120B4C65BAE
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 06:51:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CA3842080F
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 06:51:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lixom-net.20150623.gappssmtp.com header.i=@lixom-net.20150623.gappssmtp.com header.b="PeM7Xy6H"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CA3842080F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lixom.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727292AbeLMGvp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Dec 2018 01:51:45 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:45019 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727261AbeLMGvn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Dec 2018 01:51:43 -0500
Received: by mail-lj1-f193.google.com with SMTP id k19-v6so764625lji.11
        for <linux-kernel@vger.kernel.org>; Wed, 12 Dec 2018 22:51:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lixom-net.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=QhSVaQYJedSA+aBywG/Ib4vn4OqSeRDKiRI2SrKATuI=;
        b=PeM7Xy6HhDd4Ayll1qqzFXq2U14GOCAaNBCoUrS6tieOelDToewJCXAG2lc6kNUUyj
         L6QitWP/OQNqFqoLHZU1wS02CoKmhqEF4loMKtNpEN8gEltkVL2Gn0yXsqvmb8bFs8ty
         nUObes5DqKjg6zxegNE2NEP586K0b8BpMU6MFjsPOQUsJRecM3+XgSdM1Y0tLHycNEPJ
         lI/x6R2XHqcuca3/pa8p+vOy3bls6/eEj2rl55H3XyPQ1ZsZlIpG6IVVgbc9mvVWm1kq
         WrHtGvzPLYtMXBNE0RBppLRL0+2l4TW23SRRFVpthoYaMg5kMV4CiYgCiOqvR8XZFjTu
         suQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=QhSVaQYJedSA+aBywG/Ib4vn4OqSeRDKiRI2SrKATuI=;
        b=jvgn29k5nO1od/DuDML6INZvHTsL1O0eEJu3EtxAqBpqHnXirLfCuzKHk68SWo5St9
         pxZTGMp1wE9Ha8Ew1UHbunQ1VnxXmU2Jwh78rzg+kNaBmeCNsTGkg9OG+7mwClYULUei
         pjMKzn/GRld5qVqv0jxC0lNTDdMceA/h8+ANoHwl0qOMPTiq+xQl6pQQVXr/sX1i9smJ
         mTLPoQvH9QH2aBRHq3xtrUBpf65w0QkIgkPTsDPoOcQSvR2/QWZRibXuxXa/t3HSDOkf
         5yPzt4iXniMfu8VoyATaaUnIPk5zR3VEvkUPcl0al9d5C33dTwmGiQfuw8CwKCev4lqd
         GuNQ==
X-Gm-Message-State: AA+aEWZ1dd/Q9PgpVJMoiF56/Ur+0d5EAocUOIuH9zz6iFQ9vO46y4+h
        wmcjDaWgoo+jG3pGIE64VWB2aw==
X-Google-Smtp-Source: AFSGD/Xr3A13sIjQXFIMIvb8VH9ppwfQDM7+S/4TMGelmTKM7+BOqjsb+jcXuzRXXQbncer9umAN4w==
X-Received: by 2002:a2e:6a13:: with SMTP id f19-v6mr15278163ljc.41.1544683900803;
        Wed, 12 Dec 2018 22:51:40 -0800 (PST)
Received: from localhost (h85-30-9-151.cust.a3fiber.se. [85.30.9.151])
        by smtp.gmail.com with ESMTPSA id 15-v6sm166712lje.18.2018.12.12.22.51.39
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 12 Dec 2018 22:51:39 -0800 (PST)
Date:   Wed, 12 Dec 2018 22:48:03 -0800
From:   Olof Johansson <olof@lixom.net>
To:     Horia Geanta <horia.geanta@nxp.com>
Cc:     Marc Gonzalez <marc.w.gonzalez@free.fr>, arm-soc <arm@kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 7/9] arm64: defconfig: Enable FSL_MC_BUS and
 FSL_MC_DPIO
Message-ID: <20181213064803.kd7p7fzsegu6nhnl@localhost>
References: <49a5d199-4eeb-a7c2-b539-13356162547f@free.fr>
 <beb32683-fbd0-fc17-8e71-4f4f51163223@free.fr>
 <VI1PR0402MB3485824A9FB3BC878E7B83D498C60@VI1PR0402MB3485.eurprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <VI1PR0402MB3485824A9FB3BC878E7B83D498C60@VI1PR0402MB3485.eurprd04.prod.outlook.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 09, 2018 at 06:05:24AM +0000, Horia Geanta wrote:
> On 11/9/2018 3:11 AM, Marc Gonzalez wrote:
> > Commit e8342cc7954e ("enable CAAM crypto engine on QorIQ DPAA2 SoCs")
> > enabled CRYPTO_DEV_FSL_DPAA2_CAAM, which depends on FSL_MC_DPIO,
> > which is not set. Enable FSL_MC_BUS, and build FSL_MC_DPIO and
> > CRYPTO_DEV_FSL_DPAA2_CAAM as modules.
> > 
> > Signed-off-by: Marc Gonzalez <marc.w.gonzalez@free.fr>
> Reviewed-by: Horia Geantă <horia.geanta@nxp.com>

I had to redo this one, and when I did I noticed that there's also an ethernet
driver. Should that be enabled as well?


-Olof

