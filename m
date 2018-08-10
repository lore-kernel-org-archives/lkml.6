Return-Path: <SRS0=aVpA=KZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE90CC4646D
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Aug 2018 07:30:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A0D252089F
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Aug 2018 07:30:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A0D252089F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727745AbeHJJ6z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Aug 2018 05:58:55 -0400
Received: from mx2.suse.de ([195.135.220.15]:45774 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727538AbeHJJ6z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Aug 2018 05:58:55 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id E871FAF76;
        Fri, 10 Aug 2018 07:30:16 +0000 (UTC)
Date:   Fri, 10 Aug 2018 09:30:16 +0200
From:   Joerg Roedel <jroedel@suse.de>
To:     kernel test robot <lkp@intel.com>
Cc:     LKP <lkp@01.org>, linux-kernel@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: a13c600e15 ("x86/mm/pti: Move user W+X check into .."): WARNING:
 CPU: 0 PID: 1 at arch/x86/mm/dump_pagetables.c:283 note_page
Message-ID: <20180810073016.fn7wrkkdm5p7zv53@suse.de>
References: <5b6cc146.lVmfvLKHKgZxC5d8%lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5b6cc146.lVmfvLKHKgZxC5d8%lkp@intel.com>
User-Agent: NeoMutt/20170421 (1.8.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 10, 2018 at 06:33:42AM +0800, kernel test robot wrote:
> [    9.635329] x86/mm: Checking user space page tables
> [    9.636271] ------------[ cut here ]------------
> [    9.637045] x86/mm: Found insecure W+X mapping at address (ptrval)/0xffc01000
> [    9.638228] WARNING: CPU: 0 PID: 1 at arch/x86/mm/dump_pagetables.c:283 note_page+0x66b/0x870

Hmm, weird, this warning triggers for 32-bit non-pae. There is no
NX-bit in this mode, so the check shouldn't happen there. I'll
investigate.


	Joerg

