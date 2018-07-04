Return-Path: <SRS0=cgxA=JU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52B75C3279B
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 16:11:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1533A214FD
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 16:11:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1533A214FD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753015AbeGDQLd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Jul 2018 12:11:33 -0400
Received: from foss.arm.com ([217.140.101.70]:40116 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752399AbeGDQLc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jul 2018 12:11:32 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9CB057A9;
        Wed,  4 Jul 2018 09:11:32 -0700 (PDT)
Received: from edgewater-inn.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 6DD0E3F5AD;
        Wed,  4 Jul 2018 09:11:32 -0700 (PDT)
Received: by edgewater-inn.cambridge.arm.com (Postfix, from userid 1000)
        id 67DEF1AE180C; Wed,  4 Jul 2018 17:12:12 +0100 (BST)
Date:   Wed, 4 Jul 2018 17:12:12 +0100
From:   Will Deacon <will.deacon@arm.com>
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kvmarm@lists.cs.columbia.edu, catalin.marinas@arm.com,
        christoffer.dall@arm.com, drjones@redhat.com, marc.zyngier@arm.com,
        ramana.radhakrishnan@arm.com, suzuki.poulose@arm.com,
        awallis@codeaurora.org
Subject: Re: [PATCHv4 00/10] ARMv8.3 pointer authentication userspace support
Message-ID: <20180704161212.GS4828@arm.com>
References: <20180503132031.25705-1-mark.rutland@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180503132031.25705-1-mark.rutland@arm.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

HI Mark,

On Thu, May 03, 2018 at 02:20:21PM +0100, Mark Rutland wrote:
> This series adds support for the ARMv8.3 pointer authentication extension,
> enabling userspace return address protection with recent versions of GCC.

As discussed off-list, I'd really like to get a feel for how we might use
this to protect the kernel before we commit to a userspace ABI, especially
given that there is some level of resource sharing with the keys.

So ideally, we'd merge this along with the support for the kernel side.
In the meantime, is it worth taking any of the ID register sanity checks
now?

Will
