Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id HOdCFfq3GltTPQAAmS7hNA
	; Fri, 08 Jun 2018 17:08:10 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 2B3D2608B8; Fri,  8 Jun 2018 17:08:10 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,FREEMAIL_FROM,
	MAILING_LIST_MULTI autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 65D006089E;
	Fri,  8 Jun 2018 17:08:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 65D006089E
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=free.fr
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752810AbeFHRIE (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Fri, 8 Jun 2018 13:08:04 -0400
Received: from smtp4-g21.free.fr ([212.27.42.4]:38258 "EHLO smtp4-g21.free.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752328AbeFHRIC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jun 2018 13:08:02 -0400
Received: from tock (unknown [37.48.92.129])
        (Authenticated sender: albeu)
        by smtp4-g21.free.fr (Postfix) with ESMTPSA id 2422119F5BD;
        Fri,  8 Jun 2018 19:07:26 +0200 (CEST)
Date: Fri, 8 Jun 2018 19:07:17 +0200
From: Alban <albeu@free.fr>
To: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc: Aban Bedel <albeu@free.fr>, linux-kernel@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Boris Brezillon <boris.brezillon@free-electrons.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        Richard Weinberger <richard@nod.at>,
        Cyrille Pitchen <cyrille.pitchen@wedev4u.fr>,
        devicetree@vger.kernel.org, linux-mtd@lists.infradead.org
Subject: Re: [PATCH v3 1/3] nvmem: Update the OF binding to use a subnode
 for the cells list
Message-ID: <20180608190717.55cb185c@tock>
In-Reply-To: <cd7a0085-66cd-308e-a950-cd0eb96db945@linaro.org>
References: <1521933899-362-1-git-send-email-albeu@free.fr>
        <1521933899-362-2-git-send-email-albeu@free.fr>
        <344e0087-7410-aebb-8a66-c6976064df10@linaro.org>
        <20180417165420.423a691b@avionic-0020>
        <8c4b48ad-e99e-030a-a4ee-b6df0fa59c79@linaro.org>
        <20180417180040.04f53495@avionic-0020>
        <20180418134119.2e587621@avionic-0020>
        <9f7d2987-b33e-79b5-ae58-2985fd7334e4@linaro.org>
        <20180418143243.3c23493c@avionic-0020>
        <e34619a4-e9b6-9945-a1cc-a3680aac6819@linaro.org>
        <20180418153440.187ed16e@avionic-0020>
        <d30656d6-f17e-6ed0-251f-2b59d02cd202@linaro.org>
        <20180607184155.6da38a01@tock>
        <0fb0e8e9-e7b8-10c3-fcdd-399c73a33878@linaro.org>
        <20180608125938.4fd457a0@tock>
        <cd7a0085-66cd-308e-a950-cd0eb96db945@linaro.org>
X-Mailer: Claws Mail 3.13.2 (GTK+ 2.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/1vWlee8hPcRrge=jA.imybo"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/1vWlee8hPcRrge=jA.imybo
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Fri, 8 Jun 2018 12:34:12 +0100
Srinivas Kandagatla <srinivas.kandagatla@linaro.org> wrote:

> >> Can you try this with your original subnode proposal:
> >> just pass the subnode node pointer in np of nvmem_config:
> >> =20
> >> ------------------------->cut<------------------------------------ =20
> >> diff --git a/drivers/nvmem/core.c b/drivers/nvmem/core.c
> >> index b05aa8e81303..c9621632bbfb 100644
> >> --- a/drivers/nvmem/core.c
> >> +++ b/drivers/nvmem/core.c
> >> @@ -472,7 +472,11 @@ struct nvmem_device *nvmem_register(const struct
> >> nvmem_config *config)
> >>           nvmem->priv =3D config->priv;
> >>           nvmem->reg_read =3D config->reg_read;
> >>           nvmem->reg_write =3D config->reg_write;
> >> -       nvmem->dev.of_node =3D config->dev->of_node;
> >> +
> >> +       if (config->np)
> >> +               nvmem->dev.of_node =3D config->np;
> >> +       else
> >> +               nvmem->dev.of_node =3D config->dev->of_node;
> >>
> >>           if (config->id =3D=3D -1 && config->name) {
> >>                   dev_set_name(&nvmem->dev, "%s", config->name);
> >> diff --git a/include/linux/nvmem-provider.h
> >> b/include/linux/nvmem-provider.h index f89598bc4e1c..743345ffe2c8
> >> 100644 --- a/include/linux/nvmem-provider.h
> >> +++ b/include/linux/nvmem-provider.h
> >> @@ -49,6 +49,7 @@ typedef int (*nvmem_reg_write_t)(void *priv,
> >> unsigned int offset,nvmem_device_get(
> >>     */
> >>    struct nvmem_config {
> >>           struct device           *dev;
> >> +       struct device_node      *np;
> >>           const char              *name;
> >>           int                     id;
> >>           struct module           *owner;
> >> =20
> >> ------------------------->cut<------------------------------------ =20
> >=20
> > That should work just fine to allow next to any kind of binding.
> > I'll do a new patch using this approach for the code side and leaving
> > the generic binding as it is. =20
> Sure!!
> This will give more flexibility to other provider drivers!

I looked into this. It would work fine for the cells but not so nicely
for the nvmem device API. The phandle for the nvmem device would have
to reference the node passed here and not the real device. We would end
up with a DT like this:

flash@0 {
	compatible =3D "mtd";
	...
	nvmem_dev: nvmem-cells {
		compatible =3D "nvmem-cells";
		...
        };
};

other-device@10 {
	...
	nvmem =3D <&nvmem_dev>;
};

Now if there is no cell defined we have this empty child node that make
very little sense, it is just there to accommodate the nvmem API.

What I would suggest now is to just change the wording. We don't
deprecate the current binding, but we extend it to allow grouping the
cells in a child node if required. The code to support this is trivial,
(4 lines including error handling) so even if we expect very few
bindings to make use of it it is not going to be maintenance drag.
That would look like this:

diff --git a/Documentation/devicetree/bindings/nvmem/nvmem.txt b/Documentat=
ion/devicetree/bindings/nvmem/nvmem.txt
index fd06c09..085d042 100644
--- a/Documentation/devicetree/bindings/nvmem/nvmem.txt
+++ b/Documentation/devicetree/bindings/nvmem/nvmem.txt
@@ -19,7 +19,10 @@ Optional properties:
=20
 =3D Data cells =3D
 These are the child nodes of the provider which contain data cell
-information like offset and size in nvmem provider.
+information like offset and size in nvmem provider. Alternatively the data
+cells can be grouped in a node that has a compatible property set to
+"nvmem-cells".
+
=20
 Required properties:
 reg:   specifies the offset in byte within the storage device.
diff --git a/drivers/nvmem/core.c b/drivers/nvmem/core.c
index 4e94a78..3e1369c 100644
--- a/drivers/nvmem/core.c
+++ b/drivers/nvmem/core.c
@@ -859,6 +859,14 @@ struct nvmem_cell *of_nvmem_cell_get(struct device_nod=
e *np,
        if (!nvmem_np)
                return ERR_PTR(-EINVAL);
=20
+       /* bindings that already have anonymous child nodes can instead put
+        * their cells in a child node with an nvmem-cells compatible. */
+       if (of_device_is_compatible(nvmem_np, "nvmem-cells")) {
+               nvmem_np =3D of_get_next_parent(nvmem_np);
+               if (!nvmem_np)
+                       return ERR_PTR(-EINVAL);
+       }
+
        nvmem =3D __nvmem_device_get(nvmem_np, NULL, NULL);
        of_node_put(nvmem_np);
        if (IS_ERR(nvmem))

What about it?

Alban

--Sig_/1vWlee8hPcRrge=jA.imybo
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJbGrfFAAoJEHSUmkuduC2858QQALNCfJfDeDgJ4UflIREPgTjM
tOAZb2U4VRG2yYPimmsg3K9TLvIoI/xk4as0wTalJyKlT1zQBwGOZ4Wwvije9d1Q
OHxatgrDPhA5tcvD7SadXasxkYJD8MVLjhIZCGIZ90sdikZibzWr78uFEaRYJ601
B41dCr13rkgHlrNYdVS9zfxNrZ6liE/+Tr+q2L7q6YDC73Oz5S2lAm85AkUBbEEi
HmwowmBPA2HPNJOhG7e6l4M+dxHGJydOWY3SDJE98OnEXvNKqgt3NGiMyhfMunm1
nkrUSclBN/HrZh7a6tQ2TaDFUJ9drMWRwdvqnspNW5l8KpwJhWHxeXajAZkGoe/W
MNorpVMlD8rmjTLx+73VwOby43YwAcDyG60g4E4p3hmb2Wi1sHM0ABp8hItk5lYg
q0ioG1fO3g2GCJc5QxtCPJS1I7HP+AhPiKwz7cmRyLcxr1TRJOKW6z45gjMs++rQ
huEQb8AD2HPBOW0VvrgBJl9OXoGxHpouV2P+sWoL/cEUj/TcljRImUcryTzxJdab
ga6R9MXAYyDYq0hfbBfEAzACWMGez65qG5zMolMR/VcoSAX01S7xeAOisdXqdQbR
JHVs3OGEduv8r8MgG0ISasoeAth3+MCcFu4/hD/92iI7r6kjMZdzlRe8b3X4x4wq
I76qSh15tQeDkIaM23S8
=xWJ5
-----END PGP SIGNATURE-----

--Sig_/1vWlee8hPcRrge=jA.imybo--
