Return-Path: <SRS0=Tk4m=PR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6896CC43387
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 18:42:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 41BCF20657
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 18:42:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727704AbfAISmN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Jan 2019 13:42:13 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:41740 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726465AbfAISmM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jan 2019 13:42:12 -0500
Received: from akpm3.svl.corp.google.com (unknown [104.133.8.65])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 114F4BF9;
        Wed,  9 Jan 2019 18:42:12 +0000 (UTC)
Date:   Wed, 9 Jan 2019 10:42:11 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Souptick Joarder <jrdr.linux@gmail.com>
Cc:     dave.hansen@linux.intel.com, luto@kernel.org, peterz@infradead.org,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, hpa@zytor.com,
        x86@kernel.org, linux-kernel@vger.kernel.org, willy@infradead.org
Subject: Re: [PATCH v2] x86/mm/fault.c: Convert to use vm_fault_t
Message-Id: <20190109104211.ce93b844df26c340100cfa14@linux-foundation.org>
In-Reply-To: <20190109183742.GA24326@jordon-HP-15-Notebook-PC>
References: <20190109183742.GA24326@jordon-HP-15-Notebook-PC>
X-Mailer: Sylpheed 3.6.0 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 10 Jan 2019 00:07:42 +0530 Souptick Joarder <jrdr.linux@gmail.com> wrote:

> Convert to use vm_fault_t type for last argument of do_sigbus().
> 
> kbuild reported a warning during testing of final vm_fault_t patch
> integrated in mm tree.

Please be more specific when identifying patches.

> [auto build test WARNING on linus/master]
> [also build test WARNING on v5.0-rc1 next-20190109]
> [if your patch is applied to the wrong git tree, please drop us a note
> to help improve the system]
> 
> https://github.com/0day-ci/linux/commits/Souptick-Joarder/
> mm-Create-the-new-vm_fault_t-type/20190109-154216
> 
> All warnings:
> 
> arch/x86/mm/fault.c:1051:39: warning: restricted vm_fault_t degrades to integer
> arch/x86/mm/fault.c:1057:29: warning: restricted vm_fault_t degrades to integer
> arch/x86/mm/fault.c:1059:29: warning: restricted vm_fault_t degrades to integer
> arch/x86/mm/fault.c:1094:62: warning: incorrect type in argument 4 (different base types)
> arch/x86/mm/fault.c:1094:62:    expected unsigned int fault
> arch/x86/mm/fault.c:1094:62:    got restricted vm_fault_t [usertype] fault
> 
> This patch has fixed the warnings.
> 

I'll be folding this into "mm: Create the new vm_fault_t type".
