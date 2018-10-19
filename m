Return-Path: <SRS0=xTli=M7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8800ECDE43
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 18:31:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 693C82086E
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 18:31:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="qgWzP8Qx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 693C82086E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727835AbeJTCiX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Oct 2018 22:38:23 -0400
Received: from merlin.infradead.org ([205.233.59.134]:46966 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727193AbeJTCiX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Oct 2018 22:38:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=8t9WA+vtwYEHOtSdG6iDh3KbCzULva9NgiwMtHEE5Cc=; b=qgWzP8QxV7AJDvuNUhOZO0o4W
        I9FdzM0+9PZ295hOwFPh4QT9yc3jcmKartxY2Pq+tZRYQbRX2R5DGHasMevs4VXy6dBtnW3pCcBhy
        egORTbWjf0SUB4YUEpz/V9M5sydPyfoxeRZKgYFlYunASx1IMepQ0zsM41TQh4He6AA8Wh4eGW42d
        KGXgAoGmX0jnwAWudAbqiGrShKr2for6O+yFy+8qdfLvgT9OsIPOnbvnmCrK0zFlXfQAOw+Jfz1yd
        j1kd6r4rdcHda8KjMhdjiCJ7WW92u2LbgYjTgWsS80P0Iuj1AXN+BnIMQCtXJDMHKje7cA54exZN4
        Xy+WqWcAg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gDZY3-0007g8-NE; Fri, 19 Oct 2018 18:31:00 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 5031520296B3E; Fri, 19 Oct 2018 20:30:57 +0200 (CEST)
Date:   Fri, 19 Oct 2018 20:30:57 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Peng Hao <penghao122@sina.com.cn>
Cc:     mingo@redhat.com, linux-kernel@vger.kernel.org,
        Peng Hao <peng.hao2@zte.com.cn>
Subject: Re: [PATCH]  sched/fair : modify comment of fbq_type description
Message-ID: <20181019183057.GA31016@hirez.programming.kicks-ass.net>
References: <1539967494-12493-1-git-send-email-penghao122@sina.com.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1539967494-12493-1-git-send-email-penghao122@sina.com.cn>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 19, 2018 at 12:44:54PM -0400, Peng Hao wrote:
> 
> From: Peng Hao <peng.hao2@zte.com.cn>
> 
> for type 'all', the comment 'there is no distinction' is vague.
> make it clearer.
> 
> Signed-off-by: Peng Hao <peng.hao2@zte.com.cn>
> ---
>  kernel/sched/fair.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index f808ddf..3a0543f 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -8304,7 +8304,7 @@ static struct rq *find_busiest_queue(struct lb_env *env,
>  		 * We classify groups/runqueues into three groups:
>  		 *  - regular: there are !numa tasks
>  		 *  - remote:  there are numa tasks that run on the 'wrong' node
> -		 *  - all:     there is no distinction
> +		 *  - all:     there are numa tasks that run on the 'right' node

No, that is actively wrong. Both the previous cases inlcude that.

If anything, it should be: all tasks are numa tasks and run on the
'right' node.
