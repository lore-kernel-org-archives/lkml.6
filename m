Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16A37C04EB8
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 21:52:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D88A72146D
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 21:52:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D88A72146D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=brown.name
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726011AbeLFVwL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Dec 2018 16:52:11 -0500
Received: from mx2.suse.de ([195.135.220.15]:44846 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725935AbeLFVwL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Dec 2018 16:52:11 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 22381B068;
        Thu,  6 Dec 2018 21:52:09 +0000 (UTC)
From:   NeilBrown <neil@brown.name>
To:     Nishad Kamdar <nishadkamdar@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Joe Perches <joe@perches.com>
Date:   Fri, 07 Dec 2018 08:51:58 +1100
Cc:     devel@driverdev.osuosl.org,
        Christian =?utf-8?Q?L=C3=BCtke-Stetzkamp?= <christian@lkamp.de>,
        linux-kernel@vger.kernel.org,
        Dan Carpenter <dan.carpenter@oracle.com>
Subject: Re: [PATCH v2] staging: mt7621-mmc: Fix incompletely removed #if 0 block in sd.c
In-Reply-To: <20181206155659.GA15420@nishad>
References: <20181206155659.GA15420@nishad>
Message-ID: <87d0qee329.fsf@notabene.neil.brown.name>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
        micalg=pgp-sha256; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 06 2018, Nishad Kamdar wrote:

> Commit 2a54e3259e2a ("staging: mt7621-mmc: Remove #if 0 blocks in sd.c")
> does not completely remove an #if 0 block in sd.c. This causes the functi=
on
> msdc_select_clksrc() which was eariler not compiled, to be compiled.
> That causes an error - MSDC_CLKSRC_REG is not defined.
>
> This patch completely removes the #if 0 block
>
> Reported-by: NeilBrown <neil@brown.name>
> Fixes: 2a54e3259e2a ("staging: mt7621-mmc: Remove #if 0 blocks in sd.c")
> Signed-off-by: Nishad Kamdar <nishadkamdar@gmail.com>
> ---

Perfect, thanks.
 Reviewed-by: NeilBrown <neil@brown.name>

NeilBrown


> Changes in v2:
>  - Modify commit message
>  - Include Fixes: and Reported-by: tags
> ---
>  drivers/staging/mt7621-mmc/sd.c | 20 --------------------
>  1 file changed, 20 deletions(-)
>
> diff --git a/drivers/staging/mt7621-mmc/sd.c b/drivers/staging/mt7621-mmc=
/sd.c
> index 7b66f9b0a094..3d918e481bd8 100644
> --- a/drivers/staging/mt7621-mmc/sd.c
> +++ b/drivers/staging/mt7621-mmc/sd.c
> @@ -216,26 +216,6 @@ static void msdc_tasklet_card(struct work_struct *wo=
rk)
>  	spin_unlock(&host->lock);
>  }
>=20=20
> -static void msdc_select_clksrc(struct msdc_host *host, unsigned char clk=
src)
> -{
> -	u32 val;
> -
> -	BUG_ON(clksrc > 3);
> -
> -	val =3D readl(host->base + MSDC_CLKSRC_REG);
> -	if (readl(host->base + MSDC_ECO_VER) >=3D 4) {
> -		val &=3D ~(0x3  << clk_src_bit[host->id]);
> -		val |=3D clksrc << clk_src_bit[host->id];
> -	} else {
> -		val &=3D ~0x3; val |=3D clksrc;
> -	}
> -	writel(val, host->base + MSDC_CLKSRC_REG);
> -
> -	host->hclk =3D hclks[clksrc];
> -	host->hw->clk_src =3D clksrc;
> -}
> -#endif /* end of --- */
> -
>  static void msdc_set_mclk(struct msdc_host *host, int ddr, unsigned int =
hz)
>  {
>  	//struct msdc_hw *hw =3D host->hw;
> --=20
> 2.17.1

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEG8Yp69OQ2HB7X0l6Oeye3VZigbkFAlwJmf8ACgkQOeye3VZi
gbnE3w//aBUZMawbeSd0S94XmK0KiTxFv3Adi0FDK+nYX8su4lqlRcETPbMBdUUG
NGz1BLc1hxI9nqD0BGtu5hGrDtA6yHawl2lWZU0c10nXlDCTciTzZnbrFSfx7bw4
tlFOHuBGLq+bkBXaywC+aQe3z7/2l50D6aaoYqkcI4mEMByJpx0t+7YVVkx5G4I9
3EqWEuKrzlkMSyiJR0x73LKeg3Xt/IoUReI0PzdSczxe01sIi7bpi2/qAeUcTrkj
rhfs7gnudW/y6jKKyAHCEnbenyg7ee6C0LWflXU4nE+361W2CAto2K9g7cBZGFCP
OJoI4Xhb08KWA3k8Tyb6IX0prYn0lsIcDorlYPBPLk808vroH4q38b6u3beOe9Nw
J5FrsmSNimRz5bvQbBqlkiUuCVAmI+kIjBkCzXHV8poTXv8bEIIKOmbSKleITVBP
cRrpQwxpfZwRxlU0/mCPhRl9uNd5bSP9Q0PkRPni49vb93fxDfRyrfi8V28IAU0Z
xtkQSoyvk0MaMpOUghF5VtVoF5VMdZUY6LVDgrCOS/mHsfFjI53ozVvCOGVUpN1Z
s4Y+Rtuy9f5fYaF0qLRpX4T3LWSjJxiQiohc3CqZ8NO6s95cxTXSeJzo0eVHoyky
RQ4I5sJTH0p/OKqbd+DdxyXRJBQnO5lCxWwhpBBGehePxUQmY/M=
=HVG9
-----END PGP SIGNATURE-----
--=-=-=--
