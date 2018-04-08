Return-Path: <kernel-hardening-return-12889-gregkh=linuxfoundation.org@lists.openwall.com>
X-Google-Smtp-Source: AIpwx4/1hYPD7lw4J8DUR4h9nGdxbW8GXDZGfPD7uFy7md44xNj/gK7N/NdQjOKggVbvrsjvbgWG
ARC-Seal: i=1; a=rsa-sha256; t=1523177749; cv=none;
        d=google.com; s=arc-20160816;
        b=ha7O896x1rpTuKqQBeKUa7vZoekhnpkw1ME96ufT1I3hmXKx6RM9s4LStGt6S8TGkD
         4OL4joRcG/pMS/zuh3hN15WMCkgmzMXJkI9lX7fR2294XC3Xi2dtArxaQaQMGH9egrj1
         E7EWesh/PIDxIbv5QiFWGmlIP29Q2m86/hxje+mU8KXzeS8IpuUg693JGwRexqUA+iYR
         psDRnpLsiqf8C/ZD8ZcOtwg3mHBMPI5pzcleZAlzdJd+k8DP4su5wn8nUrcst5JhHPHK
         UEbxdQUXhdVUPPfK2ZfJVCRKoHYOBx98unumpaE2jKjiPcWzutdXA39N+QdwhviA6on6
         F9BA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:dkim-signature:delivered-to:list-id:list-subscribe
         :list-unsubscribe:list-help:list-post:precedence:mailing-list
         :arc-authentication-results;
        bh=qKsP/qas9OvfKvrgkVQ3baBiMl9ZDLuBuGEtHn2aAAg=;
        b=AnLL/V0UV7eV0j7yjJD6VbKNBUfCP1PREu3w/2bqba3Qw1fxLm3HDN1TmsdL+jMy89
         +x0m4xrB9P1pYoaKnqaHg2iGD4OWjpJUbzvygkxP4/V310XRDbXRTapvi/ZSLSEeHKTr
         E/tG0KR0M5nDpb77HFsK5tyUODzM4THd8Oa+3kMM5mkBwrvtjAiF6n9BSGnIRapdpU8R
         Lwhh7MiyzRnEGAIZ+W5QZPhputA/dRTTTPtNYkXZ5cYLqIyI4/bwgRPcZP2maJPqWdTM
         j5dQAOUTygrCPuCnO6O9Srzflyp3p1tv1zxzeUnnWpYCPxsGfP1soKPvSAYP/+AelOKD
         OTCQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=snl12KvI;
       spf=pass (google.com: domain of kernel-hardening-return-12889-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12889-gregkh=linuxfoundation.org@lists.openwall.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=snl12KvI;
       spf=pass (google.com: domain of kernel-hardening-return-12889-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12889-gregkh=linuxfoundation.org@lists.openwall.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Mailing-List: contact kernel-hardening-help@lists.openwall.com; run by ezmlm
List-Post: <mailto:kernel-hardening@lists.openwall.com>
List-Help: <mailto:kernel-hardening-help@lists.openwall.com>
List-Unsubscribe: <mailto:kernel-hardening-unsubscribe@lists.openwall.com>
List-Subscribe: <mailto:kernel-hardening-subscribe@lists.openwall.com>
MIME-Version: 1.0
In-Reply-To: <CAGXu5j+cETZ7udEG9pgmxfdwZLmNzO0Br4KAL7_ZdyOP2_CANQ@mail.gmail.com>
References: <1523126303-23205-1-git-send-email-s.mesoraca16@gmail.com> <CAGXu5j+cETZ7udEG9pgmxfdwZLmNzO0Br4KAL7_ZdyOP2_CANQ@mail.gmail.com>
From: Salvatore Mesoraca <s.mesoraca16@gmail.com>
Date: Sun, 8 Apr 2018 10:55:09 +0200
Message-ID: <CAJHCu1LLVoov_dHb-GuzyZpO3EVAwpeoJN_1PQHipBpAh8S1Gw@mail.gmail.com>
Subject: Re: [PATCH 0/6] Remove several VLAs in the crypto subsystem
To: Kees Cook <keescook@chromium.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
	Kernel Hardening <kernel-hardening@lists.openwall.com>,
	linux-crypto <linux-crypto@vger.kernel.org>, "David S. Miller" <davem@davemloft.net>,
	Herbert Xu <herbert@gondor.apana.org.au>, Eric Biggers <ebiggers3@gmail.com>,
	Laura Abbott <labbott@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1597113743875859229?=
X-GMAIL-MSGID: =?utf-8?q?1597167631468739467?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

2018-04-07 21:56 GMT+02:00 Kees Cook <keescook@chromium.org>:
> On Sat, Apr 7, 2018 at 11:38 AM, Salvatore Mesoraca
> <s.mesoraca16@gmail.com> wrote:
>> As suggested by Laura Abbott[2], I'm resending my patch with
>> MAX_BLOCKSIZE and MAX_ALIGNMASK defined in an header, so they
>> can be used in other places.
>> I take this opportuinuty to deal with some other VLAs not
>> handled in the old patch.
>>
>> [1] http://lkml.kernel.org/r/CA+55aFzCG-zNmZwX4A2FQpadafLfEzK6CC=qPXydAacU1RqZWA@mail.gmail.com
>> [2] http://lkml.kernel.org/r/4e536889-439a-49e6-dd95-2d4286913202@redhat.com
>>
>> Salvatore Mesoraca (6):
>>   crypto: api - laying macros for statically allocated buffers
>>   crypto: ctr - avoid VLA use
>>   crypto: api - avoid VLA use
>>   crypto: pcbc - avoid VLA use
>>   crypto: cts - avoid VLA use
>>   crypto: cfb - avoid VLA use
>>
>>  crypto/cfb.c      | 14 ++++++++++----
>>  crypto/cipher.c   |  7 ++++++-
>>  crypto/ctr.c      | 13 +++++++++++--
>>  crypto/cts.c      |  8 ++++++--
>>  crypto/internal.h |  8 ++++++++
>>  crypto/pcbc.c     |  9 +++++++--
>>  6 files changed, 48 insertions(+), 11 deletions(-)
>
> These all look good to me! Thanks for the refactoring. :)
>
> Reviewed-by: Kees Cook <keescook@chromium.org>

Thank you!

Salvatore
