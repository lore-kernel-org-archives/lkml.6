Return-Path: <SRS0=Jh2l=L4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=3.0 tests=DKIM_SIGNED,FSL_HELO_FAKE,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C70C5ECDFD0
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 17:45:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 67FD320853
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 17:45:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sbwT+coS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 67FD320853
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728090AbeINXBF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Sep 2018 19:01:05 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:37584 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727118AbeINXBF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Sep 2018 19:01:05 -0400
Received: by mail-wr1-f66.google.com with SMTP id u12-v6so11398126wrr.4;
        Fri, 14 Sep 2018 10:45:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=VXXx9HvWRIDEQarI3gEXwi4IGS4iD4IPQ5hP7GBn9wk=;
        b=sbwT+coSpCG5fPfmqnDkLr9Hvz0UfYfPNqPUGynYAYA/O/oMPDg9ztk2i9SkIIjh9u
         D5jTQG4YYpNNaiOReVzNyyMp4UzJlmBrs5mcE6ENo0n4tdpVZfU8xIwSV6LSDwy5dOAd
         qpYlDNt898XwCwx9073PKAWZ4mUrqgDBdLRZM5Kocd+cllHFJazXVRpBmmO561TT9weC
         uYUMY7ZqsAAJxeFfuMbhwbUJs/vsMV+wjMknUcAu0GnWmxyA8I3HH+LHHkm1tFJXmxdI
         f99H8Z55xtiQ89MUy9Oe50XWr1LzqvOZ2lMH8i161YjNJN4Ow2+K7T+RexeZebP95UUe
         7HKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=VXXx9HvWRIDEQarI3gEXwi4IGS4iD4IPQ5hP7GBn9wk=;
        b=GBnLRmF3yX+h01cdC6tTUCxiR1gczTahpmjzxQZEQt4JgCOkQmkMQlfVGGg/d/ExVz
         1keFe8TtPjatU+zpnI4+SrGAmDqxcs30SsBzktA7X7+3eUrkPp6tO8xl1GtlqeMF3+tb
         wqg1p1x2UMHEll//zTbxccKlZX7aWg1FcVTyzvFfXS/pNqwc3qDNC3ZmRsy3bGwtPCHk
         T3OY7Z7ZqR8SptPJT9xFsxmOzLtp2W7iuj2U/Z0mZMil+EB01EUx2lJfBmcRQCHePiBp
         ziyWVllMJNYwAbbzMbBC9ryih2oBDd1WmCRiSwO/iZFEhbfZu/UJmDiAV6i2v0fpqsx/
         An5A==
X-Gm-Message-State: APzg51ApjKwCwjewCaKkHL5ec0459EYPB3fPUn4SKITu3AgjBbSOzq57
        IkYamBzsJyqoGjKcbEAhL3w=
X-Google-Smtp-Source: ANB0VdbU6qdK/UO7FV04jaf5n4Q5k+rp/IZl2h+Z9dDtKvLL/JMugEFQpDzdBi07c4YmplyFBQYFWA==
X-Received: by 2002:a5d:5344:: with SMTP id t4-v6mr11194075wrv.257.1536947131798;
        Fri, 14 Sep 2018 10:45:31 -0700 (PDT)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id e133-v6sm4918754wma.33.2018.09.14.10.45.30
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 14 Sep 2018 10:45:30 -0700 (PDT)
Date:   Fri, 14 Sep 2018 19:45:28 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     linux-arch@vger.kernel.org, linux-api@vger.kernel.org,
        Joseph =?iso-8859-1?Q?Myers=A0?= <joseph@codesourcery.com>,
        David Howells <dhowells@redhat.com>, libc-alpha@sourceware.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] [RFC] making uapi/linux/elfcore.h useful again
Message-ID: <20180914174528.GA35000@gmail.com>
References: <20180914113929.953895-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180914113929.953895-1-arnd@arndb.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Arnd Bergmann <arnd@arndb.de> wrote:

> After finding a bug in glibc the question came up how linux/elfcore.h
> is supposed to be used from user space. As far as I can tell, it's
> not possible, as it references data types that are simply unavailable
> there.
> 
> The #ifndef __KERNEL__ section in that header dates back to when the
> file was introduced in linux-1.3.5, and presumably was meant to
> provide the structures for the libc sys/procfs.h implementation.
> However, this was never portable to architectures other than x86-32,
> and has been broken on that architecture at a later point.
> 
> These are the steps that I needed to make it possible to include the
> header file, e.g. for libc self-testing in order to make sure the
> structures are compatible with its own:
> 
> - drop the #ifndef __KERNEL__ section that are obviously useless
>   and get in the way
> 
> - change the pid_t references to __kernel_pid_t
> 
> - Move required data from the private x86 asm/elf.h file into
>   a new uapi/asm/elf.h. Some other architectures already do that,
>   but most of them do not. Before applying the patch, we have
>   to do this for all architectures
> 
> - Change ELF_NGREG to an integer literal constant instead of
>   a sizeof operation based on a private type.
> 
> Cc: Joseph Myers <joseph@codesourcery.com>
> Cc: David Howells <dhowells@redhat.com>
> Cc: libc-alpha@sourceware.org
> Link: https://patchwork.ozlabs.org/patch/969540/
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  arch/x86/include/asm/elf.h         | 24 +-----------------------
>  arch/x86/include/uapi/asm/elf.h    | 30 ++++++++++++++++++++++++++++++
>  arch/x86/include/uapi/asm/signal.h |  2 +-
>  include/uapi/linux/elf.h           |  1 +
>  include/uapi/linux/elfcore.h       | 26 +++++---------------------
>  5 files changed, 38 insertions(+), 45 deletions(-)
>  create mode 100644 arch/x86/include/uapi/asm/elf.h

Acked-by: Ingo Molnar <mingo@kernel.org>

I suspect this wants to go through -mm, or do you want to carry it?

Thanks,

	Ingo
