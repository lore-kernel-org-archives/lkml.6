Return-Path: <SRS0=k9B+=NF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB963ECDE46
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 19:25:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 825BB2083E
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 19:25:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="nfSGINKC";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="QL2itA/C"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 825BB2083E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727671AbeJZD7V (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Oct 2018 23:59:21 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:47256 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727598AbeJZD7V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Oct 2018 23:59:21 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id EF6F060792; Thu, 25 Oct 2018 19:25:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1540495516;
        bh=EZE2IU0PvgdHkfj0YKWjxhyofP8EjCx6xOu9H7fhPyM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=nfSGINKC8NHb57mgE5anlWMAu/G+QW/7jdl6YTWu0ONJbRNEDRieuQEKjddokFoj5
         b+KVFve7Tfyj2YC2xcjQtMxoJhnK6omrTLkUPjaJ7LDjrU2Gjewmwss7vF4Ae/OTfv
         DKfPcsKQzKNAPwcs5v1gicuS2vn0IwTXdu3BOYak=
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        by smtp.codeaurora.org (Postfix) with ESMTP id B806360792;
        Thu, 25 Oct 2018 19:25:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1540495515;
        bh=EZE2IU0PvgdHkfj0YKWjxhyofP8EjCx6xOu9H7fhPyM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=QL2itA/C9zO9mSTsjfHr11cz6ugyn8pWT+T3F2LWA9EWTW7+7DYpmPxEVb/RMJYTe
         Qv5buTLzWLl9Deh66Bqf2N1DC1nq0in2GC9uA0IlPac0sDYDfDwc7Dea9WJNlurWT5
         wWH5U+P0RvCYwjiHvMgF798M30oAdsqibBixhBcE=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Thu, 25 Oct 2018 12:25:15 -0700
From:   Abhinav Kumar <abhinavk@codeaurora.org>
To:     Doug Anderson <dianders@chromium.org>
Cc:     sean@poorly.run, Sean Paul <seanpaul@chromium.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Sandeep Panda <spanda@codeaurora.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Jeykumar Sankaran <jsanka@codeaurora.org>,
        ryandcase@chromium.org, David Airlie <airlied@linux.ie>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-msm-owner@vger.kernel.org
Subject: Re: [PATCH 5/6] drm/panel: simple: Innolux TV123WAM is actually
 P120ZDG-BF1
In-Reply-To: <CAD=FV=Vs7V7zN8MoyPhjAWcszfWZ0xT50ELo-2gZ-iLmjr7s7w@mail.gmail.com>
References: <20181022204639.8558-1-dianders@chromium.org>
 <20181022204639.8558-5-dianders@chromium.org>
 <20181025181349.GM154160@art_vandelay>
 <CAD=FV=Vs7V7zN8MoyPhjAWcszfWZ0xT50ELo-2gZ-iLmjr7s7w@mail.gmail.com>
Message-ID: <b1bab8f70062def8255380d7d2754de5@codeaurora.org>
X-Sender: abhinavk@codeaurora.org
User-Agent: Roundcube Webmail/1.2.5
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-10-25 11:45, Doug Anderson wrote:
> Hi,
> 
> On Thu, Oct 25, 2018 at 11:13 AM Sean Paul <sean@poorly.run> wrote:
>> 
>> On Mon, Oct 22, 2018 at 01:46:38PM -0700, Douglas Anderson wrote:
>> > As far as I can tell the panel that was added in commit da50bd4258db
>> > ("drm/panel: simple: Add Innolux TV123WAM panel driver support")
>> > wasn't actually an Innolux TV123WAM but was actually an Innolux
>> > P120ZDG-BF1.
>> >
>> > As far as I can tell the Innolux TV123WAM isn't a real panel and but
>> > it's a mosh between the TI TV123WAM and the Innolux P120ZDG-BF1.
>> > Let's unmosh.
>> >
>> > Here's my evidence:
>> >
>> > * Searching for TV123WAM on the Internet turns up a TI panel.  While
>> >   it's possible that an Innolux panel has the same model number as the
>> >   TI Panel, it seems a little doubtful.  Looking up the datasheet from
>> >   the TI Panel shows that it's 1920 x 1280 and 259.2 mm x 172.8 mm.
>> >
>> > * As far as I know, the patch adding the Innolux Panel was supposed to
>> >   be for the board that's sitting in front of me as I type this
>> >   (support for that board is not yet upstream).  On the back of that
>> >   panel I see Innolux P120ZDZ-EZ1 rev B1.
>> >
>> > * Someone pointed me at a datasheet that's supposed to be for the
>> >   panel in front of me (sorry, I can't share the datasheet).  That
>> >   datasheet has the string "p120zdg-bf1"
>> >
>> > * If I search for "P120ZDG-BF1" on the Internet I get hits for panels
>> >   that are 2160x1440.  They don't have datasheets, but the fact that
>> >   the resolution matches is a good sign.
>> >
>> > In any case, let's update the name and also the physical size to match
>> > the correct panel.
>> >
>> > Fixes: da50bd4258db ("drm/panel: simple: Add Innolux TV123WAM panel driver support")
>> > Signed-off-by: Douglas Anderson <dianders@chromium.org>
>> > Cc: Sandeep Panda <spanda@codeaurora.org>
>> > ---
If Rob is onboard with this binding change, please feel free to add
Reviewed-by: Abhinav Kumar <abhinavk@codeaurora.org>
>> >
>> >  drivers/gpu/drm/panel/panel-simple.c | 14 +++++++-------
>> >  1 file changed, 7 insertions(+), 7 deletions(-)
>> >
>> > diff --git a/drivers/gpu/drm/panel/panel-simple.c b/drivers/gpu/drm/panel/panel-simple.c
>> > index 937e97490c30..7ee1abc5d81b 100644
>> > --- a/drivers/gpu/drm/panel/panel-simple.c
>> > +++ b/drivers/gpu/drm/panel/panel-simple.c
>> > @@ -1370,7 +1370,7 @@ static const struct panel_desc innolux_n156bge_l21 = {
>> >       },
>> >  };
>> >
>> > -static const struct drm_display_mode innolux_tv123wam_mode = {
>> > +static const struct drm_display_mode innolux_p120zdg_bf1_mode = {
>> >       .clock = 206016,
>> >       .hdisplay = 2160,
>> >       .hsync_start = 2160 + 48,
>> > @@ -1384,13 +1384,13 @@ static const struct drm_display_mode innolux_tv123wam_mode = {
>> >       .flags = DRM_MODE_FLAG_PHSYNC | DRM_MODE_FLAG_PVSYNC,
>> >  };
>> >
>> > -static const struct panel_desc innolux_tv123wam = {
>> > -     .modes = &innolux_tv123wam_mode,
>> > +static const struct panel_desc innolux_p120zdg_bf1 = {
>> > +     .modes = &innolux_p120zdg_bf1_mode,
>> >       .num_modes = 1,
>> >       .bpc = 8,
>> >       .size = {
>> > -             .width = 259,
>> > -             .height = 173,
>> > +             .width = 254,
>> > +             .height = 169,
>> >       },
>> >       .delay = {
>> >               .prepare = 200,
>> > @@ -2454,8 +2454,8 @@ static const struct of_device_id platform_of_match[] = {
>> >               .compatible = "innolux,n156bge-l21",
>> >               .data = &innolux_n156bge_l21,
>> >       }, {
>> > -             .compatible = "innolux,tv123wam",
>> 
>> I think we should update the struct, but we might want to keep this 
>> around.
>> Given the tv123wam panel is TI, we're likely not going to have a 
>> collision on
>> innolux,...
>> 
>> That said, I'll defer to robh on this one, I'm not sure if changing 
>> names is
>> cool once the bindings have hit mainline.
> 
> Whoops, I missed Rob on this patch--just had him on the bindings one.
> 
> ...generally I believe Rob seems to be OK with wiping out backward
> compatibility for things like this when the previous binding is super
> new and there's no evidence that anyone ever used it (like if it was
> added for a specific board and that board doesn't have a fully
> functional DT anyway).
> 
> In this particular case I'm 99.9999% certain nobody is using the
> existing binding.  If someone crawls out of the woodwork and says this
> patch broke them, it would be trivially easy to add the backward
> compatible string later.
> 
> Obviously Rob can feel free to correct me if I'm wrong.
> 
> I purposely put this patch at the end of the series so we can land the
> earlier ones and we can sit on this one for a little while if desired.
> 
> -Doug
