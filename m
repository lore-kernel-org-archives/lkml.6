Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id 6aOzLYI3GlsWVQAAmS7hNA
	; Fri, 08 Jun 2018 08:00:05 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 0B531608CD; Fri,  8 Jun 2018 08:00:04 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d838tQWi"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	MAILING_LIST_MULTI,T_DKIM_INVALID autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 54A61608D2;
	Fri,  8 Jun 2018 08:00:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 54A61608D2
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751636AbeFHIAA (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Fri, 8 Jun 2018 04:00:00 -0400
Received: from mail-lf0-f66.google.com ([209.85.215.66]:42978 "EHLO
        mail-lf0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751021AbeFHH76 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jun 2018 03:59:58 -0400
Received: by mail-lf0-f66.google.com with SMTP id v135-v6so18655092lfa.9;
        Fri, 08 Jun 2018 00:59:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=c9DCGq6F6/aGX0s9sD9bjpX/SvTHtx05rXottLKSBcY=;
        b=d838tQWiAWp2sxNsi9gPNVR6VHDnOyV0k4f55+vbZDWkwWdK3Qz/pEwUlNpdvlt5Rm
         i5Q8Ac8smme5/xtPeHWXNlm6WDzfruN81zP2KtgXv0+oNJZGO7uJPFfCEIUe42aenfCU
         9l6jEbKWhItaEJxco8cCAQRR4+Vjugi6Ooiu4ZkX01CYkoMW4OhnHOYdre71cfCm7Hz5
         b/muhlo+hyZ7lb3odBNLICwQDzffEWtam6T2ykb39ovB8gHAQo9XZhtuDJbVIh4JW/1u
         jSTBxo/pIajSEgdKcEVjq4zxVgec7P4IPZk+QwKMzm2RePgUjQ3AZLQugPcwCEL8M93r
         R1Rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=c9DCGq6F6/aGX0s9sD9bjpX/SvTHtx05rXottLKSBcY=;
        b=Ey9h3KfvPyZ8elloHgEpUUdzAlt3DN9K9GwT8wQYIXnOEZjB9FKhsGEbK7XEa4uFZt
         ZFDxJOJwMgS/k9ssQAchalOeCsXgcBLKctHfpCyHz1MeDsvMfZO6PX/LFFWtmihPYYy1
         UWFWtV0fxqzAvbV3p3enAUOXnAHy5mGcQ1om5gVr+kmNBSRmeG92n0z3PtGJBzRWQMsg
         QvAC1BTIfpD0TBpuPzjFCTQT/kkdTYhVftdkUjv445Gf4iUIgpw/M6DLY6XPrLzJpGcP
         kjni4TfT7g+y1gt8MNgzf4yYhw0pV40ft7EItm8DUWz01zPd5/4LmSMvqXHrZnMCArkm
         zLHg==
X-Gm-Message-State: APt69E20YvfEzxrXF8HCf1s6P7wHyRoHD6IyiTFqQOpHezSLuM7R5a9p
        G/2ohjm1tErwmX2zgrRmmVz7wMgQ4KlQmETJicc=
X-Google-Smtp-Source: ADUXVKLggl5YQlwiAG9F/4YqQnLfMOl0mQ68bf6nIMM48MBXLvkX90bKPeOJ5FWOZNzavcVxb9+uG1UR3AHHqemwhbw=
X-Received: by 2002:a2e:401b:: with SMTP id n27-v6mr3876572lja.6.1528444796678;
 Fri, 08 Jun 2018 00:59:56 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a2e:56c8:0:0:0:0:0 with HTTP; Fri, 8 Jun 2018 00:59:54 -0700 (PDT)
In-Reply-To: <20180607204927.219329-2-ndesaulniers@google.com>
References: <20180607204927.219329-1-ndesaulniers@google.com> <20180607204927.219329-2-ndesaulniers@google.com>
From: Arnd Bergmann <arnd@arndb.de>
Date: Fri, 8 Jun 2018 09:59:54 +0200
X-Google-Sender-Auth: gTxtcVH0sYeduPGyrogXx2Z_0OE
Message-ID: <CAK8P3a0yi+MrOS=+pjCeUu==YBE_AppB8vfqdsQS-1NpSO2c4A@mail.gmail.com>
Subject: Re: [PATCH v4 1/3] compiler-gcc.h: add gnu_inline to all inline declarations
To: Nick Desaulniers <ndesaulniers@google.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
        "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-efi@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        virtualization@lists.linux-foundation.org, astrachan@google.com,
        Manoj Gupta <manojgupta@google.com>,
        Greg Hackmann <ghackmann@google.com>, sedat.dilek@gmail.com,
        tstellar@redhat.com, Kees Cook <keescook@google.com>,
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

On Thu, Jun 7, 2018 at 10:49 PM, Nick Desaulniers
<ndesaulniers@google.com> wrote:
> Functions marked extern inline do not emit an externally visible
> function when the gnu89 C standard is used. Some KBUILD Makefiles
> overwrite KBUILD_CFLAGS. This is an issue for GCC 5.1+ users as without
> an explicit C standard specified, the default is gnu11. Since c99, the
> semantics of extern inline have changed such that an externally visible
> function is always emitted. This can lead to multiple definition errors
> of extern inline functions at link time of compilation units whose build
> files have removed an explicit C standard compiler flag for users of GCC
> 5.1+ or Clang.
>
> Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>
> Suggested-by: H. Peter Anvin <hpa@zytor.com>
> Suggested-by: Joe Perches <joe@perches.com>

I suspect this will break Geert's gcc-4.1.2, which I think doesn't have that
attribute yet (4.1.3 or higher have it according to the documentation.

It wouldn't be hard to work around that if we want to keep that version
working, or we could decide that it's time to officially stop supporting
that version, but we should probably decide on one or the other.

        Arnd
