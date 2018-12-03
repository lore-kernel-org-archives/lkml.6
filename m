Return-Path: <SRS0=Grn6=OM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 329DCC04EBF
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 11:01:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 03FEA2145D
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 11:01:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 03FEA2145D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726314AbeLCLBr convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Dec 2018 06:01:47 -0500
Received: from prv1-mh.provo.novell.com ([137.65.248.33]:45299 "EHLO
        prv1-mh.provo.novell.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725888AbeLCLBr (ORCPT
        <rfc822;groupwise-linux-kernel@vger.kernel.org:7:1>);
        Mon, 3 Dec 2018 06:01:47 -0500
Received: from INET-PRV1-MTA by prv1-mh.provo.novell.com
        with Novell_GroupWise; Mon, 03 Dec 2018 04:01:13 -0700
Message-Id: <5C050CF3020000780020223F@prv1-mh.provo.novell.com>
X-Mailer: Novell GroupWise Internet Agent 18.1.0 
Date:   Mon, 03 Dec 2018 04:01:07 -0700
From:   "Jan Beulich" <JBeulich@suse.com>
To:     "Marek Marczykowski" <marmarek@invisiblethingslab.com>
Cc:     "Dwayne Litzenberger" <dlitz@dlitz.net>,
        "Stefano Stabellini" <sstabellini@kernel.org>,
        "xen-devel" <xen-devel@lists.xenproject.org>,
        "Boris Ostrovsky" <boris.ostrovsky@oracle.com>,
        "Juergen Gross" <jgross@suse.com>, <linux-kernel@vger.kernel.org>
Subject: Re: [Xen-devel] [PATCH 2/2] xen-pciback: Allow
 enabling/disabling expansion ROM
References: <cover.55c0e31b75e2fbdf4206cc39c2fd7581793ae7ae.1543772656.git-series.marmarek@invisiblethingslab.com><cover.55c0e31b75e2fbdf4206cc39c2fd7581793ae7ae.1543772656.git-series.marmarek@invisiblethingslab.com>
 <a05e3cf451d692dc4b1c81c8b5d66fc75d1fa325.1543772656.git-series.marmarek@invisiblethingslab.com>
In-Reply-To: <a05e3cf451d692dc4b1c81c8b5d66fc75d1fa325.1543772656.git-series.marmarek@invisiblethingslab.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>>> On 02.12.18 at 18:47, <marmarek@invisiblethingslab.com> wrote:
> From: Dwayne Litzenberger <dlitz@dlitz.net>
> 
> Newer AMD GPUs store their initialization routines as bytecode on the
> ROM.  This fixes the following initialization error inside the VM when
> doing PCI passthrough:
> 
>     radeon 0000:00:05.0: Invalid PCI ROM header signature: expecting 0xaa55, got 0xffff
>     radeon 0000:00:05.0: Invalid PCI ROM header signature: expecting 0xaa55, got 0xffff
>     [drm:radeon_get_bios [radeon]] *ERROR* Unable to locate a BIOS ROM
>     radeon 0000:00:05.0: Fatal error during GPU init

Isn't it that qemu is supposed to surface the ROM image to guests,
making it unnecessary to allow guests control over the physical
enable bit? Also why would allowing to alter the bit depend on
whether the address portion of the value is non-zero?

Jan


