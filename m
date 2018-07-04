Return-Path: <SRS0=cgxA=JU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F611C3279B
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 16:23:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 27945240F4
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 16:23:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="U5Z3NGPp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 27945240F4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752653AbeGDQXp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Jul 2018 12:23:45 -0400
Received: from mail-it0-f68.google.com ([209.85.214.68]:51150 "EHLO
        mail-it0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752173AbeGDQXo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jul 2018 12:23:44 -0400
Received: by mail-it0-f68.google.com with SMTP id u4-v6so8483784itg.0
        for <linux-kernel@vger.kernel.org>; Wed, 04 Jul 2018 09:23:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gQPJ836h+b/3bDAnuyswh+Mo13UThqAEu+8wMB7zA84=;
        b=U5Z3NGPpjFEQNy3vGjys7w70cVMJAD0hemwZYY6unWrZPbe2ZKcaq3OiasWhYuICLO
         rg/dPksJnN95DQ1IEDeKDZ0NFggHWcbHjTY63xzOhNeLGlgFa/THuBjHsMt5bbG+Mp58
         ov1TlLIm/Eo1JolyQdP0P5kBLOCmea10Qd4JY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gQPJ836h+b/3bDAnuyswh+Mo13UThqAEu+8wMB7zA84=;
        b=NljsjSzqa3k7mCfHdr9Hf+cMguU4UgjxwFocUS7+xh9t0v/6X3KOQwFCO6+rdn8SYJ
         8jrmnJ+VumycBlfaVqC4XANYB3a4saddqAofupn3BLVq2upQooWOiKxlPiRVWulAmVg2
         OtFFn8ih+lf1HBkDXq9G6gHV6BKp98P2MqMzNhYtwyGS0j3zTN2uZHVgJTGh3jmOY+ka
         XKGazkj/7296v8tqHmN59vp8feb8i1g3kF+/r3E+z/wq7uJR5EjiUTrFiX+dUSJqhyLa
         qd0RZnViWMMzKjRJeqAR+ALi5dE1Z3mXGl5tatgZE3uux2S9L3Gfz1J0S/mQ3knECMtC
         M4MQ==
X-Gm-Message-State: APt69E3FRd0/xZOOID2cAda0c/6I+K8sceXIKXj4Qs9bt3jP7UkyEDxm
        Q7KL3eQCQFGAQERWiPTfxhYHuqQZe/nZu449mYE=
X-Google-Smtp-Source: AAOMgpeHTwDeXc7Ax/vGjDU3HCQanOQ9j4gsYeO9koVexCJAddPn5JDbew3cfp1xUQYMFlxU0WRtMy2ysMYx1s5xhJ8=
X-Received: by 2002:a24:d0d7:: with SMTP id m206-v6mr2189121itg.1.1530721423143;
 Wed, 04 Jul 2018 09:23:43 -0700 (PDT)
MIME-Version: 1.0
References: <20180704065414.GD23907@yexl-desktop>
In-Reply-To: <20180704065414.GD23907@yexl-desktop>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 4 Jul 2018 09:23:32 -0700
Message-ID: <CA+55aFwSD8T1dusD_Q14MhAxQcYG===ZTdS+CXuT-odj88xWkA@mail.gmail.com>
Subject: Re: [lkp-robot] [x86/entry/64/compat] 8bb2610bc4: kernel_selftests.x86.test_syscall_vdso_32.fail
To:     kernel test robot <xiaolong.ye@intel.com>
Cc:     Andrew Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Denys Vlasenko <dvlasenk@redhat.com>,
        Borislav Petkov <bp@alien8.de>,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        LKP <lkp@01.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 3, 2018 at 11:58 PM kernel test robot <xiaolong.ye@intel.com> wrote:
>
> FYI, we noticed the following commit (built with gcc-7):
>
> commit: 8bb2610bc4967f19672444a7b0407367f1540028 ("x86/entry/64/compat: Preserve r8-r11 in int $0x80")
> [...]
> caused below changes (please refer to attached dmesg/kmsg for entire log/backtrace):

So that commit is expected to fix things, but it also *enabled* the
selftests to warn about the change.

Did you run the new selftest on an old kernel?

It looks that way, because you talk about running the selftests for
commit 8bb2610bc496 (which is 4.17-rc2+), but the dmesg you include is
some ancient version"

    Linux version 4.12.0-10998-g6974f0c

Hmm. Some of those self-tests are very much expected to break on old kernels.

                  Linus
