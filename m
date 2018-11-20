Return-Path: <SRS0=i6x1=N7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BADD3C04EBC
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 13:18:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 83BFF2075B
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 13:18:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 83BFF2075B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727310AbeKTXra (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Nov 2018 18:47:30 -0500
Received: from mga18.intel.com ([134.134.136.126]:44281 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725926AbeKTXr3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Nov 2018 18:47:29 -0500
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 20 Nov 2018 05:18:23 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,257,1539673200"; 
   d="scan'208";a="251189394"
Received: from paasikivi.fi.intel.com ([10.237.72.42])
  by orsmga004.jf.intel.com with ESMTP; 20 Nov 2018 05:18:16 -0800
Received: by paasikivi.fi.intel.com (Postfix, from userid 1000)
        id 14D17209B9; Tue, 20 Nov 2018 15:18:15 +0200 (EET)
Date:   Tue, 20 Nov 2018 15:18:15 +0200
From:   Sakari Ailus <sakari.ailus@linux.intel.com>
To:     Jagan Teki <jagan@amarulasolutions.com>
Cc:     Yong Deng <yong.deng@magewell.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        davem@davemloft.net, akpm@linux-foundation.org,
        Arnd Bergmann <arnd@arndb.de>,
        Hans Verkuil <hans.verkuil@cisco.com>,
        laurent.pinchart@ideasonboard.com, geert@linux-m68k.org,
        Neil Armstrong <narmstrong@baylibre.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        jacopo+renesas@jmondi.org, tglx@linutronix.de,
        todor.tomov@linaro.org, linux-media <linux-media@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-sunxi@googlegroups.com
Subject: Re: [linux-sunxi] [PATCH v12 2/2] media: V3s: Add support for
 Allwinner CSI.
Message-ID: <20181120131815.bkhbdtuqkpsfb33u@paasikivi.fi.intel.com>
References: <1540887490-28316-1-git-send-email-yong.deng@magewell.com>
 <CAMty3ZAprBAxAm+=1kpFsbhV3XGvmQ8XEW+6mOcsV5iaR3xNyQ@mail.gmail.com>
 <CAMty3ZBa3XwQ-0CDYb69qny2MiaCfx1RiQZvQ+WhkoSonU5CbA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMty3ZBa3XwQ-0CDYb69qny2MiaCfx1RiQZvQ+WhkoSonU5CbA@mail.gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 20, 2018 at 06:27:48PM +0530, Jagan Teki wrote:
> On Mon, Nov 19, 2018 at 5:38 PM Jagan Teki <jagan@amarulasolutions.com> wrote:
> >
> > On Tue, Oct 30, 2018 at 1:49 PM Yong Deng <yong.deng@magewell.com> wrote:
> > >
> > > Allwinner V3s SoC features a CSI module with parallel interface.
> > >
> > > This patch implement a v4l2 framework driver for it.
> > >
> > > Reviewed-by: Hans Verkuil <hans.verkuil@cisco.com>
> > > Reviewed-by: Maxime Ripard <maxime.ripard@bootlin.com>
> > > Tested-by: Maxime Ripard <maxime.ripard@bootlin.com>
> > > Signed-off-by: Yong Deng <yong.deng@magewell.com>
> > > ---
> > >  MAINTAINERS                                        |   8 +
> > >  drivers/media/platform/Kconfig                     |   1 +
> > >  drivers/media/platform/Makefile                    |   2 +
> > >  drivers/media/platform/sunxi/sun6i-csi/Kconfig     |   9 +
> > >  drivers/media/platform/sunxi/sun6i-csi/Makefile    |   3 +
> > >  drivers/media/platform/sunxi/sun6i-csi/sun6i_csi.c | 915 +++++++++++++++++++++
> > >  drivers/media/platform/sunxi/sun6i-csi/sun6i_csi.h | 135 +++
> > >  .../media/platform/sunxi/sun6i-csi/sun6i_csi_reg.h | 196 +++++
> > >  .../media/platform/sunxi/sun6i-csi/sun6i_video.c   | 678 +++++++++++++++
> > >  .../media/platform/sunxi/sun6i-csi/sun6i_video.h   |  38 +
> > >  10 files changed, 1985 insertions(+)
> > >  create mode 100644 drivers/media/platform/sunxi/sun6i-csi/Kconfig
> > >  create mode 100644 drivers/media/platform/sunxi/sun6i-csi/Makefile
> > >  create mode 100644 drivers/media/platform/sunxi/sun6i-csi/sun6i_csi.c
> > >  create mode 100644 drivers/media/platform/sunxi/sun6i-csi/sun6i_csi.h
> > >  create mode 100644 drivers/media/platform/sunxi/sun6i-csi/sun6i_csi_reg.h
> > >  create mode 100644 drivers/media/platform/sunxi/sun6i-csi/sun6i_video.c
> > >  create mode 100644 drivers/media/platform/sunxi/sun6i-csi/sun6i_video.h
> > >
> > > diff --git a/MAINTAINERS b/MAINTAINERS
> > > index 23021e0df5d7..42d73b35ed3e 100644
> > > --- a/MAINTAINERS
> > > +++ b/MAINTAINERS
> > > @@ -3900,6 +3900,14 @@ M:       Jaya Kumar <jayakumar.alsa@gmail.com>
> > >  S:     Maintained
> > >  F:     sound/pci/cs5535audio/
> > >
> > > +CSI DRIVERS FOR ALLWINNER V3s
> > > +M:     Yong Deng <yong.deng@magewell.com>
> > > +L:     linux-media@vger.kernel.org
> > > +T:     git git://linuxtv.org/media_tree.git
> > > +S:     Maintained
> > > +F:     drivers/media/platform/sunxi/sun6i-csi/
> > > +F:     Documentation/devicetree/bindings/media/sun6i-csi.txt
> > > +
> > >  CW1200 WLAN driver
> > >  M:     Solomon Peachy <pizza@shaftnet.org>
> > >  S:     Maintained
> > > diff --git a/drivers/media/platform/Kconfig b/drivers/media/platform/Kconfig
> > > index 0edacfb01f3a..be6626ed0ec8 100644
> > > --- a/drivers/media/platform/Kconfig
> > > +++ b/drivers/media/platform/Kconfig
> > > @@ -138,6 +138,7 @@ source "drivers/media/platform/am437x/Kconfig"
> > >  source "drivers/media/platform/xilinx/Kconfig"
> > >  source "drivers/media/platform/rcar-vin/Kconfig"
> > >  source "drivers/media/platform/atmel/Kconfig"
> > > +source "drivers/media/platform/sunxi/sun6i-csi/Kconfig"
> >
> > [snip]
> >
> > > +
> > > +       return 0;
> > > +}
> > > +
> > > +static int sun6i_subdev_notify_complete(struct v4l2_async_notifier *notifier)
> > > +{
> > > +       struct sun6i_csi *csi = container_of(notifier, struct sun6i_csi,
> > > +                                            notifier);
> > > +       struct v4l2_device *v4l2_dev = &csi->v4l2_dev;
> > > +       struct v4l2_subdev *sd;
> > > +       int ret;
> > > +
> > > +       dev_dbg(csi->dev, "notify complete, all subdevs registered\n");
> > > +
> > > +       if (notifier->num_subdevs != 1)
> >
> > drivers/media/platform/sunxi/sun6i-csi/sun6i_csi.c: In function
> > ‘sun6i_subdev_notify_complete’:
> > drivers/media/platform/sunxi/sun6i-csi/sun6i_csi.c:646:14: error:
> > ‘struct v4l2_async_notifier’ has no member named ‘num_subdevs’
> 
> This build issues on linux-next, let me know you have next version
> changes for this, thanks.

I've applied Maxime's fixes to the patch that went in:

<URL:https://git.linuxtv.org/sailus/media_tree.git/commit/?id=78d1d55a4fe1f82b83278c93803fbdf6226f698f>

-- 
Sakari Ailus
sakari.ailus@linux.intel.com
