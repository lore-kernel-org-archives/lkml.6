Return-Path: <SRS0=bmN+=JH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CCD1C43143
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 20:19:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2758821EFB
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 20:19:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="ggNeE2v8";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="OZWe0G/z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2758821EFB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933467AbeFUUTq (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Jun 2018 16:19:46 -0400
Received: from mail-yw0-f195.google.com ([209.85.161.195]:35749 "EHLO
        mail-yw0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933292AbeFUUTo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jun 2018 16:19:44 -0400
Received: by mail-yw0-f195.google.com with SMTP id n82-v6so1162320ywc.2
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jun 2018 13:19:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=AMlwUJiNmINznjP95pYnUa+y2ojcqDdqmTUqgIUWHvE=;
        b=ggNeE2v88/eV23FYYjjFVY2VeehisaO5iC75Zv7uX1osbxXCkBJMWlxXdoFEER2MtY
         du5IBW87UmZmogUoSb2hCAxolQWNe3B5xL+xyoXNUFTn6ECTkmd6BARu0tc4W+G0+nna
         St+uAt046MIn8W0qV6JR5gyxglXTHy92tz/T7q2uCGxWxE5g+cK9f+0cAySh4Fk+bkjA
         L3IuMWIxTVSVgbVLTRa5FD/XMggpAIuhoozElXCZJAndVx7IkS5jjpCmX863z3cMvQF0
         sgAXPWly3ZEoIYQYnjmlk8qF5aLShKkQzvAeo2pHx8nkHcd+GIr9a2BEyDkGcQp2hSwx
         en7w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=AMlwUJiNmINznjP95pYnUa+y2ojcqDdqmTUqgIUWHvE=;
        b=OZWe0G/zMGniMaUZ1CyJ1Th/PV4iqM94d0/EFMnlA/gqo36OK9jKwcJn/xLODPwlbT
         qk4GsLpIBz6CMm7YdXuC6qmhGwiVTklL6SN7YXd7biEXfJp11oL/4unVTPnMLQo+c2pM
         BzycPYcIZxuplvKiFNdSOPraxvAqGrsWQShh0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=AMlwUJiNmINznjP95pYnUa+y2ojcqDdqmTUqgIUWHvE=;
        b=Mjhg8HUEwZG6XCRjjEoo5xpOG7RlU7nRZVLAKp1yoNVi5CNXAWhz/oKtY+qFjgLVEf
         cpcKu0zDMGixJpHzAR48kcFELxrmfS++6LKdgKP8WpGHYtLVVjdWngfCU1Lxi+nFm/gA
         VKzBSxIAgoalgOrdRPAa7QhCc2RWbe/Z1WV/CpsAqnJUZ1dLboZVzjAKqftGZPGtNPn2
         //tM6qVNG9SRBk2LSsWbE/xdfOoxgfeCORzO5HHX9W21rO2ROTrYqzGG+qFoOpEeOO+d
         dXU0bBdExYx/eirl90ENtNzbITLR54PjIGsvk54BY8CY6fIGD4Q/mO+AOHIgrxYCbpga
         FK2A==
X-Gm-Message-State: APt69E1JWguTmWmgnJql3tWX+LQGEq5xywsXQ1ZWGKeD2bw4PJf1viEW
        uxtUvw8elVl5qb/dSj3gxQMnl34MjFgTlhaa9j+lCA==
X-Google-Smtp-Source: ADUXVKItNwPQdYS9fcDkDEujJLXFFWY33OVXaWsZY1mVfTnXcSqCSlQwIpJh09EJS61rNL8tXIDxQWVmTcfvBbEh2Oc=
X-Received: by 2002:a81:8743:: with SMTP id x64-v6mr12955434ywf.129.1529612383525;
 Thu, 21 Jun 2018 13:19:43 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a25:d6c5:0:0:0:0:0 with HTTP; Thu, 21 Jun 2018 13:19:42
 -0700 (PDT)
In-Reply-To: <20180621023054.5jx5s3jzap3soe6e@gondor.apana.org.au>
References: <20180620190408.45104-1-keescook@chromium.org> <20180620190408.45104-5-keescook@chromium.org>
 <20180621023054.5jx5s3jzap3soe6e@gondor.apana.org.au>
From:   Kees Cook <keescook@chromium.org>
Date:   Thu, 21 Jun 2018 13:19:42 -0700
X-Google-Sender-Auth: aXPmKn77CFkyZMm7LuSXMqu5J9w
Message-ID: <CAGXu5j+nMXYL6F7A218yfu+AqroqcdMU-J3ibozaK=Nzza0Y8Q@mail.gmail.com>
Subject: Re: [PATCH 04/11] dm verity fec: Remove VLA usage
To:     Herbert Xu <herbert@gondor.apana.org.au>
Cc:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Alasdair Kergon <agk@redhat.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Eric Biggers <ebiggers@google.com>,
        Giovanni Cabiddu <giovanni.cabiddu@intel.com>,
        Lars Persson <larper@axis.com>,
        Mike Snitzer <snitzer@redhat.com>,
        Rabin Vincent <rabinv@axis.com>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        "David S. Miller" <davem@davemloft.net>,
        linux-crypto <linux-crypto@vger.kernel.org>, qat-linux@intel.com,
        dm-devel@redhat.com, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 20, 2018 at 7:30 PM, Herbert Xu <herbert@gondor.apana.org.au> wrote:
> On Wed, Jun 20, 2018 at 12:04:01PM -0700, Kees Cook wrote:
>> In the quest to remove all stack VLA usage from the kernel[1], this
>> uses the newly defined max digest size macro. Also adds a sanity-check
>> at use-time.
>>
>> [1] https://lkml.kernel.org/r/CA+55aFzCG-zNmZwX4A2FQpadafLfEzK6CC=qPXydAacU1RqZWA@mail.gmail.com
>>
>> Signed-off-by: Kees Cook <keescook@chromium.org>
>> ---
>>  drivers/md/dm-verity-fec.c | 5 ++++-
>>  1 file changed, 4 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/md/dm-verity-fec.c b/drivers/md/dm-verity-fec.c
>> index 684af08d0747..0dfcc52835bc 100644
>> --- a/drivers/md/dm-verity-fec.c
>> +++ b/drivers/md/dm-verity-fec.c
>> @@ -212,12 +212,15 @@ static int fec_read_bufs(struct dm_verity *v, struct dm_verity_io *io,
>>       struct dm_verity_fec_io *fio = fec_io(io);
>>       u64 block, ileaved;
>>       u8 *bbuf, *rs_block;
>> -     u8 want_digest[v->digest_size];
>> +     u8 want_digest[AHASH_MAX_DIGESTSIZE];
>>       unsigned n, k;
>>
>>       if (neras)
>>               *neras = 0;
>>
>> +     if (WARN_ON(v->digest_size < sizeof(want_digest)))
>> +             return -EINVAL;
>
> How about verifying digest_size in the ahash API when algorithms
> are registered?

That happens already in ahash_prepare_alg() (and see the tweak in
patch 3 "crypto: ahash: Remove VLA usage"), but I wanted to keep these
run-time checks to avoid any problems in the future of things change.
As it's marked as "unlikely" internal to WARN_ON, this shouldn't have
a performance impact.

-Kees

-- 
Kees Cook
Pixel Security
