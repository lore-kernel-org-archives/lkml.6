Return-Path: <SRS0=OQFz=KL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67A1AC6778F
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 17:02:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 19912208B3
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 17:02:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="MesFzsBo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 19912208B3
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388874AbeG0SZJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Jul 2018 14:25:09 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:37913 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730510AbeG0SZJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jul 2018 14:25:09 -0400
Received: by mail-wm0-f66.google.com with SMTP id t25-v6so6178803wmi.3
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jul 2018 10:02:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=pd8oAo0UR1IEBOUY2nlnpzU7L5g2B1zTEkOTlwLHaAk=;
        b=MesFzsBorAhUdswqwgeYqf1K5kiJ1pzrZImOdjmhpTKPMEMm9FFDbMc4bipRFs2hqE
         5atfd/yEK5HOuT6Kg/CpO81U8G5flULHxKn2XpzFRbpIWZTjfobvAk4lXyA5GZNqKsCy
         MiI+CviLUmOjuZ0uF5KwsoghddSsUMWVrm2HSN1NJgRYp5cKtvVXvOmwMzFpM6buARDL
         YMjW7Fx9bu3AmAFOASHPVv1Rc/Kx2z+//znOjE8PZa1CGZ8O9KHxwvoAu/Hv1x3ktK/V
         4g7DFacxZ/4WIbRmYQigVcQevN4TfdAta4hetg7iGNu5vgJ8jgXmusU8W1Kyp5hihvah
         RV1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pd8oAo0UR1IEBOUY2nlnpzU7L5g2B1zTEkOTlwLHaAk=;
        b=Qi5oMhN6/S5B+dc16b7VvbzB6NaPxCHcwgZosxRGoz6v7d52Vwb4tlmoXdr98wVvHK
         L/+dMgwqf0sWu/tTeYOpINvKrr5v6gi4qehvtS7jbzGyLV1pRSWedY4v+BhI0M3mjMiS
         OnIM7S/xYoxuxXqDqBPEi4VelDd/dav2Cn9vLGbxQmwJKhcwAxuc+e1muelxQOA9h/MT
         AdemubsrNCphLxpf2NP4XiiYv687lAOS/srvNDOGKeS75yVi1oYfsskcYnkeYm5tfdRQ
         kEsCxj4trSSE6fsRVs+Yj4jhAyJilBykQmgPt7yyS41uu1lYrWnH7TWnuVkdNTlydDqU
         pluw==
X-Gm-Message-State: AOUpUlHhOVF3w/mWJS8F0xYcRcCNFT2l7gMGV1zRH+zrD2Lxia7jRlLJ
        gek2Gg0B7gr+pAhbUEMdq/26EuOwyxFRwCYNrDFySw==
X-Google-Smtp-Source: AAOMgpcNO0u2RSeIynBMA8/72GBGAbmfLiSu64/phJDXy1YiHbXr2cJ3Rvc5Tj5posZXUxAQL2pAf2lvV38dWbEv53Q=
X-Received: by 2002:a1c:2807:: with SMTP id o7-v6mr4666543wmo.11.1532710941639;
 Fri, 27 Jul 2018 10:02:21 -0700 (PDT)
MIME-Version: 1.0
References: <20180727030737.231268-1-toddpoynor@gmail.com> <20180727030737.231268-2-toddpoynor@gmail.com>
 <20180727150855.GB3713@kroah.com>
In-Reply-To: <20180727150855.GB3713@kroah.com>
From:   Todd Poynor <toddpoynor@google.com>
Date:   Fri, 27 Jul 2018 10:02:09 -0700
Message-ID: <CAAW3YpaX6fNq2TCsu6cbgYkLsd8vHdZ0Wz+0+WkkHiL5UKjmcw@mail.gmail.com>
Subject: Re: [PATCH 01/10] staging: gasket: save struct device for a gasket device
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     "toddpoynor@gmail.com" <toddpoynor@gmail.com>,
        Rob Springer <rspringer@google.com>,
        John Joseph <jnjoseph@google.com>, benchan@chromium.org,
        devel@driverdev.osuosl.org, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 27, 2018 at 8:09 AM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Thu, Jul 26, 2018 at 08:07:28PM -0700, Todd Poynor wrote:
> > From: Todd Poynor <toddpoynor@google.com>
> >
> > Save the struct device pointer to a gasket device in gasket's metadata,
> > to facilitate use of standard logging calls and in anticipation of
> > non-PCI gasket devices in the future.
> >
> > Signed-off-by: Todd Poynor <toddpoynor@google.com>
> > ---
> >  drivers/staging/gasket/gasket_core.c | 5 +++--
> >  drivers/staging/gasket/gasket_core.h | 3 +++
> >  2 files changed, 6 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/staging/gasket/gasket_core.c b/drivers/staging/gasket/gasket_core.c
> > index 732218773c3c6..e8f3b021c20d1 100644
> > --- a/drivers/staging/gasket/gasket_core.c
> > +++ b/drivers/staging/gasket/gasket_core.c
> > @@ -450,6 +450,7 @@ static int gasket_alloc_dev(
> >       gasket_dev->internal_desc = internal_desc;
> >       gasket_dev->dev_idx = dev_idx;
> >       snprintf(gasket_dev->kobj_name, GASKET_NAME_MAX, "%s", kobj_name);
> > +     gasket_dev->dev = parent;
>
> Normally when saving off a pointer to an object that you reference later
> on, and that you rely on, you need to grab a reference to it, otherwise
> it may disappear at any point in time.

Got it, I'll clean that up next round, thanks.

>
> However this whole "wrap the pci layer" nonsense is a total mess with
> the lifetime rules of devices, so it's probably the least of your
> worries....

That's high on the list to fix up, too.

>
> As long as you know you will have to fix that crud up, and what you are
> doing here will bite you if you do not do it right, that's fine with
> me...
>
> thanks,
>
> greg k-h
