Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752203AbeBHLZi (ORCPT <rfc822;w@1wt.eu>);
        Thu, 8 Feb 2018 06:25:38 -0500
Received: from foss.arm.com ([217.140.101.70]:33350 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751066AbeBHLZh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Feb 2018 06:25:37 -0500
Date: Thu, 8 Feb 2018 11:25:41 +0000
From: Will Deacon <will.deacon@arm.com>
To: Christoffer Dall <christoffer.dall@linaro.org>
Cc: Suzuki K Poulose <suzuki.poulose@arm.com>,
        linux-arm-kernel@lists.infradead.org, kvm@vger.kernel.org,
        kvmarm@lists.cs.columbia.edu, marc.zyngier@arm.com,
        linux-kernel@vger.kernel.org, kristina.martsenko@arm.com,
        peter.maydell@linaro.org, pbonzini@redhat.com, rkrcmar@redhat.com,
        ard.biesheuvel@linaro.org, mark.rutland@arm.com,
        catalin.marinas@arm.com
Subject: Re: [PATCH 00/16] kvm: arm64: Support for dynamic IPA size
Message-ID: <20180208112540.GA17775@arm.com>
References: <20180109190414.4017-1-suzuki.poulose@arm.com>
 <20180208111844.GN29286@cbox>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180208111844.GN29286@cbox>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I can comment on one part here:

On Thu, Feb 08, 2018 at 12:18:44PM +0100, Christoffer Dall wrote:
> Wasn't this also the decision taken for IOMMU page table allocation, and
> why was that the right approach for the IOMMU but not for KVM stage 2
> page tables?  Is there room for reuse of the IOMMU page table allocation
> logic in KVM as well?

There were a few reasons we did this for IOMMU page tables:

  * Ability to use different page size/VA bits/levels from the CPU
  * Ability to support different page table formats (e.g. short descriptor)
  * Ability to determine page table attributes at runtime
  * Requirement to map/unmap in atomic context
  * Ability to cope with non-coherent page table walkers
  * Ability to create both stage-1 and stage-2 mappings
  * Easier to hook in our own TLB invalidation routines
  * Support for lockless concurrent map/unmap within confines of the DMA API
    usage

Will
