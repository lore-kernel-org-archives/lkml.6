Return-Path: <SRS0=q0iV=PB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2322C64E75
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Dec 2018 23:07:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 96F6121773
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Dec 2018 23:07:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545692837;
	bh=VgAUzhUhKocKnDYDcZrhPslFcuQyRqm3tZGejWGxxsQ=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=Q9sVKkomlxwp0W37Ey6rDc+StehqYpZbPQPQKanbNEN/i429ZfaDfjklN1BmYpCwi
	 T/AY3IuyUDHuhQuWNPHiWxG0AzK2+HwELuLi68dr37XoTQI5T9CXTTgOHxlkihiVEO
	 R74QHYCzgc/HfUzHnpSEvOORc9fKYqgkIQ15E1SY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725837AbeLXXHQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Dec 2018 18:07:16 -0500
Received: from mail-wr1-f44.google.com ([209.85.221.44]:34079 "EHLO
        mail-wr1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725788AbeLXXHP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Dec 2018 18:07:15 -0500
Received: by mail-wr1-f44.google.com with SMTP id j2so12662984wrw.1
        for <linux-kernel@vger.kernel.org>; Mon, 24 Dec 2018 15:07:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=Sx8tvxZGkL+OMdDrVGRzDeuGizPnuEhSiB4mkU+8Io4=;
        b=Bg4dI2xx+SRLpRi7mnFiLfyDL6Fg6P8S0S4eF62ZXQS6dPFFXeunIy8Mc0mW7tRTcP
         PXFfV1ADntwOl2i3HsQPVRlz7GkYw5/AxAJZ7wGzTMhAzpUQSEPnk6h9WoD0QZCujZYM
         yXf1YWr2a7ShwhzdYcEupXegRsrVOnJXPqD9q7Ls1mvD8CoJjbahPhA0lYa7wJ08xqk4
         GqWmOySYZ/z/BtQj/xsQQgaPYTCXzN03ZHhOt36Jhm07zThK10pyNM+1GhfidftknnwY
         EckGMEtplr07mvDBsJ3q1FGa5wqCgDcIWLN+s8A7E7txc1lvKo7VfBiDzozTThgkfot0
         bBLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mime-version:content-disposition:user-agent;
        bh=Sx8tvxZGkL+OMdDrVGRzDeuGizPnuEhSiB4mkU+8Io4=;
        b=K8P/X3aTukpzCbDGwugSkkjUacZmcGc3BqKgeSFfdoyNKIczlX5Kjcjvhh+T+YQBPa
         DA2AdxAA0EkMyoV0gD2BcMW5OvR+UmkSgDTYiZ4nDkkQnvQXH6K6UjwdVna7iFihiC2K
         l0r7He5SbAYA5OnybIXb9M/pgIDzQttGhnsfQX2Gw2MqxEc9bQUQCLLbPmfoVeY4GGEf
         wcJhOJalPrZUlXF8Y1Pr//g6sBm+iTlEPC2aDOb9ibHh4rGPPms1LMpevtOxGfc08syH
         o8PynX2OPfaz798D3wnbaQaJApFZXqAZ0D03EFOEO25Qk1oN/L46JB1rVq1ttCwUIJ7S
         UYrA==
X-Gm-Message-State: AJcUukdOeVhYoPYK2KE0WsGG6N/Ub+h+Ra5Bxyxg3qSJxgQ+5Ar6xwvm
        CDJ9b1FCDBmbG4nK+uzJ86eb0psl
X-Google-Smtp-Source: ALg8bN5dKLDKPpZliyeyldhAcU21aF54nyGNDJx4YSJ7qyUfLMU9pkdtYvDlnflZNvQQmxqKz0GPPA==
X-Received: by 2002:a5d:4303:: with SMTP id h3mr13461391wrq.273.1545692833199;
        Mon, 24 Dec 2018 15:07:13 -0800 (PST)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id m4sm24129797wmi.3.2018.12.24.15.07.12
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 24 Dec 2018 15:07:12 -0800 (PST)
Date:   Tue, 25 Dec 2018 00:07:10 +0100
From:   Ingo Molnar <mingo@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [GIT PULL] x86/fpu changes for v4.21
Message-ID: <20181224230710.GA125684@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

Please pull the latest x86-fpu-for-linus git tree from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-fpu-for-linus

   # HEAD: 12209993e98c5fa1855c467f22a24e3d5b8be205 x86/fpu: Don't export __kernel_fpu_{begin,end}()

Misc preparatory changes for an upcoming FPU optimization that will delay 
the loading of FPU registers to return-to-userspace.

 Thanks,

	Ingo

------------------>
Sebastian Andrzej Siewior (7):
      x86/fpu: Use unsigned long long shift in xfeature_uncompacted_offset()
      x86/process/32: Remove asm/math_emu.h include
      x86/thread_info: Remove _TIF_ALLWORK_MASK
      x86/pkeys: Make init_pkru_value static
      x86/fpu: Add might_fault() to user_insn()
      x86/fpu: Update comment for __raw_xsave_addr()
      x86/fpu: Don't export __kernel_fpu_{begin,end}()


 arch/x86/include/asm/efi.h          |  6 ++----
 arch/x86/include/asm/fpu/api.h      | 15 +++++----------
 arch/x86/include/asm/fpu/internal.h |  3 +++
 arch/x86/include/asm/thread_info.h  |  8 --------
 arch/x86/kernel/fpu/core.c          |  6 ++----
 arch/x86/kernel/fpu/xstate.c        |  4 +---
 arch/x86/kernel/process_32.c        |  3 ---
 arch/x86/mm/pkeys.c                 |  1 +
 8 files changed, 14 insertions(+), 32 deletions(-)
