Return-Path: <SRS0=bYeO=OJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.9 required=3.0 tests=DATE_IN_PAST_03_06,
	DKIMWL_WL_MED,DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B40C6C64EB4
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 22:56:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7752E2145D
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 22:56:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lixom-net.20150623.gappssmtp.com header.i=@lixom-net.20150623.gappssmtp.com header.b="CMP08eMG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7752E2145D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lixom.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726870AbeLAKHV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 1 Dec 2018 05:07:21 -0500
Received: from mail-lf1-f67.google.com ([209.85.167.67]:38345 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726519AbeLAKHU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Dec 2018 05:07:20 -0500
Received: by mail-lf1-f67.google.com with SMTP id p86so5257781lfg.5
        for <linux-kernel@vger.kernel.org>; Fri, 30 Nov 2018 14:56:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lixom-net.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=CRaczM14x8jN2CGA32OyRSnI3OnYrZYJ8H64Fo/XgsY=;
        b=CMP08eMG1ImxNQPqDq6Dz1EVM6Gn69gv14Orf1Cp9uUyfGOcJxwrje5SQrueUWQ40f
         SfYoPSBYk4+HG9UzDLiZiFKholiBpLJBLtG6S2HCp2jMI8a4XTpurG5XOVcinvQIkj3X
         JbefcIF5uBrLxF0rPDIGXzI67l4Eu1JXpRQgbaAH5LJ7fCVOAHPWd7DiNi6/ByCyWOe7
         02m0kKTce0hMp6Oy+bRXF8fVWZlaWuSQr/VUVnHNNe36OKDlDWVZqwvx4nWUdJMCX8lJ
         hoPltMmRGie/qv1ULtFIjJ6+dj4fdT04Mci70mdv5hkOBc92lHGpuihSXHcdlaX5PNHI
         RcGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=CRaczM14x8jN2CGA32OyRSnI3OnYrZYJ8H64Fo/XgsY=;
        b=VJkvqy35L9h+Hrc4PKavZiY2QSA8gmKQOPH38khfyy9UYVGYI4ZqDsc6QjDtCh+/R6
         I6mtGSncVBL8a3OxXxpcKMCnt1Kb+KOeRX3D2/JCwqWYV+E7IKkzJY7zPc3qc5jQylGp
         FmFVN5EGPISCFaZ1znysrr9nPYoXfvnpgSO9MoPzIhhwmmCNppmSBxi/KdtvAU9kaqW6
         XI71wpeK/+AiUiLy7Wwx9HYAHDbkw6ICu4RPDNfiy3VlxuWJ74V2JhckOKRWGjvSfq8M
         1Pu/l6+Tlqb+391xwKLSecpPgjmeQwVBlcaVPTWmkKoEAt5KedVkiZOEoypa8B9WlADz
         yXyg==
X-Gm-Message-State: AA+aEWarSFd5g4X/fJPiFduBubbReE3V0bS8TKFyV8wO7VYRsUWY55Fa
        i4ylKcA7Hupr6xzEIOstMweq7g==
X-Google-Smtp-Source: AFSGD/Xytu2S9QiwctTNlf6nYW5Fpz9uarqPX9iu2oP71QRDFwBrfFMWbIxHXuBNsUWhpOTpRJYEeQ==
X-Received: by 2002:a19:5f1e:: with SMTP id t30mr4465906lfb.76.1543618586569;
        Fri, 30 Nov 2018 14:56:26 -0800 (PST)
Received: from localhost (h85-30-9-151.cust.a3fiber.se. [85.30.9.151])
        by smtp.gmail.com with ESMTPSA id k68-v6sm1013616ljb.35.2018.11.30.14.56.24
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 30 Nov 2018 14:56:25 -0800 (PST)
Date:   Fri, 30 Nov 2018 11:49:19 -0800
From:   Olof Johansson <olof@lixom.net>
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, arm@kernel.org,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [GIT PULL] ARM: at91: fixes for 4.20
Message-ID: <20181130194919.rah6fxh6jcaiadea@localhost>
References: <20181121111623.GA10372@piout.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181121111623.GA10372@piout.net>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 21, 2018 at 12:16:23PM +0100, Alexandre Belloni wrote:
> Arnd, Olof,
> 
> A simple DT fix that is necessary to get reliable access to the NAND on
> sama5d2 based boards.
> 
> The following changes since commit 651022382c7f8da46cb4872a545ee1da6d097d2a:
> 
>   Linux 4.20-rc1 (2018-11-04 15:37:52 -0800)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/at91/linux tags/at91-4.20-fixes
> 
> for you to fetch changes up to 4ab7ca092c3c7ac8b16aa28eba723a8868f82f14:
> 
>   ARM: dts: at91: sama5d2: use the divided clock for SMC (2018-11-21 11:50:32 +0100)

Merged, thanks.


-Olof
