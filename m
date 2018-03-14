Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1279864-1521017450-2-16766493879987715398
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, T_TVD_MIME_EPI 0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='utf-8'
X-Attached: signature.asc
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-usb-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521017449; b=DnV80pNGNotb6lLOK2LQunY/Upe4dCCi7PU1y/xRCICIXfx
    4HipGPwZsqgESJjoK6BXqCR/ocLrTeHqWpm32Q0g9sV1Ifps3SYzdvUy7JOlE4dd
    NHhGfwnyIFQIH1BCtSChQJ9lwHE3KInpgzpPCKVaR2GyNOtr39MVtrnxmrZCECGi
    hfF6D3LQLVT949g9iEIXSOOgNeSRuQEP4XY6RWf77CfjiDnYIGLCuS60FBh2iqGp
    ye8+MuJ2G8DHPMwyoTaAJCddjIC0ZgLSEGEb1etqNHKlI51TPIlwsZzwT1zhlyJs
    J6RS8mUN6s4sQOjlUwIEQk+1W3YXf/IeKWu/0jg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:in-reply-to:references
    :date:message-id:mime-version:content-type:sender:list-id; s=
    arctest; t=1521017449; bh=YQSxTECdD/5ovDUw4g4eFjt5Xium6zO1i6ELUt
    aCmYY=; b=JjerHYKJlRLk3k1kpyD+CxpQB9K667UYu5Sjg7KR5AtrG1UBZtuok9
    6C3v8+an3kE4rFNSEAS3WsGlfatZYUtCjYaSZlNAUCubF2LDOwnwPut4xbdQAt+s
    6qmGQm2f39IqZPJ/SIyf18tD4zkBk/5CLP71/+IDYJoa0cfIfK+X6xnNUhl1/ZEs
    mTOQ/TBoUoJ2j8PCDHYYFZncwQtFB8A1QPF5McZ6UYaV9XNSwPTzLh/sD9looTII
    3mHAPnlHYw6LxOMshLpNPJG3GNCaBMkJOWOMmkAMC3d0uJtJz2Q6dWvQT+3QWgTv
    M9xqCxsnwwVnHBJ/We0GmCAmdEctW4og==
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
        id S1753328AbeCNIug (ORCPT <rfc822;greg@kroah.com>);
        Wed, 14 Mar 2018 04:50:36 -0400
Received: from mga12.intel.com ([192.55.52.136]:49100 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753166AbeCNIue (ORCPT <rfc822;linux-usb@vger.kernel.org>);
        Wed, 14 Mar 2018 04:50:34 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.47,469,1515484800";
   d="asc'?scan'208";a="24076188"
From: Felipe Balbi <balbi@kernel.org>
To: Manu Gautam <mgautam@codeaurora.org>,
        Rob Herring <robh+dt@kernel.org>,
        Andy Gross <andy.gross@linaro.org>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc: linux-arm-msm@vger.kernel.org, linux-usb@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v1 2/2] usb: dwc3: Add Qualcomm DWC3 glue driver
In-Reply-To: <5a65d202-bb94-0f73-f9aa-9055a1cddf76@codeaurora.org>
References: <1520937362-28777-1-git-send-email-mgautam@codeaurora.org> <1520937362-28777-2-git-send-email-mgautam@codeaurora.org> <878taw8c81.fsf@linux.intel.com> <5a65d202-bb94-0f73-f9aa-9055a1cddf76@codeaurora.org>
Date: Wed, 14 Mar 2018 10:50:12 +0200
Message-ID: <87woyfrqgr.fsf@linux.intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
        micalg=pgp-sha512; protocol="application/pgp-signature"
Sender: linux-usb-owner@vger.kernel.org
X-Mailing-List: linux-usb@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

--=-=-=
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable


Hi,

Manu Gautam <mgautam@codeaurora.org> writes:
> Hi,
>
>
> On 3/13/2018 4:38 PM, Felipe Balbi wrote:
>> Hi,
>>
>> +Andy
>>
>> Manu Gautam <mgautam@codeaurora.org> writes:
>>> DWC3 controller on Qualcomm SOCs has a Qscratch wrapper.
>>> Some of its uses are described below resulting in need to
>>> have a separate glue driver instead of using dwc3-of-simple:
>>>  - It exposes register interface to override vbus-override
>>>    and lane0-pwr-present signals going to hardware. These
>>>    must be updated in peripheral mode for DWC3 if vbus lines
>>>    are not connected to hardware block. Otherwise RX termination
>>>    in SS mode or DP pull-up is not applied by device controller.
>> right, core needs to know that VBUS is above 4.4V. Why wasn't this a
>> problem when the original glue layer was first published?
>
> Thanks for reviewing.
> Original glue layer supported only host mode, hence this wasn't needed.

okay

>>>  - pwr_events_irq_stat support to ensure USB2 PHY is in L2 state
>>>    before glue driver can turn-off clocks and suspend PHY.
>> Core manages PHY suspend automatically. Isn't that working for you? Why?
>
> Yes, it is not supported with QUSB2 PHY (usb2-phy on Qualcomm SOCs).

but the PHY doesn't need to support it, DWC3 does :-)

> Issue is that If core suspends USB2 PHY (say in host mode if some SS devi=
ce connected),
> USB2 PHY stops responding to any attach event as it can't exit suspend st=
ate by itself.

Okay, so we miss remote wakeup events. Fair enough.

>>>  - Support to replace pip3 clock going to DWC3 with utmi clock
>>>    for hardware configuration where SSPHY is not used with DWC3.
>> Is that SW configurable? Really? In any case seems like this and SESSVLD
>> valid should be handled using Hans' and Heikki's mux support.
>
> Yes, with this we can use dwc3 without using SSPHY. Please point me to
> those patches. There are only bunch of register writes in glue wrapper to
> achieve the same.

https://www.spinics.net/lists/linux-usb/msg160868.html

>>> +static int dwc3_qcom_suspend(struct dwc3_qcom *qcom)
>>> +{
>>> +	struct dwc3	*dwc =3D platform_get_drvdata(qcom->dwc3);
>> nope! Glue shouldn't touch dwc3 at all.
> Other than PHY handles, need this to fail runtime suspend if dwc3 hasn't
> probed yet.

Will that even happen? You should pm_runtime_forbid() by default,
anyway and expect it to be enabled via sysfs later, no?

>>> +	dwc3_qcom_suspend_hsphy(qcom);
>>> +
>>> +	if (dwc->usb2_generic_phy)
>>> +		phy_pm_runtime_put_sync(dwc->usb2_generic_phy);
>>> +	if (dwc->usb3_generic_phy)
>>> +		phy_pm_runtime_put_sync(dwc->usb3_generic_phy);
>> core.c should do this.
> Recommended sequence from h/w programming guide is that:
> 1. PHY autosuspend must be left disabled - snps,dis_u2_susphy_quirk/dis_e=
nblslpm_quirk
> 2. During runtime-suspend (say on xhci bus_suspend) , PHY should be suspe=
nded
> =C2=A0 =C2=A0 using GUSB2PHYCFG register

this is something that dwc3 core can do on its own suspend implementation.

> 3. Wait until pwr_event_irq_stat in qscratch reflects PHY transition to L=
2.

this is interesting part. Is this register accessible by the PHY driver?
Seems like that would be the best place to stuff this...

> 3. USB2 PHY driver can suspend - enable wakeup events and turns off clock=
s etc.

... together with this.

> 4. dwc3 glue driver can suspend.
>
> Since, pwr_event_irq stat can't be checked in core driver, I added this h=
andling
> in glue driver. Alternative approach I can think of is to let dwc3 core s=
uspend
> PHY using GUSBPHYCFG register on suspend,=C2=A0 add some delay before
> suspending PHY. Glue driver can check for pwr_event_irq stat and throw a
> warning if PHY not in L2.

almost :-) core_suspend fiddles with GUSB2PHYCFG for suspend and calls
phy_suspend() (or whatever the function is called heh), that will go to
your phy driver's suspend callback, which checks pwr_event_irq_stat and
then pm_runtime_put() to schedule ->runtime_suspend() so that can enable
wakeups and switch off clocks.

>>> +	irq =3D platform_get_irq_byname(pdev, "dp_hs_phy_irq");
>>> +	if (irq > 0) {
>>> +		irq_set_status_flags(irq, IRQ_NOAUTOEN);
>> why do you need to set this flag?
> These wakeup_irqs should be enabled only during suspend. With this flag I
> don't need to disable irq immediately after requesting it.

oh, okay. You may want to add a comment here :-)

>
>>
>>> +		ret =3D devm_request_threaded_irq(qcom->dev, irq, NULL,
>>> +					qcom_dwc3_resume_irq,
>>> +					IRQF_TRIGGER_HIGH | IRQF_ONESHOT,
>>> +					"qcom_dwc3 DP_HS", qcom);
>> this is the same as devm_request_irq()
> I am passing hard_irq handler as NULL whereas thread_fn is not NULL.
> devm_request_irq is just the opposite.

oh, indeed. I misparsed it.

>>> +static const struct dev_pm_ops dwc3_qcom_dev_pm_ops =3D {
>>> +	SET_SYSTEM_SLEEP_PM_OPS(dwc3_qcom_pm_suspend, dwc3_qcom_pm_resume)
>>> +	SET_RUNTIME_PM_OPS(dwc3_qcom_runtime_suspend, dwc3_qcom_runtime_resum=
e,
>>> +			   NULL)
>> why don't you have runtime_idle?
>
> I didn't see any need for that. rpm_idle will invoke rpm_suspend if idle =
callback
> is not specified.

Right, but ->runtime_idle() helps making things a little more
readable. It is, however, a matter of taste. No strong feelings here. :-)

=2D-=20
balbi

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEElLzh7wn96CXwjh2IzL64meEamQYFAlqo4kYACgkQzL64meEa
mQZCCRAA0blI1D1nOAAMl06rb+jsilSfIsJFCN30Dz/9AFv1vMecbB2crJLWQNEJ
IT39n7ssbYp2JQLviZ3dZLMEeuUVHy3Ml4KYGRM04VG8BNQZcxGWphDeDOTBujvz
xPP/1bjA3VR9MTd05GotWwnLF+EMfHSHsMi4C/waVLTBIillrglXK1D7nrZLXO1m
C4VxqcmhkAqGL4rexQ4FyvsKrmYOZGjuVO0PiUGfJelBJR56x5opA7jA4VqCPEYF
pVxATPPvm9lj92PEDW39rQIiRSeSAmqFQ23PDoVkm4DzPC+o1SeZ68cxIwQUZtlY
FKoIOq8026D8XE8PX3pXagRzOTYEekz1YWAXFP8WMYRlmoIh/htmVtrG/04+0mjo
YbeYxslStw1yg7FB+tY5q4O+s9rOey+a5FNBjgUchj4MMTsrfZTTpxSBC32w34Aq
wjTSlZQ86p/xVHeEsi4xHqYya0egCggE0So71gx8uwRDXu9kzcYcIGyn8V7lISiG
qZB0jtf9Z5oe0mIBMU0/L55qsug0NeG5oscV6U8goZrQKrp1Qov0b160gSe5s/4f
ShjZGtbd06LgAbOTgeC/k7GhlhhMUNWoCHRiWnaIBnQN2KPLcsj1stIxbd/fRfaj
DEOElEwgnHnJnK0VrVsAqEiicu4uegO9zC3bEA9lTJAF5Qja+wM=
=8FBf
-----END PGP SIGNATURE-----
--=-=-=--
