Return-Path: <SRS0=zRJA=NN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2C9FC32789
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 08:39:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A9F302081B
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 08:39:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A9F302081B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726362AbeKBRqE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Nov 2018 13:46:04 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:38342 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725990AbeKBRqE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Nov 2018 13:46:04 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 858701596;
        Fri,  2 Nov 2018 01:39:41 -0700 (PDT)
Received: from localhost (e113682-lin.copenhagen.arm.com [10.32.144.41])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E303A3F71D;
        Fri,  2 Nov 2018 01:39:40 -0700 (PDT)
Date:   Fri, 2 Nov 2018 09:39:39 +0100
From:   Christoffer Dall <christoffer.dall@arm.com>
To:     Amit Daniel Kachhap <amit.kachhap@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org,
        Marc Zyngier <marc.zyngier@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Andrew Jones <drjones@redhat.com>,
        Dave Martin <Dave.Martin@arm.com>,
        Ramana Radhakrishnan <ramana.radhakrishnan@arm.com>,
        kvmarm@lists.cs.columbia.edu,
        Kristina Martsenko <kristina.martsenko@arm.com>,
        linux-kernel@vger.kernel.org, Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH v3 6/7] arm64: docs: document KVM support of pointer
 authentication
Message-ID: <20181102083939.GW12057@e113682-lin.lund.arm.com>
References: <1539773280-4159-1-git-send-email-amit.kachhap@arm.com>
 <1539773280-4159-7-git-send-email-amit.kachhap@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1539773280-4159-7-git-send-email-amit.kachhap@arm.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 17, 2018 at 04:17:59PM +0530, Amit Daniel Kachhap wrote:
> The documentation is updated to help in using pointer authentication
> for KVM guests.
> 
> Signed-off-by: Amit Daniel Kachhap <amit.kachhap@arm.com>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: Christoffer Dall <christoffer.dall@arm.com>
> Cc: Marc Zyngier <marc.zyngier@arm.com>
> Cc: kvmarm@lists.cs.columbia.edu
> ---
>  Documentation/arm64/pointer-authentication.txt | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/arm64/pointer-authentication.txt b/Documentation/arm64/pointer-authentication.txt
> index 8a9cb57..b00d735 100644
> --- a/Documentation/arm64/pointer-authentication.txt
> +++ b/Documentation/arm64/pointer-authentication.txt
> @@ -78,7 +78,13 @@ to TTBR1 addresses (e.g. kernel pointers).
>  Virtualization
>  --------------
>  
> -Pointer authentication is not currently supported in KVM guests. KVM
> +Pointer authentication is enabled in KVM guest when virtual machine is
> +created by passing a flag requesting this feature to be enabled. Without
> +this flag, pointer authentication is not enabled in KVM guests and KVM
>  will mask the feature bits from ID_AA64ISAR1_EL1, and attempted use of
>  the feature will result in an UNDEFINED exception being injected into
>  the guest.
> +
> +The flag to enable this feature is KVM_ARM_VCPU_PTRAUTH and should be
> +used in KVM API KVM_ARM_VCPU_INIT. The pointer authentication key
> +registers are hidden from userspace if this feature is not enabled.
> -- 
> 2.7.4
> 

I think this is placed in the wrong file.

Any information about the KVM API should go in
Documentation/virtual/kvm/api.txt.

The only information about KVM that belongs in this file would be host
running a VM with ptrauth can affect the host's ptrauth state (if that
applies).


Thanks,

    Christoffer
