Return-Path: <SRS0=PvM2=PP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37350C43387
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 14:22:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F219D217D4
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 14:22:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546870923;
	bh=lnDSYHGN6rNIJSR/c7EGks0FRT405XLrP6bjK6hOHyg=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=UX+Q5Y0g21hokFyjDrmiUIVqPm2HiM/hVxtNRqrTQBOFbCqWqSDjiIkumJnw7v/dl
	 iz0teNCXMfxvMZFUhY5Dl/7ZA2kXykoEVgNrwvTbh9QIIMYBHuu81CdorZ1iFnp7+6
	 LAIy09ev9mcO08tYUqHqRVrcyMCyUxs3AeRmMlC4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727880AbfAGOWC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Jan 2019 09:22:02 -0500
Received: from mail-ot1-f68.google.com ([209.85.210.68]:33821 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726827AbfAGOWB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jan 2019 09:22:01 -0500
Received: by mail-ot1-f68.google.com with SMTP id t5so451748otk.1;
        Mon, 07 Jan 2019 06:22:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lnDSYHGN6rNIJSR/c7EGks0FRT405XLrP6bjK6hOHyg=;
        b=I/sMH969Rih5ajkde/7CkNUwfV3OIMqvj7hWeti0yW4ZAzw9BGaRgsW1FZ4Q2AD/gg
         o8XN8l7sk3vBm7dQGI3PriWDYcGn3G7ZDX6b/aavdxR9+wybxYH96o+iDbgy4OVZfmGG
         rH0GhhUWY4YKelqiqo5RsU7LiiGDIB2ncdRrtFGrUjrlYVp9B56k7jN+TSVqMVbPNby5
         S4C5beDqaxHbYyxJM0kvv+U5hqj2VRMmIMttzsq/Ok4drQ/2nTg2Ki/urz13UnP5GjfU
         pW4+Hf0KN9AlWcnyIdw1EbsRLkq2icbUXNY3GK67w8EaazrI3YGK5wcy4Ytzk0xpvOMC
         ptWA==
X-Gm-Message-State: AJcUukfxRWhz9VIOM8LggYfeBzV8glGnN4cCRfA2Hz9srWGK/Qm96wL9
        2GR/lpAjHrCvAcqFLSrcCtdQ1x94AJXE5QXz1tc=
X-Google-Smtp-Source: ALg8bN4fWEHeL7jYMpoON+5ytbUBEDCKoiPVBJUfaziPIhJvzKznL9lgh+LdnOxcAxi/KM+vTlPBb0RJ6RhpSzhYPnI=
X-Received: by 2002:a9d:5e8c:: with SMTP id f12mr45432271otl.343.1546870921008;
 Mon, 07 Jan 2019 06:22:01 -0800 (PST)
MIME-Version: 1.0
References: <1545388436-7489-1-git-send-email-vincent.guittot@linaro.org>
 <1545388436-7489-3-git-send-email-vincent.guittot@linaro.org>
 <ae85c6d4-5482-1376-7573-8ece9f78bc61@linux.intel.com> <CAKfTPtDx8u_TnZQnQNmn+=A5A78CPVSWKvMdOVD0UEw4m4s1iQ@mail.gmail.com>
 <d15e49e3-8d86-9c25-6412-a8534f1790d4@linux.intel.com> <CAKfTPtC1VVqK8Fde=AdRFyd4--09XVoNg8xHUja2siynL_o_3Q@mail.gmail.com>
In-Reply-To: <CAKfTPtC1VVqK8Fde=AdRFyd4--09XVoNg8xHUja2siynL_o_3Q@mail.gmail.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 7 Jan 2019 15:21:49 +0100
Message-ID: <CAJZ5v0i_xyKTtMShut5JEFSE=8GrE4cfb_Yi+eeMPZdRsNvmbA@mail.gmail.com>
Subject: Re: [Intel-gfx] [PATCH v5 2/3] drm/i915: Move on the new pm runtime interface
To:     Vincent Guittot <vincent.guittot@linaro.org>
Cc:     Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
        "open list:THERMAL" <linux-pm@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Thara Gopinath <thara.gopinath@linaro.org>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        rodrigo.vivi@intel.com, David Airlie <airlied@linux.ie>,
        "Intel graphics driver community testing & development" 
        <intel-gfx@lists.freedesktop.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Ulf Hansson <ulf.hansson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 7, 2019 at 3:04 PM Vincent Guittot
<vincent.guittot@linaro.org> wrote:
>
> Hi Tvrtko,
>
> On Mon, 31 Dec 2018 at 13:32, Tvrtko Ursulin
> <tvrtko.ursulin@linux.intel.com> wrote:
> >
> >
> > On 21/12/2018 13:26, Vincent Guittot wrote:
> > > On Fri, 21 Dec 2018 at 12:33, Tvrtko Ursulin
>
> [snip]
>
> > >>
> > >> If it is always monotonic, then worst case we report one wrong sample,
> > >> which I guess is still not ideal since someone could be querying the PMU
> > >> with quite low frequency.
> > >>
> > >> There are tests which probably can hit this, but to run them
> > >> automatically your patches would need to be rebased on drm-tip and maybe
> > >> sent to our trybot. I can do that after the holiday break if you are
> > >> okay with having the series waiting until then.
> > >
> > > yes looks good to me
> >
> > Looks good to me as well. And our CI agrees with it. So:
> >
> > Reviewed-by: Tvrtko Ursulin <tvrtko.ursulin@intel.com>
>
> Thanks for the review and the test
>
> >
> > I assume you will take the patch through some power related tree and we
> > will eventually pull it back to drm-tip.
>
> Rafael,
> How do you want to proceed with this patch and the 2 others of the serie ?

I'm going to queue up the whole series for 5.1.

Thanks!
