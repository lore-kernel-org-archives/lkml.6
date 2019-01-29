Return-Path: <SRS0=gcLq=QF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8537AC169C4
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 06:52:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3CFFD2177E
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 06:52:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="bhYeKlHw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725773AbfA2Gwj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Jan 2019 01:52:39 -0500
Received: from hqemgate16.nvidia.com ([216.228.121.65]:16965 "EHLO
        hqemgate16.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725267AbfA2Gwj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jan 2019 01:52:39 -0500
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate16.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5c4ff80d0001>; Mon, 28 Jan 2019 22:51:57 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Mon, 28 Jan 2019 22:52:37 -0800
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Mon, 28 Jan 2019 22:52:37 -0800
Received: from [192.168.88.246] (172.20.13.39) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Tue, 29 Jan
 2019 06:52:35 +0000
Subject: Re: [2/2] mfd: max77620: Add low battery monitor support
To:     <blaws05@gmail.com>, <lee.jones@linaro.org>,
        <linux-kernel@vger.kernel.org>
CC:     <linux-tegra@vger.kernel.org>,
        Laxman Dewangan <ldewangan@nvidia.com>,
        Venkat Reddy Talla <vreddytalla@nvidia.com>
References: <3587c682-e1db-5140-fd8e-13c46d882dd3@gmail.com>
From:   Mark Zhang <markz@nvidia.com>
Message-ID: <bd942195-4f1c-1a39-283f-610354308f45@nvidia.com>
Date:   Tue, 29 Jan 2019 14:52:31 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <3587c682-e1db-5140-fd8e-13c46d882dd3@gmail.com>
X-Originating-IP: [172.20.13.39]
X-ClientProxiedBy: HQMAIL107.nvidia.com (172.20.187.13) To
 HQMAIL101.nvidia.com (172.20.187.10)
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1548744718; bh=1RuziyC2SsAua9mvzv9LkgMFFoKkse64z06Xao33WfM=;
        h=X-PGP-Universal:Subject:To:CC:References:From:Message-ID:Date:
         User-Agent:MIME-Version:In-Reply-To:X-Originating-IP:
         X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=bhYeKlHwfxDAPeaXG4ST9DBf0ZQfEFkKMEExP7HxfNJQqnpVUx/AG/pyqvOeUkVN/
         PJWhaccbDkwleDe3ahH0/KeF7c731omUU0OIjcus8QCHeMkxTO4ajQaMeWaVN+4Av2
         Lfd5N/ohtXL18CHsrQUOv3yCzTmGlPaulmCmlW0gK2yruOQIXXeXeTxgj68rP2bwRM
         yvS0osmNyC9VJBq3AtNecqDn20vodtHCsQ606MbD8eAk0pQ6xuFk1d/SeVmawDVZSs
         /iihY3EzQHGwmdW+PSoBTaZ2ArFLo99kpnQPm3wZfHtOh4sGvcEXhb0LFrdP+mat3j
         LvpUix+UlYowg==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/27/2019 10:54 PM, Billy Laws wrote:
>  >This patch adds PMIC configurations for low-battery
>  >monitoring by handling max77620 register CNFGGLBL1.
>  >
> It might be an idea to add lbhyst configuration here and support using
> custom lbdac values to specify a different cutoff point.

Yeah this patch doesn't have support to program LBHYST & LBDAC because
according to our experiences, we don't have requirement to modify them
when low battery monitor support added.

I think we can create a new patch to support these 2 fields in the future
when we really need them. Or you can create a patch if you have requirement
for them, is this OK to you Billy?

Mark

>=20
> See: https://datasheetspdf.com/pdf-file/924230/Maxim/MAX8698C/1=C2=A0 pg =
46
>  >Signed-off-by: Laxman Dewangan <ldewangan@nvidia.com>
>  >Signed-off-by: Venkat Reddy Talla <vreddytalla@nvidia.com>
>  >Signed-off-by: Mark Zhang <markz@nvidia.com>
>  >---
>  > drivers/mfd/max77620.c | 57 +++++++++++++++++++++++++++++++++++++++++-
>  > 1 file changed, 56 insertions(+), 1 deletion(-)
>  >
>  >diff --git a/drivers/mfd/max77620.c b/drivers/mfd/max77620.c
>  >index f58143103185..9e50d145afd8 100644
>  >--- a/drivers/mfd/max77620.c
>  >+++ b/drivers/mfd/max77620.c
>  >@@ -474,6 +474,57 @@ static int=20
> max77620_init_backup_battery_charging(struct max77620_chip *chip)
>  >=C2=A0 return ret;
>  > }
>  >
>  >+static int max77620_init_low_battery_monitor(struct max77620_chip *chi=
p)
>  >+{
>  >+ struct device *dev =3D chip->dev;
>  >+ struct device_node *np;
>  >+ bool pval;
>  >+ u8 mask =3D 0;
>  >+ u8 val =3D 0;
>  >+ int ret;
>  >+
>  >+ np =3D of_get_child_by_name(dev->of_node, "low-battery-monitor");
>  >+ if (!np) {
>  >+ dev_info(dev, "Low battery monitoring support disabled\n");
>  >+ return 0;
>  >+ }
>  >+
>  >+ pval =3D of_property_read_bool(np, "maxim,low-battery-dac-enable");
>  >+ if (pval) {
>  >+ mask |=3D MAX77620_CNFGGLBL1_LBDAC_EN;
>  >+ val |=3D MAX77620_CNFGGLBL1_LBDAC_EN;
>  >+ }
>  >+
>  >+ pval =3D of_property_read_bool(np, "maxim,low-battery-dac-disable");
>  >+ if (pval)
>  >+ mask |=3D MAX77620_CNFGGLBL1_LBDAC_EN;
>  >+
>  >+ pval =3D of_property_read_bool(np, "maxim,low-battery-shutdown-enable=
");
>  >+ if (pval) {
>  >+ mask |=3D MAX77620_CNFGGLBL1_MPPLD;
>  >+ val |=3D MAX77620_CNFGGLBL1_MPPLD;
>  >+ }
>  >+
>  >+ pval =3D of_property_read_bool(np, "maxim,low-battery-shutdown-disabl=
e");
>  >+ if (pval)
>  >+ mask |=3D MAX77620_CNFGGLBL1_MPPLD;
>  >+
>  >+ pval =3D of_property_read_bool(np, "maxim,low-battery-reset-enable");
>  >+ if (pval) {
>  >+ mask |=3D MAX77620_CNFGGLBL1_LBRSTEN;
>  >+ val |=3D MAX77620_CNFGGLBL1_LBRSTEN;
>  >+ }
>  >+
>  >+ pval =3D of_property_read_bool(np, "maxim,low-battery-reset-disable")=
;
>  >+ if (pval)
>  >+ mask |=3D MAX77620_CNFGGLBL1_LBRSTEN;
>  >+
>  >+ ret =3D regmap_update_bits(chip->rmap, MAX77620_REG_CNFGGLBL1, mask, =
val);
>  >+ if (ret < 0)
>  >+ dev_err(dev, "Reg CNFGGLBL1 update failed: %d\n", ret);
>  >+ return ret;
>  >+}
>  >+
>  > static int max77620_read_es_version(struct max77620_chip *chip)
>  > {
>  >=C2=A0 unsigned int val;
>  >@@ -563,7 +614,11 @@ static int max77620_probe(struct i2c_client *clien=
t,
>  >=C2=A0 if (ret < 0)
>  >=C2=A0 return ret;
>  >
>  >- ret =3D=C2=A0 devm_mfd_add_devices(chip->dev, PLATFORM_DEVID_NONE,
>  >+ ret =3D max77620_init_low_battery_monitor(chip);
>  >+ if (ret < 0)
>  >+ return ret;
>  >+
>  >+ ret =3D devm_mfd_add_devices(chip->dev, PLATFORM_DEVID_NONE,
>  >=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 mfd_cells, n_mfd_cells, NULL, 0,
>  >=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 regmap_irq_get_domain(chip->top_irq_data=
));
>  >=C2=A0 if (ret < 0) {
>=20
