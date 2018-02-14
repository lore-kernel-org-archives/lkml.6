Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3837409-1518642051-2-17168925194691802892
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
    t=1518642051; b=EKBvOx5roFwtM+OZIEPGgOTf6u5Z5l9jibMAarrSSs1f6qX
    cX0MwXthYVaDCc/Six7ygD2Pig353yanmlZhMK8H+NerKAlmAr19qbHZzrX+V9Wm
    o6PLFCOcShCUshEMzusg0QRoGVdA8743iU2D/a0gn2/y8ulIHYqTKXQfkyweP0v7
    z34f/nefVV0Pl+ubanBKfGbsbQw+gW1KkPuWR4Rr/T1M/IviJtFYevHNDQ0Rqye5
    TtlYCz1+G4j6WnP4XMn6membwhgt6euZt68pWjPCSUj0ZV7NSBAfUie/AyxefM6e
    x/jVheMqBrZcv4YFuy51il5TPot53jkqTUCPrwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=arctest; t=1518642051; bh=3ursfTJbJBIU1+dUjhzmluOat9
    VUfeDyer675fi2dGY=; b=I3v5Zm2XBXH6lTu9U8mWHx0gctN5sNoCpIf9qKQST1
    /+chdGjyi3EEqXDIkBXSugrRQ86N1nY5+jTFntSMyt+DZNd74Cr2Ej5a1i5xOeLj
    mGlZrrWlekBwzqCYaKNo6+8tPaPeVbC9MblEHG7PjD90O4FOfuUsHUffUT73qHxv
    3P4aFR1f4NSvjotOQOhnLME4ZHNgDXK79Joepcu5hJn5lFgz1L5ApR3WgFLKU/MP
    9wxKdy+fyQWWCupTO2JqaE8EhBjeyhH8aOmf9noZcZJn29f1AsWA2tPj/hdd4M+J
    OexNehkAwDfv2EGtj0V0z1ZFHUw96zWUoAvQ4cqgx7Pw==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=orgdomain_pass;
    x-google-dkim=fail (body has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=OhRcgEQl;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=kernel.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=orgdomain_pass;
    x-google-dkim=fail (body has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=OhRcgEQl;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=kernel.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1030830AbeBNVAt (ORCPT <rfc822;greg@kroah.com>);
        Wed, 14 Feb 2018 16:00:49 -0500
Received: from mail-pg0-f68.google.com ([74.125.83.68]:34570 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1030618AbeBNVAr (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 14 Feb 2018 16:00:47 -0500
X-Google-Smtp-Source: AH8x224m9Ot0DoIYqitLUYpgTjMB7mjfrzIHODLG5gHawYJC3mez2jiasYLHWgCARWDcG35UeO8xLw==
Date: Wed, 14 Feb 2018 12:55:50 -0800
From: Moritz Fischer <mdf@kernel.org>
To: Wu Hao <hao.wu@intel.com>
Cc: atull@kernel.org, mdf@kernel.org, linux-fpga@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        luwei.kang@intel.com, yi.z.zhang@intel.com
Subject: Re: [PATCH v4 03/24] fpga: mgr: add status for fpga-manager
Message-ID: <20180214205550.GB25618@tyrael.ni.corp.natinst.com>
References: <1518513893-4719-1-git-send-email-hao.wu@intel.com>
 <1518513893-4719-4-git-send-email-hao.wu@intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="l76fUT7nc3MelDdI"
Content-Disposition: inline
In-Reply-To: <1518513893-4719-4-git-send-email-hao.wu@intel.com>
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>


--l76fUT7nc3MelDdI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Hao,

with Alan's Feedback

On Tue, Feb 13, 2018 at 05:24:32PM +0800, Wu Hao wrote:
> This patch adds status to fpga-manager data structure, to allow
> driver to store full/partial reconfiguration errors and other
> status information, and adds one status callback to fpga_manager_ops
> to allow fpga_manager to collect latest status when failures are
> detected.
>=20
> The following sysfs file is created:
> * /sys/class/fpga_manager/<fpga>/status
>   Return status of fpga manager, including reconfiguration errors.
>=20
> Signed-off-by: Wu Hao <hao.wu@intel.com>

Acked-by: Moritz Fischer <mdf@kernel.org>
> ---
> v3: add one line description for status
>     add status callback function to fpga_manager_ops
>     update fpga-mgr status if any failure or during initialization
>     s/INCOMPATIBLE_BS_ERR/INCOMPATIBLE_IMAGE_ERR/
> v4: simply code per suggestion from Alan.
>     add supported status strings (and descriptions) in sysfs document.
>     remove unused error code (SECURE_LOAD_ERR).
> ---
>  Documentation/ABI/testing/sysfs-class-fpga-manager | 24 ++++++++++++++++=
+++
>  drivers/fpga/fpga-mgr.c                            | 28 ++++++++++++++++=
++++++
>  include/linux/fpga/fpga-mgr.h                      |  9 +++++++
>  3 files changed, 61 insertions(+)
>=20
> diff --git a/Documentation/ABI/testing/sysfs-class-fpga-manager b/Documen=
tation/ABI/testing/sysfs-class-fpga-manager
> index 23056c5..60db277 100644
> --- a/Documentation/ABI/testing/sysfs-class-fpga-manager
> +++ b/Documentation/ABI/testing/sysfs-class-fpga-manager
> @@ -35,3 +35,27 @@ Description:	Read fpga manager state as a string.
>  		* write complete	=3D Doing post programming steps
>  		* write complete error	=3D Error while doing post programming
>  		* operating		=3D FPGA is programmed and operating
> +
> +What:		/sys/class/fpga_manager/<fpga>/status
> +Date:		February 2018
> +KernelVersion:	4.16
> +Contact:	Wu Hao <hao.wu@intel.com>
> +Description:	Read fpga manager status as a string.
> +		If FPGA programming operation fails, it could be caused by crc
> +		error or incompatible bitstream image. The intent of this
> +		interface is to provide more detailed information for FPGA
> +		programming errors to userspace. This is a list of strings for
> +		the supported status.
> +
> +		* reconfig operation error 	- invalid operations detected by
> +						  reconfiguration hardware.
> +						  e.g start reconfiguration
> +						  with errors not cleared
> +		* reconfig CRC error		- CRC error detected by
> +						  reconfiguration hardware.
> +		* reconfig incompatible image	- reconfiguration image is
> +						  incompatible with hardware
> +		* reconfig IP protocol error	- protocol errors detected by
> +						  reconfiguration hardware
> +		* reconfig fifo overflow error	- FIFO overflow detected by
> +						  reconfiguration hardware
> diff --git a/drivers/fpga/fpga-mgr.c b/drivers/fpga/fpga-mgr.c
> index 245e7a6..50b7396 100644
> --- a/drivers/fpga/fpga-mgr.c
> +++ b/drivers/fpga/fpga-mgr.c
> @@ -397,12 +397,40 @@ static ssize_t state_show(struct device *dev,
>  	return sprintf(buf, "%s\n", state_str[mgr->state]);
>  }
> =20
> +static ssize_t status_show(struct device *dev,
> +			   struct device_attribute *attr, char *buf)
> +{
> +	struct fpga_manager *mgr =3D to_fpga_manager(dev);
> +	u64 status;
> +	int len =3D 0;
> +
> +	if (!mgr->mops->status)
> +		return -ENOENT;
> +
> +	status =3D mgr->mops->status(mgr);
> +
> +	if (status & FPGA_MGR_STATUS_OPERATION_ERR)
> +		len +=3D sprintf(buf + len, "reconfig operation error\n");
> +	if (status & FPGA_MGR_STATUS_CRC_ERR)
> +		len +=3D sprintf(buf + len, "reconfig CRC error\n");
> +	if (status & FPGA_MGR_STATUS_INCOMPATIBLE_IMAGE_ERR)
> +		len +=3D sprintf(buf + len, "reconfig incompatible image\n");
> +	if (status & FPGA_MGR_STATUS_IP_PROTOCOL_ERR)
> +		len +=3D sprintf(buf + len, "reconfig IP protocol error\n");
> +	if (status & FPGA_MGR_STATUS_FIFO_OVERFLOW_ERR)
> +		len +=3D sprintf(buf + len, "reconfig fifo overflow error\n");
> +
> +	return len;
> +}
> +
>  static DEVICE_ATTR_RO(name);
>  static DEVICE_ATTR_RO(state);
> +static DEVICE_ATTR_RO(status);
> =20
>  static struct attribute *fpga_mgr_attrs[] =3D {
>  	&dev_attr_name.attr,
>  	&dev_attr_state.attr,
> +	&dev_attr_status.attr,
>  	NULL,
>  };
>  ATTRIBUTE_GROUPS(fpga_mgr);
> diff --git a/include/linux/fpga/fpga-mgr.h b/include/linux/fpga/fpga-mgr.h
> index 6e98b66..6c79183 100644
> --- a/include/linux/fpga/fpga-mgr.h
> +++ b/include/linux/fpga/fpga-mgr.h
> @@ -112,6 +112,7 @@ struct fpga_image_info {
>   * struct fpga_manager_ops - ops for low level fpga manager drivers
>   * @initial_header_size: Maximum number of bytes that should be passed i=
nto write_init
>   * @state: returns an enum value of the FPGA's state
> + * @status: returns status of the FPGA, including reconfiguration error =
code
>   * @write_init: prepare the FPGA to receive confuration data
>   * @write: write count bytes of configuration data to the FPGA
>   * @write_sg: write the scatter list of configuration data to the FPGA
> @@ -126,6 +127,7 @@ struct fpga_image_info {
>  struct fpga_manager_ops {
>  	size_t initial_header_size;
>  	enum fpga_mgr_states (*state)(struct fpga_manager *mgr);
> +	u64 (*status)(struct fpga_manager *mgr);
>  	int (*write_init)(struct fpga_manager *mgr,
>  			  struct fpga_image_info *info,
>  			  const char *buf, size_t count);
> @@ -137,6 +139,13 @@ struct fpga_manager_ops {
>  	const struct attribute_group **groups;
>  };
> =20
> +/* FPGA manager status: Partial/Full Reconfiguration errors */
> +#define FPGA_MGR_STATUS_OPERATION_ERR		BIT(0)
> +#define FPGA_MGR_STATUS_CRC_ERR			BIT(1)
> +#define FPGA_MGR_STATUS_INCOMPATIBLE_IMAGE_ERR	BIT(2)
> +#define FPGA_MGR_STATUS_IP_PROTOCOL_ERR		BIT(3)
> +#define FPGA_MGR_STATUS_FIFO_OVERFLOW_ERR	BIT(4)
> +
>  /**
>   * struct fpga_manager - fpga manager structure
>   * @name: name of low level fpga manager
> --=20
> 2.7.4
>=20

--l76fUT7nc3MelDdI
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEowQ4eJSlIZpNWnl2UVwKRFcJcNgFAlqEolIACgkQUVwKRFcJ
cNiCBgf5AdCjqOIT/Zuc8MtaWYizG6WLKlMordYr+Ct+czrgrOlFvnVzMZ9GghWZ
uUFoKJJ43F3ov67PIjpvVhwQYCR07FtX52N0pwXsyc8ullwPBCaijPmgSjZW7wVV
33XE5IU6CTfIdDsvNQd/kSSmtEvv9r79+zgD+6nG5c9alB4yHxwmsKK7DXt/cMH5
n5gfN9OX3o3rkxcPZaLSazcU5jzlXYM9I6HfJyDN7o31PkFPuxraKEawD01+KTci
xeeX7MvZGVPCMr/AxjxUW63vQUMrkDltGUTcXXqjqjeWy2RBO8Yy1v5jDnj9iRQy
oeyfqR0hAOiflUDmCPXyJqxeV1CwSg==
=ql4b
-----END PGP SIGNATURE-----

--l76fUT7nc3MelDdI--
