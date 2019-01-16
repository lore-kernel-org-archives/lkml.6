Return-Path: <SRS0=1Lvk=PY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1A2CC43387
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 21:24:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 78E5F20840
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 21:24:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JI+IUnQZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729735AbfAPVYn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Jan 2019 16:24:43 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:37995 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729635AbfAPVYi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jan 2019 16:24:38 -0500
Received: by mail-pf1-f194.google.com with SMTP id q1so3680315pfi.5
        for <linux-kernel@vger.kernel.org>; Wed, 16 Jan 2019 13:24:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fqavfFFoBnTEqPaLDWGOznQU69q5cYmtpsNuznnDYpE=;
        b=JI+IUnQZKvI7ocgF3nbSpMNuXyCYGrTQJb37G0E2cgyDYZ+mzS3QMHa8UoXe4RMqtm
         0P3fiuYxMRht56r4EYPG7JAJmCUgSoJ4r+5YgSCjC+UnMm5b5uqlRtM933oKBCWTOp4p
         Z5C0G4tLOu4+PnvaGFyl8sQ5AH+dz+rrMhXQ0vDJ/tZZ8+az6uTGOzBKg/9M8VOhMUS9
         lMTqX053EdKm70CXRB8uVRZlSyn5W8z8oCDUPWn2LBuyGXVQr8aYUaw0HjC2CfPgmC9V
         kG7mG84Raq4oiFIlt5SeIrMwW1AOToQcCILbjyEymlA6OJP4EAqRYq9KQfHn4Olq6s2+
         Oe2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fqavfFFoBnTEqPaLDWGOznQU69q5cYmtpsNuznnDYpE=;
        b=Tiea7pzi4rUbK+FTZBvcmE8Xop5NzbhgBAw8Kh23tz7FTxm4EIMXh7MYqqwYGRs49C
         Z4L3rhIHN2YSOnsH3666gAJDt7NA+vV3+qCvRAed4/pwkqA5RD97A3SnnIemckoOn+5A
         QdnKo+IibVN1bULIJT3FROfECCRomFHEXVy/PrJGau3MiQOgRTuMGODc1O64PgCqFw6g
         qMUcJxoHNH6bIMXnAUuX20luw/GXvCEGDpwGyST8qmOEU7M+y5tKVq6KPEK+OoG67RRW
         3J43bIpeoSudrvjFa7G6R0oMNDssg8TrM7Smmcet5VAxCPdmvQWA6mptT4QqPefRNp6E
         tAxA==
X-Gm-Message-State: AJcUukeWmXA+Dd7CwV3IuVyAOAebCbA9SAq2BR024MX5Pu8w1Mp/wkSg
        mzPYgj2dauNAdnikJV5eSJKcCS5hP4IYk+wRnKM=
X-Google-Smtp-Source: ALg8bN7YxJcD1Tcpnn0eV1h6gRmRyulbit6AJb4LuGpBUodzf7dSCqWST3MA/dz3Q8F9lAsTKDN2BkYT1H8k38d8znk=
X-Received: by 2002:a63:bd51:: with SMTP id d17mr10877817pgp.443.1547673878052;
 Wed, 16 Jan 2019 13:24:38 -0800 (PST)
MIME-Version: 1.0
References: <CAGXu5jKUP9o-ZgW5Wa5-9DHeQNZ5VA3cLBCJ0P7AVkTQ5tqHtQ@mail.gmail.com>
 <CAPcyv4iZZEM3D8vta_sge7a4iMgPZ5a1AnunXa4DKUaWauZk1g@mail.gmail.com>
 <CAGXu5j+z_yRPgE0HO=Sjo_VwwDDPJ+VLxbxwKgbb2cUAB5jmwg@mail.gmail.com>
 <CAPcyv4jhFGMzBrWHS_9q0Fe2MersRXz31VG3H2dJfujx1CJGhQ@mail.gmail.com>
 <CAGXu5jKrhvUduv_XUYF94YM=bBfPGNkPrZ_EkvRKB0pDY_6uOw@mail.gmail.com>
 <CAPcyv4jQ1Og_mEVjb77xdM263MugzK7_yrR_zi498JFrOrhSrg@mail.gmail.com> <CAPcyv4if2YwyYSn9XLKHQXX2oe+nX2idvNx79M2s1j4FMftkBg@mail.gmail.com>
In-Reply-To: <CAPcyv4if2YwyYSn9XLKHQXX2oe+nX2idvNx79M2s1j4FMftkBg@mail.gmail.com>
From:   Dexuan-Linux Cui <dexuan.linux@gmail.com>
Date:   Wed, 16 Jan 2019 13:24:26 -0800
Message-ID: <CAA42JLYcpY_f4CJY5XU9zmbLWw6ivyWsp1rgfDWnovCUvcDCVg@mail.gmail.com>
Subject: Re: nvdimm crash at boot
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     Kees Cook <keescook@chromium.org>,
        Dave Jiang <dave.jiang@intel.com>,
        linux-nvdimm <linux-nvdimm@lists.01.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Dexuan Cui <decui@microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 8, 2019 at 4:49 PM Dan Williams <dan.j.williams@intel.com> wrote:
>
> On Tue, Jan 8, 2019 at 4:02 PM Dan Williams <dan.j.williams@intel.com> wrote:
> >
> > On Tue, Jan 8, 2019 at 3:55 PM Kees Cook <keescook@chromium.org> wrote:
> > >
> > > On Tue, Jan 8, 2019 at 3:54 PM Dan Williams <dan.j.williams@intel.com> wrote:
> > > >
> > > > On Tue, Jan 8, 2019 at 3:34 PM Kees Cook <keescook@chromium.org> wrote:
> > > > >
> > > > > On Tue, Jan 8, 2019 at 3:28 PM Dan Williams <dan.j.williams@intel.com> wrote:
> > > > > > Ah, thanks for the report! The key difference is that you don't define
> > > > > > a "label area", so the driver bails out early and never initializes
> > > > > > the security state.
> > > > > >
> > > > > > This should fix it up.
> > > > > >
> > > > > > diff --git a/drivers/nvdimm/dimm_devs.c b/drivers/nvdimm/dimm_devs.c
> > > > > > index 4890310df874..636cdb06ee17 100644
> > > > > > --- a/drivers/nvdimm/dimm_devs.c
> > > > > > +++ b/drivers/nvdimm/dimm_devs.c
> > > > > > @@ -514,7 +514,7 @@ static umode_t nvdimm_visible(struct kobject
> > > > > > *kobj, struct attribute *a, int n)
> > > > > >
> > > > > >         if (a != &dev_attr_security.attr)
> > > > > >                 return a->mode;
> > > > > > -       if (nvdimm->sec.state < 0)
> > > > > > +       if (!nvdimm->sec.ops || nvdimm->sec.state < 0)
> > > > > >                 return 0;
> > > > > >         /* Are there any state mutation ops? */
> > > > > >         if (nvdimm->sec.ops->freeze || nvdimm->sec.ops->disable
> > > > >
> > > > > Okay, cool. I wasn't sure if that test needed a deeper check. :)
> > > > >
> > > > > Fixes: 37833fb7989a9 ("acpi/nfit, libnvdimm: Add freeze security
> > > > > support to Intel nvdimm")
> > > > > Tested-by: Kees Cook <keescook@chromium.org>
> > > > >
> > > >
> > > > Actually, looking closer this should have been avoided by the fact
> > > > that __nvdimm_create() initializes the security state early and that
> > > > nvdimm->sec.state should have saved us.
> > > >
> > > > I'll dig a bit deeper with your qemu config.
> > >
> > > Maybe something goes weird with pstore stealing the region?
> >
> > No, pstore is off the hook. I was just able to reproduce locally and
> > I'm not doing anything with pstore.
>
> Huh, this fixes it:
>
> diff --git a/include/linux/libnvdimm.h b/include/linux/libnvdimm.h
> index 5440f11b0907..7315977b64da 100644
> --- a/include/linux/libnvdimm.h
> +++ b/include/linux/libnvdimm.h
> @@ -160,6 +160,7 @@ static inline struct nd_blk_region_desc *to_blk_region_desc(
>  }
>
>  enum nvdimm_security_state {
> +       NVDIMM_SECURITY_ERROR = -1,
>         NVDIMM_SECURITY_DISABLED,
>         NVDIMM_SECURITY_UNLOCKED,
>         NVDIMM_SECURITY_LOCKED,
>
> Apparently I was wrong to think an enum was a signed int without
> actually making a signed value a possibility. I would have a expected
> the compiler to give me a "statement has no effect" for testing for a
> negative value against an effectively unsigned quantity.

Thanks for the one-line patch! It fixed the same crash for me.

-- Dexuan
