Return-Path: <SRS0=S+WB=KJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CBACC67790
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 21:26:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DC98C20843
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 21:26:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="YsPYG2ud"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DC98C20843
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sifive.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731414AbeGYWkM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Jul 2018 18:40:12 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:44467 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730594AbeGYWkM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jul 2018 18:40:12 -0400
Received: by mail-pg1-f193.google.com with SMTP id r1-v6so6108060pgp.11
        for <linux-kernel@vger.kernel.org>; Wed, 25 Jul 2018 14:26:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=08iLNokAyjC2I2z1h9DcFHTtSS1TtAzf6pbSsoMioBM=;
        b=YsPYG2udCQpbqMjzznUpGnAOwqA/grPpYheB0wXoOtbEtqMr6pZ9DYUwcnuOgM9Wja
         o2ABO30MrHU/VPTSab8AWWdl6gnO0/gLIL3K9L4lviOnU2wC3yVC7U51imBZhGA6zyt7
         YczrY9NhvNGgnHzxKoimUJiP9IXVfePuyTudtnegXPuFCX56NXu4T5caypSz/VCBPepr
         YiJ80+Z7GRbWQA1trxQ+F0+X1DMRW9L6UkFSDHn7aMXZujLGXbuBUivQlb8yaOUNDqTS
         AMDMGnKvDvbxCnwobgNcTn05W3oyFOYd3B3wh6Qa64YaaozMOVwcu8Z7parkIvDuqtsn
         r+9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=08iLNokAyjC2I2z1h9DcFHTtSS1TtAzf6pbSsoMioBM=;
        b=GtIlvRmpConrKpid7E+A+3UFh356lXuGmgiWzQ2qaW2NxxCRBddxiLVEvhCG379y7+
         l1KzY9PeldHwJHtF7y/+n+T7V/1vDdQzAU9iEysuhiLKge4ukWeJ8KbiT6oL0E67k3hL
         oOYBJq522kY2ruacdWSboFqNfwUPXModd65tWTGqm07tY0oes+z22Q/qnJ8N9fHXo/TK
         7+n/jKL0ygaymbkrLf52el5ubV+o9WEQPzZkelwDkNtmbbaXiiaUgaHaS3dtvFdO5P02
         gZkUayczTtkQI4guVaCzMIcQ8LZmA9gbImVfFrCcBbQvqCWz8Nk29S2B1b9Bd0pffMoo
         gLoQ==
X-Gm-Message-State: AOUpUlEzVI2Ea3a25uDIA+LL/2vFsgYxgx355Ar/sBP4ek7g4KHWlYNr
        WoFW6hEhrhMNHZ2vP4+GvPBX5w==
X-Google-Smtp-Source: AAOMgpf785dIkLz51LI+N49QGsY/H53uwuOMHwJwLPTeEvE4doV/L767t78x1PC1alcvEJyHHJ/WaQ==
X-Received: by 2002:a63:7d48:: with SMTP id m8-v6mr22365548pgn.0.1532553999664;
        Wed, 25 Jul 2018 14:26:39 -0700 (PDT)
Received: from localhost (96-90-200-139-static.hfc.comcastbusiness.net. [96.90.200.139])
        by smtp.gmail.com with ESMTPSA id f6-v6sm24000226pgf.52.2018.07.25.14.26.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 25 Jul 2018 14:26:38 -0700 (PDT)
Date:   Wed, 25 Jul 2018 14:26:38 -0700 (PDT)
X-Google-Original-Date: Wed, 25 Jul 2018 14:25:55 PDT (-0700)
Subject:     Re: RISC-V irqchip drivers
In-Reply-To: <20180725093649.32332-1-hch@lst.de>
CC:     tglx@linutronix.de, jason@lakedaemon.net, marc.zyngier@arm.com,
        robh+dt@kernel.org, mark.rutland@arm.com,
        devicetree@vger.kernel.org, aou@eecs.berkeley.edu,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        shorne@gmail.com
From:   Palmer Dabbelt <palmer@sifive.com>
To:     Christoph Hellwig <hch@lst.de>
Message-ID: <mhng-670ecc27-6fdd-491b-8db4-4ce8f93bfb94@palmer-si-x1c4>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 25 Jul 2018 02:36:43 PDT (-0700), Christoph Hellwig wrote:
> The RISC-V ISA mandantes the presence of a simple, per-hart (hardware
> thread) interrupt controller availiable to supervisor mode.  In addition
> the RISC-V specification contains the definition of a programmable
> interrupt controller that is present on all current RISC-V cores (at
> least as far as a I know).
>
> This series adds both of them.  For the per-hart controller this series
> tries to address all comments vs the last posting from Palmr in June,
> and for the PLIC it has a lot of cleanups which I think should address
> all outstanding comments, but it has been a while since it was last
> posted.
>
> Without these irqchip drivers the RISC-V port in mainline is rather
> useless as it can't boot on any SOC or emulator.  With it it still is
> almost as useless as a clocksource driver is still missing, but at least
> we're only a patch or two away from a booting system, and the
> clocksource  driver will need the per-hart interrupt driver to work as
> well.
>
> Palmer: I assume you are ok with me pushing this forward.  If not I'll
> happily drop this series.

Thanks for taking this over, and sorry I've dropped the ball a bit here -- 
there's just a bit too much to do!

> A git tree with the patches in this series, the missing clocksource
> driver a few pending patches to allow booting a RISC-V kernel in qemu
> is available here:
>
>     git://git.infradead.org/users/hch/riscv.git riscv-linux-4.18
>
> Gitweb:
>
>     http://git.infradead.org/users/hch/riscv.git/shortlog/refs/heads/riscv-linux-4.18
