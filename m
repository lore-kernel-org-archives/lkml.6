Return-Path: <SRS0=/0sc=JS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 404A1C3279B
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 20:54:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DEAE125BEA
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 20:54:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="MrRXngiY";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="YQPKMQNY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DEAE125BEA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752969AbeGBUyj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Jul 2018 16:54:39 -0400
Received: from mail-yw0-f196.google.com ([209.85.161.196]:45959 "EHLO
        mail-yw0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752391AbeGBUyh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jul 2018 16:54:37 -0400
Received: by mail-yw0-f196.google.com with SMTP id 139-v6so1806821ywg.12
        for <linux-kernel@vger.kernel.org>; Mon, 02 Jul 2018 13:54:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=ZX0kxtKXqxWLYEoVFOKpwuR0lKdAjWDtszc83xa48Ao=;
        b=MrRXngiYOfw//SXySzh6dMsahHbJ1oh/0Ap8mOU0naARtPNhXv5ugkp10i3mHh8Jap
         htqgELVnn0HDhsxwiQjwAGcvHJBkelhY1tlsknS76MWRmoa/NckSpcPWbcKBOwsO5s0+
         rYBCFuFpga1kGu00y1UzGdgQbR7DMXei5XXGTqg7TscoLGsKEdi7KRDCvJC9YxBF3APO
         JOabR4/NiCFhmhdJnSwdIUJbnR1O6Q7zbGL/A+S9lCASyrrwCtEEF62XEJWPPn7lppQB
         cFQftGIfIcq8E0+IvlrvGrFN8K7N6ML1jWwvsc45JnEyo1POiZRVlv27UvOT7A5cyi8N
         XZ/g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=ZX0kxtKXqxWLYEoVFOKpwuR0lKdAjWDtszc83xa48Ao=;
        b=YQPKMQNYK0U+8ZwZLP/yQ2BHnwY1nvElvNpSt4FuWKz7w+UyZLUIahAl9DF7E+Y+Po
         D3zlfLWvx/epajvds3YzLhB4zpHbOnmR/ZPZewrIosOMn0iI5ASMSUzza9IOIhin8KMf
         du//qTFp3fpdEjMvpCIyLb8MlyHY8fvgzuYds=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=ZX0kxtKXqxWLYEoVFOKpwuR0lKdAjWDtszc83xa48Ao=;
        b=eDSATUamgrCpaXwHgP9P05GSr7ncyUQ7C5Zi+W9r/3712GK+nkAZJG7oeOuGZm+NDN
         FbaRFnCjPp4EkaUPojcojnOnoAIS/eeFNo8v5Nsf4E5fMDKxm08i9wD89qCY4btpAY26
         jrnzdFx+Wdg2MxzPE/RVjuIvuC5Y0pCVEFq5PW+fr3rxVBYG81LF98Krcy0ya7u8eCgo
         ViiB5Nt7q+0Wh1uvC8+3eIefwjiyaHNfg5hH6Brq2I0ulCuOk3AX6KCTadPtF/la5JQI
         2QV9JDK5ipxRpMxRg/W5Wzq3fF2+bbXv69RRt2OSttbzWdaHLtkmgUDOCCpfg7kjInhz
         8uRA==
X-Gm-Message-State: APt69E1EO1ju3A2JwHSzTmSRqIngx1U1S2YusDaeJu4BiG7C5O0IWPM2
        dKV061gu/vviwL7FkZ1/CVMzB31X0t6/sJIzfVrYWw==
X-Google-Smtp-Source: AAOMgpf6XzrFeb87O+WkmdwVQ4Iycha6LiqThxPPpfm/VtlXDctfPFsFuj489s3QDE1qSCM3ybnGV0NuiFX8Z65kCbE=
X-Received: by 2002:a81:39d7:: with SMTP id g206-v6mr6774791ywa.416.1530564876953;
 Mon, 02 Jul 2018 13:54:36 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a25:5f51:0:0:0:0:0 with HTTP; Mon, 2 Jul 2018 13:54:36 -0700 (PDT)
In-Reply-To: <0076b929-4785-0665-0e08-789c504f6b78@redhat.com>
References: <1530101255-13988-1-git-send-email-crecklin@redhat.com>
 <CAGXu5jLDULvf-VBhUfBXtSNaSWpq8irgg56LT3nHDft5gZg5Lw@mail.gmail.com>
 <5506a72f-99ac-b47c-4ace-86c43b17b5c5@redhat.com> <CAGXu5jL8XDYE+B=a_TBM2K8F-c3f4Jz6zcm3ggacbPNN2wCtpg@mail.gmail.com>
 <0076b929-4785-0665-0e08-789c504f6b78@redhat.com>
From:   Kees Cook <keescook@chromium.org>
Date:   Mon, 2 Jul 2018 13:54:36 -0700
X-Google-Sender-Auth: ms4Ng3WgA0XXjN0pDtEiHxJLYJo
Message-ID: <CAGXu5jLXG6YKruuNc3Bnx3tuKZjNfavRwKxk-e4_-Q5mEzy5rw@mail.gmail.com>
Subject: Re: [PATCH v3] add param that allows bootline control of hardened usercopy
To:     Chris von Recklinghausen <crecklin@redhat.com>
Cc:     Laura Abbott <labbott@redhat.com>, Paolo Abeni <pabeni@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 2, 2018 at 11:55 AM, Christoph von Recklinghausen
<crecklin@redhat.com> wrote:
> On 07/02/2018 02:43 PM, Kees Cook wrote:
>> On Sat, Jun 30, 2018 at 1:43 PM, Christoph von Recklinghausen
>> <crecklin@redhat.com> wrote:
>>> The last issue I'm chasing is build failures on ARCH=m68k. The error is
>>> atomic_read and friends needed by the jump label code not being found.
>>> The config has CONFIG_BROKEN_ON_SMP=y, so the jump label calls I added
>>> will only be made #ifndef CONFIG_BROKEN_ON_SMP. Do you think that's
>>> worth a mention in the blurb that's added to
>>> Documentation/admin-guide/kernel-parameters.txt?
>> Uhm, that's weird -- I think the configs on m68k need fixing then? I
>> don't want to have to sprinkle that ifdef in generic code.
>>
>> How are other users of static keys and jump labels dealing with m68k weirdness?
>>
> There's also CONFIG_JUMP_LABEL which is defined in x86_64 but not
> defined in the m68k configs. I'll use that instead. In hindsight I
> should have spotted that but didn't.

I think what I mean is that jump labels should always work. There
shouldn't be a need to #ifdef the common usercopy code. i.e.
include/linux/jump_label.h should work on all architectures already. I
see HAVE_JUMP_LABEL tests there, for example:

#if defined(CC_HAVE_ASM_GOTO) && defined(CONFIG_JUMP_LABEL)
# define HAVE_JUMP_LABEL
#endif

Other core code uses static keys without this; what is the failing combination?

-Kees

-- 
Kees Cook
Pixel Security
