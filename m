Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3288027-1519665624-2-4083181491231792617
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, ME_NOAUTH 0.01,
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
    t=1519665624; b=I8ihwpbYK432GhJRecVMcQaL9saBTZ/RJtmw2H6T7Plncij
    pgb8I84l6VjU4veEZ5wIKF3xlSIJEm3m4fHC+QN6dIpDsPR/Y47DfFYx9Lkjppez
    pTffHw3AYJ8PqzgCpGa6yiRGdOjmfGoU2bJLqtkMAV2gHpApphqhCoxkCvXykRk/
    fgo4bn8KZDcDA1ukJ6nb03GMZazOBtLbjRqRAt40ur4jlElxTA1XzrghkmIvsDbQ
    x0hVlb5I46ug4ThuKBFj+3aGDNtsRGsYlhyj/+DrHjr14b/pTtp1p8QUau1NJCg0
    XyPeLJp9T8JVkilaYqa6S0UxK2pPwU7+JRj2RmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=subject:to:references:from:message-id
    :date:mime-version:in-reply-to:content-type:sender:list-id; s=
    arctest; t=1519665624; bh=iLXOzxwid2MbV9phtys6VZO+pveKYCG2PeJiYc
    Mqq1Q=; b=e+2QU6jxb6p902sTx+phFaSYOcmEb47w5MmotfKL//jxyrdUx8yYto
    YLCUlYEoZDroAd2wdb8gMQgF8YxUnRzraXbRBOPJCSYg+SM8APwpqPLKjIK+cYkH
    2diUkQb5Zk8LLPBOg8DhNqHe0VI13o/jZkOAXvjC+NcDTj46NE+NKgPa2F8TtRy6
    uUcGG36j5eBOPv9uWqKutuyoTEvkbhwIeqiP2+tc7QBQhgovtBQqhsyHO0opUPfd
    ELCDl8OyePIiRtP3LFJsNE+elKUSIPZi1A0m434WQqn5yBWWuvFXfXDK2298GqnG
    NYsXYRuoPB8Ey1y0xBJ8K7Af1ESEg9+w==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=wizzup.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=wizzup.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=wizzup.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=wizzup.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751454AbeBZRUH (ORCPT <rfc822;greg@kroah.com>);
        Mon, 26 Feb 2018 12:20:07 -0500
Received: from nala.villavu.com ([188.165.243.101]:44953 "EHLO
        nala.villavu.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751079AbeBZRUG (ORCPT
        <rfc822;linux-usb@vger.kernel.org>); Mon, 26 Feb 2018 12:20:06 -0500
Subject: Re: [PATCH] usb: musb: call pm_runtime_{get,put}_sync before reading
 vbus registers
To: Bin Liu <b-liu@ti.com>, linux-omap@vger.kernel.org,
        tony@atomide.com, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20180226105609.22514-1-merlijn@wizzup.org>
 <20180226155716.GB20609@uda0271908>
From: Merlijn Wajer <merlijn@wizzup.org>
Message-ID: <73a1de6d-6bf4-275f-aee3-85699cd6ca76@wizzup.org>
Date: Mon, 26 Feb 2018 18:19:30 +0100
User-Agent: Mozilla/5.0 (X11; Linux armv7l; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180226155716.GB20609@uda0271908>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="v7DLODj7yyMXF0yaV8OWKW7IM7rys82oW"
Sender: linux-usb-owner@vger.kernel.org
X-Mailing-List: linux-usb@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--v7DLODj7yyMXF0yaV8OWKW7IM7rys82oW
Content-Type: multipart/mixed; boundary="ZxcOfYQgk538GczIH3XlQ1XTQx1BbNV8o";
 protected-headers="v1"
From: Merlijn Wajer <merlijn@wizzup.org>
To: Bin Liu <b-liu@ti.com>, linux-omap@vger.kernel.org, tony@atomide.com,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-usb@vger.kernel.org,
 linux-kernel@vger.kernel.org
Message-ID: <73a1de6d-6bf4-275f-aee3-85699cd6ca76@wizzup.org>
Subject: Re: [PATCH] usb: musb: call pm_runtime_{get,put}_sync before reading
 vbus registers
References: <20180226105609.22514-1-merlijn@wizzup.org>
 <20180226155716.GB20609@uda0271908>
In-Reply-To: <20180226155716.GB20609@uda0271908>

--ZxcOfYQgk538GczIH3XlQ1XTQx1BbNV8o
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: quoted-printable

Hi,

On 26/02/18 16:57, Bin Liu wrote:
> Hi,
>=20
> On Mon, Feb 26, 2018 at 11:56:08AM +0100, Merlijn Wajer wrote:
>> Without pm_runtime_{get,put}_sync calls in place, reading
>> vbus status via /sys causes the following error:
>>
>> Unhandled fault: external abort on non-linefetch (0x1028) at 0xfa0ab06=
0
>> pgd =3D b333e822
>> [fa0ab060] *pgd=3D48011452(bad)
>>
>> [<c05261b0>] (musb_default_readb) from [<c0525bd0>] (musb_vbus_show+0x=
58/0xe4)
>> [<c0525bd0>] (musb_vbus_show) from [<c04c0148>] (dev_attr_show+0x20/0x=
44)
>> [<c04c0148>] (dev_attr_show) from [<c0259f74>] (sysfs_kf_seq_show+0x80=
/0xdc)
>> [<c0259f74>] (sysfs_kf_seq_show) from [<c0210bac>] (seq_read+0x250/0x4=
48)
>> [<c0210bac>] (seq_read) from [<c01edb40>] (__vfs_read+0x1c/0x118)
>> [<c01edb40>] (__vfs_read) from [<c01edccc>] (vfs_read+0x90/0x144)
>> [<c01edccc>] (vfs_read) from [<c01ee1d0>] (SyS_read+0x3c/0x74)
>> [<c01ee1d0>] (SyS_read) from [<c0106fe0>] (ret_fast_syscall+0x0/0x54)
>>
>> Solution was suggested by Tony Lindgren <tony@atomide.com>.
>>
>> Signed-off-by: Merlijn Wajer <merlijn@wizzup.org>
>> ---
>>  drivers/usb/musb/musb_core.c | 4 ++++
>>  1 file changed, 4 insertions(+)
>>
>> diff --git a/drivers/usb/musb/musb_core.c b/drivers/usb/musb/musb_core=
=2Ec
>> index eef4ad578b31..ceaa40ef0e73 100644
>> --- a/drivers/usb/musb/musb_core.c
>> +++ b/drivers/usb/musb/musb_core.c
>> @@ -1760,6 +1760,8 @@ vbus_show(struct device *dev, struct device_attr=
ibute *attr, char *buf)
>>  	val =3D musb->a_wait_bcon;
>>  	vbus =3D musb_platform_get_vbus_status(musb);
>>  	if (vbus < 0) {
>> +		pm_runtime_get_sync(dev);
>> +
>>  		/* Use default MUSB method by means of DEVCTL register */
>>  		devctl =3D musb_readb(musb->mregs, MUSB_DEVCTL);
>>  		if ((devctl & MUSB_DEVCTL_VBUS)
>> @@ -1767,6 +1769,8 @@ vbus_show(struct device *dev, struct device_attr=
ibute *attr, char *buf)
>>  			vbus =3D 1;
>>  		else
>>  			vbus =3D 0;
>> +
>> +		pm_runtime_put_sync(dev);
>>  	}
>>  	spin_unlock_irqrestore(&musb->lock, flags);
>=20
> Thanks for the patch, but I got spinlock deadlock when testing it. I
> think the function pair should be at the outside scope of the
> spin_lock/unlock, doesn't it?

I see - sorry. Weird, it worked for me on my Nokia N900. What did you
test this on?

I will try to submit an improved version tonight (you seem to have a
good idea on what is wrong, so I will follow that), but it would help me
if I can reproduce the issue.

Cheers,
Merlijn


--ZxcOfYQgk538GczIH3XlQ1XTQx1BbNV8o--

--v7DLODj7yyMXF0yaV8OWKW7IM7rys82oW
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYIAB0WIQRM5LT7NbLF9yb6a/UGN09rynK8WgUCWpRBowAKCRAGN09rynK8
WsJ2AQCFTepleUmO+hp6g2z88hbLON6tpRFFkCLGamoyJkUZigEAiPE6v00LuuOu
8iPD3QEknN21HdFlDE+/WkOPqw9/LAw=
=8PVH
-----END PGP SIGNATURE-----

--v7DLODj7yyMXF0yaV8OWKW7IM7rys82oW--
