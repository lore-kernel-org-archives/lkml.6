Return-Path: <SRS0=bmN+=JH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7BE9C43141
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 16:01:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 88B6E21104
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 16:01:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WsHZ0FMx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 88B6E21104
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933388AbeFUQB3 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Jun 2018 12:01:29 -0400
Received: from mail-lf0-f67.google.com ([209.85.215.67]:35507 "EHLO
        mail-lf0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933253AbeFUQB1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jun 2018 12:01:27 -0400
Received: by mail-lf0-f67.google.com with SMTP id i15-v6so5100347lfc.2;
        Thu, 21 Jun 2018 09:01:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=4k+TkGgYvKQsnv+ATqUw/aqsCSYKNSWpFfcCFRZIMsM=;
        b=WsHZ0FMxWcFeblW/c3fbydRLNzoMeAB9ib56bso6te/UfrE+ijXJ5l7f2d1UCk7JXF
         by1k808amSzg3PqtM8S0apJrXzGVLYWf8m2LC6ZUgtcHyr/oH2Lidw2RRwnBz3il8YZk
         Sfur6/jsV+9b4KL1AG8H5zZvj827xo3d3REyyiGrw2QEHbIydL9vj4U87AEfbkjw60xV
         VRUAd0RbBulkcuDAibEtKQdjsIAu6fRuBU3D4GwBZUpaYGfSSjL+idPBpqkvPhOdrcOU
         Besg7ZQJPajPVSm28R+JsCTAafs5fQMq5t2x55swEc/4IRndyzDznkorFCTJJ+/hOKrg
         xcQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=4k+TkGgYvKQsnv+ATqUw/aqsCSYKNSWpFfcCFRZIMsM=;
        b=A/VpwvGEVBeX2KRLQ/nD6ux/DM1nbJDk0c3s3pt7NzE+6CTwyOMU8Q4hsMb6CqXzDi
         HX8FbMP6v5f2qdLLM7m1SFhrskEz9ijmY5azIW6CtZz9ZM4QOqC93iHDlk0oNXoh/lXu
         Xhyxy6Sr413zpr+Sh05aCjqqeAKBvKEQC/xCthVyHTZSBA52mluY52XvyaZHTTXkS06F
         6O9FUC3KTBZ+kSAfeMnnsLlLVFzuKewM1LBNy9hYA2OLa7mF9HcrO06w1fR9Dwl+dP0w
         881ihHvMWO/Dr+v/5K3xN8ReEQzsnqrhRtXsjGWa6PQV7Hp77v9l4J0HJpU0SBVVO8CD
         xr2A==
X-Gm-Message-State: APt69E1uEZVNqAsuEOVYJW1dAa3SU+5dv56ZK/Pl2VqCx3SPEe5rwVEl
        k0r6WzgUic1gP4WdFfjFgLPf62nUaxlfGmc7r0I=
X-Google-Smtp-Source: ADUXVKIHFqN24HMueQxMKOcmbLEn3nal4NQSygTkc1vPP+sfvSQTSz/ImQf1hZIziPZie6t+xVpkFHaScgo8P5EbH88=
X-Received: by 2002:a2e:40d9:: with SMTP id r86-v6mr17367950lje.19.1529596885012;
 Thu, 21 Jun 2018 09:01:25 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a2e:56c8:0:0:0:0:0 with HTTP; Thu, 21 Jun 2018 09:01:24
 -0700 (PDT)
In-Reply-To: <20180621154915.GA31947@gmail.com>
References: <20180420120605.1612248-1-arnd@arndb.de> <20180420120605.1612248-2-arnd@arndb.de>
 <20180621154915.GA31947@gmail.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Thu, 21 Jun 2018 18:01:24 +0200
X-Google-Sender-Auth: x2XQWTyLUSnmAGsh2beKP9iDD7E
Message-ID: <CAK8P3a1QYTfRNQt2+a29BpvgYM_pnSFrO=NBvVo=BdUa2q9ngQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] rusage: allow 64-bit times ru_utime/ru_stime
To:     Ingo Molnar <mingo@kernel.org>
Cc:     y2038 Mailman List <y2038@lists.linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Paul Eggert <eggert@cs.ucla.edu>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        Richard Henderson <rth@twiddle.net>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Matt Turner <mattst88@gmail.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-alpha@vger.kernel.org,
        Deepa Dinamani <deepa.kernel@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 21, 2018 at 5:49 PM, Ingo Molnar <mingo@kernel.org> wrote:
> * Arnd Bergmann <arnd@arndb.de> wrote:
>
>> +int put_compat_rusage_time64(const struct __kernel_rusage *r,
>> +                          struct compat_rusage_time64 __user *ru)
>> +{
>> +     struct compat_rusage_time64 r32;
>> +     memset(&r32, 0, sizeof(r32));
>> +     r32.ru_utime.tv_sec = r->ru_utime.tv_sec;
>> +     r32.ru_utime.tv_usec = r->ru_utime.tv_usec;
>> +     r32.ru_stime.tv_sec = r->ru_stime.tv_sec;
>> +     r32.ru_stime.tv_usec = r->ru_stime.tv_usec;
>> +     r32.ru_maxrss = r->ru_maxrss;
>> +     r32.ru_ixrss = r->ru_ixrss;
>> +     r32.ru_idrss = r->ru_idrss;
>> +     r32.ru_isrss = r->ru_isrss;
>> +     r32.ru_minflt = r->ru_minflt;
>> +     r32.ru_majflt = r->ru_majflt;
>> +     r32.ru_nswap = r->ru_nswap;
>> +     r32.ru_inblock = r->ru_inblock;
>> +     r32.ru_oublock = r->ru_oublock;
>> +     r32.ru_msgsnd = r->ru_msgsnd;
>> +     r32.ru_msgrcv = r->ru_msgrcv;
>> +     r32.ru_nsignals = r->ru_nsignals;
>> +     r32.ru_nvcsw = r->ru_nvcsw;
>> +     r32.ru_nivcsw = r->ru_nivcsw;
>
> Could you please vertically align the right side of the initialization as well?
> Much easier to check at a glance.
...

> Which tabulated form made me notice the info.cause / si_code asymmetry - and a
> brief check of the source shows that it's correct. No way would I have noticed it
> in the jumbled up form above, so I think aligning such mass-initializations makes
> sense.

Sure, no problem. Do you have an opinion on the question I raised in the
first patch [1], i.e. whether we actually want this to be done this way in the
kernel, or one of the other approaches I described there?

Thanks for taking a look here already!

      Arnd

[1] https://patchwork.kernel.org/patch/10352507/
