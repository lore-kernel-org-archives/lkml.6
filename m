Return-Path: <SRS0=uOC5=M5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 804B0ECDE32
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 17:08:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 47B1E21476
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 17:08:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="iY5Szprq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 47B1E21476
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727837AbeJRBFa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Oct 2018 21:05:30 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:33708 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727332AbeJRBF3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Oct 2018 21:05:29 -0400
Received: by mail-ot1-f65.google.com with SMTP id q50so26970448otd.0
        for <linux-kernel@vger.kernel.org>; Wed, 17 Oct 2018 10:08:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=Y/xr2rqqnO4M3YntWem4HxiuPTbdciA7bGfMU/F7Dy4=;
        b=iY5Szprq2KvTmBERmlxfHZWQJ5/PM3zXEiNBifrBR4KJo52vkULdEFO+wIk/SlIbFQ
         FScSN6brL46IIFp1DMMmvnN2vC0Ne+i+bPy8JUR6uaPfyHgMAOsPnxtm5pob/mhit8YH
         Sdfb8INU+FnpQ8DBFYq1ccSSvtMzYWkWVoT3n7tR6bx+VOdR5DsQbXMq+IW0qCvkhPHK
         CE5EWTuIn6kSlDrNayzhOggSwUez55UuH7CxCDxs1JorzetFuhGpVn54s3DV3FJwLKF4
         +Tx7lYuWMoD0MX3B6QfGc7UbkZmMO9ysOcfcA36C9vbdzPPFDT6PSr0ZTyMQd9sDA4LE
         WPRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=Y/xr2rqqnO4M3YntWem4HxiuPTbdciA7bGfMU/F7Dy4=;
        b=Bn4i/trlkSR0QUirgypSye4gP7+W3yJDFuAmlDgv+4XXDxqQ0TuxZNKej+P9ACmCo1
         uVWeOmsZ0xuBu03SE1pE5zhbgcpD5vIj4Gs72ft1ByNYRvkBuck1B0NeiiOXFCED2uZ+
         UqnFANRW5asEPDg9l90wuIwp9MUvlnbxL8vxGelCJ1Hsc6jfqb55f1qcyDcjRoADXeWV
         hg6t1Is6+lLa5EAi+3c7CgsslKc2EzFJ34cusIQQ1ByZ6UGnpMsP1Kxb5LWbfpym3XBu
         b4RyGO5+2oXYGKnugaOAGiHiTgWjV9WHLaz4nmKxbAdjHg3cQGHjv/DDES6I7w35mjAX
         8XEA==
X-Gm-Message-State: ABuFfohXJeg0D3iiGmdlMeZ193kKKCG6Uo55UT+eeMDsDUPmGBvRIkTH
        jPTsc38jSuixthWIC72JfCK8b9srfDSfPw7BNqckig==
X-Google-Smtp-Source: ACcGV60jw5aNarwg6KdKhs+bn5yJOFj2QMIJ1MuUh77YqPhy8pbngXgPwvb8X5E2qM5r7gx/rUXy88z0g4XBgAZDC4M=
X-Received: by 2002:a9d:4d0c:: with SMTP id n12mr17909059otf.90.1539796131829;
 Wed, 17 Oct 2018 10:08:51 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ac9:2aca:0:0:0:0:0 with HTTP; Wed, 17 Oct 2018 10:08:51
 -0700 (PDT)
In-Reply-To: <0ff3acb0-1d20-cbb0-5f40-887d9db93d9e@redhat.com>
References: <20181016165011.6607-1-vkuznets@redhat.com> <20181016165011.6607-7-vkuznets@redhat.com>
 <2064be05-4286-e3d5-cd22-13fd957b7003@redhat.com> <8736t4sk8w.fsf@vitty.brq.redhat.com>
 <0ff3acb0-1d20-cbb0-5f40-887d9db93d9e@redhat.com>
From:   Jim Mattson <jmattson@google.com>
Date:   Wed, 17 Oct 2018 10:08:51 -0700
Message-ID: <CALMp9eTtSuguXb=gCWKL9ZKWy5kUve0SNY1Toduf8x2Qn=1s9Q@mail.gmail.com>
Subject: Re: [PATCH v6 06/13] KVM: nVMX: optimize prepare_vmcs02{,_full} for
 Enlightened VMCS case
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     Vitaly Kuznetsov <vkuznets@redhat.com>,
        =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        Roman Kagan <rkagan@virtuozzo.com>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        "Michael Kelley (EOSG)" <Michael.H.Kelley@microsoft.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Liran Alon <liran.alon@oracle.com>,
        kvm list <kvm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I believe that ESXi reads GUEST_CS_AR_BYTES on every VM-exit to
determine code size.

On Wed, Oct 17, 2018 at 10:02 AM, Paolo Bonzini <pbonzini@redhat.com> wrote:
> On 17/10/2018 16:47, Vitaly Kuznetsov wrote:
>>>> +   if (!hv_evmcs || !(hv_evmcs->hv_clean_fields &
>>>> +                      HV_VMX_ENLIGHTENED_CLEAN_FIELD_GUEST_GRP2)) {
>>>> +           vmcs_write16(GUEST_CS_SELECTOR, vmcs12->guest_cs_selector);
>>>> +           vmcs_write32(GUEST_CS_LIMIT, vmcs12->guest_cs_limit);
>>>> +           vmcs_write32(GUEST_CS_AR_BYTES, vmcs12->guest_cs_ar_bytes);
>>>> +           vmcs_writel(GUEST_ES_BASE, vmcs12->guest_es_base);
>>>> +           vmcs_writel(GUEST_CS_BASE, vmcs12->guest_cs_base);
>>>> +   }
>>> For what it's worth, I suspect that these can be moved to
>>> prepare_vmcs02_full.  The initial implementation of shadow VMCS did not
>>> expose "unrestricted guest" to the L1 hypervisor, and emulation does a
>>> lot of accesses to CS (of course).  Not sure how ES base ended up in
>>> there and not DS base, though...
>> I tried unshadowing all these fields and at least Hyper-V on KVM
>> (without using eVMCS of course) experiences a 1200-1300 cpu cycles
>> regression during tight cpuid loop test. I checked and this happens
>> because it likes vmreading GUEST_CS_AR_BYTES a lot.
>
> Go figure. :)  Liran, do you happen to know if ESX does something
> similar with CS descriptor cache fields?
>
> Paolo
