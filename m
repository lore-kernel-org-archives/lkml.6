Return-Path: <kernel-hardening-return-12779-gregkh=linuxfoundation.org@lists.openwall.com>
X-Google-Smtp-Source: AIpwx4/8Yv53qxpJXexztaweIhi2uW4B1ut8Inz7aVYDdQDuTiz0LEBUYXWgYjOFZ85icts85Goa
ARC-Seal: i=1; a=rsa-sha256; t=1522188673; cv=none;
        d=google.com; s=arc-20160816;
        b=akAVvy0WSHV6FQ20gcWOx2HyO4iLLj4xN05KZ4hJrO8oCh+2F7dXD/G2hA5uRgcAYY
         v+fkPOZjVynj5eMq+o/CNgtGyGSR81RmTY3AYYDkUjhS4//WKMmDcIFJMSFXgobskeX3
         FTZfzW0mS4RF3UqGsjenu62eXXmSp8u6j67nIFui4imenR6/1xFU8R8irwHfGwhd7ScP
         1SghPnfg3iCMUx7qxM94qg8MnUZZlF7NSil6eiUMQ1gQDkm54E9LJmtlPql1GBx02tzL
         4SOr7xHIE5f8w3qEx3RzYiIxpZ8wSeU2W8Tr+XIcNAQdhq1A7wZXJv9ogAOF0Dmc/Bo8
         JCxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:delivered-to:list-id
         :list-subscribe:list-unsubscribe:list-help:list-post:precedence
         :mailing-list:arc-authentication-results;
        bh=tSx90A0201iu5PkqbNkGIfc2K7gk8XoGTJq+ydCWIlA=;
        b=LH0V8z02fsftF7sL3lDJEBIfL8c8x2X6VNVpAoV83ACDBKC61xEO5hZzkhBfZB0XBk
         +0BnZrQtZEmcxQZJyOkHrrv9ytnPf86JLM3nqeigTfPGuc99f8BSkV1VArdYp9yCsxUl
         AnIwHPx0gbfhKcfLZ49/QdrAmw0DfKNy0rF2Qs7UXH9s+Fxk+6+hGHbds/YyyWAk+bRh
         Q5lr9FJM4XUxhl0fHwMZidqkg7GALVNNhtIwZciD3ZTkXgihdaRLnvFTHEwcdTv6nUnz
         qc062dxtP4+nHZWzyvOy2U9Ou4SsE2zfpMYQpAHpd/Pb28voyMAsGetPFVsulTAixL7x
         Vmzg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of kernel-hardening-return-12779-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12779-gregkh=linuxfoundation.org@lists.openwall.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of kernel-hardening-return-12779-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12779-gregkh=linuxfoundation.org@lists.openwall.com
Mailing-List: contact kernel-hardening-help@lists.openwall.com; run by ezmlm
List-Post: <mailto:kernel-hardening@lists.openwall.com>
List-Help: <mailto:kernel-hardening-help@lists.openwall.com>
List-Unsubscribe: <mailto:kernel-hardening-unsubscribe@lists.openwall.com>
List-Subscribe: <mailto:kernel-hardening-subscribe@lists.openwall.com>
Date: Tue, 27 Mar 2018 15:10:53 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Kees Cook <keescook@chromium.org>
Cc: Boaz Harrosh <ooo@electrozaur.com>, linux-kernel@vger.kernel.org, Nick
 Desaulniers <ndesaulniers@google.com>, kernel-hardening@lists.openwall.com
Subject: Re: [PATCH] exofs: Avoid VLA in structures
Message-Id: <20180327151053.c7c8df4135a5dc0bacea0a83@linux-foundation.org>
In-Reply-To: <20180327203904.GA1151@beast>
References: <20180327203904.GA1151@beast>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1596124735903775296?=
X-GMAIL-MSGID: =?utf-8?q?1596130510514699900?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, 27 Mar 2018 13:39:04 -0700 Kees Cook <keescook@chromium.org> wrote:

> On the quest to remove all VLAs from the kernel[1] this adjusts several
> cases where allocation is made after an array of structures that points
> back into the allocation. The allocations are changed to perform explicit
> calculations instead of using a Variable Length Array in a structure.
> Additionally, this lets Clang compile this code now, since Clang does not
> support VLAIS[2].
> 
> [1] https://lkml.org/lkml/2018/3/7/621
> [2] https://lkml.org/lkml/2013/9/23/500
> 
> ...
>
> I not sure the best way to test this. Kconfig implies I need special hardware?

Yeah, I was wondering about that.  It's a tricky-looking patch.

Boaz, are you able to give it a spin?

Thanks.
