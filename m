Return-Path: <SRS0=OLKc=O6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C004C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 17:26:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 22D6E21939
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 17:26:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="ZtNZpMFm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390212AbeLUR0g (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Dec 2018 12:26:36 -0500
Received: from mail-io1-f49.google.com ([209.85.166.49]:33417 "EHLO
        mail-io1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731522AbeLUR0f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Dec 2018 12:26:35 -0500
Received: by mail-io1-f49.google.com with SMTP id t24so4228964ioi.0
        for <linux-kernel@vger.kernel.org>; Fri, 21 Dec 2018 09:26:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=EF3KDcq1OPKVRJUCo/GQmomuC/MhhwMGlFXLQ5IJr6s=;
        b=ZtNZpMFmKu434Gl6ywzPwp2wvGjhkWNwWyD4yfqOJGU4LNbp4daaq80Ue1b/NTJYPP
         r1dfBwiH9CDEgkzyba+FjbTHjSJ0P+U20rgYu8RWzEftVoIzp7W9nldCNcLj8kGCbXSk
         fw2xUXut8iB9nCLvpCtMCJiAOxzRdO2Cq6+o8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=EF3KDcq1OPKVRJUCo/GQmomuC/MhhwMGlFXLQ5IJr6s=;
        b=MZsSRjDg4PD+9njKEvafvYE7aCAmrr51F0weSyl+/e+CTzfA9dgS6HXRLCAdV6Qw3N
         HGECyEd8cemRxbl7UgFnJpXG7xh5H6vrGr9oq2SbzJc9GaAt/QOLWff8VObBjRWhGGW9
         u8ktyRREXYuNx7zX/wnXLAxsdpS7IA7iCVPEb6cDtWxIkfB1KOzc035OP6FWDAeKkNmc
         X7CL9aPZipIVLFHND8VQsnnPWxtVzqQFHwdaKozZU5Fi+GouV86gxLzndFXVmT3a7uhD
         Oqh3INEQKtcMGCQNFEo0gKpto4PVolScbkM6KOLkJ6xdfRy425OY1C3KLTPxE91j5I8h
         /S0A==
X-Gm-Message-State: AJcUukcPWZOFPh3tuk2dHca9BWuEnBbSQmGNkpEAX4Q2Vj9d/ipiO71i
        bRjqDE411TlcSH17OOhhdkTPbIosxlEvLiu3mfZMeQ==
X-Google-Smtp-Source: ALg8bN6GT0vHICydfCxuIO6bJUd9Q0eSa0DJPlSlzJ3G50yA8u/Df26YVafvkP03QFuGtRJppgyEKJRm5dXaRz/RCno=
X-Received: by 2002:a5e:cb0b:: with SMTP id p11mr2365554iom.60.1545413194360;
 Fri, 21 Dec 2018 09:26:34 -0800 (PST)
MIME-Version: 1.0
References: <20181129171230.18699-6-ard.biesheuvel@linaro.org>
 <tip-08cfb38f3ef49cfd1bba11a00401451606477d80@git.kernel.org>
 <FFF73D592F13FD46B8700F0A279B802F48604575@ORSMSX114.amr.corp.intel.com>
 <CAKv+Gu_vTHFxpKRu_CxKP-GdNdgdFKr7fi87VkNur0sqGQNVDw@mail.gmail.com>
 <FFF73D592F13FD46B8700F0A279B802F486045CA@ORSMSX114.amr.corp.intel.com>
 <CAKv+Gu9iJinkP-buhmzRyB91_HcJ-tDwT3YHeHGFo4Bsiv7O_Q@mail.gmail.com>
 <FFF73D592F13FD46B8700F0A279B802F486046A9@ORSMSX114.amr.corp.intel.com>
 <CAKv+Gu99VdPero0yrXiaByURyp1idYE948Qi4j1eqY0ENCrF5A@mail.gmail.com> <20181221171308.GJ1325@zn.tnic>
In-Reply-To: <20181221171308.GJ1325@zn.tnic>
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date:   Fri, 21 Dec 2018 18:26:23 +0100
Message-ID: <CAKv+Gu91YsuK2QmWStPe84v8L7XD9x4cduTYgUjj3TPRfQckfw@mail.gmail.com>
Subject: Re: [tip:efi/core] x86/efi: Unmap EFI boot services code/data regions
 from efi_pgd
To:     Borislav Petkov <bp@alien8.de>
Cc:     "Prakhya, Sai Praneeth" <sai.praneeth.prakhya@intel.com>,
        Ingo Molnar <mingo@kernel.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "x86@kernel.org" <x86@kernel.org>,
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

On Fri, 21 Dec 2018 at 18:13, Borislav Petkov <bp@alien8.de> wrote:
>
> On Fri, Dec 21, 2018 at 06:02:29PM +0100, Ard Biesheuvel wrote:
> > As far as I can tell, the SGI x86 UV platforms still rely on this, so
> > we're stuck with it for the foreseeable future.
>
> What happened with the old apple laptops which couldn't handle high
> virtual mappings and needed 1:1? We don't care anymore?
>

If that is the case (I wouldn't know) then yes, there is a second
reason why we need to keep this code.
