Return-Path: <SRS0=01Bl=QN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75C4BC169C4
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 10:29:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3798D218A4
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 10:29:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZktpcLN9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729511AbfBFK3X (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Feb 2019 05:29:23 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:37046 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726977AbfBFK3W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Feb 2019 05:29:22 -0500
Received: by mail-wm1-f66.google.com with SMTP id g67so2039858wmd.2;
        Wed, 06 Feb 2019 02:29:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:openpgp:autocrypt:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=dsFh6M05FTa1HqYbD/4s+4kgJRw7zdkrrtt/zNsiACs=;
        b=ZktpcLN91U0UgF8PQujPWH2ZXW3PERhxMzdaVO2TjvMznBszVXcMzV+PA2kOOLKRRE
         L6W0dICXV9AeASGsMBvSH1fq5547GCl/yF8u+VN9tudwZ9SdwykFQh4M3WAQO1977YHW
         3f0ExuBYyd0YRHmA0BCJUZznLmv4pjKRoZhXTtKrQOta5DIeIO0xH7pOzi2tK8URtBQZ
         E9wl0h8RLhCzG3OnrusjWpMgekTjDCgmOjw4BRDdI4Pk4B65Y5Kbvl5QpGEij8ICn4/T
         Xtc/yJoqacyHMT+EAOkmuCuRYIJj9EnHLqYu0OJVHPk2UvNSmoQ4G3Wbhi1TyXNaekWC
         AYLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:openpgp
         :autocrypt:message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=dsFh6M05FTa1HqYbD/4s+4kgJRw7zdkrrtt/zNsiACs=;
        b=fgvuO/k/utBWVhdSOgO1OIiCtv/juxnbvfPSI+99gQJtjhMh+bWqYeaLUS4KdhH1Yq
         qr/eaQzNDyXd4OIk7mPlJucY4Jm8MeQtAOwKKOOLBvBG6QOpExlPMm3NeQvrAnGU/epB
         TO3Cmhseu+/9YfG7r2lVADmzxgMZ1gH3RQCTsB8rBzX3l5AqkNxLPKkw3fODHYGkiWI3
         V3lY2qy0OQQS1iag4TUjeXxYq/fHc4cMPp0mD+APVs8e47pNgvAI7DXouMZb8jqsN8V6
         xZu2C1ZkU4A1PgWtNxlRaw8GBSnJi1v7oLLDDfQiZxyzlyEbkpyZ1aaQWMOFuSpd+Rbh
         kAhw==
X-Gm-Message-State: AHQUAuaOeTvYqBuB3OGYu+0sJ4vY+4MGmvu+DCwVfUl+72GUzgXVErqs
        SdF7yutpPrCUqSPPlK7UFrg=
X-Google-Smtp-Source: AHgI3IZVouy3/JgHh8LbzaKudSE5nr+tlBaSyqNfwpJOz58RzMgf0bBBJm5DOOh4v/UkZd9g4Un5vQ==
X-Received: by 2002:a1c:c181:: with SMTP id r123mr2596668wmf.8.1549448959835;
        Wed, 06 Feb 2019 02:29:19 -0800 (PST)
Received: from ?IPv6:2001:b07:6468:f312:942c:94db:9853:9c8f? ([2001:b07:6468:f312:942c:94db:9853:9c8f])
        by smtp.googlemail.com with ESMTPSA id s8sm22855324wrn.44.2019.02.06.02.29.17
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Wed, 06 Feb 2019 02:29:18 -0800 (PST)
Subject: Re: [RFC PATCH 7/8] KVM: i8254: Remove need for irq ack notifier
To:     "Suthikulpanit, Suravee" <Suravee.Suthikulpanit@amd.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>
Cc:     "joro@8bytes.org" <joro@8bytes.org>,
        "rkrcmar@redhat.com" <rkrcmar@redhat.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "bp@alien8.de" <bp@alien8.de>, "hpa@zytor.com" <hpa@zytor.com>,
        "jsteckli@amazon.de" <jsteckli@amazon.de>,
        "sironi@amazon.de" <sironi@amazon.de>,
        "wawei@amazon.de" <wawei@amazon.de>
References: <20190204144128.9489-1-suravee.suthikulpanit@amd.com>
 <20190204144128.9489-8-suravee.suthikulpanit@amd.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Openpgp: preference=signencrypt
Autocrypt: addr=pbonzini@redhat.com; keydata=
 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
 uUHgL9dKIfvpm+rNXRn9wAwGjk0X/A==
Message-ID: <8ecf791c-d850-25d9-562e-aa2ff5944d2e@redhat.com>
Date:   Wed, 6 Feb 2019 11:29:15 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.1
MIME-Version: 1.0
In-Reply-To: <20190204144128.9489-8-suravee.suthikulpanit@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/02/19 15:42, Suthikulpanit, Suravee wrote:
> From: Julian Stecklina <jsteckli@amazon.de>
> 
> ACK notifiers don't work with AMD AVIC when the PIT interrupt is
> delivered as edge-triggered fixed interrupt via the IOAPIC. AMD
> processors cannot exit on EOI for these interrupts. The ACK notifiers do
> work when the interrupt is delivered via PIC as ExtINT, because the ACK
> comes as PIO write that KVM sees.
> 
> Change the PIT code to not rely on the ACK notifiers. The IRQ ACK
> notifier in the PIT emulation re-schedules pit->expired to reinject any
> pending PIT interrupt. This seems useless, because we can pulse the PIT
> interrupt even when the interrupt is not ACKed yet. This means any timer
> expiry when the interrupt was being handled by the guest, will cause an
> interrupt to be injected automatically when the interrupt is ACKed.

The difference is that with the irq ack notifier *all* the pending PIT 
interrupts will be delivered.  Without, only one will.  If you don't 
want the ack notifier, you can do that with the KVM_REINJECT_CONTROL 
ioctl.

Unfortunately, reinject is enabled by default and that is part of the 
userspace ABI and we cannot change it.

It's possible to enable AVIC when reinject is disabled, and we fix that
at the QEMU level by changing the default reinject behavior, basically
with this one-line change:

diff --git a/hw/i386/kvm/i8254.c b/hw/i386/kvm/i8254.c
index d4d4a85..1d82860 100644
--- a/hw/i386/kvm/i8254.c
+++ b/hw/i386/kvm/i8254.c
@@ -305,7 +305,7 @@ static void kvm_pit_realizefn(DeviceState *dev, Error **errp)
 static Property kvm_pit_properties[] = {
     DEFINE_PROP_UINT32("iobase", PITCommonState, iobase,  -1),
     DEFINE_PROP_LOSTTICKPOLICY("lost_tick_policy", KVMPITState,
-                               lost_tick_policy, LOST_TICK_POLICY_DELAY),
+                               lost_tick_policy, LOST_TICK_POLICY_DISCARD),
     DEFINE_PROP_END_OF_LIST(),
 };
 

plus the corresponding change to compat properties in hw/i386/pc.c.

Alternatively, it is probably a good time to switch the default to split irqchip
in QEMU.  Split irqchip was introduced in kernel 4.5, which was released about
three years ago.

Paolo

> Reviewed-by: Filippo Sironi <sironi@amazon.de>
> Signed-off-by: Julian Stecklina <jsteckli@amazon.de>
> Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>

