Return-Path: <SRS0=qqIy=KO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2031FD21E1
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 10:21:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9221320893
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 10:21:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9221320893
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727517AbeG3LzX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Jul 2018 07:55:23 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:55683 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726623AbeG3LzX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jul 2018 07:55:23 -0400
Received: from hsi-kbw-5-158-153-52.hsi19.kabel-badenwuerttemberg.de ([5.158.153.52] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1fk5IP-0005lU-EI; Mon, 30 Jul 2018 12:20:57 +0200
Date:   Mon, 30 Jul 2018 12:20:57 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
cc:     isaacm@codeaurora.org, peterz@infradead.org,
        matt@codeblueprint.co.uk, mingo@kernel.org,
        linux-kernel@vger.kernel.org, psodagud@codeaurora.org,
        gregkh@linuxfoundation.org, pkondeti@codeaurora.org,
        stable@vger.kernel.org
Subject: Re: [PATCH] stop_machine: Disable preemption after queueing stopper
 threads
In-Reply-To: <20180724062350.nlem2suuy5wlxpts@linutronix.de>
Message-ID: <alpine.DEB.2.21.1807301220280.2518@nanos.tec.linutronix.de>
References: <1531856129-9871-1-git-send-email-isaacm@codeaurora.org> <a30d1e147d3181fc7b294262e380a10c@codeaurora.org> <20180724062350.nlem2suuy5wlxpts@linutronix.de>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 24 Jul 2018, Sebastian Andrzej Siewior wrote:
> On 2018-07-23 18:13:48 [-0700], isaacm@codeaurora.org wrote:
> > Hi all,
> Hi,
> 
> > Are there any comments about this patch?
> 
> I haven't look in detail at this but your new preempt_disable() makes
> things unbalanced for the err != 0 case.

It doesn't but that code is really an unreadable pile of ...
