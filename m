Return-Path: <SRS0=A5JR=LD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E494CC4321D
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Aug 2018 13:18:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A7328216C4
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Aug 2018 13:18:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A7328216C4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727256AbeHTQdr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Aug 2018 12:33:47 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:55402 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726632AbeHTQdr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Aug 2018 12:33:47 -0400
Received: from hsi-kbw-5-158-153-52.hsi19.kabel-badenwuerttemberg.de ([5.158.153.52] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1frk4M-0005le-IK; Mon, 20 Aug 2018 15:18:06 +0200
Date:   Mon, 20 Aug 2018 15:18:06 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Juergen Gross <jgross@suse.com>
cc:     linux-kernel@vger.kernel.org, xen-devel@lists.xenproject.org,
        x86@kernel.org, boris.ostrovsky@oracle.com, hpa@zytor.com,
        mingo@redhat.com, pasha.tatashin@oracle.com
Subject: Re: [PATCH] x86/xen: enable early use of set_fixmap in 32-bit Xen
 PV guest
In-Reply-To: <20180817134016.19957-1-jgross@suse.com>
Message-ID: <alpine.DEB.2.21.1808201514100.1551@nanos.tec.linutronix.de>
References: <20180817134016.19957-1-jgross@suse.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 17 Aug 2018, Juergen Gross wrote:

> Commit 7b25b9cb0dad83 ("x86/xen/time: Initialize pv xen time in
> init_hypervisor_platform()") moved the mapping of the shared info area
> before pagetable_init(). This breaks booting as 32-bit PV guest as the
> use of set_fixmap isn't possible at this time on 32-bit.
> 
> This can be worked around by populating the needed PMD on 32-bit
> kernel earlier.
> 
> In order not to reimplement populate_extra_pte() using extend_brk()
> for allocating new page tables extend alloc_low_pages() to do that in
> case the early page table pool is not yet available.
> 
> Fixes: 7b25b9cb0dad83

  ^^^ That's missing the subject text

Other than that:

Reviewd-by: Thomas Gleixner <tglx@linutronix.de>

