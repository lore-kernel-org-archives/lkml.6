Return-Path: <SRS0=Xm/m=NJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C09BC2BC61
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 13:46:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 039EA2084A
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 13:46:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="IFkvkhEq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 039EA2084A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726580AbeJ2WfP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Oct 2018 18:35:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:41760 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725964AbeJ2WfP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Oct 2018 18:35:15 -0400
Received: from earth.universe (host-091-097-041-006.ewe-ip-backbone.de [91.97.41.6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4FD4520657;
        Mon, 29 Oct 2018 13:46:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1540820790;
        bh=xxlx0ykMwfiZ1Qgu3JPxjLMrfBo5tiTcmknPEom9sE0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=IFkvkhEq3yCJKryBxUgLNQRx5XvElG9pe83YAkm2VYX152P9ghiMoI2krd5p7TSmK
         Cno3tbI9FcBI2sfNsw1T6wxJr8S0K4dbz6lWX8/yf06UXHv2x3FchL27x5FPTIvjyJ
         iRU/L9ZEZcOPv9KbYY/dMa+DLlbDCFLHf2tJ4rjY=
Received: by earth.universe (Postfix, from userid 1000)
        id 582C23C08A5; Mon, 29 Oct 2018 14:46:28 +0100 (CET)
Date:   Mon, 29 Oct 2018 14:46:28 +0100
From:   Sebastian Reichel <sre@kernel.org>
To:     Steffen Vogel <post@steffenvogel.de>
Cc:     linux-kernel@vger.kernel.org, Evgeniy Polyakov <zbr@ioremap.net>
Subject: Re: [PATCH 5/9] w1: use octal numbers instead of macros for file mode
Message-ID: <20181029134628.dq6eroc5ypmzrkoz@earth.universe>
References: <20181028220927.56227-1-post@steffenvogel.de>
 <20181028220927.56227-6-post@steffenvogel.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="q5taw6g2bvcjv7de"
Content-Disposition: inline
In-Reply-To: <20181028220927.56227-6-post@steffenvogel.de>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--q5taw6g2bvcjv7de
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Sun, Oct 28, 2018 at 11:09:24PM +0100, Steffen Vogel wrote:
> This satifies a warning raised by the checkpatch tool.
>=20
> Signed-off-by: Steffen Vogel <post@steffenvogel.de>
> ---
>  drivers/w1/w1.c | 24 ++++++++++++------------
>  1 file changed, 12 insertions(+), 12 deletions(-)
>=20
> diff --git a/drivers/w1/w1.c b/drivers/w1/w1.c
> index f64da16dbec9..bad2ee26cd4e 100644
> --- a/drivers/w1/w1.c
> +++ b/drivers/w1/w1.c
> @@ -554,18 +554,18 @@ static ssize_t w1_master_attribute_store_remove(str=
uct device *dev,
>  		       w1_master_attribute_show_##_name,	\
>  		       w1_master_attribute_store_##_name)
> =20
> -static W1_MASTER_ATTR_RO(name, S_IRUGO);
> -static W1_MASTER_ATTR_RO(slaves, S_IRUGO);
> -static W1_MASTER_ATTR_RO(slave_count, S_IRUGO);
> -static W1_MASTER_ATTR_RW(max_slave_count, S_IRUGO | S_IWUSR | S_IWGRP);
> -static W1_MASTER_ATTR_RO(attempts, S_IRUGO);
> -static W1_MASTER_ATTR_RO(timeout, S_IRUGO);
> -static W1_MASTER_ATTR_RO(timeout_us, S_IRUGO);
> -static W1_MASTER_ATTR_RO(pointer, S_IRUGO);
> -static W1_MASTER_ATTR_RW(search, S_IRUGO | S_IWUSR | S_IWGRP);
> -static W1_MASTER_ATTR_RW(pullup, S_IRUGO | S_IWUSR | S_IWGRP);
> -static W1_MASTER_ATTR_RW(add, S_IRUGO | S_IWUSR | S_IWGRP);
> -static W1_MASTER_ATTR_RW(remove, S_IRUGO | S_IWUSR | S_IWGRP);
> +static W1_MASTER_ATTR_RO(name, 0444);
> +static W1_MASTER_ATTR_RO(slaves, 0444);
> +static W1_MASTER_ATTR_RO(slave_count, 0444);
> +static W1_MASTER_ATTR_RW(max_slave_count, 0664);
> +static W1_MASTER_ATTR_RO(attempts, 0444);
> +static W1_MASTER_ATTR_RO(timeout, 0444);
> +static W1_MASTER_ATTR_RO(timeout_us, 0444);
> +static W1_MASTER_ATTR_RO(pointer, 0444);
> +static W1_MASTER_ATTR_RW(search, 0664);
> +static W1_MASTER_ATTR_RW(pullup, 0664);
> +static W1_MASTER_ATTR_RW(add, 0664);
> +static W1_MASTER_ATTR_RW(remove, 0664);

Since the permissions are the same for all instances, the macros
could be simplified further (e.g. W1_MASTER_ATTR_RW(remove)).

-- Sebastian

--q5taw6g2bvcjv7de
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAlvXDzEACgkQ2O7X88g7
+prjkQ/8CUwvwB+XzOEmsOzb0aqPGf+4HK6uGu1Mv/rYwoSfMlrzqRauJUqxf2+x
XikNOQXfXxRioIWgr2hhxoYz6qrYS45/1jIPtOt59jSWr9DD9AXYzZSjUkYvUCqe
a43atMGggA2dxmxg+c2yx0BH7Zao09/A1LaXqKUGL8Y4EfqivR5Sd8IHpR4KRN3Y
0bntSPQff6PTsur6mjTfNCK3I7A2SH5WhesXmlrn7MtqUxq6BjXgt96LGsRE7LI/
AMpWC5aOb9VqGUNJw54W5HUaD1lZ4F3R5OCjWaUYqjz9d8gY/FHa5en9FEDyuf8/
JK+LnfoDw0TuI68yyjrlyPO/MHaco7+jxc5X40wIZM2IAmpwIBvbMo9rjjFaiZei
KaaaLWt5PKqT0unEzR7UGkfA05Wcc556CViALH3PLCLAHoJYwuYSTRJRHUR7HOdS
O4ccqMOcEpGmlyx6eFkPL/VX3sN3aGg8SMj5rx8YrpofALQSuDdus42tJkinJio1
GVBbFRpMa+VIeRAeUN3t0oStF/jo26WnljvQq/AD+DNTFzLiQm7uRHGSue3Fvmfb
BAKQLXGx8r39tMTE+WKvl5k0R+/ZPe25qCJnBEROqm69GRWgGoRXUAffOU2hnmpM
z1ZNu52F6kV+EOL8k6Y/xdwP8qPmuyA6SI+/EVea/CvRKBYZ7J8=
=F1jp
-----END PGP SIGNATURE-----

--q5taw6g2bvcjv7de--
