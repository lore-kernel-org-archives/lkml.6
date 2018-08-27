Return-Path: <SRS0=ekB2=LK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B225C433F4
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 21:06:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3F310208B8
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 21:06:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ZnYhu99l"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3F310208B8
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727538AbeH1Ayi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Aug 2018 20:54:38 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:40555 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727281AbeH1Ayi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Aug 2018 20:54:38 -0400
Received: by mail-pg1-f193.google.com with SMTP id z25-v6so143396pgu.7
        for <linux-kernel@vger.kernel.org>; Mon, 27 Aug 2018 14:06:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=SJPZB94REAEIC078OFGYFnLQNwdqil4F+Z/VRUyYtdU=;
        b=ZnYhu99lnWNClUTsnEKRDBQ+bpQG1vkesMksQO8hgdtBicdq1+2o39ZCDuWkmDiT1D
         /CRGwHiOk8JvbhJ7aQD6bQ8dUOLM+zj8xR+AwHV9kxorCwFf5pTHAPLo8OzpcVTTYeeg
         ITPMy6DNcIzMgc3NZJ8mi64lXVBubl5RqLaS4aU4TNPuoOBAbqYvmX7XxYGtGdrnhFbC
         dw5ji3fOGijDiv+l67SNHukn/nT813Pwu3MujJ87jhP46GSq0tyXlFKM0dguaKdEPjMQ
         AnT9tnPq8I7FaxS016EHKe55ejLdO5L3IuXfjJYDLNEumWwYvjrcuMn5NSJEdORrB84K
         YkDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SJPZB94REAEIC078OFGYFnLQNwdqil4F+Z/VRUyYtdU=;
        b=rfQVtt6GPn2xe+nKz6sVlypobwfr/U2eOWASAYp/7/xWvBvrmzpw9IgWb8WYsIgJq8
         UONj2dNbNSHen9aGxL6XpUYo5Bw5mJ+AqCK7jq0OMbD7oRwaHJyp15T279VlRirQnlyM
         56jWIPp5dpq/epFGLEVDX0dyBADYA2ZS+DjfxPyIzO0whbxz9wxbxL8+aoURfR+CZGBv
         0TJxO+fVEd2r62LBtrSaeiI+JIAaZX47aJS1aGePBvGJmVa9D0QAiwcxcpBYyk5nVCTh
         XXhQLpI/etuE+gPO0SthcBmpH9jq9GltZ7rUWioP4+MFZiB8ZAelkk1EFwnp1SwNVTZ+
         oiEA==
X-Gm-Message-State: APzg51CL778Rbxfoj2xqflkNtY9aCwdqclxf/d6Pj1/SeaLDMoeCiOjT
        rXwIvh/nM0v7JH5KUfJSYBBOZgjvbvo3l7fA7TzfnA==
X-Google-Smtp-Source: ANB0VdaB0UbvONtdOzYj5o3Hve6WonKkewMZJqabJE3LM8QBDl2nsJDZwwT1XEkytxbPRbpJqcfbE6uZUE6nZUBggcM=
X-Received: by 2002:a62:1815:: with SMTP id 21-v6mr15765579pfy.227.1535403978894;
 Mon, 27 Aug 2018 14:06:18 -0700 (PDT)
MIME-Version: 1.0
References: <20180723122413.003644357@linuxfoundation.org> <20180723122413.797031305@linuxfoundation.org>
 <1535152080.2902.58.camel@codethink.co.uk>
In-Reply-To: <1535152080.2902.58.camel@codethink.co.uk>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Mon, 27 Aug 2018 14:06:07 -0700
Message-ID: <CAKwvOd=8rVG5L8dzE5v_jj6o3gruRStxF=orX4jA+tzB=gf2Vg@mail.gmail.com>
Subject: Re: [PATCH 4.4 018/107] x86/paravirt: Make native_save_fl() extern inline
To:     ben.hutchings@codethink.co.uk
Cc:     stable@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        hpa@zytor.com, tstellar@redhat.com, sedat.dilek@gmail.com,
        jgross@suse.com, Linus Torvalds <torvalds@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>, acme@redhat.com,
        akataria@vmware.com, Andrew Morton <akpm@linux-foundation.org>,
        andrea.parri@amarulasolutions.com,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Alistair Strachan <astrachan@google.com>,
        boris.ostrovsky@oracle.com, brijesh.singh@amd.com,
        Cao jin <caoj.fnst@cn.fujitsu.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Greg Hackmann <ghackmann@google.com>,
        "J. Kiszka" <jan.kiszka@siemens.com>,
        jarkko.sakkinen@linux.intel.com, joe@perches.com,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Kees Cook <keescook@google.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        linux-efi@vger.kernel.org,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Manoj Gupta <manojgupta@google.com>, mawilcox@microsoft.com,
        Michal Marek <michal.lkml@markovi.net>, mjg59@google.com,
        Matthias Kaehlcke <mka@chromium.org>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        David Rientjes <rientjes@google.com>, rostedt@goodmis.org,
        thomas.lendacky@amd.com, Thiebaud Weksteen <tweek@google.com>,
        virtualization@lists.linux-foundation.org,
        Will Deacon <will.deacon@arm.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Ingo Molnar <mingo@kernel.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 24, 2018 at 4:08 PM Ben Hutchings
<ben.hutchings@codethink.co.uk> wrote:
>
> On Mon, 2018-07-23 at 14:41 +0200, Greg Kroah-Hartman wrote:
> > 4.4-stable review patch.  If anyone has any objections, please let me know.
> >
> > ------------------
> >
> > From: Nick Desaulniers <ndesaulniers@google.com>
> >
> > commit d0a8d9378d16eb3c69bd8e6d23779fbdbee3a8c7 upstream.
> >
> > native_save_fl() is marked static inline, but by using it as
> > a function pointer in arch/x86/kernel/paravirt.c, it MUST be outlined.
> >
> > paravirt's use of native_save_fl() also requires that no GPRs other than
> > %rax are clobbered.
> [...]
>
> Shouldn't native_restore_fl() be changed similarly?  You added an out-
> of-line definition, but it doesn't seem like it will actually be used.
>

Good catch, will send a patch with your reported by. Thank you for the report.
-- 
Thanks,
~Nick Desaulniers
