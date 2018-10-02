Return-Path: <SRS0=iNRz=MO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87C1EC43143
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 10:28:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1E3CF2089A
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 10:28:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BL1xf7+z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1E3CF2089A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727182AbeJBRKk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Oct 2018 13:10:40 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:36513 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726866AbeJBRKk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Oct 2018 13:10:40 -0400
Received: by mail-qt1-f195.google.com with SMTP id u34-v6so1312413qth.3;
        Tue, 02 Oct 2018 03:28:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=YWj0eLBuovzMSRJcTz+JkIyJvbXFgVxFIGiCFTpk84U=;
        b=BL1xf7+z1A20R1jSEHELVw7GDY9ULBKfHb6aoNJUp7a37kdpocNGekJIF0njF/uEZ3
         D6EDUvkItF8vBMOX8UIb+OTLxYcOShR2c+b0ES97YE2TiJNezObiRcWstxXnir9rCJ3R
         MWXtdELcBP9G0H20poCYgHg8ePeOhKbNyaUgpByfQ41GA2kvxenPya55BRYMcFgCjEfQ
         +z+VxMVoOSyYyoVYeeCooJlMO4KKthLeC2dqCzVciO1nWah/HgmIF7392g4WR/SLSnjw
         BuMvtJwOwrc6FWJnNVMh1Vi/GbSQS7mJqeQnaRdAQr+5R5SOk9fjW7xjG78Db8iwGZQU
         VWug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YWj0eLBuovzMSRJcTz+JkIyJvbXFgVxFIGiCFTpk84U=;
        b=qs0jHSYIM4BitHUvicOZIS0R+z3BfvnO4e/4WKYyp1aGGFYfFO/o6NM3zfxXimyqrA
         jgv/BpW1Z0C/Rc6bS45qJfXDaL5WwuKincYNYYi6PUYFnziPu2fSNDVtpRPHVWzEC52E
         RNjYWvQ/8/dCBCPoMd6daoyJEDpBGw8IJu5EcwLTvjnus4WKutcpC1+Anpt+Xy8OiEWT
         05O5+hGAV3Tt99tI3DT1PBo4Y3TPidppzlhwjeCqIYE8WRCsk0TI7VrSYdmXK+XYexka
         Y5hqT9tnzZzZ4v2zXI5ztuSmNe6jUNZIwRAIxRICiv4NSWs3D5eQI9p2tzQe8wHALxtn
         lcsg==
X-Gm-Message-State: ABuFfojQZC4TPF159PPTZNsYXeILnmd9ILycYGZmG00KJW0i7FNHfdG9
        HbOfIW5XVvAnAtMk62zncOsoF0zqoa8Fj4qa4t8=
X-Google-Smtp-Source: ACcGV62oOj63WLV0jzEi1WOgJBtUZvcgpqfk/z0fhhOXptydkLsABx22FIG+/2lQ2WVLHf/j+jS5yfzlcq2uIVhXGPI=
X-Received: by 2002:ac8:3c3:: with SMTP id z3-v6mr12129228qtg.39.1538476084420;
 Tue, 02 Oct 2018 03:28:04 -0700 (PDT)
MIME-Version: 1.0
References: <20181001174349.26357-1-f.fainelli@gmail.com> <CAHp75Vd2js3QCJYjPDea5xapYLiOObSUF7_Q2hjG8RS=QYyPaQ@mail.gmail.com>
 <CAK8P3a22COa4YyWc7_pCSAy3TU0mne76RGwG8d73Aphad_ekwg@mail.gmail.com>
In-Reply-To: <CAK8P3a22COa4YyWc7_pCSAy3TU0mne76RGwG8d73Aphad_ekwg@mail.gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Tue, 2 Oct 2018 13:27:53 +0300
Message-ID: <CAHp75Vf_daFqLZ+aYRRAR_6ZZKH2==r1+6Dc51MUpx1VSW3QKA@mail.gmail.com>
Subject: Re: [PATCH v2] i2c: brcmstb: Allow enabling the driver on DSL SoCs
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Kamal Dasu <kdasu.kdev@gmail.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Jarkko Nikula <jarkko.nikula@linux.intel.com>,
        Jean Delvare <jdelvare@suse.de>, kramasub@codeaurora.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Eddie James <eajames@linux.vnet.ibm.com>,
        James Hogan <jhogan@kernel.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        "Krogerus, Heikki" <heikki.krogerus@linux.intel.com>,
        linux-i2c <linux-i2c@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 2, 2018 at 1:22 PM Arnd Bergmann <arnd@arndb.de> wrote:
>
> On Mon, Oct 1, 2018 at 8:13 PM Andy Shevchenko
> <andy.shevchenko@gmail.com> wrote:
> > On Mon, Oct 1, 2018 at 8:44 PM Florian Fainelli <f.fainelli@gmail.com> wrote:
> > >
> > >  config I2C_BRCMSTB
> > > -       tristate "BRCM Settop I2C controller"
> > > -       depends on ARCH_BRCMSTB || BMIPS_GENERIC || COMPILE_TEST
> > > +       tristate "BRCM Settop/DSL I2C controller"
> > > +       depends on ARCH_BRCMSTB || BMIPS_GENERIC || ARCH_BCM_63XX || \
> > > +                  COMPILE_TEST
> >
> > I would rather split this to two 'depends' entries, though it's
> > cosmetic and up to you.
>
> You can only split 'depends on A && B' into multiple lines, not
> 'depends on A || B'.

Indeed. What I was thinking of?

-- 
With Best Regards,
Andy Shevchenko
