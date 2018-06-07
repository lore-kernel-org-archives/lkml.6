Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id CwJxEQ15GVsEMwAAmS7hNA
	; Thu, 07 Jun 2018 18:38:20 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 3044A6089E; Thu,  7 Jun 2018 18:38:20 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="f6ivqwZJ"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,T_DKIMWL_WL_HIGH
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id A32FA60590;
	Thu,  7 Jun 2018 18:38:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org A32FA60590
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754027AbeFGSiR (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Thu, 7 Jun 2018 14:38:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:35054 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754010AbeFGSiQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jun 2018 14:38:16 -0400
Received: from mail-wm0-f54.google.com (mail-wm0-f54.google.com [74.125.82.54])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6E3972089F
        for <linux-kernel@vger.kernel.org>; Thu,  7 Jun 2018 18:38:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1528396695;
        bh=wcUk5+A/0qKa4hdM6cmbZllt6CvzsJhBid5Qt0tV3dI=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=f6ivqwZJBM47+7hBICB8AGCNj5R2/vFovjlLydZfVUcptW5aPFLZLDqUpAI4/SCcj
         sOMZnehXePuR2wG+NGeDhTz1K5mXQVNOU3szQEvpmJKlp5MrR1jOzq1YmBS24rPiJa
         xhpmK1K0/OD+9tthnrIaR5Db4hS73Zxuak8rjKa0=
Received: by mail-wm0-f54.google.com with SMTP id v131-v6so21130209wma.1
        for <linux-kernel@vger.kernel.org>; Thu, 07 Jun 2018 11:38:15 -0700 (PDT)
X-Gm-Message-State: APt69E1qpc2EHVmW61MkvcemImmrnwZuAvUf5PSnKvhBLCn5Q5+ip+kQ
        MGPENa1Mywe+dncIR6GhnSJmhQ9gavZ1AhnzIsKUjw==
X-Google-Smtp-Source: ADUXVKLR6aoSzT5bPomlX7u7kQB7Kj1K4kgWGr7D8FW77hDTJo4o6NcyvYAbMaK4Q/psk115g505QRfuC4ja+TdUthU=
X-Received: by 2002:a1c:f902:: with SMTP id x2-v6mr2241602wmh.116.1528396693907;
 Thu, 07 Jun 2018 11:38:13 -0700 (PDT)
MIME-Version: 1.0
References: <20180607143807.3611-1-yu-cheng.yu@intel.com> <20180607143807.3611-6-yu-cheng.yu@intel.com>
In-Reply-To: <20180607143807.3611-6-yu-cheng.yu@intel.com>
From: Andy Lutomirski <luto@kernel.org>
Date: Thu, 7 Jun 2018 11:38:02 -0700
X-Gmail-Original-Message-ID: <CALCETrVyGdWnU1B5vZK4QP2TGVjTCg5wsPX8iAQRGzpcGNGr5g@mail.gmail.com>
Message-ID: <CALCETrVyGdWnU1B5vZK4QP2TGVjTCg5wsPX8iAQRGzpcGNGr5g@mail.gmail.com>
Subject: Re: [PATCH 05/10] x86/cet: ELF header parsing of Control Flow Enforcement
To: Yu-cheng Yu <yu-cheng.yu@intel.com>
Cc: LKML <linux-kernel@vger.kernel.org>, linux-doc@vger.kernel.org,
        Linux-MM <linux-mm@kvack.org>,
        linux-arch <linux-arch@vger.kernel.org>, X86 ML <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. J. Lu" <hjl.tools@gmail.com>,
        "Shanbhogue, Vedvyas" <vedvyas.shanbhogue@intel.com>,
        "Ravi V. Shankar" <ravi.v.shankar@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Oleg Nesterov <oleg@redhat.com>, Arnd Bergmann <arnd@arndb.de>,
        mike.kravetz@oracle.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 7, 2018 at 7:41 AM Yu-cheng Yu <yu-cheng.yu@intel.com> wrote:
>
> Look in .note.gnu.property of an ELF file and check if shadow stack needs
> to be enabled for the task.

Nice!  But please structure it so it's one function that parses out
all the ELF notes and some other code (a table or a switch statement)
that handles them.  We will probably want to add more kernel-parsed
ELF notes some day, so let's structure the code to make it easier.

> +static int find_cet(u8 *buf, u32 size, u32 align, int *shstk, int *ibt)
> +{
> +       unsigned long start = (unsigned long)buf;
> +       struct elf_note *note = (struct elf_note *)buf;
> +
> +       *shstk = 0;
> +       *ibt = 0;
> +
> +       /*
> +        * Go through the x86_note_gnu_property array pointed by
> +        * buf and look for shadow stack and indirect branch
> +        * tracking features.
> +        * The GNU_PROPERTY_X86_FEATURE_1_AND entry contains only
> +        * one u32 as data.  Do not go beyond buf_size.
> +        */
> +
> +       while ((unsigned long) (note + 1) - start < size) {
> +               /* Find the NT_GNU_PROPERTY_TYPE_0 note. */
> +               if (note->n_namesz == 4 &&
> +                   note->n_type == NT_GNU_PROPERTY_TYPE_0 &&
> +                   memcmp(note + 1, "GNU", 4) == 0) {
> +                       u8 *ptr, *ptr_end;
> +
> +                       /* Check for invalid property. */
> +                       if (note->n_descsz < 8 ||
> +                          (note->n_descsz % align) != 0)
> +                               return 0;
> +
> +                       /* Start and end of property array. */
> +                       ptr = (u8 *)(note + 1) + 4;
> +                       ptr_end = ptr + note->n_descsz;

Exploitable bug here?  You haven't checked that ptr is in bounds or
that ptr + ptr_end is in bounds (or that ptr_end > ptr, for that
matter).

> +
> +                       while (1) {
> +                               u32 type = *(u32 *)ptr;
> +                               u32 datasz = *(u32 *)(ptr + 4);
> +
> +                               ptr += 8;
> +                               if ((ptr + datasz) > ptr_end)
> +                                       break;
> +
> +                               if (type == GNU_PROPERTY_X86_FEATURE_1_AND &&
> +                                   datasz == 4) {
> +                                       u32 p = *(u32 *)ptr;
> +
> +                                       if (p & GNU_PROPERTY_X86_FEATURE_1_SHSTK)
> +                                               *shstk = 1;
> +                                       if (p & GNU_PROPERTY_X86_FEATURE_1_IBT)
> +                                               *ibt = 1;
> +                                       return 1;
> +                               }
> +                       }
> +               }
> +
> +               /*
> +                * Note sections like .note.ABI-tag and .note.gnu.build-id
> +                * are aligned to 4 bytes in 64-bit ELF objects.
> +                */
> +               note = (void *)note + ELF_NOTE_NEXT_OFFSET(note, align);

A malicious value here will probably just break out of the while
statement, but it's still scary.

> +       }
> +
> +       return 0;
> +}
> +
> +static int check_pt_note_segment(struct file *file,
> +                                unsigned long note_size, loff_t *pos,
> +                                u32 align, int *shstk, int *ibt)
> +{
> +       int retval;
> +       char *note_buf;
> +
> +       /*
> +        * Try to read in the whole PT_NOTE segment.
> +        */
> +       note_buf = kmalloc(note_size, GFP_KERNEL);

kmalloc() with fully user-controlled, unchecked size is not a good idea.
