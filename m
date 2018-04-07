Return-Path: <kernel-hardening-return-12883-gregkh=linuxfoundation.org@lists.openwall.com>
X-Google-Smtp-Source: AIpwx4/b6/L8yCMm0hcFOpl3x7cuVD2bsHCKJyHaNtqIY/Ov+vhc6e5cZKPM+SI4WE5OIKMcMwWU
ARC-Seal: i=1; a=rsa-sha256; t=1523131016; cv=none;
        d=google.com; s=arc-20160816;
        b=ODE/Bxkeo2AfG7f9a/5p4qZpaZJ9RxE4MuUezSRQPqIWTrEHcarKXzMsJvvb35j6uN
         99JoGRmheaQB7BEGZCkt1XV9fCCmLz1EPgZiXp++iSL27/D596VS9tGOXhRa2Puv2K6V
         VLVJ6vycBJ9mDf5XXbBhr27Fpy/3j6JXPL/RYDliuhx18iH+GpCkxMsMdaxG52xsEOE4
         g9TJb1xr0QWRWH2NgsztH/7LbKTQZSCA09w8R4acZybyXH80Yk/L4PK3t+aHaewI2Dh4
         uo/nbRr9UXDxJn9+7R2jJRFk8sl8ee25xO/FAxQc5YxX7q7aEHNxna+qtRf/1nfpgsXP
         qmWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to:sender
         :mime-version:dkim-signature:dkim-signature:delivered-to:list-id
         :list-subscribe:list-unsubscribe:list-help:list-post:precedence
         :mailing-list:arc-authentication-results;
        bh=V4LE1CiTkx9EIvRSlhDpkIZspb3GdA19M9eIGvgx4kI=;
        b=o2DCWjv+j+7WUpIsOHYq/DVFQq3fOII6JvueadKNKZEil4T4u18OYmEjVUsbMWajQW
         RsYsKg0BQLjuYCiKdWq2n/mWb/D/RkiSCpM7ZlUhBc76x5znu2vx5He+PR7Tr2WpYPsm
         4eS+/2ptD/EgcyCI+sNbBLNZrJKgGACJyhXhWGexZUVbwLpOyRSpFHQwXsdLMtDpxnfV
         yrCTRY1XSvYJNhD/hJM2umStGRldNdZ5AJPesane+1r8rqe4JL7gvPiCrFKYGJbJU43W
         AFSE/3yY7Xk6BxAkjtThGdR1Q0pVsMnwycs1Thc71Xpo3TYNHUcS+ycD7yVBFMkEbTpI
         8dnA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@google.com header.s=20161025 header.b=euflMiQM;
       dkim=pass header.i=@chromium.org header.s=google header.b=mXmWn0mg;
       spf=pass (google.com: domain of kernel-hardening-return-12883-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12883-gregkh=linuxfoundation.org@lists.openwall.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=chromium.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@google.com header.s=20161025 header.b=euflMiQM;
       dkim=pass header.i=@chromium.org header.s=google header.b=mXmWn0mg;
       spf=pass (google.com: domain of kernel-hardening-return-12883-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12883-gregkh=linuxfoundation.org@lists.openwall.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=chromium.org
Mailing-List: contact kernel-hardening-help@lists.openwall.com; run by ezmlm
List-Post: <mailto:kernel-hardening@lists.openwall.com>
List-Help: <mailto:kernel-hardening-help@lists.openwall.com>
List-Unsubscribe: <mailto:kernel-hardening-unsubscribe@lists.openwall.com>
List-Subscribe: <mailto:kernel-hardening-subscribe@lists.openwall.com>
MIME-Version: 1.0
Sender: keescook@google.com
In-Reply-To: <1523126303-23205-1-git-send-email-s.mesoraca16@gmail.com>
References: <1523126303-23205-1-git-send-email-s.mesoraca16@gmail.com>
From: Kees Cook <keescook@chromium.org>
Date: Sat, 7 Apr 2018 12:56:34 -0700
X-Google-Sender-Auth: Z6mpNoaWii-96O27GfckO9Pks_A
Message-ID: <CAGXu5j+cETZ7udEG9pgmxfdwZLmNzO0Br4KAL7_ZdyOP2_CANQ@mail.gmail.com>
Subject: Re: [PATCH 0/6] Remove several VLAs in the crypto subsystem
To: Salvatore Mesoraca <s.mesoraca16@gmail.com>
Cc: LKML <linux-kernel@vger.kernel.org>,
	Kernel Hardening <kernel-hardening@lists.openwall.com>,
	linux-crypto <linux-crypto@vger.kernel.org>, "David S. Miller" <davem@davemloft.net>,
	Herbert Xu <herbert@gondor.apana.org.au>, Eric Biggers <ebiggers3@gmail.com>,
	Laura Abbott <labbott@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1597113743875859229?=
X-GMAIL-MSGID: =?utf-8?q?1597118628667923136?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Sat, Apr 7, 2018 at 11:38 AM, Salvatore Mesoraca
<s.mesoraca16@gmail.com> wrote:
> As suggested by Laura Abbott[2], I'm resending my patch with
> MAX_BLOCKSIZE and MAX_ALIGNMASK defined in an header, so they
> can be used in other places.
> I take this opportuinuty to deal with some other VLAs not
> handled in the old patch.
>
> [1] http://lkml.kernel.org/r/CA+55aFzCG-zNmZwX4A2FQpadafLfEzK6CC=qPXydAacU1RqZWA@mail.gmail.com
> [2] http://lkml.kernel.org/r/4e536889-439a-49e6-dd95-2d4286913202@redhat.com
>
> Salvatore Mesoraca (6):
>   crypto: api - laying macros for statically allocated buffers
>   crypto: ctr - avoid VLA use
>   crypto: api - avoid VLA use
>   crypto: pcbc - avoid VLA use
>   crypto: cts - avoid VLA use
>   crypto: cfb - avoid VLA use
>
>  crypto/cfb.c      | 14 ++++++++++----
>  crypto/cipher.c   |  7 ++++++-
>  crypto/ctr.c      | 13 +++++++++++--
>  crypto/cts.c      |  8 ++++++--
>  crypto/internal.h |  8 ++++++++
>  crypto/pcbc.c     |  9 +++++++--
>  6 files changed, 48 insertions(+), 11 deletions(-)

These all look good to me! Thanks for the refactoring. :)

Reviewed-by: Kees Cook <keescook@chromium.org>

-Kees

-- 
Kees Cook
Pixel Security
