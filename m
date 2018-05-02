Return-Path: <andreyknvl@google.com>
ARC-Seal: i=1; a=rsa-sha256; t=1525274945; cv=none;
        d=google.com; s=arc-20160816;
        b=BtVLSALCBiy+1tWvV5t+W9PZrZt1qIDktNNrotfD07exRX7Opw7iAivzSTHBkgwLbs
         E4dLKeWp24uVujjT8kPA+60byxLHTJhZJA9/qe7D+V0fXyBY55j5j7/eQtcvxglWotYT
         50LS9Uun74rw5HbXsJNF2B/E9g2wnc+OIXZvGAgr4fOa8hIR71DRQeBsYeDZOlhRDcGw
         Ip19rhNdhQHSqCvEMdJA20OxZnkk6im2UdJAkQYtnUqa5IebwLfqrHI8KrX3D5Pc806I
         zjEGxyowTriXSM+9HLfFwglA04VzV+7Y/VwdEXtTs9UC5cLy/msErcaqdx1FYzkv1Vxd
         ZAkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:dkim-signature:arc-authentication-results;
        bh=6iuSgSHO95gOCYNelmTwLpKGLZlSQcNMjayssl8k4L8=;
        b=e29Cjz3mTbBGULnWR4+iqE0zqyRRcHQ9Tkbx6riVtsjHuBY2k3sP7uH2Ew6aGL1H7W
         t+cyMYAs+RCEm53hiUl5rLeTKf4sPk1OSmgoKhQQJ3Xu91XwHxcG1bhpufJMEoe8wRl7
         Z4NovaK8Ld2ILRIi2PG9Ztf2hL6rRSt8kxqdseYdifYMn+VgFng7PE2QREbfHhYmxCWR
         jTujQ34Vb3LceR0tLukSqX+weUgvAbYR9Vl6LboMXQsoJdakXz30fp28iFlT8z+X7lhl
         9nAAFAmG4f1pNRcJ9laGuWor+XIlDtYwnTWNZXetxAVPHaxAKfuH4urDXZpZnpC51lY7
         yLdw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@google.com header.s=20161025 header.b=gPm4JyZq;
       spf=pass (google.com: domain of andreyknvl@google.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=andreyknvl@google.com;
       dmarc=pass (p=REJECT sp=REJECT dis=NONE) header.from=google.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@google.com header.s=20161025 header.b=gPm4JyZq;
       spf=pass (google.com: domain of andreyknvl@google.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=andreyknvl@google.com;
       dmarc=pass (p=REJECT sp=REJECT dis=NONE) header.from=google.com
X-Google-Smtp-Source: AB8JxZowJLy6Gal4yX/ow8ogykWJv3gSkzUpfWQZ6g69dVQNdlnL6YtMx4U8fHbOez9qp/aPKBA47YbLKhTLlZLFuno=
MIME-Version: 1.0
In-Reply-To: <20180426154725.74a33tnevvbtqx63@armageddon.cambridge.arm.com>
References: <cover.1524077494.git.andreyknvl@google.com> <949c343a4b02b41b80f324c2b7cd56b75e6a04f3.1524077494.git.andreyknvl@google.com>
 <20180426154725.74a33tnevvbtqx63@armageddon.cambridge.arm.com>
From: Andrey Konovalov <andreyknvl@google.com>
Date: Wed, 2 May 2018 17:29:04 +0200
Message-ID: <CAAeHK+xWV2RNuoOrgkLrQ973eV2r8xFOcrzHWVrQZz7XA2WGYA@mail.gmail.com>
Subject: Re: [PATCH 3/6] arm64: untag user addresses in copy_from_user and others
To: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will.deacon@arm.com>, Jonathan Corbet <corbet@lwn.net>,
	Mark Rutland <mark.rutland@arm.com>, Robin Murphy <robin.murphy@arm.com>,
	Al Viro <viro@zeniv.linux.org.uk>, James Morse <james.morse@arm.com>,
	Kees Cook <keescook@chromium.org>, Bart Van Assche <bart.vanassche@wdc.com>,
	Kate Stewart <kstewart@linuxfoundation.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Thomas Gleixner <tglx@linutronix.de>,
	Philippe Ombredanne <pombredanne@nexb.com>, Andrew Morton <akpm@linux-foundation.org>,
	Ingo Molnar <mingo@kernel.org>, "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
	Dan Williams <dan.j.williams@intel.com>,
	"Aneesh Kumar K . V" <aneesh.kumar@linux.vnet.ibm.com>, Zi Yan <zi.yan@cs.rutgers.edu>,
	Linux ARM <linux-arm-kernel@lists.infradead.org>, linux-doc@vger.kernel.org,
	LKML <linux-kernel@vger.kernel.org>,
	Linux Memory Management List <linux-mm@kvack.org>, Jacob Bramley <Jacob.Bramley@arm.com>,
	Ruben Ayrapetyan <Ruben.Ayrapetyan@arm.com>, Lee Smith <Lee.Smith@arm.com>,
	Kostya Serebryany <kcc@google.com>, Dmitry Vyukov <dvyukov@google.com>,
	Ramana Radhakrishnan <Ramana.Radhakrishnan@arm.com>, Evgeniy Stepanov <eugenis@google.com>
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598111197844196620?=
X-GMAIL-MSGID: =?utf-8?q?1599366701439986740?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Thu, Apr 26, 2018 at 5:47 PM, Catalin Marinas
<catalin.marinas@arm.com> wrote:
> On Wed, Apr 18, 2018 at 08:53:12PM +0200, Andrey Konovalov wrote:
>> @@ -238,12 +239,15 @@ static inline void uaccess_enable_not_uao(void)
>>  /*
>>   * Sanitise a uaccess pointer such that it becomes NULL if above the
>>   * current addr_limit.
>> + * Also untag user pointers that have the top byte tag set.
>>   */
>>  #define uaccess_mask_ptr(ptr) (__typeof__(ptr))__uaccess_mask_ptr(ptr)
>>  static inline void __user *__uaccess_mask_ptr(const void __user *ptr)
>>  {
>>       void __user *safe_ptr;
>>
>> +     ptr = untagged_addr(ptr);
>> +
>>       asm volatile(
>>       "       bics    xzr, %1, %2\n"
>>       "       csel    %0, %1, xzr, eq\n"
>
> First of all, passing a tagged user pointer throughout the kernel is
> safe with uaccess routines but not suitable for find_vma() etc.
>
> With this change, we may have an inconsistent behaviour on the tag
> masking, depending on whether the entry code uses __uaccess_mask_ptr()
> or not. We could preserve the tag with something like:
>
> diff --git a/arch/arm64/include/asm/uaccess.h b/arch/arm64/include/asm/uaccess.h
> index e66b0fca99c2..ed15bfcbd797 100644
> --- a/arch/arm64/include/asm/uaccess.h
> +++ b/arch/arm64/include/asm/uaccess.h
> @@ -244,10 +244,11 @@ static inline void __user *__uaccess_mask_ptr(const void __user *ptr)
>         void __user *safe_ptr;
>
>         asm volatile(
> -       "       bics    xzr, %1, %2\n"
> +       "       bics    xzr, %3, %2\n"
>         "       csel    %0, %1, xzr, eq\n"
>         : "=&r" (safe_ptr)
> -       : "r" (ptr), "r" (current_thread_info()->addr_limit)
> +       : "r" (ptr), "r" (current_thread_info()->addr_limit),
> +         "r" (untagged_addr(ptr))
>         : "cc");
>
>         csdb();

Just to make sure I understood this assembly snippet correctly, this
change will result in checking untagged address against addr_limit,
and returning the original tagged address if the check passes. Sure,
sounds good, I'll do that.
