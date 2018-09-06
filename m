Return-Path: <SRS0=QnR0=LU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32710C433F5
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 07:35:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EC5FC20659
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 07:35:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EC5FC20659
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727949AbeIFMKC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Sep 2018 08:10:02 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:32769 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725929AbeIFMKC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Sep 2018 08:10:02 -0400
Received: from bigeasy by Galois.linutronix.de with local (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1fxopS-0007zL-0i; Thu, 06 Sep 2018 09:35:50 +0200
Date:   Thu, 6 Sep 2018 09:35:49 +0200
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     linux-kernel@vger.kernel.org,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Carsten Emde <C.Emde@osadl.org>,
        John Kacur <jkacur@redhat.com>,
        Paul Gortmaker <paul.gortmaker@windriver.com>,
        Julia Cartwright <julia@ni.com>,
        Daniel Wagner <daniel.wagner@siemens.com>,
        tom.zanussi@linux.intel.com
Subject: Re: [PATCH RT 08/22] Revert "x86: UV: raw_spinlock conversion"
Message-ID: <20180906073549.zu6gdlwor4fwjngs@linutronix.de>
References: <20180905122754.443196118@goodmis.org>
 <20180905122835.654334475@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180905122835.654334475@goodmis.org>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-09-05 08:28:02 [-0400], Steven Rostedt wrote:
> 4.14.63-rt41-rc1 stable review patch.
> If anyone has any objections, please let me know.
> 
> ------------------
> 
> From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> 
> [ Upstream commit 2a9c45d8f89112458364285cbe2b0729561953f1 ]
> 
> Drop the Ultraviolet patch. UV looks broken upstream for PREEMPT, too.
> Mike is the only person I know that has such a thing and he isn't going
> to fix this upstream (from 1526977462.6491.1.camel@gmx.de):

I don't think that we need to propagate that revert for stable. I
reverted it in the devel tree because nobody wanted this upstream and I
couldn't test it. For that reason I didn't see the point for having it
in the RT tree.
However, if you want to revert it for stable, be my guest. It probably
will have no impact and if it will people might step forward and fix it
properly / upstream.

Sebastian
