Return-Path: <SRS0=cKeY=I6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.7 required=3.0 tests=BODY_8BITS,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id E7CF9C5CFF1
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 19:54:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9384220660
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 19:54:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="XbiFiFYS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9384220660
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754308AbeFLTyF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Jun 2018 15:54:05 -0400
Received: from mail-yb0-f194.google.com ([209.85.213.194]:47023 "EHLO
        mail-yb0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754110AbeFLTyE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jun 2018 15:54:04 -0400
Received: by mail-yb0-f194.google.com with SMTP id p22-v6so62566yba.13
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jun 2018 12:54:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=8yHkdgVIpxTMHHgVUumack6HiMHlX/Yn6zXgyBVNaXY=;
        b=XbiFiFYSipFykKvlEwSHmpjAXjh8On7c3mE5VLQ340qeQ0LGjY3BUYa60IAKZTBuFE
         GG7/rrMC7tR8fWfkLbOIM0vd2TE9idHd14C9u8FkFbFT8c4xTYP4Az2sCWOY56AAhv6t
         SK7HICD1hM2VwtqkgR+f4w2Boo35ZKxTseNnI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=8yHkdgVIpxTMHHgVUumack6HiMHlX/Yn6zXgyBVNaXY=;
        b=NTxfChS32o3jrkm0QhbPkDU6YtcYnqcUGrsP247xsyJtYzKUb6XRzRyNWIfiIiUo2o
         91qAZJ9STAH8xRQDAufpFYSfEJyToS45HU+nGVh4FkUYu2hUTOYU/FMwKw6+jFpF+PJ1
         54dI8DzgM0WyfISo/h2IfTN5H6a3Itm5eGt8mjVx4pfh2Iw6mSl/aJp0+8ZmXoKTK9+W
         rhsgeWf5J6YSFxgbAZhM3SkRGUVDsbjHUnItOfVzQvFStT44YnPlXZMl0cUK4iNlbiXS
         1R0QPOzsTEaKCd7CY33Hoz9EEtCSudcflhNTSoPlgF0zWg5R6O3FX7llZVU95xsvYAWX
         V9xw==
X-Gm-Message-State: APt69E0Tg05a2II0yQtNwCMr/WK1D4vmRUWAMjqatHJEnGBx86Qpa+j2
        cVkMRswUPVk3DOK0tC9fkEWUXXDcjWS4HsigXJMrrA==
X-Google-Smtp-Source: ADUXVKLSSm1r7VYdEP0OEDmKq9znvaBdiELsAVuq3yyloonMoFSmWI6c9meXVS0kG4gZWSx5UHvWnmAIEQSc2hwEWFE=
X-Received: by 2002:a25:acd0:: with SMTP id x16-v6mr910636ybd.400.1528833243036;
 Tue, 12 Jun 2018 12:54:03 -0700 (PDT)
MIME-Version: 1.0
References: <20180608144834.3003465-1-arnd@arndb.de> <20180608181956.GA110395@decatoncale.mtv.corp.google.com>
 <20180611060819.GD5278@dell>
In-Reply-To: <20180611060819.GD5278@dell>
From:   Gwendal Grignou <gwendal@chromium.org>
Date:   Tue, 12 Jun 2018 12:53:51 -0700
Message-ID: <CAMHSBOU-f4oxR9kBkgYXOunRSUKx+cP3mJzmVKHnYJXfAzgHKQ@mail.gmail.com>
Subject: Re: [PATCH] mfd: cros_ec: remove unused __remove function
To:     Lee Jones <lee.jones@linaro.org>
Cc:     Benson Leung <bleung@google.com>, Arnd Bergmann <arnd@arndb.de>,
        Gwendal Grignou <gwendal@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Benson Leung <bleung@chromium.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Linux Kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 10, 2018 at 11:08 PM Lee Jones <lee.jones@linaro.org> wrote:
>
> On Fri, 08 Jun 2018, Benson Leung wrote:
>
> >
> > On Fri, Jun 08, 2018 at 04:48:06PM +0200, Arnd Bergmann wrote:
> > > This function is no longer called, so we get a harmless
> > > warning until it is removed as well:
> > >
> > > drivers/mfd/cros_ec_dev.c:265:13: error: '__remove' defined but not u=
sed [-Werror=3Dunused-function]
> > >
> > > Fixes: 3aa2177e4787 ("mfd: cros_ec: Use devm_kzalloc for private data=
")
> >
> > Gwendal, in PATCH v2 of https://patchwork.kernel.org/patch/10439449/
> > you mentioned that you readded the __remove to avoid a warning when bui=
lt
> > as a module. Can you explain what's going on?
>
> Yes please, and quickly.  I'm going to sent the patch-set today.  If I
> don't hear from you promptly, I'll probably pull the patch!
I readded it because when cros_ec_dev is loaded as module, I get a
warning on dmesg when unloading:

"""Device 'cros_pd' [or 'cros_ec'] does not have a release() function,
it is broken and must be fixed."""

The warning comes from device_release(). Given I get a warning when I
remove the release function or when I leave it empty. Let's pull the
patch.

Sorry for the confusion,

Gwendal.
>
> --
> Lee Jones [=E6=9D=8E=E7=90=BC=E6=96=AF]
> Linaro Services Technical Lead
> Linaro.org =E2=94=82 Open source software for ARM SoCs
> Follow Linaro: Facebook | Twitter | Blog
