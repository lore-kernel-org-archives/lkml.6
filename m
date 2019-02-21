Return-Path: <SRS0=r0+/=Q4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90891C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 15:29:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4BF5D2075A
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 15:29:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HtI/nZCu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727614AbfBUP3D (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Feb 2019 10:29:03 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:42582 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725831AbfBUP3D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Feb 2019 10:29:03 -0500
Received: by mail-wr1-f67.google.com with SMTP id r5so17658413wrg.9;
        Thu, 21 Feb 2019 07:29:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=HRGwMBnysWjd0f1PIJ2P9GxLmzTVqjXTZtyQ1NU5UPQ=;
        b=HtI/nZCuvRdGGcxhYQ9HBQ3sztjhcWxCnNMUMq0XcP1DixrlbfoVEVEemMGe1c01fL
         K+SyzTkrqA4HSi9pEp7No5lAhkp0sLZ27KS1Gr1WckiMJKPUCtzmvc3XHFO0RIMvPRgd
         ZU+TXa7syudntL39RLj0wgUdIz/j1Qxkm+TXrj/GRAYR79Y1Q9RS8W+mkTuExnzTZ3A9
         r9Fow16Cx3w+jvWIrijvAPfY2vv/rpKlvALdsadM+77Lh4gMIHhYn6D/nMp4jiCSgqNO
         o11g3PwUS6nBG7DyDVB5G/G4176FkvRC3buMIQ8kkDnKppnnaR7lNi+MxkFPVqQdvjqR
         APmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=HRGwMBnysWjd0f1PIJ2P9GxLmzTVqjXTZtyQ1NU5UPQ=;
        b=qC7L1rgsDaFPprNuEELfdVFPO47IQGKLQdiJxYUXNJmJmrN+jazy6U9DbBgs58UJj5
         bP1qQRmaM2ctpYNRQkQvtsyluw9s1J6kq4XTjSRyZHUG2gXbTPQ0aKaFBJyMABY1jk8j
         qHjHN+doM60Wxzg8zx852Aa+skAt+aKlxM6jZtNaPhtWmE3mp/YAeNJYhKLldIjpBD5x
         LGSH1RwqtswjmBisOIHEu2Zgn+OeHBhAPf5i2I6lfYwFi74HRUTu6248+xiwQdhE5yXl
         BxWSmtyY21W3kjlWNabxGmBoseurTS4a7hluYYv2Y8xeLtVkQinBrWQg0a6hagW2qcVe
         QyCg==
X-Gm-Message-State: AHQUAuZCs6RhePV7hIyrg6PVUdIYjMAbvBdKSrreh6AYOhwro5ED2SIK
        FRyzC9cQwGkMCTZgWNBWIj0=
X-Google-Smtp-Source: AHgI3IZJBFSZObVvhhp8rYo3UY7uCCelRajo4H1Kx/cDk7grhAcHiCobOOxP81UYgNNPHN8J/jjW/A==
X-Received: by 2002:adf:fa0d:: with SMTP id m13mr28537261wrr.93.1550762940199;
        Thu, 21 Feb 2019 07:29:00 -0800 (PST)
Received: from localhost (pD9E51D2D.dip0.t-ipconnect.de. [217.229.29.45])
        by smtp.gmail.com with ESMTPSA id e75sm17206201wmg.32.2019.02.21.07.28.58
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 21 Feb 2019 07:28:59 -0800 (PST)
Date:   Thu, 21 Feb 2019 16:28:58 +0100
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Philipp Zabel <p.zabel@pengutronix.de>
Cc:     Jonathan Hunter <jonathanh@nvidia.com>,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/5] reset: add acquired/released state for exclusive
 reset controls
Message-ID: <20190221152858.GA8652@ulmo>
References: <20190221152557.8534-1-thierry.reding@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="T4sUOijqQbZv57TR"
Content-Disposition: inline
In-Reply-To: <20190221152557.8534-1-thierry.reding@gmail.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--T4sUOijqQbZv57TR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 21, 2019 at 04:25:53PM +0100, Thierry Reding wrote:
> From: Philipp Zabel <p.zabel@pengutronix.de>
>=20
> There are cases where a driver needs explicit control over a reset line
> that is exclusively conneted to its device, but this control has to be
> temporarily handed over to the power domain controller to handle reset
> requirements during power transitions.
> Allow multiple exclusive reset controls to be requested in 'released'
> state for the same physical reset line, only one of which can be
> acquired at the same time.
>=20
> Signed-off-by: Philipp Zabel <p.zabel@pengutronix.de>
> Signed-off-by: Thierry Reding <treding@nvidia.com>
> ---
>  drivers/reset/core.c  | 139 ++++++++++++++++++++++++++++++++++++++----
>  include/linux/reset.h |  93 ++++++++++++++++++++++------
>  2 files changed, 200 insertions(+), 32 deletions(-)

Hi Philipp,

the bulk of this is unchanged relative to what you had posted
originally. I squashed in the few things that we had already discussed
earlier (EINVAL -> EPERM) and a couple of minor fixes for issues that I
found while working with this.

Attached is my fixup patch which contains all the changes I made on top
of your version and that I squashed into this.

Thierry

--- >8 ---
commit aa618d0b63eec676d9ea8db91a4c5fdc9330fc6b
Author: Thierry Reding <treding@nvidia.com>
Date:   Mon Feb 18 11:32:46 2019 +0100

    fixup! reset: add acquired/released state for exclusive reset controls

diff --git a/drivers/reset/core.c b/drivers/reset/core.c
index c6a7a4474142..1e8a42b16f23 100644
--- a/drivers/reset/core.c
+++ b/drivers/reset/core.c
@@ -65,6 +65,17 @@ struct reset_control_array {
 	struct reset_control *rstc[];
 };
=20
+static const char *rcdev_name(struct reset_controller_dev *rcdev)
+{
+	if (rcdev->dev)
+		return dev_name(rcdev->dev);
+
+	if (rcdev->of_node)
+		return rcdev->of_node->full_name;
+
+	return NULL;
+}
+
 /**
  * of_reset_simple_xlate - translate reset_spec to the reset line number
  * @rcdev: a pointer to the reset controller device
@@ -276,7 +287,7 @@ int reset_control_reset(struct reset_control *rstc)
 			return 0;
 	} else {
 		if (!rstc->acquired)
-			return -EINVAL;
+			return -EPERM;
 	}
=20
 	ret =3D rstc->rcdev->ops->reset(rstc->rcdev, rstc->id);
@@ -340,8 +351,11 @@ int reset_control_assert(struct reset_control *rstc)
 		if (!rstc->rcdev->ops->assert)
 			return -ENOTSUPP;
=20
-		if (!rstc->acquired)
-			return -EINVAL;
+		if (!rstc->acquired) {
+			WARN(1, "reset %s (ID: %u) is not acquired\n",
+			     rcdev_name(rstc->rcdev), rstc->id);
+			return -EPERM;
+		}
 	}
=20
 	return rstc->rcdev->ops->assert(rstc->rcdev, rstc->id);
@@ -378,8 +392,11 @@ int reset_control_deassert(struct reset_control *rstc)
 		if (atomic_inc_return(&rstc->deassert_count) !=3D 1)
 			return 0;
 	} else {
-		if (!rstc->acquired)
-			return -EINVAL;
+		if (!rstc->acquired) {
+			WARN(1, "reset %s (ID: %u) is not acquired\n",
+			     rcdev_name(rstc->rcdev), rstc->id);
+			return -EPERM;
+		}
 	}
=20
 	/*
@@ -417,15 +434,43 @@ int reset_control_status(struct reset_control *rstc)
 }
 EXPORT_SYMBOL_GPL(reset_control_status);
=20
+/**
+ * reset_control_acquire() - acquires a reset control for exclusive use
+ * @rstc: reset control
+ *
+ * This is used to explicitly acquire a reset control for exclusive use. N=
ote
+ * that exclusive resets are requested as acquired by default. In order fo=
r a
+ * second consumer to be able to control the reset, the first consumer has=
 to
+ * release it first. Typically the easiest way to achieve this is to call =
the
+ * reset_control_get_exclusive_released() to obtain an instance of the res=
et
+ * control. Such reset controls are not acquired by default.
+ *
+ * Consumers implementing shared access to an exclusive reset need to foll=
ow
+ * a specific protocol in order to work together. Before consumers can cha=
nge
+ * a reset they must acquire exclusive access using reset_control_acquire(=
).
+ * After they are done operating the reset, they must release exclusive ac=
cess
+ * with a call to reset_control_release(). Consumers are not granted exclu=
sive
+ * access to the reset as long as another consumer hasn't released a reset.
+ *
+ * See also: reset_control_release()
+ */
 int reset_control_acquire(struct reset_control *rstc)
 {
 	struct reset_control *rc;
=20
-	if (!rstc || rstc->acquired)
+	if (!rstc)
 		return 0;
=20
+	if (WARN_ON(IS_ERR(rstc)))
+		return -EINVAL;
+
 	mutex_lock(&reset_list_mutex);
=20
+	if (rstc->acquired) {
+		mutex_unlock(&reset_list_mutex);
+		return 0;
+	}
+
 	list_for_each_entry(rc, &rstc->rcdev->reset_control_head, list) {
 		if (rstc !=3D rc && rstc->id =3D=3D rc->id) {
 			if (rc->acquired) {
@@ -435,13 +480,28 @@ int reset_control_acquire(struct reset_control *rstc)
 		}
 	}
=20
+	rstc->acquired =3D true;
+
 	mutex_unlock(&reset_list_mutex);
 	return 0;
 }
 EXPORT_SYMBOL_GPL(reset_control_acquire);
=20
+/**
+ * reset_control_release() - releases exclusive access to a reset control
+ * @rstc: reset control
+ *
+ * Releases exclusive access right to a reset control previously obtained =
by a
+ * call to reset_control_acquire(). Until a consumer calls this function, =
no
+ * other consumers will be granted exclusive access.
+ *
+ * See also: reset_control_acquire()
+ */
 void reset_control_release(struct reset_control *rstc)
 {
+	if (!rstc || WARN_ON(IS_ERR(rstc)))
+		return;
+
 	rstc->acquired =3D false;
 }
 EXPORT_SYMBOL_GPL(reset_control_release);

--T4sUOijqQbZv57TR
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlxuw7cACgkQ3SOs138+
s6GgyhAAhIkiSeceruxbdmifWOFBuY/+zCpKpWTxK/nT1Dmbin3QAGm5OT9XkLw/
t2t9ttsWYLyM+IXbAzu32ORPmc//Nybzea+sTw9kKa4DPaSfk5SIawFk4N2NyLfc
uEfGcaMHA0EkvyXcg63r0nyZdRsqq3zL3fWobmUr1yZ6GUHZQbIZzhZjd7Xi6zLT
NVqu42BoysZTyjiToXJH/sUDhYBbh7MQmVDPtc9pb1wvJgY9FjZQ5ZSrBzr/0KKy
ZcPhwJoypNfFVhtD5w46fxMQzpQp2Z/HyORSETbxcWFW3my7jNs8o4/P5Ge71hUr
R1g5iUezHYpC6lbjJn8MAouzIcMiycnmLlrWwnHQg/8GEKWfz5ZhdlQrNEoVraem
NBuplJmTNRcJGH8pp/GXY4GaTQGHOebprqw2mdPYnPlQ0GrRhKjL3Wjgw9tmFFlM
umHLRc1qfViFkYu3Af7WIUTFVkZzDY02ke965Mzms9nDnG4I/+u73WPubLKOm9Is
6VHUa0YTEM+wKqe9MYbARmBmfhZ2HiU/ZlqGjc3gTCCNmaK6Km2VeqMCDNz7ZHE9
4hsMtDRYceEZo/SwK6DP4bmJJYUe+43y/9bd5gekbLXbXgXw0ineInd87eKakI6v
RsUd1FOBb2t4SRePNSv05pmHNqAyUJ1RaZUVG9RZGEOcBXC5S/8=
=Yueq
-----END PGP SIGNATURE-----

--T4sUOijqQbZv57TR--
