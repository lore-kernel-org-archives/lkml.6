Return-Path: <SRS0=AKhD=M3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53213C04AA5
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 17:20:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 13EE9208E4
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 17:20:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 13EE9208E4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726882AbeJPBHE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Oct 2018 21:07:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:47158 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726585AbeJPBHE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Oct 2018 21:07:04 -0400
Received: from gandalf.local.home (cpe-66-24-56-78.stny.res.rr.com [66.24.56.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 40FDA2098A;
        Mon, 15 Oct 2018 17:20:55 +0000 (UTC)
Date:   Mon, 15 Oct 2018 13:20:53 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     <peng.hao2@zte.com.cn>
Cc:     <peterz@infradead.org>, <mingo@redhat.com>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3] sched/rt : return accurate release rq lock info
Message-ID: <20181015132053.7122c4af@gandalf.local.home>
In-Reply-To: <201810160009439217654@zte.com.cn>
References: <20181015114220.70c3598d@gandalf.local.home>
        <201810160009439217654@zte.com.cn>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 16 Oct 2018 00:09:43 +0800 (CST)
<peng.hao2@zte.com.cn> wrote:

> >We only do the check if the immediate double_lock_balance() released
> >the current task rq lock, but we don't take into account if it was
> >released earlier, which means it could have migrated and we never
> >noticed!
> >  
> double_lock_balance may release current rq's lock,but it just for get the locks of the two rq's in order
> and it immediately reacquire the current rq's lock before double_lock_balance returns.
> >I believe the code should look like this:
> >

Bah, I didn't even compile it. And thought it was
"double_lock_balance", and didn't notice it was double_unlock_balance()
(this is what I get for trying to do too much at once).

Sad part is, I noticed this back when I added reviewed-by, but then
looking at it again, I did the same mistake :-/

Yeah, never mind, it's fine, my original reviewed-by stands.

-- Steve
