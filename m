Return-Path: <SRS0=v2je=OV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.9 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AD8AC67839
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 21:15:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1C3832086D
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 21:15:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lixom-net.20150623.gappssmtp.com header.i=@lixom-net.20150623.gappssmtp.com header.b="TCdIBrOo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1C3832086D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lixom.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728320AbeLLVPL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Dec 2018 16:15:11 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:35312 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727061AbeLLVPL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Dec 2018 16:15:11 -0500
Received: by mail-lj1-f196.google.com with SMTP id x85-v6so17614484ljb.2
        for <linux-kernel@vger.kernel.org>; Wed, 12 Dec 2018 13:15:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lixom-net.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=iVcaQ1GyN4FndFZq9RpBAWgDU7+sqQQkc/XiJFhjGWc=;
        b=TCdIBrOoNOWyWqm/MQcPDLChgSWRx+hK86zf9Lkb87B0NyYRyYfDWk6Twn7sS+Cgm0
         fumEW0tySyzRpC/4MucTJrkFdZhuVF6rCP1SUhCbLiY5pRzNFzRwapfhQDGpRNA88e3J
         Sbwkx67F2VXxCyBl6nA5JdVtIRFNyXEaOgecobGusk/McoEEtPFnMN9b5UOgcLdpIIoT
         4piaouzJwMcEUIXUJ4IyRida/EA0cfGyEfARQxB9xVy0q58wPvx3s9wiU1bnPX2TdfNy
         NubAn8+qRU55PtqP92C6JVl11ZQLpMU2kqO1cCJmc04ZiitW3VCwVJaIMRdcCIG1h/LF
         7U1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=iVcaQ1GyN4FndFZq9RpBAWgDU7+sqQQkc/XiJFhjGWc=;
        b=Z/Vf0IeOv3p+14khzKCrNQpB0aTRO+CvqxyUYR1aLU27v/axN4FgQvkxnIwKodariB
         tEEPFnBLJjNGghea+cB8cy8xZtWoIWtxtVHIG0E9Y5XXAbQzuamoROGXhZFbDycE7qJ1
         WD0pm463kOflr1+WbSKVb4ksymoswJp0h+aWYer5CufESyUajEuXLGppk37xxHSiV8EF
         XlXBdLLj0DYWsrUqTPxDN5itIn83H7wHk097Tv+RzHZRswSa2TBu39qDDscM4yhqMIs8
         SHFX18CncrJrWZVCqudXEStinBzOhXO+CK5Cj4l7GmyF07TjVNnl/bZY34ADY6aC4rD8
         516w==
X-Gm-Message-State: AA+aEWZ3o9wXINDZi17Feen1GoAti/BLFW0c4Tp0+DAIO/5YOITUTziI
        7eWYV0JXPe4+8Pj+2e3cGWcG0A==
X-Google-Smtp-Source: AFSGD/WHdwf3Zxj49gSBPumAn8zpIP4Hyv1Gca9XF2GYI5ebWauQAyK6MDCeCYrpOY/qGzizA36UoA==
X-Received: by 2002:a2e:3803:: with SMTP id f3-v6mr3182954lja.169.1544649309117;
        Wed, 12 Dec 2018 13:15:09 -0800 (PST)
Received: from localhost (h85-30-9-151.cust.a3fiber.se. [85.30.9.151])
        by smtp.gmail.com with ESMTPSA id x29-v6sm3464264ljb.97.2018.12.12.13.15.07
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 12 Dec 2018 13:15:07 -0800 (PST)
Date:   Wed, 12 Dec 2018 13:01:55 -0800
From:   Olof Johansson <olof@lixom.net>
To:     Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     arm-soc <arm@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [GIT PULL RESEND] ARM: dts: uniphier: UniPhier DT updates for
 v4.21/v5.0
Message-ID: <20181212210155.wgpix34vo56rwoxl@localhost>
References: <CAK7LNAROrpzx96gT4CnJ8ZkiBa3Yf38_nNqVpMQ7NyH+hK+kOg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK7LNAROrpzx96gT4CnJ8ZkiBa3Yf38_nNqVpMQ7NyH+hK+kOg@mail.gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 11, 2018 at 01:37:12AM +0900, Masahiro Yamada wrote:
> Hi Arnd, Olof,
> 
> Please pull UniPhier DT updates for the v4.21/v5.0 MW.
> 
> 
> Thanks!
> 
> 
> 
> 
> The following changes since commit 651022382c7f8da46cb4872a545ee1da6d097d2a:
> 
>   Linux 4.20-rc1 (2018-11-04 15:37:52 -0800)
> 
> are available in the git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/masahiroy/linux-uniphier.git
> tags/uniphier-dt-v4.21
> 
> for you to fetch changes up to 5fd98eb7e8ce0f7d7e4f3c138e5b46fc98389804:
> 
>   ARM: dts: uniphier: add MIO DMAC nodes (2018-12-11 01:31:17 +0900)
> 
> ----------------------------------------------------------------
> UniPhier ARM SoC DT updates for v4.21
> 
> - Add bindings for all SoCs/boards of UniPhier platform
> 
> - Move binding docs to socionext directory
> 
> - Add all CPUs in cooling maps
> 
> - Add MIO DMAC nodes

Merged, thanks!


-Olof
