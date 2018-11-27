Return-Path: <SRS0=Hds+=OG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0848C43441
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 08:39:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 93FAB2086B
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 08:39:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 93FAB2086B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729587AbeK0TgK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Nov 2018 14:36:10 -0500
Received: from mga04.intel.com ([192.55.52.120]:49193 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728985AbeK0TgK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Nov 2018 14:36:10 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 27 Nov 2018 00:39:02 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,286,1539673200"; 
   d="scan'208";a="277497479"
Received: from paasikivi.fi.intel.com ([10.237.72.42])
  by orsmga005.jf.intel.com with ESMTP; 27 Nov 2018 00:39:00 -0800
Received: by paasikivi.fi.intel.com (Postfix, from userid 1000)
        id 89E3921B94; Tue, 27 Nov 2018 10:38:59 +0200 (EET)
Date:   Tue, 27 Nov 2018 10:38:59 +0200
From:   Sakari Ailus <sakari.ailus@linux.intel.com>
To:     Luca Ceresoli <luca@lucaceresoli.net>
Cc:     linux-media@vger.kernel.org, Leon Luo <leonl@leopardimaging.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] media: imx274: don't declare events, they are not
 implemented
Message-ID: <20181127083859.zljff4wk4hikel56@paasikivi.fi.intel.com>
References: <20181127083445.27737-1-luca@lucaceresoli.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181127083445.27737-1-luca@lucaceresoli.net>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Luca,

On Tue, Nov 27, 2018 at 09:34:43AM +0100, Luca Ceresoli wrote:
> The V4L2_SUBDEV_FL_HAS_EVENTS flag should not be set, event are just
> not implemented.
> 
> Signed-off-by: Luca Ceresoli <luca@lucaceresoli.net>

The driver supports controls, and so control events can be subscribed and
received by the user. Therefore I don't see a reason to remove the flag.

> ---
>  drivers/media/i2c/imx274.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/media/i2c/imx274.c b/drivers/media/i2c/imx274.c
> index 95a0e7d9851a..78746c51071d 100644
> --- a/drivers/media/i2c/imx274.c
> +++ b/drivers/media/i2c/imx274.c
> @@ -1878,7 +1878,7 @@ static int imx274_probe(struct i2c_client *client,
>  	imx274->client = client;
>  	sd = &imx274->sd;
>  	v4l2_i2c_subdev_init(sd, client, &imx274_subdev_ops);
> -	sd->flags |= V4L2_SUBDEV_FL_HAS_DEVNODE | V4L2_SUBDEV_FL_HAS_EVENTS;
> +	sd->flags |= V4L2_SUBDEV_FL_HAS_DEVNODE;
>  
>  	/* initialize subdev media pad */
>  	imx274->pad.flags = MEDIA_PAD_FL_SOURCE;

-- 
Sakari Ailus
sakari.ailus@linux.intel.com
