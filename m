Return-Path: <SRS0=ZAeg=KF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A84BECDE5F
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Jul 2018 21:07:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C65E620858
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Jul 2018 21:07:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="JE0GY1nT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C65E620858
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728166AbeGUWBK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 21 Jul 2018 18:01:10 -0400
Received: from mail-io0-f194.google.com ([209.85.223.194]:42559 "EHLO
        mail-io0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728080AbeGUWBK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Jul 2018 18:01:10 -0400
Received: by mail-io0-f194.google.com with SMTP id g11-v6so12613492ioq.9
        for <linux-kernel@vger.kernel.org>; Sat, 21 Jul 2018 14:07:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=3yO07bYf5lrMCO9yyC0kQG9GgNMgDjdwLm6rzRE4B0g=;
        b=JE0GY1nTAI6tS7Q490V1ihGpTb9BTV7Apwd3Diw05X/REoWfUvwUc8//VS5jLqQeh0
         mOMFj8OTjzpf8z/ANeymrnUM9vvkx6K57ChwpnpbbLRtkMy4bDCgMOnUKTGVzJTBERbq
         SgvwxUijcqUQoIHdoqDKRkS17SiwozaoBITLs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=3yO07bYf5lrMCO9yyC0kQG9GgNMgDjdwLm6rzRE4B0g=;
        b=i4f1V7Wqq6Sa2gzQNvTWAevkN1gWDcRx9do/98Vnz7ts5FNv4Dr7AnsaGVq2rSLnKZ
         L+p0W1blwbau39L+PGuTyzmeCvqCOwGhZjaVMV3pRq+fOvkMms/mcTFx5c67Pmog1OIJ
         noitDxNEWPCa76ljUj1J7Xh2TWdh7HG5tDlWTeccM58XUq0wOXhzbYesNYN4b+3Aya6D
         +Mma8g3k+GW93iQl7FfWJq62nSqFh7/QmaDHab26Ugxin0u89ltVto49CxG2D/ftXfkU
         MiYb6xNj+zk2x8rUHdavRhhWccgGIHrly/KmD6n5CFAmpggVx6kJseQgdj2OJaw0nmj8
         6gEg==
X-Gm-Message-State: AOUpUlHom1Mt6HUlrpB1y2JuhRoRHuVajUMxJJ9Xz4vwzPhiRTbZ4QgR
        W5NCMWYg2BBC+Kr681+rHCv0DvcusLQABxS+CO4=
X-Google-Smtp-Source: AAOMgpew5GgiqFVkMVEe2Y1hF2h8yO2mHF38u6/CIuQ5GdFuiPvXVozMGZIEz1t/jakkpa5zr5U1ur6w/h0BV2Fm79Q=
X-Received: by 2002:a6b:1502:: with SMTP id 2-v6mr5951510iov.203.1532207223678;
 Sat, 21 Jul 2018 14:07:03 -0700 (PDT)
MIME-Version: 1.0
References: <1532103744-31902-1-git-send-email-joro@8bytes.org>
 <1532103744-31902-2-git-send-email-joro@8bytes.org> <CALCETrXJX8tPVgD=Ce41534uneAAobm-HyjeGwVYgJDJ_+-bDw@mail.gmail.com>
 <20180720174846.GF18541@8bytes.org> <CALCETrUj4cLpOKUbJUfLqKJFkjAgeraE=ORQ-e-bKU+AHda0=Q@mail.gmail.com>
 <20180720213700.gh6d2qd2ck6nt4ax@suse.de> <D89602E9-E620-4AF0-822C-206D7F0BA071@amacapital.net>
In-Reply-To: <D89602E9-E620-4AF0-822C-206D7F0BA071@amacapital.net>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sat, 21 Jul 2018 14:06:52 -0700
Message-ID: <CA+55aFyjFjdeAwAOu-WsE=yk_+cAaaOvp4-DSEHDaWG+1g_BSA@mail.gmail.com>
Subject: Re: [PATCH 1/3] perf/core: Make sure the ring-buffer is mapped in all page-tables
To:     Andy Lutomirski <luto@amacapital.net>
Cc:     Joerg Roedel <jroedel@suse.de>,
        Andrew Lutomirski <luto@kernel.org>,
        Joerg Roedel <joro@8bytes.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>, Peter Anvin <hpa@zytor.com>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>,
        Dave Hansen <dave.hansen@intel.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        =?UTF-8?B?SsO8cmdlbiBHcm/Dnw==?= <jgross@suse.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Borislav Petkov <bp@alien8.de>, Jiri Kosina <jkosina@suse.cz>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Brian Gerst <brgerst@gmail.com>,
        David Laight <David.Laight@aculab.com>,
        Denys Vlasenko <dvlasenk@redhat.com>,
        Eduardo Valentin <eduval@amazon.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Will Deacon <will.deacon@arm.com>,
        "Liguori, Anthony" <aliguori@amazon.com>,
        Daniel Gruss <daniel.gruss@iaik.tugraz.at>,
        Hugh Dickins <hughd@google.com>,
        Kees Cook <keescook@google.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Waiman Long <llong@redhat.com>, Pavel Machek <pavel@ucw.cz>,
        "David H . Gutteridge" <dhgutteridge@sympatico.ca>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 20, 2018 at 3:20 PM Andy Lutomirski <luto@amacapital.net> wrote=
:
> Thanks for digging!  The problem was presumably that vmalloc_fault() will=
 IRET and re-enable NMIs on the way out.
>  But we=E2=80=99ve supported page faults on user memory in NMI handlers o=
n 32-bit and 64-bit for quite a while, and it=E2=80=99s fine now.
>
> I would remove the warning, re-test, and revert the other patch.

Agreed. I don't think we have any issues with page faults during NMI
any more.  Afaik the kprobe people depend on it.

That said, 64-bit mode has that scary PV-op case
(arch_flush_lazy_mmu_mode). Being PV mode, I can't find it in myself
to worry about it, I'm assuming it's ok.

                Linus
