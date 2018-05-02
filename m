Return-Path: <prvs=166075862b=stefan.potyra@elektrobit.com>
X-Google-Smtp-Source: AB8JxZqEDlDVwqH7tdZIF02dS+ckKDi5HgeL3zRpkRk59HZMo+MYaHPbsx7LKquQ7SJ7rtl8d/aO
ARC-Seal: i=1; a=rsa-sha256; t=1525251334; cv=none;
        d=google.com; s=arc-20160816;
        b=fCknp43ZMCW//T0i59MMg2mEclrNtUjnn9nRFmIW7r+pcJeKyD6O4kg3Pu9SULBtSD
         /AVInLRpnWstNYPMFjBIm5r5KRj42MHT5FunL+Fj95P1Jx2DzGPSvE1D+SMIZcHstmxf
         dNeSptBYxfeol2Ej/WhnAiOVSXsosuMkH8cg3AbHwRLYhy5o2VpF0AyJeG7rSfjzkEHl
         KJKuuq/ysqYHAyJUXHVmS7KctgdW2WqmtmfDsTQLTd8uI4UK6UpTMMPki76F4cpFTnBf
         RTCAVcQWKI21WmtqgCWEQsz8ZiHOyyxci9bDQOyti3oXcDftz4QATpXXYAAk1SQRu1Lt
         LmJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:arc-authentication-results;
        bh=DAA3c2NAgJG2i5QsGHdWI0i1mz2j8qYMCrwzD02DMII=;
        b=D5u76pKI/ouct/l8vLaP7mayypLfpgS9qdVnce3U8n7H3G9GHilMiK8XeZVsUdJFHc
         ewPISu1bjXNQdslMJrydXt/4niTPD1UO7ShfSfBv7N5Plhkno14yYrC8sLJMma9Ry4uS
         MwQr1Ab8Ol2uW9uuR5lzaZHS/UG+SYXfAMz8DwYS/18BdExLhGx98CSRzMoXU7DvMcln
         bSacdymyMz41NyTM9ci5mOH85YkFc7AQGfueV4bgPiPAoe09uqHtNvu8rvIMMpepZSwS
         F8ctrcZF4HGz9Zf2uqI9Lln8QNyuK3YqVTiNwBlOhQWncZNlLTqKSK+0vtSvV3ajlJni
         YkVQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of prvs=166075862b=stefan.potyra@elektrobit.com designates 213.95.163.141 as permitted sender) smtp.mailfrom=prvs=166075862b=stefan.potyra@elektrobit.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of prvs=166075862b=stefan.potyra@elektrobit.com designates 213.95.163.141 as permitted sender) smtp.mailfrom=prvs=166075862b=stefan.potyra@elektrobit.com
Date: Wed, 2 May 2018 10:55:31 +0200
From: Stefan Potyra <Stefan.Potyra@elektrobit.com>
To: Evgeniy Polyakov <zbr@ioremap.net>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Greg
 Kroah-Hartman <gregkh@linuxfoundation.org>,
        "ldv-project@linuxtesting.org"
	<ldv-project@linuxtesting.org>,
        "sil2review@lists.osadl.org"
	<sil2review@lists.osadl.org>
Subject: [PATCH v2] w1: mxc_w1: Enable clock before calling clk_get_rate() on
 it
Message-ID: <20180502085531.GA10525@er01809n.ebgroup.elektrobit.com>
References: <20180419130254.7nriykiybpyi6j2g@agrajag.zerfleddert.de>
 <4863111525100577@web2o.yandex.ru>
 <20180502083420.GA8549@er01809n.ebgroup.elektrobit.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="liOOAslEiF7prFVr"
Content-Disposition: inline
In-Reply-To: <20180502083420.GA8549@er01809n.ebgroup.elektrobit.com>
User-Agent: Mutt/1.9.5 (2018-04-13)
X-Originating-IP: [10.0.24.181]
X-ClientProxiedBy: denue6es006.ebgroup.elektrobit.com (10.5.139.20) To
 denue6es008.ebgroup.elektrobit.com (10.5.139.25)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1599341943708820209?=
X-GMAIL-MSGID: =?utf-8?q?1599341943708820209?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

--liOOAslEiF7prFVr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

According to the API, you may only call clk_get_rate() after actually
enabling it.

Found by Linux Driver Verification project (linuxtesting.org).

Fixes: a5fd9139f74c ("w1: add 1-wire master driver for i.MX27 / i.MX31")
Signed-off-by: Stefan Potyra <Stefan.Potyra@elektrobit.com>
Acked-by: Evgeniy Polyakov <zbr@ioremap.net>
Cc: stable <stable@vger.kernel.org>
---
 drivers/w1/masters/mxc_w1.c | 20 +++++++++++++-------
 1 file changed, 13 insertions(+), 7 deletions(-)

diff --git a/drivers/w1/masters/mxc_w1.c b/drivers/w1/masters/mxc_w1.c
index 74f2e6e6202a..8851d441e5fd 100644
--- a/drivers/w1/masters/mxc_w1.c
+++ b/drivers/w1/masters/mxc_w1.c
@@ -112,6 +112,10 @@ static int mxc_w1_probe(struct platform_device *pdev)
 	if (IS_ERR(mdev->clk))
 		return PTR_ERR(mdev->clk);
=20
+	err =3D clk_prepare_enable(mdev->clk);
+	if (err)
+		return err;
+
 	clkrate =3D clk_get_rate(mdev->clk);
 	if (clkrate < 10000000)
 		dev_warn(&pdev->dev,
@@ -125,12 +129,10 @@ static int mxc_w1_probe(struct platform_device *pdev)
=20
 	res =3D platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	mdev->regs =3D devm_ioremap_resource(&pdev->dev, res);
-	if (IS_ERR(mdev->regs))
-		return PTR_ERR(mdev->regs);
-
-	err =3D clk_prepare_enable(mdev->clk);
-	if (err)
-		return err;
+	if (IS_ERR(mdev->regs)) {
+		err =3D PTR_ERR(mdev->regs);
+		goto out_disable_clk;
+	}
=20
 	/* Software reset 1-Wire module */
 	writeb(MXC_W1_RESET_RST, mdev->regs + MXC_W1_RESET);
@@ -146,8 +148,12 @@ static int mxc_w1_probe(struct platform_device *pdev)
=20
 	err =3D w1_add_master_device(&mdev->bus_master);
 	if (err)
-		clk_disable_unprepare(mdev->clk);
+		goto out_disable_clk;
=20
+	return 0;
+
+out_disable_clk:
+	clk_disable_unprepare(mdev->clk);
 	return err;
 }
=20
--=20
2.17.0


--liOOAslEiF7prFVr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEATY+KFcrMtHMM+b3X8uyjJIzOwAFAlrpfPwACgkQX8uyjJIz
OwDscA//f+nXJJD7MGuuKnHvroMF8g8EJyt0cLXBS2p3yi2juLsNh5rUuh5IHg4v
/dvJW9h/4TIyNRNfJk2TRo4c6oXkVDgnFD0f4O4f4zkohKbKarJ8XcVV6rdFBxlU
xC4FEAjiBMVmWkgRsuJWv214XadFfg0wyKkcIvX3GWtBY2fxZBHzLpcoAtRQbqJI
Z+s6vtbO70o48JJfCZPaMu2ArKyJ/XvDzpEOT7Wt1MwcRVfy265E2uGPz8kd2Q1r
DR1MEm7XTVeJ5iqJr61iuKjmEoSYKgRL8JQIG81ThhqW812BdfGeJNoj87wc2kSa
tgYk/4hZZEX/ijkrnSls5LjHy0m06P3YNvnG8R0A64yAhhi2Y27hdpQ/Al9VgX1S
D9fmHtdFuFJlEwlrrujWAbV1obd6MR8cFB2eGdXkPJPMF4AXrFNhdmey83U3qHro
sCOFd5UJYRYYGv/Gu1lKMEn1RSm9G/p6CP2Qu7xxNywqRhBRrIBpjo1GutXST3AB
EHOOyotIYWahCf8ykED4/AYQWg79Te59Z2GCp/4kpBrAcroyJlWZ/y52pPpezVuJ
qUhTrJlgwkLvCODjUKq60pqyMFVY8JtKS38YljkfIrrG3/JuXyw3jQTlQ73//y2I
QM4USjqThc9FWgPTlPGM/9Ma441SlHd75CXxoNhK2x3Org9uQis=
=d62v
-----END PGP SIGNATURE-----

--liOOAslEiF7prFVr--
