Return-Path: <SRS0=sqHT=JP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC84AC43144
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 15:58:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A157C24B56
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 15:58:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A157C24B56
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966724AbeF2P6v (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Jun 2018 11:58:51 -0400
Received: from foss.arm.com ([217.140.101.70]:36470 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S934265AbeF2P6t (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jun 2018 11:58:49 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 06B6518A;
        Fri, 29 Jun 2018 08:58:49 -0700 (PDT)
Received: from [10.1.206.34] (melchizedek.cambridge.arm.com [10.1.206.34])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 33AE73F5C0;
        Fri, 29 Jun 2018 08:58:46 -0700 (PDT)
Subject: Re: [PATCH v5 2/2] arm64: KVM: export the capability to set guest
 SError syndrome
To:     Dongjiu Geng <gengdongjiu@huawei.com>
References: <1529960309-2513-1-git-send-email-gengdongjiu@huawei.com>
 <1529960309-2513-3-git-send-email-gengdongjiu@huawei.com>
From:   James Morse <james.morse@arm.com>
Cc:     rkrcmar@redhat.com, corbet@lwn.net, christoffer.dall@arm.com,
        marc.zyngier@arm.com, linux@armlinux.org.uk,
        catalin.marinas@arm.com, will.deacon@arm.com, kvm@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org
Message-ID: <bca12032-c465-1d10-f7d4-71fc044ac695@arm.com>
Date:   Fri, 29 Jun 2018 16:58:44 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <1529960309-2513-3-git-send-email-gengdongjiu@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dongjiu Geng,

This patch doesn't apply on v4.18-rc2.

Documentation/virtual/kvm/api.txt already has a 8.18 section. I guess you based
this on v4.17.

For posting patches, please use the latest 'rc' from Linus' tree, (or the
maintainer's tree listed in MAINTAINERS for the tree you are targeting if the
maintainer has started to pick up patches).


Thanks,

James


On 25/06/18 21:58, Dongjiu Geng wrote:
> For the arm64 RAS Extension, user space can inject a virtual-SError
> with specified ESR. So user space needs to know whether KVM support
> to inject such SError, this interface adds this query for this capability.
> 
> KVM will check whether system support RAS Extension, if supported, KVM
> returns true to user space, otherwise returns false.


> diff --git a/Documentation/virtual/kvm/api.txt b/Documentation/virtual/kvm/api.txt
> index 3732097..86b3808 100644
> --- a/Documentation/virtual/kvm/api.txt
> +++ b/Documentation/virtual/kvm/api.txt
> @@ -4628,3 +4628,14 @@ Architectures: s390
>  This capability indicates that kvm will implement the interfaces to handle
>  reset, migration and nested KVM for branch prediction blocking. The stfle
>  facility 82 should not be provided to the guest without this capability.
> +
> +8.14 KVM_CAP_ARM_SET_SERROR_ESR
> +
> +Architectures: arm, arm64
> +
> +This capability indicates that userspace can specify the syndrome value reported
> +to the guest OS when guest takes a virtual SError interrupt exception.
> +If KVM has this capability, userspace can only specify the ISS field for the ESR
> +syndrome, it can not specify the EC field which is not under control by KVM.
> +If this virtual SError is taken to EL1 using AArch64, this value will be reported
> +in ISS filed of ESR_EL1.



