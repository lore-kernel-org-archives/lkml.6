Return-Path: <SRS0=sczE=Q3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FC58C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 16:08:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E519E2084D
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 16:08:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727017AbfBTQIC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Feb 2019 11:08:02 -0500
Received: from mga17.intel.com ([192.55.52.151]:48779 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726152AbfBTQIB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Feb 2019 11:08:01 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 20 Feb 2019 08:08:01 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,391,1544515200"; 
   d="scan'208";a="301211327"
Received: from smile.fi.intel.com (HELO smile) ([10.237.72.86])
  by orsmga005.jf.intel.com with ESMTP; 20 Feb 2019 08:07:56 -0800
Received: from andy by smile with local (Exim 4.92-RC6)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1gwUPa-0005kW-Eb; Wed, 20 Feb 2019 18:07:54 +0200
Date:   Wed, 20 Feb 2019 18:07:54 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     "H. Nikolaus Schaller" <hns@goldelico.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Charles Keepax <ckeepax@opensource.cirrus.com>,
        Song Qiang <songqiang1304521@gmail.com>,
        letux-kernel@openphoenux.org, Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/9] iio: accel: bmc150: add mount matrix support
Message-ID: <20190220160754.GW9224@smile.fi.intel.com>
References: <cover.1550671256.git.hns@goldelico.com>
 <71ef51037525ae6324bc22e933c00a514d518b31.1550671256.git.hns@goldelico.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <71ef51037525ae6324bc22e933c00a514d518b31.1550671256.git.hns@goldelico.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 20, 2019 at 03:00:50PM +0100, H. Nikolaus Schaller wrote:
> This patch allows to read a mount-matrix device tree
> property and report to user-space or in-kernel iio
> clients.

> +static const struct iio_mount_matrix *
> +bmc150_accel_get_mount_matrix(const struct iio_dev *indio_dev,
> +				const struct iio_chan_spec *chan)
> +{
> +	return &((struct bmc150_accel_data *)iio_priv(indio_dev))->orientation;

It's hard to read.

Can you split such lines in your series to something like

struct bmc150_accel_data *data = iio_priv(indio_dev);

return &data->orientation;

?

> +}
> +
> +static const struct iio_chan_spec_ext_info bmc150_accel_ext_info[] = {
> +	IIO_MOUNT_MATRIX(IIO_SHARED_BY_DIR, bmc150_accel_get_mount_matrix),
> +	{ },

Terminator lines better without comma.

> +};

-- 
With Best Regards,
Andy Shevchenko


