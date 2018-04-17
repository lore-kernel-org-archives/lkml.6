Return-Path: <andreyknvl@google.com>
ARC-Seal: i=1; a=rsa-sha256; t=1523968059; cv=none;
        d=google.com; s=arc-20160816;
        b=GCaC88ckt9OYFhzs/hj2R54JsyTgQKXquA0N8NazVW/igMGh3odm5WXKILDHNiTwaj
         7uWi73SUnjgAS+neeWZBF+tZicfSpcxDPU5CQ6rPk9Oq2JxADkjx/6YIc3VK3QkrbTEd
         sy50+Hs5N5c1YxrSfZWnaIKUzzG6RvZVVSYNo3Tif4PX/VEWQs2pFoLzu70Xxm5UMjs/
         x3lRxbpfWhYAWxoTyrCoLPnwvoNuDdj8TRfIBiq3ZzsJjXhiHe149a1NtDInF2vZqifK
         AiOK+QjpJWrn3bKNVfXUCny+IUWbM+ovqLm6lASCLTYu7Upd9sdhRgXAxApeCfPpeUUH
         N5Hg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:dkim-signature:arc-authentication-results;
        bh=AVqAaXpANcnEM+SZi0PHAemprwfHjdJIx15kEHQ2lRY=;
        b=w3o7xqv8rB9x2/kt9Jc1SBbVue16d6KKYu/HyRwXEytMSSUr93vtO/aZgoTwv7zta0
         pbkKa6Y3sa+LPbeoPc0bHRjv9Nyv1WBrkrgEAJKaqoCWUwXZBqimQH/HrlTAVgZBCFSj
         Gf3IRajH+dfG1YWbeQ/ABNl/TobMaih3OKBBul8OMSVG0qsQ/AR6YYz9nCFhel5/wrbb
         tpZ0VWr0J+NQxydSPl14sZtnouHkvEQvrw53gcWknM5q/8cL+gy76Hvcriamum04K13o
         Jnt7booeL1rD6/YVJ5tlTiuqfisCoB0p+mhBWySbIoLDwTK5YGeQp8kVx6PHZRNSnEJA
         oNuQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@google.com header.s=20161025 header.b=WoeCGnrE;
       spf=pass (google.com: domain of andreyknvl@google.com designates 209.85.220.41 as permitted sender) smtp.mailfrom=andreyknvl@google.com;
       dmarc=pass (p=REJECT sp=REJECT dis=NONE) header.from=google.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@google.com header.s=20161025 header.b=WoeCGnrE;
       spf=pass (google.com: domain of andreyknvl@google.com designates 209.85.220.41 as permitted sender) smtp.mailfrom=andreyknvl@google.com;
       dmarc=pass (p=REJECT sp=REJECT dis=NONE) header.from=google.com
X-Google-Smtp-Source: AIpwx48x2SbC0UHirrusNiSdEQMpm91wwS1+BDdVS1VZJ63njto/8ZWCI6Tj6CjACLDXaqF97MeG1h3Qh8RYwf47CTc=
MIME-Version: 1.0
In-Reply-To: <c95bd92f-bef4-378a-55ed-04439c784e43@virtuozzo.com>
References: <4ad725cc903f8534f8c8a60f0daade5e3d674f8d.1523554166.git.andreyknvl@google.com>
 <b849e2ff-3693-9546-5850-1ddcea23ee29@virtuozzo.com> <CAAeHK+y18zU_PAS5KB82PNqtvGNex+S0Jk3bWaE19=YjThaNow@mail.gmail.com>
 <c95bd92f-bef4-378a-55ed-04439c784e43@virtuozzo.com>
From: Andrey Konovalov <andreyknvl@google.com>
Date: Tue, 17 Apr 2018 14:27:37 +0200
Message-ID: <CAAeHK+xSsnPwBC__K+LODAYSwtPkBYReA0yOV=K=We1exzamCg@mail.gmail.com>
Subject: Re: [PATCH] kasan: add no_sanitize attribute for clang builds
To: Andrey Ryabinin <aryabinin@virtuozzo.com>
Cc: Alexander Potapenko <glider@google.com>, Dmitry Vyukov <dvyukov@google.com>,
	Andrew Morton <akpm@linux-foundation.org>, David Rientjes <rientjes@google.com>,
	Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@kernel.org>,
	David Woodhouse <dwmw@amazon.co.uk>, Will Deacon <will.deacon@arm.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Paul Lawrence <paullawrence@google.com>,
	Sandipan Das <sandipan@linux.vnet.ibm.com>, Kees Cook <keescook@chromium.org>,
	LKML <linux-kernel@vger.kernel.org>, kasan-dev <kasan-dev@googlegroups.com>,
	Linux Memory Management List <linux-mm@kvack.org>, Kostya Serebryany <kcc@google.com>
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1597562343326181438?=
X-GMAIL-MSGID: =?utf-8?q?1597996331733064580?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Fri, Apr 13, 2018 at 9:16 PM, Andrey Ryabinin
<aryabinin@virtuozzo.com> wrote:
> However, "#ifdef CONFIG_KASAN" seems to be redundant, I'd rather remove it.

Done, sent v2.

Thanks!
