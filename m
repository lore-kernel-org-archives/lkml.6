Return-Path: <SRS0=q0iV=PB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3AB0C64E75
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Dec 2018 22:53:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B8DD2217D6
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Dec 2018 22:53:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545692033;
	bh=wfc3ByuCBLbD0XTyI1eONBqsQoSNGWrF68wTw73U3Nc=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=xzpHjeNsZlxVDKOzKi4zJ/o5LSbbg/VomiipyVkmiPNrYT4fd4scInXkqFEIDpsuu
	 shdQBZ2/LJiLBIkfFsBqAIiGLBYIJ/CaMAE7u2Bir1Euy+uzN9gQwul1G7F++HBr2x
	 mYqBV0EPbPZwqbORT+dAZsf4oPPnt6FpydHgnIC8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725831AbeLXWxw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Dec 2018 17:53:52 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:35650 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725788AbeLXWxw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Dec 2018 17:53:52 -0500
Received: by mail-wm1-f66.google.com with SMTP id t200so645097wmt.0
        for <linux-kernel@vger.kernel.org>; Mon, 24 Dec 2018 14:53:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=AtdMDBqk5CWCZXjHRiWcfLyKwV2Af5kE/a8G+XsvmLY=;
        b=KP/c7BAjFJjz+KrwVQGp3WDbr04vARGY0u8AOcbpblkdHgUkWQGPAVwszT6DDqMfhB
         XMMEwemE0creNix4PuA/7TTSPq+MtYculRdig8wOhuRyd2yV83TlEJ8hSr3cPxiTVKNz
         ct6eyt/5DvWoQOP8eK4j1WFlQa4antjrPSC1qb2SlKyK3YSIgl1uUY3FC44mPigvLMZy
         sQp+fHieOaAd3xhPBqvnI3UmHhM5fC8NjAHAlH2T3K99V1K3E616R5AQB4PHWEyolVse
         W+cgkyBUzSImu4E5FT07JWEIPQ6L8A3Ja+jw6Gely15/OONhlfUODu8NLWTEvkGOVbrm
         IGog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mime-version:content-disposition:user-agent;
        bh=AtdMDBqk5CWCZXjHRiWcfLyKwV2Af5kE/a8G+XsvmLY=;
        b=tfpQ2fzfvDfQWqiqF+5cUcdhby32CYiqlltKPC+sExCpbqj+TWAIfA1h4B93suzw/e
         aO+L4RjY0xKAfERYORz6NGbqxDwlynAqpwQlGniyr65n4jshQ/YORq3FOurNrJKI3Vhb
         mHGjg1dnRrky1AE8EVeq8Rrm8VoiIYaen/o06mUF/Ne/l3FA1EQ/tTD5sftCr8Slrosu
         GFvqTyndrWJZS0//65xtoAexIYCRVD7yYd8hsmjv3vQFDQNslGoI9BZpWOyMBEc6l/+G
         1joZH37MUcZf+t1KsepCJTIdWFmMOdDVlSduw6WmR5gKHV8KeBtIaY4Qqd7PAIfot4PT
         EZGA==
X-Gm-Message-State: AA+aEWbNdxN69r4IfWL9jTZKIZ+Q/dH/3wx7TFydzrfjk9vfEGPXYeNM
        Q6ZIDNcI1wgeynt4OHEaKDs=
X-Google-Smtp-Source: AFSGD/UvCQwgNDKaSiA2AccLWRWNJAIUw1Ua1Ds0pdQKMpnEzwAAEhdmg/cm5q56Ae58a9X0G6mJ8Q==
X-Received: by 2002:a1c:dc02:: with SMTP id t2mr13022324wmg.78.1545692030094;
        Mon, 24 Dec 2018 14:53:50 -0800 (PST)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id m15sm18177420wrr.95.2018.12.24.14.53.49
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 24 Dec 2018 14:53:49 -0800 (PST)
Date:   Mon, 24 Dec 2018 23:53:47 +0100
From:   Ingo Molnar <mingo@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [GIT PULL] x86/asm changes for v4.21
Message-ID: <20181224225347.GA124901@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

Please pull the latest x86-asm-for-linus git tree from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-asm-for-linus

   # HEAD: 29434801e7e9c6d05fbea4533b3c0bd6be612f62 x86/vdso: Remove a stale/misleading comment from the linker script

Two changes:

 - Remove (some) remnants of the vDSO's fake section table mechanism that
   were left behind when the vDSO build process reverted to using
   "objdump -S" to strip the userspace image.

 - Remove hardcoded POPCNT mnemonics now that the minimum binutils 
   version supports the symbolic form.

 Thanks,

	Ingo

------------------>
Sean Christopherson (2):
      x86/vdso: Remove obsolete "fake section table" reservation
      x86/vdso: Remove a stale/misleading comment from the linker script

Uros Bizjak (1):
      x86: Use POPCNT mnemonics in arch_hweight.h


 arch/x86/entry/vdso/vdso-layout.lds.S | 27 ---------------------------
 arch/x86/entry/vdso/vdso2c.c          |  8 --------
 arch/x86/include/asm/arch_hweight.h   | 10 ++--------
 3 files changed, 2 insertions(+), 43 deletions(-)
