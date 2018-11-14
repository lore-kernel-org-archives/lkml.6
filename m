Return-Path: <SRS0=v0ik=NZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AC44C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 08:45:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F35B8223DD
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 08:45:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VDWwsEME"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F35B8223DD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732028AbeKNSrv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Nov 2018 13:47:51 -0500
Received: from mail-qk1-f196.google.com ([209.85.222.196]:41880 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727154AbeKNSrv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Nov 2018 13:47:51 -0500
Received: by mail-qk1-f196.google.com with SMTP id 189so24339677qkj.8;
        Wed, 14 Nov 2018 00:45:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9JqiqffogSxkMzHC76vZq7ygx2uB8l06NSTchXosjBc=;
        b=VDWwsEMEP82pcGao2BGghgqrYhPkM5hYRFP7eDGGCIdNUBRJtF7Lk6EgbBwlz8V7p3
         YYnCemPYaV/aAz8sC2HPxWqZ6Sp8wnhKRA/nA8yx5voFQLDzOFTDxgtruEgF7PCZk/ES
         y2kACD6Z3qLFJRn7gkCv81yQh1P0I0bQjaAGkfSB04oEj1VchBtWUNazwvHlOfggSTtl
         8ietrJmS0gegB5j6TVODFhj1zr2tOySH2PVrmKH7LDMQByEU8UW6xQK4fskthFhBJ25O
         uMlHEG58aeupi0RXWG3jhpk6Y+UkWURYgFw2jeaNX4C1ADzCOM6/OC46Dec4ZG/RYDDC
         p35g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9JqiqffogSxkMzHC76vZq7ygx2uB8l06NSTchXosjBc=;
        b=ejY0MZrddR8GM55GT2GHq8UW8kaHAdhaLcQkXNvBwe7AuBmxfB5gG/HtjrmRtfUsHH
         xek1thPqilFO2jJESWtpWMWu6eAMgB4RoG34DByOSUxnxnKflsTjrlB6r+qAIoI97ruP
         I1GwHN4Noh8yQqLwMMXJqelZtlDbd89iHGVmRsvd2QKN/jlNdzY2bRLoRibLXm7xCHii
         VXkg+BKklLSjlrhHenOCXXiYEBseiUbS7XRw8BgT3C8JQglBnXwDvb60lBjF75kF6O35
         PYhGZqvFQ0ppNtFNy3Jw8jBann/m44Q2u8C4WP2ohd81wKp1dny+/igPjcDqPGpVK5oj
         oIcw==
X-Gm-Message-State: AGRZ1gL8waKU6YqfJ6V8tflfkRcXmZlU0jW2zoheVgeVUhmBgWUecKIt
        EyJYWHSk/1hhUZ9f+UBD4dzreNWZI9pf+W2jkhM=
X-Google-Smtp-Source: AJdET5dhdzbBuV1p0dsrB7qLgdPLnCqSGL17K2Q+3IpNBKL9SICSbrhXvrVBHr23Bu+7mxRjV5B5crOLKQjFxp8PHLQ=
X-Received: by 2002:aed:3b76:: with SMTP id q51mr844488qte.229.1542185133743;
 Wed, 14 Nov 2018 00:45:33 -0800 (PST)
MIME-Version: 1.0
References: <20181110181101.24557-1-andriy.shevchenko@linux.intel.com>
 <1c2c1031-a6b4-cbce-ceed-c2ce229c204e@ti.com> <20181114003345.GV2089@sirena.org.uk>
In-Reply-To: <20181114003345.GV2089@sirena.org.uk>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Wed, 14 Nov 2018 10:45:22 +0200
Message-ID: <CAHp75Vf7qozL8abZSh1gv_F3iSiZCprEK5_eGW=SRyUpjYrmtA@mail.gmail.com>
Subject: Re: [PATCH v1 1/5] drivercore: Revert "deferral race condition fix"
To:     Mark Brown <broonie@kernel.org>
Cc:     Peter Ujfalusi <peter.ujfalusi@ti.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        USB <linux-usb@vger.kernel.org>, Felipe Balbi <balbi@kernel.org>,
        Guenter Roeck <linux@roeck-us.net>,
        "Krogerus, Heikki" <heikki.krogerus@linux.intel.com>,
        rogerq@ti.com, Linux PM <linux-pm@vger.kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Sebastian Reichel <sre@kernel.org>,
        Linux OMAP Mailing List <linux-omap@vger.kernel.org>,
        Darren Hart <dvhart@infradead.org>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Grant Likely <grant.likely@linaro.org>,
        Andrzej Hajda <a.hajda@samsung.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 14, 2018 at 2:34 AM Mark Brown <broonie@kernel.org> wrote:
>
> On Mon, Nov 12, 2018 at 06:11:26PM +0200, Peter Ujfalusi wrote:
>
> > if we revert the commit then the original issue will re-surfaces. afaik
> > it was not only audio which hit the 'last driver to be probed from the
> > deferred list would never probe, unless we provoke the kernel to load
> > additional module, or remove/reload the module' issue.
>
> Right, aren't we just going to be swapping one bug for another?

Have anyone in possession of Davinchi tested most recent kernel with
this revert?

> > Do I understand correctly that in your case you have two modules
> > (dwc3-pci and extcon-intel-mrfld) in a deferred probe loop, iow both of
> > the drivers returns -EPROBE_DEFER and they just spin?
>
> > If both is deferring, how this supposed to work?
>
> I'm struggling to follow the original explanation too :(

Sorry, guys, I confused a nit myself. The bug is there, but
exxplanation is not fully corrent, indeed. I'll come back with more
details later.

-- 
With Best Regards,
Andy Shevchenko
