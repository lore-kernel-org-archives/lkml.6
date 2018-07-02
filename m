Return-Path: <SRS0=/0sc=JS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A946C3279B
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 07:23:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 498AB24F67
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 07:23:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="b4m3gzxd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 498AB24F67
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753837AbeGBHXs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Jul 2018 03:23:48 -0400
Received: from mail-io0-f195.google.com ([209.85.223.195]:37984 "EHLO
        mail-io0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753216AbeGBHXp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jul 2018 03:23:45 -0400
Received: by mail-io0-f195.google.com with SMTP id v26-v6so1617079iog.5
        for <linux-kernel@vger.kernel.org>; Mon, 02 Jul 2018 00:23:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=R5By7J935glGP7CvhXfIZJ3v5vV9/r3Xlnkq6xHXLUc=;
        b=b4m3gzxd8yWeOaqSbixNCiw8RxjebW+Cd57ITsopbGhGMLPz4D0QNYmc7HBFfWoJHo
         i+zh70nwkW/mZw5E3BLaO1zNw2rh3OHGEN8nrk2Gw4pWzaa+LPiOPntnH1M+MFhPUBQJ
         2/2qB+lWVCA14EYKGgp6S46aSL6xCatIcE0jo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=R5By7J935glGP7CvhXfIZJ3v5vV9/r3Xlnkq6xHXLUc=;
        b=fvqiWrQ0kz7m31m32b8yQmYOtxEksBOwgCSCM7pkqn2HZ6+fOUFXm66RHbjBMTB5/7
         9Oqj6jtivk0TGdBkP2TalJHGjp0ymYbCP79jxeaiSJKBZEcEJ1TUxeEk2LjeaDBsZHzI
         Iy6nRP9NbQNECjreA+TZ4WKSyxGI9j+Yl52/em5Tf0lD9ajR8y1uS4ETlsFdJ5GZHLYM
         40TTWS7AoB/M9UzAad6lhRC11vjcN9ka8fRP3eqsj98Kz2D0qQl+ziTX0vhGsut9RcLt
         ffzYllRIf48tmB/8skXkJKcsS9ZP04obpgu8SiAHmUKGQ4nj+RVUhKjk9NAa2maaBIgG
         ffAQ==
X-Gm-Message-State: APt69E2y5LcesA1s3I3WA4PFPfN5ZVjrBV+FdMNdVeNT2vQRF43QRBpt
        X+n3hwxYt4lPfWbeARr1C3dbpav3UBc++IW9TUX+Aw==
X-Google-Smtp-Source: AAOMgpf77CS/ceDPKdMOtYfEihpRsMiNKXYujT4ZZpsKCglOX16WE5gscfLiZxi9S8xhmCXBjGlrLh+jZy1Ka7W7RdY=
X-Received: by 2002:a6b:3e46:: with SMTP id l67-v6mr8896915ioa.294.1530516224969;
 Mon, 02 Jul 2018 00:23:44 -0700 (PDT)
MIME-Version: 1.0
References: <20180620121141.15403-1-georgi.djakov@linaro.org>
 <20180620121141.15403-2-georgi.djakov@linaro.org> <CAKfTPtBApjf9rhJm3paeXdgbVG50ALeun=zMUddc-f+RnrvkqQ@mail.gmail.com>
 <730fac43-e99f-e4bd-bc40-eddeb8338e6e@linaro.org>
In-Reply-To: <730fac43-e99f-e4bd-bc40-eddeb8338e6e@linaro.org>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Mon, 2 Jul 2018 09:23:33 +0200
Message-ID: <CAKfTPtBFcwSGm8oxd7e-xqUvyHjRfOawFrJiKeF_E4Lj=qPZ7w@mail.gmail.com>
Subject: Re: [PATCH v5 1/8] interconnect: Add generic on-chip interconnect API
To:     Georgi Djakov <georgi.djakov@linaro.org>
Cc:     "open list:THERMAL" <linux-pm@vger.kernel.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Rob Herring <robh+dt@kernel.org>,
        mturquette <mturquette@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Saravana Kannan <skannan@codeaurora.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Amit Kucheria <amit.kucheria@linaro.org>,
        "Sweeney, Sean" <seansw@qti.qualcomm.com>,
        daidavid1@codeaurora.org, Evan Green <evgreen@chromium.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Alexandre Bailon <abailon@baylibre.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        LAK <linux-arm-kernel@lists.infradead.org>,
        linux-arm-msm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 1 Jul 2018 at 13:09, Georgi Djakov <georgi.djakov@linaro.org> wrote=
:
>
> Hi Vincent,
>
> On 27.06.18 =D0=B3. 9:19, Vincent Guittot wrote:
> > Hi Georgi
> >
> > On Wed, 20 Jun 2018 at 14:11, Georgi Djakov <georgi.djakov@linaro.org> =
wrote:
> >
> > [snip]
> >
> >> +
> >> +static struct icc_path *path_allocate(struct icc_node *dst, ssize_t n=
um_nodes)
> >> +{
> >> +       struct icc_node *node =3D dst;
> >> +       struct icc_path *path;
> >> +       size_t i;
> >> +
> >> +       path =3D kzalloc(sizeof(*path) + num_nodes * sizeof(*path->req=
s),
> >
> > Should be (num_nodes -1) * sizeof(*path->reqs) as there is already 1
> > icc_req in icc_path struct
>
> reqs[] is a flexible array member and it's size is not included in
> sizeof(*path)

ah yes, my eyes saw "struct icc_req reqs[0];"  but my brain was
reading "struct icc_req reqs[1]"

Sorry for the noise

>
> Thanks,
> Georgi
>
> >> +                      GFP_KERNEL);
> >> +       if (!path)
> >> +               return ERR_PTR(-ENOMEM);
> >> +
> >> +       path->num_nodes =3D num_nodes;
> >> +
> >> +       for (i =3D 0; i < num_nodes; i++) {
> >> +               hlist_add_head(&path->reqs[i].req_node, &node->req_lis=
t);
> >> +
> >> +               path->reqs[i].node =3D node;
> >> +               /* reference to previous node was saved during path tr=
aversal */
> >> +               node =3D node->reverse;
> >> +       }
> >> +
> >> +       return path;
> >> +}
> >> +
> >
> > [snip]
> >
>
