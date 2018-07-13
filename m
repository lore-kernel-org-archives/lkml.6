Return-Path: <SRS0=Zbfl=J5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CD8DECDFB0
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 06:00:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0E1232124D
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 06:00:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="vdxgq0L/";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="bcV5jRZl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0E1232124D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727269AbeGMGNI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Jul 2018 02:13:08 -0400
Received: from mail-yw0-f193.google.com ([209.85.161.193]:37292 "EHLO
        mail-yw0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726380AbeGMGNI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jul 2018 02:13:08 -0400
Received: by mail-yw0-f193.google.com with SMTP id w76-v6so11345884ywg.4
        for <linux-kernel@vger.kernel.org>; Thu, 12 Jul 2018 23:00:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=zDPTvady3hGJuubgbaW82Z4ZxgnJXZxjC6mQHcULwIw=;
        b=vdxgq0L/u4a9KdhMsim9aFqPmupFGmI0b3kAhPKTHu6E68RR1EkGnjPxlpaLNRVgn4
         Sr99Hu9mO3BwryBAIULq/0FykMRdCrUSdiUUUHaIEJU3fFJfxZvjzkmfyrObuC9dZc7R
         uTS4yov5alAfO9i0qmzY5ChIWoUVK6jmihJspKJSpnur6uEvkrLElJlUUyudFLXeZc+x
         JVlDl7CeiC4HyHsP37ibt2j76XjX9W+B/PAkX9Siu+RlY9A9cFLegHlPZ0SRGuLg/x8E
         3894+DkNyrnN8c+BwAN55m9IbyOwHuF2cq75GZWOAF3vGusVjfZbLSDVhwmvPl+1LE4Y
         oGpA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=zDPTvady3hGJuubgbaW82Z4ZxgnJXZxjC6mQHcULwIw=;
        b=bcV5jRZlAAMmHkS3LN1KV+kqPDv6NlvX4cQ3/Iwu9RXsZufZquf7/6kUZGkFq1xRbG
         9zgP+s//h5jKTtj4seVSvfJzDLvNMOda4mXqrHpstP1V205pvA/6xC1k3nJOt9Oa2eU5
         wnkObmhnsnq3leCBgOKHmnLppel4hr4A6RNU0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=zDPTvady3hGJuubgbaW82Z4ZxgnJXZxjC6mQHcULwIw=;
        b=BAPuRDjrrnYyWowwZ0j46Ewj5pedOsTjz7UlkeOEiWOajPuLG0S9nof2CZ7aZKkElx
         h5YMOy+EuqKkAUC96TkmFAiJu3KIghEPDa1rIydc0/FiZ5ujLq79wB2df3zKA1JQVnn6
         Uq2XQxU2/1TUCUfpoYlKQdeQUsj35oO621iErg4J+8BxWmxUX+JZUGePcxMuTxodFukw
         1ocSdEnflfTf99Dgus1vb5tBBV5VzGz6j5ufTVqIukXz+ojfEsdSC1f7CNxoCAWDMI1s
         ZwD7foNw9Y75FytXpiPXPHQMk613BgyFjk5q3IscAUBYAlqZXT/aN/NcXydDCS0EO8ec
         5gfA==
X-Gm-Message-State: AOUpUlFbCrJYfaAn1CbDL50B4dMgKt4hgmBLDZVAEBoFA/3bLdqRKGsV
        Mfb/T+redMZp6q6lldC412VBVMKEQ12LW+OBtRc3SQ==
X-Google-Smtp-Source: AAOMgpcWRrFn0lL+exJ4dFVRFboXnxotYmDYCA+DU5+EyX70QpvnWZ3R6yZCk0s4M/lcq9MFqlag/GtnNP99QZVpg7o=
X-Received: by 2002:a81:2706:: with SMTP id n6-v6mr2531893ywn.88.1531461604333;
 Thu, 12 Jul 2018 23:00:04 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a25:5f51:0:0:0:0:0 with HTTP; Thu, 12 Jul 2018 23:00:03
 -0700 (PDT)
In-Reply-To: <20180713052029.cfo24bsr5swtbdja@gondor.apana.org.au>
References: <20180711203619.1020-1-keescook@chromium.org> <20180711203619.1020-12-keescook@chromium.org>
 <CAK8P3a3356dbruUfS_+fj9f+X-0jbNE8WMe5sWhJmuRY9Nvcbg@mail.gmail.com>
 <20180713004038.lwibdesz7ohhoind@gondor.apana.org.au> <CAGXu5jLYmC7U=bucFZCLsSXNX=T4WhCccR6hx9dwROYF+ZMt0Q@mail.gmail.com>
 <20180713034406.zwu2pkp3f2onybxs@gondor.apana.org.au> <CAGXu5jLR0zJ6b9axJuG_uvttNShNcN3rhQKGVjW37qPd9saY-Q@mail.gmail.com>
 <20180713052029.cfo24bsr5swtbdja@gondor.apana.org.au>
From:   Kees Cook <keescook@chromium.org>
Date:   Thu, 12 Jul 2018 23:00:03 -0700
X-Google-Sender-Auth: mEbHzL_Doy8uz-9G1Roqdvz9xrs
Message-ID: <CAGXu5jLG4gE44z9cXL3-D1bjbZB1RgTnTsb3PWhU7B3NdRrwVg@mail.gmail.com>
Subject: Re: [PATCH v4 11/14] treewide: Prepare to remove VLA usage for AHASH_REQUEST_ON_STACK
To:     Herbert Xu <herbert@gondor.apana.org.au>
Cc:     Arnd Bergmann <arnd@arndb.de>,
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

On Thu, Jul 12, 2018 at 10:20 PM, Herbert Xu
<herbert@gondor.apana.org.au> wrote:
> On Thu, Jul 12, 2018 at 10:17:29PM -0700, Kees Cook wrote:
>>
>> Then why does the instrumented tcrypt output show the huge size? Is
>> tcrypt doing something incorrectly?
>
> tcrypt doesn't even use AHASH_REQUEST_ON_STACK so I don't understand
> your point.

It's using crypto_ahash_set_reqsize(), which is what
AHASH_REQUEST_ON_STACK() reads back via crypto_ahash_reqsize() (i.e.
tfm->reqsize). It sounds like you're saying that there are cases where
an ahash is constructed (and will call crypto_ahash_set_reqsize()) but
where it cannot be used with AHASH_REQUEST_ON_STACK()? What actually
enforces this, since there will be a difference between
crypto_ahash_set_reqsize() (as seen with sha512-mb) and the actually
allowed stack usage. (i.e. where should I perform a check against the
new fixed value?)

>> What is the correct value to use for AHASH_REQUEST_ON_STACK?
>
> As I said to arrive at a fixed value you should examine all sync
> ahash algorithms (e.g., all shash ones plus ahash ones marked as
> sync if there are any).

The "value" for the ahash I understand: it has a request size
(tfm->reqsize, as set by crypto_ahash_set_reqsize()) what should be
used to measure the shash value? (And how does this relate to the
value returned by crypto_ahash_reqsize()?) The closest clue I can find
is this:

crypto_init_shash_ops_async() does:
        crt->reqsize = sizeof(struct shash_desc) + crypto_shash_descsize(shash);

and that gets called from crypto_ahash_init_tfm(), so if it starts
with the above reqsize and adds to it with a call to
crypto_ahash_set_reqsize() later, we'll have that maximum?

So, do I want to calculate this answer as:

sizeof(struct shash_desc) + max(shash descsize) + max(ahash-sync reqsize) ?
16 + 360 + 0

It's 0 above because if I look at all the callers of
crypto_ahash_set_reqsize() that do wrapping, all are ASYNC.

So, should this really just be 376? Where is best to validate this
size, as it seems checking in crypto_ahash_set_reqsize() is
inappropriate?

-Kees

-- 
Kees Cook
Pixel Security
