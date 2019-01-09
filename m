Return-Path: <SRS0=Tk4m=PR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FFBDC43387
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 11:23:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C5B1C217F9
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 11:23:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ERUZ9+BB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730567AbfAILXZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Jan 2019 06:23:25 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:40084 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729843AbfAILXY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jan 2019 06:23:24 -0500
Received: by mail-pl1-f195.google.com with SMTP id u18so3456700plq.7;
        Wed, 09 Jan 2019 03:23:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qHzQp0kiXKxLyhNLmld/2I5RlSC4SJfARu4BS/3WG9Q=;
        b=ERUZ9+BBcdoGzDZjgRpZulY/jkDZef5hPSUjn5MPBnZ75et591KFNgm789NlRFxUHc
         +NXU/3Bm5pdSuvo8PWXhqoS8rd3lTgmr0xLUSSSpJEG69I/tsSeMIfAsYSK7FReyRsfU
         S12AylVeXNNQxyjZx6FCV+JbOAAYKgocXS8JYxcMwqdNxiLzCIBlW47SzSGk+ZHmtHIX
         qcuYekr15FEoc0MFoMG2beI+okdJ2DF0IAU1uARicg6IgEli0vljZR+lXW9f/pkmc9th
         gxF8yPG7qlQ3DTN7STXCp0RPyC3I4OLCH6XS/4mXW9xp/hg6Zfw5PYkmB50ilbklhFwc
         UI7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qHzQp0kiXKxLyhNLmld/2I5RlSC4SJfARu4BS/3WG9Q=;
        b=CZOHevr2uMDLsBBT0ePuwmWdqxOSjdv1xBNA1vxD99jODTSLZ3xHgupdh3qZuUj5UN
         HY6WJpteq2zMTYAEFl/nwcnbuLE8uHEc88QqdMwYKGMMupz2DUkXschC0OJtzc9q/YvF
         kGxz6X1rOHbaid+n05LCiXEfVaJSdY+OR3DwGeT7kusU9QhS+0YS1L9m2sDDD7PIsWR+
         lEBStVqhdXa1Oer6O7f4YERsRj+NXEBW17HA98o5i6fOSCjsUlydFIj0yoRkpvLJsXN9
         2zqj1h462cTIVhSi4UNta9+KXY1S8nWJFyjy7is1ICvJb5D18E0K5dnLObubwcoCXy+G
         qp3g==
X-Gm-Message-State: AJcUukd2vupFL4f7YAhjzlRJ6UpBTPNk0tS+gTMkLMjq3OBzcIevlw4S
        4qi6CoYMY9sYodaOwP3lEZusD+vp3VyU0Yrnu04=
X-Google-Smtp-Source: ALg8bN77kthZIpSSKtB/V7To/2gKvPymR90In5qxOXqM9UcaQ5lsus/M2q3f7W9S9GrLnEwYRDUECm6SOj5nw/LTX8A=
X-Received: by 2002:a17:902:4081:: with SMTP id c1mr5747105pld.87.1547033003677;
 Wed, 09 Jan 2019 03:23:23 -0800 (PST)
MIME-Version: 1.0
References: <20190108175818.705110-1-lkundrak@v3.sk> <20190108175818.705110-7-lkundrak@v3.sk>
In-Reply-To: <20190108175818.705110-7-lkundrak@v3.sk>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Wed, 9 Jan 2019 13:23:12 +0200
Message-ID: <CAHp75Vf7ctTmncjOfMKL7MDAi=4rr2huBmZ7RsAnPKyJv7HTQQ@mail.gmail.com>
Subject: Re: [PATCH v4 06/15] Platform: OLPC: Move EC-specific functionality
 out from x86
To:     Lubomir Rintel <lkundrak@v3.sk>
Cc:     Andy Shevchenko <andy@infradead.org>,
        Darren Hart <dvhart@infradead.org>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        James Cameron <quozl@laptop.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Pavel Machek <pavel@ucw.cz>, Rob Herring <robh+dt@kernel.org>,
        Sebastian Reichel <sre@kernel.org>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>,
        devicetree <devicetree@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 8, 2019 at 7:59 PM Lubomir Rintel <lkundrak@v3.sk> wrote:
>
> Move the olpc-ec driver away from the X86 OLPC platform so that it could be
> used by the ARM based laptops too. Notably, the driver for the OLPC battery,
> which is also used on the ARM models, builds on this driver's interface.
>
> It is actually plaform independent: the OLPC EC commands with their argument
> and responses are mostly the same despite the delivery mechanism is
> different.
>
> Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>
> Acked-by: Pavel Machek <pavel@ucw.cz>

>  #define OLPC_F_PRESENT         0x01
>  #define OLPC_F_DCON            0x02
> -#define OLPC_F_EC_WIDE_SCI     0x04

Still same concern, i.e. if the initially added definitions are
coupled together by some reason, why we split them?
As I told either move all, or none or put in commit message how
decoupling would benefit.

> +       /* EC version 0x5f adds support for wide SCI mask */
> +       if (ec->version >= 0x5f) {
> +               __be16 ec_word = cpu_to_be16(bits);
> +
> +               return olpc_ec_cmd(EC_WRITE_EXT_SCI_MASK, (void *) &ec_word, 2, NULL, 0);

No space is needed in "(void *)&ec_word".

> +       } else {

> +               unsigned char ec_byte = bits & 0xff;

Shouldn't be u8?

> +               return olpc_ec_cmd(EC_WRITE_SCI_MASK, &ec_byte, 1, NULL, 0);
> +       }
> +}
> +EXPORT_SYMBOL_GPL(olpc_ec_mask_write);

> +int olpc_ec_sci_query(u16 *sci_value)
> +{
> +       struct olpc_ec_priv *ec = ec_priv;
> +       int ret;
> +
> +       if (WARN_ON(!ec))
> +               return -ENODEV;
> +
> +       /* EC version 0x5f adds support for wide SCI mask */
> +       if (ec->version >= 0x5f) {
> +               __be16 ec_word;
> +
> +               ret = olpc_ec_cmd(EC_EXT_SCI_QUERY, NULL, 0, (void *)&ec_word, 2);
> +               if (ret == 0)
> +                       *sci_value = be16_to_cpu(ec_word);
> +       } else {
> +               unsigned char ec_byte;

u8?

> +
> +               ret = olpc_ec_cmd(EC_SCI_QUERY, NULL, 0, &ec_byte, 1);
> +               if (ret == 0)
> +                       *sci_value = ec_byte;
> +       }
> +
> +       return ret;
> +}
> +EXPORT_SYMBOL_GPL(olpc_ec_sci_query);

-- 
With Best Regards,
Andy Shevchenko
