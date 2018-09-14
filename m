Return-Path: <SRS0=Jh2l=L4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 240AFFC6182
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 02:30:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B005120853
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 02:30:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YQCVtD+n"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B005120853
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728435AbeINHmL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Sep 2018 03:42:11 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:36707 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728246AbeINHmK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Sep 2018 03:42:10 -0400
Received: by mail-ed1-f67.google.com with SMTP id f4-v6so6219431edq.3
        for <linux-kernel@vger.kernel.org>; Thu, 13 Sep 2018 19:29:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=asArhCha9PMyxs6xs3GfCK9YGyVt2CRBoO69o7MTjA0=;
        b=YQCVtD+nGCH14gqR87hnOGzbphp1RP1Fa4rwLpgVatWzRdRO1OLVa5N2T6jscXAZ33
         SbkeLfz68pRmkH24gtRDfoEJXWtx8ewfAxKnu8Sgyy/hac75VpHRw1y/KWYiMKAHgp3V
         NZNZ3W2jK6Rkl7lymkyeWKLsLwAd3tb3O3Kh5Hop/gC7rKmG7UhqF2ou+Fzv+YMUETaI
         DJ8i22c9hzItGh2sBhAMdlIabICycRVJvZDl1K9AtaGyjl0zls3gQSrVt3Mch24N3rX7
         YB/KY4OMI/2NOOyEELEJsRJEi8cVxPrpBNrPmVTN6iqoCqrln8FHGt/KAkO2TCqvU3dB
         w6ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=asArhCha9PMyxs6xs3GfCK9YGyVt2CRBoO69o7MTjA0=;
        b=its5Z9HwcF9+Sh3bfecmGPZmxJwirdgZUzW3ZzIq4PMyiP0cr+iGtrzKCXRr9IK3/V
         GrDi78kZtgTmwRpKGz1wO2j7AdpptSSV12iqVTlo5oZGWJC+JctGLo11cmAd7utbqUSR
         MkV1V0DQpz4mQ37Nt6AvVyeznB8KEUDhkY1OgxuKzdJxHjpoezk7RPpRInKrxptkM7Nq
         tD0Bu/1yd4M0w5I+JKO6cSmBvoQ5xW89snQpInvTlTt57NhZk3+K9Y6pFHiaH8Dvw7UV
         b6qxHS+iytUuwjgIlSph93yf/DML3Et1Yg4rUb/Yu1PyjDwSLh2ZTU3IPXxwB+g9i/ur
         pWlQ==
X-Gm-Message-State: APzg51CG46eERQM55vFP8S0lDN6709R+41CeopbpxumHSsAflk9ueWTi
        Yiqj8Neum4Ki9ZWE0YCsZNgQdTjGXHzdAVd8PQ==
X-Google-Smtp-Source: ANB0VdZQ8seVW9wZ30R/QOzOB3v07OUkP+XzEa0yX+jiG7xDIjiJ2aZUiIyqqE5YU09i4HW5frIEPUr5S5xeN6s/a+Y=
X-Received: by 2002:a50:ba39:: with SMTP id g54-v6mr15212066edc.148.1536892197979;
 Thu, 13 Sep 2018 19:29:57 -0700 (PDT)
MIME-Version: 1.0
References: <s5hk1ns1m8n.wl-tiwai@suse.de> <s5hlg88z0un.wl-tiwai@suse.de>
 <8d9cf4b9-4c52-2e1d-6778-312c7a2fdffe@suse.com> <2551848.SakgYeHO72@aspire.rjw.lan>
In-Reply-To: <2551848.SakgYeHO72@aspire.rjw.lan>
From:   Pingfan Liu <kernelfans@gmail.com>
Date:   Fri, 14 Sep 2018 10:29:46 +0800
Message-ID: <CAFgQCTuNb4XOg6LaY=m92zbhDTNmYkh11Dxy4OGbXtY09oXb9A@mail.gmail.com>
Subject: Re: [REGRESSION] Errors at reboot after 722e5f2b1eec
To:     "Rafael J . Wysocki" <rjw@rjwysocki.net>
Cc:     jnwang@suse.com, tiwai@suse.de, bp@suse.de,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 13, 2018 at 10:15 PM Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
>
> On Thursday, September 13, 2018 12:03:36 PM CEST James Wang wrote:
> >  This is a multi-part message in MIME format.
> > --------------F5519E624D0AD1E3F7DDA019
> > Content-Type: text/plain; charset=utf-8
> > Content-Transfer-Encoding: 8bit
> >
> >
> >
> > On 09/11/2018 02:15 PM, Takashi Iwai wrote:
> > > On Tue, 11 Sep 2018 14:11:30 +0200,
> > > James Wang wrote:
> > >> I did try it from kernel : head
> > > OK, then the bug is present with 4.19-rc2, at least.
> > > Please check my test kernel later (it's still being built).
> > Hi folks,  I attach two log about 4.19-rc3 and 4.19-rc3+Rafeal suggestion.
>
> OK, no difference AFAICS.
>
> This means that the commit turned up by bisection simply uncovered an existing
> ordering issue, apparently between an IOMMU and its client (ie. it appears that
> the client is shut down after the IOMMU).
>
> This isn't limited to shutdown and you'd see the same issue on system-wide
> suspend/resume (in fact, the Pingfan Liu's patches make shutdown use the
> same device list that is used for system-wide PM).
>
> One way to mitigate such issues is to add a device link between the two
> devices in question to enforce the correct suspend/resume/shutdown ordering
> between them.
>
I found the iommu was at  " 0000:00:00.2", while  ohci-pci is at
0000:00:13.1. Hence ohci-pci should be shutdown before iommu. Not
familiar with AMD's iommu code, but I think there is no shutdown
interface exported to drivers/base. It is shutdown by platform code in
arch/x86. So I think there should be someone teared down the iotbl,
e.g. by invalidating pages, before the shutdown of ohci-pci. I wonder
whether adding a device link can fix this bug or not. (Forgive me if I
made a mistake, since I am ignorant in this field)

Thanks,
Pingfan
