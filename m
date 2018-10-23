Return-Path: <SRS0=vsD1=ND=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.4 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FSL_HELO_FAKE,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15A9DC67863
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 12:34:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D63CE207DD
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 12:34:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C4DdlCs+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D63CE207DD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728147AbeJWU5w (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Oct 2018 16:57:52 -0400
Received: from mail-wr1-f43.google.com ([209.85.221.43]:41184 "EHLO
        mail-wr1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727940AbeJWU5w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Oct 2018 16:57:52 -0400
Received: by mail-wr1-f43.google.com with SMTP id q7-v6so1507872wrr.8
        for <linux-kernel@vger.kernel.org>; Tue, 23 Oct 2018 05:34:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=RcYjqI+7c0qk0gAmE4Rj9IBt9U6/lFlA+lmyjrqllxw=;
        b=C4DdlCs+7Z2BtVqGIuL1L3chr0qjg0DPOaDpRaPr5MASNVSYp5MyBNEbRuDnvxMyE+
         p7XEh3Aez6y1/a+gSYuNLPMHq+B4Ipx/Ohry+bzvz3JeR5LM3TsBiC/3Lt4vy6W7OlNr
         nY1NYHA5IaxWdoaNsl8oKYaC1rAKwg1rRqzqRWGbcaPr7BKWaU5oiL/S8kyb2xvsCkKT
         d9vI8qRWUD0pChVLGJzohpLyQJrqeR/F/OETvcUbazY+qx2jVsZFqMqQO5Obh+s3LTH7
         eYsh7gupxJOw9F4oGxFwXzACxMvn+42ThFFChLZ5PnrvS2NtCKMV5qRuXAbZlMy5KwGo
         hmig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mime-version:content-disposition:user-agent;
        bh=RcYjqI+7c0qk0gAmE4Rj9IBt9U6/lFlA+lmyjrqllxw=;
        b=LiQIsegBogCsjnb8aCn7aZ0z5pBqQmOPg6MukyLlBh8xEd+wKhQV/EJM6nPboxxkJp
         0DjpJynGmmIzInB20KkHWRqYzOAFlgPN55U60ucdlAD+mNtTicJ1Bhn+atLQgW52SQot
         q+2ncuoQh+YR+bA20R+1WFBp0QcNCW+jtB0wgNi9LIypblpqlfmHdXi46+h6Bp0LsZU7
         ZcIJyqGkTWpnXS3xqoq481h1+hrV4SvJhN6esIFwERrvwS+397aDhholhD4dJe2Mgi+I
         yWSvoEllqvHKARm4JseLb1nBmtqMOabBHWLiIrdC0Tpek2Vap9J5ixMsjFaCJzSp8IvY
         blCA==
X-Gm-Message-State: ABuFfoim6m3AaQ3m1qrb7b4LFWnvwOJdYw9u8cRxL41dyDo6ijr2/9xQ
        2vz0gtIGpFTIZ5cigV0JJaA=
X-Google-Smtp-Source: ACcGV62gnDLiHNP3jYgDrA+VY/MFMvftEnGXvj/FHF1IqmSO7RvGPMg26STPQNCwavegfMiZcfP1Tw==
X-Received: by 2002:adf:f301:: with SMTP id i1-v6mr49061055wro.161.1540298072826;
        Tue, 23 Oct 2018 05:34:32 -0700 (PDT)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id p8-v6sm1402911wre.50.2018.10.23.05.34.31
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 23 Oct 2018 05:34:32 -0700 (PDT)
Date:   Tue, 23 Oct 2018 14:34:29 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [GIT PULL] x86/vdso changes for v4.20
Message-ID: <20181023123429.GA88575@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

Please pull the latest x86-vdso-for-linus git tree from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-vdso-for-linus

   # HEAD: 99c19e6a8fe4a95fa0dac191207a1d40461b1604 x86/vdso: Rearrange do_hres() to improve code generation

Two main changes:

 - Cleanups, simplifications and CLOCK_TAI support (Thomas Gleixner)

 - Improve code generation (Andy Lutomirski)

 Thanks,

	Ingo

  out-of-topic modifications in x86-vdso-for-linus:
  ---------------------------------------------------
  include/linux/clocksource.h        # d67f34c19a67: clocksource: Provide clockso
  kernel/time/Kconfig                # d67f34c19a67: clocksource: Provide clockso
  kernel/time/clocksource.c          # d67f34c19a67: clocksource: Provide clockso


------------------>
Andy Lutomirski (3):
      x86/vdso: Remove "memory" clobbers in the vDSO syscall fallbacks
      x86/vdso: Document vgtod_ts better
      x86/vdso: Rearrange do_hres() to improve code generation

Thomas Gleixner (11):
      clocksource: Provide clocksource_arch_init()
      x86/time: Implement clocksource_arch_init()
      x86/vdso: Enforce 64bit clocksource
      x86/vdso: Use unsigned int consistently for vsyscall_gtod_data:: Seq
      x86/vdso: Introduce and use vgtod_ts
      x86/vdso: Collapse high resolution functions
      x86/vdso: Collapse coarse functions
      x86/vdso: Replace the clockid switch case
      x86/vdso: Simplify the invalid vclock case
      x86/vdso: Move cycle_last handling into the caller
      x66/vdso: Add CLOCK_TAI support


 arch/x86/Kconfig                        |   1 +
 arch/x86/entry/vdso/vclock_gettime.c    | 210 +++++++++-----------------------
 arch/x86/entry/vsyscall/vsyscall_gtod.c |  51 ++++----
 arch/x86/include/asm/vgtod.h            |  53 +++++---
 arch/x86/kernel/time.c                  |  22 ++++
 include/linux/clocksource.h             |   5 +
 kernel/time/Kconfig                     |   4 +
 kernel/time/clocksource.c               |   2 +
 8 files changed, 155 insertions(+), 193 deletions(-)

