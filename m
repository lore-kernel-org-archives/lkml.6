Return-Path: <kernel-hardening-return-12932-gregkh=linuxfoundation.org@lists.openwall.com>
X-Google-Smtp-Source: AIpwx4/EGJvmCZfuWRw8jQKboqoidwTF0EFXwzZpNEkib2ryGBWCbvXsF6+GkzlQHkK6uyoz/4oJ
ARC-Seal: i=1; a=rsa-sha256; t=1523291939; cv=none;
        d=google.com; s=arc-20160816;
        b=hsa3biktwMYsNfplUZOHbA5icQI/q8n+Qz4ANCQlhCxWDUIJtlAAOu8Tau79t2a7Td
         E4I1P3J6M7tG1ieH84QX410An37C/Nnj/aTRI29cvz255IFQYdm9vVMdnIzfZrJD+T4n
         TeYuxupTq1OHPf+Cl7i9FFMbWShAjlWOMrNLlj8URcoZ70/zD/GmQGzTMBwPDhUtuF8T
         p4w1yQOQbMeByKc+hq02o6B0vSUjNEKXEMxE2dPWyYN5k9PBUc4eIOrrsW18+sJNYNyw
         +Hqy5iLj8M4gwjqK/jffFbJ07ZkSTFx0gE2hPcCBzr+nb5VgUr62aDxL0HijXrkuKMMU
         WdSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:dkim-signature:delivered-to:list-id:list-subscribe
         :list-unsubscribe:list-help:list-post:precedence:mailing-list
         :arc-authentication-results;
        bh=yRF0VqoYqq+19Qwac1dv26g7pfejHFUg8WaWS0GFFVg=;
        b=DSgQORhLKUJw1zg5Z2vtBHkBZe5NJYdDt/xzVTfTQ8DS20jJxH3vcp3O8YP7ituOFI
         VknpKH+YAPWngjlwdFWaS3Pz0He55TXl0Nf9Gv6Vfpoxg+j0EpNez3mJU/7OAPSAzw7/
         DDqbNjDH98fsu/TlV4oofg1Vgjye68vMu/BM1hxiCjPny3C06Nr6UYnvjcWiv0zj+jMM
         Kj+TtdtOdjrxxkowfpf9dEXv+bPT1x4RMXlbc3yLmRUGikXqE3o2CavPP17YjpBAPeOe
         pLBE6UZ4lIS+VJ4Wykc3kZ03K30gfeeM0dERPU7KJoOdNiToV3zX/B5bGdDGdgAOt3Vk
         WI9A==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=bvGjskTU;
       spf=pass (google.com: domain of kernel-hardening-return-12932-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12932-gregkh=linuxfoundation.org@lists.openwall.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=bvGjskTU;
       spf=pass (google.com: domain of kernel-hardening-return-12932-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12932-gregkh=linuxfoundation.org@lists.openwall.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Mailing-List: contact kernel-hardening-help@lists.openwall.com; run by ezmlm
List-Post: <mailto:kernel-hardening@lists.openwall.com>
List-Help: <mailto:kernel-hardening-help@lists.openwall.com>
List-Unsubscribe: <mailto:kernel-hardening-unsubscribe@lists.openwall.com>
List-Subscribe: <mailto:kernel-hardening-subscribe@lists.openwall.com>
MIME-Version: 1.0
In-Reply-To: <ca31b95a8b8e4dab90c5ea2eb6e6477f@AcuMS.aculab.com>
References: <1523282087-22128-1-git-send-email-s.mesoraca16@gmail.com> <ca31b95a8b8e4dab90c5ea2eb6e6477f@AcuMS.aculab.com>
From: Salvatore Mesoraca <s.mesoraca16@gmail.com>
Date: Mon, 9 Apr 2018 18:38:18 +0200
Message-ID: <CAJHCu1+YynzroRkfZC9ki0b=RwiDOoOJB0S97uUVWSxLgac74A@mail.gmail.com>
Subject: Re: [PATCH v2 0/2] crypto: removing various VLAs
To: David Laight <David.Laight@aculab.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"kernel-hardening@lists.openwall.com" <kernel-hardening@lists.openwall.com>,
	"linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>, "David S. Miller" <davem@davemloft.net>,
	Herbert Xu <herbert@gondor.apana.org.au>, Kees Cook <keescook@chromium.org>,
	Eric Biggers <ebiggers3@gmail.com>, Laura Abbott <labbott@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1597277119052489301?=
X-GMAIL-MSGID: =?utf-8?q?1597287368563779701?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

2018-04-09 16:35 GMT+02:00 David Laight <David.Laight@aculab.com>:
> From: Salvatore Mesoraca
>> Sent: 09 April 2018 14:55
>>
>> v2:
>>       As suggested by Herbert Xu, the blocksize and alignmask checks
>>       have been moved to crypto_check_alg.
>>       So, now, all the other separate checks are not necessary.
>>       Also, the defines have been moved to include/crypto/algapi.h.
>>
>> v1:
>>       As suggested by Laura Abbott[1], I'm resending my patch with
>>       MAX_BLOCKSIZE and MAX_ALIGNMASK defined in an header, so they
>>       can be used in other places.
>>       I took this opportunity to deal with some other VLAs not
>>       handled in the old patch.
>
> If the constants are visible they need better names.
> Maybe CRYPTO_MAX_xxx.

You are right, in fact I renamed them, but forget to write about this
in the change log.
The new names look like MAX_CIPHER_*.

> You can also do much better than allocating MAX_BLOCKSIZE + MAX_ALIGNMASK
> bytes by requesting 'long' aligned on-stack memory.
> The easiest way is to define a union like:
>
> union crypto_tmp {
>         u8 buf[CRYPTO_MAX_TMP_BUF];
>         long buf_align;
> };
>
> Then in each function:
>
>         union tmp crypto_tmp;
>         u8 *keystream = PTR_ALIGN(tmp.buf, alignmask + 1);
>
> I think CRYPTO_MAX_TMP_BUF needs to be MAX_BLOCKSIZE + MAX_ALIGNMASK - sizeof (long).

Yeah, that would be nice, it might save us 4-8 bytes on the stack.
But I was thinking, wouldn't it be even better to do something like:

u8 buf[CRYPTO_MAX_TMP_BUF] __aligned(__alignof__(long));
u8 *keystream = PTR_ALIGN(buf, alignmask + 1);

In this case __aligned should work, if I'm not missing some other
subtle GCC caveat.

Thank you,

Salvatore
