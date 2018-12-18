Return-Path: <SRS0=vePq=O3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9713FC43387
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 11:37:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6EB83217D9
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 11:37:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726655AbeLRLhP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Dec 2018 06:37:15 -0500
Received: from foss.arm.com ([217.140.101.70]:43912 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726341AbeLRLhP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Dec 2018 06:37:15 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B4E0B80D;
        Tue, 18 Dec 2018 03:37:14 -0800 (PST)
Received: from localhost (e113682-lin.copenhagen.arm.com [10.32.144.41])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4A0C13F5C0;
        Tue, 18 Dec 2018 03:37:14 -0800 (PST)
Date:   Tue, 18 Dec 2018 12:37:12 +0100
From:   Christoffer Dall <christoffer.dall@arm.com>
To:     Suzuki K Poulose <suzuki.poulose@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kvmarm@lists.cs.columbia.edu, kvm@vger.kernel.org,
        marc.zyngier@arm.com, will.deacon@arm.com, catalin.marinas@arm.com,
        anshuman.khandual@arm.com
Subject: Re: [PATCH v10 0/8] kvm: arm64: Support PUD hugepage at stage 2
Message-ID: <20181218113712.GA25383@e113682-lin.lund.arm.com>
References: <1544548241-6417-1-git-send-email-suzuki.poulose@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1544548241-6417-1-git-send-email-suzuki.poulose@arm.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 11, 2018 at 05:10:33PM +0000, Suzuki K Poulose wrote:
> This series is an update to the PUD hugepage support previously posted
> at [0]. This patchset adds support for PUD hugepages at stage 2 a
> feature that is useful on cores that have support for large sized TLB
> mappings (e.g., 1GB for 4K granule).
> 
> The patches are based on v4.20-rc4
> 
> The patches have been tested on AMD Seattle system with the following
> hugepage sizes - 2M and 1G.
> 
> Right now the PUD hugepage for stage2 is only supported if the stage2
> has 4 levels. i.e, with an IPA size of minimum 44bits with 4K pages.
> This could be relaxed to stage2 with 3 levels, with the stage1 PUD huge
> page mapped in the entry level of the stage2 (i.e, pgd). I have not
> added the change here to keep this version stable w.r.t the previous
> version. I could post a patch later after further discussions in the
> list.
> 

For the series:

Reviewed-by: Christoffer Dall <christoffer.dall@arm.com>
