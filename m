Return-Path: <SRS0=p5KC=ON=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE442C04EB8
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 15:01:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7F16B2082B
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 15:01:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7F16B2082B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=v3.sk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726745AbeLDPBy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Dec 2018 10:01:54 -0500
Received: from shell.v3.sk ([90.176.6.54]:43983 "EHLO shell.v3.sk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726483AbeLDPBv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Dec 2018 10:01:51 -0500
Received: from localhost (localhost [127.0.0.1])
        by zimbra.v3.sk (Postfix) with ESMTP id A8816C833B;
        Tue,  4 Dec 2018 16:01:48 +0100 (CET)
Received: from shell.v3.sk ([127.0.0.1])
        by localhost (zimbra.v3.sk [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id idSrmX-VrtaD; Tue,  4 Dec 2018 16:01:46 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by zimbra.v3.sk (Postfix) with ESMTP id 0A92CC833C;
        Tue,  4 Dec 2018 16:01:46 +0100 (CET)
X-Virus-Scanned: amavisd-new at zimbra.v3.sk
Received: from shell.v3.sk ([127.0.0.1])
        by localhost (zimbra.v3.sk [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id tI95xesJPsJQ; Tue,  4 Dec 2018 16:01:45 +0100 (CET)
Received: from belphegor (nat-pool-brq-t.redhat.com [213.175.37.10])
        by zimbra.v3.sk (Postfix) with ESMTPSA id 17963C833B;
        Tue,  4 Dec 2018 16:01:45 +0100 (CET)
Message-ID: <680ea9621883d53712d701a9859ab2677890daca.camel@v3.sk>
Subject: Re: [PATCH 1/6] media: v4l2-subdev: stub
 v4l2_subdev_get_try_format() =?ISO-8859-1?Q?=1B=1B?=
From:   Lubomir Rintel <lkundrak@v3.sk>
To:     jacopo mondi <jacopo@jmondi.org>
Cc:     "Lad, Prabhakar" <prabhakar.csengg@gmail.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rui Miguel Silva <rmfrfs@gmail.com>,
        Shunqian Zheng <zhengsq@rock-chips.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Wenyou Yang <wenyou.yang@microchip.com>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Tue, 04 Dec 2018 16:01:43 +0100
In-Reply-To: <20181203134800.GA2901@w540>
References: <20181128171918.160643-1-lkundrak@v3.sk>
         <20181128171918.160643-2-lkundrak@v3.sk> <20181203134800.GA2901@w540>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.2 (3.30.2-2.fc29) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2018-12-03 at 14:48 +0100, jacopo mondi wrote:
> Hi Lubomir,
> 
>   thanks for the patches
> 
> On Wed, Nov 28, 2018 at 06:19:13PM +0100, Lubomir Rintel wrote:
> > Provide a dummy implementation when configured without
> > CONFIG_VIDEO_V4L2_SUBDEV_API to avoid ifdef dance in the drivers
> > that can
> > be built either with or without the option.
> > 
> > Suggested-by: Jacopo Mondi <jacopo@jmondi.org>
> > Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>
> > ---
> >  include/media/v4l2-subdev.h | 11 +++++++++++
> >  1 file changed, 11 insertions(+)
> > 
> > diff --git a/include/media/v4l2-subdev.h b/include/media/v4l2-
> > subdev.h
> > index 9102d6ca566e..906e28011bb4 100644
> > --- a/include/media/v4l2-subdev.h
> > +++ b/include/media/v4l2-subdev.h
> > @@ -967,6 +967,17 @@ static inline struct v4l2_rect
> >  		pad = 0;
> >  	return &cfg[pad].try_compose;
> >  }
> > +
> > +#else /* !defined(CONFIG_VIDEO_V4L2_SUBDEV_API) */
> > +
> > +static inline struct v4l2_mbus_framefmt
> > +*v4l2_subdev_get_try_format(struct v4l2_subdev *sd,
> > +			    struct v4l2_subdev_pad_config *cfg,
> > +			    unsigned int pad)
> > +{
> > +	return ERR_PTR(-ENOTTY);
> > +}
> > +
> >  #endif
> 
> While at there, what about doing the same for get_try_crop and
> get_try_compose? At lease provide stubs, I let you figure out if
> you're willing to fix callers too, it seems there are quite a few of
> them though
> 
> $ git grep v4l2_subdev_get_try* drivers/media/ | grep -v '_format' |
> wc -l
> 44

I'd be happy to do that. However, the drivers that use those seem to
depend on CONFIG_VIDEO_V4L2_SUBDEV_API anyway. Should those
dependencies be eventually done away with?

Please pardon my ignorance -- I don't actually understand why would
anyone disable CONFIG_VIDEO_V4L2_SUBDEV_API.

I'll be following up with a v2 after I get a response from you. It will
address locking issues found with smatch: one introduced by my patch
and one that was there before.

Cheers,
Lubo

> >  extern const struct v4l2_file_operations v4l2_subdev_fops;
> > --
> > 2.19.1
> > 

