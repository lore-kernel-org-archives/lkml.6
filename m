Return-Path: <SRS0=PZjb=LN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6E32C433F4
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 09:15:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 61D4E2082A
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 09:15:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 61D4E2082A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728128AbeH3NQL convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Aug 2018 09:16:11 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:49707 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727089AbeH3NQL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Aug 2018 09:16:11 -0400
Received: from bigeasy by Galois.linutronix.de with local (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1fvJ2W-0007r4-L1; Thu, 30 Aug 2018 11:14:56 +0200
Date:   Thu, 30 Aug 2018 11:14:56 +0200
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Grygorii Strashko <grygorii.strashko@ti.com>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        "linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>,
        Mike Galbraith <efault@gmx.de>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [4.14.66-rt40] [report][cpuhotplug] BUG: sleeping function
 called from invalid context at kernel/locking/rtmutex.c:974
Message-ID: <20180830091456.mz73o26ohrc3rq2f@linutronix.de>
References: <4277080d-fbd1-282c-164d-c07796260c36@ti.com>
 <20180829140817.7pr5g2aonbp55fjr@linutronix.de>
 <3aaebda9-a956-55d6-0b04-f84daa6e4866@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <3aaebda9-a956-55d6-0b04-f84daa6e4866@ti.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-08-29 16:28:50 [-0500], Grygorii Strashko wrote:
> 
> Thank you. Are there any plans to back port them for 4.14-rt?
> Patch [1] need to be reworked a bit, [2] - I was able to cherry-pick from 4.18-rt.

Grygorii, could you please replace the second patch with

  https://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-rt-devel.git/plain/patches/irqchip-gic-v3-its-Move-pending-table-allocation-to-.patch?h=linux-4.18.y-rt-patches

(incremental patch  
  https://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-rt-devel.git/patch/?id=4a0819bb25d12d39c0390636122eefba232596c1
)

and check if it works? It should work but I can't test it myself because
my box with GICv3 died recently…

Sebastian
