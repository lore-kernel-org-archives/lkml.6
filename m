Return-Path: <SRS0=v2je=OV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E068C67839
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 22:17:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 188632084E
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 22:17:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lixom-net.20150623.gappssmtp.com header.i=@lixom-net.20150623.gappssmtp.com header.b="rXUWt6G9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 188632084E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lixom.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728750AbeLLWRD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Dec 2018 17:17:03 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:35123 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728724AbeLLWRB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Dec 2018 17:17:01 -0500
Received: by mail-lj1-f193.google.com with SMTP id x85-v6so20082ljb.2
        for <linux-kernel@vger.kernel.org>; Wed, 12 Dec 2018 14:17:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lixom-net.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=aQUbPlGCwZxTnHTHCGeJKtvPeUVR4uN80qZQS4f5k3Y=;
        b=rXUWt6G9A47HZvFjTQEb/2LVceUfrxpXy1hYI1SAZQ+mcUKdODcgzdssaQWkdh+6ec
         mkJK04b6YaKkhj/eTwn6h59allvNBZhbt86bewFC6kiVpVsAzHMfkvSvpYkej4zrXY8s
         FB7UmQcnkYkhuUV+GS0CChLWa/486lGMk4RhgGot82G2mIGJI9FzNWbgI/bumV/lrODu
         Z0tXTaAbIYV3veBa9hwdJlz+mYUOqKiZGrylZMGme1ztlFXS2zf0cmcb2e8hFb76Iikr
         +jMEwWaCyywXDx2u3gD7kpTlCZDIUWQ+ynGwVhrY7SfpQD17X4BfNCscUXV9vxXu/9Mk
         NkTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=aQUbPlGCwZxTnHTHCGeJKtvPeUVR4uN80qZQS4f5k3Y=;
        b=SURh0t92XopzlaTAOR1/QVWjlW2+mD3OLHFPegP4XUzo+36vijamT5bwqtxzh1K9Fv
         u9pL/sMqq584C3QIuPFJR+hZ2JegrL36LMiQtPg+b2Neokl87tu7LYH1h5+AWemdbnia
         XUTiiQNmEReI+rl8abWGqzHEwaWFHd/xvTQyvk6+uU8GWA89FOYmrdwlPDqm/Zp/cwpP
         n69TqlQ4l8ojZNW9m3VEGwBceBX76jKE68W7LXmg5gZ/HpEDUW/hn25YFj2uiVlI00lU
         uJosDbHXqzi8zzT6mHEMj51Rsw14+YjupnqiuD/wuicViQCEn58weUfxDj6sJ8USknts
         N44Q==
X-Gm-Message-State: AA+aEWbG8sV5s5tDckI/tSYTBa5JIM2rV7hRwbN8Ro2Tt0JAJkbVUeHQ
        t9cusKS5u+w4/t4WW/ygD0sxsg==
X-Google-Smtp-Source: AFSGD/V1T1coNKjFRctaA92Sht7m1cTteOqByQLTFCDA96psVARk1CzBIm7BvOz/G0l4mCcFoSlIrA==
X-Received: by 2002:a2e:681a:: with SMTP id c26-v6mr12950337lja.175.1544653020098;
        Wed, 12 Dec 2018 14:17:00 -0800 (PST)
Received: from localhost (h85-30-9-151.cust.a3fiber.se. [85.30.9.151])
        by smtp.gmail.com with ESMTPSA id d19-v6sm2742ljc.37.2018.12.12.14.16.58
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 12 Dec 2018 14:16:58 -0800 (PST)
Date:   Wed, 12 Dec 2018 13:56:55 -0800
From:   Olof Johansson <olof@lixom.net>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     arm@kernel.org, Greg Ungerer <gerg@uclinux.org>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        Wolfram Sang <wsa@the-dreams.de>,
        James Hogan <jhogan@kernel.org>,
        Lee Jones <lee.jones@linaro.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/4] ARM: ks8695: fix section mismatch warning
Message-ID: <20181212215655.wwciqcwmlnq4wtwh@localhost>
References: <20181210215856.2238253-1-arnd@arndb.de>
 <20181210215856.2238253-3-arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181210215856.2238253-3-arnd@arndb.de>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 10, 2018 at 10:58:38PM +0100, Arnd Bergmann wrote:
> WARNING: vmlinux.o(.text+0x13250): Section mismatch in reference from the function acs5k_i2c_init() to the (unknown reference) .init.data:(unknown)
> The function acs5k_i2c_init() references
> the (unknown reference) __initdata (unknown).
> This is often because acs5k_i2c_init lacks a __initdata
> annotation or the annotation of (unknown) is wrong.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Applied to next/soc in arm-soc now.


-Olof
