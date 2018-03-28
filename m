Return-Path: <keescook@google.com>
ARC-Seal: i=1; a=rsa-sha256; t=1522208132; cv=none;
        d=google.com; s=arc-20160816;
        b=EGT2R3x5qfIjwZzFHS+3IhI2090DjVkd0ZE5RH1j9bFLeE88reNUFQbKWS+Q6SzrJJ
         GLlvZX3ik+BZCtYSIgcfQYBvDCyre01058xc77ZQ8UVI1+kRnzMQbC692zJcazY2aYwl
         rzGcctmEFLSeSmIC6guKXNDO6zaYDHpwUo/CeUotklD+YAtA+PoVHIgW3z0V+1nHMSTL
         L+OEvSUwuAMHQQqhI1ABCO9vrbAIFsk19iGbAQj5yXW1yJibqLrVLS/ia8z4ZZEgTK9E
         xkvwvDgpBILf9IFMgAhodCuexY8INl1nuJUxlzVQs+inJ59e7Gj8ALdwL6WIhTIqo2TF
         DeGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to:sender
         :mime-version:dkim-signature:dkim-signature
         :arc-authentication-results;
        bh=3iKK5I+9IlUYodw3CwoC2wydn5y1iLId2czIN7CC7Bw=;
        b=YSLZ7IM/UnAhYbFrdriE8M9XzQu/s6UbFKiQNCLs82gZYyrjd3FEQ65D44hbQfMPjx
         r/fU5TgRAD+KpId0C2ObpXJj96kUHn3a+6Q83k521Bnhk4g28apHwXxUBZp84Tj1ZMNf
         nKxoUYF9BvfjCv4902YNkHQ33GQdAxPoHVgUOXipTPY2hH+U605iYGL62oe/2sSYTH3t
         v9def0giR52ps7Cc3XtCVwAAXzmTJ6jKc3MngHo9K7lMvDlUEKYV+hExHGngrlQxEW7b
         588uokReYweQQNbDOC7SKvNVsBlmjQdc3dABkM/hork/1NKSNImSpK4lldrDSdueLIFQ
         YYBA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@google.com header.s=20161025 header.b=I3nPE8Gc;
       dkim=pass header.i=@chromium.org header.s=google header.b=jp6qiX0o;
       spf=pass (google.com: domain of keescook@google.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=keescook@google.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=chromium.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@google.com header.s=20161025 header.b=I3nPE8Gc;
       dkim=pass header.i=@chromium.org header.s=google header.b=jp6qiX0o;
       spf=pass (google.com: domain of keescook@google.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=keescook@google.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=chromium.org
X-Google-Smtp-Source: AIpwx495yUtLVT7uQ4tXw/gqHpJ9QSuoLjPcAnNAs3zcm6bjQzsIqEUYI5+42mfcO2DaY9nm0Q+CWQJ8CxETdnPZwgI=
MIME-Version: 1.0
Sender: keescook@google.com
In-Reply-To: <1522128575-5326-7-git-send-email-yamada.masahiro@socionext.com>
References: <1522128575-5326-1-git-send-email-yamada.masahiro@socionext.com> <1522128575-5326-7-git-send-email-yamada.masahiro@socionext.com>
From: Kees Cook <keescook@chromium.org>
Date: Tue, 27 Mar 2018 20:35:31 -0700
X-Google-Sender-Auth: Ku9deh7dTf-NZnXa2r7Xzg8O04w
Message-ID: <CAGXu5jK-MtuYre2LB7=9ewFDPntv6p03PCmra9cQW57f293rTA@mail.gmail.com>
Subject: Re: [PATCH v2 06/21] kconfig: remove string expansion for mainmenu
 after yyparse()
To: Masahiro Yamada <yamada.masahiro@socionext.com>
Cc: linux-kbuild <linux-kbuild@vger.kernel.org>, Sam Ravnborg <sam@ravnborg.org>,
	Linus Torvalds <torvalds@linux-foundation.org>, Arnd Bergmann <arnd@arndb.de>,
	Ulf Magnusson <ulfalizer@gmail.com>, Thomas Gleixner <tglx@linutronix.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Randy Dunlap <rdunlap@infradead.org>,
	"Luis R . Rodriguez" <mcgrof@kernel.org>, Nicolas Pitre <nico@linaro.org>, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1596067537936435253?=
X-GMAIL-MSGID: =?utf-8?q?1596150915247961663?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Mon, Mar 26, 2018 at 10:29 PM, Masahiro Yamada
<yamada.masahiro@socionext.com> wrote:
> Now that environments are expanded in the lexer, conf_parse() does
> not need to explicitly expand $ARCH and $KERNELVERSION in the mainmenu.
>
> The hack introduced by commit 0724a7c32a54 ("kconfig: Don't leak
> main menus during parsing") can go away.
>
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>

Reviewed-by: Kees Cook <keescook@chromium.org>

-Kees

-- 
Kees Cook
Pixel Security
