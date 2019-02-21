Return-Path: <SRS0=r0+/=Q4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E5F0C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 14:22:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DC055206A3
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 14:22:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aVHoCajm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727939AbfBUOWM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Feb 2019 09:22:12 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:36322 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725880AbfBUOWL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Feb 2019 09:22:11 -0500
Received: by mail-pg1-f194.google.com with SMTP id r124so13773211pgr.3;
        Thu, 21 Feb 2019 06:22:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WvCVIvvVsBYPOmoDqOf5fUpXnAadEGUB6JGYeFd+aNM=;
        b=aVHoCajmnnlAJichgykZf1j4IYZJ7C/NwKclKiAyWP51iJLzZx3KwPYd/DV+HMShe3
         ZnRwkMYogGVYEgT3p8IdP249Zv6g39dyaF4zMaZmHdgGsZpH6HTk07f1hKu7Eyhd9tBW
         GgTWohYiso+2NoS1M+C/eQ1d3/5SdBKg6oeA7oy7MtJB9X0F0AMRJ2eAm+dZf3OkXvRg
         26ZpGa9OEfeJVi/CjXkWQ8isDpBd6tq45NY/EBXxpgCA380LszhXp9+D3h17HTCuYmg6
         bmjdvII75qo0jVLAMD+Zk5uxm85xpynsouOG7Ppn4dpNcnJRbRC0YYyckOA6Fl29rgkE
         LwbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WvCVIvvVsBYPOmoDqOf5fUpXnAadEGUB6JGYeFd+aNM=;
        b=rCbL5ODX0dPFbxUr2anrZqmP/vm1KJ4Vc0dBD9iov8Ddvnkv4nJoXlsalo0ooTRtak
         BssTMmUNO//DWA75CmiMlA6lfVkVITjCxIDQpNVIHFxnZ+NmDJ54PLZpSOYTIGHRYxUo
         PHUVgHmcWlnoT+a7jlmfs2iHdVbFTr8f8e3pC3N4jwiQkV4jrGZ4Hl05ty/2o+Umc5rA
         Ehb4tVjkKlE12tKr7IXcdMNEb0BXuG+s79n9Ny0xok9hCNuIxusUNxSpwOI2SKGGLktI
         qlkSb2A5N4RsG6tUKT9M+vK2zYUil4sQZM9QCr5+mK//vJidsec9+bt/9e3EtHh94YtY
         D3fA==
X-Gm-Message-State: AHQUAuadQy3aV3ex2wwFfbOML+fC4RERrKZBybC2Md+HtiNctsKxyKoG
        WX3WkwTc5qj7fd0BYrV0mRLUGHv7Cp3m22QOvH4=
X-Google-Smtp-Source: AHgI3IZUvFMg2Qi949pn3KvRaV9vLO23oBmHdtbMkxoifqMUkVWaujrUVio2wf2xibtygzGe6B8DrW+ByLQGDBefxs8=
X-Received: by 2002:a63:1a25:: with SMTP id a37mr20873674pga.428.1550758931112;
 Thu, 21 Feb 2019 06:22:11 -0800 (PST)
MIME-Version: 1.0
References: <20190219115959.55553-1-heikki.krogerus@linux.intel.com>
 <20190219115959.55553-2-heikki.krogerus@linux.intel.com> <CAHp75Vca+yNuNJaAuB_2_5Vgq8+0FvrBWS1VbvqhAr0nq1UYPw@mail.gmail.com>
 <20190221135641.GG5054@kuha.fi.intel.com>
In-Reply-To: <20190221135641.GG5054@kuha.fi.intel.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Thu, 21 Feb 2019 16:21:58 +0200
Message-ID: <CAHp75VeVKs=Knu-H34qY5EmUgKd61+yQ5QbkOrOGv+3Nv+yW_g@mail.gmail.com>
Subject: Re: [PATCH 1/2] platform/x86: intel_cht_int33fe: Provide fwnode for
 the USB connector
To:     Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc:     Andy Shevchenko <andy@infradead.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Darren Hart <dvhart@infradead.org>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 21, 2019 at 3:56 PM Heikki Krogerus
<heikki.krogerus@linux.intel.com> wrote:
> On Thu, Feb 21, 2019 at 03:46:46PM +0200, Andy Shevchenko wrote:
> > On Tue, Feb 19, 2019 at 2:00 PM Heikki Krogerus
> > <heikki.krogerus@linux.intel.com> wrote:
> > >
> > > In ACPI, and now also in DT, the USB connectors usually have
> > > their own device nodes. In case of USB Type-C, those
> > > connector (port) nodes are child nodes of the controller or
> > > PHY device, in our case the fusb302. The software fwnodes
> > > allow us to create a similar child node for fusb302 that
> > > represents the connector also on Intel CHT.
> > >
> > > This makes it possible replace the fusb302 specific device
> > > properties which were deprecated with the common USB
> > > connector properties that tcpm.c is able to use directly.
> > >
> >
> > This doesn't apply to our for-next branch.
>
> Please read the cover-letter ;-)

Ah, sure.
I did it once and even remove from our patchwork queue, but then
forgot details. Now it's all clear.

-- 
With Best Regards,
Andy Shevchenko
