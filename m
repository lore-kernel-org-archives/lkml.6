Return-Path: <SRS0=v2je=OV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AFCDC04EB8
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 13:49:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 47E8420849
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 13:49:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SVbC3QxD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 47E8420849
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727595AbeLLNtR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Dec 2018 08:49:17 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:34177 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726232AbeLLNtQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Dec 2018 08:49:16 -0500
Received: by mail-pf1-f196.google.com with SMTP id h3so8919159pfg.1;
        Wed, 12 Dec 2018 05:49:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=G3IFM2JRPfSXiwa3LwOgLbRyT371jKSCE6oz2U8s08M=;
        b=SVbC3QxDJNO7stR596KEpJ44JCvl7Wgdcmqr6rCHda+FiM9OvbsTs54gXHAG64kUWZ
         ms+oO/DABZSKuq9Qzq23Kabke2HtJvQtLRRjW7G8rVNrLL1Or542+NuNbqLjrAui+6Y8
         zLpFqzeQobSZ0C2F/impRi4EcT8PU86CUjwXkt4uCRyTE1ME1xs+2YLfGolKXcpD06dn
         e0vpJ4oPuPxEkzoeF8Df8dLFEO7uWdOkSNS9Xk/xlh9xLROGnAS+OyoaEyC7xgwVViKf
         7D4PwgnAOSX8lLOjG7sqGGUEAX38mGNmF47O69zydZisuD3Ogdt++4R/2BIU87jPmPJr
         +Cng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=G3IFM2JRPfSXiwa3LwOgLbRyT371jKSCE6oz2U8s08M=;
        b=X96yduEWEyMWOo8XZBpqTB1Ly3k9rCXaO+kke008LBjzW9D0gSFLuxFWE3e0cFq54e
         AkMjH0XnQsJf4XnOa+KOxlNxw3NZ/1co2Sf2EsRGkMNO31tUyAWXfsT9REDrCyWwgmZl
         DHv0Qy3rtWbDp53y8AsnM+YfsRfo2qGRHJa77acWlEPnHzTmfYT0wzSWzsWJyJhQU2w0
         eJZfXqpDBFiWINR0QlT/1wvakxdkaQFnbiyZ05dIwoINVXk0+bmBqUBI0bMvB+pRgbpP
         idBq2LwVHj8clx6t419gxLp9B1+CzeI4R/XME6Zuifd8IGX7qfmMg8UYMdiIlvlm8epp
         p8Ug==
X-Gm-Message-State: AA+aEWZ+Dur65v0jSHIb50tDduxkepXZho85gls4FprSm6IgtpMuKg6l
        EyzVabKGm/mN65XoZsYp46KPK8ph+pRAqV4MmXM=
X-Google-Smtp-Source: AFSGD/XXAi+9D08+lPS1O+rEF5LSv0GH9i1FbO1+5OKpr4jF258kSx59512K0FzNZAM5IWiobJolg6AoaAljWfKpdrQ=
X-Received: by 2002:a62:69c4:: with SMTP id e187mr20510631pfc.50.1544622555050;
 Wed, 12 Dec 2018 05:49:15 -0800 (PST)
MIME-Version: 1.0
References: <20181211060125.28671-1-ayman.bagabas@gmail.com>
 <20181211060125.28671-3-ayman.bagabas@gmail.com> <CAHp75VcNstKd3JW-D8QSQWez-TxrwsKrkA-a1D11kZW72fSqfw@mail.gmail.com>
 <757a7ce6ae8ea5f040fb7bb1bdf9768799d82a11.camel@gmail.com>
 <s5hh8fjutbx.wl-tiwai@suse.de> <CAHp75VfXJ_LDyWAqgMPPqFMKRcQ1E9FGm5uyobKN7D9ec9Qqyg@mail.gmail.com>
In-Reply-To: <CAHp75VfXJ_LDyWAqgMPPqFMKRcQ1E9FGm5uyobKN7D9ec9Qqyg@mail.gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Wed, 12 Dec 2018 15:49:04 +0200
Message-ID: <CAHp75Vd40zUUFcGjRmYoVE7ravo_CLsOoRVTS+x93iKh_VjpLg@mail.gmail.com>
Subject: Re: [PATCH v10 2/3] x86: add support for Huawei WMI hotkeys.
To:     Takashi Iwai <tiwai@suse.de>
Cc:     Ayman Bagabas <ayman.bagabas@gmail.com>,
        ALSA Development Mailing List <alsa-devel@alsa-project.org>,
        Hui Wang <hui.wang@canonical.com>,
        Andy Shevchenko <andy@infradead.org>,
        Darren Hart <dvhart@infradead.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Kailang Yang <kailang@realtek.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Platform Driver <platform-driver-x86@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 12, 2018 at 3:48 PM Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
>
> On Wed, Dec 12, 2018 at 8:56 AM Takashi Iwai <tiwai@suse.de> wrote:
> >
> > On Tue, 11 Dec 2018 21:10:07 +0100,
> > <ayman.bagabas@gmail.com> wrote:
> > >
> > >
> > > Do I need to resubmit?
> >
> > Yes, please.
> >
> > Andy, I think it's better to merge the series through my tree, as it
> > uses the new leds audio trigger stuff.
> >
> > Could you give ACK if the revised one is OK?
>
> For addressed comments
> Acked-by: Andy Shevchenko <andy.shevchenko@gmail.com>

And for the entire series

Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>

>
> >
> > Then I'll merge them to the immutable branch topic/leds-trigger, so
> > that you can merge to your tree cleanly, too.
> >
> >
> > thanks,
> >
> > Takashi
>
>
>
> --
> With Best Regards,
> Andy Shevchenko



-- 
With Best Regards,
Andy Shevchenko
