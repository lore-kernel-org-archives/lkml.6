Return-Path: <SRS0=wzyR=PL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 251ECC43387
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 17:39:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E132D208E3
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 17:39:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546537151;
	bh=6DZzW66VVPYYwKb351IgdGl4LhNRguOE3nUFacZsWeU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=yLp0uoqN4t7qH45jh9FPRB5OrCF4eiI3k5eO0+LzHc77yVSbajcdr8jgAD3zkaRUP
	 B+W7k62j1RrwBLQPHCG1G2/2U0HlPiHH6/XHY7x9l1PTuZBG8jw0wvhnk7UCqzenlz
	 SF3uF2KE6Ei6GDlScoCRPvxnHAk/VLQYzsOykxnM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731824AbfACRjK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Jan 2019 12:39:10 -0500
Received: from mail-oi1-f195.google.com ([209.85.167.195]:41628 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730952AbfACRjI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Jan 2019 12:39:08 -0500
Received: by mail-oi1-f195.google.com with SMTP id j21so28297779oii.8
        for <linux-kernel@vger.kernel.org>; Thu, 03 Jan 2019 09:39:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6DZzW66VVPYYwKb351IgdGl4LhNRguOE3nUFacZsWeU=;
        b=mcm8OqJcro+0QRRSV/mNmAKEIkg16D/5QgTycukMzTot8v0dZIDZdMuqQtdfmpjAjg
         XZmUcZ1XOwfQUjuh3HDJLL5mLqBVTBLkCA7WtKFrsq3P4vbUQ7zdz1zGvDKF8xdWZulI
         LBy+hs/Vqxt6EnwUV8/AA8j9fzVXRPwDfN9l2rdY2/sR5N314pQmnAy+QGLgaHg9OfW6
         s4bb1D01TteILJt2cnOS0rFHk86UR0GLE7tYKLnAFlFixagPK5luKWpxVwGZBBUSwfUO
         8Xfs253asZB8pLhReueu/YtCWOZONsQLhp3j2pJ/qWW8Pf+bBR+uDuZDXmPo5ExybKRx
         wjnw==
X-Gm-Message-State: AA+aEWZyjVnGbzsKfZTBiLhCZwRiMRAPzCTBCL4lIFrkncohtMNq0KjY
        9ydaiuJeis88Yo8nqhdpemR+SBMTz0sKzLH9bBk=
X-Google-Smtp-Source: AFSGD/UD4eLUSYW8g1hpqewFWE2ZnhqNgvnUEyJetkcbPYNbBLNt6H2GhhBH0q6UiJABrf+9L6Et7H9vdjIZNiUTTgU=
X-Received: by 2002:aca:195:: with SMTP id 143mr30684057oib.322.1546537146567;
 Thu, 03 Jan 2019 09:39:06 -0800 (PST)
MIME-Version: 1.0
References: <CABGGisxcHWwhUcQML7XmriK_DLFGjmud3cKt8yp+K4G2CAL=9Q@mail.gmail.com>
 <20190102185106.56913-1-swboyd@chromium.org> <CAJZ5v0iL_Fq0RUbLjMj9WBitDw2amNV_ybirkiPbuYb0zroGAg@mail.gmail.com>
 <154653191998.15366.14229484132412159772@swboyd.mtv.corp.google.com>
 <CAJZ5v0hwhuerPoizdYjqNkdymxubOweZ3JhPiXRUcrNtByz_=Q@mail.gmail.com> <154653631992.15366.980047163353936345@swboyd.mtv.corp.google.com>
In-Reply-To: <154653631992.15366.980047163353936345@swboyd.mtv.corp.google.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 3 Jan 2019 18:38:55 +0100
Message-ID: <CAJZ5v0jj13UgkM+7ad8-17W_4cdOJw61FMyvshBAcybzaiea5A@mail.gmail.com>
Subject: Re: [PATCH v3] driver core: platform: Add an error message to platform_get_irq*()
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Mark Brown <broonie@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        javierm@redhat.com,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Russell King - ARM Linux <linux@armlinux.org.uk>,
        Marek Szyprowski <m.szyprowski@samsung.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 3, 2019 at 6:25 PM Stephen Boyd <swboyd@chromium.org> wrote:
>
> Quoting Rafael J. Wysocki (2019-01-03 09:22:56)
> > On Thu, Jan 3, 2019 at 5:12 PM Stephen Boyd <swboyd@chromium.org> wrote:
> > >
> > > I don't see much benefit to seeing -ENXIO or -EINVAL printed here, so I
> > > left out the error code.
> >
> > OK, so the value of the message is to tell the user that some driver
> > asked for an invalid IRQ, right?
>
> Yes.

OK

This can help to reduce code duplication a bit, so

Reviewed-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

for the v3.
