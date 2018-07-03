Return-Path: <SRS0=3XDn=JT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E464C6778A
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 11:48:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 17D4E208A5
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 11:48:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="utxfdLs9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 17D4E208A5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752730AbeGCLsd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Jul 2018 07:48:33 -0400
Received: from mail-lf0-f66.google.com ([209.85.215.66]:35981 "EHLO
        mail-lf0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752067AbeGCLsc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jul 2018 07:48:32 -0400
Received: by mail-lf0-f66.google.com with SMTP id n24-v6so1361242lfh.3
        for <linux-kernel@vger.kernel.org>; Tue, 03 Jul 2018 04:48:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=9WsRTVkTTGUDGgQJHJowwDPzAwvaFRxNgihFnGMkmnA=;
        b=utxfdLs9bErT1zw9FIZ4SPMC8elrVgu8W9CObwzqJboNcu199cMwPnlr+5ZZoaCD2d
         AR6Id65XqNRQoY2ROA423tjBMKEjWosyzzU597NYSvKnTjGzZ4Yy4D/vhwIWT9DxK/U4
         nq4Fj8qAVqERZmYnu6JI3imYtmwIKnE6Ifi2nLYDCcDw4ChhZ9gi5kA45Wg+9pVD4Vs5
         LQkyyPvA0zz92wX2Mvwf2NjF4jvUGjc0s0iMwX607DYjJUX6/UMoJCdA3PaQLatW9RoF
         NyFTFJ9OvyzQnUxHuj21+Kxm8wbcOyZSOCN/syWfIOJylkeedsXBHfaInEaX9i/jV4Ms
         GfPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=9WsRTVkTTGUDGgQJHJowwDPzAwvaFRxNgihFnGMkmnA=;
        b=c284r2r/vIto3WdChy0Vh/af3hkYJt5Bcf/n1qJA+ty78X2eLSYWkMselMCQhy497a
         f/cl+iAUWj6LSCOhu5y0z2OOH31UnLXT8gYGLiYaKs6PLGiyBeDPwtaxXeAuQzQyH4lK
         c74xHRXsjDhuHnA8FqI3OoyiYA4P4hKc1P2lLX6PTRig7JYqfZ8oQ0YjnQ5SUVuecmLe
         9e0e8mt6iOYWhQsDtth1/MFvqQnG3b/jNA3C7ov7HlP9tD+d4MjyyFmYNrooYfQmZixR
         QZ2GlFglT2nZ1MHONDfwnwP3Fiv6wVEQ6ash7tIg56/5cGvfB81qeMylgVyV8Wa0s6CM
         ekVQ==
X-Gm-Message-State: APt69E1VBEdKzZE0C4RtWVg2KRYq0jUo0f3BV8NFFpuibj4fbLyAdVP0
        uxO4goMxq7QoKgVyypIuTrTeZ9cOKvgUN6HUTk0=
X-Google-Smtp-Source: AAOMgpfswTtvb7vqlB7PjclGobHHjJn0ruaisbBsPxIkaCW7i5lDjbm10B1AeBXoX2v0IZeCfViOxIX0toczyluZqVE=
X-Received: by 2002:a19:c742:: with SMTP id x63-v6mr18682034lff.9.1530618511155;
 Tue, 03 Jul 2018 04:48:31 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a19:2b14:0:0:0:0:0 with HTTP; Tue, 3 Jul 2018 04:48:30 -0700 (PDT)
In-Reply-To: <20180703111735.GA3544@bombadil.infradead.org>
References: <20180625175737.GA20042@jordon-HP-15-Notebook-PC> <20180703111735.GA3544@bombadil.infradead.org>
From:   Souptick Joarder <jrdr.linux@gmail.com>
Date:   Tue, 3 Jul 2018 17:18:30 +0530
Message-ID: <CAFqt6zaiFuHZKwp+Ou67hLX=JiqTzZ9v3hjaHj3+BYQi+-=Ebg@mail.gmail.com>
Subject: Re: [PATCH v2] x86/vdso: Change return type to vm_fault_t for fault handlers
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Andy Lutomirski <luto@amacapital.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, X86 ML <x86@kernel.org>,
        linux-kernel@vger.kernel.org, brajeswar.linux@gmail.com,
        Sabyasachi Gupta <sabyasachi.linux@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 3, 2018 at 4:47 PM, Matthew Wilcox <willy@infradead.org> wrote:
> On Mon, Jun 25, 2018 at 11:27:37PM +0530, Souptick Joarder wrote:
>> Use new return type vm_fault_t for both fault handler
>> vdso_fault() and vvar_fault(). Previously vm_insert_pfn()
>> returns err which has to mapped into VM_FAULT_* type.
>> The new function vmf_insert_pfn() will replace this
>> inefficiency by returning correct VM_FAULT_* type.
>
>> @@ -105,10 +105,10 @@ static int vvar_fault(const struct vm_special_mapping *sm,
>>        * the page past the end of the vvar mapping.
>>        */
>>       if (sym_offset == 0)
>> -             return VM_FAULT_SIGBUS;
>> +             return ret;
>>
>>       if (sym_offset == image->sym_vvar_page) {
>> -             ret = vm_insert_pfn(vma, vmf->address,
>> +             ret = vmf_insert_pfn(vma, vmf->address,
>>                                   __pa_symbol(&__vvar_page) >> PAGE_SHIFT);
>>       } else if (sym_offset == image->sym_pvclock_page) {
>>               struct pvclock_vsyscall_time_info *pvti =
>> @@ -124,14 +124,11 @@ static int vvar_fault(const struct vm_special_mapping *sm,
>
> Haven't you missed converting vm_insert_pfn_prot() at line 117?
> Did you test-compile this?
>

I left it intentionally in this patch. When we will be replacing
vm_insert_foo() with new API vmf_insert_foo(), vm_insert_pfn_prot
need to be changed to return vm_fault_t type.

I will change the return type of vm_insert_pfn_prot() in that patch.
