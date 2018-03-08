Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1971043-1520514834-2-3972594844308709679
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
    t=1520514834; b=IhsDLgKk2IA13L92ykf5Nh46bhy2QKjECSp1ttC4HuPUTNe
    k/ZNzsXUEVk62EhyV7ABURZraGWKLDEAre1DWsMqb8NFpsZV0yDya5q09aCVwUV2
    YhA9Q4SFm8h2BbDkZVZAWB7YyTpZYHIi82WSvuyrmk8c60R6pYx5zY9s6dPRCanU
    GzhQewIBYTeCq9j3mgVMmStbIDDeSR9n83Rpk3wH81zietgMlHO8x9p4VIPYAXIK
    SJL4/4/nt4i7+tAmYj1xRbT/NMO4k/Fl6mz7vtk6CHI+mdjB3BN34pTqAqufZkht
    WlW5L7FSgxc0K7uDQx8JMB81oFDXOsl6HsTPZgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:in-reply-to:references
    :date:message-id:mime-version:content-type:sender:list-id; s=
    arctest; t=1520514834; bh=wRW/pa+sy5aD44YHFF56DIoi2Inq4N5gDwq8D3
    hb2gk=; b=pdZy+szUMDmxq/VNuWWv+38PSxjQDTN5sOOAVMl5qoKnL5rq2kHyaa
    1hO/46YD5717ag+1zvs5IYZVzX94lneNQiPcEtXtbsSTCzaFLtVF0+euApH45AtW
    +Rhws/1YnPF7r4x5GlAoSN5y+bW6oj4ViKEgVCzqGpGKa0lgqd6hA38d+69EhNfV
    7pewJZKaLJ14YRYa0UatHeV2JW13omrUzcwgAjikDJF8gWJVWnl8BrNSxUCg/eml
    AZDH9qpq3cbHWAwGMBUR65rMHFe53YT5FXQLHPnbI1g/kxMXPcSHMcPa6le9nBVU
    WisChJ+sK06NxfsqbKy6fVuCjXtksmUQ==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    smime=temperror;
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=orgdomain_pass;
    x-category=spam score=150 state=1;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=kernel.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    smime=temperror;
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=orgdomain_pass;
    x-category=spam score=150 state=1;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=kernel.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935742AbeCHNNA (ORCPT <rfc822;greg@kroah.com>);
        Thu, 8 Mar 2018 08:13:00 -0500
Received: from mga05.intel.com ([192.55.52.43]:58632 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S935041AbeCHNM6 (ORCPT <rfc822;linux-usb@vger.kernel.org>);
        Thu, 8 Mar 2018 08:12:58 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.47,441,1515484800";
   d="asc'?scan'208";a="209898181"
From: Felipe Balbi <balbi@kernel.org>
To: Roger Quadros <rogerq@ti.com>
Cc: linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] usb: dwc3: add dual role support using OTG block
In-Reply-To: <7c9382af-bd99-2599-35b1-863320517a0c@ti.com>
References: <1519730952-2102-1-git-send-email-rogerq@ti.com> <1519731019-2220-1-git-send-email-rogerq@ti.com> <87lgf2vol2.fsf@linux.intel.com> <7c9382af-bd99-2599-35b1-863320517a0c@ti.com>
Date: Thu, 08 Mar 2018 15:12:50 +0200
Message-ID: <87ina6btil.fsf@linux.intel.com>
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


Hi,

Roger Quadros <rogerq@ti.com> writes:
> Felipe,
>
> On 08/03/18 12:39, Felipe Balbi wrote:
>> Roger Quadros <rogerq@ti.com> writes:
>>=20
>>> This is useful on platforms (e.g. TI AM437x) that don't
>>> have ID available on a GPIO but do have the OTG block.
>>>
>>> We can obtain the ID state via the OTG block and use it
>>> for dual-role switching.
>>>
>>> Signed-off-by: Roger Quadros <rogerq@ti.com>
>>=20
>> patch one applied fine to testing/next. But not this one:
>
> That's because you will need this commit from v4.16-rc3
>
> c4a5153e87fd	("usb: dwc3: core: Power-off core/PHYs on system_suspend in =
host mode")
>
> Could you please apply that and let me know if it works?

indeed, applied fine. thanks

=2D-=20
balbi

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEElLzh7wn96CXwjh2IzL64meEamQYFAlqhNtIACgkQzL64meEa
mQZqSg//TdXkYkh87opIHT67GdtMuzKO07rUiHw+qzqfl4JKcWhEEy+XFEc5M5PW
eNiuzRUtEvhqGvCKX4vO/xawSCx1rI5KDkCSwTfHHQLcXBYcgGbBDuNfW8jmY0P+
1YilfnSQY+1r7PUEPIloDBGF90LviWXHs8QNJuspYth7ZLOwPMXXtB6hYzdddCT9
ffwU4iYR5IgOHp+KPBotW2Kv3xSwpcMYKkcAfHh6rdLNGYrqpIF/l4H8EsTARB+r
Kqs3sF5xiMEY9umqFgJuUqbMi6x8QILFuYbWgVM+kLcl8jjieau+NaMxs41qkgy1
v3GF8uiYfcaaPS0qgi3JB5pkJGnr63sUgsx2pyAZ98KXdXTTm1r9hPkBr3DjpCnq
rU/wwbjJxHUJBtGFVxFsQHbSoa/wNOA66sW1GxrsV6BhHkXo89j83B7e++kUQx22
PnV7+1Xpir3yafzqcaqn/J/B7zaTN/q1KW3A+r/ys8KbzdSZDK3za5jtsCXN7h4a
TU9zrpbfJInKGy7qLsGwOeaBjedria9iSOYE8zFLjYFASjjl8VSgj6T2bGB3uzd7
VSf3LWgPg3IhSsk5etmuqgh+rw2Vje+g3TRYrnXxvrk1RgPOZo93Xi+EEjqKfst3
jZ3d1Co7g+RCLfEGuPSdRPtHVlB+Oc+7Z8aGVhcpCACd4QwwYsY=
=jMSC
-----END PGP SIGNATURE-----
--=-=-=--
