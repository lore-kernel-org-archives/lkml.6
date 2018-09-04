Return-Path: <SRS0=7C3F=LS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 289E5C433F5
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 18:01:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DA7732082B
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 18:01:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DO/M2nXG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DA7732082B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727844AbeIDW1i (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Sep 2018 18:27:38 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:41087 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726304AbeIDW1i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Sep 2018 18:27:38 -0400
Received: by mail-qk1-f193.google.com with SMTP id h138-v6so3034384qke.8;
        Tue, 04 Sep 2018 11:01:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9IOhWTi7JFHbldu1zWeCwqC+ZGa8HoB2dYRwFq6ob+Q=;
        b=DO/M2nXG6419KGN3It/WTOIvhY+uJubq2xxrFMrkN9Dsh3D+XDy5JoXl8s3VTMR8nr
         Hs9cmaCqm1VrqVOa+59TlZvryv9c3VGZq7aJ6Qo7juiXDWi4y6orbyy4KOFyFzRaWhvX
         BZvNoZM0qrrlYgYnMnAu9ovqlLXrwg2necfX/ISxwKB0GoStqMJmVZ8pkPemzwdklkKK
         QhXV3ZlFyrUcNxW3oo+V7go9LXEReonig+ZS6ve1CUqxueDWw4O5gUlxvgAVJnTTaJgP
         G3BUVBpay2w9oG4Rxcuwu/lnjyN7UNpG7pfGu1TaOYWD6drEJMz75Ssx4vRmR5gv1YX0
         ACTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9IOhWTi7JFHbldu1zWeCwqC+ZGa8HoB2dYRwFq6ob+Q=;
        b=pkq2RT3VxOc058/dDsQFGWn9oZuSZPt4CoNqepVTWE/fxQoI9wb3CH5S2XkfSUkK20
         +FrW/DB1EhfxMJqK0wzUq07ryPsrGVngzIH1anU+ScBT8RFWjcCTWqj2zDtDfVn7Lx/b
         FYi9J0+dVgBRUXI1nmNQOhqP0BnjIj9X/s1nXmHoJgZeelVs0GxlzlOmPYUMK8cKqIuj
         VG0OW767qid1ak2MEJOgOK+QV4ieRHRBM2IyrQyrV/rUddd5EJKa3VlESFZuXkr8YkIF
         IZgr4Z+S7Rhl4eKSjlpL/YuXU8juBcr8tyoHiyWy18z3WLgcC4HCx+3e9JNJhQKe7MZ2
         I4VQ==
X-Gm-Message-State: APzg51AxijkMsoJmzWCn5BaiXjXmCRo34zmiIP0QyvC637Zp5+aPB6Vv
        yzxnQKtEx57I02b//KaTjXOJYyqJkHLvg8tx51U=
X-Google-Smtp-Source: ANB0VdbMPFe3GnoeHeI8LXy2dAxr8FkUUfm+m01qlfTIiovIG8CT/OX7cL9SPPvmbyCoNk5lcFpMDgTjiIyT/kGWKg8=
X-Received: by 2002:a37:17aa:: with SMTP id 42-v6mr29624978qkx.64.1536084086326;
 Tue, 04 Sep 2018 11:01:26 -0700 (PDT)
MIME-Version: 1.0
References: <20180827185507.17087-1-jarkko.sakkinen@linux.intel.com>
 <20180827185507.17087-8-jarkko.sakkinen@linux.intel.com> <CAHp75VcjKkJR4_H-acbVm3BwA4tVR8gUtkg9STqOK2UG20Tvgg@mail.gmail.com>
 <20180904174914.GA5690@linux.intel.com>
In-Reply-To: <20180904174914.GA5690@linux.intel.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Tue, 4 Sep 2018 21:01:15 +0300
Message-ID: <CAHp75VeC0n82thqKKywfiTwd7_fngrc5Zf_1dMzmNdjgafgMvA@mail.gmail.com>
Subject: Re: [PATCH v13 07/13] x86/sgx: Add data structures for tracking the
 EPC pages
To:     sean.j.christopherson@intel.com
Cc:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        Dave Hansen <dave.hansen@intel.com>, nhorman@redhat.com,
        npmccallum@redhat.com, linux-sgx@vger.kernel.org,
        serge.ayoun@intel.com, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, suresh.b.siddha@intel.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 4, 2018 a> +/**

> > > +       va = ioremap_cache(addr, size);
> > > +       if (!va)
> > > +               return -ENOMEM;
> >
> > I'm not sure this is a right API. Do we operate with memory? Does it
> > have I/O side effects?
> > If no, memremap() would be better to use.
>
> Preserving __iomem is desirable.  There aren't side effects per se,
> but direct non-enclave accesses to the EPC get abort page semantics so
> the kernel shouldn't be directly dereferencing a pointer to the EPC.
> Though by that argument, sgx_epc_bank.va, sgx_epc_addr's return and
> all ENCLS helpers should be tagged __iomem.

Why?
Does it related to *any* I/O?

-- 
With Best Regards,
Andy Shevchenko
