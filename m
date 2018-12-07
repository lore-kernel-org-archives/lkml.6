Return-Path: <SRS0=szhz=OQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87E8BC07E85
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 15:14:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 404A120882
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 15:14:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Qd867Bi/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 404A120882
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726145AbeLGPOZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Dec 2018 10:14:25 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:45516 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726034AbeLGPOY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Dec 2018 10:14:24 -0500
Received: by mail-wr1-f66.google.com with SMTP id b14so4108538wru.12;
        Fri, 07 Dec 2018 07:14:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:openpgp:autocrypt:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=jvsrK9fuBp4EhpNaGA578d9Coc6TFRRDbrRIiXY/DVA=;
        b=Qd867Bi/1nPhGnr1MNjjsFR1tHlv/BY4nOR0IssMGZRf8FdWeveL1sHFGh5PSSZ/Vs
         0T77GvlayNf77ZBnCcKcj+K8HqxoFRKmcPFq2ZZ3h0kCQsIklDymA7OIT1f4wLGxZbFn
         HxgaEAVHFRlaz6gCks/SHYxEWBoRXLuEJb9gM7A95o4r5vnzDkHQzzLIN3mQd7ph4aIR
         efurRR803sPkhRkK4qQRAFoyKY3WugA3P/RRyNfGHSohQC6VlvLRjRPC/1BCSe9qY7gy
         qCvBNL+XqRMwITbGDN8RDns5JBOgQOJXRl8HejzfpXAvvFj3h8W0vzP45a9PS9bAlVYq
         caag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:openpgp
         :autocrypt:message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=jvsrK9fuBp4EhpNaGA578d9Coc6TFRRDbrRIiXY/DVA=;
        b=NDraiwo5FWZG30td9hL/m8f8wI1N6IN1igbkQi9XzUrQj4K3L5vQB5zG2iPbyRqYWn
         Xj9bD5HkhRUIdXGQbHsdLeYqAgCHTaTxnPted0Q8pbWoVtJeXc7bAjQoEfvcQYWmkORc
         LvRIZ0WISHK5TdWsLNj2osZOvR+6NbwotOZPhQe/K4oAQzqNckqR/lEwcgOL56aJAwqB
         QCc5J3nwhIwazo9vSyOMG7abhNj5dYOlPXf7/q2kVhPuUJQeXbca+w0UcPWr8w/zB5En
         QB3M6M7hcyw2fM+L0Ow2hPzBg8YodhrLQc/l9ZeAZv6UG5EiXKhFRDg5uDTX5yuukFqg
         tE3Q==
X-Gm-Message-State: AA+aEWZBq/Vbpg11h//diW5VODGSZaZPkT9pVnvv6XJFi+gZxbtxBIcg
        z3lrxvDFVuny8KzzM4Ii2b8=
X-Google-Smtp-Source: AFSGD/Ujp1DVLl9AztZLYimqulXDk5nS/EgxxOux89pTzI1Dwt1QmGEU3BgnMvBLsD5jEwqJwewejQ==
X-Received: by 2002:a05:6000:110f:: with SMTP id z15mr2055424wrw.136.1544195661953;
        Fri, 07 Dec 2018 07:14:21 -0800 (PST)
Received: from [192.168.43.81] ([31.157.62.197])
        by smtp.googlemail.com with ESMTPSA id q14sm3628751wrw.39.2018.12.07.07.14.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 07 Dec 2018 07:14:20 -0800 (PST)
Subject: Re: [PATCH v8 1/7] xen/pvh: Split CONFIG_XEN_PVH into CONFIG_PVH and
 CONFIG_XEN_PVH
To:     Juergen Gross <jgross@suse.com>,
        Maran Wilson <maran.wilson@oracle.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org, xen-devel@lists.xenproject.org,
        kvm@vger.kernel.org
Cc:     tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com,
        boris.ostrovsky@oracle.com, jpoimboe@redhat.com,
        kirill.shutemov@linux.intel.com, bp@suse.de,
        thomas.lendacky@amd.com, luto@kernel.org,
        dave.hansen@linux.intel.com, roger.pau@citrix.com,
        rkrcmar@redhat.com, rdunlap@infradead.org
References: <1544076152-21637-1-git-send-email-maran.wilson@oracle.com>
 <1544076257-21792-1-git-send-email-maran.wilson@oracle.com>
 <d532f023-85f9-62b9-ca56-53a619fdcd1e@redhat.com>
 <2c289956-0e6a-700c-605d-83685fbb08f9@suse.com>
 <0a2f692a-f7df-8ad1-9d34-96f5e36926db@redhat.com>
 <3f95d053-87aa-ad45-03e6-1e1977283eb4@suse.com>
 <d0fd8799-35ea-fba5-9d0d-94feead85943@redhat.com>
 <5d1d0071-1db4-ea03-027f-2a12812b78d0@suse.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Openpgp: preference=signencrypt
Autocrypt: addr=pbonzini@redhat.com; keydata=
 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
Message-ID: <d18b961a-d115-8d12-8ee4-eb1a3466959c@redhat.com>
Date:   Fri, 7 Dec 2018 16:14:15 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.1
MIME-Version: 1.0
In-Reply-To: <5d1d0071-1db4-ea03-027f-2a12812b78d0@suse.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/12/18 14:58, Juergen Gross wrote:
> On 07/12/2018 14:52, Paolo Bonzini wrote:
>> On 07/12/18 14:50, Juergen Gross wrote:
>>> The PVH boot entry is in the same bzImage binary as the normal one.
>>> Its just another entry, similar to the Xen PV boot entry. So the binary
>>> arch/x86/boot/bzimage can be booted either on bare metal via grub2 or
>>> other boot-loaders, as Xen PV-guest, as Xen PVH-guest, or as KVM
>>> PVH-guest. So one build and one binary. The non-standard boot entries
>>> (PV- or PVH-node) are found via ELF-notes by the boot loader (qemu in
>>> case of KVM).
>>
>> But the bzImage is not an ELF binary, and it is compressed, isn't it?
>> /me is confused. :)
> 
> grub2 (and qemu, too) can decompress it. And the decompressed result
> "vmlinux" is an ELF-binary.

Aha - for KVM, the main advantage of PVH would be to skip the cost of
decompression, and that is what confused me (also we probably prefer not
having any decompression code running in QEMU, since that increases the
attack surface; there's no real disadvantage to using the existing
linuxboot code if we're given a bzImage).  So, at least for now, KVM
would go with the two-binaries/one-config approach.

Sorry for having you lecture me, it's much clearer now.  Thanks,

Paolo
