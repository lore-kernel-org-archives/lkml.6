Return-Path: <SRS0=iNRz=MO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FSL_HELO_FAKE,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F34A0C43143
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 09:06:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AA8542064E
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 09:06:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FAw6v0UG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AA8542064E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727153AbeJBPsV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Oct 2018 11:48:21 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:45338 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726734AbeJBPsV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Oct 2018 11:48:21 -0400
Received: by mail-wr1-f67.google.com with SMTP id q5-v6so1240303wrw.12
        for <linux-kernel@vger.kernel.org>; Tue, 02 Oct 2018 02:06:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=yNRQXzEfoVmNJXYOquCGCe94H0Jg5bRMybSjq64Ljg8=;
        b=FAw6v0UGISB6vp/DBviRnbhxjjqbL01Bk8xbc/E3as+rMvhiVaQsV6it/epUKESyQb
         ATaRPxeWsBKYLAzUUqeqcwR320SfmSdqHH42cVBY9xEARRurK3R4QVT8dhoo+uy3anV/
         pXq2LOT9eL1NMprfpFmJJWJBa+KkguQyRPi2684tLgCEahTRao2vYbOqXcuUmhNrWfek
         25TDag7HZ4cXNKXftSmwbgU3Vny8MQ9kMm7XoHPjCD/Cjy52tSfrsgQ1hTebaueXmzMb
         qPH+/pIjRLx/mRDumCkp6a3DuyR+HjAVAmmAL/QePSd5UEljt3LLQk1FEyJdXNTZWeXP
         hYYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=yNRQXzEfoVmNJXYOquCGCe94H0Jg5bRMybSjq64Ljg8=;
        b=ff4K6auccC5E29A/PKEZ4veuAWztKHUwp9YNpxa0t8uIj24rdmWsUCHwjSobf8jt8p
         /KcbC/q9iSYEFF8SQdNopTwb8orKGX/FogyDxTqo/Ol+fCQEp7f38Zl6KgfgVzzUZgfk
         3K0QjP8B8gcdl7sXw8bYZeUlucnPyjxMX9+TA0wyRq6MQqr1GIX8sKHNTs8Db5vZ/yuk
         BMdZ0riwUxyjTwtfVdSTvizFYCjblsjU+PIM/Tp9CNKpqw1DxA63vJhjsEwj8yVwQbEm
         mUPO65UPVXYoNXWnzO65o/1xJsF6hPQOtIHY9pXaFrsiyOqk9zAcgBarpZ0Vx8CBXDF7
         wV8w==
X-Gm-Message-State: ABuFfoi2rW4WcS/4Vfgu37jdRRuUwhY/gtdvo4ANxnM/53UuEtYAsIL+
        dxkbG4M39h+lTzC4BqknOGs=
X-Google-Smtp-Source: ACcGV63UPH6XeS5vpigEo2b52MvZQzC9kREcje6NAUkhmvBBnSf6+WcUlKVxd2ARMUggIii5cWH4Ug==
X-Received: by 2002:adf:c650:: with SMTP id u16-v6mr10756261wrg.177.1538471164972;
        Tue, 02 Oct 2018 02:06:04 -0700 (PDT)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id x5-v6sm10793662wmi.37.2018.10.02.02.06.04
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 02 Oct 2018 02:06:04 -0700 (PDT)
Date:   Tue, 2 Oct 2018 11:06:02 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Waiman Long <longman@redhat.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Will Deacon <will.deacon@arm.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/5] locking/lockdep: Eliminate redundant irqs check in
 __lock_acquire()
Message-ID: <20181002090602.GB116695@gmail.com>
References: <1538157201-29173-1-git-send-email-longman@redhat.com>
 <1538157201-29173-3-git-send-email-longman@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1538157201-29173-3-git-send-email-longman@redhat.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Waiman Long <longman@redhat.com> wrote:

> The static __lock_acquire() function has only two callers:
> 
>  1) lock_acquire()
>  2) reacquire_held_locks()
> 
> In lock_acquire(), raw_local_irq_save() is called before hand. So
> irqs must have been disabled. So the check

s/before hand/
 /beforehand

s/irqs
 /IRQs

> 
> 	DEBUG_LOCKS_WARN_ON(!irqs_disabled())
> 
> is kind of redundant in thise case. So move the above check
> to reacquire_held_locks() to eliminate redundant code in the
> lock_acquire path.

s/thise
 /this

s/lock_acquire path
 /lock_acquire() path
 
> Signed-off-by: Waiman Long <longman@redhat.com>
> ---
>  kernel/locking/lockdep.c | 15 +++++++--------
>  1 file changed, 7 insertions(+), 8 deletions(-)
> 
> diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
> index 8f9de7c..add0468 100644
> --- a/kernel/locking/lockdep.c
> +++ b/kernel/locking/lockdep.c
> @@ -3192,6 +3192,10 @@ void lockdep_init_map(struct lockdep_map *lock, const char *name,
>  /*
>   * This gets called for every mutex_lock*()/spin_lock*() operation.
>   * We maintain the dependency maps and validate the locking attempt:
> + *
> + * The callers must make sure that IRQs are disabled before calling it.
> + * otherwise we could get an interrupt which would want to take locks,
> + * which would end up in lockdep again.

Spelling nit: a comma after the first line, like it was in the original version:

> -	/*
> -	 * Lockdep should run with IRQs disabled, otherwise we could
> -	 * get an interrupt which would want to take locks, which would
> -	 * end up in lockdep and have you got a head-ache already?
> -	 */

Thanks,

	Ingo
