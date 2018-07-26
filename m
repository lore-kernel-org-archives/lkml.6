Return-Path: <SRS0=7Z+k=KK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39B94C6778F
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 11:46:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E26CF20685
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 11:46:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E26CF20685
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729984AbeGZNCr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Jul 2018 09:02:47 -0400
Received: from ozlabs.org ([203.11.71.1]:45353 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729882AbeGZNCr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jul 2018 09:02:47 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 41bqzx2q9Mz9ryl;
        Thu, 26 Jul 2018 21:46:05 +1000 (AEST)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Mike Kravetz <mike.kravetz@oracle.com>, Alex Ghiti <alex@ghiti.fr>,
        Michal Hocko <mhocko@kernel.org>
Cc:     linux@armlinux.org.uk, catalin.marinas@arm.com,
        will.deacon@arm.com, tony.luck@intel.com, fenghua.yu@intel.com,
        ralf@linux-mips.org, paul.burton@mips.com, jhogan@kernel.org,
        jejb@parisc-linux.org, deller@gmx.de, benh@kernel.crashing.org,
        paulus@samba.org, ysato@users.sourceforge.jp, dalias@libc.org,
        davem@davemloft.net, tglx@linutronix.de, mingo@redhat.com,
        hpa@zytor.com, x86@kernel.org, arnd@arndb.de,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-ia64@vger.kernel.org, linux-mips@linux-mips.org,
        linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-sh@vger.kernel.org, sparclinux@vger.kernel.org,
        linux-arch@vger.kernel.org,
        Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>,
        "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>
Subject: Re: [PATCH v4 00/11] hugetlb: Factorize hugetlb architecture primitives
In-Reply-To: <75195a7d-3d0f-4e55-92cc-4ad772683c75@oracle.com>
References: <20180705110716.3919-1-alex@ghiti.fr> <20180709141621.GD22297@dhcp22.suse.cz> <2173685f-7f85-7acb-4685-2383210c5fa2@ghiti.fr> <75195a7d-3d0f-4e55-92cc-4ad772683c75@oracle.com>
Date:   Thu, 26 Jul 2018 21:46:00 +1000
Message-ID: <87tvomgqyv.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Mike Kravetz <mike.kravetz@oracle.com> writes:

> On 07/20/2018 11:37 AM, Alex Ghiti wrote:
>> Does anyone have any suggestion about those patches ?
>
> I only took a quick look.  From the hugetlb perspective, I like the
> idea of moving routines to a common file.  If any of the arch owners
> (or anyone else) agree, I can do a review of the series.

The conversions look pretty good to me. If you want to give it a review
then from my point of view it could go in -mm to shake out any bugs.

cheers
