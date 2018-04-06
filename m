Return-Path: <linus971@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1522980132; cv=none;
        d=google.com; s=arc-20160816;
        b=aUDwhy5boHHRbjPueaj1XLJLD7wtsMluNQCZqU9uVJjBgLziiW6AdlkSVRSUvirpHI
         d9m9Tt66qVamXLskbvuCZF6CYoUB/SjltDZUPwwh1z1UiRFd5CrjEI7cVBf7Oe+ZAeEo
         4ebNARMpAxurzq+S7BhpRtkQldaT90wWEj48p12jxcma0P7DefN0tsQj6ehEaOfzyOof
         5jtCGFzuKImVFfMcMFu0AKk8DhnrB9ERf5iiBWAO/UsaDYIpIT5VrviQmS2H3mAQW7QV
         y0FT/DWmk+UHYCFxcdzyTQinYgl6dkaR26MoEUdbfHWecpxnwkFbu3Lizt/N2sBidvYj
         rzFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to:sender
         :mime-version:dkim-signature:dkim-signature
         :arc-authentication-results;
        bh=yAl4rglx8dTmYw7DcbIdDWqpNJEh38FEHK9gfXjapss=;
        b=KQ90Ld2CkuGSeBNUiamaR/LGL05C3bX+//zhUavMuYUTkJr/7DMoCOpN+P50LZ+tYu
         eJpQr28vj8rqR4uN8r6HozxFtuPDXp3w+DD9oz4nlNyn+XuyT3S7pPSYcJqxC8NmANYk
         +yQrQlJ5xdMnoXmDq+7F5+cjMTp6B+exn5SpO+c7mFABsE+EE/qvyQCbpNU7QpHeDq8O
         F/a8AeJKBpDO0nKFRA77mjdR+oGh07Mc2sSPH2EK/R5cD6ElfikJUmpAAYz0DyuzEyBX
         RTcflHNHrI0ChZ8hAHSMp4ncpxajVCYN6hitbTNrL5w7rb/ZtI03nsnUAu58h4UDjsDf
         0rPg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=D9TsvD//;
       dkim=pass header.i=@linux-foundation.org header.s=google header.b=ekTq7vjs;
       spf=pass (google.com: domain of linus971@gmail.com designates 209.85.220.41 as permitted sender) smtp.mailfrom=linus971@gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=D9TsvD//;
       dkim=pass header.i=@linux-foundation.org header.s=google header.b=ekTq7vjs;
       spf=pass (google.com: domain of linus971@gmail.com designates 209.85.220.41 as permitted sender) smtp.mailfrom=linus971@gmail.com
X-Google-Smtp-Source: AIpwx4+a9x5ZzuoltgRextXvBPktZPx3V+vxlFYkmcb8jjC57m2Jql+W8UT0IFswiefO4RUVC8LV+yOOF7RE9e2KpGE=
MIME-Version: 1.0
Sender: linus971@gmail.com
In-Reply-To: <CAA2zVHohAdM3v4WVsePPbCB1iC6OFOW9=Pxiqe=YYUTkxUNcwQ@mail.gmail.com>
References: <20180404093007.GI4082@hirez.programming.kicks-ass.net>
 <20180404191724.GF87376@google.com> <CAK8P3a1VFWYBymd3AeG1DwW++tCGsP9+vw6t8XSGHby2jmQPqA@mail.gmail.com>
 <20180404205848.GG87376@google.com> <CAK8P3a2tf3v6seq=OeyBakZ1ZXYzzL=tY=aHvKYv-GtD7sWeTA@mail.gmail.com>
 <20180404214639.GH87376@google.com> <CA+55aFwp8vRmf5p09nbunp6DfO+YvvWLj=FsU8KSW0ZwF6u80w@mail.gmail.com>
 <20180404221744.GI87376@google.com> <CA+55aFz+RcyPOTs3WM-FcwoQtgaotcBVqswma7qZ-3O2Fv__9Q@mail.gmail.com>
 <20180404233111.GJ87376@google.com> <20180405072017.GN4043@hirez.programming.kicks-ass.net>
 <CAA2zVHraWtmmW1yFvVH+kUbih5wxiDLuM=wArnQanrWN9NF=Xw@mail.gmail.com>
 <CA+55aFwrZU-VPa9HShikNDkvuOvFXtO2vw8sDeRRTCU_hV7dWA@mail.gmail.com>
 <CAA2zVHrF+teb3SwigH_sDqkWfKDg4itq4TkefYXUXw2RF9+4qw@mail.gmail.com>
 <CA+55aFz3PUE1mSM+yFeb55ca3EZAYHHqTyHjktiW1FVfK-tP9A@mail.gmail.com> <CAA2zVHohAdM3v4WVsePPbCB1iC6OFOW9=Pxiqe=YYUTkxUNcwQ@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Thu, 5 Apr 2018 19:02:11 -0700
X-Google-Sender-Auth: FZnb6-Ufv1f04fPimS6ueA5EXtM
Message-ID: <CA+55aFxjR5=0uQ7JVUs=aZp0frtBZorAvsPeXk6GYbQJZ_VU+Q@mail.gmail.com>
Subject: Re: [GIT PULL] x86/build changes for v4.17
To: James Y Knight <jyknight@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Matthias Kaehlcke <mka@chromium.org>,
	Arnd Bergmann <arnd@arndb.de>, Ingo Molnar <mingo@kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
	Andrew Morton <akpm@linux-foundation.org>, Chandler Carruth <chandlerc@google.com>,
	Stephen Hines <srhines@google.com>, Nick Desaulniers <ndesaulniers@google.com>,
	Kees Cook <keescook@google.com>, Guenter Roeck <groeck@chromium.org>,
	Greg Hackmann <ghackmann@google.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcSW1wb3J0YW50Ig==?=
X-GMAIL-THRID: =?utf-8?q?1596675801568391777?=
X-GMAIL-MSGID: =?utf-8?q?1596960415938915103?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Thu, Apr 5, 2018 at 3:51 PM, James Y Knight <jyknight@google.com> wrote:
>
> Unfortunately, that behavior is required by the standard, it's not up to
> compiler optimization to change.

I actually mis-read your example - in your case it obviously does pass
the array itself down to the call, and yes, it obviously needs to be
allocated.

I had a test-case at one point where gcc avoided the stack allocation
entirely for a regular array, but not for a VLA (of the same constant
size) because the VLA logic is apparently different enough - even when
the size of the array is a compile-time constant.

We had that issue because we had a lot of trouble coming up with a
"max()" macro that was still an I-C-E (and we had a number of array
sizes that used "max()"). So all the array sizes were compile-time
constants, they just weren't traditional C arrays.

But now I can't recreate the thing. Maybe I had screwed up in my
test-case somehow.

               Linus
