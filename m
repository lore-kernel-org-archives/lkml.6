Return-Path: <SRS0=6f18=J7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25C18ECDFB0
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Jul 2018 04:29:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B0EA62086E
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Jul 2018 04:29:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="GUy8AVbc";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="MihlEDiH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B0EA62086E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726235AbeGOEuK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 15 Jul 2018 00:50:10 -0400
Received: from mail-yw0-f194.google.com ([209.85.161.194]:45479 "EHLO
        mail-yw0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725745AbeGOEuK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Jul 2018 00:50:10 -0400
Received: by mail-yw0-f194.google.com with SMTP id 139-v6so13127259ywg.12
        for <linux-kernel@vger.kernel.org>; Sat, 14 Jul 2018 21:28:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=+EIlnIIKPX9TWus6wjuen3Utq7Z3LweYXEi8HYW6oOc=;
        b=GUy8AVbc/cIRsCtuTl5497IU0rLhqk4fxX77S6RXAv9tOkKEoUQSp9fODAjEwnafjs
         rDVkbSd6jUI7JhQAl8RYpf/aiBzvhE4ok2eTiE6hZvedwvTzOnu57gcalKcapnMkoGxD
         CeYkVgj/tqLqU/GiM31hGGOpsJFK/z22ZJIN4Ju/SYbJLBPsJ9GQ2JqkZydDf0wWRTwu
         X4KjoJ/rIQES3yhE1A6Mdz34Ilmiv4j7ro17t7NuQKKDqr5qmuZRUWyR7MPlDWnt8Dsr
         4jx9kts0DHSUJV3w4L0foBNmBvNSpd4yry0QB35sIhcJGaOZ61+e1j/xfglwy2A2i4H8
         JCeg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=+EIlnIIKPX9TWus6wjuen3Utq7Z3LweYXEi8HYW6oOc=;
        b=MihlEDiH0eSRgEyl9ik/B0+YJmbUnBYfIsBxkCqJrtk4LETjtdQJBzfjMwzSP1mSCV
         xBW04fv8XFf6uVqHa1aWAWP2UTYrQKr/zrr3fNEsM29p2I1/nn25gRbngZLMdjCM/uUO
         kImXzmudZZb98DvYSFt5xD5/gfxs18s8EfTQ0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=+EIlnIIKPX9TWus6wjuen3Utq7Z3LweYXEi8HYW6oOc=;
        b=pvYEXHlg4B8WSbauu5gxZCOJJ2jlTpsweoaCFZ4Hvs1kMmw41FzYzWY453GftI5lRD
         uH6f7VLr32LSF0LC/ZKWR5muNvK0731BfgYqiF0XtIXHfxmWLrCGSgg0k3gYuOQxCpY+
         L/xAgyqTxkW7JOahnjyYIBwhSwbBl4tch+LuXs3WYzmberM7m/8YLnl2wbN3CoqjdUrU
         d10Gms9rpP7h+QB3II3USECQSbti8cI5CxSmyWQIQjC9+UMyjvODap/OJuLKLCoXypIQ
         L7sNMp6oKOWd7m2UBd+IqXaQJ9zQl4/PA8SmuIBixaWNHrC38QmaQurRbFUi9Sv+knwL
         Gr7Q==
X-Gm-Message-State: AOUpUlFmAq/hnWG4thM+ln9b0646VA4/7I83tjemkyvD/MgzF2GMEci8
        SU/kgDdI+CO4PtXRoQinnRPz15tEjnVxpQMQYDgIsA==
X-Google-Smtp-Source: AAOMgpdLvohSWqhXCnShH+5mqWO/45IrHyBml5kTu33FSgSWAGOnzGWVYLaTWfyw57LItWQCUiBlSRn3MgtbRDwkF/g=
X-Received: by 2002:a0d:fa42:: with SMTP id k63-v6mr6153355ywf.53.1531628918984;
 Sat, 14 Jul 2018 21:28:38 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a25:6602:0:0:0:0:0 with HTTP; Sat, 14 Jul 2018 21:28:38
 -0700 (PDT)
In-Reply-To: <CAK8P3a3nk4-EewKTXcLENTb86r1+bJz_WrkJoJt+D1uTwcpxPA@mail.gmail.com>
References: <20180711203619.1020-1-keescook@chromium.org> <20180711203619.1020-12-keescook@chromium.org>
 <CAK8P3a3356dbruUfS_+fj9f+X-0jbNE8WMe5sWhJmuRY9Nvcbg@mail.gmail.com>
 <20180713004038.lwibdesz7ohhoind@gondor.apana.org.au> <CAGXu5jLYmC7U=bucFZCLsSXNX=T4WhCccR6hx9dwROYF+ZMt0Q@mail.gmail.com>
 <20180713034406.zwu2pkp3f2onybxs@gondor.apana.org.au> <CAGXu5jLR0zJ6b9axJuG_uvttNShNcN3rhQKGVjW37qPd9saY-Q@mail.gmail.com>
 <20180713052029.cfo24bsr5swtbdja@gondor.apana.org.au> <CAGXu5jLG4gE44z9cXL3-D1bjbZB1RgTnTsb3PWhU7B3NdRrwVg@mail.gmail.com>
 <CAK8P3a3nk4-EewKTXcLENTb86r1+bJz_WrkJoJt+D1uTwcpxPA@mail.gmail.com>
From:   Kees Cook <keescook@chromium.org>
Date:   Sat, 14 Jul 2018 21:28:38 -0700
X-Google-Sender-Auth: xC8bVYLXF0eFQScVuWfA-Mo9BgI
Message-ID: <CAGXu5j+Q_jc_f9VybyoJqmV7_Q-3hqnC-pOubfNsi7uyAROVrQ@mail.gmail.com>
Subject: Re: [PATCH v4 11/14] treewide: Prepare to remove VLA usage for AHASH_REQUEST_ON_STACK
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
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        "open list:HARDWARE RANDOM NUMBER GENERATOR CORE" 
        <linux-crypto@vger.kernel.org>, qat-linux@intel.com,
        dm-devel@redhat.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 13, 2018 at 3:14 AM, Arnd Bergmann <arnd@arndb.de> wrote:
> On Fri, Jul 13, 2018 at 8:00 AM, Kees Cook <keescook@chromium.org> wrote:
>> On Thu, Jul 12, 2018 at 10:20 PM, Herbert Xu
>> <herbert@gondor.apana.org.au> wrote:
>>> On Thu, Jul 12, 2018 at 10:17:29PM -0700, Kees Cook wrote:
>>>> What is the correct value to use for AHASH_REQUEST_ON_STACK?
>>>
>>> As I said to arrive at a fixed value you should examine all sync
>>> ahash algorithms (e.g., all shash ones plus ahash ones marked as
>>> sync if there are any).
>>
>> The "value" for the ahash I understand: it has a request size
>> (tfm->reqsize, as set by crypto_ahash_set_reqsize()) what should be
>> used to measure the shash value? (And how does this relate to the
>> value returned by crypto_ahash_reqsize()?) The closest clue I can find
>> is this:
>>
>> crypto_init_shash_ops_async() does:
>>         crt->reqsize = sizeof(struct shash_desc) + crypto_shash_descsize(shash);
>>
>> and that gets called from crypto_ahash_init_tfm(), so if it starts
>> with the above reqsize and adds to it with a call to
>> crypto_ahash_set_reqsize() later, we'll have that maximum?
>>
>> So, do I want to calculate this answer as:
>>
>> sizeof(struct shash_desc) + max(shash descsize) + max(ahash-sync reqsize) ?
>> 16 + 360 + 0
>
> I arrived at the same number, looking at all the sizes in shash,
> The largest I found are sha3_state (360 bytes) and s390_sha_ctx
> (336 bytes), everything else is way smaller.

Excellent. Thanks for double-checking this. :)

>
>> It's 0 above because if I look at all the callers of
>> crypto_ahash_set_reqsize() that do wrapping, all are ASYNC.
>>
>> So, should this really just be 376? Where is best to validate this
>> size, as it seems checking in crypto_ahash_set_reqsize() is
>> inappropriate?
>
> How about crypto_init_shash_ops_async()?

Ah yes, that looks good. Nice find!

After my ahash to shash conversions, only ccm is left as an ahash
user, since it actually uses sg. But with the hard-coded value reduced
to 376, this doesn't trip the frame warnings any more. :)

I'll send an updated series soon.

-Kees

-- 
Kees Cook
Pixel Security
