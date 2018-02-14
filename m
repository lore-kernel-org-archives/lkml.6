Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3865763-1518642501-2-15355746280990308665
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, T_TVD_MIME_EPI 0.01, LANGUAGES ro,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Attached: signature.asc
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-api-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1518642500; b=kFz2g46T/htdGS2PfnvIBS51R2ycZsi/iIR25gMP0hm8Mp4
    6r/Fd/pFCtt+a8qYgiqTV2jIWH1pCYj2qrY1ZPM/tYrjbFMiSwHmYQqHng6pV+Y+
    040cqPe0jAQaoAcgNnYFOOfVAXkEGLPw9VUkc97jNGCjmqPR5D1LnAkv8ZpdksrM
    SjNIZxKT3WkLekxvpiniWebV2WVuusd/sPa9lPISssxtgEMS+uKck5zajIvNkY5N
    UqLabUojnE+6i4cMfQrIssrk/1eNP7FdE93BszJ3uhgyt+sjD/tyHzKg6n43Usws
    ZXCHeyAtkzHGPkokKWb+kvmydgvyoXvsLJLx2qA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=arctest; t=1518642500; bh=jpQmPAqyrjRV4/JI2su1kYU0iN
    cAfdNwYYcs/xEOcuE=; b=VEHE9fVvHjGtsm+SMyX20QpYwLY4QPzzHQBounpI3B
    ETGNGdxLbMn5a5nJOcVNf7raABn2P+WjhDSqfTPwc07Ci3yrU1Yh70nwYVQxLkcy
    d4RQpUPHmO3YQ3lTxi7FTw8dPagNokVHljS8AUA/3MsSUzqusIS3nUDslNLYsI88
    dmS2PtZO4s8p6h+TstfOXnA/3v2T4atKtNkHQ7eNDpwF9laglD+foj1SpMdhXIrQ
    O9BjQnNPKyUOqoJbFRhYY7cFLcQkjlSrszSl31HI1R0lyO6rqx9mrnt48rj18sXG
    3HYvsn9VT7aovSf6LwG5CzXn8C5MBqmSw8wbBtNYzOfQ==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=orgdomain_pass;
    x-google-dkim=fail (body has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=hrjtA9Ca;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=kernel.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=orgdomain_pass;
    x-google-dkim=fail (body has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=hrjtA9Ca;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=kernel.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1030687AbeBNVIT (ORCPT <rfc822;greg@kroah.com>);
        Wed, 14 Feb 2018 16:08:19 -0500
Received: from mail-pl0-f66.google.com ([209.85.160.66]:36940 "EHLO
        mail-pl0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1030649AbeBNVIR (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 14 Feb 2018 16:08:17 -0500
X-Google-Smtp-Source: AH8x226DM9PyFu77H1LbSJiliD7x8tcUDQl/U0qRrdXaS3/bDeVJkXGQeo8xXXLrma/0Nm+le33ARA==
Date: Wed, 14 Feb 2018 13:03:19 -0800
From: Moritz Fischer <mdf@kernel.org>
To: Wu Hao <hao.wu@intel.com>
Cc: atull@kernel.org, mdf@kernel.org, linux-fpga@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        luwei.kang@intel.com, yi.z.zhang@intel.com,
        Xiao Guangrong <guangrong.xiao@linux.intel.com>,
        Tim Whisonant <tim.whisonant@intel.com>,
        Enno Luebbers <enno.luebbers@intel.com>,
        Shiva Rao <shiva.rao@intel.com>,
        Christopher Rauer <christopher.rauer@intel.com>
Subject: Re: [PATCH v4 07/24] fpga: dfl: add feature device infrastructure
Message-ID: <20180214210319.GC25618@tyrael.ni.corp.natinst.com>
References: <1518513893-4719-1-git-send-email-hao.wu@intel.com>
 <1518513893-4719-8-git-send-email-hao.wu@intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="da4uJneut+ArUgXk"
Content-Disposition: inline
In-Reply-To: <1518513893-4719-8-git-send-email-hao.wu@intel.com>
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>


--da4uJneut+ArUgXk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

HI Hao,

On Tue, Feb 13, 2018 at 05:24:36PM +0800, Wu Hao wrote:
> From: Xiao Guangrong <guangrong.xiao@linux.intel.com>
>=20
> This patch abstracts the common operations of the sub features, and defin=
es
> the feature_ops data structure, including init, uinit and ioctl function
> pointers. And this patch adds some common helper functions for FME and AFU
> drivers, e.g feature_dev_use_begin/end which are used to ensure exclusive
> usage of the feature device file.
>=20
> Signed-off-by: Tim Whisonant <tim.whisonant@intel.com>
> Signed-off-by: Enno Luebbers <enno.luebbers@intel.com>
> Signed-off-by: Shiva Rao <shiva.rao@intel.com>
> Signed-off-by: Christopher Rauer <christopher.rauer@intel.com>
> Signed-off-by: Kang Luwei <luwei.kang@intel.com>
> Signed-off-by: Zhang Yi <yi.z.zhang@intel.com>
> Signed-off-by: Xiao Guangrong <guangrong.xiao@linux.intel.com>
> Signed-off-by: Wu Hao <hao.wu@intel.com>
> ---
> v2: rebased
> v3: use const for feature_ops.
>     replace pci related function.
> v4: rebase and add more comments in code.
> ---
>  drivers/fpga/dfl.c | 59 +++++++++++++++++++++++++++++++++++++
>  drivers/fpga/dfl.h | 85 ++++++++++++++++++++++++++++++++++++++++++++++++=
+++++-
>  2 files changed, 143 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/fpga/dfl.c b/drivers/fpga/dfl.c
> index 38dc819..c0aad87 100644
> --- a/drivers/fpga/dfl.c
> +++ b/drivers/fpga/dfl.c
> @@ -74,6 +74,65 @@ static enum fpga_id_type feature_dev_id_type(struct pl=
atform_device *pdev)
>  	return FPGA_ID_MAX;
>  }
> =20
> +void fpga_dev_feature_uinit(struct platform_device *pdev)
> +{
> +	struct feature *feature;
> +	struct feature_platform_data *pdata =3D dev_get_platdata(&pdev->dev);
See comment below w.r.t ordering declarations. Not a must for sure.
> +
> +	fpga_dev_for_each_feature(pdata, feature)
> +		if (feature->ops) {
> +			feature->ops->uinit(pdev, feature);
> +			feature->ops =3D NULL;
> +		}
> +}
> +EXPORT_SYMBOL_GPL(fpga_dev_feature_uinit);
> +
> +static int
> +feature_instance_init(struct platform_device *pdev,
> +		      struct feature_platform_data *pdata,
> +		      struct feature *feature, struct feature_driver *drv)
> +{
> +	int ret;
> +
> +	WARN_ON(!feature->ioaddr);

Not sure I understand correctly, is the !feature->ioaddr a use-case that
happens? If not just return early.
> +
> +	ret =3D drv->ops->init(pdev, feature);
> +	if (ret)
> +		return ret;
> +
> +	feature->ops =3D drv->ops;
> +
> +	return ret;
> +}
> +
> +int fpga_dev_feature_init(struct platform_device *pdev,
> +			  struct feature_driver *feature_drvs)
> +{
> +	struct feature *feature;
> +	struct feature_driver *drv =3D feature_drvs;
> +	struct feature_platform_data *pdata =3D dev_get_platdata(&pdev->dev);
> +	int ret;
We don't have clear guidelines here, but some subsystems want reverse
X-Mas tree declarations.
> +
> +	while (drv->ops) {
> +		fpga_dev_for_each_feature(pdata, feature) {
> +			/* match feature and drv using id */
> +			if (feature->id =3D=3D drv->id) {
> +				ret =3D feature_instance_init(pdev, pdata,
> +							    feature, drv);
> +				if (ret)
> +					goto exit;
> +			}
> +		}
> +		drv++;
> +	}
> +
> +	return 0;
> +exit:
> +	fpga_dev_feature_uinit(pdev);
> +	return ret;
> +}
> +EXPORT_SYMBOL_GPL(fpga_dev_feature_init);
> +
>  struct fpga_chardev_info {
>  	const char *name;
>  	dev_t devt;
> diff --git a/drivers/fpga/dfl.h b/drivers/fpga/dfl.h
> index d6ecda1..ede1e95 100644
> --- a/drivers/fpga/dfl.h
> +++ b/drivers/fpga/dfl.h
> @@ -132,6 +132,17 @@
>  #define PORT_CTRL_SFTRST_ACK	BIT(4)			/* HW ack for reset */
> =20
>  /**
> + * struct feature_driver - sub feature's driver
> + *
> + * @id:	sub feature id.
> + * @ops: ops of this sub feature.
> + */
> +struct feature_driver {
> +	u64 id;
> +	const struct feature_ops *ops;
> +};
> +
> +/**
>   * struct feature - sub feature of the feature devices
>   *
>   * @id:	sub feature id.
> @@ -139,13 +150,17 @@
>   *		    this index is used to find its mmio resource from the
>   *		    feature dev (platform device)'s reources.
>   * @ioaddr: mapped mmio resource address.
> + * @ops: ops of this sub feature.
>   */
>  struct feature {
>  	u64 id;
>  	int resource_index;
>  	void __iomem *ioaddr;
> +	const struct feature_ops *ops;
>  };
> =20
> +#define DEV_STATUS_IN_USE	0
> +
>  /**
>   * struct feature_platform_data - platform data for feature devices
>   *
> @@ -155,6 +170,8 @@ struct feature {
>   * @dev: ptr to platform device linked with this platform data.
>   * @disable_count: count for port disable.
>   * @num: number for sub features.
> + * @dev_status: dev status (e.g DEV_STATUS_IN_USE).
> + * @private: ptr to feature dev private data.
>   * @features: sub features of this feature dev.
>   */
>  struct feature_platform_data {
> @@ -163,11 +180,44 @@ struct feature_platform_data {
>  	struct cdev cdev;
>  	struct platform_device *dev;
>  	unsigned int disable_count;
> -
> +	unsigned long dev_status;
> +	void *private;
>  	int num;
>  	struct feature features[0];
>  };
> =20
> +static inline int feature_dev_use_begin(struct feature_platform_data *pd=
ata)
> +{
> +	/* Test and set IN_USE flags to ensure file is exclusively used */
> +	if (test_and_set_bit_lock(DEV_STATUS_IN_USE, &pdata->dev_status))
> +		return -EBUSY;
> +
> +	return 0;
> +}
> +
> +static inline void feature_dev_use_end(struct feature_platform_data *pda=
ta)
> +{
> +	clear_bit_unlock(DEV_STATUS_IN_USE, &pdata->dev_status);
> +}
> +
> +static inline void
> +fpga_pdata_set_private(struct feature_platform_data *pdata, void *privat=
e)
> +{
> +	pdata->private =3D private;
> +}
> +
> +static inline void *fpga_pdata_get_private(struct feature_platform_data =
*pdata)
> +{
> +	return pdata->private;
> +}
> +
> +struct feature_ops {
> +	int (*init)(struct platform_device *pdev, struct feature *feature);
> +	void (*uinit)(struct platform_device *pdev, struct feature *feature);
> +	long (*ioctl)(struct platform_device *pdev, struct feature *feature,
> +		      unsigned int cmd, unsigned long arg);
> +};
> +
>  #define FPGA_FEATURE_DEV_FME		"dfl-fme"
>  #define FPGA_FEATURE_DEV_PORT		"dfl-port"
> =20
> @@ -177,6 +227,10 @@ static inline int feature_platform_data_size(const i=
nt num)
>  		num * sizeof(struct feature);
>  }
> =20
> +void fpga_dev_feature_uinit(struct platform_device *pdev);
> +int fpga_dev_feature_init(struct platform_device *pdev,
> +			  struct feature_driver *feature_drvs);
> +
>  enum fpga_devt_type {
>  	FPGA_DEVT_FME,
>  	FPGA_DEVT_PORT,
> @@ -257,6 +311,15 @@ static inline int fpga_port_reset(struct platform_de=
vice *pdev)
>  	return ret;
>  }
> =20
> +static inline
> +struct platform_device *fpga_inode_to_feature_dev(struct inode *inode)
> +{
> +	struct feature_platform_data *pdata;
> +
> +	pdata =3D container_of(inode->i_cdev, struct feature_platform_data, cde=
v);
> +	return pdata->dev;
> +}
> +
>  #define fpga_dev_for_each_feature(pdata, feature)			    \
>  	for ((feature) =3D (pdata)->features;				    \
>  	   (feature) < (pdata)->features + (pdata)->num; (feature)++)
> @@ -284,6 +347,17 @@ static inline void __iomem *get_feature_ioaddr_by_id=
(struct device *dev, u64 id)
>  	return NULL;
>  }
> =20
> +static inline bool is_feature_present(struct device *dev, u64 id)
> +{
> +	return !!get_feature_ioaddr_by_id(dev, id);
> +}
> +
> +static inline struct device *
> +fpga_pdata_to_parent(struct feature_platform_data *pdata)
> +{
> +	return pdata->dev->dev.parent->parent;
> +}
> +
>  static inline bool feature_is_fme(void __iomem *base)
>  {
>  	u64 v =3D readq(base + DFH);
> @@ -376,4 +450,13 @@ fpga_cdev_find_port(struct fpga_cdev *cdev, void *da=
ta,
> =20
>  	return pdev;
>  }
> +
> +static inline struct fpga_cdev *
> +fpga_pdata_to_fpga_cdev(struct feature_platform_data *pdata)
> +{
> +	struct device *dev =3D pdata->dev->dev.parent;
> +	struct fpga_region *region =3D to_fpga_region(dev);
> +
> +	return container_of(region, struct fpga_cdev, region);
> +}
>  #endif /* __FPGA_DFL_H */
> --=20
> 2.7.4
>=20

Thanks,
Moritz

--da4uJneut+ArUgXk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEowQ4eJSlIZpNWnl2UVwKRFcJcNgFAlqEpBQACgkQUVwKRFcJ
cNjSRAf+LhReDDmB8JFHGcb/vTAOftz0Pd8wWYUo7Qw7vTLnP8xocPKYzqnekilQ
9nihgsoeoE2ezwbt2L2xRMyqstDYk2r26sD98WqeQi788TXxB4U1c4+16f5hV9In
0L+epZd5Ocm+mo0cfb1Yvwg1QCLDbauWEgJgkaPm0sPmAtRVy9+2v1LhpLCwO03u
O6ccWlEy9hO/hy6ENlpdGJuqX/fr7RJL6yEYnuisLSw6nMzSNe5qmpVPExx3MUJX
Pb/44/XbFcdr2akqKP6IxMRO1NOybhIHJtlVLldnyoZRQmuExRDplrYMo+Ad/iY9
AYCpBIPy0VHLGeDOH1YVlKl/aSUh2w==
=kobZ
-----END PGP SIGNATURE-----

--da4uJneut+ArUgXk--
