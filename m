Return-Path: <SRS0=yjy/=OW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10503C65BAE
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 15:04:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D605F2086D
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 15:04:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D605F2086D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729526AbeLMPEE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Dec 2018 10:04:04 -0500
Received: from Galois.linutronix.de ([146.0.238.70]:46811 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728620AbeLMPED (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Dec 2018 10:04:03 -0500
Received: from bigeasy by Galois.linutronix.de with local (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1gXSWs-0002QC-PF; Thu, 13 Dec 2018 16:03:58 +0100
Date:   Thu, 13 Dec 2018 16:03:58 +0100
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Boqun Feng <boqun.feng@gmail.com>
Cc:     Joel Fernandes <joel@joelfernandes.org>,
        linux-kernel@vger.kernel.org,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        "Paul E. McKenney" <paulmck@linux.ibm.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        tglx@linutronix.de, tj@kernel.org
Subject: Re: [PATCH] srcu: Remove srcu_queue_delayed_work_on()
Message-ID: <20181213150358.bgrwgpp5am5w53ie@linutronix.de>
References: <20181211111238.13474-1-bigeasy@linutronix.de>
 <20181212014016.GA97542@google.com>
 <20181212140519.GA10937@tardis>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20181212140519.GA10937@tardis>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-12-12 22:05:19 [+0800], Boqun Feng wrote:
> So Jiangshan and TJ, what's your opion on this one? If we call a
> queue_work_on() at a place where that target cpu may be offlined, I
> think we have the guarantee that the work will be eventually executed
> even if the cpu is never online again, right? In other words, if a cpu
> has been online once, queue_work_on() on it will be free from racing
> with cpu hotplug.
> 
> Am I right about this, or did I miss something subtle?

tj answered this one:
  https://lkml.kernel.org/r/20180919205521.GE902964@devbig004.ftw2.facebook.com

> Regards,
> Boqun

Sebastian
