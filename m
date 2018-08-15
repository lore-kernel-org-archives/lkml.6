Return-Path: <SRS0=5j8r=K6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A621C46460
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Aug 2018 00:21:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 311572156E
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Aug 2018 00:21:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lJVBWguD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 311572156E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728237AbeHODLT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Aug 2018 23:11:19 -0400
Received: from mail-io0-f196.google.com ([209.85.223.196]:32940 "EHLO
        mail-io0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727593AbeHODLT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Aug 2018 23:11:19 -0400
Received: by mail-io0-f196.google.com with SMTP id z20-v6so20242120iol.0;
        Tue, 14 Aug 2018 17:21:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=oRxzhf+ujFyfBEFMF3Z7kKvfR5Et3JnJCvkRsGCfrE0=;
        b=lJVBWguDzjiZhrybEpZsuRN212qUpSA70aH8iL6kLt5EYSffLGsjE7NSjgrtOFrTvI
         JVOrKNG3oElQSyttuoWRX2RFwT1nDOoswdEkmVtgGFEMI2ICbiwnZjW+sYTPDrR2ERb7
         IVAUWnSLzUUmxVndZUE8WNNhStoArlE2Fs/VPQFFx0kW0rJmjvGeAKMw6vSzph2BzZu2
         vUw2J1j7JIRFuvG25ROo+ZL6xGwx/WaxLa3axC9vdZF5d0h+TY+0tOEhc1q+PgDUpjry
         uIM2UGHmawkQZBJuHdQXaBsPR+iF43wmCtc//am7JLmS+709acOidB7xRO22MF4ufStd
         5igQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=oRxzhf+ujFyfBEFMF3Z7kKvfR5Et3JnJCvkRsGCfrE0=;
        b=ZuTInRJr3kWtMRXjnvA/PZTqwLtpqDXwtI0T17IzLVSZfVyYm2cXanlPu7Im9LaOXu
         CvT6Cqhk8zLwlJ05T0q0xhLTCO137gMKxdsZH7tPSxYi0dKV/U4W3bsAcZmt/IbLhWtV
         SWaTW1njNUfBSs36Kfn2I1mn9n2J1WK3HkC9ps8bzguIXHVlwvf+PeSmkAvQ67srElD6
         tU4HVwiMtVv1i7bO38UbQceL7L7P/UNC3ZD49hi7rsfrjiTAZn+IL8aW2B+ouDm7N/Mc
         KGa6MFgqJHBTSs8DOt2RUUVg6SXZval9zS0/9FJwv2L+YCRyOXOC0A1ISrNLMf5zSC0a
         bt9g==
X-Gm-Message-State: AOUpUlEfB3HoP3tnFvJ3lJGioO0AZXMdFE20pa3tvQoZg/FkOwmCh63I
        asj/AQKV3oE6FNHdX1LwHYnLG8c3mDsmN9jUViNj0lz/pOA=
X-Google-Smtp-Source: AA+uWPy3gJjkvx2HDKdbbrCWzU1vJafJ69+4jdp3ipw4+8LQVFQjH8y0fGmYifd+G2w3eANedMdWwUbJHXQ0UxD4guo=
X-Received: by 2002:a6b:fe14:: with SMTP id x20-v6mr21149593ioh.159.1534292498869;
 Tue, 14 Aug 2018 17:21:38 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a4f:5a03:0:0:0:0:0 with HTTP; Tue, 14 Aug 2018 17:21:38
 -0700 (PDT)
In-Reply-To: <BN7PR12MB2593F278911BAF74943245F8F8380@BN7PR12MB2593.namprd12.prod.outlook.com>
References: <20180810193623.24629-1-mikhail.jin@gmail.com> <BN7PR12MB2593F278911BAF74943245F8F8380@BN7PR12MB2593.namprd12.prod.outlook.com>
From:   Michael Jin <mikhail.jin@gmail.com>
Date:   Tue, 14 Aug 2018 20:21:38 -0400
Message-ID: <CAO6F7DmZCAO=jyTQKkjW5Z5u84Zkn7Ur3tgqxQZESRDcH46NLg@mail.gmail.com>
Subject: Re: [PATCH] EDAC, amd64: Add Family 17h Model 11h support.
To:     "Ghannam, Yazen" <Yazen.Ghannam@amd.com>
Cc:     Borislav Petkov <bp@suse.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 14, 2018 at 4:26 PM, Ghannam, Yazen <Yazen.Ghannam@amd.com> wrote:
>
> > -----Original Message-----
> > From: Michael Jin <mikhail.jin@gmail.com>
> > Sent: Friday, August 10, 2018 2:36 PM
> > To: Borislav Petkov <bp@suse.de>; Ghannam, Yazen
> > <Yazen.Ghannam@amd.com>; Mauro Carvalho Chehab
> > <mchehab@kernel.org>
> > Cc: linux-edac@vger.kernel.org; linux-kernel@vger.kernel.org; Michael Jin
> > <mikhail.jin@gmail.com>
> There may be some differences between models, but things should generally
> work. It's just a matter of whether or not the Platform enables certain things
> like DRAM ECC, etc.
>
> Does the amd64_edac_mod module load on your platform with just this patch?
>
> > +                     fam_type = &family_types[F17_M11H_CPUS];
> > +                     pvt->ops = &family_types[F17_M11H_CPUS].ops;
> > +                     break;
> > +             }
> >               fam_type        = &family_types[F17_CPUS];
> >               pvt->ops        = &family_types[F17_CPUS].ops;
> >               break;

Yes, I was able to load amd64_edac_mod on my AMD Ryzen Embedded V1807B
(further details on my blog -
https://ndimcomputing.io/fs-fp5v_ecc_linux.html).

> > diff --git a/drivers/edac/amd64_edac.h b/drivers/edac/amd64_edac.h
> > index 1d4b74e9a037..e50226cd53c6 100644
> > --- a/drivers/edac/amd64_edac.h
> > +++ b/drivers/edac/amd64_edac.h
> > @@ -115,6 +115,8 @@
> >  #define PCI_DEVICE_ID_AMD_16H_M30H_NB_F2 0x1582
> >  #define PCI_DEVICE_ID_AMD_17H_DF_F0  0x1460
> >  #define PCI_DEVICE_ID_AMD_17H_DF_F6  0x1466
> > +#define PCI_DEVICE_ID_AMD_17H_M11H_DF_F0 0x15e8
> > +#define PCI_DEVICE_ID_AMD_17H_M11H_DF_F6 0x15ee
> >
>
> These IDs are used for Fam17h Models 10h-2Fh. Can you please change
> the names here and in the rest of this patch?
>
> The format is to use the first supported model in the name, e.g. M11H -> M10H.
>
> >  /*
> >   * Function 1 - Address Map
> > @@ -281,6 +283,7 @@ enum amd_families {
> >       F16_CPUS,
> >       F16_M30H_CPUS,
> >       F17_CPUS,
> > +     F17_M11H_CPUS,
> >       NUM_FAMILIES,
> >  };
> >

According to https://en.wikichip.org/wiki/amd/cpuid, family 17h model
10h is not publicly known.

Therefore, I would like you to confirm that model 10h uses 0x15e8
(device F0) and 0x15ee (device F6) as I can not find any documentation
or test whether ECC works.

Raven Ridge BIOS motherboards do not enable ECC, but share the same
CPUID (0081_0F10h
http://www.cpu-world.com/CPUs/Zen/AMD-Ryzen%205%202400G.html) as AMD
Ryzen Embedded V1000 Processor Family.

This patch was written due to the fact that amd64_edac_mod erroneously
sets the wrong device ids for the AMD Ryzen Embedded V1000 Family
(device F0 and F6 fail to load, as they do not share 0x1460 and 0x1466
with the other family 17h processors).

Michael
