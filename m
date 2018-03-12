Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1475733-1520893880-2-9481418873618745714
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, T_TVD_MIME_EPI 0.01,
  LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='utf-8'
X-Attached: signature.asc
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-usb-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520893880; b=VBXsgEJKFLnXPl+jU0s7v78eJF/e+x4jRuo/GBkeiGvex7w
    Wt0tTMCqKQYIWkuhuCQuuFYOFMFAdDKFjFt34tN9fnKOsWR3osrbEVgtuHdjWkGS
    3aWMK4ZPN++t/h/7sDiOppX2c/6Pot8vg//Xzn7PPyeUGJ0bFHQAh8uPnwKKcgdd
    Bs3MDnLrMa05jwqlylMygKdn22QGZDduNRPmTudiAqzTLnXKSEkx7GfjNAA36/pb
    lBO4NYM3eyaU1iO8Qu+GSXTX1HIyo4wyEUDWD8NeRfqcreay3/CqVYxlT1AXd0WZ
    x11H5fgQ5vkODuA8kBr5LzLyCZf5stXznfgpWgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=subject:to:references:from:message-id
    :date:mime-version:in-reply-to:content-type:sender:list-id; s=
    arctest; t=1520893880; bh=FIfc8P4L5gqA37gk33PzZ06uoZJ0wEmrcnz++s
    h9psk=; b=qUz3U4d4s9s9fJlg26Vzk20+alkjb+NZMEmcytq303QRi+C4fRrgYm
    uB/ZYlEiPx1KdiI+ONm4+QD/OuveVIFuYKIyrhVAQN6DOB50QqyX/ezPRVyjlmYW
    JT0lUNi2MMvrHsxO9ZeJSN/jt13knQBI+Tytu6AmD9s9ppP0GvoNApC/yI3u4jvw
    Wo5TYdTCicD16qfwhkRC4ccwuPP0W7U5h6XUmWo2o59ziVu303d8PRURlEsb/U1V
    DwRIz4NXS5fgkhpeaLfN/P4TYiLyliolZgfY2M4gm5BWJdzS5rX4IRgKs34lD3UO
    iZqLuIqFYvZCz1dXChKEjdlfNJbR5Nag==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=wizzup.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=wizzup.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=wizzup.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=wizzup.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932322AbeCLWay (ORCPT <rfc822;greg@kroah.com>);
        Mon, 12 Mar 2018 18:30:54 -0400
Received: from nala.villavu.com ([188.165.243.101]:58807 "EHLO
        nala.villavu.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932405AbeCLWaw (ORCPT
        <rfc822;linux-usb@vger.kernel.org>); Mon, 12 Mar 2018 18:30:52 -0400
Subject: Re: [PATCH v2] usb: musb: Fix external abort in musb_remove on
 omap2430
To: Bin Liu <b-liu@ti.com>, ivo.g.dimitrov.75@gmail.com,
        linux-omap@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20180308221949.12054-1-merlijn@wizzup.org>
 <20180309141130.GM14921@uda0271908>
From: Merlijn Wajer <merlijn@wizzup.org>
Message-ID: <b163041c-02d5-56c0-8f46-139b564a7280@wizzup.org>
Date: Mon, 12 Mar 2018 23:30:39 +0100
User-Agent: Mozilla/5.0 (X11; Linux armv7l; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180309141130.GM14921@uda0271908>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="UayBKzP6GDiD7z8y2XGFaZg8vjzPWfYN1"
Sender: linux-usb-owner@vger.kernel.org
X-Mailing-List: linux-usb@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--UayBKzP6GDiD7z8y2XGFaZg8vjzPWfYN1
Content-Type: multipart/mixed; boundary="O7xnJYU27dPwxbH59fq8DAMfxtW76xdW9";
 protected-headers="v1"
From: Merlijn Wajer <merlijn@wizzup.org>
To: Bin Liu <b-liu@ti.com>, ivo.g.dimitrov.75@gmail.com,
 linux-omap@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Message-ID: <b163041c-02d5-56c0-8f46-139b564a7280@wizzup.org>
Subject: Re: [PATCH v2] usb: musb: Fix external abort in musb_remove on
 omap2430
References: <20180308221949.12054-1-merlijn@wizzup.org>
 <20180309141130.GM14921@uda0271908>
In-Reply-To: <20180309141130.GM14921@uda0271908>

--O7xnJYU27dPwxbH59fq8DAMfxtW76xdW9
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: quoted-printable

Hi Bin,

On 09/03/18 15:11, Bin Liu wrote:
> Hi,
>=20
> On Thu, Mar 08, 2018 at 11:19:48PM +0100, Merlijn Wajer wrote:
>> This fixes an oops on unbind / module unload (on the musb omap2430
>> platform).
>>
>> musb_remove function now calls musb_platform_exit before disabling
>> runtime pm.
>>
>> Signed-off-by: Merlijn Wajer <merlijn@wizzup.org>
>=20
> Applied. Thanks.

Thank you. Is there any chance that this patch and the vbus patch could
end up in the 4.16-rc series? I was waiting for another rc to see if the
vbus patch would land, but it didn't land with 4.16-rc5.

Cheers,
Merlijn


--O7xnJYU27dPwxbH59fq8DAMfxtW76xdW9--

--UayBKzP6GDiD7z8y2XGFaZg8vjzPWfYN1
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYIAB0WIQRM5LT7NbLF9yb6a/UGN09rynK8WgUCWqb/jwAKCRAGN09rynK8
WhpvAQDSuTmrMue0QSzM6ybPqwVFmIOYvbA/EJxsc8iBgT2u/AD+Logq+0vKNYp4
wbJqVHTIK6iQik+3j68BkaxGdKNnwQI=
=Y3T/
-----END PGP SIGNATURE-----

--UayBKzP6GDiD7z8y2XGFaZg8vjzPWfYN1--
