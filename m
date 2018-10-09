Return-Path: <SRS0=T/cj=MV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 778F6C64EAD
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 10:56:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3BE432064E
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 10:56:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3BE432064E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726691AbeJISMu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Oct 2018 14:12:50 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:43057 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726103AbeJISMu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Oct 2018 14:12:50 -0400
Received: from bigeasy by Galois.linutronix.de with local (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1g9pgc-0001pc-4L; Tue, 09 Oct 2018 12:56:22 +0200
Date:   Tue, 9 Oct 2018 12:56:22 +0200
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Andrea Parri <andrea.parri@amarulasolutions.com>
Cc:     Julia Cartwright <julia@ni.com>, Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>,
        Steffen Trumtrar <s.trumtrar@pengutronix.de>,
        Tim Sander <tim@krieglstein.org>,
        Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH 1/2] kthread: convert worker lock to raw spinlock
Message-ID: <20181009105621.plqufigiauieir7z@linutronix.de>
References: <cover.1538089179.git.julia@ni.com>
 <da33d7d7aa32d08f9cbf5016fb04426f90645cb0.1538089180.git.julia@ni.com>
 <20181005181035.GA19828@andrea>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20181005181035.GA19828@andrea>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-10-05 20:10:35 [+0200], Andrea Parri wrote:
> 
> Clearly not my topic..., but out of curiosity:  What do you mean by
> "well-bounded" and "minimal"?  Can you maybe point me to some doc.?

it means that the lock is not held for an arbitrary amount of time like
by processing a list with thousand items. Well-bounded would mean not
process more than one or five (or so) at a time.

>   Andrea

Sebastian
