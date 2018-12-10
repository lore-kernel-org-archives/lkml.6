Return-Path: <SRS0=GJN7=OT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54207C04EB8
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 22:41:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E4D2A2081F
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 22:41:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="BwfldLDE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E4D2A2081F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729606AbeLJWlU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Dec 2018 17:41:20 -0500
Received: from mail-ot1-f68.google.com ([209.85.210.68]:37808 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727903AbeLJWlU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Dec 2018 17:41:20 -0500
Received: by mail-ot1-f68.google.com with SMTP id 40so12125893oth.4
        for <linux-kernel@vger.kernel.org>; Mon, 10 Dec 2018 14:41:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6QO5FkdFrvOmB29K8zC59kisxltF23kVUGp0IVrwNB0=;
        b=BwfldLDE2UnFywDQwyonvVDxA10ngkDnsWkVQnGN2hnTCUO7YD9sjqXaBtKXehSpCa
         tltmJekrRFBU9VYtFV2Jgsy6AmkFJp6ctEmUCpKLBa2f0mRybHt63wY43r6PzpZfSWRg
         G/oGX8HII6cb3he9f++CnC91ceFUhB+KI+YHSE1NGgJggxxI0rbqLqyDdMtUo9i/cjVM
         4hX5VtcWUoUw39fqbwaaZ4MamD6XOoDQq0KNwFFiqlj6lVUi9pxLCOsrZArJlwm3Kv3Z
         pJJr64F9gvawc0u6dD7LDQktUL9vVKq1oSkJHJWDBTzevV1x2tpFVdOWFAgt3K60mrqw
         cBZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6QO5FkdFrvOmB29K8zC59kisxltF23kVUGp0IVrwNB0=;
        b=Fzz7OmEmHRrun4mhr8GV32zu1aR8UJbYDgJB3Y0SWuKYJcP0MPquiE/cO2iNN3Vnus
         fQmU2dyQ9UfpBQlAAQuCyl82OtRg4dy/y3Hu1v7GIrFKWIUWYmZQulSLoaWTwaqvpW3y
         oL4MpTzhA8fS9qImUP4JL4Rh5OuMqdF1StvWSWrQfq8LDiaR3kpOpnsTieRfybaKW3i4
         J6hGCLa7ooYyGRFci0nBu4pyOTyoZvNO7s/GF9ELzAn/LnoMHct5uCkba7SIPT0G9WO1
         h99dBgeI2wtRqs6EQYVkwbEsfJQy2Uk0Yr3T5g22r+F+6BE/oQcBVIR4t6Vbkh3MwTfV
         QXRw==
X-Gm-Message-State: AA+aEWY9hFuQoSYFr6oep4cMMe7qaF03eOktiIL094IlxkDkkynb2/UN
        mtzvWStB5aAYmoebJ02ALcKITzaqW0r+5SVw8HC9aw==
X-Google-Smtp-Source: AFSGD/W5AnPXmp/nrkUrkTx/8dkzrOlXifgKbRFWCTvLd1AR2wdsD43evxhZidHm1ru8Zi5anSJEE5sCRhCwvp4rty8=
X-Received: by 2002:a9d:5cc2:: with SMTP id r2mr9990013oti.367.1544481679140;
 Mon, 10 Dec 2018 14:41:19 -0800 (PST)
MIME-Version: 1.0
References: <154403054034.11544.3978949383914046587.stgit@ahduyck-desk1.jf.intel.com>
 <154403072403.11544.10419282512791659652.stgit@ahduyck-desk1.jf.intel.com>
 <CAPcyv4jH_Op-xHTd2FwQizPaWFx_2FE-pVsOLLmZAEK8EVPrYg@mail.gmail.com>
 <15b6817fd945a1622afe673b46b028bacefad72b.camel@linux.intel.com>
 <CAPcyv4i1RTrKYX0YpyCRE=pqt3pHBRiCGQq1wYUriLjKKTVA7A@mail.gmail.com>
 <bd92d0a3ff60097bf4424ff4c556a5369e66da6d.camel@linux.intel.com>
 <CAPcyv4jDG_2VwFr4oDGCURFrA=B0Bs2HGN9exLE47vDj0P3_8A@mail.gmail.com>
 <CAPcyv4hrML3SKnFP9UANC-hdTrpnOx4nWX=b-yhLsLuujL5oAA@mail.gmail.com> <00810f93b199c524378b5c963d49bd798c5d9843.camel@linux.intel.com>
In-Reply-To: <00810f93b199c524378b5c963d49bd798c5d9843.camel@linux.intel.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Mon, 10 Dec 2018 14:41:07 -0800
Message-ID: <CAPcyv4h0hk3VCCDSMNR72S9BWVMP514byGf3TWwp1Z7bQ2wi5g@mail.gmail.com>
Subject: Re: [driver-core PATCH v8 2/9] driver core: Establish order of
 operations for device_add and device_del via bitflag
To:     alexander.h.duyck@linux.intel.com
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        "Luis R. Rodriguez" <mcgrof@kernel.org>,
        linux-nvdimm <linux-nvdimm@lists.01.org>,
        Tejun Heo <tj@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux-pm mailing list <linux-pm@vger.kernel.org>,
        jiangshanlai@gmail.com, "Rafael J. Wysocki" <rafael@kernel.org>,
        "Brown, Len" <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>,
        zwisler@kernel.org, Dave Jiang <dave.jiang@intel.com>,
        bvanassche@acm.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 10, 2018 at 2:24 PM Alexander Duyck
<alexander.h.duyck@linux.intel.com> wrote:
>
> On Mon, 2018-12-10 at 13:23 -0800, Dan Williams wrote:
> > On Mon, Dec 10, 2018 at 1:15 PM Dan Williams <dan.j.williams@intel.com> wrote:
> > >
> > > On Mon, Dec 10, 2018 at 12:58 PM Alexander Duyck
> > > <alexander.h.duyck@linux.intel.com> wrote:
> >
> > [..]
> > > > Also the context for the two functions seems to be a bit different. In
> > > > the case of __device_attach_driver the device_lock is already held. In
> > > > __driver_attach the lock on the device isn't taken until after a match
> > > > has been found.
> > >
> > > Yes, I was only pattern matching when looking at the context of where
> > > dev->dead is checked in __driver_attach() and wondering why it was
> > > checked outside of __device_attach_driver()
> >
> > ...and now I realize the bigger point of your concern, we need to
> > check dev->dead after acquiring the device_lock otherwise the race is
> > back. We can defer that consolidation, but the larger concern of
> > making it internal to __device_attach_driver() still stands.
>
> I'm still not a fan of moving it into __device_attach_driver. I would
> much rather pull out the dev->driver check and instead place that in
> __device_attach_async_helper.
>
> The __device_attach function as I said took the device_lock and had
> already checked dev->driver. So in the non-async path it shouldn't be
> possible for dev->driver to ever be set anyway.

True.

> In addition
> __device_attach_driver is called once for each driver on a given bus,
> so dropping the test should reduce driver load time since it is one
> less test that has to be performed per driver.

Ok. You can add my Reviewed-by.
