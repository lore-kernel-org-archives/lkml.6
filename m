Return-Path: <SRS0=sqHT=JP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFB3FC6778A
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 17:06:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7C5FC27884
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 17:06:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LQFck6+o"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7C5FC27884
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935285AbeF2RGg (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Jun 2018 13:06:36 -0400
Received: from mail-it0-f65.google.com ([209.85.214.65]:32854 "EHLO
        mail-it0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932734AbeF2RGf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jun 2018 13:06:35 -0400
Received: by mail-it0-f65.google.com with SMTP id k17-v6so2814159ita.0
        for <linux-kernel@vger.kernel.org>; Fri, 29 Jun 2018 10:06:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=yd2iVRocnBs8BddNf5Rho7fGizvBMGmzE8KvScPwwk4=;
        b=LQFck6+obKuVBQ3HbyGJ8uAGwXQXQkXV2SKBuzs0JCD+hJ+0Esk3ZQVyqLqa/ddyKO
         KKz+6TdhSbCYpyJXNbAJt9fo7KrVKq/kTILqmh0SGGXzuqgnZr3eLt4/6JV1as+z0cbi
         WAwFRyR6Z9oYASDeB6aVjUS7hAlARpVJc/ayJifVd2FnA6u71x70S6dtbH5jazmuPUmC
         nRGjqrQhjYnfa4FyiHlxEpL7kq/SbEjsvlrxYaG9nyd/uX+Y5d2uS8H4FjEQHj33JSyd
         N67G4Avtr07sJj5jzFue1EJeVgxgA10JZCNIYetX2fcKFsGb3/c4WmM6Pe+lD2kwa3sT
         WHwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=yd2iVRocnBs8BddNf5Rho7fGizvBMGmzE8KvScPwwk4=;
        b=snjGgSpSJUuZIUGmxOSduqCX1ZTOicZfocJWDZPm011n4puTNHU4wZpZ4TcYad+6aL
         lSmlkcvB6LzJ2TW+3A5ZIMkpXkWRoqdnfSxQOh7aVXS4XjoxAFaLcVDty34xD+aTCJYE
         85y3qlphZL33ZshcG8z7vA4Hj1yz3pZSX7MOKgx2x/st6OQbmLqe1HLaXLa+sXf4ACd5
         neWRLajPv6ooeHIFHDXLlM+PmIWN8o3ciMaaI5FNZyDw0rG8z6qNpsyOEsXIWxZnXtqz
         q1ObULZfXR9E0DBSX9VphWsbnFbqXUOeIG0CgGo7FEpSuh6YM1C7ZZ9X7MXB4rR7UpVb
         ffXA==
X-Gm-Message-State: APt69E0RL0hHp36PVFojMaP5+AUjW/AzDuTqXQAHBEIrBg/B/JbGY/dq
        1LAK/DLSER9GNl8cCaE8vpmXYR9Sl3xpiRRQhh1hnA==
X-Google-Smtp-Source: AAOMgpcKDJfhxjErHG7YoPAtsneWume7+ZVVbhYO5eq59jNU8Y8Rr3XKl+WPo6YiJ9mziKY1OwQXkd4mYxy6kB8qDxg=
X-Received: by 2002:a24:d51:: with SMTP id 78-v6mr2423168itx.103.1530291994624;
 Fri, 29 Jun 2018 10:06:34 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1529915117.git.zong@andestech.com> <20180629072307.GF12956@infradead.org>
In-Reply-To: <20180629072307.GF12956@infradead.org>
From:   Zong Li <zongbox@gmail.com>
Date:   Sat, 30 Jun 2018 01:06:23 +0800
Message-ID: <CA+ZOyahMwEtrG+uzQqGtbfmbeyBDNQVQJUn9oyaMfJb2wNmybw@mail.gmail.com>
Subject: Re: [PATCH v2 0/4] Building for 32-bit RISC-V kernel
To:     hch@infradead.org
Cc:     Zong Li <zong@andestech.com>, Palmer Dabbelt <palmer@sifive.com>,
        linux-riscv@lists.infradead.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        greentime@andestech.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Hellwig <hch@infradead.org> =E6=96=BC 2018=E5=B9=B46=E6=9C=8829=
=E6=97=A5 =E9=80=B1=E4=BA=94 =E4=B8=8B=E5=8D=883:23=E5=AF=AB=E9=81=93=EF=BC=
=9A
>
> Btw, what kind of userspace do you use for riscv32?  Do you have an
> easy to use root file system available somewhere (or a way to build
> one)?

I'm porting 32 bit riscv glibc now, and it is almost completion but
still has few fail cases of glibc testsuite.
I built the root file system consist of busybox, bash and dropbear and
so on. I can push the
rootfs I used or a build script to github if somebody need it.
