Return-Path: <SRS0=ZAeg=KF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B52F3ECDFBB
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Jul 2018 22:25:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6AEF320856
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Jul 2018 22:25:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lixom-net.20150623.gappssmtp.com header.i=@lixom-net.20150623.gappssmtp.com header.b="GSlm75Zp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6AEF320856
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lixom.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728700AbeGUXTS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 21 Jul 2018 19:19:18 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:43685 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727974AbeGUXTS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Jul 2018 19:19:18 -0400
Received: by mail-lj1-f194.google.com with SMTP id r13-v6so13893844ljg.10
        for <linux-kernel@vger.kernel.org>; Sat, 21 Jul 2018 15:24:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lixom-net.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=cYxHII7R3yxWW3w02fJCPzUgmgV2ocgt+f/58szJcKU=;
        b=GSlm75ZpLfhySDYw6vda9UaN6wJ5b8dQqwD3eX0QAKSDYyPXQ11ItyZH4c5S09QJsh
         r35uobJdr2UfQijvB8sdpaae66x8qL9Pnd+8BIEzSGieuP66Sey4zkUN2ewPX0CfX5d0
         WQ5h2qeVHrow7BKvWaRpzqYR8UzMTbr2IEFWMQTkFjbGDgE0KpmU7wtjFf4S2j5a8UGW
         cr0b/73Zaecia8riBBajHKN2Vzx/yDet26ApNZZKE7y/fDwFxGLik56FxozwSEhQM+kN
         vLZhS0oIXhA6cw0B7XCSMrg4OQWIBbJBDhYd7QPsqVltWWge9HULQkWz1agkzJYWe1Tr
         IxZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=cYxHII7R3yxWW3w02fJCPzUgmgV2ocgt+f/58szJcKU=;
        b=CrYHr3C4sm7B5Gc4fppN6LDfj4RdmUqP2Wt4+tDhrlR3i6WRWMV7ToNrA6a8TewLcs
         mW+Rwn4IvlIjW84BsWMOt4nB1xgi12FMF8Y5dX8QZprEdOn7pJFEEdBfHbRi1BObds5k
         z99P9Qf/6RLS5nUJvKetPFjzxj2kPrF650vobEJ3LWz/CtQ8sN9P0+3c9XfsfPKReYM9
         mQ4O+FV3a2eQvxxIK9Rz60wcs+KXZxSoqwoenSVclZ5vAW/EGpxhnB4Ww+IY/jCG9ciS
         QQEmrZ0mVGQmzM1UIIDac0WGT/EAtilOdBuk/v6mF/DC5DFvA+KoDlVAQ81FBoBlndvg
         +Yyg==
X-Gm-Message-State: AOUpUlGnOvMkQx+oikhQG4zbkiaWuPMiqaWOm4pRiM7WNaNPory8VmXI
        bCxCIC2HVRa8pr1SI9kYb3S8Dg==
X-Google-Smtp-Source: AAOMgpcYOMsejVNRNsEZT3BZVwQi2IcWGZvZI6dQZwKFUFJ7Z1e+CdKco5Zd0gGi/xNl+46KNt5tlg==
X-Received: by 2002:a2e:1781:: with SMTP id 1-v6mr4929589ljx.76.1532211898399;
        Sat, 21 Jul 2018 15:24:58 -0700 (PDT)
Received: from localhost (h85-30-9-151.cust.se.alltele.net. [85.30.9.151])
        by smtp.gmail.com with ESMTPSA id k5-v6sm1038810ljk.69.2018.07.21.15.24.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 21 Jul 2018 15:24:56 -0700 (PDT)
Date:   Sat, 21 Jul 2018 14:31:30 -0700
From:   Olof Johansson <olof@lixom.net>
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, arm@kernel.org,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [GIT PULL] ARM: at91: DT for 4.19
Message-ID: <20180721213130.ec3wmahq5wgyx34v@localhost>
References: <20180720081859.GA22228@piout.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180720081859.GA22228@piout.net>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 20, 2018 at 10:18:59AM +0200, Alexandre Belloni wrote:
> Arnd, Olof,
> 
> Here are the unusually large DT PR for AT91. It contains mainly new DTs.
> 
> There is a pm.c change that I'm including here so it is along with the
> corresponding DT changes.
> 
> The following changes since commit ce397d215ccd07b8ae3f71db689aedb85d56ab40:
> 
>   Linux 4.18-rc1 (2018-06-17 08:04:49 +0900)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/abelloni/linux.git tags/at91-ab-4.19-dt
> 
> for you to fetch changes up to c8cbc1c20c29697e7335a5044fe6c60aa5c6e922:
> 
>   ARM: dts: at91: fix typos for SSC TD functions (2018-07-20 10:05:14 +0200)
> 
> ----------------------------------------------------------------
> AT91 DT for 4.19:
> 
>  - New boards from Laird: WB45N, WB50N, SOM60 modules and DVK, Gatwick
>  - fix the PMC compatibles
> 
> ----------------------------------------------------------------
> Alexandre Belloni (4):
>       dt-bindings: arm: remove PMC bindings
>       dt-bindings: clk: at91: Document all the PMC compatibles
>       ARM: at91: fix USB clock detection handling

I guess this patch should have gone in a soc branch?

Anyway, merged as-is, unlikely to cause conflicts.


-Olof
