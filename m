Return-Path: <SRS0=lv5c=QW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8525C4360F
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 09:30:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ED416206B7
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 09:29:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="spDgNPA6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392818AbfBOJ3q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Feb 2019 04:29:46 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:43794 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732485AbfBOJ3o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Feb 2019 04:29:44 -0500
Received: by mail-pg1-f196.google.com with SMTP id v28so4534284pgk.10
        for <linux-kernel@vger.kernel.org>; Fri, 15 Feb 2019 01:29:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kaWnJNKr9NTavzFAdPTmHtk2WutcBvDlqbmQNt9lmcI=;
        b=spDgNPA6v5VoE+IaRxIdXEf9TcqjqsYbOoBtrrlQIJaIxggRW8mvS/N4vfxaD+k+JV
         9nSKCErew/CGW+2F/FI+nyCkfVolnVm3bbiNk/gJh1H2PsbS9PrGpXJk8/gkLksxIZTW
         kCzVvZUM5D6OI45swvHeXfx9ZZVQiknrJ3zK03H/BAj6PwiiCyBF85y2GtbJzvM6PvAn
         kbX5rTPZktWZ308vGwSxug028oyUgj/JVGvyLlrtZwZRCVW60VIR3q3AmQTiSsl4eJYn
         vHKT/36uMXiDi2YFQG/CGqUFPDmClwYCuXNqckNABFNaInsChYzicPLz2W0ou5yr/15t
         l48w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kaWnJNKr9NTavzFAdPTmHtk2WutcBvDlqbmQNt9lmcI=;
        b=fdPyxmhCf5Rx80OtvPa3yK2H2xSMWmu6gedBRUjxtDUOxKyMKSq43tCWKs03uf8x1P
         xbLtxBPkYbZyH2JjSvuCBQ9TFOyxGjJMt+l6j55K5aQV9Jyp+bVUk8jkj/ZFXqSc2bik
         IlEdi64fZH2lWuzrRrlY88wvitllCtgP+IK+Mo2U7Lqpw6pjmK9VlWDrh5BkLFSRWMFd
         Q0SrI1n8kEd8sJcdukguZU5LyYJXDA+qson7UJXtbMYsteZ+aRvdk3bbN57IO4e5q2Ke
         bbnlwjtKxd2b3yMXTWRKQKrSLxIxRpf30veJS1pS+eR8zyv2HVG+CbC5dXno5ZyoNOKx
         EX4g==
X-Gm-Message-State: AHQUAuYx0GnFUrt+UhShvpIMBVcc27u82GKjrjzTl7odLLJp7k2JsP5n
        x5h8f1Ulxz9b4M5ivEaMtWEe13Eh5pmpqrCA0vY=
X-Google-Smtp-Source: AHgI3IYwRN3uAk0SNm+1pyEV0Fz5IUrjEYoPCQdwv8okOuNg1Hjz9dBiXEa592xmMe19FMxgADaSn18hphO4gkEVxyM=
X-Received: by 2002:aa7:82d5:: with SMTP id f21mr8934582pfn.50.1550222983795;
 Fri, 15 Feb 2019 01:29:43 -0800 (PST)
MIME-Version: 1.0
References: <20190210203649.21691-1-jekhor@gmail.com> <7d226dcc-9b9c-941c-7915-53ca123fa3a5@redhat.com>
 <20190214124744.GT9224@smile.fi.intel.com> <CAKWEGV7SGDMttB6uHwnkyjWk+bmSmZ-vTSOXHg1UAgLBeqnaXw@mail.gmail.com>
 <1026e999-ecda-7866-6607-3c947a4cb483@redhat.com>
In-Reply-To: <1026e999-ecda-7866-6607-3c947a4cb483@redhat.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Fri, 15 Feb 2019 11:29:32 +0200
Message-ID: <CAHp75VfB3PMBH8qAyHJPfptd0POGq4pey3TkjzU6dZqZ_Vqt+Q@mail.gmail.com>
Subject: Re: [PATCH 0/2] extcon: Intel Cherry Trail Whiskey Cove PMIC and
 external charger tweaks
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Yauhen Kharuzhy <jekhor@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        MyungJoo Ham <myungjoo.ham@samsung.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 15, 2019 at 10:31 AM Hans de Goede <hdegoede@redhat.com> wrote:
> On 14-02-19 15:15, Yauhen Kharuzhy wrote:

> I would do something similar with the fuel-gauge in
> drivers/platform/x86/intel_cht_int33fe.c, one option would
> be to simply count the number of resources in the ACPI
> resource table for the INT33FE device, versions with
> the Type-C port have 7 resources, where as your INT33FE
> device has only 3.
>
> I'm even thinking that it might be best to rename
> intel_cht_int33fe.c to intel_cht_int33fe_typec.c and add
> a check for the resource table having 7 entries there, then
> you can make a intel_cht_int33fe_micro_usb.c copy and strip
> that mostly empty. Both would bind to the same "INT33FE"
> id and they would both silently bail with -ENODEV if the
> resource-count (or the PTYP value) don't match.
>
> The reason I'm thinking of having 2 drivers is because
> the current intel_cht_int33fe.c is quite special / ugly and
> already has enough ifs.
>
> If you do a stand-alone intel_cht_int33fe_micro_usb.c that can
> hopefully be much simpler.
>
> Andy what is your take on having separate intel_cht_int33fe_typec.c
> and intel_cht_int33fe_micro_usb.c drivers, both binding to
> the "INT33FE" ACPI-ID (with its totally !@#%$#-ed up "API") ?

Depends on how code would look better, though I care about users that
they will not get additional Kconfig option and broken their
configurations when new piece of code landed up. So, from mine, as
user, prospective, we may split driver as we wish, but we should get
it working as previously for the existing cases.

> Having 2 drivers bind to the same id and exit silently with -ENODEV
> is somewhat normal for USB ids where we also sometimes have these
> kinda ID clashes with different devices hiding behind the same id.

-- 
With Best Regards,
Andy Shevchenko
