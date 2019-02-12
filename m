Return-Path: <SRS0=NGUq=QT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C0F1C282C4
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 14:14:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 264B32186A
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 14:14:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730163AbfBLOOt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 09:14:49 -0500
Received: from mx1.redhat.com ([209.132.183.28]:40886 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728629AbfBLOOt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 09:14:49 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 69E463C2CFC;
        Tue, 12 Feb 2019 14:14:48 +0000 (UTC)
Received: from slurm.brq.redhat.com (dhcp-27-164.brq.redhat.com [10.34.27.164])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 0CB505C23A;
        Tue, 12 Feb 2019 14:14:44 +0000 (UTC)
From:   Daniel Vacek <neelx@redhat.com>
To:     tipbot@zytor.com
Cc:     akpm@linux-foundation.org, dave@stgolabs.net, dbueso@suse.de,
        elohimes@gmail.com, hpa@zytor.com, linux-kernel@vger.kernel.org,
        linux-tip-commits@vger.kernel.org, longman@redhat.com,
        mingo@kernel.org, paulmck@linux.vnet.ibm.com, peterz@infradead.org,
        tglx@linutronix.de, torvalds@linux-foundation.org,
        will.deacon@arm.com, xieyongji@baidu.com, neelx@redhat.com
Subject: Re: [tip:locking/core] sched/wake_q: Reduce reference counting for special users
Date:   Tue, 12 Feb 2019 15:14:52 +0100
Message-Id: <1549980892-28583-1-git-send-email-neelx@redhat.com>
In-Reply-To: <tip-07879c6a3740fbbf3c8891a0ab484c20a12794d8@git.kernel.org>
References: <tip-07879c6a3740fbbf3c8891a0ab484c20a12794d8@git.kernel.org>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.29]); Tue, 12 Feb 2019 14:14:49 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> diff --git a/kernel/futex.c b/kernel/futex.c
> index 69e619baf709..2abe1a0b3062 100644
> --- a/kernel/futex.c
> +++ b/kernel/futex.c
> @@ -1463,8 +1463,7 @@ static void mark_wake_futex(struct wake_q_head *wake_q, struct futex_q *q)
>  	 * Queue the task for later wakeup for after we've released
>  	 * the hb->lock. wake_q_add() grabs reference to p.

Should this comment be fixed as well?

--nX

>  	 */
> -	wake_q_add(wake_q, p);
> -	put_task_struct(p);
> +	wake_q_add_safe(wake_q, p);
>  }
>  
>  /*
