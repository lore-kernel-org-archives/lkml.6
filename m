Return-Path: <SRS0=RpQd=J3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,URIBL_SBL,URIBL_SBL_A autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69483C43A1D
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 22:40:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1DF4A2146E
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 22:40:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1DF4A2146E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390678AbeGKWq7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Jul 2018 18:46:59 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:41726 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387477AbeGKWq7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jul 2018 18:46:59 -0400
Received: from akpm3.svl.corp.google.com (unknown [104.133.9.92])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 8D462AE0;
        Wed, 11 Jul 2018 22:40:28 +0000 (UTC)
Date:   Wed, 11 Jul 2018 15:40:27 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Andrea Arcangeli <aarcange@redhat.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: [2/2] mm: Drop unneeded ->vm_ops checks
Message-Id: <20180711154027.66dd158b11ab144f2f776221@linux-foundation.org>
In-Reply-To: <20180711221742.GA9360@roeck-us.net>
References: <20180710134821.84709-3-kirill.shutemov@linux.intel.com>
        <20180711221742.GA9360@roeck-us.net>
X-Mailer: Sylpheed 3.6.0 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 11 Jul 2018 15:17:42 -0700 Guenter Roeck <linux@roeck-us.net> wrote:

> On Tue, Jul 10, 2018 at 04:48:21PM +0300, Kirill A. Shutemov wrote:
> > We now have all VMAs with ->vm_ops set and don't need to check it for
> > NULL everywhere.
> > 
> > Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> 
> This patch causes two of my qemu tests to fail:
> 	arm:mps2-an385:mps2_defconfig:mps2-an385
> 	xtensa:de212:kc705-nommu:nommu_kc705_defconfig
> 
> Both are nommu configurations.
> 
> Reverting the patch fixes the problem. Bisect log is attached for reference.

Thanks.  And there's the /dev/ion sysbot bug report.

mm-drop-unneeded-vm_ops-checks.patch needs some more work - let's drop it
for now.

