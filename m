Return-Path: <keescook@google.com>
ARC-Seal: i=1; a=rsa-sha256; t=1522207761; cv=none;
        d=google.com; s=arc-20160816;
        b=QXbqfx93dgPw3a6NL+UAZ/q0db74FsFy3McAXZ7Fr4cKQjybB4b9Fs3RqFDN2tzO4p
         1OFKREwtA7Gc4vwYodFCkS96Y1LzMqvm4nKGNSlapg6Gt21aTQf2f4C7fkvZUb5ZqR+G
         wo9GvObiEfbOV094ewkr+N8TE+ru32+FgqVenNll1eHqxFCj/t9k23Uv2wTwDNlIPaYi
         kLyQSOF84WTV7epVpTx+eDUXk7xaQh88q+cU/6+LXjDBd7Ey/JDhl6go1U6+T2jLDaV1
         +ClAzq960GK9SR/zI/eNGFl2/B9CIfLtFB4faiBULqD19opZ2Rf8ZN+HL1hygyLzZTcb
         PRHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to:sender
         :mime-version:dkim-signature:dkim-signature
         :arc-authentication-results;
        bh=hjwZV2swZPm+ViBmzhY+m7r/cEb+TudZ0G37TryRsvQ=;
        b=c2t9BdaRjEcSAdYB8BRbJ2HM1uOaI48qLTNQP2NSroc3tpeOCeH66GfN4vPsfwP7TR
         044fiZ+rGrzWztSJH4ml5xgij7sFtPFPkwfvQZvHbFiVzcvHucxYhOvt245hWukdNtX7
         rAo0bWyTHRwd0Rv751IVpwS6N1MpqpiFsK7S/IYeE7oSpmeC2k4i+mBtPNK9Ydz+AOJ/
         AUpo5XylsTuT8DywLjn1Yczgg+GVROP8DPOQORSb4D99mdnbE8Hs8lX9OPYCLLHmgi/F
         dGhVhPqUJopMd/btA19WoriDgkbHD3tyyGJjpxvUVgitbYeKz5MoZrvIFd5x+Oiu/9WX
         pPmA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@google.com header.s=20161025 header.b=h9n0UhU7;
       dkim=pass header.i=@chromium.org header.s=google header.b=e52guedu;
       spf=pass (google.com: domain of keescook@google.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=keescook@google.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=chromium.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@google.com header.s=20161025 header.b=h9n0UhU7;
       dkim=pass header.i=@chromium.org header.s=google header.b=e52guedu;
       spf=pass (google.com: domain of keescook@google.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=keescook@google.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=chromium.org
X-Google-Smtp-Source: AIpwx49CIj53aJRCt5L9hWUirED1zdQ4JccjkDM4LL3ZDHE31IT2pLgrWpOFPp5dQqYRt7wDFquzDvqTk+eK7bTF7Lk=
MIME-Version: 1.0
Sender: keescook@google.com
In-Reply-To: <1522128575-5326-4-git-send-email-yamada.masahiro@socionext.com>
References: <1522128575-5326-1-git-send-email-yamada.masahiro@socionext.com> <1522128575-5326-4-git-send-email-yamada.masahiro@socionext.com>
From: Kees Cook <keescook@chromium.org>
Date: Tue, 27 Mar 2018 20:29:20 -0700
X-Google-Sender-Auth: bXnyO5pJPaL0WnBPDzx8DvG3HlM
Message-ID: <CAGXu5jL+4mboiU1xfW4Q=bpB8KmGXHCZEVavRVKL0hKJ1_06fg@mail.gmail.com>
Subject: Re: [PATCH v2 03/21] kconfig: move and rename sym_expand_string_value()
To: Masahiro Yamada <yamada.masahiro@socionext.com>
Cc: linux-kbuild <linux-kbuild@vger.kernel.org>, Sam Ravnborg <sam@ravnborg.org>,
	Linus Torvalds <torvalds@linux-foundation.org>, Arnd Bergmann <arnd@arndb.de>,
	Ulf Magnusson <ulfalizer@gmail.com>, Thomas Gleixner <tglx@linutronix.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Randy Dunlap <rdunlap@infradead.org>,
	"Luis R . Rodriguez" <mcgrof@kernel.org>, Nicolas Pitre <nico@linaro.org>, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1596067537753773827?=
X-GMAIL-MSGID: =?utf-8?q?1596150525790642070?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Mon, Mar 26, 2018 at 10:29 PM, Masahiro Yamada
<yamada.masahiro@socionext.com> wrote:
> This helper expands symbols contained in a string.  I am about to
> change it to expand environments instead of symbols.  Also, I will
> add function expansion later.
>
> Rename it to expand_string_value(), and move it to util.c, which is
> a more suitable place.
>
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>

Reviewed-by: Kees Cook <keescook@chromium.org>

-Kees

-- 
Kees Cook
Pixel Security
