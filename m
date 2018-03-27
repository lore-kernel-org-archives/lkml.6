Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755165AbeC0RKx (ORCPT <rfc822;w@1wt.eu>);
        Tue, 27 Mar 2018 13:10:53 -0400
Received: from foss.arm.com ([217.140.101.70]:60126 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753138AbeC0RKu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Mar 2018 13:10:50 -0400
Subject: Re: [RFC v2 01/12] KVM: arm/arm64: Set dist->spis to NULL after kfree
To: Eric Auger <eric.auger@redhat.com>, eric.auger.pro@gmail.com,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        kvmarm@lists.cs.columbia.edu, cdall@kernel.org,
        peter.maydell@linaro.org
Cc: andre.przywara@arm.com, drjones@redhat.com, wei@redhat.com
References: <1522159456-10419-1-git-send-email-eric.auger@redhat.com>
 <1522159456-10419-2-git-send-email-eric.auger@redhat.com>
From: Marc Zyngier <marc.zyngier@arm.com>
Organization: ARM Ltd
Message-ID: <26bb42a7-d946-e52c-68e6-eaeaae325983@arm.com>
Date: Tue, 27 Mar 2018 18:10:46 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <1522159456-10419-2-git-send-email-eric.auger@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27/03/18 15:04, Eric Auger wrote:
> in case kvm_vgic_map_resources() fails, typically if the vgic
> distributor is not defined, __kvm_vgic_destroy will be called
> several times. Indeed kvm_vgic_map_resources() is called on
> first vcpu run. As a result dist->spis is freeed more than once
> and on the second time it causes a "kernel BUG at mm/slub.c:3912!"
> 
> Set dist->spis to NULL to avoid the crash.
> 
> Signed-off-by: Eric Auger <eric.auger@redhat.com>

Fixes: ad275b8bb1e6 ("KVM: arm/arm64: vgic-new: vgic_init: implement
vgic_init")

Reviewed-by: Marc Zyngier <marc.zyngier@arm.com>

	M.
-- 
Jazz is not dead. It just smells funny...
