Return-Path: <SRS0=4ISz=MC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8CF8C433F4
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 16:39:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 94AD421522
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 16:39:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="W6PQXW5r"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 94AD421522
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731163AbeITWXh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Sep 2018 18:23:37 -0400
Received: from mail-oi0-f67.google.com ([209.85.218.67]:42390 "EHLO
        mail-oi0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727588AbeITWXg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Sep 2018 18:23:36 -0400
Received: by mail-oi0-f67.google.com with SMTP id v198-v6so8931034oif.9
        for <linux-kernel@vger.kernel.org>; Thu, 20 Sep 2018 09:39:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jaK5dqLfoxtQKYFmWJSmDb/195vbQiB1Inh5xWBHeAM=;
        b=W6PQXW5rq4FLlLWU8uZlGxaIS/ZsLgoAaC75MS14G+nEdNFqlYx03C8hyQfs9OhTwg
         GZ/yNmr58yHabVt3sdxnuKdgiTPve4owZyG6U+eur35WWvhxVybOngDKy8hGN+OJMwPX
         sKdhAlqIrVC9H/ar5f2l9kZeEXPpqlrycxJ0Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jaK5dqLfoxtQKYFmWJSmDb/195vbQiB1Inh5xWBHeAM=;
        b=T2aZ9NSF8ejGbhsejRRs1GYYMV9DG5qRi05xgQwlIMBrqKwr/ClCu8d8ac9JgHiH6s
         OSR6RceZkpMNJpxTyrzqtVI+9LaoB6SnVBCUbHHat6CG2QCUy4R1vl1MBc8TRZYS/cZz
         cdVqbEwbYI3jJRlAFB/NKc6ogTy3vLcJbvAMMhjgtOIydxqcto0ahLPbgRRGQG0lj7cG
         lVVJm1lnljXMwgXv8rlFRwsQo1D+0jxC5/ACa+dil/VUnbw9BTQ9McAKdYqwFRld8wCw
         /lA3AR9/g4aD/o9vJKV9he02oun7wRCec2qmV0Wuz6X5qOYsryP6leX5ISBUHKs0zZDH
         4AGA==
X-Gm-Message-State: APzg51B2fM8CuLPIlE3US/+9wzBo31LKioVsxuQM6ffRKEz0qDd51yyL
        MJUuRNmApE2ugVLd1XBSraQpb2oWqvyuRmeJzKKsGg==
X-Google-Smtp-Source: ANB0VdbjzxhlGfN5hOLDCjNRu1dD5YGZGU0m3LLW9be4VoJw5p/T/NwAox9Tod2ZcPUDZnN+OO+FtyOdSIk9KVToHOY=
X-Received: by 2002:aca:2214:: with SMTP id b20-v6mr2214925oic.365.1537461556385;
 Thu, 20 Sep 2018 09:39:16 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1537191359.git.leonard.crestez@nxp.com> <20180917191602.GP188300@art_vandelay>
 <80da134658da77f0d3f8fda6894ab756@agner.ch> <74b9b382ea6f9ec47573955d5b64a597b950cb5b.camel@nxp.com>
In-Reply-To: <74b9b382ea6f9ec47573955d5b64a597b950cb5b.camel@nxp.com>
From:   Sean Paul <seanpaul@chromium.org>
Date:   Thu, 20 Sep 2018 12:39:05 -0400
Message-ID: <CAEqLBRkRRutC7PXSxxx9yo7kURRH6q+vRYFzoE13QLh59gnvbA@mail.gmail.com>
Subject: Re: [RESEND 0/5] drm/mxsfb: Fix runtime PM for unpowering lcdif block
To:     leonard.crestez@nxp.com
Cc:     Stefan Agner <stefan@agner.ch>,
        Gustavo Padovan <gustavo@padovan.org>,
        Marek Vasut <marex@denx.de>, sean@poorly.run,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        linux-imx@nxp.com, Linux Kernel <linux-kernel@vger.kernel.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>, robert.chiras@nxp.com,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        DRI mailing list <dri-devel@lists.freedesktop.org>,
        Shawn Guo <shawnguo@kernel.org>, anson.huang@nxp.com,
        Dave Airlie <airlied@linux.ie>,
        Sascha Hauer <kernel@pengutronix.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 20, 2018 at 11:59 AM Leonard Crestez
<leonard.crestez@nxp.com> wrote:
>
> On Mon, 2018-09-17 at 16:37 -0700, Stefan Agner wrote:
> > On 17.09.2018 12:16, Sean Paul wrote:
> > > On Mon, Sep 17, 2018 at 04:42:10PM +0300, Leonard Crestez wrote:
> > > > Adding lcdif nodes to a power domain currently doesn't work, it results
> > > > in black/corrupted screens or hangs. While the driver does enable
> > > > runtime pm it does not deal correctly with the block being unpowered.
> > > >
> > > > All patches in this series have review tags from a while ago and I
> > > > tested them again on top of next-20180913. No changes
> > > >
> > > > This series stalled so I reached out to Marek on IRC and he was
> > > > surprised to be listed as maintainer
> > >
> > > Hopefully not too surprised since Marek added themself to MAINTAINERS when
> > > adding the driver :-)
> >
> > There have been some confusion about the DRM development processes
> > around the mxsfb already in the past.
> >
> > > I suppose we should probably move this to drm-misc since it qualifies as a
> > > "small driver" and needs a home. Looking through git history shows the last
> > > mxsfb-specific change was back in 02/17. Everything else has been drm-wide
> > > refactors. Thoughts?
> > >
> > > Marek/Leonard: Care to sign up to be listed as a reviewers?
> >
> > drm-misc seems to make sense. I volunteer to be listed as reviewer or co-maintainer.
>
> This gets +1 from me, you were very helpful during review.
>
> Next would be for one of the drm-misc maintainers to post a change for
> the MAINTAINER file and also merge my series?
>

I've posted the MAINTAINERS patch here:
https://lists.freedesktop.org/archives/dri-devel/2018-September/190414.html

Once I get some Acks, we can merge that and one of Stefan or Marek can apply the
patchset to drm-misc.

Sean

> --
> Regards,
> Leonard
