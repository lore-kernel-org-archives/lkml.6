Return-Path: <SRS0=tlbf=RB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C747C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 13:00:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3A2072087C
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 13:00:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iJj1haDe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726923AbfBZNAP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Feb 2019 08:00:15 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:32827 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725954AbfBZNAP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Feb 2019 08:00:15 -0500
Received: by mail-pl1-f195.google.com with SMTP id y10so6242968plp.0;
        Tue, 26 Feb 2019 05:00:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=j8h6kEd36XZA0W1ta6d86WO4PPXq666Fw8Odg1HSHWE=;
        b=iJj1haDeQ/N4knB6ZkfPIbBBikEijc4XMQEhvso+uGw3Gzonlx2LMHbxDNhxdOsLO5
         9/RC7drvjRuaIn9F0S3cLM0+Nf2VDOHoOBcPVpE04JoO4DDFvYHnfNhs3GM3TDepBHHL
         x3uKoOE/K+vdpA+YGX5nfTLL8rGudeiuruGtiPzknZPEsi1M+w74lrRcVnhePEkZKzSm
         hnJ+9/urf6gLp/t3HOljNrg3FSXuSCHaFrniZmdn16YbkBYxmGnUX+M73aEZGT3um4Zl
         RvuLmLpg/dPuOkvCJnfMcBVQMFa+KO/Cdp+mtyFhSiUVeuti7z0gGmnmt7LRbfq0Bfzj
         OJTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=j8h6kEd36XZA0W1ta6d86WO4PPXq666Fw8Odg1HSHWE=;
        b=Y0B8Z9vxtSHyJEzOBxcOwrGpIUKsegBzq6zVqhwfeomkhC77PVaPz/fzhImeXX35vU
         fZ6SZv2p5NSPUzbLaEEVA2mrnTsy57oGTvUKj3cbCilRF7ucehqiCM31mCASC9HpOLXm
         JBlCtz7iZ8amcxYaWq9PKwoD9GBzyNIeR1sx0ZH6SwIqJC6V9Yqh3t1IgXdRfgI/sp/E
         qvgmAHLO2h3GcB/mzBNSX1rEhsoZA7ShRQDLZn0STS4DIo5lPGujo7rCq+TkdswuTeyg
         dUwBFfqntpXh3K+SpmWbUFdxqW99WgEDg9uVJ+UuC4kNBJc2Z4aHHXSrPMpq7beFVoJU
         bUbw==
X-Gm-Message-State: AHQUAubwimAGQzzEhklKuSaqSM7TRxa1+NRK/O8yY5CxtByMoCJvVcxP
        zdnjEzqb9KGEu8v4qb45DNJ2yjADyoVBBTEqvkU=
X-Google-Smtp-Source: AHgI3IaS1g7D372cnowLzJym/B9Y1K14HF4sJbQbbdphhYleutKi1EM8iKYA0AgMOkK+w28JpCc2kA1tVi6yaSNleEo=
X-Received: by 2002:a17:902:8b8b:: with SMTP id ay11mr26134560plb.162.1551186014272;
 Tue, 26 Feb 2019 05:00:14 -0800 (PST)
MIME-Version: 1.0
References: <20190222150637.2337-1-Tianyu.Lan@microsoft.com>
 <20190222150637.2337-2-Tianyu.Lan@microsoft.com> <SN6PR2101MB0912C24CD03D22248C868196CC7F0@SN6PR2101MB0912.namprd21.prod.outlook.com>
In-Reply-To: <SN6PR2101MB0912C24CD03D22248C868196CC7F0@SN6PR2101MB0912.namprd21.prod.outlook.com>
From:   Tianyu Lan <lantianyu1986@gmail.com>
Date:   Tue, 26 Feb 2019 21:00:03 +0800
Message-ID: <CAOLK0pzVwH-1pObn3FjmLorc_pjLu2q0Q_EG4iYm3yb2aXL7PQ@mail.gmail.com>
Subject: Re: [PATCH V3 1/10] X86/Hyper-V: Add parameter offset for hyperv_fill_flush_guest_mapping_list()
To:     Stephen Hemminger <sthemmin@microsoft.com>
Cc:     Tianyu Lan <Tianyu.Lan@microsoft.com>,
        "christoffer.dall@arm.com" <christoffer.dall@arm.com>,
        "marc.zyngier@arm.com" <marc.zyngier@arm.com>,
        "linux@armlinux.org.uk" <linux@armlinux.org.uk>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "will.deacon@arm.com" <will.deacon@arm.com>,
        "jhogan@kernel.org" <jhogan@kernel.org>,
        "ralf@linux-mips.org" <ralf@linux-mips.org>,
        "paul.burton@mips.com" <paul.burton@mips.com>,
        "paulus@ozlabs.org" <paulus@ozlabs.org>,
        "benh@kernel.crashing.org" <benh@kernel.crashing.org>,
        "mpe@ellerman.id.au" <mpe@ellerman.id.au>,
        KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        "sashal@kernel.org" <sashal@kernel.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "bp@alien8.de" <bp@alien8.de>, "hpa@zytor.com" <hpa@zytor.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "pbonzini@redhat.com" <pbonzini@redhat.com>,
        "rkrcmar@redhat.com" <rkrcmar@redhat.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "kvmarm@lists.cs.columbia.edu" <kvmarm@lists.cs.columbia.edu>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mips@vger.kernel.org" <linux-mips@vger.kernel.org>,
        "kvm-ppc@vger.kernel.org" <kvm-ppc@vger.kernel.org>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
        "devel@linuxdriverproject.org" <devel@linuxdriverproject.org>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        Michael Kelley <mikelley@microsoft.com>,
        vkuznets <vkuznets@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Stephen:
               Thanks for your review.
On Sat, Feb 23, 2019 at 1:08 AM Stephen Hemminger
<sthemmin@microsoft.com> wrote:
>
> int hyperv_fill_flush_guest_mapping_list(
>                 struct hv_guest_mapping_flush_list *flush,
> -               u64 start_gfn, u64 pages)
> +               int offset, u64 start_gfn, u64 pages)
>  {
>         u64 cur = start_gfn;
>         u64 additional_pages;
> -       int gpa_n = 0;
> +       int gpa_n = offset;
>
>         do {
>                 /*
>
> Do you mean to support negative offsets here? Maybe unsigned would be better?

Yes, this makes sense. Will update. Thanks.

-- 
Best regards
Tianyu Lan
