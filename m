Return-Path: <SRS0=bmN+=JH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BEB6C43141
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 16:25:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F33232156E
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 16:25:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YftxJyB2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F33232156E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933525AbeFUQZj (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Jun 2018 12:25:39 -0400
Received: from mail-lf0-f65.google.com ([209.85.215.65]:40687 "EHLO
        mail-lf0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933399AbeFUQZg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jun 2018 12:25:36 -0400
Received: by mail-lf0-f65.google.com with SMTP id q11-v6so5197451lfc.7;
        Thu, 21 Jun 2018 09:25:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=9bcM/pdQ4wj5ddn+TVzLqOchy5cc8fazWzkq63E6zSA=;
        b=YftxJyB2mWX4L17UARFPXNrlg9ITGJ85FWxJPBa7PBGMFL60lls9utBOGtsurJYrXL
         LN9JT8Ri1TPkUx9RDef6SvgWzUZ4pImyUe6CvE/v7oLE/G51DhXu7ITeQInghXaEXpqo
         FevEMc97DlPUxYpA+zQyPRPTC7Bw5DHBZuwxezJG16fW3dQNXA4lNClxdbskoGQCw34M
         X8jyUWiHD/fK6U36xcfdOBuFc7O+FRedo0bOj2CuuqITqY7/lPG7Oj3gODEt9LPZytli
         0nip4h9gOmnf9lxfwDJQO5z56zsDB29YYwvZodOUo/tcuERsftUYs2zeOqLERwLZ1yt0
         sUtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=9bcM/pdQ4wj5ddn+TVzLqOchy5cc8fazWzkq63E6zSA=;
        b=JWS5XubDozYefU8/xMqdK9SXg9/xkElDzFwr6ktwO6UiLgsW5aiheAxI+FuN9hQaFR
         6oPgq/lVimMw2QDSu34VE3Fkd05WGTsV+Vdvzv2e6ZLaTj/KJ1A5cA23Zf5wA7hyouqf
         7bqgURTjTLuo4WiCxSeS9EzI/F2rVnRua2C0Hyf8OjQPYyhOWfd/7FluTKGJrJV8V6Bs
         VnS2kHyUsVAHGl43TvVWrv4PmzUelvDcoS7RpfADRsGOBpE2ITSEQOw7r4NdkvMylgfO
         CIPmkWSVKoit5k90em0gF/yq2UXBVuqpZlYpcqFEClOQYHzBsMoqgs5/uIumFKC5QfwR
         Hn0Q==
X-Gm-Message-State: APt69E1aRuyVTh6Dgd+Q0atu4iQNz214X6rUGu2OWJq1F3/RBT462ER8
        vJRqH9bZnWGbOedjBGVBYCVQgzyMuP2WId+6QNNVuwYX
X-Google-Smtp-Source: ADUXVKL+c8DKxKxhvY9j7pkKxO3Rekgl+GwMObOVIcrOI8RcvtojX8lyzNjvECx22kkcm6YwCVaZ4s3qz45IavxqOn8=
X-Received: by 2002:a2e:40d9:: with SMTP id r86-v6mr17420637lje.19.1529598334172;
 Thu, 21 Jun 2018 09:25:34 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a2e:56c8:0:0:0:0:0 with HTTP; Thu, 21 Jun 2018 09:25:33
 -0700 (PDT)
In-Reply-To: <20180621161121.GB7222@gmail.com>
References: <20180420120605.1612248-1-arnd@arndb.de> <20180420120605.1612248-2-arnd@arndb.de>
 <20180621154915.GA31947@gmail.com> <CAK8P3a1QYTfRNQt2+a29BpvgYM_pnSFrO=NBvVo=BdUa2q9ngQ@mail.gmail.com>
 <20180621161121.GB7222@gmail.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Thu, 21 Jun 2018 18:25:33 +0200
X-Google-Sender-Auth: z0uKCW387Muhvu2AYO4yEdhCnIk
Message-ID: <CAK8P3a1mx16S+DhEMQA6WBJ7efdhN5YaKKVHU6n+E6kfifM-Qg@mail.gmail.com>
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

On Thu, Jun 21, 2018 at 6:11 PM, Ingo Molnar <mingo@kernel.org> wrote:
>
> * Arnd Bergmann <arnd@arndb.de> wrote:
>
>> Sure, no problem. Do you have an opinion on the question I raised in the
>> first patch [1], i.e. whether we actually want this to be done this way in the
>> kernel, or one of the other approaches I described there?
>
> So this looks like the most forward looking variant:
>
>> a) deprecate the wait4() and getrusage() system calls, and create
>>    a set of kernel interfaces based around a newly defined structure that
>>    could solve multiple problems at once, e.g. provide more fine-grained
>>    timestamps. The C library could then implement the posix interfaces
>>    on top of the new system calls.
>
> ... but given the pretty long propagation time of new ABIs, is this a good
> solution? What would the limitations/trade-offs be on old-ABI systems?

The main purpose of this is to enable consistent 64-bit time_t interfaces in
user space, and for most users this would not change anything as the
existing glibc (both 64-bit and 32-bit) can continue calling the same
interfaces as before.

For those users that are interested in 64-bit time_t on 32-bit binaries,
the first step would be to change the glibc implementation to emulate
the existing interfaces with the new time_t on top of the new syscall
rather than the old (unsafe) syscall. Those users already require both
a new kernel and a new glibc version.

If the new kernel interfaces offer a real benefit, others could start
using them directly as soon as they have updated the libc version.
Note that glibc has not updated their kernel headers version for
a long time, they still allow building with linux-3.2 header files.
However, the glibc maintainers have indicated that they would
probably update that requirement to the then-latest version
when adding support to the new 64-bit time_t syscalls, so this
would become available immediately to all users of the new glibc
version.

However, the other question that has to be asked then is whether
there is anything wrong with wait4()/waitid() and getrusuage() that
we want to change beyond the time value passing. We have
answered a similar question with 'yes' for stat(), which has led
to the introduction of statx(), but so far I expect all other syscalls
to start compatible. See [1] for my current list. In that list, I have
currently marked waitid() and getrusuage() as not to be addressed,
i.e. my approach c) of applying only the first of the two patches but
not the second.

       Arnd

[1] https://docs.google.com/spreadsheets/d/1HCYwHXxs48TsTb6IGUduNjQnmfRvMPzCN6T_0YiQwis/edit#gid=0
