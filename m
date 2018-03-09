Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932167AbeCINsL (ORCPT <rfc822;w@1wt.eu>);
        Fri, 9 Mar 2018 08:48:11 -0500
Received: from foss.arm.com ([217.140.101.70]:51968 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932135AbeCINsJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Mar 2018 08:48:09 -0500
Date: Fri, 9 Mar 2018 13:48:13 +0000
From: Will Deacon <will.deacon@arm.com>
To: Shanker Donthineni <shankerd@codeaurora.org>
Cc: Robin Murphy <robin.murphy@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        kvmarm <kvmarm@lists.cs.columbia.edu>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Vikram Sethi <vikrams@codeaurora.org>,
        Philip Elcan <pelcan@codeaurora.org>
Subject: Re: [PATCH v7] arm64: Add support for new control bits CTR_EL0.DIC
 and CTR_EL0.IDC
Message-ID: <20180309134813.GD15537@arm.com>
References: <1520434808-29703-1-git-send-email-shankerd@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1520434808-29703-1-git-send-email-shankerd@codeaurora.org>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 07, 2018 at 09:00:08AM -0600, Shanker Donthineni wrote:
> The DCache clean & ICache invalidation requirements for instructions
> to be data coherence are discoverable through new fields in CTR_EL0.
> The following two control bits DIC and IDC were defined for this
> purpose. No need to perform point of unification cache maintenance
> operations from software on systems where CPU caches are transparent.
> 
> This patch optimize the three functions __flush_cache_user_range(),
> clean_dcache_area_pou() and invalidate_icache_range() if the hardware
> reports CTR_EL0.IDC and/or CTR_EL0.IDC. Basically it skips the two
> instructions 'DC CVAU' and 'IC IVAU', and the associated loop logic
> in order to avoid the unnecessary overhead.

Cheers, I've queued this for 4.17.

Will
