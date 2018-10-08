Return-Path: <SRS0=fRGm=MU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D7FEC65C20
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 15:58:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C8B1720C0A
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 15:58:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C8B1720C0A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726810AbeJHXLP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Oct 2018 19:11:15 -0400
Received: from mga05.intel.com ([192.55.52.43]:16560 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726379AbeJHXLO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Oct 2018 19:11:14 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 08 Oct 2018 08:58:50 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,357,1534834800"; 
   d="scan'208";a="86685705"
Received: from paasikivi.fi.intel.com ([10.237.72.42])
  by FMSMGA003.fm.intel.com with ESMTP; 08 Oct 2018 08:58:30 -0700
Received: by paasikivi.fi.intel.com (Postfix, from userid 1000)
        id 7A7E3204D0; Mon,  8 Oct 2018 18:58:29 +0300 (EEST)
Date:   Mon, 8 Oct 2018 18:58:29 +0300
From:   Sakari Ailus <sakari.ailus@linux.intel.com>
To:     Yong <yong.deng@magewell.com>
Cc:     Maxime Ripard <maxime.ripard@bootlin.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Chen-Yu Tsai <wens@csie.org>,
        "David S. Miller" <davem@davemloft.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Hans Verkuil <hans.verkuil@cisco.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Jacob Chen <jacob-chen@iotwrt.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Thierry Reding <treding@nvidia.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Todor Tomov <todor.tomov@linaro.org>,
        linux-media@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-sunxi@googlegroups.com
Subject: Re: [PATCH v11 2/2] media: V3s: Add support for Allwinner CSI.
Message-ID: <20181008155829.jxxz4mjmeuu4hzki@paasikivi.fi.intel.com>
References: <1537951420-24752-1-git-send-email-yong.deng@magewell.com>
 <20180928101937.wdlrgezxoqzua5ke@paasikivi.fi.intel.com>
 <20180929181844.87fd7560cc560f268df3c7b4@magewell.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180929181844.87fd7560cc560f268df3c7b4@magewell.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Yong,

On Sat, Sep 29, 2018 at 06:18:44PM +0800, Yong wrote:
> Hi Sakari,
> 
> On Fri, 28 Sep 2018 13:19:37 +0300
> Sakari Ailus <sakari.ailus@linux.intel.com> wrote:
> 
> > Hi Yong,
> > 
> > Thanks for the update! This looks pretty good; some small bits to fix
> > still, please see my comments below.
> > 
> > On Wed, Sep 26, 2018 at 04:43:40PM +0800, Yong Deng wrote:
> > > Allwinner V3s SoC features two CSI module. CSI0 is used for MIPI CSI-2
> > > interface and CSI1 is used for parallel interface. This is not
> > > documented in datasheet but by test and guess.
> > > 
> > > This patch implement a v4l2 framework driver for it.
> > > 
> > > Currently, the driver only support the parallel interface. MIPI-CSI2,
> > > ISP's support are not included in this patch.
> > > 
> 
> ...
> 
> > > +
> > > +static void sun6i_csi_v4l2_cleanup(struct sun6i_csi *csi)
> > > +{
> > > +	v4l2_async_notifier_unregister(&csi->notifier);
> > > +	v4l2_async_notifier_cleanup(&csi->notifier);
> > > +	sun6i_video_cleanup(&csi->video);
> > > +	v4l2_device_unregister(&csi->v4l2_dev);
> > > +	media_device_unregister(&csi->media_dev);
> > 
> > Please unregister the media device as first.
> 
> I notice that the release order of intel ipu3 is:
>     cio2_notifier_exit(cio2);
>     cio2_fbpt_exit_dummy(cio2);
>     for (i = 0; i < CIO2_QUEUES; i++) 
>         cio2_queue_exit(cio2, &cio2->queue[i]);
>     v4l2_device_unregister(&cio2->v4l2_dev);
>     media_device_unregister(&cio2->media_dev);
>     media_device_cleanup(&cio2->media_dev);
>     mutex_destroy(&cio2->lock);

Well, yeah... this doesn't make a big difference after all. Unregistering
the media device first is still preferred.

> 
> > 
> > You're missing freeing the control handler.
> > 
> > > +	media_device_cleanup(&csi->media_dev);
> > > +}
> > > +
> > > +static int sun6i_csi_v4l2_init(struct sun6i_csi *csi)
> > > +{
> > > +	int ret;
> > > +
> > > +	csi->media_dev.dev = csi->dev;
> > > +	strlcpy(csi->media_dev.model, "Allwinner Video Capture Device",
> > > +		sizeof(csi->media_dev.model));
> > 
> > strscpy, please.
> > 
> > > +	csi->media_dev.hw_revision = 0;
> > > +
> > > +	media_device_init(&csi->media_dev);
> > > +
> > > +	ret = v4l2_ctrl_handler_init(&csi->ctrl_handler, 0);
> > 
> > Do you need controls? The driver doesn't appear to register any.
> 
> Some one suggest this. They want the drver can pass control queries to 
> the subdev.

If you need that, it should be done in the user space instead. The imx
staging driver does so but it is not supported by the control framework:
you may only call v4l2_ctrl_handler_free() for the purpose of freeing the
resources of the control handler --- not while it is still accessible from
the user space.

> 
> > 
> > > +	if (ret) {
> > > +		dev_err(csi->dev, "V4L2 controls handler init failed (%d)\n",
> > > +			ret);
> > > +		goto clean_media;
> > > +	}
> > > +
> > > +	csi->v4l2_dev.mdev = &csi->media_dev;
> > > +	csi->v4l2_dev.ctrl_handler = &csi->ctrl_handler;
> > > +	ret = v4l2_device_register(csi->dev, &csi->v4l2_dev);
> > > +	if (ret) {
> > > +		dev_err(csi->dev, "V4L2 device registration failed (%d)\n",
> 
> ...
> 
> > > +
> > > +/*
> > > + * PHYS_OFFSET isn't available on all architectures. In order to
> > > + * accomodate for COMPILE_TEST, let's define it to something dumb.
> > > + */
> > > +#ifndef PHYS_OFFSET
> > 
> > How about:
> > 
> > #if !defined(CONFIG_COMPILE_TEST) && !defined(PHYS_OFFSET)
> 
> Do you mean:
> #if defined(CONFIG_COMPILE_TEST) && !defined(PHYS_OFFSET)

Oh, yes. Indeed.

-- 
Kind regards,

Sakari Ailus
sakari.ailus@linux.intel.com
