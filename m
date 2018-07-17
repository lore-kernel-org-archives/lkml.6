Return-Path: <SRS0=QM4b=KB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40624ECDFB3
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 20:06:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F12D22077B
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 20:06:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=amacapital-net.20150623.gappssmtp.com header.i=@amacapital-net.20150623.gappssmtp.com header.b="TeaxKs0z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F12D22077B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amacapital.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730707AbeGQUkr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Jul 2018 16:40:47 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:34826 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729838AbeGQUkq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jul 2018 16:40:46 -0400
Received: by mail-wr1-f65.google.com with SMTP id a3-v6so2415988wrt.2
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jul 2018 13:06:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20150623.gappssmtp.com; s=20150623;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=DfXPsxu1Dp+K/Kc47BnLwyrteW3/d+HDwDVopLlRgH8=;
        b=TeaxKs0zj4BRUUojh/t9lYaUcq3v6ZTpuqlEOQmOL4t9oImO2JAFN8WRYfgpm4MD/l
         QG6CS5nrKnr+1IiZBuo1WZy8vfN8yIgN8gx64DOVdeSgO7DWpf68KPb6f1zN4WLirXDh
         bmXkWbopDPKodDDjFfti8IpB3VUjYeKzq6n1MAum+OTvhd16MAt550wHva/BJkv9kOoi
         BGyayato2VUfu4WG1oIEBpenV0if/owXrm2V18A4lnLSSUAIoKeS2KxRfeCBJ4indEPr
         rQNiKQqs4/B13usiPwF9jYt/MWtCt+gHATUuMmycirQRwwzrORDXL+failMcjVffFcI+
         iG4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=DfXPsxu1Dp+K/Kc47BnLwyrteW3/d+HDwDVopLlRgH8=;
        b=C33Uju7XTsLtWpitkGIO/kYOGH+akVcAXSR4Mq3ZrKAvzdOQgdWFx85X3prUm39i4w
         sfNAfJVMjC0fpp8yP0w3/IEXDM8qZfDP9lzHzS3lQ09NpoUmwKgEI3ZPfV8VDxYWMtCu
         z89Axb0nNWC7sYJx5lIX4ui2gji6s3j0Z2S3ueHP8IKPE+sNKeKQkoHQLI3bR89vdj+B
         c3xPtjB7o8Rl4P+LsM0TFXwcSzshDzLvqdrrKMk9ZxHV4YQdZ+p6c/NtxqnebiNitnv5
         ymMNCYkclyJUww4ES6GDdIi4bfMp3ryfSVgcN7DUARhY5iYSCFFboY7t2FB9RSWuiTH6
         YMHQ==
X-Gm-Message-State: AOUpUlHJog1Kp0D+3CWRq5vnUtio2HXGgScrMqOJa8YQ6+1nvchpbeIF
        8xI9Pp4bsgxOGleGQFdnmbrhyauXhNMOKy+GIbytVw==
X-Google-Smtp-Source: AAOMgpdFNR2OMYrN/8RfBKoyJsVneIUmtZNgCqeXIlhwJ6yZ88v0kg9KfFCwoif+020M+Jmc+JsqQ/YDEAiRPIBsT7M=
X-Received: by 2002:adf:fe42:: with SMTP id m2-v6mr2273311wrs.171.1531857991713;
 Tue, 17 Jul 2018 13:06:31 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a1c:d548:0:0:0:0:0 with HTTP; Tue, 17 Jul 2018 13:06:11
 -0700 (PDT)
In-Reply-To: <20180717071545.ojdall7tatbjtfai@suse.de>
References: <1531308586-29340-1-git-send-email-joro@8bytes.org>
 <1531308586-29340-11-git-send-email-joro@8bytes.org> <CALCETrUg_4q8a2Tt_Z+GtVuBwj3Ct3=j7M-YhiK06=XjxOG82A@mail.gmail.com>
 <20180714052110.cobtew6rms23ih37@suse.de> <7AB4F269-E0E8-4290-A764-69D8605467E8@amacapital.net>
 <20180714080159.hqp36q7fxzb2ktlq@suse.de> <75BDF04F-9585-438C-AE04-918FBE00A174@amacapital.net>
 <20180717071545.ojdall7tatbjtfai@suse.de>
From:   Andy Lutomirski <luto@amacapital.net>
Date:   Tue, 17 Jul 2018 13:06:11 -0700
Message-ID: <CALCETrXAF6+mkDL4+uQdHQdJ=G70YVu_k55P_x6Mgi4hXe3oYw@mail.gmail.com>
Subject: Re: [PATCH 10/39] x86/entry/32: Handle Entry from Kernel-Mode on Entry-Stack
To:     Joerg Roedel <jroedel@suse.de>
Cc:     Andy Lutomirski <luto@kernel.org>, Joerg Roedel <joro@8bytes.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>,
        "H . Peter Anvin" <hpa@zytor.com>, X86 ML <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Dave Hansen <dave.hansen@intel.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Juergen Gross <jgross@suse.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Borislav Petkov <bp@alien8.de>, Jiri Kosina <jkosina@suse.cz>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Brian Gerst <brgerst@gmail.com>,
        David Laight <David.Laight@aculab.com>,
        Denys Vlasenko <dvlasenk@redhat.com>,
        Eduardo Valentin <eduval@amazon.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        Will Deacon <will.deacon@arm.com>,
        "Liguori, Anthony" <aliguori@amazon.com>,
        Daniel Gruss <daniel.gruss@iaik.tugraz.at>,
        Hugh Dickins <hughd@google.com>,
        Kees Cook <keescook@google.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Waiman Long <llong@redhat.com>, Pavel Machek <pavel@ucw.cz>,
        "David H . Gutteridge" <dhgutteridge@sympatico.ca>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 17, 2018 at 12:15 AM, Joerg Roedel <jroedel@suse.de> wrote:
> On Sat, Jul 14, 2018 at 07:36:47AM -0700, Andy Lutomirski wrote:
>> But I=E2=80=99m still unconvinced. If any code executed with IRQs enable=
d on
>> the entry stack, then that code is terminally buggy. If you=E2=80=99re
>> executing with IRQs off, you=E2=80=99re not going to get migrated.  64-b=
it
>> kernels run on percpu stacks all the time, and it=E2=80=99s not a proble=
m.
>
> The code switches to the kernel-stack and kernel-cr3 and just remembers
> where it came from (to handle the entry-from-kernel with entry-stack
> and/or user-cr3 case). IRQs are disabled in the entry-code path. But
> ultimately it calls into C code to handle the exception. And there IRQs
> might get enabled again.
>
>> IRET errors are genuinely special and, if they=E2=80=99re causing a prob=
lem
>> for you, we should fix them the same way we deal with them on x86_64.
>
> Right, IRET is handled differently and doesn't need this patch. But the
> segment-writing exceptions do.
>
> If you insist on it I can try to implement the assumption that we don't
> get preempted in this code-path. That will safe us some cycles for
> copying stack contents in this unlikely slow-path. But we definitly need
> to handle the entry-from-kernel with entry-stack and/or user-cr3 case
> correctly and make a switch to kernel-stack/cr3 because we are going to
> call into C-code.
>
>

Yes, we obviously need to restore the correct cr3.  But I really don't
like the code that rewrites the stack frame that we're about to IRET
to, especially when it doesn't seem to serve a purpose.  I'd much
rather the code just get its CR3 right and do the IRET and trust that
the frame it's returning to is still there.
