Return-Path: <SRS0=3XDn=JT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C06FC6778A
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 15:16:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DCEB6208E4
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 15:16:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gI5shgUG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DCEB6208E4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934197AbeGCPQM (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Jul 2018 11:16:12 -0400
Received: from mail-lf0-f67.google.com ([209.85.215.67]:43130 "EHLO
        mail-lf0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934187AbeGCPQE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jul 2018 11:16:04 -0400
Received: by mail-lf0-f67.google.com with SMTP id m12-v6so1911991lfc.10
        for <linux-kernel@vger.kernel.org>; Tue, 03 Jul 2018 08:16:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=7seU26ovXIUTf1IqV0pm0qSm4HDudN5bpqVnFDc/gbI=;
        b=gI5shgUGHXXQdT2wZ+FQ0EECb/hJATlOI0lvrEau92kloMEF1Y6MtM4b6UURfAj77D
         nY/tTXKKDoa2kFfU1ryxej3sxpsARZ3HYUrbutHdbQ/l5P6c5BhY7b4eHeafspmLgwO/
         /CPfmNs86x3xneiDysMYnRR+eTj5QzyNtlf4vb2pfy+fxlsqjnIyTmkWLI1/+tIrMtwq
         DuzWoJhpVbVBZ1nfGqYUmkYX00UGuW8SvHFmLAZUE0qOeRjzASOZezd3nddtFBVxqEkH
         VhRWxvzk0YmSxniH1qhgO9V82Z5oUg+WJOYIdDGVaAmvoNx3nClGCGrcmjc7DY6FQLXQ
         sE5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=7seU26ovXIUTf1IqV0pm0qSm4HDudN5bpqVnFDc/gbI=;
        b=fJMJzIkkt2whPtjv1sBM9SrTaIpIWEHreuBNKgx2jw9csH98cqkOnXMCiL01QinUGv
         leP8Ybjo4bmus9Fcv5jwEXIwFTeM98VBRivdYMFugd1MH8pzPk56JBVb2pcXhbM9AZbm
         yg9qJXl+cRSc4XbUj4sNJ6ejVver/4H7d8Qr2FAS2lxFCJ8mpfOvdc123TlMbTIR+j1J
         keVvXoOegN2F+TFre0E0P/Z1Ar1VSDldvCXNsy3PPGF/QzAIvfoBmR+3D0yodkvFe+fZ
         JxsOGTyV/l0ZPxQtropurdQ25CcpQBOIctQVcWk0htcsGklkYle6IVhhDkRcoCwEQeOK
         0FTQ==
X-Gm-Message-State: APt69E3+Edm0E5m6fXiVUlkaZT2y6gN3FWFJ1w5oPMSR2olJ8qwZ9XV9
        /FQqP5PhgLzz4SHLX/S308sIPKft+cT0Xa71qn4=
X-Google-Smtp-Source: AAOMgpdbY+KwerOKJopLaefOcFrpa8B4QkcTs8Z+vdODcSCKujzvKXfitxcckBeaY/lOUh8EnnxsXdDv1QeRLPwRXDk=
X-Received: by 2002:a19:9cca:: with SMTP id f193-v6mr2374059lfe.60.1530630963176;
 Tue, 03 Jul 2018 08:16:03 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a19:2b14:0:0:0:0:0 with HTTP; Tue, 3 Jul 2018 08:16:02 -0700 (PDT)
In-Reply-To: <20180703121122.GB3544@bombadil.infradead.org>
References: <20180625175737.GA20042@jordon-HP-15-Notebook-PC>
 <20180703111735.GA3544@bombadil.infradead.org> <CAFqt6zaiFuHZKwp+Ou67hLX=JiqTzZ9v3hjaHj3+BYQi+-=Ebg@mail.gmail.com>
 <20180703121122.GB3544@bombadil.infradead.org>
From:   Souptick Joarder <jrdr.linux@gmail.com>
Date:   Tue, 3 Jul 2018 20:46:02 +0530
Message-ID: <CAFqt6zZ+dp9gvF3kx2OO6kv_GH0Nrm2e31Om_c9y78Mu+Krzfw@mail.gmail.com>
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

On Tue, Jul 3, 2018 at 5:41 PM, Matthew Wilcox <willy@infradead.org> wrote:
> On Tue, Jul 03, 2018 at 05:18:30PM +0530, Souptick Joarder wrote:
>> On Tue, Jul 3, 2018 at 4:47 PM, Matthew Wilcox <willy@infradead.org> wrote:
>> > On Mon, Jun 25, 2018 at 11:27:37PM +0530, Souptick Joarder wrote:
>> >> Use new return type vm_fault_t for both fault handler
>> >> vdso_fault() and vvar_fault(). Previously vm_insert_pfn()
>> >> returns err which has to mapped into VM_FAULT_* type.
>> >> The new function vmf_insert_pfn() will replace this
>> >> inefficiency by returning correct VM_FAULT_* type.
>> >
>> >> @@ -105,10 +105,10 @@ static int vvar_fault(const struct vm_special_mapping *sm,
>> >>        * the page past the end of the vvar mapping.
>> >>        */
>> >>       if (sym_offset == 0)
>> >> -             return VM_FAULT_SIGBUS;
>> >> +             return ret;
>> >>
>> >>       if (sym_offset == image->sym_vvar_page) {
>> >> -             ret = vm_insert_pfn(vma, vmf->address,
>> >> +             ret = vmf_insert_pfn(vma, vmf->address,
>> >>                                   __pa_symbol(&__vvar_page) >> PAGE_SHIFT);
>> >>       } else if (sym_offset == image->sym_pvclock_page) {
>> >>               struct pvclock_vsyscall_time_info *pvti =
>> >> @@ -124,14 +124,11 @@ static int vvar_fault(const struct vm_special_mapping *sm,
>> >
>> > Haven't you missed converting vm_insert_pfn_prot() at line 117?
>> > Did you test-compile this?
>> >
>>
>> I left it intentionally in this patch. When we will be replacing
>> vm_insert_foo() with new API vmf_insert_foo(), vm_insert_pfn_prot
>> need to be changed to return vm_fault_t type.
>>
>> I will change the return type of vm_insert_pfn_prot() in that patch.
>
> What?!  That's just broken.  vm_insert_pfn_prot returns an errno, so
> this patch introduces a bug where sometimes 'ret' contains a vm_fault_t
> and sometimes contains an errno.  That's exactly the kind of thing this
> patch series is supposed to be *preventing*, not introducing!
>

It was my wrong understanding which create this issue. Sorry about it.
I though to change the return type of vm_insert_pfn_prot() to vm_fault_t
type directly along with the caller of vm_insert_pfn_prot(), but in a separate
patch.

But introducing vmf_insert_pfn_prot() is much simpler approach here.

Sorry for making things complex.
