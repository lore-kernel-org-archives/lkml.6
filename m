Return-Path: <SRS0=fL2C=MA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B379FC433F4
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 17:15:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 641AD2150B
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 17:15:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="ivc3wvvQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 641AD2150B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730428AbeIRWs5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Sep 2018 18:48:57 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:35265 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729037AbeIRWs5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Sep 2018 18:48:57 -0400
Received: by mail-ot1-f68.google.com with SMTP id j9-v6so2796759otl.2
        for <linux-kernel@vger.kernel.org>; Tue, 18 Sep 2018 10:15:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=7eEptge3oTBSJ5QRX9F/gUGuBpEGhLdp6vjStpCYLeE=;
        b=ivc3wvvQ67zs27uqN/Hf9nuT8Hsmk5E3B0fwmfhSJUnT0TycdcMbl0pB4T6ZmM/dbT
         2vlas/AXvNgvJm0ndJBiMMmtjj9oG0zlvYe1uAdiOenZuXOBkUkvRuhBH8qzPWsNkZFi
         xy4ko1TrUjDVeppGpQR/xoVZY/Sjtcstee6hs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=7eEptge3oTBSJ5QRX9F/gUGuBpEGhLdp6vjStpCYLeE=;
        b=gd1mmHXa6TeVsWbUo5716kFeAEFNCTwG39ClsL+vopNhfH3O8z7Qdskm0MMgbdT+4M
         vThOsImqXhm7T1RiKjc3IqBxnG1wPwnOqSPDLCGpMrohpR4D542O+yNrR2WXyPYiYNd5
         RFIzfDLFBIZ4ryv25SweznSb5/zHBSF51Ch7iMehv57I9L+yFCAHxc4COaczMaly+k/D
         qiIGE44fx6CSWkAzH+w+qQ2+/2TdeC9NFtCm9rbMdxG82D3fObaG2D96l2S+EQRil3PD
         81ne2cNt/EfavhLetDVEeh1IkvL88ZLgrtUgTBwZeIcK7uU5Hxmnx3weu+ZSQoHcE/Up
         qVfw==
X-Gm-Message-State: APzg51BBAuU0twFAVUsPLA/5zzUaTMbXaQAgUAs24J4FKRD9v0/8osWz
        onl/8SGxe5mZZS9SpUg1SMkLeXOnbWQihXyxuHxf9g==
X-Google-Smtp-Source: ANB0VdYqJ4idrXjHRrAjupa2PPlm4tVYnAdGEsOSLrjfVwYyXDodoRuEwakwGRBXyH6N9hVcw0nnzLByYyPTNqRiLGM=
X-Received: by 2002:a9d:82f:: with SMTP id 44-v6mr16958236oty.377.1537290924554;
 Tue, 18 Sep 2018 10:15:24 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a9d:20e3:0:0:0:0:0 with HTTP; Tue, 18 Sep 2018 10:15:04
 -0700 (PDT)
In-Reply-To: <fec1a2e0-a45a-eb51-6ffe-2ac9b35acc45@arm.com>
References: <20180917104144.19188-1-suzuki.poulose@arm.com>
 <20180917104144.19188-19-suzuki.poulose@arm.com> <CAFEAcA8eWYkzwFYHyP49dasK-NDVbbm=6DbEFNNPq9ZAdUM7JQ@mail.gmail.com>
 <218b64d5-741d-97ef-8aae-bc0a2ac3e56c@arm.com> <CAFEAcA8qjJJ0FkQj4yBMKFrwNFiJj3Q4FBi4GbnK2PN3B3J-mg@mail.gmail.com>
 <fec1a2e0-a45a-eb51-6ffe-2ac9b35acc45@arm.com>
From:   Peter Maydell <peter.maydell@linaro.org>
Date:   Tue, 18 Sep 2018 18:15:04 +0100
Message-ID: <CAFEAcA_tphfZ_BKfAYuefStTipta0notyAR=NCnWFJ6nRfERpg@mail.gmail.com>
Subject: Re: [PATCH v5 18/18] kvm: arm64: Allow tuning the physical address
 size for VM
To:     Suzuki K Poulose <Suzuki.Poulose@arm.com>
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

On 18 September 2018 at 17:27, Suzuki K Poulose <Suzuki.Poulose@arm.com> wrote:
> ---
>
> "On arm64, the physical address size for a VM (IPA Size limit) is limited
> to 40bits by default. The limit can be configured if the host supports the
> extension KVM_CAP_ARM_VM_IPA_SIZE. When supported, use
> KVM_VM_TYPE_ARM_IPA_SIZE(IPA_Bits) to set the size in the machine type
> identifier, where IPA_Bits is the maximum width of any physical
> address used by the VM. The IPA_Bits is encoded in bits[7-0] of the
> machine type identifier.
>
> e.g, to configure a guest to use 48bit physical address size :
>
>         vm_fd = ioctl(dev_fd, KVM_CREATE_VM, KVM_VM_TYPE_ARM_IPA_SIZE(48));
>
> The requested size (IPA_Bits) must be :
>   0 - Implies default 40bits (for backward compatibility)
>
>   or
>
>   N - Implies N bits, where N is a positive integer such that 32 <= N <=
> Host_IPA_Limit
>
> Host_IPA_Limit is the maximum possible value for IPA_Bits on the host and
> is dependent on the CPU capability and the kernel configuration. The limit
> can
> be retrieved using KVM_CAP_ARM_VM_IPA_SIZE of the KVM_CHECK_EXTENSION
> ioctl() at run-time.
>
> Please note that configuring the IPA size does not affect the capability
> exposed by the guest CPUs in ID_AA64MMFR0_EL1[PARange]. It only affects
> the guest to host physical address (stage2) translations setup by the host.
> "

Thanks, this is much clearer. The only bit I'm not sure about is that
last paragraph -- if I ask for a VM with a 48 bit address space why
don't we tell the guest that that's what it has ?

thanks
-- PMM
