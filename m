Return-Path: <SRS0=GJN7=OT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29530C5CFFE
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 16:28:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D970C20821
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 16:28:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pefGxJ1w"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D970C20821
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727967AbeLJQ2B (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Dec 2018 11:28:01 -0500
Received: from mail-it1-f194.google.com ([209.85.166.194]:37794 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727935AbeLJQ2B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Dec 2018 11:28:01 -0500
Received: by mail-it1-f194.google.com with SMTP id b5so19093553iti.2;
        Mon, 10 Dec 2018 08:28:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=rq61FvlLTrrBLq40FzRBJbUAVudtRm7lWLwCmjfQZrk=;
        b=pefGxJ1wdWrCKqMIH/RWxtn6Wuw8rTjsxbi8ePQJjoKwPfNhQt30rxwMys5fbbrQzt
         /ajFJNdFjhSElyNWLLk6n8BB6t1JtPH2O+Pl3oXj+CHp8DzwRhD3935pgN5rhN3DWGFx
         enJxn6GNVqt01Cxv3+VVWKjXpiN8HYmu0YsrYVkTtIQn4yTf46lUmUDP6tJiaHkm3Oe+
         L8lMt5KPaJPlppSkyQlzW6fxi8BJ7cUkEZt9KEiKLmr1+PcJU9D7xc6YNQ2+AGaOd58Q
         HKo3zwlSWCKeN3ZCAs+hHe/cIzkXhwmP7uNmXVI7naqQIHYO1i4YerW2EFL255wZkdI7
         pNfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=rq61FvlLTrrBLq40FzRBJbUAVudtRm7lWLwCmjfQZrk=;
        b=Av1rG3n0WM4ZYioWPSJRytUzh7BnK4LO36eRpIohJFs4xLrYJH80ffWILQjZtkUcfN
         gfZu063LdXnuTq1gRMKaY97UP0Ip+xaGbrKgFfJRGODjgiYCUMDkbf95kVDLaqQFd+QM
         9hQsu9H30SxTTCPR2mErvSlNymH8cVNYuJGrd662szw1pLvuNv8S5f2t1qLfDnWAtp1G
         dTdHdhRzSshuioBPadjeM6wJH1HsA9PGMEp5x4NRVC93cJPpTqqI84riVnMjOvdoSC89
         zHlWnovpmhJMQyqmu4ngdJawTlIcCZ9BiGFRVyeSsdd7WwbXTu66sh6GOt5AinQ197hG
         wh6A==
X-Gm-Message-State: AA+aEWYGughhGUGMECUB7PZVCUdC2ju2xNs4UQUkdRt+NS+n9/D00Qfe
        no1Ts5g2e7jx/fpEKuKcDs2/2z+OChpOxe/3aagBBFH4kcs=
X-Google-Smtp-Source: AFSGD/UtUcvZNe3jXrL9v/Cfw5manMyFZ06OJ6tVFeNwDlyQbE5C7Y2GOKRFKSnIOS8U4jhF/K5TG1d404w+3XLUCGc=
X-Received: by 2002:a02:6c90:: with SMTP id w138mr11958588jab.60.1544459280133;
 Mon, 10 Dec 2018 08:28:00 -0800 (PST)
MIME-Version: 1.0
References: <20181120161451.21149-1-tiny.windzz@gmail.com> <ed0c146f-0a47-ef56-f919-4887d6a69001@linaro.org>
In-Reply-To: <ed0c146f-0a47-ef56-f919-4887d6a69001@linaro.org>
From:   Frank Lee <tiny.windzz@gmail.com>
Date:   Tue, 11 Dec 2018 00:27:49 +0800
Message-ID: <CAEExFWta3+EfvGODb58R8_3-=iMwJet0iGPY9zu8LmWFEMV2Fg@mail.gmail.com>
Subject: Re: [PATCH v3] cpuidle: big.LITTLE: add of_node_put()
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     rjw@rjwysocki.net, lorenzo.pieralisi@arm.com,
        linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 10, 2018 at 7:59 PM Daniel Lezcano
<daniel.lezcano@linaro.org> wrote:
>
>
> Hi Yangtao,
>
>
> On 20/11/2018 17:14, Yangtao Li wrote:
> > of_find_node_by_path() acquires a reference to the node
> > returned by it and that reference needs to be dropped by its caller.
> > bl_idle_init() doesn't do that, so fix it.
> >
> > Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
> > ---
> > Changes in v3:
> > -update changelog
> > ---
> >  drivers/cpuidle/cpuidle-big_little.c | 6 +++++-
> >  1 file changed, 5 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/cpuidle/cpuidle-big_little.c b/drivers/cpuidle/cpu=
idle-big_little.c
> > index db2ede565f1a..650f063ef809 100644
> > --- a/drivers/cpuidle/cpuidle-big_little.c
> > +++ b/drivers/cpuidle/cpuidle-big_little.c
> > @@ -174,8 +174,12 @@ static int __init bl_idle_init(void)
> >       /*
> >        * Initialize the driver just for a compliant set of machines
> >        */
> > -     if (!of_match_node(compatible_machine_match, root))
> > +     if (!of_match_node(compatible_machine_match, root)){
> > +             of_node_put(root);
> >               return -ENODEV;
> > +     }
> > +
> > +     of_node_put(root);
>
> Don't duplicate the of_node_put.
>
> I suggest:
>
> const struct of_device_id *match_id;
>
> [ ... ]
>
>
> match_id =3D of_match_node(compatible_machine_match, root);
>
> of_node_put(root);
>
> if (!match_id)
>         return -ENODEV;
>
>
Thank you for your suggestion, the new one has been sent.

Yours,
Yangtao
> >       if (!mcpm_is_available())
> >               return -EUNATCH;
> >
>
>
> --
>  <http://www.linaro.org/> Linaro.org =E2=94=82 Open source software for A=
RM SoCs
>
> Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
> <http://twitter.com/#!/linaroorg> Twitter |
> <http://www.linaro.org/linaro-blog/> Blog
>
