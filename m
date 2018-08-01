Return-Path: <SRS0=pNWC=KQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D5A8C28CF6
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 20:03:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ECC9A208A4
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 20:03:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ECC9A208A4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729764AbeHAVus (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Aug 2018 17:50:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:33226 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725938AbeHAVus (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Aug 2018 17:50:48 -0400
Received: from gandalf.local.home (cpe-66-24-56-78.stny.res.rr.com [66.24.56.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CB514208A3;
        Wed,  1 Aug 2018 20:03:21 +0000 (UTC)
Date:   Wed, 1 Aug 2018 16:03:20 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Erica Bugden <erica.bugden@linutronix.de>,
        linux-kernel@vger.kernel.org, peterz@infradead.org,
        anna-maria@linutronix.de, bigeasy@linutronix.de
Subject: Re: [PATCH] ftrace: Add missing check for existing hwlat thread
Message-ID: <20180801160320.3a4c63f7@gandalf.local.home>
In-Reply-To: <alpine.DEB.2.21.1808012151360.1835@nanos.tec.linutronix.de>
References: <1533120354-22923-1-git-send-email-erica.bugden@linutronix.de>
        <20180801154006.580806cc@gandalf.local.home>
        <alpine.DEB.2.21.1808012151360.1835@nanos.tec.linutronix.de>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 1 Aug 2018 21:59:38 +0200 (CEST)
Thomas Gleixner <tglx@linutronix.de> wrote:

> > This looks like it is treating the symptom and not the disease.  
> 
> My bad. We looked at the other instances of tracers and they all have
> protection against this kind of call sequence ...

Probably because they were all fixing the symptom ;-)

I'm going to keep Erica's patch and add a WARN_ON() to it just in case.
But can you still check if the patch I gave fixes it too?

-- Steve
