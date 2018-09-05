Return-Path: <SRS0=wmYC=LT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A343C43334
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 00:25:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2071C206BA
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 00:25:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iNEUAD2i"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2071C206BA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726284AbeIEEwo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Sep 2018 00:52:44 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:35683 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725862AbeIEEwo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Sep 2018 00:52:44 -0400
Received: by mail-pg1-f194.google.com with SMTP id 7-v6so2483389pgf.2;
        Tue, 04 Sep 2018 17:25:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=RmFKsKzNkj0/CRR7kqm7sdo22piWs4gj1gkay/MiDzo=;
        b=iNEUAD2ipitdI5oLR/l72TqLgMlHcFbHvBStWRSBmmluiNWzE/SQckzIAqnXm2JJ3i
         l8UzkLr0QJNlTfEZhiz9H4nnHOsrLw+ZQ8eajdj2gijczy0mTgrOHVah2tBnRciCRTYe
         8WOBkPmx6pH7Mvz2dHrPfB+q4hlY14lglvL8Lp7aUuyoKXMApp1TwGTIMYb3MCmaxvp6
         yMTPHWs1VtGvrBsxEELAju942mF6OVEL7JBYfH5tAOQdCxtWrSyMRwloiz+ZEogLdtkS
         r/jIxhiP/tH+ufRbN2c27id8cD4WVQiwGOJrW26uvTsBt0zrFl015Qy3YxgbO1mGOC6u
         xMKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=RmFKsKzNkj0/CRR7kqm7sdo22piWs4gj1gkay/MiDzo=;
        b=Msdw1JwC67QTtc8wgmvffHBcPshCtzxojSUpnvvQqHVRdsdcgYOwJHcTvVKXY28/04
         rS6GKidmt3+G7dmfATS9vFLBnrxgscPKXyqIKIrtYhx3AQ9oqRd7rXQrOmZ9hijN8DOJ
         0jKrLL0DVp04hkfKIflhvLXLOhi7N77m6ADSrbR7bFGbFSOynHL4vXoZjzBLc2Xvlb2M
         PnObNyqV2yrGpVLCPazZPNfVjA7fUk0p4S05E+eB5pwAh+oxFN4m+7gUU2KY01ibtFC4
         fvyoaEAVkAfgthvV3NvY/Fl7RhnFeAQEYMKciXkxLYUTVTXFNJ8MCg1NP0lMpQ8I98Ow
         rb6Q==
X-Gm-Message-State: APzg51CtEzW+LukZ+C99lY6EdgjvKMg/rrVSfB6gHR+BEALFn2L4hZOY
        Akap+8WVswfsLhl5aq2h4eU=
X-Google-Smtp-Source: ANB0VdZXtI39IGUNJD9Lr8KHsbR09AIwEMklJzbqM7hydZ4IwvvpPrx1szF1XPDREQ5aKs2z8FRO6A==
X-Received: by 2002:a63:e841:: with SMTP id a1-v6mr18907154pgk.126.1536107111676;
        Tue, 04 Sep 2018 17:25:11 -0700 (PDT)
Received: from dtor-ws ([2620:15c:202:201:3adc:b08c:7acc:b325])
        by smtp.gmail.com with ESMTPSA id c8-v6sm231109pfb.147.2018.09.04.17.25.10
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 04 Sep 2018 17:25:10 -0700 (PDT)
Date:   Tue, 4 Sep 2018 17:25:08 -0700
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Jiri Kosina <jikos@kernel.org>
Cc:     Harry Cutts <hcutts@chromium.org>,
        linux-input <linux-input@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Jiri Kosina <jiri.kosina@suse.cz>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        linux-doc@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>
Subject: Re: [PATCH v2 1/5] Add the `REL_WHEEL_HI_RES` event code
Message-ID: <20180905002508.GA72133@dtor-ws>
References: <20180830215622.47550-1-hcutts@chromium.org>
 <20180830215622.47550-2-hcutts@chromium.org>
 <nycvar.YFH.7.76.1809031542370.25787@cbobk.fhfr.pm>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <nycvar.YFH.7.76.1809031542370.25787@cbobk.fhfr.pm>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 03, 2018 at 03:43:13PM +0200, Jiri Kosina wrote:
> On Thu, 30 Aug 2018, Harry Cutts wrote:
> 
> > This event code represents scroll reports from high-resolution wheels,
> > and will be used by future patches in this series. See the linux-input
> > "Reporting high-resolution scroll events" thread [0] for more details.
> > 
> > [0]: https://www.spinics.net/lists/linux-input/msg57380.html
> > 
> > Signed-off-by: Harry Cutts <hcutts@chromium.org>
> > ---
> > 
> > Changes in v2: None
> > 
> >  Documentation/input/event-codes.rst    | 11 ++++++++++-
> >  include/uapi/linux/input-event-codes.h |  1 +
> >  2 files changed, 11 insertions(+), 1 deletion(-)
> > 
> > diff --git a/Documentation/input/event-codes.rst b/Documentation/input/event-codes.rst
> > index a8c0873beb95..cef220c176a4 100644
> > --- a/Documentation/input/event-codes.rst
> > +++ b/Documentation/input/event-codes.rst
> > @@ -190,7 +190,16 @@ A few EV_REL codes have special meanings:
> >  * REL_WHEEL, REL_HWHEEL:
> >  
> >    - These codes are used for vertical and horizontal scroll wheels,
> > -    respectively.
> > +    respectively. The value is the number of "notches" moved on the wheel, the
> > +    physical size of which varies by device. For high-resolution wheels (which
> > +    report multiple events for each notch of movement, or do not have notches)
> > +    this may be an approximation based on the high-resolution scroll events.
> > +
> > +* REL_WHEEL_HI_RES:
> > +
> > +  - If a vertical scroll wheel supports high-resolution scrolling, this code
> > +    will be emitted in addition to REL_WHEEL. The value is the (approximate)
> > +    distance travelled by the user's finger, in microns.
> >  
> >  EV_ABS
> >  ------
> > diff --git a/include/uapi/linux/input-event-codes.h b/include/uapi/linux/input-event-codes.h
> > index 53fbae27b280..dad8d3890a3a 100644
> > --- a/include/uapi/linux/input-event-codes.h
> > +++ b/include/uapi/linux/input-event-codes.h
> > @@ -708,6 +708,7 @@
> >  #define REL_DIAL		0x07
> >  #define REL_WHEEL		0x08
> >  #define REL_MISC		0x09
> > +#define REL_WHEEL_HI_RES	0x0a
> >  #define REL_MAX			0x0f
> >  #define REL_CNT			(REL_MAX+1)
> 
> Dmitry, is this OK with you?

Yep, please feel free to merge through your tree.

Acked-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>

Thanks.

-- 
Dmitry
