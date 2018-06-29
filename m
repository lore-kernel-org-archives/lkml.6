Return-Path: <SRS0=sqHT=JP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E756C6778C
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 21:56:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E77F42808F
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 21:56:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="hEvj1x9y";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Xr9EZ+vS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E77F42808F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936713AbeF2V4l (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Jun 2018 17:56:41 -0400
Received: from mail-yw0-f194.google.com ([209.85.161.194]:41549 "EHLO
        mail-yw0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934086AbeF2V4j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jun 2018 17:56:39 -0400
Received: by mail-yw0-f194.google.com with SMTP id j5-v6so4222403ywe.8
        for <linux-kernel@vger.kernel.org>; Fri, 29 Jun 2018 14:56:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=TpYkn8m2etMpCR0QwsktlSjBduqwjTKCppyk+pSh3EM=;
        b=hEvj1x9yhPX7qzU6S3jlSeIyiB0o8HPEo9s+Et/bCjAS8n3TRLxQFc65ZnjlElmmSS
         406r3g3//fIb0rbAnNjG1OSnihnCBMAS2nJwpkyKDZyK9HsiCLNsgW/XUHUAUSPlU/9T
         0IkXacrjET7Vy5oIC8wPkVzOMJlSgFqIC1YpqVrSY4LyMYXieAq2L0V5LWofJrS3Cy/x
         nTtQ/tkTm5WEaTYPe86FSoGjNANoh9SLpo0d34lBBcCloOuHiE6aZSAP0sht2M+TQnT/
         pyBeg1s4te+ALpnxlGFDYyQtXqdlA8RYvNa/HA0S4WONUd68GjeM4dU80ND1NgMLAbcy
         q38g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=TpYkn8m2etMpCR0QwsktlSjBduqwjTKCppyk+pSh3EM=;
        b=Xr9EZ+vSEKK+86Z6zWDJbvX6d0UMPVM9uC47BFYAb3Y5E+qkGTE4AypAplw8ApcYva
         i7Mt3KFjlqQ6TNf4mqnf52gKRLEf24SMyyoYgF7VHNcLKA/Dw5YiBJLxA2G6bQm6W4hj
         SbVXHL3Yqzx7mSjxB/7zTai9yL56NRY4KadvA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=TpYkn8m2etMpCR0QwsktlSjBduqwjTKCppyk+pSh3EM=;
        b=hMZ2cczmQCXzSJvyculp0JBD0jLaeUFkwwuJHiFaB13ukT5MmEvpbdUT4oOcBZaWYr
         eUeOgDKpVQdnVIqEts7/1xKNmfNcUWWJOmPkNAX3PipTPptjjkyIMiPbwJWai69JdYUC
         xtRi/jW8Iat85yiCM377lKT7Bnem3rnbZKryiVLdPrJWQyWBSi8MUaAOS9cKKmImLGe/
         NsCOx1LOg3IWbXnNMx4ZvYwUH8m15b3luqCG7vOS7FPKs3J89xj5xbTk4shtReiYudC2
         T7kHolrvQRxy6h+1yXB93IfRqXQbMuHCl/MXPUmTRQkdpAliSMoWQAOaYMZ+rzKe23L7
         nsNg==
X-Gm-Message-State: APt69E3hsm0BVKZc+C0m97TLISqdiS9EA2XZ/CeMxyKhZlWvZS2olDad
        Pp3bSgjED1UNrNjWzm/sO4xeyO95oza/fMeBDOubyw==
X-Google-Smtp-Source: AAOMgpc2U0ojfNEz6Sy/2iSZqPv2nUp5NdOVavEQ2pTtbzD1QbL6AGf0tosWc1NRtLnQruBj7EC9SjOZVrEbzYRbzqQ=
X-Received: by 2002:a81:8743:: with SMTP id x64-v6mr8167150ywf.129.1530309398418;
 Fri, 29 Jun 2018 14:56:38 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a25:5f51:0:0:0:0:0 with HTTP; Fri, 29 Jun 2018 14:56:37
 -0700 (PDT)
In-Reply-To: <CAK8P3a3F2y8B3a5zhYyG2KSMmSx5L3J3C_0sV-Csa0zPOzYJhA@mail.gmail.com>
References: <20180629002843.31095-1-keescook@chromium.org> <20180629002843.31095-5-keescook@chromium.org>
 <CAK8P3a3F2y8B3a5zhYyG2KSMmSx5L3J3C_0sV-Csa0zPOzYJhA@mail.gmail.com>
From:   Kees Cook <keescook@chromium.org>
Date:   Fri, 29 Jun 2018 14:56:37 -0700
X-Google-Sender-Auth: LQDn_4UNuYW42o07xnrrqL7il9g
Message-ID: <CAGXu5j+MLs-Jj7VCcpKS8Yo6MFAf=Nyf3jYsCbBoXnhtEvn4+g@mail.gmail.com>
Subject: Re: [PATCH v3 4/9] dm integrity: Remove VLA usage
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Herbert Xu <herbert@gondor.apana.org.au>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Eric Biggers <ebiggers@google.com>,
        Alasdair Kergon <agk@redhat.com>,
        Giovanni Cabiddu <giovanni.cabiddu@intel.com>,
        Lars Persson <larper@axis.com>,
        Mike Snitzer <snitzer@redhat.com>,
        Rabin Vincent <rabinv@axis.com>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        "David S. Miller" <davem@davemloft.net>,
        "open list:HARDWARE RANDOM NUMBER GENERATOR CORE" 
        <linux-crypto@vger.kernel.org>, qat-linux@intel.com,
        dm-devel@redhat.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 29, 2018 at 1:43 PM, Arnd Bergmann <arnd@arndb.de> wrote:
> On Fri, Jun 29, 2018 at 2:28 AM, Kees Cook <keescook@chromium.org> wrote:
>
>> diff --git a/drivers/md/dm-integrity.c b/drivers/md/dm-integrity.c
>> index 86438b2f10dd..85e8ce1625a2 100644
>> --- a/drivers/md/dm-integrity.c
>> +++ b/drivers/md/dm-integrity.c
>> @@ -521,7 +521,12 @@ static void section_mac(struct dm_integrity_c *ic, unsigned section, __u8 result
>>                 }
>>                 memset(result + size, 0, JOURNAL_MAC_SIZE - size);
>>         } else {
>> -               __u8 digest[size];
>> +               __u8 digest[SHASH_MAX_DIGESTSIZE];
>> +
>> +               if (WARN_ON(size > sizeof(digest))) {
>> +                       dm_integrity_io_error(ic, "digest_size", -EINVAL);
>> +                       goto err;
>> +               }
>
> I'm still slightly worried that some patches like this one could make
> things worse and lead to an actual stack overflow.

As in stack exhaustion? Yeah, this has been a concern of mine for the
crypto stuff because some combinations get BIG. My thinking has been
mainly that it means ALL cases will lead to a bad state instead of
only corner cases, which makes it easier to find and fix.

> You define SHASH_MAX_DIGESTSIZE
> as '512', which is still quite a lot to put on the kernel stack. The
> function also
> uses SHASH_DESC_ON_STACK(), so now you have two copies. Then you
> could call shash_final_unaligned(), which seems to put a third copy on
> the stack,
> so replacing each one with a fixed-size buffer adds quite a bit of bloat.
>
> Is there actually a digest that can be used in dm-integrity with more than 64
> byte output (matching JOURNAL_MAC_SIZE) here?

This conversion was following the existing check (PAGE_SIZE / 8), and
not via an analysis of alg.digestsize users. Let me double-check. For
predefined stuff, it looks like the largest is:

SKEIN1024_DIGEST_BIT_SIZE/8 == 128

I can drop this from 512 down to 128...

-Kees

-- 
Kees Cook
Pixel Security
