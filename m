Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2771174-1527005768-6-2199855743277260888
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, MAILING_LIST_MULTI -1, RCVD_IN_DNSWL_HI -5,
  T_TVD_MIME_EPI 0.01, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Attached: signature.asc
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-usb-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1527005766; b=Dw53s4NegY49FAXHGenUEyybOn1/ZI0t4xa1lBabAwHFGHMrUD
    HR0IbczxTBuWS4FNI1s1Rmmu6zD2Rh2DbD2WJxnXgb0Iqspko/L9x2cHqETXfrwM
    dD6lv6GVWjQOcYRMRr7A4lefZiInP55Y1opI/KkvZoMTxWX3xZPbk3J0S4dYKRte
    0mN0gFY4imXE97uR01AbhAC9x4+0wqEyrpVAVMEG4KIYD6dOnWTQL3tWi9jIlyOF
    bSsTgMgM7If5Qgq0c8ZwelqXOoq7wGJ0iP+f/aFKSPfmOZRqU3DHgivvYhVsTxnM
    SUNw2Y+G8wvrL2W46y/6iYvhTO79BCVHwoZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=fm2; t=1527005766; bh=oaInEOp2WK6j9Bme3Wgp+Uefiv4JAh
    1FJyyPs91pwMc=; b=NObKpQNtZaxbcS095503sldu8E5VNuiav8RIyCDRiTPC5G
    zEUtfn0T5PZkCemmfKJsOGoQSK1IQlACrZv2DHwvGfzewas/ZCyKwmVYK+4tH95v
    EDAzt02glikGh+ZZ+N2ypw9Av4bd+O7l5GG1dLOkdgn5KPkyZIgqbll6Gkba34P+
    3i2rcBoGKEq1ZUKuTjjbXNOpKSWNt1MxrDg8cmvVd4JQJsp2u2oEPvxOEf2CUACa
    BGlEawr1HMhZTYuL9M/snW2RAXB+0NHyzxOE5o9TAXJxrC6YcXddVPKRPAMRRFLj
    VZOZCErcwz9mReJ1OoPTBUt41UOPCEPHjVGA2Kjg==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered, 1024-bit rsa key sha256)
    header.d=kernel.org header.i=@kernel.org header.b=e2Avyxgs x-bits=1024
    x-keytype=rsa x-algorithm=sha256 x-selector=default;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=orgdomain_pass (Domain org match);
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=kernel.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (body has been altered, 1024-bit rsa key sha256)
      header.d=kernel.org header.i=@kernel.org header.b=e2Avyxgs x-bits=1024
      x-keytype=rsa x-algorithm=sha256 x-selector=default;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=orgdomain_pass (Domain org match);
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=kernel.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfIzQckqH1WzoGof2sSI/biUwwUf+1LzUnZ1cVUm3a664tCbGfKkEruUuEAsQ1mJWLgoa/CmkX60L+74Q5qo5UUfLLYBaORfT4BYquMt8ZCzZ3hzJlojX
    7SMq4tPj1hoFOaHKFvQkNX0xrbAMHBHJOa5R2MnvO20EDoy4gw81P+PFO2E8Uf9U5xPPbs6FzxIwh5OE7ACsJe0QIhk2tzLETrkLC26uyHH68LEeYbz1k1BP
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=VUJBJC2UJ8kA:10 a=X3a0BiUdAAAA:8
    a=QyXUC8HyAAAA:8 a=gvl4HP8tAAAA:8 a=UHFruWed2s98n1uijYYA:9
    a=hrchzVdIPJx98vp7:21 a=Iyyy38AQjZfFGV_S:21 a=CjuIK1q_8ugA:10
    a=p8gb3ImC8vaTF24QcfUA:9 a=ONNS8QRKHyMA:10 a=VwQbUJbxAAAA:8
    a=Ndx7yIVex8M7RJDNeXoA:9 a=x8gzFH9gYPwA:10 a=aWu3muFgq6otJbhCXpL5:22
    a=tRkgsvjveJ3YVe9fnr1q:22 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751612AbeEVQPv (ORCPT <rfc822;greg@kroah.com>);
        Tue, 22 May 2018 12:15:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:48468 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751020AbeEVQPg (ORCPT <rfc822;linux-usb@vger.kernel.org>);
        Tue, 22 May 2018 12:15:36 -0400
Date: Tue, 22 May 2018 18:15:32 +0200
From: Sebastian Reichel <sre@kernel.org>
To: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
Cc: Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, support.opensource@diasemi.com
Subject: Re: [PATCH 1/2] power: supply: Add fwnode pointer to
 power_supply_config struct
Message-ID: <20180522161532.qqmyknk6f3scwzpg@earth.universe>
References: <cover.1527000797.git.Adam.Thomson.Opensource@diasemi.com>
 <c398d1fcc81017b9cc694a00d2c1f655874dfeac.1527000797.git.Adam.Thomson.Opensource@diasemi.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="piqsyxv6m4f4ofuj"
Content-Disposition: inline
In-Reply-To: <c398d1fcc81017b9cc694a00d2c1f655874dfeac.1527000797.git.Adam.Thomson.Opensource@diasemi.com>
User-Agent: NeoMutt/20180323
Sender: linux-usb-owner@vger.kernel.org
X-Mailing-List: linux-usb@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>


--piqsyxv6m4f4ofuj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, May 22, 2018 at 04:16:23PM +0100, Adam Thomson wrote:
> To allow users of the power supply framework to be hw description
> agnostic, this commit adds the ability to pass a fwnode pointer,
> via the power_supply_config structure, to the initialisation code
> of the core, instead of explicitly specifying of_ndoe. If that
> fwnode pointer is provided then it will automatically resolve down
> to of_node on platforms which support it, otherwise it will be NULL.
>=20
> In the future, when ACPI support is added, this can be modified to
> accommodate ACPI without the need to change calling code which
> already provides the fwnode handle in this manner.
>=20
> Signed-off-by: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
> Suggested-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
> ---

Reviewed-by: Sebastian Reichel <sebastian.reichel@collabora.co.uk>

-- Sebastian

>  drivers/power/supply/power_supply_core.c | 4 +++-
>  include/linux/power_supply.h             | 2 ++
>  2 files changed, 5 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/power/supply/power_supply_core.c b/drivers/power/sup=
ply/power_supply_core.c
> index ecd68c2..f57ab0a 100644
> --- a/drivers/power/supply/power_supply_core.c
> +++ b/drivers/power/supply/power_supply_core.c
> @@ -19,6 +19,7 @@
>  #include <linux/err.h>
>  #include <linux/of.h>
>  #include <linux/power_supply.h>
> +#include <linux/property.h>
>  #include <linux/thermal.h>
>  #include "power_supply.h"
> =20
> @@ -874,7 +875,8 @@ static void psy_unregister_cooler(struct power_supply=
 *psy)
>  	psy->desc =3D desc;
>  	if (cfg) {
>  		psy->drv_data =3D cfg->drv_data;
> -		psy->of_node =3D cfg->of_node;
> +		psy->of_node =3D
> +			cfg->fwnode ? to_of_node(cfg->fwnode) : cfg->of_node;
>  		psy->supplied_to =3D cfg->supplied_to;
>  		psy->num_supplicants =3D cfg->num_supplicants;
>  	}
> diff --git a/include/linux/power_supply.h b/include/linux/power_supply.h
> index 0c9a572..b21c4bd9 100644
> --- a/include/linux/power_supply.h
> +++ b/include/linux/power_supply.h
> @@ -199,6 +199,8 @@ enum power_supply_notifier_events {
>  /* Run-time specific power supply configuration */
>  struct power_supply_config {
>  	struct device_node *of_node;
> +	struct fwnode_handle *fwnode;
> +
>  	/* Driver private data */
>  	void *drv_data;
> =20
> --=20
> 1.9.1
>=20

--piqsyxv6m4f4ofuj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAlsEQh0ACgkQ2O7X88g7
+prbag/+MdsWV2EBxYN+umd8vzZNmSS9/RdlMu/Nrmu3PAbA95P/N/IIRS5+VB1Y
1+WT+Dt9kAwHPc9N/VuD61WxHlNo0ofmuPFEDb0lNdu2diYEpwWm2J2kr1jvCwPd
5xQxi6Lq1Ktig77YyALo4SoMmBb7ANUz5CCrrsUML9lAYuZqvejwtyyzLwjpeAVv
HWxN3z9mRLg7a017goNyBXYJnKhTHXgeOJlnKGbdkJ6ziP/8uAhkgANM3b5CJQyf
OC8vyYJkBvKT63Ai46RHW6X7tWnkwfcgXzkQVCmyHn/krrHLz9wLctpPNXTboB7p
dRJVUS0LcT1NWDWmQ9yWHpAvkdYLw1sWll6cfEm1MLmYbfRS6kFExbGk6Yt6h8mU
MSk8H4Nm74z29MpP7L434JzWs173pQ2zhwXA6IqAppw8kQ0F6ADlq61Cmnd0Fklv
SQXHeHTtpzz1NBf95KBbAuAHp6T5cXJrQA5BzkaaOztoMCTp1hOVbzqKEBr9iaLq
Rkfr/l5ci81iqGH2SkFsKtMQnWB0M3BNBtjMfON+7zap5p6cKTn1g0RDjUGeTefE
WV+syOHSpkOk8I66cmEiLTR80uT2TQXBG4E21wVILUMW0atyqH5VPRdY8RPSlK6C
sv7jXTTSjpnr02o547tHj/J/31HcEUB3U8jJ0IKUqkXwqLL4kcM=
=0taw
-----END PGP SIGNATURE-----

--piqsyxv6m4f4ofuj--
