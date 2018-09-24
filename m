Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 014A5ECE568
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 21:09:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AB0AC2145D
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 21:09:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h/tqEWJB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AB0AC2145D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728532AbeIYDNa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Sep 2018 23:13:30 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:39060 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726227AbeIYDN3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Sep 2018 23:13:29 -0400
Received: by mail-qt1-f194.google.com with SMTP id c25-v6so5381367qtp.6;
        Mon, 24 Sep 2018 14:09:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=CrALZ6L3Llp7eeLcIXR7AOc6ugMP3S6GPPXEOFTJH2g=;
        b=h/tqEWJBio0nQjestvOCUy2xcrlPIo9O9yMb2mOO1R/BLS65KlAe+Kk1n+fFATuADi
         OaX/EchFmuZJR+cXeN1L96WqY4bt5Vvvqlem+JxgrDeczSn/BSYLagQcRLP340uDh+Vo
         T7YY97xEhwxEPICMhJ6sL5hYkYXs1vYNcScSWMFqINce3PY8WDSZ8fnYXUROsA5EgyoG
         xBQxPMfaRSU6JxVv+3j5lvv+ldXdANQ4nvk/nybwJkmMTMLdfUExXzlQz8nGnjqRDiv/
         9QW9pSbaYd0ZPdCNtZy3dp3xclizutv9zfzf4/jpleJhHGZerWbQPpgk9d25LLS7c5Fi
         zr4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CrALZ6L3Llp7eeLcIXR7AOc6ugMP3S6GPPXEOFTJH2g=;
        b=Iyuos0pEaGw2rHPrFRluZpj8dBTlNbazFx40A7teF4Rcii+p5vGkevwQdRCSu0+1qx
         FL9/3nkoDuTAr26GO8BheU3dJwhJc+J/5FNXqmFtmbqT/B9RvV9zLz6PFB96hMBh3umW
         2rB77t28jYimbitUYKdEkE5/t005BU/JmtjVvnIVqtFu/SfWJRnUWY3jpfoWb77/ZRni
         cmKi7DLiSfHj70+sg4C/n4Tu8W7gNwitCIO8fwaFCMR8KpZJ5mQmvctJ5sLyTBBQjCam
         i3EPHjVzw1sjhcnnyz065/IA0aqYrPD8g5j8eAqTVxiHWZfZfMbAg/tYsBTqvUHD13gc
         j6bw==
X-Gm-Message-State: ABuFfoiklJBJp890lb156whnxB7eaGBNXC7mXkFou/VHuzl2xhk6hoFw
        mu4JkIVmjaf1G5dcB/vLpLIxYeKKW4rtbG6kQxY=
X-Google-Smtp-Source: ACcGV63RIaFLg0GNU01n4GR7JsdaCBsl9+5QHGRlj3XPrc94lkWtJZCCd74/1w5h0/SH+MpjpgVi/WmOe/SRlOOeGbg=
X-Received: by 2002:ac8:16c5:: with SMTP id y5-v6mr537415qtk.187.1537823361611;
 Mon, 24 Sep 2018 14:09:21 -0700 (PDT)
MIME-Version: 1.0
References: <20180913223143.12664-1-rajatja@google.com> <CAHp75VcVkp6i_4oNVJvzde13MwaRQge91mvZF2aXgneZC9nzWg@mail.gmail.com>
 <CACK8Z6FhJhhfgk1zPMv5M0oRwz=o75YOKFmU+4Wx-X9-prPnKA@mail.gmail.com>
 <CACK8Z6GeZ+2uRsRDPfdd=i+WrdQwQgEBvEyDxQuKLygXqPp4dw@mail.gmail.com>
 <CACK8Z6FLPVSJpPuAXZsqHV2rY2zy3L-Fvd=QPn=+Ynp3aHyhaQ@mail.gmail.com>
 <20180924135935.GP15943@smile.fi.intel.com> <70D28D5DAE32E9429B09AA8B7C84AC472C0000CB@BGSMSX106.gar.corp.intel.com>
 <CACK8Z6Ej=BVThT8gSHCNZadXbLpzqKe6TmLYGkeBMmJBby1n-g@mail.gmail.com>
In-Reply-To: <CACK8Z6Ej=BVThT8gSHCNZadXbLpzqKe6TmLYGkeBMmJBby1n-g@mail.gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Tue, 25 Sep 2018 00:09:10 +0300
Message-ID: <CAHp75VdyOAzHDNr4L6Onj=Qgu2DfQxPy-j_jo2HXfyukCZRePg@mail.gmail.com>
Subject: Re: [PATCH] pinctrl: icelake: Fix the resource number for community-4/5
To:     Rajat Jain <rajatja@google.com>
Cc:     subrata.banik@intel.com,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Rajat Jain <rajatxjain@gmail.com>, aamir.bohra@intel.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 24, 2018 at 8:04 PM Rajat Jain <rajatja@google.com> wrote:
> On Mon, Sep 24, 2018 at 7:54 AM Banik, Subrata <subrata.banik@intel.com> wrote:

> > First of all, this is pre-production chip, so, I don't think there is a bug in the driver (yet) discovered.
> >
> > Looking to the above ASL code I may conclude that is definitely is *not* from our reference BIOS.
> > I have checked two versions of it and found that in both we have the following mapping:
> > for LP variant: there are only 4 communities are exported for H variant: there are only 5 communities are exported
> >
> > So, I guess the problem is in ASL code you provided. It simple should not export that community at all.
> >
> > In case you need to do so, there are ways:
> >  - contact Intel and ask for a change in reference BIOS
> >  - acquire another ACPI ID for the case, or, perhaps use special constants like
> >    _HRV for that purpose (also need to contact Intel while doing that)
>
> As Subrata clarified (Subrata & Aamir are from Intel's Coreboot team),
> that is not *the* Intel reference BIOS that you are using, but it is
> *an* Intel generated BIOS/Coreboot image.

Ah, interesting.

> Andy, can you please let us know in what order are the resources laid
> out in your reference BIOS for the case when it exports 5 communities
> (i.e. community-0-2, 4-5)?

We have no hardware with such PCH to answer to this question. LP
version exports only 4 communities and order of them as per existing
driver.

-- 
With Best Regards,
Andy Shevchenko
