Return-Path: <SRS0=yjy/=OW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB6C1C65BAE
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 06:52:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AD5242080F
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 06:52:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lixom-net.20150623.gappssmtp.com header.i=@lixom-net.20150623.gappssmtp.com header.b="O6yeEAUp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AD5242080F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lixom.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727465AbeLMGwH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Dec 2018 01:52:07 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:34769 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727158AbeLMGvk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Dec 2018 01:51:40 -0500
Received: by mail-lj1-f196.google.com with SMTP id u6-v6so808805ljd.1
        for <linux-kernel@vger.kernel.org>; Wed, 12 Dec 2018 22:51:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lixom-net.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=f+dqQ+gQRatgd27zUadLvVLrqMLHrjFK7tPpkgqay+s=;
        b=O6yeEAUp+WcqdsHc4ykm2UDHbBkNKjPjBjiYjedaR18NnVPVJ6DBVWD6ZqRYE+kzSO
         U3DwCUtiSnUc4onCnhwWDIrKHlXTMfmW0U2Qq8j41s7rXhYS6Uq2gX4bEySAeuviIgjj
         CttzfQDQu+8LaeynN+Bq936ZDM46dFDvxBundj4JYc54ZCsUMB5hXu4Ex/oAjZ+aM8wp
         CU5aJSrXZhY251mdsVhegRtrt8GaMKZ7AVi/WawuM/2A91by7VkhagkosA8zHrI8J6iQ
         hy71nq85elB/WyRp+wuVP9B/w7uTIkOJeNbCk6QICx/84fhn44Hdh4+WKt2dZu7Aaidd
         dbdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=f+dqQ+gQRatgd27zUadLvVLrqMLHrjFK7tPpkgqay+s=;
        b=pStYg01WKkkYyMHAXIr753ncdImVuTmtFq/RmJv+c7NoFkabKDLbSEIOmiKGi4xe5a
         8GuBXDXKZDShfhmUGkDrNiAkgUseQ6unS/iRmp1ISO3N11fc5M1n4ibN/oeiJcuDlssF
         BeOEJEJPusI9s0mKnJdPRSaG8KjhpiY83lW0Cd9rYDSRTAQNasOoVvazIX/VO1/6Fing
         4K6zr/Uxsf1OKzluA6QHE1peDKxSl/pIBPKnoRdyZpqWZG60K+yrgGp82Osh5vVtw+re
         tugIOD85g1GMjt0szavsRtz63x5HJbMbHI3hpxmmConnipjqMfdkQ0fx369OvjT+vhL6
         L+dA==
X-Gm-Message-State: AA+aEWb6ZXgyaZk/oZmB2zzV80MsTqhB5hybvNNV5KyvgMbu1/tL+F2e
        dG43c3sU5JUr40SOPAYk7kNYZQ==
X-Google-Smtp-Source: AFSGD/Wi7FFI2BAbqsQFgx1NvN7dDhywGpU2sE+7AMxg/55dvU1CJ72zF1mv+mZG5ADUftP0DutxlA==
X-Received: by 2002:a2e:9e95:: with SMTP id f21-v6mr13796777ljk.128.1544683898574;
        Wed, 12 Dec 2018 22:51:38 -0800 (PST)
Received: from localhost (h85-30-9-151.cust.a3fiber.se. [85.30.9.151])
        by smtp.gmail.com with ESMTPSA id b17sm180280lfc.21.2018.12.12.22.51.36
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 12 Dec 2018 22:51:37 -0800 (PST)
Date:   Wed, 12 Dec 2018 22:47:35 -0800
From:   Olof Johansson <olof@lixom.net>
To:     Marc Gonzalez <marc.w.gonzalez@free.fr>
Cc:     arm-soc <arm@kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 6/9] arm64: defconfig: Drop redundant
 SND_SOC_ROCKCHIP_I2S
Message-ID: <20181213064735.j3l5luli7hzkwzcv@localhost>
References: <49a5d199-4eeb-a7c2-b539-13356162547f@free.fr>
 <f893ee9c-210e-8dc2-8660-fc9a9b2a567a@free.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f893ee9c-210e-8dc2-8660-fc9a9b2a567a@free.fr>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 09, 2018 at 02:03:55AM +0100, Marc Gonzalez wrote:
> SND_SOC_ROCKCHIP_RT5645 selects SND_SOC_ROCKCHIP_I2S
> 
> Signed-off-by: Marc Gonzalez <marc.w.gonzalez@free.fr>
> ---
>  arch/arm64/configs/defconfig | 1 -
>  1 file changed, 1 deletion(-)

This one got covered by patch 1 too.


-Olof
