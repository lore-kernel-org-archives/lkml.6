Return-Path: <SRS0=SmvU=O7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	T_DKIMWL_WL_HIGH autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26165C43612
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Dec 2018 17:23:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E348A21974
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Dec 2018 17:23:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545499436;
	bh=tfK8GXVHRc8eguZqSBemy1Mx2WbKhGjdXhtUQT8DRlo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=p7KK7dULJPdq5uyA5mi0knebbSFuC+rp28zGIW7N+KloZG5tjYrw/bfTRK/2UfEN3
	 GXp59KZn4evPhQC856iDda3eFKn9n7ZhSipabM7xg6dewL4cq3hskXS4F2g/IDx+nr
	 N2TK5CUIp+GWAWu4Uygguc/moZZL1Ont2ntwqjEQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404356AbeLVRXz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 22 Dec 2018 12:23:55 -0500
Received: from mail.kernel.org ([198.145.29.99]:55340 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731167AbeLVRXy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Dec 2018 12:23:54 -0500
Received: from archlinux (cpc91196-cmbg18-2-0-cust659.5-4.cable.virginm.net [81.96.234.148])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 42ABF21974;
        Sat, 22 Dec 2018 17:23:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1545499433;
        bh=tfK8GXVHRc8eguZqSBemy1Mx2WbKhGjdXhtUQT8DRlo=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=dlCo3waX3Uh2mu7fOi4aK76g1kCmGz+XuXe6Hr8PCIR7ay86YftkVeo9wzMdrhV+u
         vq6T8QhvOhuWfbm6ceK1F0/u/yci04ebmKObrJu9QKh3dcd//lv4zPyfgddabS9nsa
         njbT7sAsw2qK3WhmMUrdGst3dG7uE86Acgmg6g3Y=
Date:   Sat, 22 Dec 2018 17:23:46 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Tomasz Duszynski <tduszyns@gmail.com>
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] iio: chemical: sps30: add support for self cleaning
Message-ID: <20181222172346.7d520112@archlinux>
In-Reply-To: <20181218202809.25822-1-tduszyns@gmail.com>
References: <20181218202809.25822-1-tduszyns@gmail.com>
X-Mailer: Claws Mail 3.17.2 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 18 Dec 2018 21:28:09 +0100
Tomasz Duszynski <tduszyns@gmail.com> wrote:

> Self cleaning is especially useful in cases where sensor undergoes
> frequent power on/off cycles. In such scenarios it is recommended to
> turn self cleaning at least once per week in order to maintain reliable
> measurements.
> 
> Self cleaning is activated by writing 1 to a dedicated attribute.
> Internal fan accelerates to its maximum speed and keeps spinning
> for about 10 seconds blowing out accumulated dust.
> 
> Signed-off-by: Tomasz Duszynski <tduszyns@gmail.com>
Applied to the togreg branch of iio.git.   I took this today rather than
leaving it on the list for longer simply because I'm not sure I'll be
very timely in applying patches.

If anyone has any comments, it'll only be out as testing so we can
still modify if that make sense for at least the next couple of weeks.

Thanks,

Jonathan

> ---
> v2:
>  * removed TODO item
>  * sensor cleaning is not measurement related per se so drop in_ prefix
> 
>  Documentation/ABI/testing/sysfs-bus-iio-sps30 |  8 +++++
>  drivers/iio/chemical/sps30.c                  | 35 ++++++++++++++++++-
>  2 files changed, 42 insertions(+), 1 deletion(-)
>  create mode 100644 Documentation/ABI/testing/sysfs-bus-iio-sps30
> 
> diff --git a/Documentation/ABI/testing/sysfs-bus-iio-sps30 b/Documentation/ABI/testing/sysfs-bus-iio-sps30
> new file mode 100644
> index 000000000000..e7ce2c57635e
> --- /dev/null
> +++ b/Documentation/ABI/testing/sysfs-bus-iio-sps30
> @@ -0,0 +1,8 @@
> +What:		/sys/bus/iio/devices/iio:deviceX/start_cleaning
> +Date:		December 2018
> +KernelVersion:	4.22
> +Contact:	linux-iio@vger.kernel.org
> +Description:
> +		Writing 1 starts sensor self cleaning. Internal fan accelerates
> +		to its maximum speed and keeps spinning for about 10 seconds in
> +		order to blow out accumulated dust.
> diff --git a/drivers/iio/chemical/sps30.c b/drivers/iio/chemical/sps30.c
> index fa3cd409b90b..f3b4390c8f5c 100644
> --- a/drivers/iio/chemical/sps30.c
> +++ b/drivers/iio/chemical/sps30.c
> @@ -7,7 +7,6 @@
>   * I2C slave address: 0x69
>   *
>   * TODO:
> - *  - support for turning on fan cleaning
>   *  - support for reading/setting auto cleaning interval
>   */
> 
> @@ -37,6 +36,7 @@
>  #define SPS30_READ_DATA_READY_FLAG 0x0202
>  #define SPS30_READ_DATA 0x0300
>  #define SPS30_READ_SERIAL 0xd033
> +#define SPS30_START_FAN_CLEANING 0x5607
> 
>  enum {
>  	PM1,
> @@ -104,6 +104,7 @@ static int sps30_do_cmd(struct sps30_state *state, u16 cmd, u8 *data, int size)
>  		break;
>  	case SPS30_STOP_MEAS:
>  	case SPS30_RESET:
> +	case SPS30_START_FAN_CLEANING:
>  		ret = sps30_write_then_read(state, buf, 2, NULL, 0);
>  		break;
>  	case SPS30_READ_DATA_READY_FLAG:
> @@ -275,7 +276,39 @@ static int sps30_read_raw(struct iio_dev *indio_dev,
>  	return -EINVAL;
>  }
> 
> +static ssize_t start_cleaning_store(struct device *dev,
> +				    struct device_attribute *attr,
> +				    const char *buf, size_t len)
> +{
> +	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
> +	struct sps30_state *state = iio_priv(indio_dev);
> +	int val, ret;
> +
> +	if (kstrtoint(buf, 0, &val) || val != 1)
> +		return -EINVAL;
> +
> +	mutex_lock(&state->lock);
> +	ret = sps30_do_cmd(state, SPS30_START_FAN_CLEANING, NULL, 0);
> +	mutex_unlock(&state->lock);
> +	if (ret)
> +		return ret;
> +
> +	return len;
> +}
> +
> +static IIO_DEVICE_ATTR_WO(start_cleaning, 0);
> +
> +static struct attribute *sps30_attrs[] = {
> +	&iio_dev_attr_start_cleaning.dev_attr.attr,
> +	NULL
> +};
> +
> +static const struct attribute_group sps30_attr_group = {
> +	.attrs = sps30_attrs,
> +};
> +
>  static const struct iio_info sps30_info = {
> +	.attrs = &sps30_attr_group,
>  	.read_raw = sps30_read_raw,
>  };
> 
> --
> 2.20.1
> 

