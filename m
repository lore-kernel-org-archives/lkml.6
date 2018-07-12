Return-Path: <SRS0=HMm1=J4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D13A3ECDFAA
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 23:45:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8671120BF2
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 23:45:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8671120BF2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387719AbeGLX5b (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Jul 2018 19:57:31 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:55338 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387612AbeGLX5b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jul 2018 19:57:31 -0400
Received: from localhost.localdomain (c-24-4-125-7.hsd1.ca.comcast.net [24.4.125.7])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id A0380DA7;
        Thu, 12 Jul 2018 23:45:38 +0000 (UTC)
Date:   Thu, 12 Jul 2018 16:45:37 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Tejun Heo <tj@kernel.org>,
        Suren Baghdasaryan <surenb@google.com>,
        Vinayak Menon <vinmenon@codeaurora.org>,
        Christopher Lameter <cl@linux.com>,
        Mike Galbraith <efault@gmx.de>,
        Shakeel Butt <shakeelb@google.com>, linux-mm@kvack.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com
Subject: Re: [RFC PATCH 10/10] psi: aggregate ongoing stall events when
 somebody reads pressure
Message-Id: <20180712164537.324caee21fd68c47a02af009@linux-foundation.org>
In-Reply-To: <20180712172942.10094-11-hannes@cmpxchg.org>
References: <20180712172942.10094-1-hannes@cmpxchg.org>
        <20180712172942.10094-11-hannes@cmpxchg.org>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 12 Jul 2018 13:29:42 -0400 Johannes Weiner <hannes@cmpxchg.org> wrote:

> Right now, psi reports pressure and stall times of already concluded
> stall events. For most use cases this is current enough, but certain
> highly latency-sensitive applications, like the Android OOM killer,
> might want to know about and react to stall states before they have
> even concluded (e.g. a prolonged reclaim cycle).
> 
> This patches the procfs/cgroupfs interface such that when the pressure
> metrics are read, the current per-cpu states, if any, are taken into
> account as well.
> 
> Any ongoing states are concluded, their time snapshotted, and then
> restarted. This requires holding the rq lock to avoid corruption. It
> could use some form of rq lock ratelimiting or avoidance.
> 
> Requested-by: Suren Baghdasaryan <surenb@google.com>
> Not-yet-signed-off-by: Johannes Weiner <hannes@cmpxchg.org>

What-does-that-mean:?
