Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752098AbeENKpg (ORCPT <rfc822;w@1wt.eu>);
        Mon, 14 May 2018 06:45:36 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:39794 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750760AbeENKpf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 May 2018 06:45:35 -0400
Subject: Re: Difference between IOVA and bus address when SMMU is enabled
To: valmiki <valmikibow@gmail.com>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm-kernel@lists.infradead.org
References: <c4fe00a3-33b1-7cd4-f613-768dee06ef6b@gmail.com>
From: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
Message-ID: <c6521bad-04c9-7bc6-0e7c-b4965de6ff3b@arm.com>
Date: Mon, 14 May 2018 11:45:26 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <c4fe00a3-33b1-7cd4-f613-768dee06ef6b@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Valmiki,

On 12/05/18 13:55, valmiki wrote:
> Hi All,
> 
> What is the difference between IOVA address and bus address
> when SMMU is enabled ?

They are the same. You'll use one term or the other depending on what
system component you're talking about. "IOVA" only means something when
talking about IOMMUs, where it represents the input address. If you're
discussing bus transactions without caring whether an SMMU is enabled or
not, then "bus address" makes more sense.

We distinguish "IOVA" from "VA", which represents the input address of
the CPU's MMU (e.g. any userspace pointer). The distinction is useful
because the SMMU page tables are usually separate from the CPU page
tables. In this case if you want to share a buffer between application
and device, you'll have to allocate and map both a VA on the CPU side,
and an IOVA on the device side. When sharing MMU page tables with the
SMMU (see the SVA work), then we tend to talk about VA instead of IOVA,
because they are identical.

> Is IOVA address term used only when hypervisor is present ?

No, the term is used in bare-metal setups as well.

Thanks,
Jean
