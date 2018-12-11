Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 118A3C07E85
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 12:15:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CC41A20811
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 12:15:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544530549;
	bh=roZCx4HTVA3IisYCmPheiblNUEmrdwsjZvdv5ElZxXc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:List-ID:From;
	b=U+MLUkjGwXZVekxJ/ys//x66sy1Q9LZCnYsmN61EqIkYmYgBfCdFWogya8DaFMbYv
	 UyCbvp5bL0vqLIXP1wVzzvcVcaeKPlub3gkOaWL6T0CA2+UKAz+elnTeNcGIt76XOF
	 UIhwxKV31AfUiXfwUKAbICtex5PXPv6S7kbbdD68=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CC41A20811
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726349AbeLKMPs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 07:15:48 -0500
Received: from mga04.intel.com ([192.55.52.120]:32945 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726135AbeLKMPs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 07:15:48 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 11 Dec 2018 04:15:47 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,342,1539673200"; 
   d="asc'?scan'208";a="109461474"
Received: from pipin.fi.intel.com (HELO localhost) ([10.237.72.175])
  by orsmga003.jf.intel.com with ESMTP; 11 Dec 2018 04:15:43 -0800
From:   Felipe Balbi <balbi@kernel.org>
To:     Pawel Laszczak <pawell@cadence.com>, Roger Quadros <rogerq@ti.com>,
        "devicetree\@vger.kernel.org" <devicetree@vger.kernel.org>
Cc:     "gregkh\@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "linux-usb\@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel\@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Alan Douglas <adouglas@cadence.com>,
        "jbergsagel\@ti.com" <jbergsagel@ti.com>,
        "nsekhar\@ti.com" <nsekhar@ti.com>, "nm\@ti.com" <nm@ti.com>,
        Suresh Punnoose <sureshp@cadence.com>,
        "peter.chen\@nxp.com" <peter.chen@nxp.com>,
        Pawel Jez <pjez@cadence.com>, Rahul Kumar <kurahul@cadence.com>
Subject: RE: [PATCH v1 2/2] usb:cdns3 Add Cadence USB3 DRD Driver
In-Reply-To: <BYAPR07MB47095A5EEBC106EE7CD0E078DDA60@BYAPR07MB4709.namprd07.prod.outlook.com>
References: <1544445555-17325-1-git-send-email-pawell@cadence.com> <1544445555-17325-3-git-send-email-pawell@cadence.com> <5C0F85E4.10609@ti.com> <BYAPR07MB47095A5EEBC106EE7CD0E078DDA60@BYAPR07MB4709.namprd07.prod.outlook.com>
Date:   Tue, 11 Dec 2018 14:15:39 +0200
Message-ID: <87d0q8mf84.fsf@linux.intel.com>
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


Hi,

Pawel Laszczak <pawell@cadence.com> writes:
>>I think what Felipe meant was to only combine the gadget driver code into=
 one patch.
>>
>>The series could be split into 6 patches like so.
>>-dt binding
>>-pci glue
>>-core driver
>>-host driver
>>-gadget driver
>>-drd driver
>
> Felipe wrote:
> "=20
> Frankly, I don't understand why this is a series. It's a single driver
> and splitting it into a series just makes it more difficult to review,
> actually.
>
> Sure, a single patch will be large, but there's no way to have a
> functional driver until all patches are applied, anyway.
> "
>
> Felipe should I split this driver as suggested by Roger ?.=20
> Now it's very big patch but it's still a single driver.

don't bother. It's far easier to review as it is.

=2D-=20
balbi

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEElLzh7wn96CXwjh2IzL64meEamQYFAlwPqmsACgkQzL64meEa
mQZPmQ//esDJQg93nkGwEMz/n7dBD/KM+sQAtvq4SeIeOwgcS0YyLYWFtu+lHxMJ
S3+6BIkWVQksJ/38yscj6pohIjNLENdHDYKgqQDWf5bPJdLKXim4BJQ66I5b36VW
C8RdDf55uzOgNVs4+3cwpVUoUTXRwmAdl/Hl3lj2VEYDnyYEl+r8LwHRue0D9JeK
CrIlseRcHISvFEMjAN/0llqCBzDc4gvWU2nu+xiSfe2quPDzOP4ew0mdNr3diAo/
QvkIAIDsCumQ7QumURLHhgPq4+BG5wdnYXGDlHyMx5UiiQgRXWjyZoc9ifJqA2mJ
dgn+w7ZRNru1T108kC24zCIuoEvMb7pO9rEK2BclhGBMDreleEdOVnfFNoSno/Av
5ehkQJpeSlGMguskkZ2jFZMCRL9Io813yqq/rV872xoyHVqSIIRWCJCAVa010oRm
o52j+V5ezs9DyKnHMJJFVAHRF6BbWP7LQEgMVP24q0CQ+4+KySpAMtD0/iruSOCO
W5GS6fwrRyfXIi9ex4AQS7Eb5bJs1GMVSiGkMP+8xTJnzWW+rcj03xmU8y8kHbGq
lLxeR+3982xdCibam/7OVQEU6OFybxGByQzhsYSjgSZwo2BUD9P03zJcDkcF1bc4
e9uCfDmZqHS17h2yPuFMOEM8WaQLE5ueSY16PwDzUfB5WjJg8B8=
=HuLJ
-----END PGP SIGNATURE-----
--=-=-=--
