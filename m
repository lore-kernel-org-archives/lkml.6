Return-Path: <SRS0=GJN7=OT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82FD5C04EB8
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 09:01:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 49FC62082F
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 09:01:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 49FC62082F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726881AbeLJJBs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Dec 2018 04:01:48 -0500
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:48996 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726531AbeLJJBr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Dec 2018 04:01:47 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 59E4B1596;
        Mon, 10 Dec 2018 01:01:47 -0800 (PST)
Received: from localhost (e113682-lin.copenhagen.arm.com [10.32.144.41])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id BEB343F575;
        Mon, 10 Dec 2018 01:01:46 -0800 (PST)
Date:   Mon, 10 Dec 2018 10:01:45 +0100
From:   Christoffer Dall <christoffer.dall@arm.com>
To:     Anshuman Khandual <anshuman.khandual@arm.com>
Cc:     Punit Agrawal <punit.agrawal@arm.com>,
        kvmarm@lists.cs.columbia.edu, suzuki.poulose@arm.com,
        marc.zyngier@arm.com, Catalin Marinas <catalin.marinas@arm.com>,
        will.deacon@arm.com, linux-kernel@vger.kernel.org,
        Russell King <linux@armlinux.org.uk>, punitagrawal@gmail.com,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v9 3/8] KVM: arm/arm64: Introduce helpers to manipulate
 page table entries
Message-ID: <20181210090145.GE30263@e113682-lin.lund.arm.com>
References: <20181031175745.18650-1-punit.agrawal@arm.com>
 <20181031175745.18650-4-punit.agrawal@arm.com>
 <396402d5-fddf-ab72-01c4-80dd1a0d4d44@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <396402d5-fddf-ab72-01c4-80dd1a0d4d44@arm.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 03, 2018 at 07:20:08PM +0530, Anshuman Khandual wrote:
> 
> 
> On 10/31/2018 11:27 PM, Punit Agrawal wrote:
> > Introduce helpers to abstract architectural handling of the conversion
> > of pfn to page table entries and marking a PMD page table entry as a
> > block entry.
> 
> Why is this necessary ? we would still need to access PMD, PUD as is
> without any conversion. IOW KVM knows the breakdown of the page table
> at various levels. Is this something required from generic KVM code ?
>   
> > 
> > The helpers are introduced in preparation for supporting PUD hugepages
> > at stage 2 - which are supported on arm64 but do not exist on arm.
> 
> Some of these patches (including the earlier two) are good on it's
> own. Do we have still mention in commit message about the incoming PUD
> enablement as the reason for these cleanup patches ?
> 

Does it hurt?  What is your concern here?


Thanks,

    Christoffer
