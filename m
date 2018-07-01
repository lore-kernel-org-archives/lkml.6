Return-Path: <SRS0=zLEl=JR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B7D1C6778A
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Jul 2018 17:05:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D682625567
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Jul 2018 17:05:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="bxax1jf1";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="QJaFb9Rf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D682625567
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965199AbeGARFL (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 1 Jul 2018 13:05:11 -0400
Received: from mail-yb0-f195.google.com ([209.85.213.195]:42383 "EHLO
        mail-yb0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753592AbeGARFB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Jul 2018 13:05:01 -0400
Received: by mail-yb0-f195.google.com with SMTP id i3-v6so4298196ybl.9
        for <linux-kernel@vger.kernel.org>; Sun, 01 Jul 2018 10:05:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=8XFHVqQJumXHMdiabsqInOElStobXUDH3ocPWki42zM=;
        b=bxax1jf11oeJWP/1EfEBwnZlivmYMa2ZMhHEnKlzDMkzWQdxxhzQkHZII2EJXjlD/w
         7LzxxwDcbKiMUYRo90EbrBxu73b85IhwfGT+UTxOt3rXMoUc9TawGs9rgw2jEBPRtKpB
         2JykqPqiYdMl2A/Nvcxj7MnvtMfyMph/SwAB12b6CQ06gGqgFhe/jBfjjsjzcAm7UuFD
         9wgC/4qFMwcFiW4Fess427ioXQqtzCdAnm6r4a0Nqznn7uD2aIOMiyvTKpEC785leHlV
         oe+TYIS8HPmhGQgDNqC3zw0UO5zDU85lN9+z2kawktR0T0dqwfhdEk72rGzF6ZuuhBoU
         ld/Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=8XFHVqQJumXHMdiabsqInOElStobXUDH3ocPWki42zM=;
        b=QJaFb9RfK/IS/T8IpCMEc3LRmBVMS8AFBbyazouRjGGWdOq2Q48vPQAnSiPq5b5FeW
         by5g9LW7zY7jxsqBEPOYlKXkFi1gHbeRPpftYHbakGRNnihKj9ItVShoJ3HMmb+8tOFD
         225pc3sMmlNSF/GxauQyNYMlVDzjYDQZ5oSd8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=8XFHVqQJumXHMdiabsqInOElStobXUDH3ocPWki42zM=;
        b=QHZM9ZT/8m2M1zKLt80JLDkZ9xzlc+jDriZSHLktz4iQixfprqDjUqUgc0+me2+6D1
         R3knn4UpnDYBh0DB95Oww4EpmKtmYptMjduzPH3DG4WpVFuqeQgmX1ak04dFkbgLueFA
         2bNHz22rIOtZ4jqjP/ClR8QGK3IVoGZ0uJvnfUPPRp80hYNFFlS7FltjBgOyOInPc+4h
         aLaC/K7kw+lZzsR9VKPHvl7DtSdyqje9rH2/XhS6wtkxvS9fvYf+qIrC7SQaeMsv4gVc
         Dbsgo4hb40uoE9h/HK9jmudghmJZcIMOdgpxycyRjflGsB8F4i5UYZHR16eOJAnlCpXc
         xfKw==
X-Gm-Message-State: APt69E3Iiy9Zz255W61FgFMoXjh0VM6eD4n9A0dn8WJ4LsLiC8rRPZYd
        YNCeeU7fANVSlwXCIXxZ19OWqmiwjLHkeUh6bkStYA==
X-Google-Smtp-Source: AAOMgpdZmSgU/HQltEg8hQtssxUR95s3lKTMsn/6kUCPCudY1G6nyO7knuwS5IFfcVe/AHFq5ELhbBr17Pdy1UEu0rU=
X-Received: by 2002:a25:ce8e:: with SMTP id x136-v6mr1113299ybe.118.1530464700355;
 Sun, 01 Jul 2018 10:05:00 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a25:5f51:0:0:0:0:0 with HTTP; Sun, 1 Jul 2018 10:04:59 -0700 (PDT)
In-Reply-To: <20180630070301.GA1706@sol.localdomain>
References: <20180629002843.31095-1-keescook@chromium.org> <20180629002843.31095-10-keescook@chromium.org>
 <20180630070301.GA1706@sol.localdomain>
From:   Kees Cook <keescook@chromium.org>
Date:   Sun, 1 Jul 2018 10:04:59 -0700
X-Google-Sender-Auth: wrvIhcpnoHVeAw2bOsB76kMKo1k
Message-ID: <CAGXu5jJ9eqETPdrvUZrV9bhnNQA6LwBuk+V5MeQrAS_M=_VX+Q@mail.gmail.com>
Subject: Re: [dm-devel] [PATCH v3 9/9] crypto: shash: Remove VLA usage in
 unaligned hashing
To:     Eric Biggers <ebiggers3@gmail.com>
Cc:     Herbert Xu <herbert@gondor.apana.org.au>,
        Giovanni Cabiddu <giovanni.cabiddu@intel.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Eric Biggers <ebiggers@google.com>,
        Mike Snitzer <snitzer@redhat.com>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        qat-linux@intel.com, LKML <linux-kernel@vger.kernel.org>,
        dm-devel@redhat.com, linux-crypto <linux-crypto@vger.kernel.org>,
        Lars Persson <larper@axis.com>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        "David S. Miller" <davem@davemloft.net>,
        Alasdair Kergon <agk@redhat.com>,
        Rabin Vincent <rabinv@axis.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 30, 2018 at 12:03 AM, Eric Biggers <ebiggers3@gmail.com> wrote:
> On Thu, Jun 28, 2018 at 05:28:43PM -0700, Kees Cook wrote:
>> @@ -88,11 +81,13 @@ static int shash_update_unaligned(struct shash_desc *desc, const u8 *data,
>>       unsigned long alignmask = crypto_shash_alignmask(tfm);
>>       unsigned int unaligned_len = alignmask + 1 -
>>                                    ((unsigned long)data & alignmask);
>> -     u8 ubuf[shash_align_buffer_size(unaligned_len, alignmask)]
>> -             __aligned_largest;
>> +     u8 ubuf[MAX_ALGAPI_ALIGNMASK + 1];
>>       u8 *buf = PTR_ALIGN(&ubuf[0], alignmask + 1);
>>       int err;
>>
>> +     if (WARN_ON(buf + unaligned_len > ubuf + sizeof(ubuf)))
>> +             return -EINVAL;
>> +
>
> How is 'ubuf' guaranteed to be large enough?  You removed the __aligned
> attribute, so 'ubuf' can have any alignment.  So the aligned pointer 'buf' may
> be as high as '&ubuf[alignmask]'.  Then, up to 'alignmask' bytes of data will be
> copied into 'buf'... resulting in up to '2 * alignmask' bytes needed in 'ubuf'.
> But you've only guaranteed 'alignmask + 1' bytes.

Hm, good point. Adding __aligned(MAX_ALGAPI_ALIGNMASK + 1) looks to
fix this, yes?

Also, if __aligned() is used here, can't PTR_ALIGN() be dropped? (I
think you pointed this out earlier.)

Also, is "unaligned_len" being calculated correctly? Let's say
alignmask is 63. If data is binary ...111111, then unaligned_len will
be 64 - 63 == 1, which is fine: we copy 1 byte out, bump the address
by 1, and we're happily aligned to ...000000. If data is ...000000,
then unaligned_len will be 64. But it should be 0. Shouldn't this be:

unsigned int unaligned_len;

unaligned_len = (unsigned long)data & alignmask;
if (unaligned_len)
    unaligned_len = alignmask + 1 - unaligned_len;

And then ubuf only needs to be MAX_ALGAPI_ALIGNMASK, without the +1?

-Kees

-- 
Kees Cook
Pixel Security
