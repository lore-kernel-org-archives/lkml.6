Return-Path: <SRS0=sQLo=JB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id F0A99C5CFC1
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 04:04:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A304F208B8
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 04:04:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="goc812Kb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A304F208B8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755503AbeFOEEu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Jun 2018 00:04:50 -0400
Received: from mail-lf0-f65.google.com ([209.85.215.65]:34053 "EHLO
        mail-lf0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750890AbeFOEEr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jun 2018 00:04:47 -0400
Received: by mail-lf0-f65.google.com with SMTP id o9-v6so12626352lfk.1;
        Thu, 14 Jun 2018 21:04:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:reply-to:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=VN32mAWuP/M7mDALBruH5lUHjVq3Gko9f32gJXgG3M0=;
        b=goc812KbK7lMqqt/9kI5Wx4F9fPSGQt9YsYgdQF5vXkapj3ZKZwxZnglDWKUfwzKtg
         jr3CbFEZCJgPG0RQi5MZcUjc0YpPj40m6WVTqKCVK9PQube8+AK/baSHybshi6iDx0zt
         fkBPNqAP3EU60d65uw6mfFxly3Qj16zD+LmRfu9KU4mMaX7pz9V1uUedse8eSPphI4JW
         PrljgkqinDySZXMQBA1loLwghgioGzv0YX9SPy56FSK1aKFcUmovA22tkKaYq++9y1g8
         E/KhioJW0bg8yLWg2bL4mbPIa6xwS1298URE0Uybn6TvMNjRzxp+6JRY/mkC9byTS5s8
         8jSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:reply-to:in-reply-to:references
         :from:date:message-id:subject:to:cc;
        bh=VN32mAWuP/M7mDALBruH5lUHjVq3Gko9f32gJXgG3M0=;
        b=GSDXjTYabGDtnyc2an+7eompxtYFA9sXXPQq1Rd6FVsT0ysEa1kZO3T6qM/bcXbSwV
         yd5xoKubZkgRv1ZHD9Dz7ivQB2lTDqsl1NoxouzyKD9Puhkph1P65qF8ZOpF7A0srYqk
         VpEErmPJzqOw2QiTG4GBWaZ5dfVPL0M/Ye7GXLZVfCO7zk7cpQkM9aWSxuj/oX7hDNJJ
         IXWPTy9qge7FQOYuU+XffwNH/HPJ9+paBB84otB2OUcSQ2yUY9W1fO74+IOUoe7Pbubb
         fbfHdFqAf2Uvpe79KnSQc1M/n3AuYFVhNbRBntNx64h01pY6DiTSJsUuQbXBJjPC8qYc
         yeWQ==
X-Gm-Message-State: APt69E3k9WwDCK2zuflAa7pKvJPy8ao1njwKLA7fIVGm3DExbjjb4+W7
        MYJ82ZGn3kuamr5ssBcmZoZr7R1jG9JdgSs4CiA=
X-Google-Smtp-Source: ADUXVKJiAA3cI7tuYp4g+oOGUWiKjUnm7IyvqolQEx4c0nWkulwUNE34S7+SVUNEWixdt7SQ3/5O/UpSiEXlPNlkQUk=
X-Received: by 2002:a2e:5b95:: with SMTP id m21-v6mr5187lje.79.1529035486137;
 Thu, 14 Jun 2018 21:04:46 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a19:b87:0:0:0:0:0 with HTTP; Thu, 14 Jun 2018 21:04:45 -0700 (PDT)
Reply-To: sedat.dilek@gmail.com
In-Reply-To: <CAKwvOdngs8k_T=nDKh8JYdAwwFoJRcCU0bZu0tJHQ+keZ5+RFQ@mail.gmail.com>
References: <20180613210518.113983-1-ndesaulniers@google.com>
 <20180613210518.113983-3-ndesaulniers@google.com> <b027a324-ffae-fd5e-d8a3-03934be91a2d@zytor.com>
 <CAKwvOdngs8k_T=nDKh8JYdAwwFoJRcCU0bZu0tJHQ+keZ5+RFQ@mail.gmail.com>
From:   Sedat Dilek <sedat.dilek@gmail.com>
Date:   Fri, 15 Jun 2018 06:04:45 +0200
Message-ID: <CA+icZUWTqyrHGj=OzUtb7Kry0x_dH0-C9d5CpmDgzgZc0a9=Lg@mail.gmail.com>
Subject: Re: [PATCH v5 2/3] x86/asm: add _ASM_ARG* constants for argument
 registers to <asm/asm.h>
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     hpa@zytor.com, Andrew Morton <akpm@linux-foundation.org>,
        mingo@redhat.com, Thomas Gleixner <tglx@linutronix.de>,
        linux-efi@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        x86@kernel.org, virtualization@lists.linux-foundation.org,
        Alistair Strachan <astrachan@google.com>,
        Manoj Gupta <manojgupta@google.com>,
        Greg Hackmann <ghackmann@google.com>, tstellar@redhat.com,
        Kees Cook <keescook@google.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Michal Marek <michal.lkml@markovi.net>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        geert@linux-m68k.org, Will Deacon <will.deacon@arm.com>,
        mawilcox@microsoft.com, Arnd Bergmann <arnd@arndb.de>,
        David Rientjes <rientjes@google.com>, acme@redhat.com,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        boris.ostrovsky@oracle.com, "J. Kiszka" <jan.kiszka@siemens.com>,
        rostedt@goodmis.org, kirill.shutemov@linux.intel.com,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        akataria@vmware.com, brijesh.singh@amd.com,
        Cao jin <caoj.fnst@cn.fujitsu.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        jarkko.sakkinen@linux.intel.com, jgross@suse.com,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Matthias Kaehlcke <mka@chromium.org>, thomas.lendacky@amd.com,
        Thiebaud Weksteen <tweek@google.com>, mjg59@google.com,
        joe@perches.com, andrea.parri@amarulasolutions.com,
        "H. Peter Anvin" <hpa@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 14, 2018 at 10:59 PM, Nick Desaulniers
<ndesaulniers@google.com> wrote:
> On Thu, Jun 14, 2018 at 1:48 PM H. Peter Anvin <hpa@zytor.com> wrote:
>>
>> On 06/13/18 14:05, Nick Desaulniers wrote:
>> > From: "H. Peter Anvin" <hpa@linux.intel.com>
>> >
>> > i386 and x86-64 uses different registers for arguments; make them
>> > available so we don't have to #ifdef in the actual code.
>> >
>> > Native size and specified size (q, l, w, b) versions are provided.
>> >
>> > Suggested-by: Sedat Dilek <sedat.dilek@gmail.com>
>> > Signed-off-by: H. Peter Anvin <hpa@linux.intel.com>
>> > Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>
>>
>> I still object to Suggested-by: here.  Sedat did a correction, which is
>> a Reviewed-by:, but unless I'm completely out to sea, there was no
>> suggestion on Sedat's part of this; and I had certainly not seen it when
>> I wrote the code.
>
> I'm fine with changing it from a Suggested-by to a Reviewed-by.  Can
> you do that when you apply the set, or should I send a v6?
>

Hi,

this issue with Clang and Paravirt is such an ancient issue.
Back to the days in 2011 before LLVMlinux was born, the project was
called lll-project.
Fact is the issue is today fixed.
Not sure about the credits Suggested-by/Reviewed-by in the
Linux-kernel development process.
I did not count the number of compiler runs here.
A Tested-by is OK for me.
Anyway, the beast is dead, this counts for me.

Regards,
- Sedat -
