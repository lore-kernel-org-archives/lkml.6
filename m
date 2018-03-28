Return-Path: <keescook@google.com>
ARC-Seal: i=1; a=rsa-sha256; t=1522236160; cv=none;
        d=google.com; s=arc-20160816;
        b=CJNlqu5rGdl4mNa9gZtZlje9tSkkBUub+CM+0O+0fy3LOZizmLPrNuJJig06eZCHUZ
         B8I1o8xABv1mSLdnwNQVztPzBaB69uO+KgjZd+WURJ8xnhm31B+NIf4+lQs01R5+14MR
         9UX9tr5Wcw7Q+vRZLebTjqZ45T3fkhh73ROBu2Db8QtbECZhEMml37gNCoo+PHceaqRi
         lODyKvI/269ZPZyRXTq9spsRD0V/uClBP5pWTVJeGvk2ThB4TNc3Z3CchsVtoGi0RRnz
         0adqFynZw4h6R4cGeFrEdR7WqVNejvUaM8LnCK7O4P8MOVyZo1iRXHanYG8+MKzs9/Nc
         5+lQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to:sender
         :mime-version:dkim-signature:dkim-signature
         :arc-authentication-results;
        bh=9cCbaSxu18MYfiTHQnKweBQY7aVfoGzaSLybdYxd2XA=;
        b=cpOD7rN2hDpcGT7QtU/W/0wHrj+JWm//7vdCBgLLPwTbCif2K9dZnHHWk8cuOd/gwu
         JtIkSpZvusT5jmGzh0qPqnv0jGzpmGl0VlT9cFEZWipGl8sxA0DuC0ZlDkCY4hLXVTvN
         68/aS07vMY58/EoIbVyaoYGpEqw1n+NfYF+XLTFOjVj/ekmbpeqOVksKwH4J+uRLlsLp
         AiBO0iOW1k4abX3E/6MvrCE0ga/dT8FdSY+rpXh/oE3Ma2eicxhc1hkfVRGJmQ5ecy0o
         tPoBdktEr/+vQ/xgy8W6Wq3cko5enEWm//9pShZpFfsg7znAQ2V/LVJMg2ZUj7SHmttX
         LMUw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@google.com header.s=20161025 header.b=HinmdSrY;
       dkim=pass header.i=@chromium.org header.s=google header.b=UeI9jUUz;
       spf=pass (google.com: domain of keescook@google.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=keescook@google.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=chromium.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@google.com header.s=20161025 header.b=HinmdSrY;
       dkim=pass header.i=@chromium.org header.s=google header.b=UeI9jUUz;
       spf=pass (google.com: domain of keescook@google.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=keescook@google.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=chromium.org
X-Google-Smtp-Source: AIpwx484DiqE7Q8x/+C2HpNegmSKDwxSvYaQIitvcNeWg882MciEI9RgvQAdEwA8+VDM/T6D6OWzmKxAE5SYe9bTrz0=
MIME-Version: 1.0
Sender: keescook@google.com
In-Reply-To: <1522128575-5326-15-git-send-email-yamada.masahiro@socionext.com>
References: <1522128575-5326-1-git-send-email-yamada.masahiro@socionext.com> <1522128575-5326-15-git-send-email-yamada.masahiro@socionext.com>
From: Kees Cook <keescook@chromium.org>
Date: Wed, 28 Mar 2018 04:22:38 -0700
X-Google-Sender-Auth: 5AkiNJO8ctLEpfVHwuhplHy8dj8
Message-ID: <CAGXu5jK48XYSpga0M-49GPrMT3iud7rqEOD7ZpKQR-MXi=zjWw@mail.gmail.com>
Subject: Re: [PATCH v2 14/21] kconfig: add CC_IS_CLANG and CLANG_VERSION
To: Masahiro Yamada <yamada.masahiro@socionext.com>
Cc: linux-kbuild <linux-kbuild@vger.kernel.org>, Sam Ravnborg <sam@ravnborg.org>,
	Linus Torvalds <torvalds@linux-foundation.org>, Arnd Bergmann <arnd@arndb.de>,
	Ulf Magnusson <ulfalizer@gmail.com>, Thomas Gleixner <tglx@linutronix.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Randy Dunlap <rdunlap@infradead.org>,
	"Luis R . Rodriguez" <mcgrof@kernel.org>, Nicolas Pitre <nico@linaro.org>, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1596067545333051904?=
X-GMAIL-MSGID: =?utf-8?q?1596180304160726172?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Mon, Mar 26, 2018 at 10:29 PM, Masahiro Yamada
<yamada.masahiro@socionext.com> wrote:
> This will be useful to describe the clang version dependency.
>
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>

One aspect of clang version checking that may be "weird" (and likely
won't be meaningful for very long as we're about to raise the minimum
gcc version), is that clang claims to be gcc version 4.2 if you look
at #defines. This is already handled in compiler.h, but may be weird
in Kconfig.

Regardless:

Reviewed-by: Kees Cook <keescook@chromium.org>

-Kees

-- 
Kees Cook
Pixel Security
