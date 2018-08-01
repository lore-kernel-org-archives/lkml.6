Return-Path: <SRS0=pNWC=KQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72CEFC28CF6
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 18:44:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 191AB20840
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 18:44:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="sCzXqWO8";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="MSjIIWiH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 191AB20840
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731699AbeHAUbb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Aug 2018 16:31:31 -0400
Received: from mail-yb0-f196.google.com ([209.85.213.196]:37445 "EHLO
        mail-yb0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726116AbeHAUba (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Aug 2018 16:31:30 -0400
Received: by mail-yb0-f196.google.com with SMTP id r3-v6so7942547ybo.4
        for <linux-kernel@vger.kernel.org>; Wed, 01 Aug 2018 11:44:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=JryO2vUObm+WbLxG4dh/x5ottxk2Pn5k6B8PgzUh6FM=;
        b=sCzXqWO8Ag/kmxdUAhbTEgUQkM14E/vuxJD3E1Q0h6DTa0R7IZ1OfPV0JG3fR7zatL
         FGABnD0iMBKbRuRJ+Pc43oVqu+b3HJoP7kjVZJ+PV7pDEjTZmTTEJ8ObBdgS6WXIu33w
         ZeQTwHbDLcHhgrvaYbGQYQnFqG3MyMQ6e9WOo6lb1l/RCAKDNhsw8DYwvHyveBMj6FSu
         EjgeI2MHUeWJv2PPP1NXz3uzH7DUtn6bFl/2RJMubUzFq9VBUuSDtJxwltbNYOX4CEAh
         Fup5KLyY0mXCR1kF9GSOqV+aF0u0LczIPTIZYiZMzqJr+AbPLOoiy5qPbF92R27S3os/
         VxUw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=JryO2vUObm+WbLxG4dh/x5ottxk2Pn5k6B8PgzUh6FM=;
        b=MSjIIWiHVdH4usexf+DrJioH3coyPBdPbvAbYt/b6O9P15qpncqmhUxcqaa0cMinjM
         57Uc4OPQPl08Zao4+k9KHF5zZhP16Vs9wxjZkn5xqkSaI03MReLXtz346b2kYNvh7mRg
         7wrvFK5IUYu5InEne/opjZToo1r9OH4BfiCB8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=JryO2vUObm+WbLxG4dh/x5ottxk2Pn5k6B8PgzUh6FM=;
        b=VgK9gvXM1Sy2V/Of/VaodC3K7P1BVSKSuKtDRB12ywJjJvB6LxvR7MOhDwrD54GZFm
         NNgHsPy8+mWVjrsde2NzVK/TqMmcdU184aT7Is0yYW7sUY/ksliqbMhoEKm4bWrx6hCe
         LTPkGSu0XCiPcfQsjTEJdPBdYZ5k1n58W7GDJ9yI2A16UBjar0/eYh0bW4/XLrjqC1PJ
         VWFZG2w2oB3d6/dCfDDTzYkUNoQAtv13+QkLHVkbbHhmzJnMj6Yq5oadSUwP246O0abQ
         gI1cSyuTV9qdY9g4hViD+RXTsSsm+wYg/NSyXsJSMTLF43vfNVLI1ZAB6AwtAByFveIn
         rU5g==
X-Gm-Message-State: AOUpUlG03OglXQjk59enfYmXjcoEJyp+Ubo7cxY/oOeYfu2wmmPCFTYy
        1hRyDQ/x94nxdUgd+wyAR6hDWGmg/js1R+jlE9HRyA==
X-Google-Smtp-Source: AAOMgpeqdgTTEr68lKbG+E6wV2npX4CCHFbAGQ2YiHJVjniUVKevIsl1paTU+GHNWA5k99MfeeqAb9trQMeW8NB4XC8=
X-Received: by 2002:a25:a483:: with SMTP id g3-v6mr14267418ybi.309.1533149063745;
 Wed, 01 Aug 2018 11:44:23 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a25:6602:0:0:0:0:0 with HTTP; Wed, 1 Aug 2018 11:44:22 -0700 (PDT)
In-Reply-To: <0568f73f-c1ff-1e9d-8ef9-04c46eb13d6e@infradead.org>
References: <20180801060947.16670-1-keescook@chromium.org> <20180801060947.16670-2-keescook@chromium.org>
 <0568f73f-c1ff-1e9d-8ef9-04c46eb13d6e@infradead.org>
From:   Kees Cook <keescook@chromium.org>
Date:   Wed, 1 Aug 2018 11:44:22 -0700
X-Google-Sender-Auth: fiLic5CIuXGJDjm1k2S6IKFG4Qs
Message-ID: <CAGXu5jJ7yKsCdcKiqoXAoBPsQbWZK4ERMJnK5chdwJtQ+2AAag@mail.gmail.com>
Subject: Re: [PATCH v3 1/3] overflow.h: Add arithmetic shift helper
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Leon Romanovsky <leonro@mellanox.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Leon Romanovsky <leon@kernel.org>,
        Bart Van Assche <Bart.VanAssche@wdc.com>,
        Doug Ledford <dledford@redhat.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        linux-rdma <linux-rdma@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 1, 2018 at 9:28 AM, Randy Dunlap <rdunlap@infradead.org> wrote:
> On 07/31/2018 11:09 PM, Kees Cook wrote:
>> From: Jason Gunthorpe <jgg@mellanox.com>
>>
>> Add shift_overflow() helper to assist driver authors in ensuring that
>> shift operations don't cause overflows or other odd conditions.
>>
>> Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>
>> Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
>> [kees: tweaked comments and commit log, dropped unneeded assignment]
>> Signed-off-by: Kees Cook <keescook@chromium.org>
>> ---
>>  include/linux/overflow.h | 31 +++++++++++++++++++++++++++++++
>>  1 file changed, 31 insertions(+)
>>
>> diff --git a/include/linux/overflow.h b/include/linux/overflow.h
>> index 8712ff70995f..69fc366ce865 100644
>> --- a/include/linux/overflow.h
>> +++ b/include/linux/overflow.h
>> @@ -202,6 +202,37 @@
>>
>>  #endif /* COMPILER_HAS_GENERIC_BUILTIN_OVERFLOW */
>>
>> +/** check_shift_overflow() - Calculate a left-shifted value and check overflow
>> + *
>> + * @a: Value to be shifted
>> + * @b: How many bits left to shift
>> + * @d: Pointer to where to store the result
>> + *
>> + * Computes *@d = (@a << @s)
>> + *
>
> missed                     @b [again]

Heh, thanks. It's fixed on disk, but... I failed to merge it into the
patch. Anyway, I'll spin this one more time with s/shift/shl/ and this
fixed.

-Kees

-- 
Kees Cook
Pixel Security
