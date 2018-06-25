Return-Path: <SRS0=Q/hc=JL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8124C43144
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 01:26:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 74742253AF
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 01:26:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 74742253AF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xmission.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752378AbeFYB0h (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 24 Jun 2018 21:26:37 -0400
Received: from out02.mta.xmission.com ([166.70.13.232]:47877 "EHLO
        out02.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751979AbeFYB0d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Jun 2018 21:26:33 -0400
Received: from in02.mta.xmission.com ([166.70.13.52])
        by out02.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1fXGH0-0006FA-0T; Sun, 24 Jun 2018 19:26:30 -0600
Received: from 97-119-124-205.omah.qwest.net ([97.119.124.205] helo=x220.xmission.com)
        by in02.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1fXGGz-00025O-5y; Sun, 24 Jun 2018 19:26:29 -0600
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        y2038 Mailman List <y2038@lists.linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        the arch/x86 maintainers <x86@kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Paul Eggert <eggert@cs.ucla.edu>,
        Richard Henderson <rth@twiddle.net>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Matt Turner <mattst88@gmail.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-alpha@vger.kernel.org,
        Deepa Dinamani <deepa.kernel@gmail.com>
References: <20180420120605.1612248-1-arnd@arndb.de>
        <20180420120605.1612248-2-arnd@arndb.de>
        <20180621154915.GA31947@gmail.com>
        <CAK8P3a1QYTfRNQt2+a29BpvgYM_pnSFrO=NBvVo=BdUa2q9ngQ@mail.gmail.com>
        <20180621161121.GB7222@gmail.com>
        <CAK8P3a1mx16S+DhEMQA6WBJ7efdhN5YaKKVHU6n+E6kfifM-Qg@mail.gmail.com>
        <20180622021636.GA11266@gmail.com> <87a7rm3eb5.fsf@xmission.com>
        <20180624071258.GB29407@gmail.com>
Date:   Sun, 24 Jun 2018 20:26:08 -0500
In-Reply-To: <20180624071258.GB29407@gmail.com> (Ingo Molnar's message of
        "Sun, 24 Jun 2018 09:12:58 +0200")
Message-ID: <87y3f31wsv.fsf@xmission.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1fXGGz-00025O-5y;;;mid=<87y3f31wsv.fsf@xmission.com>;;;hst=in02.mta.xmission.com;;;ip=97.119.124.205;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX19jKo//4z23LDvKo7/SFoIT9ujafb4vVVs=
X-SA-Exim-Connect-IP: 97.119.124.205
X-SA-Exim-Mail-From: ebiederm@xmission.com
Subject: Re: [PATCH v2 2/2] rusage: allow 64-bit times ru_utime/ru_stime
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar <mingo@kernel.org> writes:

> * Eric W. Biederman <ebiederm@xmission.com> wrote:
>
>> The trouble with attributes is that means you can't filter your system
>> call arguments with seccomp. [...]
>
> There's nothing keeping seccomp from securely fetching those arguments and 
> extending filtering to them as well ...
>
> Allowing that would make sense for a lot of other system calls as
> well.

Possibly.  The challenge is that if the fetch for the kernel to use
those arguments is different from the fetch of seccomp to test those
arguments you have a time of test vs time of use race.

Given the location of the seccomp hook at the kernel user space border
there is no easy way for seccomp to share the fetch with the system
call itself.

So I don't see how seccomp could perform the fetch securely.

Eric
