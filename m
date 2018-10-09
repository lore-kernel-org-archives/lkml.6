Return-Path: <SRS0=T/cj=MV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2533EC64EB8
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 17:29:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D4FB621502
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 17:29:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D4FB621502
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726564AbeJJAri convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Oct 2018 20:47:38 -0400
Received: from mx1.redhat.com ([209.132.183.28]:40506 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726415AbeJJArh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Oct 2018 20:47:37 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id E17AF3082E02;
        Tue,  9 Oct 2018 17:29:36 +0000 (UTC)
Received: from llong.remote.csb (dhcp-17-55.bos.redhat.com [10.18.17.55])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 130CB78565;
        Tue,  9 Oct 2018 17:29:35 +0000 (UTC)
Subject: Re: [PATCH] lib/Kconfig.debug: add a comment to PROVE_LOCKING impact
To:     Lukasz Luba <l.luba@partner.samsung.com>,
        linux-kernel@vger.kernel.org
Cc:     b.zolnierkie@samsung.com, mingo@redhat.com
References: <CGME20181009153959eucas1p1ab3c10ba4868a4e97a1bff24d8f34c41@eucas1p1.samsung.com>
 <20181009153959eucas1p1ab3c10ba4868a4e97a1bff24d8f34c41~b_u5xrZ3z3130331303eucas1p1U@eucas1p1.samsung.com>
From:   Waiman Long <longman@redhat.com>
Organization: Red Hat
Message-ID: <c328b3c5-ef09-5cf7-80f5-4b6a8cc9a553@redhat.com>
Date:   Tue, 9 Oct 2018 13:29:35 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.0
MIME-Version: 1.0
In-Reply-To: <20181009153959eucas1p1ab3c10ba4868a4e97a1bff24d8f34c41~b_u5xrZ3z3130331303eucas1p1U@eucas1p1.samsung.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.46]); Tue, 09 Oct 2018 17:29:36 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/09/2018 11:39 AM, Lukasz Luba wrote:
> This patch add some comment related to performance impact,
> which can be really big (x3 times slower context switch).
>
> Signed-off-by: Lukasz Luba <l.luba@partner.samsung.com>
> ---
>  lib/Kconfig.debug | 11 +++++++++++
>  1 file changed, 11 insertions(+)
>
> diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
> index 4966c4f..9e67a2a3 100644
> --- a/lib/Kconfig.debug
> +++ b/lib/Kconfig.debug
> @@ -1088,6 +1088,9 @@ config PROVE_LOCKING
>  	 the proof of observed correctness is also maintained for an
>  	 arbitrary combination of these separate locking variants.
>  
> +	 This feature enables LOCKDEP which can harm system performance
> +	 even x3 times.
> +
>  	 For more details, see Documentation/locking/lockdep-design.txt.
>  
>  config LOCK_STAT
> @@ -1112,6 +1115,10 @@ config LOCK_STAT
>  	 CONFIG_LOCK_STAT defines "contended" and "acquired" lock events.
>  	 (CONFIG_LOCKDEP defines "acquire" and "release" events.)
>  
> +	 This feature enables LOCKDEP which can harm system performance
> +	 even x3 times.
> +	 For more details, see Documentation/locking/lockdep-design.txt.
> +
>  config DEBUG_RT_MUTEXES
>  	bool "RT Mutex debugging, deadlock detection"
>  	depends on DEBUG_KERNEL && RT_MUTEXES
> @@ -1175,6 +1182,10 @@ config DEBUG_LOCK_ALLOC
>  	 spin_lock_init()/mutex_init()/etc., or whether there is any lock
>  	 held during task exit.
>  
> +	 This feature enables LOCKDEP which can harm system performance
> +	 even x3 times.
> +	 For more details, see Documentation/locking/lockdep-design.txt.
> +
>  config LOCKDEP
>  	bool
>  	depends on DEBUG_KERNEL && LOCK_DEBUGGING_SUPPORT

I don't mind seeing warning message about the performance impact of
enabling lockdep. However, the actual slowdown depends on many factors
including the type of systems, workloads and so on. I am a bit hesitant
to quote an actual figure like x3 in the help text as it may not be
correct in many cases.

BTW, my recent lockdep patch (https://lkml.org/lkml/2018/10/2/1410)
should be able to reduce the performance impact of enabling lockdep.
Could you try to see if that help in your case?

Cheers,
Longman


