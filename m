Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2841-1524823722-2-1960577505712654698
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, FREEMAIL_FORGED_FROMDOMAIN 0.25, FREEMAIL_FROM 0.001,
  HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, T_TVD_MIME_EPI 0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Attached: signature.asc
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-usb-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1524823722; b=ZcQniMQeJ+UYTvb8jy/qgmxCqfnqLuwwNJRtt2wD0YwrGCCF3J
    Cw9ZqJqizdk9L0WCJe7cW6cLvXj6DAmdR/skBJYAVRx3/81DnMiHJa8mbaw00nqm
    cOBMZ0uSgDfhg92P4/qE7l5Tn9zZRhE5lHb4M+If0fnMNSBXaSyH72/0Cg6NKyvq
    zP9L3OFpYaqdUEIiz9jigQhK8if+cNnLl57lFii3jos7ijflXyiNBajYwFySgaXU
    3+Men+begPUBv6D+o0K6HhS2EOGiuK8n28LJtUDPdMLmqS9yZnuNSOTstA8eI1FV
    4Pja8SA8tJpsX9wwaTCafE2MughbjVLaD/bA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=fm2; t=1524823722; bh=oefm9nAdPnsFiqVJQMVBhc4WXnBjGE
    Zj5gBwZSjwiPI=; b=X7WtW4CTMz75J9Z+55odOQk0clVRPCMfe3yWh67EYsFMSA
    j6rATGNUSQ8mDZB7KivTK9vRljgOJHzMEN4469mO8XrDzk4TSCZlsHt4I4keJOw7
    dIlxdPsWnJvyksMffxhEsO0Xv/uXRNT8z4sL81w0M46B5yPkAKk7on24YWCeTNi/
    GPZMLa8s/qnz9qSQfZhRIyDJPeyqoMXiQPcgJ3JNhAnJLl0eD3yx2vDLmp04LP5P
    eDaEYZFa/UL00cZtviz8N7gzdm9XAldkeuweV02GsqZnk9LejXL/WXgStgkYKZ5D
    GAulCfpQmv/yMOeyxRd148u5drGQvUPAb5gHZtXw==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered, 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=l4KOOkny x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (body has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=pGf2KoZk;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (body has been altered, 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=l4KOOkny x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (body has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=pGf2KoZk;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfGR3dbmypv7Co10KgOAYkIZp3L3NERtQ2gR59+vPWra45EAQ/M52Qdv7e5gfL+MVymGQFdNSRwohjxsVlNwJ62FJeUYC0hSMZSgctlsPp2yZRuYvgf0a
    2rhng/RWaUy91iH1LhCAYklJui/LuR8Po8UYgbaFP9dgptyy+Sg6DePsrbVM8mcDililSDgfCabGxvXatRSm4or7GXh4ULsHFuJhxfiRu9lRo9clEEeEaURw
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=x7bEGLp0ZPQA:10 a=I5jJpb0z_YgA:10
    a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10 a=Ikd4Dj_1AAAA:8 a=GjCIeZvoTAnWx6o7uwIA:9
    a=CjuIK1q_8ugA:10 a=TC1m6TQkiwKXMQZUKgQA:9 a=ONNS8QRKHyMA:10 a=VwQbUJbxAAAA:8
    a=Ndx7yIVex8M7RJDNeXoA:9 a=x8gzFH9gYPwA:10 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932496AbeD0KI1 (ORCPT <rfc822;greg@kroah.com>);
        Fri, 27 Apr 2018 06:08:27 -0400
Received: from mail-wr0-f196.google.com ([209.85.128.196]:46250 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1757805AbeD0KI0 (ORCPT
        <rfc822;linux-usb@vger.kernel.org>); Fri, 27 Apr 2018 06:08:26 -0400
X-Google-Smtp-Source: AB8JxZoBFVLMh491njhxajwXVFUr43jes1Ahk6wwlPEJ/cnUpscd+bDaP7OLpg3KH61OUNP5m6VchQ==
Date: Fri, 27 Apr 2018 12:08:22 +0200
From: Thierry Reding <thierry.reding@gmail.com>
To: Jon Hunter <jonathanh@nvidia.com>
Cc: Mathias Nyman <mathias.nyman@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH V2 1/3] usb: xhci: tegra: Prepare for adding runtime PM
 support
Message-ID: <20180427100822.GP30388@ulmo>
References: <1524754750-3633-1-git-send-email-jonathanh@nvidia.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="xXygN3QAmJYWdGtb"
Content-Disposition: inline
In-Reply-To: <1524754750-3633-1-git-send-email-jonathanh@nvidia.com>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: linux-usb-owner@vger.kernel.org
X-Mailing-List: linux-usb@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>


--xXygN3QAmJYWdGtb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 26, 2018 at 03:59:08PM +0100, Jon Hunter wrote:
> When adding runtime PM support to the Tegra XHCI driver, it is desirable
> to move the function calls to enable the clocks, regulators and PHY from
> the tegra_xusb_probe into the runtime PM handlers. Currently, the
> clocks, regulators and PHY are all enabled before we call
> usb_create_hcd() in tegra_xusb_probe(), however, we cannot call
> pm_runtime_get_sync() at this point because the platform device data is
> not yet initialised. Fortunately, the function usb_create_hcd() can be
> called before we enable the clocks, regulators and PHY and so prepare
> for adding runtime PM support, by moving the call to usb_create_hcd()
> before we enable the hardware.
>=20
> Signed-off-by: Jon Hunter <jonathanh@nvidia.com>

Acked-by: Thierry Reding <treding@nvidia.com>

--xXygN3QAmJYWdGtb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlri9pYACgkQ3SOs138+
s6HzjhAAwVHAmy4sZt3lLaoj3GhqOOVEexovo3hsAp5Se568AXbA3qHi+iYXPlZn
5jd10c+vZlC7Su2+2RzrKZhPmqUGTYWWw2bqBQ5xVGx04dyFk656vsCvENsE4ftJ
InDd+WezMSBDIRcVtXMfNGFpS9Y1YwWy2QuvME2/mxSAICVneQ0sKHKSGa6xNPdx
/6eGtIxTGyS2U7mQ683L26KSCNnYvyek0YNnd1/AuF/ycykfCV0tlysCFFIqxmaz
udGtP4uaG5TVM8Wc/rUMX83bqkFHwS7A0mY+fP78qn+PPyUZlvsBXi8ljm4OXnd8
Q9wwptIcODODk2dnjbTOIjgakvcR0DavpbXtK/udmZ8nH1eeeV41ZpvFMgw0zJxp
fCiIm2nAjUrwEk/ZD8YQti4GFvq/rQ6xv4h6ElQ150jG+LkcHA2FNHBddaZsAG2z
5iQdNOup/a1N0R7uBU+kc/6UUuVtNwSDTA1DrntAvW7kOsTqU+JhSvG89V69rsM9
P3vIfmyc5EE6nYotPCoegHmLd9R/6/B0HUTW/BSs37mnR6entdPxmbgyj10atvQM
2g7LyXSM31CPyne1atMWLBzxBFkugCKrLGI4W6D8ISUN8Nf1DFjth9vh6qTnOPBY
Uf3t9QXPUtHLspbSyeCM49tyHGHH/D9KEEzd2CNvZqfixq4rOPg=
=oRd8
-----END PGP SIGNATURE-----

--xXygN3QAmJYWdGtb--
