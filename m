Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-26780-1520586109-2-17631993674015078740
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
    t=1520586108; b=qxOtS8EELEgBa9s928uMPjV/0pfEIYerroGWO0JsF+MXwoe
    IZMXlV5HWl1v7DpDMdkg9npvm831ik6SxLLkmElXGsMlNEgYpApmY9+/++W6+uYg
    WTfpkp2hXesdAldh6q0qP26+yuUs0xFZSuKSXYiF3q2nkV7LsnaL76oeT0eUt4w4
    7UP34SLqT4DkxrultKPwAFB24HOdQVjm0HM5Hm+EyNmj4f0vas1J9QWyZgPI5co1
    J0+bZFlWz0d7gZrn2ttHgBk8GucQjGICfRDXTV5PFRqR8Sy8cyuQSwrvUDd4dY12
    +rcaYURCudLzKB6M3dbdCIIAR3eAQDFzOpkbftw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:in-reply-to:references
    :date:message-id:mime-version:content-type:sender:list-id; s=
    arctest; t=1520586108; bh=OeQ9pAhT3sCpKOLbfFTEaOeq/SDBup+nG8Bi4q
    SbB8E=; b=LzvGXR4woOpAkgqefew7r2mMKXW5ufVHfryOOtohae2dXO84E9bXhU
    3ATzVBM1gU5yNkiaIr6Irno/8gs8QQkbrbqX5YOCLtaUmqCPRHA3WlnQ1YqIn9xf
    GkB+3i8DoXB4rkkyvgCPyPsFBT1frn0jGC/baPtybx6u/drms25UK7ORygScRuwv
    vcyrnc593qXxxeZ8MzLt0Zomt9jKfm2OwYnfoix5inD7+LWj/icIxGM9KzhXmcX4
    aEyfxNDn0W0QHxxeBTd+h5NikwPc2aJipUMmlSA0fGS/6UXtI3VejpNEFgphNZ6R
    niZj6ah2VMYntHkpp2/DVTwNB9U8inwQ==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    smime=temperror;
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=orgdomain_pass;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=kernel.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx5.messagingengine.com;
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
        id S1751161AbeCIJBb (ORCPT <rfc822;greg@kroah.com>);
        Fri, 9 Mar 2018 04:01:31 -0500
Received: from mga02.intel.com ([134.134.136.20]:34852 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751114AbeCIJBa (ORCPT <rfc822;linux-usb@vger.kernel.org>);
        Fri, 9 Mar 2018 04:01:30 -0500
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.47,444,1515484800";
   d="asc'?scan'208";a="36757032"
From: Felipe Balbi <balbi@kernel.org>
To: Roger Quadros <rogerq@ti.com>,
        Brian Norris <briannorris@chromium.org>
Cc: William Wu <william.wu@rock-chips.com>, gregkh@linuxfoundation.org,
        heiko@sntech.de, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org, linux-rockchip@lists.infradead.org,
        frank.wang@rock-chips.com, huangtao@rock-chips.com,
        dianders@google.com, briannorris@google.com, groeck@google.com,
        daniel.meng@rock-chips.com, John.Youn@synopsys.com,
        lin.huang@rock-chips.com
Subject: Re: [PATCH] usb: dwc3: core: power on PHYs before initializing core
In-Reply-To: <abca45d6-2304-a607-5185-f26327a653f5@ti.com>
References: <1515729616-8639-1-git-send-email-william.wu@rock-chips.com> <87ina6vodf.fsf@linux.intel.com> <20180308164916.GA65031@rodete-desktop-imager.corp.google.com> <abca45d6-2304-a607-5185-f26327a653f5@ti.com>
Date: Fri, 09 Mar 2018 11:01:17 +0200
Message-ID: <871sgtbp2a.fsf@linux.intel.com>
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
> Hi,
>
> On 08/03/18 18:49, Brian Norris wrote:
>> Hi,
>>=20
>> On Thu, Mar 08, 2018 at 12:43:40PM +0200, Felipe Balbi wrote:
>>> William Wu <william.wu@rock-chips.com> writes:
>>>> The dwc3_core_init() gets the PHYs and initializes the PHYs with
>>>> the usb_phy_init() and phy_init() functions before initializing
>>>> core, and power on the PHYs after core initialization is done.
>>>>
>>>> However, some platforms (e.g. Rockchip RK3399 DWC3 with Type-C
>>>> USB3 PHY), it needs to do some special operation while power on
>>>> the Type-C PHY before initializing DWC3 core. It's because that
>>>> the RK3399 Type-C PHY requires to hold the DWC3 controller in
>>>> reset state to keep the PIPE power state in P2 while configuring
>>>> the Type-C PHY, otherwise, it may cause waiting for the PIPE ready
>>>> timeout. In this case, if we power on the PHYs after the DWC3 core
>>>> initialization is done, the core will be reset to uninitialized
>>>> state after power on the PHYs.
>>>>
>>>> Fix this by powering on the PHYs before initializing core. And
>>>> because the GUID register may also be reset in this case, so we
>>>> need to configure the GUID register after powering on the PHYs.
>>>>
>>>> Signed-off-by: William Wu <william.wu@rock-chips.com>
>>>
>>> does this cause any regressions for your boards?
>>=20
>> I'm not Roger, but I believe it was determined we don't need this for
>> the Rockchip systems for which William was originally sending this. At
>> least not right now. I believe our PHY init problems were mostly
>> resolved in other ways.
>>=20
>> (Although I hear USB is currently pretty broken around suspend/resume
>> for us on -next. Likely unrelated.)
>>=20
>> I guess we never clearly replied stating the above. I hope this isn't
>> merged anywhere? Or I guess it's no problem to me at the moment, but it
>> might be needless churn.
>>=20
>
> I did some quick tests on TI platforms and didn't see any issues with thi=
s patch.
> Since this patch isn't really fixing your problem and we didn't have any
> problems to start with I'd suggest to avoid this churn for now.

fair enough, I won't apply it :-)

=2D-=20
balbi

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEElLzh7wn96CXwjh2IzL64meEamQYFAlqiTV0ACgkQzL64meEa
mQYAbBAAq6DNTsVhFehYtxLSararzyR1Bl7Jmm7fW7a5WRQL6oymcPBUIxqkNZeW
HKzeSPXSKptZamTwbTsy6f0O5KgZ+InB+/BpffoBMz4+H2m+od4n/QJJy1NRLF7v
9kvcX6vmfl+2qnEUTXZA3iuq5Ke7IXUsOiZbr54GnLdRLDP+Pc0G6figfpW/d8cA
XkJAxajTnxYhhm/TBF+v/tihfMTyJtNYRp1Z/YZcyGNAAy12mB/XA5bP8YDdn9Rz
Jse5StIviEGb/hKNd6S+myzv69tixXqFbyqSd2mG4ZgBOKxNg6IUHvU9sfc2xw/9
/K+pmceXwDUNOBJsICp6Akwq4jRqYNEVCfdRaMMvFTEHDm70LwkVCnC8XwFZpQ1k
KHL0/YnOBJH8L/hrinG6GoraURUstt8B/1EgVdnry7kYr952F1gDN+OgccI8PyiZ
8Jqy6ec4IS+wHmpVVsninE634t9iuYKqUt/OpdsXHIhGfMRqPRy+F0M3qbAkY6/J
M0TZGgIWMtxG4AsBdGK+MJUk31s4jwIO7mHRIMoXFBXTEoy57V5Ir5vAZVZKWwHW
2izw8+thTpw6UWJ79aFMd8GmeRIuzbCpWujK1aFj3x/fBxPE/aiTGfOzbmgZvUBy
r7lke7ehQz3y8b0dRMuRudfm6qCg+Ew1EX6uUDvF/y7Vw1bfo9w=
=VnTN
-----END PGP SIGNATURE-----
--=-=-=--
