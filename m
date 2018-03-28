Return-Path: <keescook@google.com>
ARC-Seal: i=1; a=rsa-sha256; t=1522236255; cv=none;
        d=google.com; s=arc-20160816;
        b=XnXRTpTUjNdFvGW3diJtk1rlNUBrHldnHBDVzVMefDMFe9ZkigSEj7NuqgqyWKG/Ok
         0UMbbyUfZLpa4slO/svjWwwAOazoRLwr2qVX0+S0OiMoyOBRlsPpCel4cceRcy8FlFhD
         EuohKH5JXP4qp7sbNRLLzCXDVuRPiNzkazQWCE/hvgohj4G4LwOPdLvQtQonZCxBT0Dx
         CPSm+lkG6v4smcvwvf711i8t2XJChHiRUYs+luHb4e8HJDvCMDZ1hv2dnL8wROyUbhHx
         idHr2mb01/8lY0Au24IfTFEsuQwlWteliZqLEMkgVyaLme2jy4cQ1P9hQAoaYm+8J3wM
         GuIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to:sender
         :mime-version:dkim-signature:dkim-signature
         :arc-authentication-results;
        bh=o/Z4dCPT3qmNSrQ9M1UUFQkKNGvlSpqUVYB3mMXJrik=;
        b=eBaKJEpuZsiaujVVH6+TZnmfH2rPObRXViCqLBBLLCInjmAzUzxcTDpK5POhkeLRYz
         27TlwUK35DCL/1n1UdJDcy7nTaWEGedoo+CJa5lQVBEKV9P7iV1kgtndOQgBxH3iTfS/
         nDOS88tKGbrYg7rmBIyB4Dn37JVpuR5LcjGqALCWwQfnDXWLoIU28PJe/c2VkYaEkDcu
         +yyCBGw1Qz9QJLkpdcnkSforCNV0ucoamctu2zae1z/vewjcS54SgGsyqfnApsgPhYbI
         KR16mRRWcmF93smoxVHMVLZfL87IZQaft0HrMNsXpkEncBmLEuRT+2avZquqi1/em8Wn
         yGzQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@google.com header.s=20161025 header.b=BgfhQAyH;
       dkim=pass header.i=@chromium.org header.s=google header.b=ARxs5lpB;
       spf=pass (google.com: domain of keescook@google.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=keescook@google.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=chromium.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@google.com header.s=20161025 header.b=BgfhQAyH;
       dkim=pass header.i=@chromium.org header.s=google header.b=ARxs5lpB;
       spf=pass (google.com: domain of keescook@google.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=keescook@google.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=chromium.org
X-Google-Smtp-Source: AIpwx4+C8ufaJgLCEDMvpNJb4HyIUaojrmcqUO+6L17629O89Dj9oheIG+6yVN3CeG3ZC5BvK1v4CVuKkQVGF8Cfywk=
MIME-Version: 1.0
Sender: keescook@google.com
In-Reply-To: <1522128575-5326-16-git-send-email-yamada.masahiro@socionext.com>
References: <1522128575-5326-1-git-send-email-yamada.masahiro@socionext.com> <1522128575-5326-16-git-send-email-yamada.masahiro@socionext.com>
From: Kees Cook <keescook@chromium.org>
Date: Wed, 28 Mar 2018 04:24:14 -0700
X-Google-Sender-Auth: G6nIXhw3f5TQlLXE2upj6jZWERg
Message-ID: <CAGXu5jLmyp4Q9VeP-F3N2SJuUxPpo3=2WTUC4vRLX348FwrtUQ@mail.gmail.com>
Subject: Re: [PATCH v2 15/21] gcov: remove CONFIG_GCOV_FORMAT_AUTODETECT
To: Masahiro Yamada <yamada.masahiro@socionext.com>
Cc: linux-kbuild <linux-kbuild@vger.kernel.org>, Sam Ravnborg <sam@ravnborg.org>,
	Linus Torvalds <torvalds@linux-foundation.org>, Arnd Bergmann <arnd@arndb.de>,
	Ulf Magnusson <ulfalizer@gmail.com>, Thomas Gleixner <tglx@linutronix.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Randy Dunlap <rdunlap@infradead.org>,
	"Luis R . Rodriguez" <mcgrof@kernel.org>, Nicolas Pitre <nico@linaro.org>,
	Peter Oberparleiter <oberpar@linux.vnet.ibm.com>, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1596067545713412850?=
X-GMAIL-MSGID: =?utf-8?q?1596180404143320042?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Mon, Mar 26, 2018 at 10:29 PM, Masahiro Yamada
<yamada.masahiro@socionext.com> wrote:
> CONFIG_GCOV_FORMAT_AUTODETECT compiles either gcc_3_4.c or gcc_4_7.c
> according to your GCC version.
>
> We can achieve the equivalent behavior by setting reasonable dependency
> with the knowledge of the compiler version.
>
> If GCC older than 4.7 is used, GCOV_FORMAT_3_4 is the default, but users
> are still allowed to select GCOV_FORMAT_4_7 in case the newer format is
> back-ported.
>
> On the other hand, If GCC 4.7 or newer is used, there is no reason to
> use GCOV_FORMAT_3_4, so it should be hidden.
>
> If you down-grade your compiler GCC 4.7 or older, oldconfig/syncconfig
> will display a prompt for the choice because GCOV_FORMAT_3_4 becomes
> visible as a new symbol.
>
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>

Reviewed-by: Kees Cook <keescook@chromium.org>

-Kees

-- 
Kees Cook
Pixel Security
