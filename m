Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id iyySEM50HluJEwAAmS7hNA
	; Mon, 11 Jun 2018 13:10:38 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 28F60607BB; Mon, 11 Jun 2018 13:10:38 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MDQ3r1t+"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FROM,MAILING_LIST_MULTI
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 68B54601C3;
	Mon, 11 Jun 2018 13:10:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 68B54601C3
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933116AbeFKNKf (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 20 others); Mon, 11 Jun 2018 09:10:35 -0400
Received: from mail-wr0-f194.google.com ([209.85.128.194]:41471 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932516AbeFKNKd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jun 2018 09:10:33 -0400
Received: by mail-wr0-f194.google.com with SMTP id h10-v6so20339519wrq.8;
        Mon, 11 Jun 2018 06:10:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=zDKzscYWoVp6LPOwxIkF2BGslwWmlicISZc3gF/Zp3M=;
        b=MDQ3r1t+n+FWa749G3gQNQXtZAMIvPkKMMJy6749jNl4pl8y5j2UFGwFiN6aD0lqVb
         FTKZNibjX9CQR6O7o11AGunG77bjZRnZMeOA49mnj07BUPqeeQRS+PtE3ZXMY+GJFPRO
         SPi8mSNE0CvBOJSJDB0i3q48SbXwmw2gFPEyvBSJXGtquRRnGYBG9qYTjkA/rWvcxvZW
         i5SStnrVrSuAEmSytSbwcxDgQNHXm7GO+8LqXtrfs/7hApH/Lu11t4kvfAxBD9nlSklR
         6xXVIIpgrO/AuUOPQ1Oi3CJL8D1WKZdpWA+uqf6xvkpA0c/HiyJvsbNwbskQOC44QKdI
         FUCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=zDKzscYWoVp6LPOwxIkF2BGslwWmlicISZc3gF/Zp3M=;
        b=oZRWwQ/MLeglENEx/brYAe6OcHztKRPzyVk3jGGhA9v8lCW97KmNzqeLn+in5QznhT
         3mk7MvcdD6d50Mbx/Vug2LLOoKhS23RYFAsyk9hoYe1Jvy6Cho1hgtIpYw6NV9h+DpSa
         A7I4o+HupCB5Zaz9OH88r+BesHE+RUwXreLTdFiMozxjmYUQPz27mN8QpfSrJShOFLEv
         TUYcYPWx4wdpCRbHedWXWipWKfgCeiSMuqlev2TKuaHAVldjD/paLPPl3VdArc7ASbFX
         1sRqcFdkLgL7aeLPsbd7FSH+m71mPOO+xWEpXiJGIjF/mlIx8QPBXXfQbSE3+9iZrHgs
         VMrw==
X-Gm-Message-State: APt69E2tEY5KrPE6fg/VQgrae7twSHLZL7tmJOm+6kKnoh1/aGz7H27a
        gD3dnIXymkgDASEP1OUBUkQ=
X-Google-Smtp-Source: ADUXVKIuh8IS4SgkDZ0UoCa1lJgH06G80hZJBTleCi6yaQ9v/iH6hQUfuFBgcYSCMoEitLp7mMAXCw==
X-Received: by 2002:adf:a148:: with SMTP id r8-v6mr12427053wrr.104.1528722631594;
        Mon, 11 Jun 2018 06:10:31 -0700 (PDT)
Received: from dimapc.localnet (109-252-55-168.nat.spd-mgts.ru. [109.252.55.168])
        by smtp.gmail.com with ESMTPSA id o16-v6sm40286138wrp.8.2018.06.11.06.10.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 11 Jun 2018 06:10:30 -0700 (PDT)
From: Dmitry Osipenko <digetx@gmail.com>
To: Boris Brezillon <boris.brezillon@bootlin.com>
Cc: Stefan Agner <stefan@agner.ch>, dwmw2@infradead.org,
        computersforpeace@gmail.com, marek.vasut@gmail.com,
        robh+dt@kernel.org, mark.rutland@arm.com, thierry.reding@gmail.com,
        dev@lynxeye.de, miquel.raynal@bootlin.com, richard@nod.at,
        marcel@ziswiler.com, krzk@kernel.org, benjamin.lindqvist@endian.se,
        jonathanh@nvidia.com, pdeschrijver@nvidia.com, pgaikwad@nvidia.com,
        mirza.krak@gmail.com, linux-mtd@lists.infradead.org,
        linux-tegra@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 4/6] mtd: rawnand: add NVIDIA Tegra NAND Flash controller driver
Date: Mon, 11 Jun 2018 16:10:21 +0300
Message-ID: <6764263.x6FQro3A0J@dimapc>
In-Reply-To: <20180611135013.7bb5b59b@bbrezillon>
References: <20180531221637.6017-1-stefan@agner.ch> <1862022.905gDpZtpO@dimapc> <20180611135013.7bb5b59b@bbrezillon>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday, 11 June 2018 14:50:13 MSK Boris Brezillon wrote:
> On Mon, 11 Jun 2018 14:45:45 +0300
> 
> Dmitry Osipenko <digetx@gmail.com> wrote:
> > On Sunday, 10 June 2018 18:32:02 MSK Boris Brezillon wrote:
> > > On Sun, 10 Jun 2018 18:00:06 +0300
> > > 
> > > Dmitry Osipenko <digetx@gmail.com> wrote:
> > > > > >> That seems a lot of work for a code path I do not intend to ever
> > > > > >> use
> > > > > >> 
> > > > > >> :-)
> > > > > > 
> > > > > > Are you sure that resetting HW resets the timing and other
> > > > > > registers
> > > > > > configuration? Reset implementation is HW-specific, like for
> > > > > > example
> > > > > > in a
> > > > > > case of a video decoder the registers state is re-intialized on HW
> > > > > > reset,
> > > > > > but registers configuration is untouched in a case of resetting
> > > > > > GPU.
> > > > > > I'd
> > > > > > suggest to check whether NAND controller resetting affects the HW
> > > > > > configuration.
> > > > > 
> > > > > It seems all registers are set back to their documented reset value:
> > > > > 
> > > > > [boot loader/ROM initialized values]
> > > > > [    1.270253] tegra-nand 70008000.nand: Tegra NAND controller
> > > > > register
> > > > > dump
> > > > > [    1.277051] tegra-nand 70008000.nand: COMMAND: 0x66880104
> > > > > [    1.282457] tegra-nand 70008000.nand: STATUS: 0x00000101
> > > > > [    1.287763] tegra-nand 70008000.nand: ISR: 0x01000120
> > > > > [    1.292818] tegra-nand 70008000.nand: IER: 0x00000000
> > > > > [    1.297863] tegra-nand 70008000.nand: CONFIG: 0x00840000
> > > > > [    1.303181] tegra-nand 70008000.nand: TIMING: 0x05040000
> > > > > [    1.308486] tegra-nand 70008000.nand: TIMING2: 0x00000003
> > > > > [    1.313897] tegra-nand 70008000.nand: CMD_REG1: 0x00000000
> > > > > [    1.319377] tegra-nand 70008000.nand: CMD_REG2: 0x00000030
> > > > > [    1.324868] tegra-nand 70008000.nand: ADDR_REG1: 0x03000000
> > > > > [    1.330435] tegra-nand 70008000.nand: ADDR_REG2: 0x00000000
> > > > > [    1.336011] tegra-nand 70008000.nand: DMA_MST_CTRL: 0x04100004
> > > > > [    1.341838] tegra-nand 70008000.nand: DMA_CFG_A: 0x00000fff
> > > > > [    1.347415] tegra-nand 70008000.nand: DMA_CFG_B: 0x0000001b
> > > > > [    1.352991] tegra-nand 70008000.nand: FIFO_CTRL: 0x0000aa00
> > > > > [reset]
> > > > > [    1.358559] tegra-nand 70008000.nand: Tegra NAND controller
> > > > > register
> > > > > dump
> > > > > [    1.365352] tegra-nand 70008000.nand: COMMAND: 0x00800004
> > > > > [    1.370744] tegra-nand 70008000.nand: STATUS: 0x00000101
> > > > > [    1.376060] tegra-nand 70008000.nand: ISR: 0x00000100
> > > > > [    1.381105] tegra-nand 70008000.nand: IER: 0x00000000
> > > > > [    1.386161] tegra-nand 70008000.nand: CONFIG: 0x10030000
> > > > > [    1.391466] tegra-nand 70008000.nand: TIMING: 0x00000000
> > > > > [    1.396782] tegra-nand 70008000.nand: TIMING2: 0x00000000
> > > > > [    1.402174] tegra-nand 70008000.nand: CMD_REG1: 0x00000000
> > > > > [    1.407664] tegra-nand 70008000.nand: CMD_REG2: 0x00000000
> > > > > [    1.413156] tegra-nand 70008000.nand: ADDR_REG1: 0x00000000
> > > > > [    1.418722] tegra-nand 70008000.nand: ADDR_REG2: 0x00000000
> > > > > [    1.424297] tegra-nand 70008000.nand: DMA_MST_CTRL: 0x24000000
> > > > > [    1.430123] tegra-nand 70008000.nand: DMA_CFG_A: 0x00000000
> > > > > [    1.435698] tegra-nand 70008000.nand: DMA_CFG_B: 0x00000000
> > > > > [    1.441264] tegra-nand 70008000.nand: FIFO_CTRL: 0x0000aa00
> > > > 
> > > > Alright, then indeed it's not really worth to bother with HW resetting
> > > > here. Probably only a kernel module reload or a reboot will help if HW
> > > > is
> > > > hung. Maybe NAND controller / chip recovering is something that NAND
> > > > core
> > > > should be handling in a such case by providing a
> > > > nand_controller_reset()
> > > > hook?
> > > 
> > > I don't see what the core could do to help with that. We'd end up with
> > > a new hook implemented by the controller that would be called by the
> > > controller driver when it knows it's safe to reset the controller. So,
> > > why bother exposing that in the core?
> > 
> > Giving a driver more flexibility is always a good thing. I'm not really
> > familiar with mtd/ and maybe indeed it doesn't make much sense to move HW
> > resetting to NAND core, though it looked to me that it should be always
> > safe for NAND core to initiate HW resetting after IO failure and hence
> > would be cleaner and nicer to have a unified HW reset management rather
> > than to have each driver to do its own thing.
> 
> No really, the NAND core can't know when it's appropriate to reset the
> controller, and what this reset will do, hence it doesn't know if the
> chips connected to the controller should also be reset.

Okay!
