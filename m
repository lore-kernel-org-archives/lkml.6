Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A872BC282CD
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 16:02:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 785BE2175B
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 16:02:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UZvjHYj/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731156AbfA1QB7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 11:01:59 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:45423 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729309AbfA1QBy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 11:01:54 -0500
Received: by mail-pf1-f195.google.com with SMTP id g62so8164203pfd.12;
        Mon, 28 Jan 2019 08:01:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=enNVGkt9XDJEL3W1otIblCYmxiA/11Y68u0rYJ68T+U=;
        b=UZvjHYj/10tnpz1w6iWx5p+RfcdWFv61HQwrEqiR4P2NTarn3cus8cBk8KOjSo3J94
         lApmfTJZBjfKHVLcT1Kf0Pkj/6ib6bVNMqgzR9U1cX5BR8wOMGVzTvUFk3T3ZKzB+LJA
         4py1EcbSSkXIFzA7hfI6+48ujLTQ5bHx8g8JTXZ8jkCNW/N6NaqqHT0hUI0H6A6xlE9c
         VbYT5Xx7Xs+JQr7DUiLBMmReCXCA7Siivlrh6FDiPMQpIBO43FmnC5ysbHX983NwaaFL
         oEG2MLv+NrZm4xu3i/UdEGnDuSv3D+SpPQcU2pwaznUNx0JYEvG3RZyFSnWnVYFHCMZ4
         yMkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=enNVGkt9XDJEL3W1otIblCYmxiA/11Y68u0rYJ68T+U=;
        b=kkn+7GEhbQPdbw45Gh91mndmke/53VFVhW97iwRxdNcMojkDzQIMN8CXSGgV2ZyDeY
         VI5toeZb4qBV6bOYdQdQhZEg4Esr/eZRa4twI7YyIiqK0+wAma2RrSF1mguykZ3AA5I6
         EMpJHFXLbeXh4YI0tZJXInWyhB8rNQ824jpRu1PatZytNmUuWMN1ifFhP49y6OBZQPbw
         6uRnHtjwfWcfvQMsOonO2EH+iNGdqzbOr9S8KZjPK3dc+y+w5NeRCU5rn8pN2XuyGo2u
         QrYujOBfwrbOGeF7K1115BUgzjV3n6g1IiE625nymIu0kzga3aeqJfk9MwJine3t4FC4
         VMVg==
X-Gm-Message-State: AJcUukf7dReB2NaC2BB61HJ1DJ9bThhbjaIwYa3vyyADawHYV52jA8rj
        72jaGhpbBQRA/RXaBMHDBZaBS6yMFbYtHlItEkLNdb1u
X-Google-Smtp-Source: ALg8bN6nMFxYKoEJWlT4/iBkNPzvG4tfh6a8YgoLtQPzHiiq0SNLQ/U51KszLZO/yyrVvDmZ3fDzlIiFGzxYm6Dxja4=
X-Received: by 2002:a63:20e:: with SMTP id 14mr20241414pgc.161.1548691313263;
 Mon, 28 Jan 2019 08:01:53 -0800 (PST)
MIME-Version: 1.0
References: <cover.1548610407.git.2pi@mok.nu> <b40da7d75a8cf02f78db7896e07859e315477120.1548610407.git.2pi@mok.nu>
 <CAHp75Vdsr8aY1ODpZUqR--jAfgRowJz8tbSGwS1SFTH-W4u0XA@mail.gmail.com> <20190128135437.qetbebros3xkayyn@mok.nu>
In-Reply-To: <20190128135437.qetbebros3xkayyn@mok.nu>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Mon, 28 Jan 2019 18:01:42 +0200
Message-ID: <CAHp75Vco3sCDVC6QTf8FbOpwzOtoAO699fvdSCJv7G8HOVZEjg@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] platform/x86: wmi: move struct wmi_device_id to mod_devicetable.h
To:     Mattias Jacobsson <2pi@mok.nu>
Cc:     Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 28, 2019 at 3:55 PM Mattias Jacobsson <2pi@mok.nu> wrote:
> On 2019-01-27, Andy Shevchenko wrote:
> > On Sun, Jan 27, 2019 at 9:04 PM Mattias Jacobsson <2pi@mok.nu> wrote:

> > > +#define WMI_GUID_STRING_LEN    36
> >
> > Isn't this already defined in UUID namespace?
> > (include/linux/uuid.h IIRC)
>
> Kind of, UUID_STRING_LEN is defined in uuid.h. It is included behind a
> #ifdef __KERNEL__, but others seam to use things included through it so
> I guess it is alright...
>
> Let me know how you want it.

On one hand I think too many places with the same information is not
good. On the other hand WMI might change this limit in the future and
on top of this it seems you are sharing it with user space.
However, file2alias.c includes kernel header directly and uses a
duplicate definition for cases !__KERNEL__.

So, I would do that way.
Use in mod_devicetable.h the definition from uuid.h (which is already
included there), and duplicate the same definition in file2alias.c in
the way it's done for the rest UUID stuff there.

> > >  #include <linux/acpi.h>
> >
> > > +#include <linux/mod_devicetable.h>
> >
> > Not sure it's needed since acpi.h includes that.
>
> It is included in acpi.h(behind CONFIG_ACPI), I thought it was cleaner
> with it included explicitly. Plus that we aren't relying on others to
> include it.
>
> Let me know how you want it.

Since it's minor, it's up to you. Ideally we would better to split out
that inclusion from acpi.h and explicitly do this in all similar
cases, but it's not ours call here.
That said, your variant is okay.

-- 
With Best Regards,
Andy Shevchenko
