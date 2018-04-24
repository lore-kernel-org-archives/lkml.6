Return-Path: <SRS0=KIOc=HN=goodmis.org=rostedt@kernel.org>
X-Google-Smtp-Source: AB8JxZqbnDXhgASTUCfDRZDE/vLyJxE2sefidOKGajQ7EzoODVaXKAvIebLXDHh2TLeuD6d5ygCA
ARC-Seal: i=1; a=rsa-sha256; t=1524602709; cv=none;
        d=google.com; s=arc-20160816;
        b=D4q0AVjuJrg2gAy4WXV4him5QqJrV6qv5OlHParnIWCAzKkP83uDJQCEXRFnOBmcD2
         uI7Kx4/GGJCpua1xz6MwkwHIk/7ALoy3sKe1MqXKXtR6PXK9Qu9ofoJ3kr98IsGHjF0E
         OlGU7vHqx+DbJv6u1BL33tV15AvnpZcbeyKAd6eOVQWZu5PvORBWZkkUnLF48Z91qN1N
         f+6dyUAqbSVkNyTSjRIsWqB2E+DyejuBRBLzRB6y6Ku0tVllvj1g6mPkowueGRx+favN
         9C1CTjSndWWfSaWhGioK6FJ+Qn34wiWnbtx6gdHoB57v5EDWtmO73/2SR4mCBReR1CNo
         QTdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:dmarc-filter
         :arc-authentication-results;
        bh=opPDknKr6w6k5euqdYSaQkE6el0Gg6ZbV+r3fN9dO10=;
        b=B87NDEIcVu+//aEbQpqMcb2k+v52pPUy6AiTOV/Ys/BBfWATJ4/T1WSzV1sBpRSRAP
         Phq/DNvBl6lGFXeL0QPcvaqgGhOzT0HCyaaS+ZDTWQbmqvNjtbDUu9hpDbU+jeFfxNLc
         NX4z39AWvcl/okpX9oWHTubJsmKqV5x7iiSMCipObr76qghho2u3HMmd546UeoZWprLK
         1qejsPlMnSFRmmD+WVWfimZHUGgHZKoRZxmXCtz2LQqU8Ew2iw3VTAjEwD7hbmFKih0g
         jKjpT4yRJ0aCm2u8ZPP6MvTlPkj5yeS24TXgFatCmLTT80xIvtQ+bJXJKUImnaV/2jBW
         a4Hw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of srs0=kioc=hn=goodmis.org=rostedt@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=KIOc=HN=goodmis.org=rostedt@kernel.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of srs0=kioc=hn=goodmis.org=rostedt@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=KIOc=HN=goodmis.org=rostedt@kernel.org
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 15D13217BA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=rostedt@goodmis.org
Date: Tue, 24 Apr 2018 16:45:05 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Wei Wang <wvw@google.com>
Cc: gregkh@linuxfoundation.org, Wei Wang <wei.vince.wang@gmail.com>, Ingo
 Molnar <mingo@redhat.com>, Andrew Morton <akpm@linux-foundation.org>, Kees
 Cook <keescook@chromium.org>, Peter Zijlstra <peterz@infradead.org>, Thomas
 Gleixner <tglx@linutronix.de>, Crt Mori <cmo@melexis.com>, Alexei
 Starovoitov <ast@kernel.org>, Randy Dunlap <rdunlap@infradead.org>,
 linux-kernel@vger.kernel.org, Joe Perches <joe@perches.com>
Subject: Re: [PATCH] do not call trace_printk on non-debug build
Message-ID: <20180424164505.0a4d15f7@gandalf.local.home>
In-Reply-To: <CAGXk5yre3aDtVbtEz4=DdBnLrT3U=LPA69jOp9zmkfeYiZ7w=Q@mail.gmail.com>
References: <20180424180812.215900-1-wvw@google.com>
	<20180424145056.7c29ea18@gandalf.local.home>
	<CAGXk5yo44kAku+ZYx=8HzOgkEVC7ARNSER4MvWTCz-i51up=ew@mail.gmail.com>
	<20180424151416.397fbbde@gandalf.local.home>
	<CAGXk5yriz2CtCN-vkL0q7gdpV+f8+9GJH-FT+v3KBLb-fWoCZA@mail.gmail.com>
	<20180424152607.71fbee34@gandalf.local.home>
	<CAGXk5yre3aDtVbtEz4=DdBnLrT3U=LPA69jOp9zmkfeYiZ7w=Q@mail.gmail.com>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598651942651560845?=
X-GMAIL-MSGID: =?utf-8?q?1598661810246334516?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, 24 Apr 2018 20:39:27 +0000
Wei Wang <wvw@google.com> wrote:

> The config is not something new and it is controlling pr_debug and
> pr_devel, so might not be too annoying, IMHO. But I agree this is not a
> problem from us but from abusers.

And is the reason I never use pr_debug() and pr_devel().

-- Steve
