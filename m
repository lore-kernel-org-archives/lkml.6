Return-Path: <keescook@google.com>
ARC-Seal: i=1; a=rsa-sha256; t=1523343605; cv=none;
        d=google.com; s=arc-20160816;
        b=PJyf/bH8rEi6W8J324YlOvfci2LP00NmlVGlsNeTuc7E1JmOVIhr4LbLF2lj5AQ0AN
         SFvgigAMMNBR/wM4bS1qgxfhismY9s9XBVCUBixdlyYAd2XjVwtBNEbdY8WxCTp22LPW
         DcU1pbRo6Xf6x0TUS9kYYkJZH0DwcC0pmyfI7Ti2q8OwVeAfldqV/x3S57sJKQxBXUNT
         AVOjnfnOu/ZB8UkkYYsjtZ5i93S268/wjhJdcpd9NOT+Nopjvbcgx60Z0OlYaPmMSj9x
         Nhvy8olM900yxwNJ/Ir46PAeXw+ZlOLzFfVvkyNZ3oR3ednynjrZ9HPLsKt1ZqTNC6Ei
         +YWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to:sender
         :mime-version:dkim-signature:dkim-signature
         :arc-authentication-results;
        bh=k3PlbSDWv6jGtpA88lrjIUQvV5howHbbXGnJOtTsWwc=;
        b=YxZWjkJonVOrgtLB4GY1QYldQGDmjYF/9n2eg4B3qfs+C7dAaTf6a8rsSowQkiGrhp
         qGuPBCqXOonP8qcQ41XOAhmPMNYed8bmNL5p+hrDXxUy98vWBwToXMJQmOBoYUrzwWr4
         oLdnz3vEMeSP4ngIM9JeKFxgNvvfwkWKEpbbhG7Me2z4l+1NYNRc1dtad8bdLXZ2nh0k
         vOVJGibW9P4fUrxSIs+iiTmv3opPiHbfD5HJTb7b32BV2WrkqEyCQ6PrZRWQLMfs2Fhq
         QRUpNdKtujswMvdj9S4ahQCIIfnxKgOKO4xZI0hW+9/yfhZlqMKWajtCS79XKuKKg1RL
         s8BQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@google.com header.s=20161025 header.b=QKp4IoVx;
       dkim=pass header.i=@chromium.org header.s=google header.b=fjrjYHE+;
       spf=pass (google.com: domain of keescook@google.com designates 209.85.220.41 as permitted sender) smtp.mailfrom=keescook@google.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=chromium.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@google.com header.s=20161025 header.b=QKp4IoVx;
       dkim=pass header.i=@chromium.org header.s=google header.b=fjrjYHE+;
       spf=pass (google.com: domain of keescook@google.com designates 209.85.220.41 as permitted sender) smtp.mailfrom=keescook@google.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=chromium.org
X-Google-Smtp-Source: AIpwx48mYPHlncPEB/CEW0u7teO9c7iL1ivlSLw6aCb1KmYH2F6cO17cH8Pjjrkr4uRVHKtMlJLe/fuF5XqHaX1b5lo=
MIME-Version: 1.0
Sender: keescook@google.com
In-Reply-To: <CAK7LNATJidxieoNoo=CTk_-BpKJv8dwq+q1MAmsRDivd6ZrotQ@mail.gmail.com>
References: <1522128575-5326-1-git-send-email-yamada.masahiro@socionext.com>
 <1522128575-5326-21-git-send-email-yamada.masahiro@socionext.com>
 <CAGXu5jJQfYXqsF7pcRsUtY9Mrw+Yi_Y6+CBAwDrQT_4kpUiHDA@mail.gmail.com> <CAK7LNATJidxieoNoo=CTk_-BpKJv8dwq+q1MAmsRDivd6ZrotQ@mail.gmail.com>
From: Kees Cook <keescook@chromium.org>
Date: Tue, 10 Apr 2018 00:00:03 -0700
X-Google-Sender-Auth: muSlbXOrKizUz7v04dGKHko29is
Message-ID: <CAGXu5jLTzqe3MVZnY+SOrreUBUZZOsEDsZNuS66ZxXjRzywv3A@mail.gmail.com>
Subject: Re: [PATCH v2 20/21] gcc-plugins: enable GCC_PLUGINS for COMPILE_TEST
To: Masahiro Yamada <yamada.masahiro@socionext.com>
Cc: linux-kbuild <linux-kbuild@vger.kernel.org>, Sam Ravnborg <sam@ravnborg.org>,
	Linus Torvalds <torvalds@linux-foundation.org>, Arnd Bergmann <arnd@arndb.de>,
	Ulf Magnusson <ulfalizer@gmail.com>, Thomas Gleixner <tglx@linutronix.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Randy Dunlap <rdunlap@infradead.org>,
	"Luis R . Rodriguez" <mcgrof@kernel.org>, Nicolas Pitre <nico@linaro.org>, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1596067568210936951?=
X-GMAIL-MSGID: =?utf-8?q?1597341543948529115?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Mon, Apr 9, 2018 at 11:15 PM, Masahiro Yamada
<yamada.masahiro@socionext.com> wrote:
> Can you explain a bit more about GCC_PLUGIN_RANDSTRUCT_PERFORMANCE?
>
> IIUC, this option reduces the randomization.

Correct: I don't want to do COMPILE_TEST buids with
GCC_PLUGIN_RANDSTRUCT_PERFORMANCE since it is effectively a subset of
the GCC_PLUGIN_RANDSTRUCT possibilities. So, ..._PERFORMANCE shouldn't
be enabled for COMPILE_TEST, as that would reduce the coverage for
buid tests.

-Kees

-- 
Kees Cook
Pixel Security
