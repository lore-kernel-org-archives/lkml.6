Return-Path: <SRS0=PvM2=PP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86902C43387
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 16:20:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4BD852147C
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 16:20:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eV+GpH4A"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730063AbfAGQUk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Jan 2019 11:20:40 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:44188 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726864AbfAGQUj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jan 2019 11:20:39 -0500
Received: by mail-wr1-f66.google.com with SMTP id z5so993266wrt.11;
        Mon, 07 Jan 2019 08:20:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:openpgp:autocrypt:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=wo6kvzYCEB9x6sNLpbzEiDdvddMlVBTQkNzc4peqcCQ=;
        b=eV+GpH4AQ6+7T7LIwNOOOejnJmtqZM2yXT2/VG308IJZHjjJWS3N9gcP2nHKtkdKM/
         JSHGL1niPKpht2EkJPG0TH/ZEyjxwZOOxHQZipQC4OkRjBRRecfDTw4YBB1LwHoXFC9v
         tlQODf899mTtivp7XmyjMbe28JPPTbJdZqkufAuDIxH0pbKvIfPCyG54kRacioV/ZCER
         OAScVNmXQW7hsXbXDhUsZHGvOibmdboZ/nz2xngABk4O5ZdLPs/ivMrBJql+rEHsT24D
         piOxUPf3ysxjycsEaKrpbN++XCo7/zdlGe4l+GI8qh4/k7k7sFCDyGb6M1UMqBpqMyGt
         wg4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:openpgp
         :autocrypt:message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=wo6kvzYCEB9x6sNLpbzEiDdvddMlVBTQkNzc4peqcCQ=;
        b=ntNkfam2EYhk1ZMuI87ixZLr342Jnh213ICwizeTsWw5KFKbnjIzFDSoV+eBq3MTI1
         vCd+jaXA0XzIlKKt8futLOQ6ilf3om0r1bB6knHJUh9oszQBWQ+2DtAC2t6Xz9yXx2nG
         NRdnFKCKYEwiNVU0r0oFFR7Mbr+MdoCpG7Fz+w3QBARoE94gsd2qG3K8Dc+v0tTfRbUM
         8uuK2dWDYtYiF9mvQB9eOOFMGa/v8mN9/E+NG8uhEb3jTK1paVOTHDa6J9ZfAg77M0ya
         FwPoiE4PqYR8pA8XNuMRzShei2vW1o6dLGFxa7QCCrXfVE02GUnYwgLq1hDy3LvzyiEB
         +aEw==
X-Gm-Message-State: AJcUukfBXLZfOZvKg90owJr9Cc4iuP9Elc0Mr/5aQ2mHRUyMJeNzusYP
        6/bWsVAuCgw+ihIOrXDDUEw=
X-Google-Smtp-Source: ALg8bN75whlY2X8B+OnId7dxa6Gwo2IHtNNBq6DMkLET6wv0X8qN6sDjd1i2QO6EG+oSM13RIXDDEg==
X-Received: by 2002:adf:f149:: with SMTP id y9mr56724337wro.284.1546878037106;
        Mon, 07 Jan 2019 08:20:37 -0800 (PST)
Received: from ?IPv6:2001:b07:6468:f312:3473:41cf:8b30:f2e1? ([2001:b07:6468:f312:3473:41cf:8b30:f2e1])
        by smtp.googlemail.com with ESMTPSA id j8sm19509377wmd.0.2019.01.07.08.20.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 07 Jan 2019 08:20:36 -0800 (PST)
Subject: Re: [PATCH 7/11] KVM: Remove redundant check in the
 kvm_get_dirty_log_protect()
To:     Sean Christopherson <sean.j.christopherson@intel.com>,
        lantianyu1986@gmail.com
Cc:     kvm@vger.kernel.org, rkrcmar@redhat.com, catalin.marinas@arm.com,
        will.deacon@arm.com, linux-kernel@vger.kernel.org,
        paulus@ozlabs.org, hpa@zytor.com, kys@microsoft.com,
        kvmarm@lists.cs.columbia.edu, mpe@ellerman.id.au, x86@kernel.org,
        linux@armlinux.org.uk, michael.h.kelley@microsoft.com,
        mingo@redhat.com, benh@kernel.crashing.org, jhogan@kernel.org,
        linux-mips@vger.kernel.org, Lan Tianyu <Tianyu.Lan@microsoft.com>,
        marc.zyngier@arm.com, kvm-ppc@vger.kernel.org, bp@alien8.de,
        tglx@linutronix.de, linux-arm-kernel@lists.infradead.org,
        christoffer.dall@arm.com, ralf@linux-mips.org,
        paul.burton@mips.com, vkuznets@redhat.com,
        linuxppc-dev@lists.ozlabs.org
References: <20190104085405.40356-1-Tianyu.Lan@microsoft.com>
 <20190104085405.40356-8-Tianyu.Lan@microsoft.com>
 <20190104155036.GA11288@linux.intel.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Openpgp: preference=signencrypt
Autocrypt: addr=pbonzini@redhat.com; keydata=
 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
 uUHgL9dKIfvpm+rNXRn9wAwGjk0X/A==
Message-ID: <dad62bfb-e4c0-266f-ff36-8344d3952ba0@redhat.com>
Date:   Mon, 7 Jan 2019 17:20:30 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.1
MIME-Version: 1.0
In-Reply-To: <20190104155036.GA11288@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/01/19 16:50, Sean Christopherson wrote:
> Tangentially related, does mmu_lock actually need to be held while we
> walk dirty_bitmap in kvm_{clear,get}_dirty_log_protect()?  The bitmap
> itself is protected by slots_lock (a lockdep assertion would be nice
> too), e.g. can we grab the lock iff dirty_bitmap[i] != 0?

Yes, we could avoid grabbing it as long as the bitmap is zero.  However,
without kvm->manual_dirty_log_protect, the granularity of
kvm_get_dirty_log_protect() is too coarse so it won't happen in
practice.  Instead, with the new manual clear,
kvm_get_dirty_log_protect() does not take the lock and a well-written
userspace is not going to call the clear ioctl unless some bits are set.

Paolo
