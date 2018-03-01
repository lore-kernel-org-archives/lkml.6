Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-4152423-1519948058-2-11283248146145109476
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, T_TVD_MIME_EPI 0.01,
  LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: cc='UTF-8', plain='utf-8'
X-Attached: signature.asc
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-usb-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519948058; b=og5hxLi0nXS1VKLm6gv4jzc2Ehsk/e4m+rCvsliUmVdfGbD
    EI2A1x6fsmnrkqyTDTEPbaKlj0SgjDmqhQMVyIL6ucx/ERcbrqbFE2xlFlRn46FN
    JtGXxMHyyjYuA1WUaoYBXk9nMsrIuaC2UG4I1Reb+OceoHH50NSYrI0EydrtsHon
    e+ghuN+3nq0Swo0M1Yoli/VcqJ7qMWdzdwvQ6iHO0GP+jAQWc+dV3/YZyLo5UB7n
    T7GJRgCQz0RMPni081Sm//6H4clm1KxNWeAZS9B4NCn5hXQssEO6i0chlMojWPAZ
    9iR8O3vIGnq6GmLf5F6FeJY1OS1NwW5xTOtzgRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=to:cc:from:subject:message-id:date
    :mime-version:content-type:sender:list-id; s=arctest; t=
    1519948058; bh=XMi+1/hztvLdVvZpoGgV5yIkzvK3glMgobICooEHry4=; b=H
    mCujRGaZm6Ssr8c8RJQuPFOEDp/SenGf5TPoaJN8mTZ+IQFWcxxK++0fP4DofnD4
    2UKAKQpNGNmsisGDf0prtpIcXdZDvCYp6RXgRFnJaaxhjz5EoOC6Qq5jqzBgJRHj
    lgyvZ5sc/mYUbI2o2ExoC8hOAfwLsRc3mp8E5vMCvYndzqeoxb24T/dTNLHmU49m
    1SDIp3jIt2TN7DPtpsp/XzN8LOJM0OygKCRyQBzdQuEjz8ifvzMT0k8+fKol0CTI
    HnbfnhTWnczSbLU0sNWIA/kicAPLlHndKA0xCCOPZgw88LExj+LcD9Hq0nLtFsQh
    ZfQk9FhFB6YL8NBhRoSdw==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=wizzup.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=wizzup.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=wizzup.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=wizzup.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1163445AbeCAXrX (ORCPT <rfc822;greg@kroah.com>);
        Thu, 1 Mar 2018 18:47:23 -0500
Received: from nala.villavu.com ([188.165.243.101]:40293 "EHLO
        nala.villavu.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1163229AbeCAXrW (ORCPT
        <rfc822;linux-usb@vger.kernel.org>); Thu, 1 Mar 2018 18:47:22 -0500
To: Bin Liu <b-liu@ti.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        =?UTF-8?Q?Pali_Roh=c3=a1r?= <pali.rohar@gmail.com>,
        Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>,
        linux-omap@vger.kernel.org
From: Merlijn Wajer <merlijn@wizzup.org>
Subject: usb: musb: "(null)" in sysfs mode file after disabling a gadget (and
 at other times, system hangs)
Message-ID: <f7a8cfac-e70b-046a-b465-7b37630d5d86@wizzup.org>
Date: Fri, 2 Mar 2018 00:47:07 +0100
User-Agent: Mozilla/5.0 (X11; Linux armv7l; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="oppHN8720nJDSW0moTFny67VymaCCNuFA"
Sender: linux-usb-owner@vger.kernel.org
X-Mailing-List: linux-usb@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--oppHN8720nJDSW0moTFny67VymaCCNuFA
Content-Type: multipart/mixed; boundary="92YCC1hftCZSStZab6Cetqmpq8LUyXBGQ";
 protected-headers="v1"
From: Merlijn Wajer <merlijn@wizzup.org>
To: Bin Liu <b-liu@ti.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
 =?UTF-8?Q?Pali_Roh=c3=a1r?= <pali.rohar@gmail.com>,
 Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>, linux-omap@vger.kernel.org
Message-ID: <f7a8cfac-e70b-046a-b465-7b37630d5d86@wizzup.org>
Subject: usb: musb: "(null)" in sysfs mode file after disabling a gadget (and
 at other times, system hangs)

--92YCC1hftCZSStZab6Cetqmpq8LUyXBGQ
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: quoted-printable

Hi,

I found that the "mode" file in musb sys node will return "(null)" when
one would expect it show b_idle.

Wrong /mode file:

[Fresh boot, cable not connected yet]
root@n900devuan:~# modprobe g_nokia
[Insert cable connected to PC]
root@n900devuan:~# cat
/sys/devices/platform/68000000.ocp/480ab000.usb_otg_hs/musb-hdrc.0.auto/m=
ode
b_peripheral
[Remove cable connected to PC]
root@n900devuan:~# cat
/sys/devices/platform/68000000.ocp/480ab000.usb_otg_hs/musb-hdrc.0.auto/m=
ode
b_idle
root@n900devuan:~# rmmod g_nokia
root@n900devuan:~# cat
/sys/devices/platform/68000000.ocp/480ab000.usb_otg_hs/musb-hdrc.0.auto/m=
ode
(null)
[Insert cable connected to PC]
root@n900devuan:~# cat
/sys/devices/platform/68000000.ocp/480ab000.usb_otg_hs/musb-hdrc.0.auto/m=
ode
b_idle

I would expect it to state "b_idle" instead of "(null)".
I have also been able to reproduce this "(null)" state using only
configfs (and not deprecated g_nokia module), but this example is more
cumbersome to write up)


Sometimes it crashes the entire system (reproducibly):

[Fresh boot, USB cable connect to PC at all times]
root@n900devuan:~# cat
/sys/devices/platform/68000000.ocp/480ab000.usb_otg_hs/musb-hdrc.0.auto/m=
ode
b_idle
root@n900devuan:~# modprobe g_nokia
root@n900devuan:~# cat
/sys/devices/platform/68000000.ocp/480ab000.usb_otg_hs/musb-hdrc.0.auto/m=
ode
b_peripheral
root@n900devuan:~# rmmod g_nokia
(Hangs, reboots after a few seconds, probably due to watchdog)


This occurs on Nokia N900 (RX-51). Kernel config has:

CONFIG_USB_LIBCOMPOSITE=3Dm
CONFIG_USB_F_*=3Dm
CONFIG_USB_G_*=3Dm

I don't have a trace because I don't have a serial on my Nokia N900. I
have not yet tested this on other musb devices, but I can do that if
that helps reproducing the issue.

Cheers,
Merlijn


--92YCC1hftCZSStZab6Cetqmpq8LUyXBGQ--

--oppHN8720nJDSW0moTFny67VymaCCNuFA
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYIAB0WIQRM5LT7NbLF9yb6a/UGN09rynK8WgUCWpiQ+wAKCRAGN09rynK8
WtVMAP4himSJrs3BWzRBvU2MnT/2LcIYc63PBQE7RKE03uB4FwD/Rgjdw0KyeEDX
z2D6zNvYfN/0ssZE3v4vQ7ig7W4H/go=
=wlPG
-----END PGP SIGNATURE-----

--oppHN8720nJDSW0moTFny67VymaCCNuFA--
