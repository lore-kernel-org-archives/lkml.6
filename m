Return-Path: <SRS0=3sEf=MI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60054C43382
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 17:10:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E12142150B
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 17:10:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="vXzXcoJb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E12142150B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728724AbeIZXYl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Sep 2018 19:24:41 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:35700 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726937AbeIZXYl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Sep 2018 19:24:41 -0400
Received: by mail-qt1-f194.google.com with SMTP id z14-v6so13055164qtn.2;
        Wed, 26 Sep 2018 10:10:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=UqsZ50gsEsMPkg4JVh0IrkGsmEX3d9KsNG31A9HIiVg=;
        b=vXzXcoJbr2UBRwYYlkF1oni4lx0FW9p1u6OtbXMR27bkeEAbdocdpZPtm6FgOXCtP7
         S9wWJybBKhpWOJR6thSOgwR/YS1OpiHvr18CdS0G/cMwTdWOolvV4UPPIzRSOz77hma+
         knHVQ/cAMNkBlhj3tPA+7Jc4KSz9LNDB5P6x3LI6tQ0HsAU+ccxxdndMBhNHFG5M6cZc
         t6Y07yQka2IleaAVxt4bvqPX5aLcw0J5Qvqy1D8WCWO8Cg5V+2br5MuZT19U+iIyc9Fw
         KDuFuPInBN79CHv6pQHWXPSp1eXK1bwOyckJfyX1fZGiM1t2rMmKufPCu4/aWQeqDdcY
         /Ueg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UqsZ50gsEsMPkg4JVh0IrkGsmEX3d9KsNG31A9HIiVg=;
        b=V6eK3/vngpAtYm+iLz287tw+3koOXgurPCY+WUAwf/oc4qy6C/TZiyVje+t9Yo6As/
         BxGagVkHYvLJdWo1pl+mUMbENSSKQPccFzmjqYUlHntYpcqIZ79N2vMRO2xMnGLAs+HV
         1OisbdXC/hLnq+X+KOffuKT//J8dTRc3acYNEpU2a7/1qJJPovxFoufDvOpuWbb7q0I6
         hgor3SbFCtiGMAHVNIEruQ5QbRkcW/ut5yZXdPvIJtMPWQFsO7RiMGHwUtWdufll+6nj
         5M0vMCm372qj7Fm//quhP4sq55lht2ln+W4zAQydV9sBNcKwxhKYq390gdO0vzMUYihE
         Q9Rg==
X-Gm-Message-State: ABuFfogwK4n6wOXfXEG5DrADqs6Z+KCSl2tL7M+AYuMqLWvoXVFE73TT
        YE2ami7vkkgNIuHmQCV2r96cQTckoBssTHuggcs=
X-Google-Smtp-Source: ACcGV62jFTGwcJHdQoePWq1++TKViPySa7xXqBQjptiVhZUfHx3CDKfFJTAGZi1en//a9UcB49z9NiljsR0pXLYY4bk=
X-Received: by 2002:ac8:29ef:: with SMTP id 44-v6mr5105088qtt.174.1537981845523;
 Wed, 26 Sep 2018 10:10:45 -0700 (PDT)
MIME-Version: 1.0
References: <1537978258-2907-1-git-send-email-mario.limonciello@dell.com>
 <CAHp75VeGQTEZOrMbNsbsxSb4RcN1y=gAZuZ5Z6FawuU-e0+qcg@mail.gmail.com> <72af799dd45442e6bd35082e1579013a@ausx13mpc120.AMER.DELL.COM>
In-Reply-To: <72af799dd45442e6bd35082e1579013a@ausx13mpc120.AMER.DELL.COM>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Wed, 26 Sep 2018 20:10:34 +0300
Message-ID: <CAHp75VcMDbiOhGzm7oXZ2jPcxe494YhSRFVzQtbUNj0ugUZfrQ@mail.gmail.com>
Subject: Re: [PATCH] platform/x86: intel-wmi-thunderbolt: Add dynamic debugging
To:     Mario Limonciello <Mario.Limonciello@dell.com>
Cc:     Darren Hart <dvhart@infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        Mika Westerberg <mika.westerberg@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 26, 2018 at 8:03 PM <Mario.Limonciello@dell.com> wrote:
>
> >
> > On Wed, Sep 26, 2018 at 7:11 PM Mario Limonciello
> > <mario.limonciello@dell.com> wrote:
> > >
> > > Some users have been reporting issues with thunderbolt being turned off
> > > before fully initialized.  This is suspected to be caused by userspace
> > > turning off the Thunderbolt controller using intel-wmi-thunderbolt
> > > prematurely.
> > >
> >
> > > Details are available here:
> > > https://bugzilla.kernel.org/show_bug.cgi?id=201227
> > > https://bugzilla.kernel.org/show_bug.cgi?id=199631
> >
> > BugLink: ... ?
> > BugLink: ... ?
> >
> > I can do it myself if you are okay with this format.
> >
> > The patch itself LGTM.
>
> Sure, thank you.

Pushed to my review and testing queue with mentioned changes, thanks!

>
> >
> > >
> > > Userspace has already made some mitigiations for this situation:
> > > https://github.com/hughsie/fwupd/commit/ef6f1d76983c9b66
> > > https://github.com/hughsie/fwupd/commit/c07ce5b4889a5384
> > >
> > > To allow easier debugging of this situation add output that can be turned
> > > on with dynamic debugging to better root cause this problem.
> > >
> > > Suggested-by: Mika Westerberg <mika.westerberg@intel.com>
> > > Signed-off-by: Mario Limonciello <mario.limonciello@dell.com>
> > > ---
> > >  drivers/platform/x86/intel-wmi-thunderbolt.c | 6 +++++-
> > >  1 file changed, 5 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/drivers/platform/x86/intel-wmi-thunderbolt.c
> > b/drivers/platform/x86/intel-wmi-thunderbolt.c
> > > index c2257bd..ce5fbf0 100644
> > > --- a/drivers/platform/x86/intel-wmi-thunderbolt.c
> > > +++ b/drivers/platform/x86/intel-wmi-thunderbolt.c
> > > @@ -38,12 +38,16 @@ static ssize_t force_power_store(struct device *dev,
> > >         input.length = sizeof(u8);
> > >         input.pointer = &mode;
> > >         mode = hex_to_bin(buf[0]);
> > > +       dev_dbg(dev, "force_power: storing %#x\n", mode);
> > >         if (mode == 0 || mode == 1) {
> > >                 status = wmi_evaluate_method(INTEL_WMI_THUNDERBOLT_GUID, 0, 1,
> > >                                              &input, NULL);
> > > -               if (ACPI_FAILURE(status))
> > > +               if (ACPI_FAILURE(status)) {
> > > +                       dev_dbg(dev, "force_power: failed to evaluate ACPI method\n");
> > >                         return -ENODEV;
> > > +               }
> > >         } else {
> > > +               dev_dbg(dev, "force_power: unsupported mode\n");
> > >                 return -EINVAL;
> > >         }
> > >         return count;
> > > --
> > > 2.7.4
> > >
> >
> >
> > --
> > With Best Regards,
> > Andy Shevchenko



-- 
With Best Regards,
Andy Shevchenko
