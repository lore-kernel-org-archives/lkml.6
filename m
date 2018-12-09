Return-Path: <SRS0=cWqk=OS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90566C65BAF
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Dec 2018 06:20:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 52ECB20837
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Dec 2018 06:20:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="Q58Es1dz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 52ECB20837
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726154AbeLIGUD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 9 Dec 2018 01:20:03 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:33574 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726066AbeLIGUC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Dec 2018 01:20:02 -0500
Received: by mail-pg1-f194.google.com with SMTP id z11so3516445pgu.0
        for <linux-kernel@vger.kernel.org>; Sat, 08 Dec 2018 22:20:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=KsUYlcXzKm/UKKYGb/7A7EVppzI14sZkMJSXxWtlLdo=;
        b=Q58Es1dzUJP02dv0h99RLvwF8q9hSoWlIw8GQFlt+GPdu2XJQD9lItkfzkA1Y0ARDe
         C8HEL4eu8+OwY/lS9vMSiuU3/H0AcO83V5aPlufx3g849dAWaFB3mB1JD8dP9ZurPbF/
         bjztVyguEOE0rEMtVvHH5orhoMphLIJQnftjlmblt1yvNqX6J7ATeVSlmJjuN1Dowjtq
         RWDXGN4EEfzLGAlD71kob7JNUL5JoPmObJR64YK4ElloBeJFZHv3GnS5sI2+JpTHvUlx
         w/+oFAdgCOxytFPuMbf+4SiHbSQJECZ4gri0P8ecvwxWZdnioYAMT1x/CNIzTjGZ2WFr
         QmDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=KsUYlcXzKm/UKKYGb/7A7EVppzI14sZkMJSXxWtlLdo=;
        b=t61xQzEJwWmn9QHQ3+fV4qSL5hRTYRqqs8UBJzhMyKHDY0uMc+l5bu99JIgBEdaRL9
         zWB6TBeAoMw/c8O5pG7HDn+rQy7bBlpm11dBTeGmqVUAwEhM8QcQB0lGUL/B4BsLOU5U
         LrRZB803/0yWOULiAm/4+HEKDXHc2lZUQnO7OKx4uODeWB0g9gMFtPUzZv09napa1U8j
         CToZElQcth8lk6M+G1d+9PEdvYpzLVE1qBK5GMu1A1zzvCdvnukwQmpXuuv6wAMPcFOi
         e9iREVxuNl7bdz5ahEcqDnpQ/F69jiIa7o9PxiwKeomfHVz1lPjIYGOgxcR5M6dFOXXV
         THrw==
X-Gm-Message-State: AA+aEWZMwv9t1RkQLR2i4kIXrgv0I2SRxXiyRgRtCyxfreuXUYWCabns
        gGkb0zyPmb9uPUs9x7pQshtanw==
X-Google-Smtp-Source: AFSGD/Wa4xKsKXV2NeYzqy6MRwVzC3UT+zhoaEmt1HhU53xC66LFw7zpjXszaZqt1Rn/5SS6M4jZSg==
X-Received: by 2002:a63:1e17:: with SMTP id e23mr6974841pge.130.1544336401764;
        Sat, 08 Dec 2018 22:20:01 -0800 (PST)
Received: from [192.168.1.238] (66.29.188.166.static.utbb.net. [66.29.188.166])
        by smtp.gmail.com with ESMTPSA id a90sm14897779pfj.109.2018.12.08.22.20.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 08 Dec 2018 22:20:00 -0800 (PST)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH 2/3] sbitmap: ammortize cost of clearing bits
From:   Jens Axboe <axboe@kernel.dk>
X-Mailer: iPhone Mail (16C5050a)
In-Reply-To: <20181209055146.GA17190@roeck-us.net>
Date:   Sat, 8 Dec 2018 23:19:59 -0700
Cc:     linux-block@vger.kernel.org, osandov@osandov.com,
        linux-kernel@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <6AAE999B-AB08-46D0-9DF8-9CED32E6141B@kernel.dk>
References: <20181130011234.32674-1-axboe@kernel.dk> <20181130011234.32674-3-axboe@kernel.dk> <20181209055146.GA17190@roeck-us.net>
To:     Guenter Roeck <linux@roeck-us.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Dec 8, 2018, at 10:51 PM, Guenter Roeck <linux@roeck-us.net> wrote:
>=20
> Hi,
>=20
>> On Thu, Nov 29, 2018 at 06:12:33PM -0700, Jens Axboe wrote:
>> sbitmap maintains a set of words that we use to set and clear bits, with
>> each bit representing a tag for blk-mq. Even though we spread the bits
>> out and maintain a hint cache, one particular bit allocated will end up
>> being cleared in the exact same spot.
>>=20
>> This introduces batched clearing of bits. Instead of clearing a given
>> bit, the same bit is set in a cleared/free mask instead. If we fail
>> allocating a bit from a given word, then we check the free mask, and
>> batch move those cleared bits at that time. This trades 64 atomic bitops
>> for 2 cmpxchg().
>>=20
>> In a threaded poll test case, half the overhead of getting and clearing
>> tags is removed with this change. On another poll test case with a
>> single thread, performance is unchanged.
>>=20
>> Signed-off-by: Jens Axboe <axboe@kernel.dk>
>=20
> This patch results in irq lock inversion warnings when trying to boot
> from usb drives. This was observed with qemu boots of aarch64, x86, and
> x86_64 images.

This one is a false positive, was already reported last week. Just need to a=
dd some lockdep annotation for it.=20


