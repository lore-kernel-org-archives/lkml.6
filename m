Return-Path: <SRS0=RpQd=J3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDC4EC5CFEB
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 13:24:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 73C3120652
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 13:24:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 73C3120652
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387851AbeGKN2a (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Jul 2018 09:28:30 -0400
Received: from ozlabs.org ([203.11.71.1]:50751 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732530AbeGKN2a (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jul 2018 09:28:30 -0400
Received: by ozlabs.org (Postfix, from userid 1034)
        id 41Qft01FR3zB4MS; Wed, 11 Jul 2018 23:24:07 +1000 (AEST)
X-powerpc-patch-notification: thanks
X-powerpc-patch-commit: a545cf032d11437ed86e62f00d499108d91cae54
In-Reply-To: <20180611202904.GA25538@jordon-HP-15-Notebook-PC>
To:     Souptick Joarder <jrdr.linux@gmail.com>, willy@infradead.org,
        fbarrat@linux.vnet.ibm.com, andrew.donnellan@au1.ibm.com,
        arnd@arndb.de, gregkh@linuxfoundation.org
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
Cc:     brajeswar.linux@gmail.com, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org, sabyasachi.linux@gmail.com
Subject: Re: misc: ocxl: Change return type for fault handler
Message-Id: <41Qft01FR3zB4MS@ozlabs.org>
Date:   Wed, 11 Jul 2018 23:24:07 +1000 (AEST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2018-06-11 at 20:29:04 UTC, Souptick Joarder wrote:
> Use new return type vm_fault_t for fault handler. For
> now, this is just documenting that the function returns
> a VM_FAULT value rather than an errno. Once all instances
> are converted, vm_fault_t will become a distinct type.
> 
> Ref-> commit 1c8f422059ae ("mm: change return type to vm_fault_t")
> 
> There is an existing bug when vm_insert_pfn() can return
> ENOMEM which was ignored and VM_FAULT_NOPAGE returned as
> default. The new inline vmf_insert_pfn() has removed
> this inefficiency by returning correct vm_fault_ type.
> 
> Signed-off-by: Souptick Joarder <jrdr.linux@gmail.com>
> Acked-by: Andrew Donnellan <andrew.donnellan@au1.ibm.com>
> Acked-by: Frederic Barrat <fbarrat@linux.vnet.ibm.com>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/a545cf032d11437ed86e62f00d4991

cheers
