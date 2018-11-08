Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS,URIBL_BLOCKED,URIBL_SBL,URIBL_SBL_A autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF238C43441
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 22:24:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8379E20818
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 22:24:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Qt28jviC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8379E20818
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730469AbeKIIBu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Nov 2018 03:01:50 -0500
Received: from mail-ed1-f65.google.com ([209.85.208.65]:37302 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727229AbeKIIBu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Nov 2018 03:01:50 -0500
Received: by mail-ed1-f65.google.com with SMTP id y10-v6so229956edr.4
        for <linux-kernel@vger.kernel.org>; Thu, 08 Nov 2018 14:24:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=CPFX4uVCKXMP3814gZIQemoLaJE5n/O3zYhVzKP9RT4=;
        b=Qt28jviCXJO2bQJXP6NQbOo7Ug/1KtCCllivWhfLqi+Jt26bABDOZmncUq0Q1t9lnk
         USBaTXOnFvrnqjfqFKwik2S2X0OejYB9xClmLjXW4rpoMMah0+jqUuZfccyxC/jJU2oU
         o8Iy7dUkQDiAg8jneqFGPVLP6GvNt4On3gMaVcQ3LmwAMoGwkLR1cEfbM7wWmODkvV2T
         sNr8P9Lu8H2N5LIeSrU0LDrGSn2n4tLfle8wbGHLhIOKlY6n9xgTHZTay9d6x2NRoVpX
         BVcinlxKbLfD8sFJFIQ8GltfRwJVuciun9CM3P/NJszbno3MZ04PI8sZozojk1Ua+WId
         XpwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=CPFX4uVCKXMP3814gZIQemoLaJE5n/O3zYhVzKP9RT4=;
        b=ixUqS2c4ymt+OMEhKQOYzMgXYuzP3DSCra0VXK09mL39dtq17XvAgcScdnmzZy5KXS
         r3wEHrydl2hqNoGkxV7xabgCgOdViO7dFWGvE+J23pou7ngajRPrsnNOe/RMYG1RfS9o
         o2vvpobKwZxtadFk0FQioggCKkyf77W+TnMloReF1CJ/AvuUI2YnYLXmtSSOUUr50IAK
         ZFxm6E/UGXhP/6gVGRcGVq4EXZw+ps8ULeFvwD8gd8ACBr2XpQYKJGfS4HWCFk8jl2o8
         GVsKb9m8MS5ZNXzIV3Ax0wZaPNrnKGYJ/a8b1/1eDPk2b8dRZuMH7waQgVVXEehBdXXO
         w72Q==
X-Gm-Message-State: AGRZ1gKIDkd+h2o4pagCwLn4lH0CU4WforFmNU8HB0xRlq+36yMgqwnC
        J6iqjhb9rQzfxDCTYHVhLQ3bbe5cSRFleLpjllzT5+WC
X-Google-Smtp-Source: AJdET5c0JEAXr0Nw/eaB909loOyU+y2JQtrnLWX2d4NpMktN3sHTlR4pgDG/dXfjrCPsyLdzeU+HYQu2ggxs7iDAp/4=
X-Received: by 2002:a50:a1c7:: with SMTP id 65-v6mr27613edk.190.1541715852312;
 Thu, 08 Nov 2018 14:24:12 -0800 (PST)
MIME-Version: 1.0
From:   Rian Quinn <rianquinn@gmail.com>
Date:   Thu, 8 Nov 2018 15:23:59 -0700
Message-ID: <CANmpu8XY10CgYsnGn9hVDzGJQyWdwNihpYu3So62KtNwrkwGXw@mail.gmail.com>
Subject: x86_64 INIT/SIPI Bug
To:     linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I apologize upfront if this is the wrong place to post this, pretty new to this.

We are working on the Bareflank Hypervisor (www.bareflank.org), and we
are passing through the INIT/SIPI process (similar to how a VMX
rootkit from EFI might boot the OS) and we noticed that on Arch Linux,
the INIT/SIPI process stalls, something we are not seeing on Ubuntu.

Turns out, to fix the issue, we had to turn on cpu_init_udelay=10000.
The problem is, once a hypervisor is turned on, even one that is doing
nothing but passing through the instructions, the "quick" that is
detailed below fails as the kernel is not giving the CPU enough time
to perform a VMExit/VMEntry (even through the VMExit is not doing
anything).
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/arch/x86/kernel/smpboot.c?h=v4.20-rc1#n650

You can see our INIT/SIPI code here if you are interested:
https://github.com/rianquinn/extended_apis/blob/hyperkernel_1/bfvmm/src/hve/arch/intel_x64/vmexit/init_signal.cpp

The reason I suggest this is a bug is the manual clearly states that a
wait is required and the "quirk" that turns off this delay prevents
code like this from working. Would it be possible to either:
- Turn this off by default, but still allow someone to turn it on if
they are confident the delay is not needed?
- Provide a generic way to turn this off (maybe if a hypervisor is
detected, it defaults to off)?

I'd be more than happy to provide a patch and test, but I'm not sure
if there is any interest in changing this code.

Thanks,
- Rian Quinn
