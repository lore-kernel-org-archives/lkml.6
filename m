Return-Path: <keescook@google.com>
ARC-Seal: i=1; a=rsa-sha256; t=1522236567; cv=none;
        d=google.com; s=arc-20160816;
        b=0X7rfwFHTn4D81rax47EI2U13xAvn+2jdxzK/OusaP+q3RYe+AfDxXNjPPdEayE8t8
         YvGF2MotD2lvsRopMdiX6KkuG3/C1uZrydL7TnPhNPSo8gvijI6MOY8jl7eJjmM/t7ua
         0w3Rre0vrJZ9TVOo0tfcTmJUCl2yjyQjE0bjuOODrckBkxt2AuiTkVgTP9V/7kK5enLc
         lVzfSvSFozXHOw4Zu2Jr8c+OQuYEOQUi3ZLv5ZbUjnkAcPCwIipL78APKPAbgOM6x7M/
         EK36yDZWRCPNsksiM6BqKZPh01eWaZiWuSQz+go0iC4BCvBLpRAw2FK+PMgapvD+eNLH
         BFqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to:sender
         :mime-version:dkim-signature:dkim-signature
         :arc-authentication-results;
        bh=aSkURl5T8gHt9bEVKRik11TFkcFenDgmmwBCiuMUyss=;
        b=PQnlw4lcLts3d8JCbRdeLxmnVq5cnt54VLKlQOqX9outqEpwYJrKGPDm0Q+mxEQiGh
         /d2YUWEzS/FWjBx2hqhYRa1ImMttwdjArVgOoaIxWWT9RVxzYho5T+9ga0g2uPqUmviH
         FGAKJzbk+j9RtCJ+OC8em8DHfzAW9cqZQ/1U6ZeJdLoJLQ2+0LeGFG0NenbFhZGNfPdj
         ObRffUSA0FPaTvQ5bMLnsksEjuOaucMMHim6KBpbspIPDFfr0gObD9cfxnbLkJEFC5tX
         DkTGgYvVf/vnj6Web3/5/wfQXX+HW1mJpTPcPthfFC6xlE+tbA8VkU9FM682lMhEGfIn
         Lrag==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@google.com header.s=20161025 header.b=fA3vzy3/;
       dkim=pass header.i=@chromium.org header.s=google header.b=RU1+gSUk;
       spf=pass (google.com: domain of keescook@google.com designates 209.85.220.41 as permitted sender) smtp.mailfrom=keescook@google.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=chromium.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@google.com header.s=20161025 header.b=fA3vzy3/;
       dkim=pass header.i=@chromium.org header.s=google header.b=RU1+gSUk;
       spf=pass (google.com: domain of keescook@google.com designates 209.85.220.41 as permitted sender) smtp.mailfrom=keescook@google.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=chromium.org
X-Google-Smtp-Source: AIpwx49yICatOxbgChMtGZ6QTyAhJtjTSxgihMNeqou7yVYNFhb9G8lbJlAfuUqOuGXmOIie5CnW8h8QgVSRsAA9YD0=
MIME-Version: 1.0
Sender: keescook@google.com
In-Reply-To: <1522128575-5326-18-git-send-email-yamada.masahiro@socionext.com>
References: <1522128575-5326-1-git-send-email-yamada.masahiro@socionext.com> <1522128575-5326-18-git-send-email-yamada.masahiro@socionext.com>
From: Kees Cook <keescook@chromium.org>
Date: Wed, 28 Mar 2018 04:29:26 -0700
X-Google-Sender-Auth: uQVeCtX-YnRVFF7BOS687idrrgA
Message-ID: <CAGXu5j+mJeG+POhgPkoanX8SVnY0LvTDoBUsyTNGpKh0KYiHMQ@mail.gmail.com>
Subject: Re: [PATCH v2 17/21] gcc-plugins: always build plugins with C++
To: Masahiro Yamada <yamada.masahiro@socionext.com>
Cc: linux-kbuild <linux-kbuild@vger.kernel.org>, Sam Ravnborg <sam@ravnborg.org>,
	Linus Torvalds <torvalds@linux-foundation.org>, Arnd Bergmann <arnd@arndb.de>,
	Ulf Magnusson <ulfalizer@gmail.com>, Thomas Gleixner <tglx@linutronix.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Randy Dunlap <rdunlap@infradead.org>,
	"Luis R . Rodriguez" <mcgrof@kernel.org>, Nicolas Pitre <nico@linaro.org>, LKML <linux-kernel@vger.kernel.org>,
	Kernel Hardening <kernel-hardening@lists.openwall.com>, Emese Revfy <re.emese@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1596067545463713502?=
X-GMAIL-MSGID: =?utf-8?q?1596180730922821685?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Mon, Mar 26, 2018 at 10:29 PM, Masahiro Yamada
<yamada.masahiro@socionext.com> wrote:
> If the target compiler is GCC 4.8 or newer, plugins are compiled with
> HOSTCXX.  Otherwise, gcc-plugin.sh will select HOSTCC or HOSTCXX.
>
> To simplify things, drop the HOSTCC support for plugins.  If you use
> GCC plugins, the requirement for the target compiler is GCC 4.8 (or
> older compiler with necessary features backported).  This is a feature
> for advanced users, so this requirement would not be a big deal.
> Currently, building plugins requires GCC 4.5, so this is not a big jump.

Emese already NAKed this, and I'd agree. 4.5 to 4.8 is quite a jump
(see all the threads on minimum gcc versions). Until we're at 4.8 as a
minimum, let's leave this as-is. "To simply things" doesn't seem like
a good enough reason to me.

-Kees

-- 
Kees Cook
Pixel Security
