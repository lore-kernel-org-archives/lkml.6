Return-Path: <SRS0=szhz=OQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86BD9C07E85
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 21:36:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3E6A82083D
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 21:36:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="BXY6nPQ2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3E6A82083D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726103AbeLGVgQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Dec 2018 16:36:16 -0500
Received: from mail-vk1-f193.google.com ([209.85.221.193]:38856 "EHLO
        mail-vk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726008AbeLGVgQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Dec 2018 16:36:16 -0500
Received: by mail-vk1-f193.google.com with SMTP id w72so1279662vkd.5
        for <linux-kernel@vger.kernel.org>; Fri, 07 Dec 2018 13:36:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dP+i4G2wSzRAn0QgynKJSJkIw51tiH0ggqE8uIpfmzY=;
        b=BXY6nPQ2/wY0SlFiNMyIpAa/VzIcmEV7+Z0BnNxPYXewcbCncx9dbM3lhxVdRnyAJN
         z38wBH+gAV8AEVN26ZvNborHniPx7MenYSUOGkaTON/F9Vh9e81Q1s2LYnMUXsGa2Dz8
         j4XO22NBMa24m0FgpoWDXwgITopTiM9ujVrB4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dP+i4G2wSzRAn0QgynKJSJkIw51tiH0ggqE8uIpfmzY=;
        b=UMwHOzjhcXxm9jKyYwOQ5kDIV84Lse/EqERvNNFKPybodO59hcFktllHoOrpWP0cMe
         Z4RNiVZGZOOmpeG9WQVKY+v3JIY1mwxygfcpIGQcpsUvoEH/TZaCopf6UIyqpYhuBkF9
         a882YJExYCddTC/fB9Pd6lm++lfwbo77BUqkk14xlyRQ73RCSQYTX+U0yKSUDETHPEvz
         jhNm/dCp1pOqHP1iI6S2g/FUYOk++xi8Tw07prcS0IGVcQ1/2er2Z827kcz1U4ZWEvHN
         wOvzJ76nQnD3RiSc6ZfmJogw7wgh1gJU3wJY1YBfy+idTwVPjFinZ7dQJQLUwHiKAkT/
         A/rg==
X-Gm-Message-State: AA+aEWacnEpjoszggrCVoZUuFj5pSPH1l63Pb3nPkAbz1sGQMgd56+m3
        TaVILWxC9rnHg3f9BIdvheqz17J9ZYA=
X-Google-Smtp-Source: AFSGD/Xa3HiwzMVXQx8dNYPalKOyfWsbu2RyIqMT/nkDNfwz7UXFXeXQqdxAx88GgkGHzfYAQVOPnA==
X-Received: by 2002:a1f:8b48:: with SMTP id n69mr1627263vkd.12.1544218574827;
        Fri, 07 Dec 2018 13:36:14 -0800 (PST)
Received: from mail-ua1-f54.google.com (mail-ua1-f54.google.com. [209.85.222.54])
        by smtp.gmail.com with ESMTPSA id k77sm1595496vkd.17.2018.12.07.13.36.14
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 07 Dec 2018 13:36:14 -0800 (PST)
Received: by mail-ua1-f54.google.com with SMTP id n7so1909397uao.7
        for <linux-kernel@vger.kernel.org>; Fri, 07 Dec 2018 13:36:14 -0800 (PST)
X-Received: by 2002:ab0:146b:: with SMTP id c40mr1644621uae.9.1544218194278;
 Fri, 07 Dec 2018 13:29:54 -0800 (PST)
MIME-Version: 1.0
References: <20181207152917.4862-1-georgi.djakov@linaro.org>
 <20181207152917.4862-9-georgi.djakov@linaro.org> <20181207162733.pdd62qvqzd6xk4nr@queper01-lin>
 <fb5d11cd-6729-5521-c828-9bfeedba9ce0@linaro.org> <20181207171437.qmtacurmqg53zzkl@queper01-lin>
In-Reply-To: <20181207171437.qmtacurmqg53zzkl@queper01-lin>
From:   Doug Anderson <dianders@chromium.org>
Date:   Fri, 7 Dec 2018 13:29:43 -0800
X-Gmail-Original-Message-ID: <CAD=FV=VxgeTw5KMY75h487WMGuJxAHCbXMoSm00LBqSh_PdTYA@mail.gmail.com>
Message-ID: <CAD=FV=VxgeTw5KMY75h487WMGuJxAHCbXMoSm00LBqSh_PdTYA@mail.gmail.com>
Subject: Re: [PATCH v11 8/8] interconnect: sdm845: Fix build failure after
 cmd_db API change
To:     quentin.perret@arm.com
Cc:     Georgi Djakov <georgi.djakov@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-pm@vger.kernel.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Rob Herring <robh+dt@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Saravana Kannan <skannan@codeaurora.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Amit Kucheria <amit.kucheria@linaro.org>,
        seansw@qti.qualcomm.com, daidavid1@codeaurora.org,
        Evan Green <evgreen@chromium.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        abailon@baylibre.com, maxime.ripard@bootlin.com,
        Arnd Bergmann <arnd@arndb.de>,
        Thierry Reding <thierry.reding@gmail.com>,
        ksitaraman@nvidia.com, sanjayc@nvidia.com,
        devicetree@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        linux-tegra@vger.kernel.org, Andy Gross <andy.gross@linaro.org>,
        Olof Johansson <olof@lixom.net>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, Dec 7, 2018 at 9:14 AM Quentin Perret <quentin.perret@arm.com> wrote:
>
> On Friday 07 Dec 2018 at 18:47:22 (+0200), Georgi Djakov wrote:
> > Hi Quentin,
> >
> > On 12/7/18 18:27, Quentin Perret wrote:
> > > Hi Georgi,
> > >
> > > On Friday 07 Dec 2018 at 17:29:17 (+0200), Georgi Djakov wrote:
> > >> Recently the cmd_db_read_aux_data() function was changed to avoid using
> > >> memcpy and return a pointer instead. Update the code to the new API and
> > >> fix the build failure.
> > >>
> > >> Fixes: ed3cafa79ea7 ("soc: qcom: cmd-db: Stop memcpy()ing in cmd_db_read_aux_data()")
> > >> Signed-off-by: Georgi Djakov <georgi.djakov@linaro.org>
> > >> ---
> > >>  drivers/interconnect/qcom/sdm845.c | 26 ++++++++++++++------------
> > >
> > > IIUC this file is introduced by patch 5. Should the fix be squashed
> > > into patch 5 directly ? Just to keep things bisectable.
> >
> > The reason why i have split it as a separate change is because as a
> > separate change it would be easier to review & test for the people who
> > are already familiar with the rest of the series.
> >
> > Another minor reason is that a separate patch will also make the life a
> > bit easier for some people who are back-porting this to kernels using
> > the older version of the cmd_db API.
> >
> > The commit that changed the cmd_db API is not yet in mainline, but in
> > linux-next. I am not sure what is preferred in this case?
>
> Not sure either but I guess that will depend who gets merged first ...
> If that's the cmd_db change, then you'll need to squash your fix in
> patch 5. If your series goes first, then the fix needs to be applied to
> the cmb_db change.
>
> I personally don't mind either way as long as we don't break bisection :-)

My $0.02 is that anyone downstream picking this will also be picking
the cmd db change, so I'd suggest squashing as suggested by Quentin.
Maybe you can do that and post a v12?  Since it sounded like Greg was
about ready to land [1] maybe we shouldn't wait too long till doing
it?

...unfortunately I guess we need to figure out how this will actually
land.  Greg can't pick the series up directly since it won't compile
without the cmd-db change.  ...so we need to do one of the following:

1. Feed it through a tree that goes through arm-soc (Andy's tree or
arm-soc directly) so you'll have commit ed3cafa79ea7 ("soc: qcom:
cmd-db: Stop memcpy()ing in cmd_db_read_aux_data()").

2. Greg could also merge in Andy's pull request
(https://patchwork.kernel.org/patch/10710447/), but you'll get some
unrelated patches too.

3. Wait until next year and we have the next -rc1 to get this merged.

...it seems like #1 would be the least painful option, but obviously
others would have to be OK w/ it.


[1] https://lkml.kernel.org/r/20181206145547.GA7884@kroah.com


-Doug
