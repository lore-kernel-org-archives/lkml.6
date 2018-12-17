Return-Path: <SRS0=+VtO=O2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04859C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 19:35:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C5B72206A2
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 19:35:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="eGZ3PG4X"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388321AbeLQTfu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Dec 2018 14:35:50 -0500
Received: from mail-it1-f196.google.com ([209.85.166.196]:50443 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727641AbeLQTfu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Dec 2018 14:35:50 -0500
Received: by mail-it1-f196.google.com with SMTP id z7so659176iti.0
        for <linux-kernel@vger.kernel.org>; Mon, 17 Dec 2018 11:35:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=cg/drGNrJvWSVvhwSllUP1bylbyWPMkVlihtmXoDqKE=;
        b=eGZ3PG4XF/xoPxCtYsXDY+LFzEyLNh854EoG3J5j/7o+oPzU8hywE1h0ZpA7jF2tCw
         qrn6Z1Lrk+Frhg1JbKkjGyAgGWBR8vcITYaCQfT5vcs2O9RbIPIaO3Fj+pl1xBnoDPWS
         +50UoS2TX9sOL/CQ6G3/GfFOG5/oWUK6zE4is=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cg/drGNrJvWSVvhwSllUP1bylbyWPMkVlihtmXoDqKE=;
        b=UNecDdbKtdrEaS7x9rzxB2H062e0xYluwk6FF9BllytrUSH4Nj4K0giCx331rpeio1
         qFX5gvWzWo+9hQ4fAKBYDnwO/0zuy3eRwgHL/RacnPpV8XcY8jBytaW1bp9r+fGk/h26
         up2dLfDaMLwE3dlPk3HYJvImGR5796WzFzPZSf4GJZfjgZH5vXrE99mguv5d5YqhEeoc
         Vb06Ff1S6MVD2aQumOAXha0SXh1QElDwInjlC9m1Da+NksnHPaBRZbPKz83MFtSLDJl6
         iJBI5CSjp5qRt+TDxyF1yHxVgRGvsQRdBrc26Ki3kRDYEWS0mxILM1ph7tq7N0lYQnvs
         n/Ng==
X-Gm-Message-State: AA+aEWbcsSXyZK4g1H2V7J//5agq/0emWK4/43BoyQwueCGxQY52k5M0
        WuX65TSjzlhWwPhxZEX/eEMdd3y/8JAbVGtb9LYkYHyAr5I=
X-Google-Smtp-Source: AFSGD/W5EURoufWwTo9bL+iORBnfR9NCtNvOYNvLovxu97To30MklDU5Qzx95PYx15ZBf1hXItxx8rtGklJ3YPQLw9s=
X-Received: by 2002:a24:edc4:: with SMTP id r187mr437561ith.158.1545075348901;
 Mon, 17 Dec 2018 11:35:48 -0800 (PST)
MIME-Version: 1.0
References: <20181129171230.18699-6-ard.biesheuvel@linaro.org>
 <tip-08cfb38f3ef49cfd1bba11a00401451606477d80@git.kernel.org>
 <FFF73D592F13FD46B8700F0A279B802F48604575@ORSMSX114.amr.corp.intel.com>
 <CAKv+Gu_vTHFxpKRu_CxKP-GdNdgdFKr7fi87VkNur0sqGQNVDw@mail.gmail.com> <FFF73D592F13FD46B8700F0A279B802F486045CA@ORSMSX114.amr.corp.intel.com>
In-Reply-To: <FFF73D592F13FD46B8700F0A279B802F486045CA@ORSMSX114.amr.corp.intel.com>
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date:   Mon, 17 Dec 2018 20:35:37 +0100
Message-ID: <CAKv+Gu9iJinkP-buhmzRyB91_HcJ-tDwT3YHeHGFo4Bsiv7O_Q@mail.gmail.com>
Subject: Re: [tip:efi/core] x86/efi: Unmap EFI boot services code/data regions
 from efi_pgd
To:     "Prakhya, Sai Praneeth" <sai.praneeth.prakhya@intel.com>
Cc:     Ingo Molnar <mingo@kernel.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "x86@kernel.org" <x86@kernel.org>, "bp@alien8.de" <bp@alien8.de>,
        "marc.zyngier@arm.com" <marc.zyngier@arm.com>,
        "eric.snowberg@oracle.com" <eric.snowberg@oracle.com>,
        "hdegoede@redhat.com" <hdegoede@redhat.com>,
        "Hansen, Dave" <dave.hansen@intel.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "arend.vanspriel@broadcom.com" <arend.vanspriel@broadcom.com>,
        "julien.thierry@arm.com" <julien.thierry@arm.com>,
        "bhsharma@redhat.com" <bhsharma@redhat.com>,
        "jonathanh@nvidia.com" <jonathanh@nvidia.com>,
        "joe@perches.com" <joe@perches.com>,
        "matt@codeblueprint.co.uk" <matt@codeblueprint.co.uk>,
        "torvalds@linux-foundation.org" <torvalds@linux-foundation.org>,
        "natechancellor@gmail.com" <natechancellor@gmail.com>,
        "luto@kernel.org" <luto@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "sedat.dilek@gmail.com" <sedat.dilek@gmail.com>,
        "zhuyifei1999@gmail.com" <zhuyifei1999@gmail.com>,
        "linux-tip-commits@vger.kernel.org" 
        <linux-tip-commits@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 17 Dec 2018 at 19:42, Prakhya, Sai Praneeth
<sai.praneeth.prakhya@intel.com> wrote:
>
> > > Hi Thomas and Ingo,
> > >
> > > I recently noticed that the below commits [1] and [2] are broken when
> > > kernel command line argument "efi=old_map" is passed. Sorry! I missed
> > > to test this condition prior to sending these patches to mailing list.
> > > I am working on a fix and will send it to mailing list as soon as it's ready.
> > >
> >
> > Could you elaborate on the problem please?
>
> Sure! My bad..
>
> Little bit of history here:
> Boris with this patch set [1] introduced statically mapping EFI Runtime Services at -4G
> and also introduced "efi=old_map" to return to previous EFI functionality which used
> ioremap and __va(pa).
>
> [3] and [4] are links to old_map_region()
>
> The commit 08cfb38f3ef4 ("x86/efi: Unmap EFI boot services code/data regions from efi_pgd"),
> unmaps EFI boot services code/data regions *only* from efi_pgd but efi=old_map maps
> EFI boot services code/data regions into swapper_pgd. Also, efi=old_map  uses either
> ioremap() or __va(md->phys_addr) to map EFI runtime/boot time services and doesn't use kernel_map_pages_in_pgd().
>
> So, we need a different unmapping routine to unmap EFI boot services code/data
> regions from swapper_pgd if they were mapped using efi=old_map.
>

For the short term, could we simply make your changes dependent on efi
!= old_map? That gives us some time to fix the old_map case properly.
