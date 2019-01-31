Return-Path: <SRS0=Wtxu=QH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9941DC169C4
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 09:28:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 715A7218AF
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 09:28:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V8v5DPFj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730227AbfAaJ2x (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Jan 2019 04:28:53 -0500
Received: from mail-qt1-f193.google.com ([209.85.160.193]:33767 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725932AbfAaJ2x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Jan 2019 04:28:53 -0500
Received: by mail-qt1-f193.google.com with SMTP id l11so2765318qtp.0
        for <linux-kernel@vger.kernel.org>; Thu, 31 Jan 2019 01:28:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=c2SH6iGzcEU+y+xScTitqTjOuMSKU4Zl8nWX7d89d/Y=;
        b=V8v5DPFjA7X89sjzl0WXa7Y9tXUMPu8D2bMGXDIOJjSrrfIAASkahblN+29quyXwXe
         BN/TTY9CS6BztLx/VUmYOSPe0D6kp7ZSXSc5p0A+Y9CjE3DyqIHLi0Uca0z01UUMcK7C
         cIRnHWVJ9nlfT5Gy8nUVDbdg0ldLg6PDgAG9XUYw0WInOIFdcGYazT1ArYvvZWzi7KU2
         Zrp6DhnPct3fRiIA4KpA2/ijC81ReOYZ39KSOahHFybphq4A9QCdrcQK6Hk3I/ELavW9
         XHj/3103iV0HOSK3kmPiUabOLuurWfHnJONqSwIaeH79plQcnxojY8oReBr9g9cHK2tu
         4rug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=c2SH6iGzcEU+y+xScTitqTjOuMSKU4Zl8nWX7d89d/Y=;
        b=BREOq1R/jUQM4APllv6ORmmT5+Ze6caI+pGwotOt7oO6xaNl+V4oWOHUM/iEA+46TG
         +ozZy7qCzcMpjzt9iEYZuc1FpRwsv+GSgI7/UblZat8eG/3AaC1HvFzxtkrRfUcOklVL
         md1GM5z1vHsnFmJmgJTlpgDd7/gp8e0uPz0DZufPS52ZNYuYukU5TNv9HNHHQlesmgUi
         y0Gv5JUAkyNp3aSzf/ahpq78BZwiDUwzKqolUWcjh4s2jcV3UYN3QSdRrjiTO6kr38y4
         uZIG8UT2nNOVi+cjwNgmiCt6KG56Jm64AVfzinr7IsNy3qjYBEAHV5VhrzgMegA4Vozi
         bR6Q==
X-Gm-Message-State: AJcUukc1fBN02wiCqkK0ycM0UT/Qah73w7RKlxy2Ukqt0Ks6Hwi9cHw7
        ls8V500rH3EfSMx8oA0yCIY3IG4uSIXMWj1ST8w=
X-Google-Smtp-Source: ALg8bN4PFrwLUlIE/LF9gEimcz+4Xvq0y7nDiglirHJq2xGlbjDLWVlSBAInj2ZpTyN/qgjbGmDvpBxdUr+lvk1b5a8=
X-Received: by 2002:ac8:5241:: with SMTP id y1mr34544942qtn.22.1548926932012;
 Thu, 31 Jan 2019 01:28:52 -0800 (PST)
MIME-Version: 1.0
References: <20181212173402.27086-1-enric.balletbo@collabora.com> <20190116085124.GC23399@dell>
In-Reply-To: <20190116085124.GC23399@dell>
From:   Enric Balletbo Serra <eballetbo@gmail.com>
Date:   Thu, 31 Jan 2019 10:28:40 +0100
Message-ID: <CAFqH_51Mk7_bK8vw8yuUPpvEouAwQjXEGW9JFqH1S4U9Ndr3+Q@mail.gmail.com>
Subject: Re: [PATCH v5 0/7] mfd / platform: cros_ec: move cros_ec sysfs
 attributes to its own drivers.
To:     Lee Jones <lee.jones@linaro.org>
Cc:     Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Gwendal Grignou <gwendal@chromium.org>,
        Nicolas Boichat <drinkcat@chromium.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Guenter Roeck <groeck@chromium.org>, kernel@collabora.com,
        Benson Leung <bleung@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Lee,

Missatge de Lee Jones <lee.jones@linaro.org> del dia dc., 16 de gen.
2019 a les 19:31:
>
> On Wed, 12 Dec 2018, Enric Balletbo i Serra wrote:
>
> > Hi,
> >
> > This is another patchset to try to cleanup a bit more the crossed
> > references for cros-ec driver between the MFD and the platform/chrome
> > subsystems.
> >
> > The purpose of these patches is get rid of the different cros-ec attrib=
utes
> > from mfd/cros_ec_dev to its own sub-driver in platform/chrome. cros_ec_=
dev
> > continues instantiating the sub-devices but the sysfs attributes are ow=
ned
> > by the platform driver.E.g. The lightbar driver should own his sysfs
> > attributes and be instantiated only if the Embedded Controller has a
> > lightbar.
> >
> > The patchset also adds the documentation of the sysfs attributes.
> >
> > Most of the patches touches mfd subsystem and platform/chrome so I'd
> > suggest go all using and inmutable branch.
> >
> > Best regards,
> >  Enric
>
> [...]
>
> > Enric Balletbo i Serra (7):
> >   mfd / platform: cros_ec: use devm_mfd_add_devices
> >   mfd / platform: cros_ec: move lightbar attributes to its own driver
> >   mfd / platform: cros_ec: move vbc attributes to its own driver
> >   mfd / platform: cros_ec: move debugfs attributes to its own driver
> >   mfd / platform: cros_ec: move device sysfs attributes to its own
> >     driver
> >   mfd / platform: cros_ec_vbc: instantiate only if the EC has a VBC
> >     NVRAM
> >   platform/chrome: cros_ec_lightbar: instantiate only if the EC has a
> >     lightbar
>
> These patches have been applied to my local MFD tree.  It will be
> pushed when 5.0-rc3 has been released.  The MFD tree needs rebasing
> onto it since it contains all of the MFD patches due for v5.0.
>

Do you mind to push the patches in your tree, I've some patches that
depend on these to apply cleanly and I'd like to base my branch on top
of yours.

Thanks,
  Enric

> --
> Lee Jones [=E6=9D=8E=E7=90=BC=E6=96=AF]
> Linaro Services Technical Lead
> Linaro.org =E2=94=82 Open source software for ARM SoCs
> Follow Linaro: Facebook | Twitter | Blog
