Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 973D0ECE563
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 14:20:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5015C206B5
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 14:20:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="beaDVq32"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5015C206B5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728784AbeIQTsI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Sep 2018 15:48:08 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:33438 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727858AbeIQTsI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Sep 2018 15:48:08 -0400
Received: by mail-ot1-f65.google.com with SMTP id i10-v6so11441715oth.0
        for <linux-kernel@vger.kernel.org>; Mon, 17 Sep 2018 07:20:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=Hpw+5A8GUyuHMXaHaMrGoShn4U2Mtb+89N0i4AYia9A=;
        b=beaDVq32HaJC/c0oKGVrfBVDJjQR+/BNQLNUgx5yjrCfeQDn69iTGcq/STAGXIy0Ra
         wmjfvXYHU8SpNMhbBQLmKWAGMiuVflrj1lG60Yc1n9p6xa5+0toMoj+Gbe9S0EKGWGul
         w1Dvbk4WtKazCcxdP7ss/xaj/+LV5+72E/Fjc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=Hpw+5A8GUyuHMXaHaMrGoShn4U2Mtb+89N0i4AYia9A=;
        b=DhofKSf7jzsqoUR63Rs9j2q1ccrCdXQun+7HsTlNmnIOLcb8hvpo9k8JIFt8H7Oz8e
         nMeU3nGtaMmgTpa5CkM9wPcSEVMT1EwES1X2183BnQiqyWuVkNgP0o2qFA36AYNCAs4E
         WxqRZqtG9uINFLLdwyoFIyCTnjdT/Llj7VYCWZDJCwu4B4bZ6gRxgm3I1xySZteN/QM9
         jwB+SsW0Gl/3jl59Mx/JIuMEtNt2e+Zr1hPKxhnVttrg+MqJ2ptbZmp627OfvO3WqivN
         l/lrdGgo+sFcaZ4H8SaEXq83wD1CubfJEBEW44o61aOzvUCFDzEIp5BsKJMWvOT4UqOu
         o+Sg==
X-Gm-Message-State: APzg51DLWcYkfp+E5ZNDpBFiUk5juVV2BfAGSsw/rO8+vCQxNdVOR5lk
        rzqT29IXIZ95cBCszQ1w5oHK8PyYoet7CXh92szjMA==
X-Google-Smtp-Source: ANB0VdbQpCm3DsUPCDEZbhePdtHJjsrAdi3tZGxDu7dPGidXsjc32UcLaZMOe9i8/hduxWDFdxTAgxvGRrfG1/G0V1w=
X-Received: by 2002:a9d:82f:: with SMTP id 44-v6mr13186771oty.377.1537194035720;
 Mon, 17 Sep 2018 07:20:35 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a9d:20e3:0:0:0:0:0 with HTTP; Mon, 17 Sep 2018 07:20:15
 -0700 (PDT)
In-Reply-To: <20180917104144.19188-19-suzuki.poulose@arm.com>
References: <20180917104144.19188-1-suzuki.poulose@arm.com> <20180917104144.19188-19-suzuki.poulose@arm.com>
From:   Peter Maydell <peter.maydell@linaro.org>
Date:   Mon, 17 Sep 2018 15:20:15 +0100
Message-ID: <CAFEAcA-AKpkzSpMofMFxxf5XdYPii3PTB8xXDAvmyFWno7nZeA@mail.gmail.com>
Subject: Re: [PATCH v5 18/18] kvm: arm64: Allow tuning the physical address
 size for VM
To:     Suzuki K Poulose <suzuki.poulose@arm.com>
Cc:     arm-mail-list <linux-arm-kernel@lists.infradead.org>,
        kvmarm@lists.cs.columbia.edu, kvm-devel <kvm@vger.kernel.org>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Christoffer Dall <cdall@kernel.org>,
        Eric Auger <eric.auger@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        Will Deacon <will.deacon@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        James Morse <james.morse@arm.com>,
        Dave P Martin <dave.martin@arm.com>, julien.grall@arm.com,
        lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17 September 2018 at 11:41, Suzuki K Poulose <suzuki.poulose@arm.com> wrote:
> Allow specifying the physical address size limit for a new
> VM via the kvm_type argument for the KVM_CREATE_VM ioctl. This
> allows us to finalise the stage2 page table as early as possible
> and hence perform the right checks on the memory slots
> without complication. The size is ecnoded as Log2(PA_Size) in
> bits[7:0] of the type field. For backward compatibility the
> value 0 is reserved and implies 40bits. Also, lift the limit
> of the IPA to host limit and allow lower IPA sizes (e.g, 32).
>
> The userspace could check the extension KVM_CAP_ARM_VM_PHYS_SHIFT
> for the availability of this feature. The cap check returns the
> maximum limit for the physical address shift supported by the host.
>
> Cc: Marc Zyngier <marc.zyngier@arm.com>
> Cc: Christoffer Dall <cdall@kernel.org>
> Cc: Peter Maydel <peter.maydell@linaro.org>

Typo: my surname has two "l"s in it.

thanks
-- PMM
