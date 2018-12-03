Return-Path: <SRS0=Grn6=OM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0057C04EBF
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 17:57:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 771F420848
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 17:57:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="phpYCNOz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 771F420848
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726896AbeLCR50 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Dec 2018 12:57:26 -0500
Received: from mail-oi1-f195.google.com ([209.85.167.195]:38334 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726526AbeLCR50 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Dec 2018 12:57:26 -0500
Received: by mail-oi1-f195.google.com with SMTP id a77so11722317oii.5
        for <linux-kernel@vger.kernel.org>; Mon, 03 Dec 2018 09:57:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=O7Q8TrTGhYJlvBLbYE9yGzEKWFC/+RaiSYqN7xMYqec=;
        b=phpYCNOzGTzasUfEX43Ks4Wu/kPJhYBCjgFgrSVmJ/yUUo+T0LPBAFhe/fArmq9SbS
         4bk4HjD7zn9rAchyFq9ih78uYJJW8LptiYKaszMKse+kQluSYTVy6Kv9XnCQ619YQOLJ
         vNJuLnR1Pu5a3QHPsIq0msbidwclcCzRB2eKQcIYnkuMxVZaDk5eIT9kMCtHaB93D95y
         5qz3STUPJiVzOb/ybLPKa/YhK62Y6z5u1NSAPnoteo5iwtGFLwAt8LSbcIZvEnkgL2WG
         2RA8plTcY8rn/Yge2EPk/+7Ozl3D/Gm/Q2pt9onNy+uovy6WKmSH8LcwN/GTh3Cu570k
         ZdJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=O7Q8TrTGhYJlvBLbYE9yGzEKWFC/+RaiSYqN7xMYqec=;
        b=gXj196sL5R5H0FLrCHCCCcOaeMR0AKSqALnTJab+8IoMYuDNVC/v40mSgrOZMhTuF4
         8GFAmX/AYbIWP7q0LxhStSR8NQ/BliH/mU5tpe5mWxJeetfAvzkWiP/bWT3AExJzo84z
         wALw2TjX+fn+NirbcAs2Efj62P5EA1qDao971Fjz8l9VUJkAyT0HpaBNy8EIeiAJncQo
         jsh/BggE+bzFp+PhccJAW3XFTG0hEKvWVj7u8QOGufi5AgY54DZK4FKbzrUpTYiHZqn9
         VIONgeJ10SHjgVJEtI29M7ki0ngifV2rwxHF/zdKPNTwAjowTfJNtK9zpqKSL8KXD7YI
         f6cg==
X-Gm-Message-State: AA+aEWZVmhQsIVd3y8eJS5alNfF9lQR5n/GdMqKqk9gLRihvMr9+QMtz
        nKusth1jSwkcX4tUt9j7GMVjQv8FxY8+uoES1fFJUQ==
X-Google-Smtp-Source: AFSGD/VD4t07wGjg73nfT0LgbX7RAnjb5CfzqN8bZnyixKjkm2DvNmzsMlVF6hwfmInBfOvgevmoNxzpxxXLXNWa7Ko=
X-Received: by 2002:aca:d78b:: with SMTP id o133mr4800593oig.232.1543859841244;
 Mon, 03 Dec 2018 09:57:21 -0800 (PST)
MIME-Version: 1.0
References: <154362450646.2367148.16448130381211111341.stgit@dwillia2-desk3.amr.corp.intel.com>
 <154362452184.2367148.10656843315134995636.stgit@dwillia2-desk3.amr.corp.intel.com>
 <4bc8cab6-4e1a-c3b9-0023-3ecde932cc70@intel.com>
In-Reply-To: <4bc8cab6-4e1a-c3b9-0023-3ecde932cc70@intel.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Mon, 3 Dec 2018 09:57:09 -0800
Message-ID: <CAPcyv4gLA_UryDZzdtAi-T=2x8io4V_2BwX_qTF7KS8Ff1Kb3A@mail.gmail.com>
Subject: Re: [PATCH v2 3/5] generic/pgtable: Introduce set_pte_safe()
To:     Dave Hansen <dave.hansen@intel.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Borislav Petkov <bp@alien8.de>, X86 ML <x86@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 3, 2018 at 9:53 AM Dave Hansen <dave.hansen@intel.com> wrote:
>
> On 11/30/18 4:35 PM, Dan Williams wrote:
> > +/*
> > + * The _safe versions of set_{pte,pmd,pud,p4d,pgd} validate that the
> > + * entry was not populated previously. I.e. for cases where a flush-tlb
> > + * is elided, double-check that there is no stale mapping to shoot down.
> > + */
>
> Functionally these look great to me.
>
> The only thing I'd suggest is to make the comment more about when to use
> these, instead of what they do:
>
>         Use the set_p*_safe() version when confident that *no*
>         TLB flush will be required as a result of the "set", such
>         as setting non-present entries or when possibly superfluously
>         re-setting an entry.

The second sentence was meant to be a "why", but yes, it's entirely too subtle.
