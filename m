Return-Path: <SRS0=6f18=J7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7009ECDFB1
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Jul 2018 08:42:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5574B208BA
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Jul 2018 08:42:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="Pa5KMJzO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5574B208BA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726346AbeGOJER (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 15 Jul 2018 05:04:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:36448 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726021AbeGOJER (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Jul 2018 05:04:17 -0400
Received: from archlinux (cpc91196-cmbg18-2-0-cust659.5-4.cable.virginm.net [81.96.234.148])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A2F3F2089E;
        Sun, 15 Jul 2018 08:42:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1531644125;
        bh=jo+LBnRQqUwv88VjVn8b4cDItGmv0UREBS27rnb7wMc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Pa5KMJzO1jDUREsJFZ3ST6ZyoGVyVB3K1JigKNYMBYPsUHbS6HGKk0BzpNQ2faQJn
         MxHRNyK25x7sjeq6e+/Uq6hWfnoa/t4D3gTYtlC65nyqcBn6Dp+B1FU97GxMzynXdM
         vlkp7jafbKNbh4jEkRM17zAglqVoZcDn+JxX6C4Q=
Date:   Sun, 15 Jul 2018 09:41:58 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Jonathan Cameron <jonathan.cameron@huawei.com>
Cc:     Brian Masney <masneyb@onstation.org>, <robh+dt@kernel.org>,
        <mark.rutland@arm.com>, <andy.gross@linaro.org>,
        <david.brown@linaro.org>, <linux-iio@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-soc@vger.kernel.org>,
        <jonathan@marek.ca>, <jmaneyrol@invensense.com>, <knaack.h@gmx.de>,
        <lars@metafoo.de>, <pmeerw@pmeerw.net>, <mkelly@xevo.com>,
        <fischerdouglasc@gmail.com>, <bshah@kde.org>, <ctatlor97@gmail.com>
Subject: Re: [PATCH 1/3] iio: imu: mpu6050: add support for 6515 variant
Message-ID: <20180715094158.08115f93@archlinux>
In-Reply-To: <20180712154738.00002918@huawei.com>
References: <20180711010932.20313-1-masneyb@onstation.org>
        <20180711010932.20313-2-masneyb@onstation.org>
        <20180712154738.00002918@huawei.com>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 12 Jul 2018 15:47:38 +0100
Jonathan Cameron <jonathan.cameron@huawei.com> wrote:

> On Tue, 10 Jul 2018 21:09:30 -0400
> Brian Masney <masneyb@onstation.org> wrote:
> 
> > This patch adds support for the MPU 6515 variant. Confirmed that the
> > driver functions correctly on a LG Nexus 5 (hammerhead) phone.
> > 
> > Signed-off-by: Brian Masney <masneyb@onstation.org>
> > Signed-off-by: Jonathan Marek <jonathan@marek.ca>
Applied to the togreg branch of iio.git and pushed out as testing
for the autobuilders to play with it.

thanks,

Jonathan

> > ---
> > This is a variation of Jonathan Marek's patch from postmarketOS
> > https://gitlab.com/postmarketOS/linux-postmarketos/commit/b8ad1ec1859c8bbcbce94944b3f4dd68f8f9fc37
> > with the following changes:
> > 
> > - The driver was previously throwing a 'whoami mismatch got XXX' error.
> >   Corrected ordering of hw_info variable to match the index of the
> >   inv_devices enum. The mpu6515 needed to come after mpu6500, not
> >   mpu6050.
> > - Removed regulator code. See next patch in this series.
> > 
> > I got confirmation from Jonathan M. that it was ok for me to submit his
> > patch upstream with these changes.
> > 
> > Jonathan C.: I assume that it is ok for the device tree binding
> > documentation to go through IIO? If not, I can split this out into a
> > separate patch if needed.  
> A single ID addition is normally uncontroversial enough that we don't bother
> the DT maintainers (though of course they are welcome to look!).
> So this is fine.
> > 
> >  Documentation/devicetree/bindings/iio/imu/inv_mpu6050.txt | 1 +
> >  drivers/iio/imu/inv_mpu6050/inv_mpu_core.c                | 6 ++++++
> >  drivers/iio/imu/inv_mpu6050/inv_mpu_i2c.c                 | 5 +++++
> >  drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h                 | 2 ++
> >  4 files changed, 14 insertions(+)
> > 
> > diff --git a/Documentation/devicetree/bindings/iio/imu/inv_mpu6050.txt b/Documentation/devicetree/bindings/iio/imu/inv_mpu6050.txt
> > index 5f4777e8cc9e..b7def51c8ad9 100644
> > --- a/Documentation/devicetree/bindings/iio/imu/inv_mpu6050.txt
> > +++ b/Documentation/devicetree/bindings/iio/imu/inv_mpu6050.txt
> > @@ -6,6 +6,7 @@ Required properties:
> >   - compatible : should be one of
> >  		"invensense,mpu6050"
> >   		"invensense,mpu6500"
> > +		"invensense,mpu6515"
> >  		"invensense,mpu9150"
> >  		"invensense,mpu9250"
> >  		"invensense,mpu9255"
> > diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c b/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
> > index de68e83fc52d..12c1b9507007 100644
> > --- a/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
> > +++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
> > @@ -103,6 +103,12 @@ static const struct inv_mpu6050_hw hw_info[] = {
> >  		.reg = &reg_set_6500,
> >  		.config = &chip_config_6050,
> >  	},
> > +	{
> > +		.whoami = INV_MPU6515_WHOAMI_VALUE,
> > +		.name = "MPU6515",
> > +		.reg = &reg_set_6500,
> > +		.config = &chip_config_6050,
> > +	},
> >  	{
> >  		.whoami = INV_MPU6000_WHOAMI_VALUE,
> >  		.name = "MPU6000",
> > diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_i2c.c b/drivers/iio/imu/inv_mpu6050/inv_mpu_i2c.c
> > index 495409d56207..dd758e3d403d 100644
> > --- a/drivers/iio/imu/inv_mpu6050/inv_mpu_i2c.c
> > +++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_i2c.c
> > @@ -174,6 +174,7 @@ static int inv_mpu_remove(struct i2c_client *client)
> >  static const struct i2c_device_id inv_mpu_id[] = {
> >  	{"mpu6050", INV_MPU6050},
> >  	{"mpu6500", INV_MPU6500},
> > +	{"mpu6515", INV_MPU6515},
> >  	{"mpu9150", INV_MPU9150},
> >  	{"mpu9250", INV_MPU9250},
> >  	{"mpu9255", INV_MPU9255},
> > @@ -192,6 +193,10 @@ static const struct of_device_id inv_of_match[] = {
> >  		.compatible = "invensense,mpu6500",
> >  		.data = (void *)INV_MPU6500
> >  	},
> > +	{
> > +		.compatible = "invensense,mpu6515",
> > +		.data = (void *)INV_MPU6515
> > +	},
> >  	{
> >  		.compatible = "invensense,mpu9150",
> >  		.data = (void *)INV_MPU9150
> > diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h b/drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h
> > index de8391693e17..e69a59659dbc 100644
> > --- a/drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h
> > +++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h
> > @@ -71,6 +71,7 @@ struct inv_mpu6050_reg_map {
> >  enum inv_devices {
> >  	INV_MPU6050,
> >  	INV_MPU6500,
> > +	INV_MPU6515,
> >  	INV_MPU6000,
> >  	INV_MPU9150,
> >  	INV_MPU9250,
> > @@ -256,6 +257,7 @@ struct inv_mpu6050_state {
> >  #define INV_MPU9150_WHOAMI_VALUE		0x68
> >  #define INV_MPU9250_WHOAMI_VALUE		0x71
> >  #define INV_MPU9255_WHOAMI_VALUE		0x73
> > +#define INV_MPU6515_WHOAMI_VALUE		0x74
> >  #define INV_ICM20608_WHOAMI_VALUE		0xAF
> >  
> >  /* scan element definition */  
> 
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

