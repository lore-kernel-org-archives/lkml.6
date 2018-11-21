Return-Path: <SRS0=ejdu=OA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FSL_HELO_FAKE,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFFF7C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 08:03:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A932C21479
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 08:03:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jmz28g3P"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A932C21479
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728667AbeKUSgd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Nov 2018 13:36:33 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:33221 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728553AbeKUSgc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Nov 2018 13:36:32 -0500
Received: by mail-wr1-f68.google.com with SMTP id u9-v6so4610649wrr.0;
        Wed, 21 Nov 2018 00:03:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=StdXAbVVGraPSHRMosK2J6YpifpAhexKTvCnKU/JIIY=;
        b=jmz28g3P7H2viKe8iK+AhKMMXOSw19qWnPyBy6+rwU8rEswBwzEjG6NYYCXS5vf/o4
         Wgy6CPtM3glWIVcSyzWM58pFZClVA+f73bRhicgq8b17KRIhz6oGsm1/FaIEDmIefh2M
         IMEDQbIxsLYfZBrbqQrvJSkR7oISsiR1WOBV9gVrXai9HcNVkE6k0rdRpUuf8Px5Pt3j
         qRXlqknesnu8N0X5Tdi2QTQlvStY0yx/haE18I7WGRNp3AujEJLT1FXBadGRB3prk+hJ
         Ef34jDvFhD6OUdL97P6p9RqFwUHHduQ7LovRurrfJ5MminwjdpKVLKTQVSuL0K4WMpR6
         LUGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=StdXAbVVGraPSHRMosK2J6YpifpAhexKTvCnKU/JIIY=;
        b=nX1Sp9frSO3yNCzo2/AcrcPzwM3TjnbhgwcFHbZdmQQdnecQMQnBG7HZ1/upVyZr6K
         +gC4wVAGIgDcbidBWuVQFvqqb++1UlyGRBvMUMVte1uEJsxPERjXKA80vUbcCHUOPZgS
         ACy8yNxY2zbOIq8eV6S/M5iuwgECRTS/rZofGrwUUKmL/qJhd0ywpMT73Dm9yJgZOW+Z
         M48eC5fzV1xoTF6xzT1+d909Sn+yck1H4dWeQAJFZOgO0iV6426NK5EOmoeqEcQzHQym
         GKquh42JOnt1/tCyLt8pSMBixvDW2fTq/2zDt++aHDsQatOk75inP2OTjQoBzJK3TZMY
         wSow==
X-Gm-Message-State: AA+aEWZMHlQxAOYy/Cn562LD0OjEYJLV6FtCq+ZWLgdBDi9laE6X82b3
        IDzO/OMH8ahcbBKMkEIPOwE=
X-Google-Smtp-Source: AFSGD/V3tTd3z6h7f7QnqdkxplHLHrD8VMLivfybDwOsITlD/pwPC2E0HW4iewWJO86biBfnA7/+wQ==
X-Received: by 2002:adf:9245:: with SMTP id 63-v6mr5049764wrj.130.1542787381557;
        Wed, 21 Nov 2018 00:03:01 -0800 (PST)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id x136sm443029wme.0.2018.11.21.00.03.00
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 21 Nov 2018 00:03:00 -0800 (PST)
Date:   Wed, 21 Nov 2018 09:02:58 +0100
From:   Ingo Molnar <mingo@kernel.org>
To:     mark.rutland@arm.com, tglx@linutronix.de, hpa@zytor.com,
        linux-kernel@vger.kernel.org, peterz@infradead.org,
        boqun.feng@gmail.com, will.deacon@arm.com
Cc:     linux-tip-commits@vger.kernel.org
Subject: Re: [tip:locking/core] locking/atomics: Check generated headers are
 up-to-date
Message-ID: <20181121080258.GA56691@gmail.com>
References: <20180904104830.2975-6-mark.rutland@arm.com>
 <tip-8d32588077bdc390420cfa6946f407033a20d7a8@git.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <tip-8d32588077bdc390420cfa6946f407033a20d7a8@git.kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* tip-bot for Mark Rutland <tipbot@zytor.com> wrote:

> Commit-ID:  8d32588077bdc390420cfa6946f407033a20d7a8
> Gitweb:     https://git.kernel.org/tip/8d32588077bdc390420cfa6946f407033a20d7a8
> Author:     Mark Rutland <mark.rutland@arm.com>
> AuthorDate: Tue, 4 Sep 2018 11:48:29 +0100
> Committer:  Ingo Molnar <mingo@kernel.org>
> CommitDate: Thu, 1 Nov 2018 11:01:10 +0100
> 
> locking/atomics: Check generated headers are up-to-date
> 
> Now that all the generated atomic headers are in place, it would be good
> to ensure that:
> 
> a) the headers are up-to-date when scripting changes.
> 
> b) developers don't directly modify the generated headers.
> 
> To ensure both of these properties, let's add a Kbuild step to check
> that the generated headers are up-to-date.
> 
> Signed-off-by: Mark Rutland <mark.rutland@arm.com>
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: catalin.marinas@arm.com
> Cc: Will Deacon <will.deacon@arm.com>
> Cc: linuxdrivers@attotech.com
> Cc: dvyukov@google.com
> Cc: Boqun Feng <boqun.feng@gmail.com>
> Cc: arnd@arndb.de
> Cc: aryabinin@virtuozzo.com
> Cc: glider@google.com
> Link: http://lkml.kernel.org/r/20180904104830.2975-6-mark.rutland@arm.com
> Signed-off-by: Ingo Molnar <mingo@kernel.org>
> ---
>  Kbuild                          | 18 ++++++++++++++++--
>  scripts/atomic/check-atomics.sh | 19 +++++++++++++++++++
>  2 files changed, 35 insertions(+), 2 deletions(-)

These scripts are *awfully* slow to be run at every kernel build - even a 
reasonably fast machine:

  model name	: Intel(R) Xeon(R) CPU E5-2680 v2 @ 2.80GHz

... they are adding 3-4 seconds to the build time:

[Before]:

  galatea:~/linux/linux> perf stat --null --repeat 3 make kernel/sched/core.o
  CALL    scripts/checksyscalls.sh
  DESCEND  objtool
  CALL    scripts/checksyscalls.sh
  DESCEND  objtool
  CALL    scripts/checksyscalls.sh
  DESCEND  objtool

 Performance counter stats for 'make kernel/sched/core.o' (3 runs):

          1.201874 +- 0.000371 seconds time elapsed  ( +-  0.03% )


[After]:

  galatea:~/linux/linux> perf stat --null --repeat 3 make kernel/sched/core.o

  CALL    scripts/checksyscalls.sh
  CALL    scripts/atomic/check-atomics.sh
  DESCEND  objtool
  CALL    scripts/checksyscalls.sh
  CALL    scripts/atomic/check-atomics.sh
  DESCEND  objtool
  CALL    scripts/checksyscalls.sh
  CALL    scripts/atomic/check-atomics.sh
  DESCEND  objtool

 Performance counter stats for 'make kernel/sched/core.o' (3 runs):

            4.5987 +- 0.0109 seconds time elapsed  ( +-  0.24% )

Could we please get this fixed so that proper dependencies are checked 
and it's only regenerated when needed? This slowdown makes additive-build 
kernel development quite painful, as ~5 seconds is in the 'too long' 
category already, while 1.2 seconds is basically instantaneous.

I cannot even imagine the slowdown on a truly slow box where kernel 
development *has* to be additive.

Thanks,

	Ingo
