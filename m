Return-Path: <SRS0=Clcj=JE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFFFEC5AE59
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 21:42:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 95FDB2083D
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 21:42:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 95FDB2083D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S964919AbeFRVmH (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Jun 2018 17:42:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:39828 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S935628AbeFRVmG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jun 2018 17:42:06 -0400
Received: from gandalf.local.home (cpe-66-24-56-78.stny.res.rr.com [66.24.56.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BFC2020836;
        Mon, 18 Jun 2018 21:42:04 +0000 (UTC)
Date:   Mon, 18 Jun 2018 17:42:03 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Byungchul Park <byungchul.park@lge.com>
Cc:     peterz@infradead.org, mingo@kernel.org, tglx@linutronix.de,
        raistlin@linux.it, linux-kernel@vger.kernel.org,
        juri.lelli@gmail.com, bristot@redhat.com, kernel-team@lge.com,
        joel@joelfernandes.org
Subject: Re: [RESEND PATCH v12 2/2] sched/rt: Add support for
 SD_PREFER_SIBLING on find_lowest_rq()
Message-ID: <20180618174203.4a1b4cf0@gandalf.local.home>
In-Reply-To: <1529297889-24551-3-git-send-email-byungchul.park@lge.com>
References: <1529297889-24551-1-git-send-email-byungchul.park@lge.com>
        <1529297889-24551-3-git-send-email-byungchul.park@lge.com>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 18 Jun 2018 13:58:09 +0900
Byungchul Park <byungchul.park@lge.com> wrote:

> Hello Steven,
> 
> I've changed the code a little bit to avoid a compile warning caused by
> 'const' args of find_cpu(). Can I keep your Reviewed-by?
> 
> BEFORE:
> static int find_cpu(const struct cpumask *mask,
> 		    const struct sched_domain *sd,
> 		    const struct sched_domain *prefer)
> 
> AFTER:
> static int find_cpu(const struct cpumask *mask,
> 		    struct sched_domain *sd,
> 		    struct sched_domain *prefer)
> 
> (I temporarily removed the Reviewed-by you gave me.)
> Reviewed-by: Steven Rostedt (VMware) <rostedt@goodmis.org>

I would fix sched_domain_span() to take a constant and keep the
previous patch.

-- Steve
