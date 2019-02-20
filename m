Return-Path: <SRS0=sczE=Q3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E0DDC10F07
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 17:10:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E34EF21841
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 17:10:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550682603;
	bh=OAFAiPYOdfY9WOwvpDt3atX4+fpl2D3WkVuOFhyZKFc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=rsEDyYZ6gNF+Qtn2G736eTWErQBHDNKb1gdZLh6AJnCVVugo+e4UiWDXeZiPv9ANa
	 xXcn9arJKur7Puk8mcyF23wUuGK+nKUk62/bvMJhbWy2lp8zTnxNqvw4ZfuygMM+sW
	 PIy6qhD0/a42o4NovkJ4BNEw+A1PmyXQPiKiInmg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726412AbfBTRKB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Feb 2019 12:10:01 -0500
Received: from mail.kernel.org ([198.145.29.99]:49380 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725806AbfBTRKB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Feb 2019 12:10:01 -0500
Received: from archlinux (cpc91196-cmbg18-2-0-cust659.5-4.cable.virginm.net [81.96.234.148])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5B9D12146E;
        Wed, 20 Feb 2019 17:09:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550682600;
        bh=OAFAiPYOdfY9WOwvpDt3atX4+fpl2D3WkVuOFhyZKFc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=aysJ6Us5neCeHdlHypxxdHxIoA2KAlXWwuUgr81AlUI8zvyNM9NsBhCxwod6O55Lx
         JvV1zyXPOQG83RCx5X7IE/sIpbuuvSSRVnCueSWL9ZnJf0ZKIwiV0rR1IX/+SdEXpP
         UTc99Euq+yKn/0Q71ePktP6FAvph8iaon4hO2p18=
Date:   Wed, 20 Feb 2019 17:09:53 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     "H. Nikolaus Schaller" <hns@goldelico.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Charles Keepax <ckeepax@opensource.cirrus.com>,
        Song Qiang <songqiang1304521@gmail.com>,
        letux-kernel@openphoenux.org, Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/9] iio: accel: bmc150: add mount matrix support
Message-ID: <20190220170953.0200e256@archlinux>
In-Reply-To: <4C07F0C8-3149-4DEA-B108-39F2CC04ED88@goldelico.com>
References: <cover.1550671256.git.hns@goldelico.com>
        <71ef51037525ae6324bc22e933c00a514d518b31.1550671256.git.hns@goldelico.com>
        <20190220161444.78f34a61@archlinux>
        <4C07F0C8-3149-4DEA-B108-39F2CC04ED88@goldelico.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 20 Feb 2019 17:20:29 +0100
"H. Nikolaus Schaller" <hns@goldelico.com> wrote:

> > Am 20.02.2019 um 17:14 schrieb Jonathan Cameron <jic23@kernel.org>:
> > 
> > On Wed, 20 Feb 2019 15:00:50 +0100
> > "H. Nikolaus Schaller" <hns@goldelico.com> wrote:
> >   
> >> This patch allows to read a mount-matrix device tree
> >> property and report to user-space or in-kernel iio
> >> clients.
> >> 
> >> Signed-off-by: H. Nikolaus Schaller <hns@goldelico.com>  
> > This will clash with Andy's current patch, but I'll fix that up if
> > needed. Otherwise, one trivial suggestion inline.  
> 
> Ok, thanks!
> 
> > 
> > Jonathan
> >   
> >> ---
> >> drivers/iio/accel/bmc150-accel-core.c | 19 +++++++++++++++++++
> >> 1 file changed, 19 insertions(+)
> >> 
> >> diff --git a/drivers/iio/accel/bmc150-accel-core.c b/drivers/iio/accel/bmc150-accel-core.c
> >> index 383c802eb5b8..9178846cfddc 100644
> >> --- a/drivers/iio/accel/bmc150-accel-core.c
> >> +++ b/drivers/iio/accel/bmc150-accel-core.c
> >> @@ -204,6 +204,7 @@ struct bmc150_accel_data {
> >> 	int ev_enable_state;
> >> 	int64_t timestamp, old_timestamp; /* Only used in hw fifo mode. */
> >> 	const struct bmc150_accel_chip_info *chip_info;
> >> +	struct iio_mount_matrix orientation;
> >> };
> >> 
> >> static const struct {
> >> @@ -796,6 +797,18 @@ static ssize_t bmc150_accel_get_fifo_state(struct device *dev,
> >> 	return sprintf(buf, "%d\n", state);
> >> }
> >> 
> >> +static const struct iio_mount_matrix *
> >> +bmc150_accel_get_mount_matrix(const struct iio_dev *indio_dev,
> >> +				const struct iio_chan_spec *chan)
> >> +{
> >> +	return &((struct bmc150_accel_data *)iio_priv(indio_dev))->orientation;  
> > 
> > I would use a local variable as that casting is less than simple to parse
> > to my eyes anyway!  
> 
> Yes, Andy already suggested that. I just happend to pick one of the only two bad examples
> from all iio drivers as template...
> 
> drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
> drivers/iio/magnetometer/ak8975.c

If you like, feel free to send patches to tidy those up as well!
Then no one else can be unlucky on the same thing in future.

Jonathan

> 
> >   
> >> +}
> >> +
> >> +static const struct iio_chan_spec_ext_info bmc150_accel_ext_info[] = {
> >> +	IIO_MOUNT_MATRIX(IIO_SHARED_BY_DIR, bmc150_accel_get_mount_matrix),
> >> +	{ },
> >> +};
> >> +
> >> static IIO_CONST_ATTR(hwfifo_watermark_min, "1");
> >> static IIO_CONST_ATTR(hwfifo_watermark_max,
> >> 		      __stringify(BMC150_ACCEL_FIFO_LENGTH));
> >> @@ -978,6 +991,7 @@ static const struct iio_event_spec bmc150_accel_event = {
> >> 		.shift = 16 - (bits),					\
> >> 		.endianness = IIO_LE,					\
> >> 	},								\
> >> +	.ext_info = bmc150_accel_ext_info,				\
> >> 	.event_spec = &bmc150_accel_event,				\
> >> 	.num_event_specs = 1						\
> >> }
> >> @@ -1555,6 +1569,11 @@ int bmc150_accel_core_probe(struct device *dev, struct regmap *regmap, int irq,
> >> 
> >> 	data->regmap = regmap;
> >> 
> >> +	ret = of_iio_read_mount_matrix(dev, "mount-matrix",
> >> +				       &data->orientation);
> >> +	if (ret)
> >> +		return ret;
> >> +
> >> 	ret = bmc150_accel_chip_init(data);
> >> 	if (ret < 0)
> >> 		return ret;  
> >   
> 
> BR and thanks,
> Nikolaus
> 

