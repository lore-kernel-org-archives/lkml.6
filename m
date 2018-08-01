Return-Path: <SRS0=pNWC=KQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF8D3C28CF6
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 15:38:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7188820862
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 15:38:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="hya25vmD";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="n7SBZdF2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7188820862
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389965AbeHARYU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Aug 2018 13:24:20 -0400
Received: from mail-yb0-f194.google.com ([209.85.213.194]:41258 "EHLO
        mail-yb0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389727AbeHARYU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Aug 2018 13:24:20 -0400
Received: by mail-yb0-f194.google.com with SMTP id s8-v6so7695677ybe.8
        for <linux-kernel@vger.kernel.org>; Wed, 01 Aug 2018 08:38:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=RXODYIZ5sIi9NOGc6vLxhNMPVhnO9s9qRUW8Qjuiwx8=;
        b=hya25vmDioRDp3AyiFY3ZOMU9R0ppK9Pd849bJrpN+MmF9f3qDAPuw0uSyhm/cPd7L
         5D+avCKni8mQs/zau4+18VOQYsuQVWBp+9h7nvHFdF54DSFWCC5+wIT1PLStRnnkJZAc
         gWZ2OSUaDI30DJvG7OsIWsK2JaSy63PZAb8KVgxqkTAkA/V4ohyobO65keQ+cpxql48a
         qaweNSfF/ASh53IbYY/7Qv/NGVc5VjGcZiVCUhmK9k/0E7OsK1oQYY8JBqGQzwj22m/b
         eae64bKz2tS8ZaiFxv+Xm3/5SJGYgWphNqPu6zGbfi31z911dAKcSrcFuv1UkORExpkz
         lZwQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=RXODYIZ5sIi9NOGc6vLxhNMPVhnO9s9qRUW8Qjuiwx8=;
        b=n7SBZdF2D/EDpxO0awWBQ+HYvF0uZnAcDO4JI0WdZaYzRAybFoYy/KSshOk/SSDksZ
         nLvO2mL4S1u0uwDl1E03QjJaory80Cl748MksseqSwHuuFtTXM1aX6ScIvZrbSFhl85N
         7AxdcnbIllvbj2gVisQcmLYRWu2o/WWI5f61E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=RXODYIZ5sIi9NOGc6vLxhNMPVhnO9s9qRUW8Qjuiwx8=;
        b=Rx3WnZKZ1AyZV8yodod0p+paZ8DfgKObfplbPCRK5V1N68TVd2JZ+xnMTulXE96ZNQ
         LlyXPyGp8zqb1jJWT2Vsotb8slVHu1MJprLzgOpKR3ImA+pbPjmT1jgMsjxCFaO/pLs7
         7CZS9eAYioGubHDAeCHu+xDeRKYJPtctl+kODLMMAZ1Q8agbQ6FxJvtncC23S9ejO37M
         lgmffFkfB5G3JM1xtTbkiruhMdxbM18vU9BsBNB/s7IWaERv0J94n7hc6TMRkNduZECD
         YUZ9T12t71svXQLKM+kR3fNA1glhz2g58Bw5/IEDMLzpRcPzcRDR4n8NQPYPVdz/+FyJ
         yyrw==
X-Gm-Message-State: AOUpUlHZ1uR1rJjHr88DY0JUdvdO7uwRDJ71OpFgTWCikBMbuymA3uzS
        lCuK0GPkCVLupPtljFjUV14cN+HPRbGxoM5PNteuvA==
X-Google-Smtp-Source: AAOMgpfnGA1J/HqH4egJC8IZ5MuExvoaPvKxgpVdG8qmDqfrbVgqa2yYENS0yI9pF1R5j7ogQGQFeR/Zy6l9vrp+vz0=
X-Received: by 2002:a25:a483:: with SMTP id g3-v6mr13872219ybi.309.1533137882151;
 Wed, 01 Aug 2018 08:38:02 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a25:6602:0:0:0:0:0 with HTTP; Wed, 1 Aug 2018 08:38:01 -0700 (PDT)
In-Reply-To: <20180801080724.2vgzagooda56aypw@mwanda>
References: <20180801000039.44314-1-keescook@chromium.org> <20180801000039.44314-2-keescook@chromium.org>
 <20180801075744.qpppbaywp5dklxul@mwanda> <20180801080724.2vgzagooda56aypw@mwanda>
From:   Kees Cook <keescook@chromium.org>
Date:   Wed, 1 Aug 2018 08:38:01 -0700
X-Google-Sender-Auth: XgNeWUqkWDkRYewA5vGx61otk-o
Message-ID: <CAGXu5j+=gBk=6Pva36HFj1L=Bz2O1+kzcUwUEu8eme_A4F5ktg@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] overflow.h: Add arithmetic shift helper
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Leon Romanovsky <leonro@mellanox.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Leon Romanovsky <leon@kernel.org>,
        Bart Van Assche <Bart.VanAssche@wdc.com>,
        Doug Ledford <dledford@redhat.com>,
        linux-rdma <linux-rdma@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 1, 2018 at 1:07 AM, Dan Carpenter <dan.carpenter@oracle.com> wrote:
> On Wed, Aug 01, 2018 at 10:57:44AM +0300, Dan Carpenter wrote:
>> The idea is nice, but I don't like the API.  The "_overflow" feels too
>> specific because maybe we could check for other things in the future.
>> Normally boolean macros should say they are boolean in the name and I
>> would prefer if it returned zero on failure.
>>
>>       if (!checked_shift(dest, mask, shift)) {
>>       if (!shift_ok(dest, mask, shift)) {
>>       if (!safe_shift(dest, mask, shift)) {
>
> Huh...  It turns out I put the argument order different as well.
>
> If we wanted to keep it returning 1 on failure then some other names
> are:
>
>         if (shift_failed(dest, mask, shift)) {
>         if (shift_error(dest, mask, shift)) {
>         if (shift_overflow(dest, mask, shift)) {

This is following the existing check_{add,mul}_overflow() helpers,
which are based on the gcc helpers. I'd like to keep things
consistent.

-Kees

-- 
Kees Cook
Pixel Security
