Return-Path: <linus971@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1525222964; cv=none;
        d=google.com; s=arc-20160816;
        b=Qej3kto3OcjV4V8gG02QWhYc7MdimhaP/8NchbWbUM+AOQY8P8asz5b+wrE8jsfL2c
         0YbfyA2m+DtpseQbA4x2QRxzLLXoZOHVX+MrhjI/PhZo77Dp+qqnHJbUFUXhRIftPn5k
         AJ7KBVpOaPrAuz+jDyukf2ixrBLjo+IkBt+JOijXITdAL7GyLlbi1JignFlgyLj1uzKB
         txPxooFt578ODOHUogYjhOKPwHMXJc8YAkoCYcjcFYRnGIU/aShtdWuotlSrCxrcHbFw
         oWTVulRNTtxp0H0/dn5dyWi9HRDOBjDkCAFzaexr/v6rLcfCq4+Eu+Dc5wx8ysZR24Nu
         NCtg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature:arc-authentication-results;
        bh=x+cUj8j9LjVH9bj20mbC1siWr+Dng6ubASksJY9epEg=;
        b=Ds9mpJ/0gAXHZ6S2sZ2b2QssI+QbOXhC4jFsgqkY50oIX2xDDltmcIxBnEmlrRk+CV
         jiDzz5Phpn2jUdbnMLH75q+mlK/pwsZ5GY4RP1BGrIDAsywF76n5xpAdKQk91BZHD14x
         mQjW3mgK3p9KA+fhjn5EwQ71MaIjc0uS2kgCoMS0i0bbnpUYoeTfBvNuSBBNka9pHb4g
         whuk5USNVm/3947fIguewrJRUaTUlrMm0FknAO0Zi7eC1xMEpiA6YMWce7XrPAk/R9RI
         YtiIy793tkVpVhhAHfiXkcQRpHS9kD5aZOj/XZo+MN4m0KmRSJerxFhv+aKQ44qiotuH
         7FPQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@linux-foundation.org header.s=google header.b=QtuuGhNd;
       spf=pass (google.com: domain of linus971@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=linus971@gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@linux-foundation.org header.s=google header.b=QtuuGhNd;
       spf=pass (google.com: domain of linus971@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=linus971@gmail.com
X-Google-Smtp-Source: AB8JxZqQ0MWZWWERBKN97txG3H2fRwK5MUSLyHC1At/zM557pkwHehez9N9Facar/FWExinraNUJvP3PVUE+nAUOK/E=
MIME-Version: 1.0
References: <1525217620-4107-1-git-send-email-me@tobin.cc> <1525217620-4107-4-git-send-email-me@tobin.cc>
In-Reply-To: <1525217620-4107-4-git-send-email-me@tobin.cc>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 02 May 2018 01:02:34 +0000
Message-ID: <CA+55aFzuGrp3XGhsj989XS-vAw9S9bzFUX6mNpvPaMfew6v1iA@mail.gmail.com>
Subject: Re: [PATCH 3/3] vsprintf: Add use-early-random-bytes cmd line option
To: tcharding <me@tobin.cc>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Randy Dunlap <rdunlap@infradead.org>,
	Steven Rostedt <rostedt@goodmis.org>, Kees Cook <keescook@chromium.org>,
	Anna-Maria Gleixner <anna-maria@linutronix.de>, Andrew Morton <akpm@linux-foundation.org>,
	"Theodore Ts'o" <tytso@mit.edu>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Arnd Bergmann <arnd@arndb.de>
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1599306645428721863?=
X-GMAIL-MSGID: =?utf-8?q?1599312195529152973?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, May 1, 2018 at 4:34 PM Tobin C. Harding <me@tobin.cc> wrote:


> This option should NOT be enabled on production kernels.

I think with your fixes to get_random_bytes_arch(), it's perfectly fine to
use on production kernels (and doesn't even need a kernel command line
option).

It was only with the "use weak crypto" (that get_random_bytes_arch() used
to fall back on) that it was a problem. That fixed "verify that
get_random_bytes_arch() really uses hw crypto" is certainly not weak crypto.

              Linus
