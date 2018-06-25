Return-Path: <SRS0=Q/hc=JL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA510C43144
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 16:53:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5B0F925E88
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 16:53:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5B0F925E88
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933711AbeFYQxL (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Jun 2018 12:53:11 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:44746 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1754834AbeFYQxK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jun 2018 12:53:10 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id C602A818F6E0;
        Mon, 25 Jun 2018 16:53:09 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.34.27.30])
        by smtp.corp.redhat.com (Postfix) with SMTP id EF7EB2026D5B;
        Mon, 25 Jun 2018 16:53:07 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Mon, 25 Jun 2018 18:53:09 +0200 (CEST)
Date:   Mon, 25 Jun 2018 18:53:07 +0200
From:   Oleg Nesterov <oleg@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     mingo@kernel.org, gkohli@codeaurora.org, tglx@linutronix.de,
        mpe@ellerman.id.au, bigeasy@linutronix.de,
        linux-kernel@vger.kernel.org, will.deacon@arm.com
Subject: Re: [PATCH 4/4] kthread: Simplify kthread_park() completion
Message-ID: <20180625165306.GA25111@redhat.com>
References: <20180607123310.866085998@infradead.org>
 <20180607124006.266038375@infradead.org>
 <20180608095220.GA18941@redhat.com>
 <20180625071217.GQ2494@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180625071217.GQ2494@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.4
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.8]); Mon, 25 Jun 2018 16:53:09 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.8]); Mon, 25 Jun 2018 16:53:09 +0000 (UTC) for IP:'10.11.54.4' DOMAIN:'int-mx04.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'oleg@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Peter,

On 06/25, Peter Zijlstra wrote:
>
> Hi Oleg,
>
> On Fri, Jun 08, 2018 at 11:52:20AM +0200, Oleg Nesterov wrote:
> > I am travelling till the end of the next week, unlikely I will be able
> > to reply to emails or even read them.
>
> Should I post a new version; with updated Changelogs for you?

IIRC you have already sent v2 with the updated changelog which explains
the problem with for_each_cpu? That series looked good to me, thanks!

Oleg.

