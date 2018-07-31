Return-Path: <SRS0=SIc1=KP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E280C43142
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 06:29:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 054EC208A2
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 06:29:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="te0YBWLX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 054EC208A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729785AbeGaIIc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Jul 2018 04:08:32 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:37242 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726086AbeGaIIc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jul 2018 04:08:32 -0400
Received: by mail-wm0-f68.google.com with SMTP id n11-v6so1795982wmc.2
        for <linux-kernel@vger.kernel.org>; Mon, 30 Jul 2018 23:29:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=By7sTNKS47yI0Hj1ZQ0nq0KjV4VrVGNwxp1FXxC5GB0=;
        b=te0YBWLXB05whDXrclqDmVtr+ONuYVzWmr3ymVDicN2xn90KM6xwygii/AOYPpOrqf
         ZrcBYvjkH0CvFz7xXvQPVj5lrjZ1n93NtaKzk/1fBQlxB9uDUicQfMmwJ8+OeC7En+xe
         FhNCk1KuMxlJ5X9sYtK64ZrklHwkiFbWlFG21iLzGr98LMKc8ihLMOpn8xITS4ozp7ko
         dbzcyW1rbfWXZZjbX6vEleSUmFQLNIv/19pzSHXBRDrrq3cA400omniYtt8QwBO9HzEV
         jpE6Sv5WM0TRq/nFJsFjOMbIbY2KyECmkFTC9lsnAOvooimS2HdSxp2GTUyRJ3C9D4jI
         jFcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=By7sTNKS47yI0Hj1ZQ0nq0KjV4VrVGNwxp1FXxC5GB0=;
        b=GUDSArJXA7ep71S5bODdhPcSuH1wV53S2uZSiVcCV3Rkkjj3/M7DbJ0mWzMDqRdW9u
         Wmfi4vagzbvey3ApL0JXIjlDRduMMJDmEvyD1EYEVyEKBZx37j87NPYrwbP1p0xeoigU
         f5J+Ecur0QFztw5/05c+JfA/d7ewYU9I5dV7MYq0Dp5joaVcn/tVmk54fEJTnqvkN9vg
         gRUljNzqtKMD4O6q0oEaDsY4digTUc/ae+CIUoyDjpuSUAZmhGY7AhvdHIOa3X85FMz0
         dVqQwtqB0vUKZLPPHMoW56bDErNYzVLs6p9inJKF2npGqd3xRGplXrGDT7igv+aqn1nm
         yUMA==
X-Gm-Message-State: AOUpUlH+UA6/4n7DqZTkMrdog2rx5WtbTtaZWRFZvi21GVyXZio1f+KD
        trHqChGouXOfi1A8zSLezY8yZH750p85PjDKYnd6hw==
X-Google-Smtp-Source: AAOMgpc0WsQWTOyCdfmVVrCqF472pF3hTqJgKizXkGCFNq5CGwW1COintMX0CdeaoxWeQfmVRWGs+UBiZHX4Gwsldwg=
X-Received: by 2002:a1c:851:: with SMTP id 78-v6mr1236178wmi.11.1533018588161;
 Mon, 30 Jul 2018 23:29:48 -0700 (PDT)
MIME-Version: 1.0
References: <20180729193646.201721-1-toddpoynor@gmail.com> <20180729193646.201721-2-toddpoynor@gmail.com>
 <CAE_wzQ-VmW=X-HEFj4PouxUcH6jKqHR_XXhXfrQmx_-CPE_tWQ@mail.gmail.com>
In-Reply-To: <CAE_wzQ-VmW=X-HEFj4PouxUcH6jKqHR_XXhXfrQmx_-CPE_tWQ@mail.gmail.com>
From:   Todd Poynor <toddpoynor@google.com>
Date:   Mon, 30 Jul 2018 23:29:37 -0700
Message-ID: <CAAW3YpYQcn-=eU+UTst1u7oKpW2k8R9Yvd-8i91hCaRGySUHiQ@mail.gmail.com>
Subject: Re: [PATCH 01/13] staging: gasket: core: hold reference to pci_dev
 while used
To:     Dmitry Torokhov <dtor@chromium.org>
Cc:     "toddpoynor@gmail.com" <toddpoynor@gmail.com>,
        Rob Springer <rspringer@google.com>,
        John Joseph <jnjoseph@google.com>, benchan@chromium.org,
        Greg KH <gregkh@linuxfoundation.org>,
        devel@driverdev.osuosl.org, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 30, 2018 at 11:19 PM Dmitry Torokhov <dtor@chromium.org> wrote:
>
> On Sun, Jul 29, 2018 at 12:37 PM Todd Poynor <toddpoynor@gmail.com> wrote:
> >
> > From: Todd Poynor <toddpoynor@google.com>
> >
> > Hold a reference on the struct pci_dev while a pointer to it is held in
> > the gasket data structures.
> >
> > Signed-off-by: Todd Poynor <toddpoynor@google.com>
> > ---
> >  drivers/staging/gasket/gasket_core.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/staging/gasket/gasket_core.c b/drivers/staging/gasket/gasket_core.c
> > index 2b484d067c38a..b832a4f529f27 100644
> > --- a/drivers/staging/gasket/gasket_core.c
> > +++ b/drivers/staging/gasket/gasket_core.c
> > @@ -488,6 +488,7 @@ static void gasket_free_dev(struct gasket_dev *gasket_dev)
> >         internal_desc->devs[gasket_dev->dev_idx] = NULL;
> >         mutex_unlock(&internal_desc->mutex);
> >         put_device(gasket_dev->dev);
> > +       pci_dev_put(gasket_dev->pci_dev);
>
> gasket_free_dev() is called only from driver PCI probe and remove
> function. I can assure you that that pci_dev structure is not going
> anywhere, there is no need to take this additional reference.

WIll fix, thanks.

>
> Thanks,
> Dmitry
