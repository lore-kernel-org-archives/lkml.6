Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1700296-1520505846-2-197446871526852264
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, T_TVD_MIME_EPI 0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: 
X-Attached: signature.asc
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-usb-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520505846; b=v/AkmBdUqNKV4N4MIoCH9UUB03ayjvScfduqcKyiMAApaOa
    u6+wPKZTalZyZUuyIWqm1u9HqAVJhEHPuN/HrqVIgMSMUXeod9Z1opxIJYNcNfAv
    aFW0yY9fRLw7+LLeLq2OOp5lNkjWn7lGEseZmejgOHrJGgzVSD9xfHQoAyULLiKP
    h6b2iFb8jLuY/5H3N/Sk45tZ9FP8ztLnXg/uX8rAlGs58KNxLsc61uwsTBBLLyPV
    GEnnNOAL84/fccTognROO+wWZbv4yb7khkj8ZfU+Omfec3cdwlIVw8P37w+AGlCu
    LjSNy5VotJgLJ0Kj52YY2T4HUeNSJina/avMyeg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:in-reply-to:references
    :date:message-id:mime-version:content-type:sender:list-id; s=
    arctest; t=1520505846; bh=+rOZr/+JRzx6RKLJQSPFCjKAdP5FVysb63RMwQ
    BiQT4=; b=l9fGMPuD4pDZWj7iGv3XeW3PMyAfYulDPa8Y11RQWgVVPHlrGSynve
    zTey4LcAlheI/8K+VJidXgXecuCwdg2omMAGyJJMRszffFYora9G08Z/esK4aj1C
    cVY5qlk4x/uGH9GFK3G+MdDy8MslOAEn4UYeYN3ZvbE/jNTu1dVB4Eh1CFp+bzle
    8TjOLPQFuFgnoBBBfNNsFSsTlSdPdESAswePVYNMYqvzZi/dxxLIRM/Y+P6XXW1W
    eBysm/ugoSDn0JbARJNa72i3C9+KdV6xYSTFCyjEECAn1NXr4PGxHvOEkABN6YNM
    e4kxi27RVMGjtWC/aq/U24yBqOiEUfSA==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    smime=temperror;
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=orgdomain_pass;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=kernel.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    smime=temperror;
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=orgdomain_pass;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=kernel.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935424AbeCHKnw (ORCPT <rfc822;greg@kroah.com>);
        Thu, 8 Mar 2018 05:43:52 -0500
Received: from mga07.intel.com ([134.134.136.100]:1644 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S934902AbeCHKnv (ORCPT <rfc822;linux-usb@vger.kernel.org>);
        Thu, 8 Mar 2018 05:43:51 -0500
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.47,440,1515484800";
   d="asc'?scan'208";a="36973008"
From: Felipe Balbi <balbi@kernel.org>
To: William Wu <william.wu@rock-chips.com>, gregkh@linuxfoundation.org,
        Roger Quadros <rogerq@ti.com>
Cc: heiko@sntech.de, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org, linux-rockchip@lists.infradead.org,
        frank.wang@rock-chips.com, huangtao@rock-chips.com,
        dianders@google.com, briannorris@google.com, groeck@google.com,
        daniel.meng@rock-chips.com, John.Youn@synopsys.com,
        william.wu@rock-chips.com, lin.huang@rock-chips.com
Subject: Re: [PATCH] usb: dwc3: core: power on PHYs before initializing core
In-Reply-To: <1515729616-8639-1-git-send-email-william.wu@rock-chips.com>
References: <1515729616-8639-1-git-send-email-william.wu@rock-chips.com>
Date: Thu, 08 Mar 2018 12:43:40 +0200
Message-ID: <87ina6vodf.fsf@linux.intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
        micalg=pgp-sha512; protocol="application/pgp-signature"
Sender: linux-usb-owner@vger.kernel.org
X-Mailing-List: linux-usb@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable


Hi Roger,

William Wu <william.wu@rock-chips.com> writes:
> The dwc3_core_init() gets the PHYs and initializes the PHYs with
> the usb_phy_init() and phy_init() functions before initializing
> core, and power on the PHYs after core initialization is done.
>
> However, some platforms (e.g. Rockchip RK3399 DWC3 with Type-C
> USB3 PHY), it needs to do some special operation while power on
> the Type-C PHY before initializing DWC3 core. It's because that
> the RK3399 Type-C PHY requires to hold the DWC3 controller in
> reset state to keep the PIPE power state in P2 while configuring
> the Type-C PHY, otherwise, it may cause waiting for the PIPE ready
> timeout. In this case, if we power on the PHYs after the DWC3 core
> initialization is done, the core will be reset to uninitialized
> state after power on the PHYs.
>
> Fix this by powering on the PHYs before initializing core. And
> because the GUID register may also be reset in this case, so we
> need to configure the GUID register after powering on the PHYs.
>
> Signed-off-by: William Wu <william.wu@rock-chips.com>

does this cause any regressions for your boards?

=2D-=20
balbi

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEElLzh7wn96CXwjh2IzL64meEamQYFAlqhE9wACgkQzL64meEa
mQbo8xAAtDhCIfBTcs4q9JOVmKiY9BpJ/u7lRXkm5jgNkuUD/DXSFIDiJAXijoNk
jVLw3sHf0HV+ba8EN8PM2TM18Ivv1K+ZFqQJOW06HKiE1xjrPlxoirWyxi97VdxM
wX9I9rQR/V/8O6WwM/nWLFeXlyaF7O7sNO+08zntExtPWeOK4L4yCkvAvpsH3csk
HfV4xGsnDKsU0rJ8xFo7TKOlB102f6NO5UL1kLowCLWSo8jRsnUDA7/NDpbl5yF7
sHmZbQmcBFCu2vzwdZqwxRIC+ziKjeWi/zbvTLH+8AH3fvDXtAY/0LAv1Um2ifrV
Q7XBOXYyJCcGNFA/uMS27KhGUFkOoHK3WB5+aLqbc6z544h5ZKf3PDo0g2CgzjEo
itkSrW/duxF7x/eXkn03JIuJN5X8UbTMsj6P9jdAw+NmKqnZZFQVYMtAAjK55q8o
+vN9hGbjGhq8kfaPoSL8Lm0TSYIglNcS/HliAd7VlgVP64K2ETEwZhaq8l7+MUIK
mScHu6KIFSkSq6BMBYm1GTILnXt8rVoTr5yPSmfPzki5V9W4Msa5HDZ35yoxHhFo
oEs2InHTLBZMeC+Vv6w77v8xy0X7mSGdz/BaXoJAlPRj/PfbzgKenP3z7/KnKqOo
YyMqKFnSKRpLFmUHGS2AscgnJhm5bQFAd5iRiJjq16FUmazeLJc=
=QuP9
-----END PGP SIGNATURE-----
--=-=-=--
