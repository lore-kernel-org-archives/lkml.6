Return-Path: <SRS0=p5KC=ON=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDDF2C04EB9
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 01:15:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 95BB320850
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 01:15:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MmGSMF/y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 95BB320850
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726074AbeLDBPg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Dec 2018 20:15:36 -0500
Received: from mail-it1-f193.google.com ([209.85.166.193]:52495 "EHLO
        mail-it1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725995AbeLDBPg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Dec 2018 20:15:36 -0500
Received: by mail-it1-f193.google.com with SMTP id i7so12651901iti.2;
        Mon, 03 Dec 2018 17:15:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lvIMcZstxPuvW/MRjmZbRUzns2Pk9TTnIKTz7yKdmNw=;
        b=MmGSMF/yxb0TUlCq0R7Hky7sJf1cjMMj/pqVZR41qsQfrwMxW8ZapCdNhav5pXm03P
         F3zfTfs/vA+47Ij+HBsQJg7ODlUAyn1phSuAC83yNC6w2AgYedKyLn8dQM0TI+G2DIpD
         YSMGuf+CDjS5r0OLvWKvD7NOQ+I5ggDmzSSTD1CTExqF8K1gdKAvW3tJJx7p71E0i8Ss
         6tajQCIwh6hqx4SuWIUx9lsZ+arW7bDaRXTYn7yuk5PmJ05vAz52b/SRGUC8hnlkz+Rj
         Xr0aNFhvYmeuC94+ONnlPK37wYPv3SMkheV/LUZ32qLO1iYWyOvDRZUV29GXmWB9Q47P
         3SHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lvIMcZstxPuvW/MRjmZbRUzns2Pk9TTnIKTz7yKdmNw=;
        b=oFpcZutec957imOGios/hcSkXL5w/dM5F9/F4rBZiENkVh17tnLOAeoPIv4qt79IA5
         sGnODS/fc5Bz9bNV+HRoqNxIPnTOqhbpl0wRyYFD/ej1xujPlXkLos13eLtlM/JN3QVj
         5vtkmi7st1Vkd1iaa7e+Kr0cVokMjLgx9lE0GvrX9sBd2bmNtFj5YfmA0OOQKMQ7Cc7X
         HiivUX584tlqkq5XbiyOnlvLCH6RV4OJOSOiOG0jnycJ4TTCuy7cNSYgXRfWTzGIHRb8
         6kcFyA7MYUpkogdxz9cmRq44tLmi0WDcD3meHYGJOSh9HJj5K1xEdkD3TtW3ByEpPMAw
         1Pmw==
X-Gm-Message-State: AA+aEWa4DlGBIsV1SeUUxxvk/B0OEBdz7BoMuZnIZrDwohrgDuV+OudL
        WsN2Rf0tEowLWE3O1oaHTCd+pum7ka6nc7JZvTA=
X-Google-Smtp-Source: AFSGD/WI+oNGM/6xgsbQ1UnCf55i1VlG42NOucgiIcIheWSCqeb9hmj+mv7nhG4QW+wxqYbfB6fkbt3YRMa6u4aOP7M=
X-Received: by 2002:a02:5184:: with SMTP id s126mr15922586jaa.12.1543886133841;
 Mon, 03 Dec 2018 17:15:33 -0800 (PST)
MIME-Version: 1.0
References: <20181130142557.2623-1-tiny.windzz@gmail.com> <CAJZ5v0hPPWx6ZbTPRLRMj_0zSF91ApS3BWgYGj31GqzhX45sYw@mail.gmail.com>
In-Reply-To: <CAJZ5v0hPPWx6ZbTPRLRMj_0zSF91ApS3BWgYGj31GqzhX45sYw@mail.gmail.com>
From:   Frank Lee <tiny.windzz@gmail.com>
Date:   Tue, 4 Dec 2018 09:16:06 +0800
Message-ID: <CAEExFWuZmcTLF+hFahucUuHzp81OXTxm5sJu_AooCz+jZJUnvA@mail.gmail.com>
Subject: Re: [PATCH] cpufreq: nforce2: Remove meaningless return
To:     rafael@kernel.org
Cc:     rjw@rjwysocki.net, Viresh Kumar <viresh.kumar@linaro.org>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 3, 2018 at 5:14 PM Rafael J. Wysocki <rafael@kernel.org> wrote:
>
> On Fri, Nov 30, 2018 at 3:26 PM Yangtao Li <tiny.windzz@gmail.com> wrote:
> >
> > In a function whose return type is void, returning on the last line is
> > not required.So remove it.Also move the module declaration to the end.
>
> The last piece is not reflected by the subject.
>
> Also, why do you move the MODULE_ stuff around at all?
When writing a driver, in most cases MODULE_  are put to the end.
Why not modify this? it is more in line with the habits of most people.

Yours,
Yangtao
>
> >
> > Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
> > ---
> >  drivers/cpufreq/cpufreq-nforce2.c | 11 ++++-------
> >  1 file changed, 4 insertions(+), 7 deletions(-)
> >
> > diff --git a/drivers/cpufreq/cpufreq-nforce2.c b/drivers/cpufreq/cpufreq-nforce2.c
> > index dbf82f36d270..ccff1f2a7c25 100644
> > --- a/drivers/cpufreq/cpufreq-nforce2.c
> > +++ b/drivers/cpufreq/cpufreq-nforce2.c
> > @@ -47,10 +47,6 @@ static int fid;
> >  static int min_fsb;
> >  static int max_fsb;
> >
> > -MODULE_AUTHOR("Sebastian Witt <se.witt@gmx.net>");
> > -MODULE_DESCRIPTION("nForce2 FSB changing cpufreq driver");
> > -MODULE_LICENSE("GPL");
> > -
> >  module_param(fid, int, 0444);
> >  module_param(min_fsb, int, 0444);
> >
> > @@ -123,8 +119,6 @@ static void nforce2_write_pll(int pll)
> >         /* Now write the value in all 64 registers */
> >         for (temp = 0; temp <= 0x3f; temp++)
> >                 pci_write_config_dword(nforce2_dev, NFORCE2_PLLREG, pll);
> > -
> > -       return;
> >  }
> >
> >  /**
> > @@ -436,6 +430,9 @@ static void __exit nforce2_exit(void)
> >         cpufreq_unregister_driver(&nforce2_driver);
> >  }
> >
> > +MODULE_AUTHOR("Sebastian Witt <se.witt@gmx.net>");
> > +MODULE_DESCRIPTION("nForce2 FSB changing cpufreq driver");
> > +MODULE_LICENSE("GPL");
> > +
> >  module_init(nforce2_init);
> >  module_exit(nforce2_exit);
> > -
> > --
> > 2.17.0
> >
