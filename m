Return-Path: <arndbergmann@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1518709032; cv=none;
        d=google.com; s=arc-20160816;
        b=vjs5BzphGqu7LhfE//xx8ZsnNJtkxOWF3R4RiffFUq+VoOyXEIzMrx4974qGWozEgF
         Ouac+pzdJVJEmPzcsw+rasXDLmG08RwbVl2HbbTAUrd/LPH5kQMLF6jsDzLVzPBWWQZG
         Ca7onnHaKX16LR0HNg5Y1NocZh8vYtbm4oEsOH2hiHZgYJiEPBujy6jQkRHzo1zORdog
         wfMxHkxkTm0O6Vz4aKFqEWjv4je6A27W0iE2i8Levbd5Cxuu7J79m5VT23OcTavYApIy
         5t6eM5WEoAbxve64nFwV677nAhrlj7e5WDn+WAzGlkeSgmJ8NyP8ypMVpqOypXqok+35
         KnmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to:sender
         :mime-version:dkim-signature:arc-authentication-results;
        bh=s9M7Z04dQy1LS678ZX5slOhFbcC4xsjZx0y2lcoWDCo=;
        b=JxLWybL10kHSG045SQRYxNwbYQf93JPQDoabTD5uFAYwqHQEuk0TrWn+WYDY80Z4/P
         55p3asa9C9Jizxj6MzSBwpi1Gk1Ql6szwtUixhlFz3/qSkr2erXrf5jNpfKk4hMAa2M8
         YKoYgnR3TLHI2nHfk++Xm8r9J+1gADgVn+hzMVK0qn60uJZxEOH7hzJRzDPuu1OFr+j2
         DKNYG6EtgjV+sBqfZWQSj6m/fQ9P5zgg4my+BM1I8uMdqg/VI+ZOOQHIDbIy+uzxWslk
         gOpzb9BnyCGpOOKOIAZ4d6FioN2zQnuy7r3xovVAWJmt15V/nsQXO8izbYMhs/ILsGbN
         gUAA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=FKHkq+RV;
       spf=pass (google.com: domain of arndbergmann@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=arndbergmann@gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=FKHkq+RV;
       spf=pass (google.com: domain of arndbergmann@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=arndbergmann@gmail.com
X-Google-Smtp-Source: AH8x226Db1mY3eD9F8W3fUbLakF+HA5fc+8YsRDLHppiBo9RarlSVWt3FTBjB15J0V7zBh0XS7zxvvDVaOfu+VR3vOA=
MIME-Version: 1.0
Sender: arndbergmann@gmail.com
In-Reply-To: <20180215054357.GC7377@kroah.com>
References: <20171206141627.688219-1-arnd@arndb.de> <CAK8P3a0ZN2ALu1tj9sm8-Lt9SsRgpbQtz91zR4MhY-Np7TQNyg@mail.gmail.com>
 <af5124d4-b2cc-7d3c-5b8e-f7381859efd6@linux.intel.com> <CAK8P3a3pyM2FwHcAvFQckvbfqt7WvgRYSWE97pwLAtdvd77ToQ@mail.gmail.com>
 <20180215054357.GC7377@kroah.com>
From: Arnd Bergmann <arnd@arndb.de>
Date: Thu, 15 Feb 2018 16:37:10 +0100
X-Google-Sender-Auth: UD4MHSCk9VUnCslRnGSKhMaZkhk
Message-ID: <CAK8P3a0hTbb+zRPH6nXVEdxP7zJyu5mYcjLqnWd4AfG_=Yrm-w@mail.gmail.com>
Subject: Re: [PATCH] x86/mm/kaiser: avoid 32-bit/PAE build warning
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Dave Hansen <dave.hansen@linux.intel.com>, "the arch/x86 maintainers" <x86@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, stable <stable@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcSW1wb3J0YW50Ig==?=
X-GMAIL-THRID: =?utf-8?q?1592481842416907194?=
X-GMAIL-MSGID: =?utf-8?q?1592481842416907194?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Thu, Feb 15, 2018 at 6:43 AM, Greg KH <gregkh@linuxfoundation.org> wrote:
> On Wed, Feb 14, 2018 at 11:12:24PM +0100, Arnd Bergmann wrote:
>> On Wed, Dec 6, 2017 at 4:08 PM, Dave Hansen <dave.hansen@linux.intel.com> wrote:

>>
>> I also saw another warning:
>>
>> /git/arm-soc/arch/x86/mm/kaiser.c: In function 'kaiser_init':
>> /git/arm-soc/arch/x86/mm/kaiser.c:347:8: error: 'vsyscall_pgprot'
>> undeclared (first use in this function); did you mean
>> 'massage_pgprot'?
>>
>> I can send this as proper patches for inclusion in 4.9-stable, unless
>> someone has a better idea or finds a problem
>
> proper patches would be good :)

Sent two patches now. I want to make sure I haven't missed anything there,
especially as my first approach at fixing it ended up causing other build
failures.

In order to test this, I backported some 35 other (mostly trivial) patches later
kernels, and now I have a 4.9.80 based tree that produces a clean randconfig
build every time on arm64 and x86_64. If you want, I'll send you the list
of the required backports as well. From what I can tell, they are all
harmless (unused functions, missing Kconfig dependencies etc), but
being able to do randconfig builds reliable gives us an additional tool for
regression testing the stable kernels.

For 4.14-stable, we only need a handful of patches, but only one of those
is upstream, I'll try my best to get the others merged with a Cc stable tag
so 4.14 randconfig should build cleanly soon.

I suspect 4.4 would require even more patches, but I have not looked.

      Arnd
