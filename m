Return-Path: <kernel-hardening-return-13144-gregkh=linuxfoundation.org@lists.openwall.com>
X-Google-Smtp-Source: AB8JxZokZL+El6xGcuiwqIX0+RKScfV+kel3g57zOopb4cFTewgR4/JvZ2zEKYipUIF7bHLXMYxo
ARC-Seal: i=1; a=rsa-sha256; t=1524763668; cv=none;
        d=google.com; s=arc-20160816;
        b=GLKqZkEJfW/GEgzr7JvMBns6NEyumf5fbb/g+tf4Xb+1tSAML7NoORPG+hIe4qOKsP
         FFBIPykhrpqlkzYvLwiWbeT6YRbXxVC6o7D6YFIzYASMhISoKjBBEYJquofYYrlxAjLc
         YC7RyZBFS6iuY4u8tUjL3fslyTthf+B16HZ19J9z3HLon6jYQZdXlASwGVZPIJEZKtz1
         My6HNXZgfJKmwLJBmYWGLzRRGpeFN5b1wpQamdjhFyKNSiSnkqb9OqKpJ8oyQQVKoPoG
         jprNXxDfF+Z4Ab+ctrKQYKZSdGrR46rPJU349FtQx9di3m1a9bCG30RMMz7CLjVHpiw6
         O6Pw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:dkim-signature:delivered-to:list-id:list-subscribe
         :list-unsubscribe:list-help:list-post:precedence:mailing-list
         :arc-authentication-results;
        bh=xX6+jDSWU7IZneTfmwxAIyV9iHorWAoGLV8n8jqtl0I=;
        b=P3nrG7Ii8WIgHbCBqqdkIrCtg7o16xAEh/TKcq1mShIl9vmCoM6jhegNdFKpJaR/9Z
         uPHVAdq0+C9tZZN/uK81vUsOipzdngP6JyEA6RCrXuVzw5Lfrk/FO8rikRaI4RWlBtzs
         k41Uw80YNsOopfUviBBXytWBGb0Y2IsP+QPh7kE4N7ELB/CZAy4JS4QW6O/cKUetf94X
         bLJWYJbVdxZKfJytzxJSAfGFDRT9r8fvfuS8XYFXEuOJimX9+u2PmDkBZ+HsuE8sBvjO
         myY8Vdbktld08aD+a4fmozszZxs0v6qdPeEPlgpRoZN+1TNm6bYCJ7jN8c5VvYgj/gxq
         ZQRQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=L0sVre6b;
       spf=pass (google.com: domain of kernel-hardening-return-13144-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-13144-gregkh=linuxfoundation.org@lists.openwall.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=L0sVre6b;
       spf=pass (google.com: domain of kernel-hardening-return-13144-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-13144-gregkh=linuxfoundation.org@lists.openwall.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Mailing-List: contact kernel-hardening-help@lists.openwall.com; run by ezmlm
List-Post: <mailto:kernel-hardening@lists.openwall.com>
List-Help: <mailto:kernel-hardening-help@lists.openwall.com>
List-Unsubscribe: <mailto:kernel-hardening-unsubscribe@lists.openwall.com>
List-Subscribe: <mailto:kernel-hardening-subscribe@lists.openwall.com>
MIME-Version: 1.0
In-Reply-To: <20180420165143.mwcxwkf6j7ddckdt@gondor.apana.org.au>
References: <1523282087-22128-1-git-send-email-s.mesoraca16@gmail.com> <20180420165143.mwcxwkf6j7ddckdt@gondor.apana.org.au>
From: Salvatore Mesoraca <s.mesoraca16@gmail.com>
Date: Thu, 26 Apr 2018 19:27:07 +0200
Message-ID: <CAJHCu1LDTDD5pBJYbsiio5yne-a+cVgDLaVNYSKxjq=L74JWqQ@mail.gmail.com>
Subject: Re: [PATCH v2 0/2] crypto: removing various VLAs
To: Herbert Xu <herbert@gondor.apana.org.au>
Cc: linux-kernel@vger.kernel.org,
	Kernel Hardening <kernel-hardening@lists.openwall.com>, linux-crypto@vger.kernel.org,
	"David S. Miller" <davem@davemloft.net>, Kees Cook <keescook@chromium.org>,
	Eric Biggers <ebiggers3@gmail.com>, Laura Abbott <labbott@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1597277119052489301?=
X-GMAIL-MSGID: =?utf-8?q?1598830588364772926?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

2018-04-20 18:51 GMT+02:00 Herbert Xu <herbert@gondor.apana.org.au>:
> On Mon, Apr 09, 2018 at 03:54:45PM +0200, Salvatore Mesoraca wrote:
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
>>
>> [1] http://lkml.kernel.org/r/4e536889-439a-49e6-dd95-2d4286913202@redhat.com
>>
>> Salvatore Mesoraca (2):
>>   crypto: api - laying defines and checks for statically allocated
>>     buffers
>>   crypto: remove several VLAs
>>
>>  crypto/algapi.c         | 10 ++++++++++
>>  crypto/cfb.c            |  7 +++----
>>  crypto/cipher.c         |  3 ++-
>>  crypto/ctr.c            |  4 ++--
>>  crypto/cts.c            |  5 +++--
>>  crypto/pcbc.c           |  5 +++--
>>  include/crypto/algapi.h |  8 ++++++++
>>  7 files changed, 31 insertions(+), 11 deletions(-)
>
> All applied.  Thanks.

Thank you very much.

Salvatore
