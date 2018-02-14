Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3837409-1518642008-5-14732828559367961367
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, T_TVD_MIME_EPI 0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Attached: signature.asc
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-api-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1518642007; b=T6NjZJmjNDiToiBkUngQF1f9Q9Zatxw5SLbEf+EiP70p7Ma
    k1eYWR4DKNUd3HMSy4QJOi3Bpy4qM/vn3bm5dSf94dSHwKoSkrsvEJ5f+wfNFApw
    DcQ2JwnsnVHACm/Qv6yleXmHRbthXGNorM74bLqNJhJdZVC7y85pM6HfGBqtNsZl
    7vOVtSmfJ4NLeqUU6jM0hWmPUA9fLo/hIB1Y+J3qU1NKB2c9uTF2YgTPo6ObBvkn
    v9kCykYaE5fMXMatQra37wIyh9FWq3MHzgtz209Q9y9tIj/8/4duAXAb6oPCwLPB
    MUKPtq7TFdjfzix2WWr2KunllkzinVvyMcfMphg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=arctest; t=1518642007; bh=4h1rZjYZf7YUyDG61GQJpqDdeU
    QYi7G6/Ki3NasXN4Q=; b=vnSY/RETV40BWf5wdEPOYTdSDxPTR1tY5YyCQRWWSd
    cKAZMBYfSzkXp+U4jo7WhrgY6tOZztFUDkcLv4TrLgNtEi7Q3QKwD4+3aGM74pO0
    0dHL3VitPqxfE0mb8tMWgd5MCLVrI5PFCamY80rz1DwpcWLRDI30AJUtdqvymZlk
    JknIKzKn4WwhPownIucrSjnGslqy8hD4vTBjvdRH4JTLXrWfTWMLO30902cCOh3s
    EFy0Ed6e1FTc0EMk8EN0fgVdtMi7h96XAiwaNM4HnYxrathTC0DMa1l7NB650rrM
    Km/uE//NmlFg1xX3nugj1HyUTbTsk6MFjLsrcpRaFL3A==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=orgdomain_pass;
    x-google-dkim=fail (body has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=bI+Fs9iq;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=kernel.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=orgdomain_pass;
    x-google-dkim=fail (body has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=bI+Fs9iq;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=kernel.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1031072AbeBNVAF (ORCPT <rfc822;greg@kroah.com>);
        Wed, 14 Feb 2018 16:00:05 -0500
Received: from mail-pg0-f68.google.com ([74.125.83.68]:40341 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1030459AbeBNVAD (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 14 Feb 2018 16:00:03 -0500
X-Google-Smtp-Source: AH8x2253UwSNEdXzQurUqXSjKwKbuFf8/L/E+cosBpnkX8zFhPeULLKaTqtPpF3r44+0vM1EY1gYdQ==
Date: Wed, 14 Feb 2018 12:55:06 -0800
From: Moritz Fischer <mdf@kernel.org>
To: Wu Hao <hao.wu@intel.com>
Cc: atull@kernel.org, mdf@kernel.org, linux-fpga@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        luwei.kang@intel.com, yi.z.zhang@intel.com,
        Tim Whisonant <tim.whisonant@intel.com>,
        Enno Luebbers <enno.luebbers@intel.com>,
        Shiva Rao <shiva.rao@intel.com>,
        Christopher Rauer <christopher.rauer@intel.com>,
        Xiao Guangrong <guangrong.xiao@linux.intel.com>
Subject: Re: [PATCH v4 06/24] fpga: dfl: adds fpga_cdev_find_port
Message-ID: <20180214205506.GA25618@tyrael.ni.corp.natinst.com>
References: <1518513893-4719-1-git-send-email-hao.wu@intel.com>
 <1518513893-4719-7-git-send-email-hao.wu@intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="Q68bSM7Ycu6FN28Q"
Content-Disposition: inline
In-Reply-To: <1518513893-4719-7-git-send-email-hao.wu@intel.com>
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>


--Q68bSM7Ycu6FN28Q
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Hao,

On Tue, Feb 13, 2018 at 05:24:35PM +0800, Wu Hao wrote:
> For feature devices, we need a method to find the port dedicated
> to the device. This patch adds a function fpga_cdev_find_port
> for this purpose. e.g FPGA Management Engine (FME) Partial
> Reconfiguration sub feature, it uses this function to find
> dedicated port on the device for PR function implementation.
>=20
> Signed-off-by: Tim Whisonant <tim.whisonant@intel.com>
> Signed-off-by: Enno Luebbers <enno.luebbers@intel.com>
> Signed-off-by: Shiva Rao <shiva.rao@intel.com>
> Signed-off-by: Christopher Rauer <christopher.rauer@intel.com>
> Signed-off-by: Xiao Guangrong <guangrong.xiao@linux.intel.com>
> Signed-off-by: Wu Hao <hao.wu@intel.com>
Acked-by: Moritz Fischer <mdf@kernel.org>
> ---
> v3: s/fpga_for_each_port/fpga_cdev_find_port/
>     move fpga_cdev_find_port to fpga-dfl module.
> v4: improve description in commit message.
>     add comments to remind user to put_device after use this function.
> ---
>  drivers/fpga/dfl.c | 34 ++++++++++++++++++++++++++++++++++
>  drivers/fpga/dfl.h | 20 ++++++++++++++++++++
>  2 files changed, 54 insertions(+)
>=20
> diff --git a/drivers/fpga/dfl.c b/drivers/fpga/dfl.c
> index dcfe5ab..38dc819 100644
> --- a/drivers/fpga/dfl.c
> +++ b/drivers/fpga/dfl.c
> @@ -783,6 +783,40 @@ void fpga_remove_feature_devs(struct fpga_cdev *cdev)
>  }
>  EXPORT_SYMBOL_GPL(fpga_remove_feature_devs);
> =20
> +/**
> + * __fpga_cdev_find_port - find a port under given container device
> + *
> + * @cdev: container device
> + * @data: data passed to match function
> + * @match: match function used to find specific port from the port devic=
e list
> + *
> + * Find a port device under container device. This function needs to be
> + * invoked with lock held.
> + *
> + * This function returns NULL if the device doesn't match and non-zero i=
f it
> + * does. If this function returns non-zero and a reference to the platfo=
rm
> + * device of port can be obtained.
> + *
> + * NOTE: you will need to drop the device reference with put_device() af=
ter use.
> + */
> +struct platform_device *
> +__fpga_cdev_find_port(struct fpga_cdev *cdev, void *data,
> +		      int (*match)(struct platform_device *, void *))
> +{
> +	struct feature_platform_data *pdata;
> +	struct platform_device *port_dev;
> +
> +	list_for_each_entry(pdata, &cdev->port_dev_list, node) {
> +		port_dev =3D pdata->dev;
> +
> +		if (match(port_dev, data) && get_device(&port_dev->dev))
> +			return port_dev;
> +	}
> +
> +	return NULL;
> +}
> +EXPORT_SYMBOL_GPL(__fpga_cdev_find_port);
> +
>  int fpga_port_id(struct platform_device *pdev)
>  {
>  	void __iomem *base =3D get_feature_ioaddr_by_id(&pdev->dev,
> diff --git a/drivers/fpga/dfl.h b/drivers/fpga/dfl.h
> index 9b19399..d6ecda1 100644
> --- a/drivers/fpga/dfl.h
> +++ b/drivers/fpga/dfl.h
> @@ -356,4 +356,24 @@ struct fpga_cdev {
>  struct fpga_cdev *fpga_enumerate_feature_devs(struct fpga_enum_info *inf=
o);
>  void fpga_remove_feature_devs(struct fpga_cdev *cdev);
> =20
> +/*
> + * need to drop the device reference with put_device() after use port pl=
atform
> + * device returned by __fpga_cdev_find_port and fpga_cdev_find_port func=
tions.
> + */
> +struct platform_device *
> +__fpga_cdev_find_port(struct fpga_cdev *cdev, void *data,
> +		      int (*match)(struct platform_device *, void *));
> +
> +static inline struct platform_device *
> +fpga_cdev_find_port(struct fpga_cdev *cdev, void *data,
> +		    int (*match)(struct platform_device *, void *))
> +{
> +	struct platform_device *pdev;
> +
> +	mutex_lock(&cdev->lock);
> +	pdev =3D __fpga_cdev_find_port(cdev, data, match);
> +	mutex_unlock(&cdev->lock);
> +
> +	return pdev;
> +}
>  #endif /* __FPGA_DFL_H */
> --=20
> 2.7.4
>=20

Thanks,
Moritz

--Q68bSM7Ycu6FN28Q
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEowQ4eJSlIZpNWnl2UVwKRFcJcNgFAlqEoicACgkQUVwKRFcJ
cNi8lgf8DVZG8kd5D9+MQo+c1/Mgzgok7FgT261n9yUNqlxXBoaOv2pfrasDizK0
LirxHxRVQwNihPtxEy5qU0SNlMB1zg1ab1I+pFrNEexnNi6uNFlb98r9D62DfZjC
RZOAU8JjrhFt/9pOFmEXbNtu5bWnrh8k0QpEOnrXoywksf6x3pptC7i/iBjsJYY/
JHrdPxhR0h5dU/fVAI97wwi7Fh47VkK5v0QETuuwLU3vsgIsepyACMzlBVJ272XW
75evaFyLufgeVcJQBFrpHI6lxcOBOmETv/gtxU6zdT4b05z5U52FtvCJ8dv9TavD
Nmo58GqObWu7noL1Mpsg7g4KiHPDDg==
=BgP7
-----END PGP SIGNATURE-----

--Q68bSM7Ycu6FN28Q--
