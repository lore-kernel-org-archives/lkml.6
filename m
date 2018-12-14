Return-Path: <SRS0=kF4g=OX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8DFBC67839
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 08:46:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5E3A12080F
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 08:46:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5E3A12080F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728705AbeLNIqx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Dec 2018 03:46:53 -0500
Received: from Galois.linutronix.de ([146.0.238.70]:48727 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726494AbeLNIqw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Dec 2018 03:46:52 -0500
Received: from bigeasy by Galois.linutronix.de with local (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1gXj7I-0003ad-Im; Fri, 14 Dec 2018 09:46:40 +0100
Date:   Fri, 14 Dec 2018 09:46:40 +0100
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Benjamin Bouvier <benjamin.bouvier@nokia.com>
Cc:     mingo@redhat.com, peterz@infradead.org, rostedt@goodmis.org,
        u.kleine-koenig@pengutronix.de, pkondeti@codeaurora.org,
        alexander.sverdlin@nokia.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sched/debug: Add tracepoint for RT throttling
Message-ID: <20181214084639.f4jnunlalkx2hkz6@linutronix.de>
References: <20181214082741.8507-1-benjamin.bouvier@nokia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20181214082741.8507-1-benjamin.bouvier@nokia.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-12-14 10:27:41 [+0200], Benjamin Bouvier wrote:
> As there is currently no information on which RT task is throttled, add a
> new tracepoint for debug purpose. By the way improve printk debugging
> message by adding task name, pid and cpu for which the throttle has been
> executed.

Throttling is for _all_ RT class applications. The task you print might
be innocent and getting the blame. The interesting part is to see all
the RT tasks (not sure about DL) since the last time, the timer was
started on the CPU.

Sebastian
