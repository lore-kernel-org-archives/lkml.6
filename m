Return-Path: <SRS0=BQBr=JA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id CCBACC433EF
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 21:27:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8AAA9208D4
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 21:27:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8AAA9208D4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755530AbeFNV1M (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Jun 2018 17:27:12 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:49158 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755070AbeFNV1L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jun 2018 17:27:11 -0400
Received: from akpm3.svl.corp.google.com (unknown [104.133.9.92])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id E4E94EC0;
        Thu, 14 Jun 2018 21:27:10 +0000 (UTC)
Date:   Thu, 14 Jun 2018 14:27:10 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Vlastimil Babka <vbabka@suse.cz>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>, linux-mm@kvack.org,
        "Steven J . Hill" <steven.hill@cavium.com>,
        Tejun Heo <htejun@gmail.com>, Christoph Lameter <cl@linux.com>,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH REPOST] Revert mm/vmstat.c: fix vmstat_update()
 preemption BUG
Message-Id: <20180614142710.8eafb333f6060dc19334ae46@linux-foundation.org>
In-Reply-To: <alpine.DEB.2.21.1806132205420.1596@nanos.tec.linutronix.de>
References: <20180504104451.20278-1-bigeasy@linutronix.de>
        <513014a0-a149-5141-a5a0-9b0a4ce9a8d8@suse.cz>
        <20180508160257.6e19707ccf1dabe5ec9e8847@linux-foundation.org>
        <20180509223539.43aznhri72ephluc@linutronix.de>
        <524ecef9-e513-fec4-1178-ac1a87452e57@suse.cz>
        <alpine.DEB.2.21.1806132205420.1596@nanos.tec.linutronix.de>
X-Mailer: Sylpheed 3.6.0 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 13 Jun 2018 23:46:45 +0200 (CEST) Thomas Gleixner <tglx@linutronix.de> wrote:

> Can we please revert that master piece of duct tape engineering and wait
> for someone to actually trigger the warning again?

OK.
