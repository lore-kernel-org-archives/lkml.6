Return-Path: <kernel-hardening-return-12917-gregkh=linuxfoundation.org@lists.openwall.com>
X-Google-Smtp-Source: AIpwx49CwlRWeU+QcrQ50qCCXPiG2ambIh5p8W1puw1VixP1jWEERIAG0xb6JYU/1JWXeW8NcB12
ARC-Seal: i=1; a=rsa-sha256; t=1523280461; cv=none;
        d=google.com; s=arc-20160816;
        b=kJX9dKsTr/vscJPJrVees8dR2XDH8PwOJ/PfsIqSqvVNet0FI+RHB7yIXJ+uVDVxyK
         Nqz7ncRehx4Ck+ARf4M6oauBTcZ/IQKOMZ69gfDWXO9PVRMBQlRSyxNTy0WfoPwFSvrb
         8bNbfPwXBZCEKf/GMWKXK2SbUCOR/NZx2BJyiCJGbgc1f6Od0jd1twzQwbNzPMM4GT2S
         /8kIZBcNL6Ymawr5K2IB6qjBgFFUUfu1GeX1Zrap3qVU7C3v4/KSBFIyDRX8jLyGGY2X
         TIa40l2oF1a3lqNFzg4WXEsBmo/hUgjFM75j+An4l6fBJha4XFDabZxJA21U3oK4jLg9
         X14w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:dkim-signature:delivered-to:list-id:list-subscribe
         :list-unsubscribe:list-help:list-post:precedence:mailing-list
         :arc-authentication-results;
        bh=/CDar8QVZCjkes7CrCBSRdt9tZIT5ddBFgazLtz29Fw=;
        b=x4j8UHKRvmXw0H742I0HyA/c3iZuADvnerBJhnP9ChklzeZLI1njpBI29YwTBmzkaM
         ozZ/8de8Ll5TZmpC4NsTKmqA9waj/bPv4z46qdPCjR7oUv7gA+LKS/Zmm9ieVY4JQPef
         M0V6B9nF3uzmpR3FJ+3DO222N0d330JBSB8fi8DC5ZhP+ykFGb25ZHMvLi0PP0pzTPwQ
         4h3cufGCC+9tAuEyGsjt7bqZgfjj/9XgJ9BbgCSHhmtV9t0YZPTpYM+2PewKwvgwMYN8
         a9fi0SO72u0EHrZ5MuTssIbDiYSICXyIabDHWV0hPoGHUK1jlaCi7q+gEW/El21+sakK
         B+Fw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=ASVMXcsJ;
       spf=pass (google.com: domain of kernel-hardening-return-12917-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12917-gregkh=linuxfoundation.org@lists.openwall.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=ASVMXcsJ;
       spf=pass (google.com: domain of kernel-hardening-return-12917-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12917-gregkh=linuxfoundation.org@lists.openwall.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Mailing-List: contact kernel-hardening-help@lists.openwall.com; run by ezmlm
List-Post: <mailto:kernel-hardening@lists.openwall.com>
List-Help: <mailto:kernel-hardening-help@lists.openwall.com>
List-Unsubscribe: <mailto:kernel-hardening-unsubscribe@lists.openwall.com>
List-Subscribe: <mailto:kernel-hardening-subscribe@lists.openwall.com>
MIME-Version: 1.0
In-Reply-To: <20180408092219.s24ymooq7afu43c2@gondor.apana.org.au>
References: <1523126303-23205-1-git-send-email-s.mesoraca16@gmail.com>
 <1523126303-23205-4-git-send-email-s.mesoraca16@gmail.com>
 <20180408031619.GB25197@gondor.apana.org.au> <CAJHCu1LiPkDzL8rQMDdope=di+TZxz6gXuMKFQi_YpkSNquJ_g@mail.gmail.com>
 <20180408092219.s24ymooq7afu43c2@gondor.apana.org.au>
From: Salvatore Mesoraca <s.mesoraca16@gmail.com>
Date: Mon, 9 Apr 2018 15:27:03 +0200
Message-ID: <CAJHCu1La-QVqjd5nVMWF_vKMZhhuqGRWshEHGTLkZCeiDDvFGw@mail.gmail.com>
Subject: Re: [PATCH 3/6] crypto: api - avoid VLA use
To: Herbert Xu <herbert@gondor.apana.org.au>
Cc: linux-kernel@vger.kernel.org,
	Kernel Hardening <kernel-hardening@lists.openwall.com>, linux-crypto@vger.kernel.org,
	"David S. Miller" <davem@davemloft.net>, Kees Cook <keescook@chromium.org>,
	Eric Biggers <ebiggers3@gmail.com>, Laura Abbott <labbott@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1597113773763364977?=
X-GMAIL-MSGID: =?utf-8?q?1597275333403864292?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

2018-04-08 11:22 GMT+02:00 Herbert Xu <herbert@gondor.apana.org.au>:
> On Sun, Apr 08, 2018 at 11:07:12AM +0200, Salvatore Mesoraca wrote:
>>
>> > This check should be done when the algorithm is registered.  Perhaps
>> > crypto_check_alg.
>>
>> Please correct me if I'm wrong:
>> isn't crypto_check_alg invoked also during hashing algorithm registration?
>> In this patch-set I'm dealing only with ciphers, because the maximum
>> block size (16)
>> is relatively small and it's also the most common block size with
>> ciphers (maybe I should
>> have explicitly referenced ciphers in the macro names, my bad).
>> I don't think that it would be OK to use a similar approach for hashes
>> too, because some
>> of them have block size >= 1024 bytes.
>
> Yes we want to make it for ciphers only even if we move it to
> crypto_check_alg.
>
> For a legacy type like cipher cou can do it by
>
>         if (!alg->cra_type && (alg->cra_flags & CRYPTO_ALG_TYPE_MASK) ==
>                               CRYPTO_ALG_TYPE_CIPHER)
>                 do_cipher_specific_check();
>

Thank you very much for your help.
I'm sending the new version.

Salvatore
