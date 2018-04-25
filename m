Return-Path: <rdunlap@infradead.org>
X-Google-Smtp-Source: AIpwx499kTh0OiGnSptftv0lkiibcn2VquGyKVQuR4FdHMnaF2b4piFD+2kjjXZW6ExncfdYzTFo
ARC-Seal: i=1; a=rsa-sha256; t=1524617356; cv=none;
        d=google.com; s=arc-20160816;
        b=kKygDZMYVQhrRgAnZHskKYYFT7AaBHS1GeMHmTNM8TzhfB2Tnwkff+7qaQ/GT8xrIw
         DQth1onkoNQ2qLyer9EljxMQc+T/M0yAm9K6yQjcMWUj+YGWTaD4v31CkTUvLlx+LjXb
         WoAPLVGKDVsKxr71YqqC92zKlj6zHL+V/8ivJ5UrPRnVqnKyFehWxUT6wlSiOd/1QPem
         VfyKDDirJNawy0XT096VfZr2c3oWkoCVHTb2RV4+fXSVyptrQ2ahbWa5apiuwKzMK1l1
         GQvIFtpIIbKnail8BKn6r2/Smv21z2DqMkpyC2i7qzwobwA99DaS44VnIrJoYUeZ0dGr
         fcsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :dkim-signature:arc-authentication-results;
        bh=3gjZPyOzS3DG+lsRb8bzypDgkQxIDcCo2pB+TeF/S9s=;
        b=B4DpcMjg5KLPDX0xg1cX8tPTVNg4dz9MNjmtDYBZWE+M1l5FifzmnBAZeVdRntbICj
         Vpb4k6fqcDcmr+qqtcrq2dl+5V7SPwj5XxYWuphJXABABc8cwEQnyJs8a1N5a8SQGpaq
         6kbJTQJg94hlVK8f/teU4uGZ5/d8qpNu3aFWs06KWcgEfDHb+Qe/NEBJVH1ibmKesjxi
         d/HMzF+Pgsm3XJ7cwW0HXNCiNJydajLNmSxZaesT0pUzRXrdzKRQXjFutWC+z8w+LFJk
         4unAbGUr98s6+W4gfHm8FVwVMwiSXy91QTJ/PKJnNlzpke4zZeKEk8WbOOStu+o9vGpo
         ibgA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@infradead.org header.s=bombadil.20170209 header.b=b3exuqCh;
       spf=pass (google.com: best guess record for domain of rdunlap@infradead.org designates 198.137.202.133 as permitted sender) smtp.mailfrom=rdunlap@infradead.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@infradead.org header.s=bombadil.20170209 header.b=b3exuqCh;
       spf=pass (google.com: best guess record for domain of rdunlap@infradead.org designates 198.137.202.133 as permitted sender) smtp.mailfrom=rdunlap@infradead.org
Subject: Re: [PATCH] do not call trace_printk on non-debug build
To: Steven Rostedt <rostedt@goodmis.org>, Wei Wang <wvw@google.com>
Cc: gregkh@linuxfoundation.org, Wei Wang <wei.vince.wang@gmail.com>,
 Ingo Molnar <mingo@redhat.com>, Andrew Morton <akpm@linux-foundation.org>,
 Kees Cook <keescook@chromium.org>, Peter Zijlstra <peterz@infradead.org>,
 Thomas Gleixner <tglx@linutronix.de>, Crt Mori <cmo@melexis.com>,
 Alexei Starovoitov <ast@kernel.org>, linux-kernel@vger.kernel.org,
 Joe Perches <joe@perches.com>
References: <20180424180812.215900-1-wvw@google.com>
 <20180424145056.7c29ea18@gandalf.local.home>
 <CAGXk5yo44kAku+ZYx=8HzOgkEVC7ARNSER4MvWTCz-i51up=ew@mail.gmail.com>
 <20180424151416.397fbbde@gandalf.local.home>
 <CAGXk5yriz2CtCN-vkL0q7gdpV+f8+9GJH-FT+v3KBLb-fWoCZA@mail.gmail.com>
 <20180424152607.71fbee34@gandalf.local.home>
 <CAGXk5yre3aDtVbtEz4=DdBnLrT3U=LPA69jOp9zmkfeYiZ7w=Q@mail.gmail.com>
 <20180424164505.0a4d15f7@gandalf.local.home>
From: Randy Dunlap <rdunlap@infradead.org>
Message-ID: <e9195edc-8661-f4d7-eb0b-ac839eea1974@infradead.org>
Date: Tue, 24 Apr 2018 17:49:06 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180424164505.0a4d15f7@gandalf.local.home>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598651942651560845?=
X-GMAIL-MSGID: =?utf-8?q?1598677168737782717?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 04/24/2018 01:45 PM, Steven Rostedt wrote:
> On Tue, 24 Apr 2018 20:39:27 +0000
> Wei Wang <wvw@google.com> wrote:
> 
>> The config is not something new and it is controlling pr_debug and
>> pr_devel, so might not be too annoying, IMHO. But I agree this is not a
>> problem from us but from abusers.
> 
> And is the reason I never use pr_debug() and pr_devel().

pr_debug() is good along with dynamic debug.

-- 
~Randy
