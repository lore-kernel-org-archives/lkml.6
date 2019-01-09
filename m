Return-Path: <SRS0=Tk4m=PR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2714C43387
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 09:48:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7FD5620651
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 09:48:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730314AbfAIJsx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Jan 2019 04:48:53 -0500
Received: from Galois.linutronix.de ([146.0.238.70]:53310 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727828AbfAIJsx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jan 2019 04:48:53 -0500
Received: from bigeasy by Galois.linutronix.de with local (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1ghATh-0002K1-O5; Wed, 09 Jan 2019 10:48:49 +0100
Date:   Wed, 9 Jan 2019 10:48:49 +0100
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Scott Wood <swood@redhat.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Mikulas Patocka <mpatocka@redhat.com>,
        linux-rt-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH RT] rtmutex: Flush block plug on __down_read()
Message-ID: <20190109094849.m7idtma5hoew3eyp@linutronix.de>
References: <1546634001-4450-1-git-send-email-swood@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1546634001-4450-1-git-send-email-swood@redhat.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019-01-04 15:33:21 [-0500], Scott Wood wrote:
> +	/*
> +	 * If sem->rtmutex blocks, the function sched_submit_work will not
> +	 * call blk_schedule_flush_plug (because tsk_is_pi_blocked would be
> +	 * true).  We must call blk_schedule_flush_plug here; if we don't
> +	 * call it, an I/O deadlock may occur.
> +	 */

I kept the original comment plus I replaced device-mapper with I/O (the
patch said already that it is not device-mapper specific and may occur
with ext4 as well).

Sebastian
