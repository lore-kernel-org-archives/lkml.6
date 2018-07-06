Return-Path: <SRS0=VV0n=JW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59C9AC6778C
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 21:39:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0BBDB22B5A
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 21:39:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0BBDB22B5A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932810AbeGFVj0 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Jul 2018 17:39:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:51376 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753367AbeGFVjZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jul 2018 17:39:25 -0400
Received: from gandalf.local.home (cpe-66-24-56-78.stny.res.rr.com [66.24.56.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0525622B57;
        Fri,  6 Jul 2018 21:39:23 +0000 (UTC)
Date:   Fri, 6 Jul 2018 17:39:22 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Claudio <claudio.fontana@gliwa.com>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org
Subject: Re: ftrace performance (sched events): cyclictest shows 25% more
 latency
Message-ID: <20180706173922.734616de@gandalf.local.home>
In-Reply-To: <20180706172428.30aeef91@gandalf.local.home>
References: <73e2f61e-7e7b-d8be-6c94-896cf94e7567@gliwa.com>
        <20180706172428.30aeef91@gandalf.local.home>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 6 Jul 2018 17:24:28 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> I'll investigate further.

Note, I enabled function tracing to trace the scheduler function:

 # trace-cmd start -p function -l schedule

And then ran cyclictest. That does not cause any noticeable increase
in latency (try it). So there is some kind of side effect with the
trace event itself, and not the recording of the event.

-- Steve
