Return-Path: <SRS0=g0DB=NA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FF47C67863
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Oct 2018 14:10:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B99CE21534
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Oct 2018 14:10:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="R4wcpoAY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B99CE21534
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727447AbeJTWVX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 20 Oct 2018 18:21:23 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:32847 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727321AbeJTWVX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Oct 2018 18:21:23 -0400
Received: by mail-io1-f65.google.com with SMTP id l25-v6so24619198ioj.0
        for <linux-kernel@vger.kernel.org>; Sat, 20 Oct 2018 07:10:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=o0j3uvj8K8qMDytKl8zVEjglg8T8MozK9PVtZPejaRk=;
        b=R4wcpoAYKA07Ny4Gzm7hVDC6VGYBpW/kh4uKwVh1/zwIoD1F4LknfjKCytm5p1HDnH
         S82FikszuVX/+vKC7o+KRgFJJKlRdanNar0SqIaYVEwGqXodIgDyRnOb5M2BH6Qg8OfX
         LMUxzLIk9KuwyAPPfW97Bwm2WTesXsdR8P+bQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=o0j3uvj8K8qMDytKl8zVEjglg8T8MozK9PVtZPejaRk=;
        b=L7DvHHQs2aGh5b2mYsW5sl5TUUl1BWX/AjDkKotUxBFbCewmdu5DqJHA5YWCQuvwuG
         JcnC9uSaUZIitJMhdAi4/y5KcES5GXG5G/pUW+qUT5hMf95Av1w3N3MEDib8Y/+S9Wah
         8aciJcuM9cj58hJljDYDrQw5/+l4xpsSfz9+GOmgPUEjP7QOgshtcMCmxsea6iSRc0vQ
         l8jitPCGU2LmHT4dL842v/ojC1zR/aBfulwz5P84M82vfCv/VweXwLWEFt9y7+6dolgg
         NgYVGVcU5LTQ/EujLc/XNFwqb9re7lGTk6L/uqauMpQ0w3ClUwu3Sw0YWbhtA3fIwCeO
         mMNg==
X-Gm-Message-State: AGRZ1gIVRhvvMjLf+koDEDCkF/I5PhGEuAYradCuFp0ftKi9cJ3OBL16
        qc0WUqr1UmEvY3K+QR/janE2TJfXKa+3aDfIOZ1JNw==
X-Google-Smtp-Source: AJdET5fZI8qcT0OAZI20At0ZpyHIJnkogXFESosFYymcved/Q4u4KtfMydXo9D2vGjIavz4ZvWp1nbmn4u/A5vJ4K5M=
X-Received: by 2002:a6b:3787:: with SMTP id e129-v6mr5376703ioa.60.1540044645941;
 Sat, 20 Oct 2018 07:10:45 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a6b:5910:0:0:0:0:0 with HTTP; Sat, 20 Oct 2018 07:10:45
 -0700 (PDT)
In-Reply-To: <alpine.LSU.2.21.1810191714540.4692@pobox.suse.cz>
References: <20181001140910.086E768BC7@newverein.lst.de> <20181001141652.5478C68BE1@newverein.lst.de>
 <alpine.LSU.2.21.1810171051560.21847@pobox.suse.cz> <20181018125820.iw54zbirq74ulknj@linux-8ccs>
 <CAKv+Gu_yNBN+Rpw98MAZaxzSjm20qMYD7+fiJ1fBHoUeDr9fBA@mail.gmail.com> <alpine.LSU.2.21.1810191714540.4692@pobox.suse.cz>
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date:   Sat, 20 Oct 2018 22:10:45 +0800
Message-ID: <CAKv+Gu8Vg9-CwvU-u9gNGmtB7gTapuCPHjU5v7FWnPsVy6vptA@mail.gmail.com>
Subject: Re: [PATCH v3 3/4] arm64: implement live patching
To:     Miroslav Benes <mbenes@suse.cz>
Cc:     Jessica Yu <jeyu@kernel.org>, Torsten Duwe <duwe@lst.de>,
        Will Deacon <will.deacon@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Julien Thierry <julien.thierry@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Ingo Molnar <mingo@redhat.com>, Arnd Bergmann <arnd@arndb.de>,
        AKASHI Takahiro <takahiro.akashi@linaro.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        live-patching@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19 October 2018 at 23:21, Miroslav Benes <mbenes@suse.cz> wrote:
>
>> >> Ad relocations. I checked that everything in struct mod_arch_specific
>> >> stays after the module is load. Both core and init get SHF_ALLOC set
>> >> (mod->arch.core.plt->sh_flags in module_frob_arch_sections(). It is
>> >> important because apply_relocate_add() may use those sections
>> >> through module_emit_plt_entry() call.
>> >
>> >
>> > Yes, it looks like the needed .plt sections will remain in module
>> > memory. However, I think I found a slight issue... :/
>> >
>> > In module_frob_arch_sections(), mod->arch.core.plt is set to an offset
>> > within info->sechdrs:
>> >
>> >             if (!strcmp(secstrings + sechdrs[i].sh_name, ".plt"))
>> >                     mod->arch.core.plt = sechdrs + i;
>> >
>> > sechdrs is from info->sechdrs, which is freed at the end of
>> > load_module() via free_copy(). So although the relevant plt section(s)
>> > are in module memory, mod->arch.core.plt will point to invalid memory
>> > after info is freed. In other words, the section (.plt) *is* in memory
>> > but the section header (struct elf64_shdr) containing section metadata
>> > like sh_addr, sh_size etc., is not.
>> >
>>
>> Just for my understanding: this only matters for live patching, right?
>
> Yes. Live patching can do deferred relocations. When a module is loaded
> and livepatched, the relevant symbols in the patching module are resolved.
> We call apply_relocate_add(), which is arch-specific, and we must be sure
> that everything used by apply_relocate_add() is preserved in the patching
> module after it is loaded.
>

So I suppose this could get interesting in cases where modules are far
away from the kernel (i.e., more than -/+ 128 MB). Fortunately, the
modules themselves are always placed in a 128 MB window, but this
window could be out of reach for branches into the kernel proper. If
we find ourselves in the situation where we need to patch calls into
the kernel proper to point into this module, this may get interesting,
since the PLT entries *must* be allocated along with the module that
contains the branch instruction, or the PLT entry itself may be out of
range, defeating the purpose.


>> The original PLT support was implemented to support loading modules
>> outside of the -/+ 128 MB range of an arm64 relative branch/jump
>> instruction, and was later enhanced [for the same reason] to support
>> emitting a trampoline for the ftrace entrypoint.
>
> Regards,
> Miroslav
