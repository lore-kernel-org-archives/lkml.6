Return-Path: <SRS0=SXUR=L3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F125FC070C3
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 00:45:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 90FA8213A2
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 00:45:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="fsiLeg5d"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 90FA8213A2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726866AbeIMFwR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Sep 2018 01:52:17 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:46004 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726261AbeIMFwQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Sep 2018 01:52:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:To:
        Subject:Sender:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=0BkCWpIgtkFuM4EvF1uPeuLWdsm7XDeYZX1g5czCAnE=; b=fsiLeg5dbAp7fkvuJaDjpQBfp
        DYaww2SLWlK6V1B1DtCp8NCfC5aL24WlsqwVaVkP5FVTgwoI/wTzrCrhHaRuLWUJSs+EJ+6BUWmq0
        6AGsH4+AH07BLoXOJjXS8Uk6mfMyiOT0vMQUsXdDfJqc4YwbMxD57FsiOb2ZNAsiabiUlN5HjmQ8i
        t2B98DlIjNm3wP7C3Cp6zCm34RvdKm+8nktWsB+TFW58MzBTWIuutcZpVdi+6vCryDfWKBx28LCj/
        1AJ4Qlmjg7/GNn7uxX2J99ooUjAvKtPZnd2sZuXadSltZ5o2VknRyzDm/l+tL43IJUtlKD5RRxnJT
        pp6kMwZVg==;
Received: from static-50-53-52-16.bvtn.or.frontiernet.net ([50.53.52.16] helo=midway.dunlab)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1g0Fku-0005Wb-2p; Thu, 13 Sep 2018 00:45:12 +0000
Subject: Re: mmotm 2018-09-12-16-40 uploaded (psi)
To:     akpm@linux-foundation.org, broonie@kernel.org, mhocko@suse.cz,
        sfr@canb.auug.org.au, linux-next@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, mm-commits@vger.kernel.org,
        Johannes Weiner <hannes@cmpxchg.org>
References: <20180912234039.Xa5RS%akpm@linux-foundation.org>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <a9bef471-ac93-2983-618b-ffee65f01e0b@infradead.org>
Date:   Wed, 12 Sep 2018 17:45:08 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <20180912234039.Xa5RS%akpm@linux-foundation.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/12/18 4:40 PM, akpm@linux-foundation.org wrote:
> The mm-of-the-moment snapshot 2018-09-12-16-40 has been uploaded to
> 
>    http://www.ozlabs.org/~akpm/mmotm/
> 
> mmotm-readme.txt says
> 
> README for mm-of-the-moment:
> 
> http://www.ozlabs.org/~akpm/mmotm/
> 
> This is a snapshot of my -mm patch queue.  Uploaded at random hopefully
> more than once a week.

Multiple build errors when CONFIG_SMP is not set: (this is on i386 fwiw)

in the psi (pressure) patches, I guess:

In file included from ../kernel/sched/sched.h:1367:0,
                 from ../kernel/sched/core.c:8:
../kernel/sched/stats.h: In function 'psi_task_tick':
../kernel/sched/stats.h:135:33: error: 'struct rq' has no member named 'cpu'
   psi_memstall_tick(rq->curr, rq->cpu);


-- 
~Randy
