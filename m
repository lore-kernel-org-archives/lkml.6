Return-Path: <SRS0=ZAeg=KF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E5B0ECDE5F
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Jul 2018 22:24:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 49AAC2086D
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Jul 2018 22:24:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lixom-net.20150623.gappssmtp.com header.i=@lixom-net.20150623.gappssmtp.com header.b="Z8zNbUZL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 49AAC2086D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lixom.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728249AbeGUXSw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 21 Jul 2018 19:18:52 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:45925 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727974AbeGUXSw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Jul 2018 19:18:52 -0400
Received: by mail-lj1-f196.google.com with SMTP id q5-v6so13873665ljh.12
        for <linux-kernel@vger.kernel.org>; Sat, 21 Jul 2018 15:24:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lixom-net.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Sg686cu/VbUtwekljH0OQgf2EVa1rx8yuCWlMKLsFIY=;
        b=Z8zNbUZLG8Yag0/FrRfsHh1OgqXNkRAFkbmkmbkWnuNvrvR1R4Zgqm41CWo6CSUuYA
         H1W6/Uia16Lk415/J8kd9VHMPCbUXHK/BbHxznL/7t/P7yE3TQsUAmzOgDur4n0AmCH2
         aW+qP5J1owclmb4zz4oJwS/qxNJiBUftvMA/eaa0ujgYhrxGXa8g+a3ZcHerkrtnonlK
         ngyRgJeNRW6p2o+KUJ+puQMHdRPHd5abE8Qafyl8conCNPYus66AvqzJLZleKuRoPwri
         I721pn/7xN7KF6a28lK8IR/wC2lusuh3MLnJnR0N6HSpBhg5vCUnH4DUUuGkiCVFGNLb
         IUzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Sg686cu/VbUtwekljH0OQgf2EVa1rx8yuCWlMKLsFIY=;
        b=OStUxpdM1i0PYy32fl7A8onJsu4yieicscLCEnXWIfoh1MCobnPVwdHsn6nhErjm7a
         N9XKllbpbAeW1s1G5Y8gCosUff7E1nrMGO4jw1dseyjUPnd32Nbjfxe99Y89oDM0TzfY
         87hPMu5Uo7g48FsprQQyJZUvvF7ch52WJ+OgU7PC5lBrZidqCQ6eh6pK2ir16cyhyRJp
         d0Yhafz3qlNJf/MeFizNzXJsbh2rzbK+w+o83/+XIhIqTXbb0j1xemdUO6GDv+59mNt5
         1volQDk+FDIN9fC2J0NEkMYAmznmizTGR6+pDI0pO6m9ceKzkM4OFpEDZ3hbtDRsso19
         EORg==
X-Gm-Message-State: AOUpUlE2cf7ClKYMFlcIvaoGUjT6iCLwxOXaoMGLL5DeFZnvMg1HSTzx
        cRb+HfEz4250Z4gEwRV0aARvrA==
X-Google-Smtp-Source: AAOMgpfWaCwDCudWMFbHymaiCVhCvgq42rMfTseq0XkqLNfZ1cvqMUdnIRPuk73CRzxFWgHRvwgvmA==
X-Received: by 2002:a2e:7113:: with SMTP id m19-v6mr4841758ljc.66.1532211871986;
        Sat, 21 Jul 2018 15:24:31 -0700 (PDT)
Received: from localhost (h85-30-9-151.cust.se.alltele.net. [85.30.9.151])
        by smtp.gmail.com with ESMTPSA id u8-v6sm1051545ljh.52.2018.07.21.15.24.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 21 Jul 2018 15:24:30 -0700 (PDT)
Date:   Sat, 21 Jul 2018 14:18:58 -0700
From:   Olof Johansson <olof@lixom.net>
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, arm@kernel.org,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [GIT PULL] ARM: at91: SoC for 4.19
Message-ID: <20180721211858.u6xc7d6ftjrglev6@localhost>
References: <20180720082030.GA22561@piout.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180720082030.GA22561@piout.net>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 20, 2018 at 10:20:30AM +0200, Alexandre Belloni wrote:
> Arnd, Olof,
> 
> Here is the SoC PR for 4.19. It is a cleanup of pm.c and the addition of
> a new low power mode.
> 
> The following changes since commit ce397d215ccd07b8ae3f71db689aedb85d56ab40:
> 
>   Linux 4.18-rc1 (2018-06-17 08:04:49 +0900)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/abelloni/linux.git tags/at91-ab-4.19-soc
> 
> for you to fetch changes up to d7484f5c6b3b0565d2395aece2862f183581e1c1:
> 
>   ARM: at91: pm: configure wakeup sources for ULP1 mode (2018-07-17 15:08:12 +0200)

Merged, thanks!


-Olof
