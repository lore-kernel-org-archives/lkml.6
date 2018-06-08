Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id OhrBGLxUGlvNLAAAmS7hNA
	; Fri, 08 Jun 2018 10:04:44 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 3F16F608B8; Fri,  8 Jun 2018 10:04:44 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZZeVFd1c"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FROM,MAILING_LIST_MULTI autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 95B38606FA;
	Fri,  8 Jun 2018 10:04:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 95B38606FA
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751682AbeFHKEl (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Fri, 8 Jun 2018 06:04:41 -0400
Received: from mail-lf0-f67.google.com ([209.85.215.67]:34985 "EHLO
        mail-lf0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751171AbeFHKEi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jun 2018 06:04:38 -0400
Received: by mail-lf0-f67.google.com with SMTP id i15-v6so8882515lfc.2;
        Fri, 08 Jun 2018 03:04:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:reply-to:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=jSVFmCIstgxTvIHeeh5jFL/irn6oLR3YhxJmL2f5rug=;
        b=ZZeVFd1c+NWMvMya6uyvfCYAe9B6kMrTslF0AU8F34F4uDS7UM2cIx1Bt+L/b6V9QQ
         YitlC/e2P783278kOP0NnOp0zSwdGQFUzYZxitPuSjaZc9k2SM5Lgirj2Rp7pmwMJECc
         oTZyD7PPriKOJGoi4lH1Ymch7BybZcCBTX1g2/6P3lPhvbBBcfAf2e351YQE+ad56ORx
         b94aqKHG8yVcCLZU7cRkhsJEV9PYQKnV2NA/evXeuVF1TwTAbc435bgmHYu5kzEKpJra
         0hS7baYtS0aszS01anR/hK+EpTzgZqJUtJKwmo+bm1Y4zFD/vx8NW7oL1qHPy9M1Yxpg
         j1UQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:reply-to:in-reply-to:references
         :from:date:message-id:subject:to:cc;
        bh=jSVFmCIstgxTvIHeeh5jFL/irn6oLR3YhxJmL2f5rug=;
        b=SH+/AbFKep37xd4toeZgBAaT7MI2XnugW/ZPvG3zATaXGEyt06xJIgtyjkYc9IPqOf
         RjNTGsWsIkV0KmIwTKtv79UQe6JXgAjKUBzrUFrwR+lKdh0+SQQr+QwjZYRnlG7Duoxy
         pxLJi6fNfgDMA4KdApKSmBSHvzStAwlrzRCtuMvpl95bEoa7gS9FSiyEUR9cDzadOj74
         jw8ZgbuzlVPoS51EEb7HlTpIAW2StsFB9HqV7uacHBKDdm113QdgqJ0RCs9gs4npK2V9
         wJ4GDuSZYvw6HEjoktFRJvXl4JqC7YHMv1rYS0Qt1eWYrLdEG6X9OWUxU9b/mJSAAaOW
         1E6A==
X-Gm-Message-State: APt69E3/p15hsGTfYY7vtk9FRPegJ42q4dk9tnDLT9tFvCqMAgsIaDl+
        kpuD+nWjfmB7gTKBoTZc2GRuMvxnsx0PgshdNJM=
X-Google-Smtp-Source: ADUXVKKluCZkr8IrhOczBOPz95Lrwlmr4IsHfF+IEaJm7yI9tT4EPYPPn3Qo3x8EymI0XP/7eQ5MNuQOj7RYqU6wb3Y=
X-Received: by 2002:a2e:994f:: with SMTP id r15-v6mr3947319ljj.53.1528452276678;
 Fri, 08 Jun 2018 03:04:36 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a19:b87:0:0:0:0:0 with HTTP; Fri, 8 Jun 2018 03:04:36 -0700 (PDT)
Reply-To: sedat.dilek@gmail.com
In-Reply-To: <CAK8P3a0yi+MrOS=+pjCeUu==YBE_AppB8vfqdsQS-1NpSO2c4A@mail.gmail.com>
References: <20180607204927.219329-1-ndesaulniers@google.com>
 <20180607204927.219329-2-ndesaulniers@google.com> <CAK8P3a0yi+MrOS=+pjCeUu==YBE_AppB8vfqdsQS-1NpSO2c4A@mail.gmail.com>
From: Sedat Dilek <sedat.dilek@gmail.com>
Date: Fri, 8 Jun 2018 12:04:36 +0200
Message-ID: <CA+icZUXDoeo5ktZZPFcFyLzk3xthM-98N88QJFzesg6t+Vr5cQ@mail.gmail.com>
Subject: Re: [PATCH v4 1/3] compiler-gcc.h: add gnu_inline to all inline declarations
To: Arnd Bergmann <arnd@arndb.de>
Cc: Nick Desaulniers <ndesaulniers@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-efi@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        virtualization@lists.linux-foundation.org, astrachan@google.com,
        Manoj Gupta <manojgupta@google.com>,
        Greg Hackmann <ghackmann@google.com>, tstellar@redhat.com,
        Kees Cook <keescook@google.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Michal Marek <michal.lkml@markovi.net>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Will Deacon <will.deacon@arm.com>, mawilcox@microsoft.com,
        David Rientjes <rientjes@google.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Jan Kiszka <jan.kiszka@siemens.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        akataria@vmware.com, Brijesh Singh <brijesh.singh@amd.com>,
        Cao jin <caoj.fnst@cn.fujitsu.com>,
        gregkh <gregkh@linuxfoundation.org>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Juergen Gross <jgross@suse.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Matthias Kaehlcke <mka@chromium.org>,
        "Lendacky, Thomas" <thomas.lendacky@amd.com>,
        Thiebaud Weksteen <tweek@google.com>, mjg59@google.com,
        Joe Perches <joe@perches.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 8, 2018 at 9:59 AM, Arnd Bergmann <arnd@arndb.de> wrote:
> On Thu, Jun 7, 2018 at 10:49 PM, Nick Desaulniers
> <ndesaulniers@google.com> wrote:
>> Functions marked extern inline do not emit an externally visible
>> function when the gnu89 C standard is used. Some KBUILD Makefiles
>> overwrite KBUILD_CFLAGS. This is an issue for GCC 5.1+ users as without
>> an explicit C standard specified, the default is gnu11. Since c99, the
>> semantics of extern inline have changed such that an externally visible
>> function is always emitted. This can lead to multiple definition errors
>> of extern inline functions at link time of compilation units whose build
>> files have removed an explicit C standard compiler flag for users of GCC
>> 5.1+ or Clang.
>>
>> Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>
>> Suggested-by: H. Peter Anvin <hpa@zytor.com>
>> Suggested-by: Joe Perches <joe@perches.com>
>
> I suspect this will break Geert's gcc-4.1.2, which I think doesn't have that
> attribute yet (4.1.3 or higher have it according to the documentation.
>
> It wouldn't be hard to work around that if we want to keep that version
> working, or we could decide that it's time to officially stop supporting
> that version, but we should probably decide on one or the other.
>

Good point.
What is the minimum requirement of GCC version currently?
AFAICS x86/asm-goto support requires GCC >= 4.5?

Just FYI...
...saw the last days in upstream commits that kbuild/kconfig for
4.18-rc1 offers possibilities to check for cc-version dependencies.

- sed@ -
