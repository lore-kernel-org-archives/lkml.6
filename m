Return-Path: <SRS0=hTZH=KI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: *
X-Spam-Status: No, score=1.3 required=3.0 tests=DKIM_SIGNED,FSL_HELO_FAKE,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D1A6ECDFBB
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 11:14:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5104B20875
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 11:14:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OugJTgFr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5104B20875
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388685AbeGXMUr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Jul 2018 08:20:47 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:55455 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388360AbeGXMUr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jul 2018 08:20:47 -0400
Received: by mail-wm0-f68.google.com with SMTP id f21-v6so2123184wmc.5;
        Tue, 24 Jul 2018 04:14:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=LGHltUa+4XbgFnAGSYQ8WjuLRULtr9GAkTv5DlGLJ0w=;
        b=OugJTgFrOv2EJl+8G5l9My+J7L5mjGneUeCM6VLc9PBDgKbHrOhAqMBkwM3NkQ5Nmu
         BmB93U1qo75dv5KIl/ef9T6hewwfU87n5m1hoiu7cHPcNbtgd2b03eConPakZsTKpD1T
         eVoS7QVCSH+SlOF4DxXjBMH5uzJgWWS3hJAUSiFFWRgrBpNIUFAPO/pdvGSdXICKxqle
         9LG081VRGBqi8l2lH0orBApb1Hr3eCoBlQVNwopF96LW/7CUzzP6ULqUy5m/ec8iIJYH
         H81uYIe6SBGk6WEE/33RNl9G0uJqi4S+TgQBhe4dH3no7qHE/l/9LxV5DsZ6OBe5kbXF
         9HjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=LGHltUa+4XbgFnAGSYQ8WjuLRULtr9GAkTv5DlGLJ0w=;
        b=VLp2VvP2xj62utGBIhs2YM1S21IRoRt7bsLTRis2Uq8LHk2JSlqG1lXeWjJmgKFKo9
         yQN+qhBDPzDUtPEO+hZbesG+HrnmtXTUS+xQvSUtzZq2wWM66tM+icppvyzLx8Gg4gm9
         5V0gKGHYzUznxuGaEoHB8Xd6v/3W5b2EgAquufktGTyPwmHNvCpwWA4ssKb/d8cofrwu
         abnDa8ha8Cd42mZDsHvYD2I0KCWt+vV3Niv2UVpPBeQc3+R3bOK89iyoxLz4CQKrynZQ
         eeA2GAQHEtBcreuHQGNup2FG9AcfPBHAXkD8YaaSg4cPuWBxGxNBLXScGUjGOGpJn+Ha
         utwg==
X-Gm-Message-State: AOUpUlFXsAhQ6ZbpdaVXloa0tZZOECMVeajfuJYLEEUaHozZEGfy8BaA
        NCrxUBfRYnYITMZWqwJgFWU=
X-Google-Smtp-Source: AAOMgpfKS+geeRcgC+lHdhOL8u0DvWunUczWs1bpr9BrqKmXtSvaUBpzAurA1rS5SJhaSy/mx9zI9Q==
X-Received: by 2002:a1c:b586:: with SMTP id e128-v6mr1573907wmf.141.1532430888542;
        Tue, 24 Jul 2018 04:14:48 -0700 (PDT)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id z3-v6sm9228192wru.27.2018.07.24.04.14.47
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 24 Jul 2018 04:14:47 -0700 (PDT)
Date:   Tue, 24 Jul 2018 13:14:45 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     Nadav Amit <namit@vmware.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        X86 ML <x86@kernel.org>, Sam Ravnborg <sam@ravnborg.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>
Subject: Re: [PATCH v6 1/9] Makefile: Prepare for using macros for inline asm
Message-ID: <20180724111445.GB14212@gmail.com>
References: <20180622172212.199633-1-namit@vmware.com>
 <20180622172212.199633-2-namit@vmware.com>
 <CAK7LNASaZd9fupgu4vxc6+tnCnNMdrCi7LTwS56K1LaKODoCtA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK7LNASaZd9fupgu4vxc6+tnCnNMdrCi7LTwS56K1LaKODoCtA@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Masahiro Yamada <yamada.masahiro@socionext.com> wrote:

> 2018-06-23 2:22 GMT+09:00 Nadav Amit <namit@vmware.com>:
> > Using macros for inline assembly improves both readability and
> > compilation decisions that are distorted by big assembly blocks that use
> > alternative sections. Compile macros.S and use it to assemble all C
> > files. Currently, only x86 will use it.
> >
> > Cc: Sam Ravnborg <sam@ravnborg.org>
> > Cc: Masahiro Yamada <yamada.masahiro@socionext.com>
> > Cc: Michal Marek <michal.lkml@markovi.net>
> > Cc: Thomas Gleixner <tglx@linutronix.de>
> > Cc: Ingo Molnar <mingo@redhat.com>
> > Cc: "H. Peter Anvin" <hpa@zytor.com>
> > Cc: x86@kernel.org
> > Cc: linux-kbuild@vger.kernel.org
> > Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> > Signed-off-by: Nadav Amit <namit@vmware.com>
> > ---
> 
> 
> 
> Acked-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> 
> 
> 
> 
> >  Makefile                 |  9 +++++++--
> >  arch/x86/Makefile        | 11 +++++++++--
> >  arch/x86/kernel/macros.S |  7 +++++++
> >  scripts/Kbuild.include   |  4 +++-
> >  scripts/mod/Makefile     |  2 ++
> >  5 files changed, 28 insertions(+), 5 deletions(-)
> >  create mode 100644 arch/x86/kernel/macros.S

So this patch appears to break the xtensa cross-build on my system, with an older 
version of crosstools:

  MODPOST vmlinux.o
/home/mingo/crosstool-korg/bin//gcc-4.9.0-nolibc/xtensa-linux/bin/xtensa-linux-ld:./arch/xtensa/kernel/vmlinux.lds:430: 
syntax error
/home/mingo/tip/Makefile:1010: recipe for target 'vmlinux' failed
make[1]: *** [vmlinux] Error 1
make[1]: Leaving directory '/dev/shm/tip/build'
Makefile:146: recipe for target 'sub-make' failed

Thanks,

	Ingo
