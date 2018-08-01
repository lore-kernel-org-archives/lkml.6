Return-Path: <SRS0=pNWC=KQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AA9BC28CF6
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 20:07:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3BC59208A4
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 20:07:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3BC59208A4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732078AbeHAVym (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Aug 2018 17:54:42 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:34865 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726788AbeHAVym (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Aug 2018 17:54:42 -0400
Received: from p4fea5a5a.dip0.t-ipconnect.de ([79.234.90.90] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1fkxOr-0001YQ-9u; Wed, 01 Aug 2018 22:07:13 +0200
Date:   Wed, 1 Aug 2018 22:07:12 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Steven Rostedt <rostedt@goodmis.org>
cc:     Erica Bugden <erica.bugden@linutronix.de>,
        linux-kernel@vger.kernel.org, peterz@infradead.org,
        anna-maria@linutronix.de, bigeasy@linutronix.de
Subject: Re: [PATCH] ftrace: Add missing check for existing hwlat thread
In-Reply-To: <20180801160320.3a4c63f7@gandalf.local.home>
Message-ID: <alpine.DEB.2.21.1808012206570.1835@nanos.tec.linutronix.de>
References: <1533120354-22923-1-git-send-email-erica.bugden@linutronix.de> <20180801154006.580806cc@gandalf.local.home> <alpine.DEB.2.21.1808012151360.1835@nanos.tec.linutronix.de> <20180801160320.3a4c63f7@gandalf.local.home>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 1 Aug 2018, Steven Rostedt wrote:

> On Wed, 1 Aug 2018 21:59:38 +0200 (CEST)
> Thomas Gleixner <tglx@linutronix.de> wrote:
> 
> > > This looks like it is treating the symptom and not the disease.  
> > 
> > My bad. We looked at the other instances of tracers and they all have
> > protection against this kind of call sequence ...
> 
> Probably because they were all fixing the symptom ;-)

:)

> I'm going to keep Erica's patch and add a WARN_ON() to it just in case.
> But can you still check if the patch I gave fixes it too?

Sure
