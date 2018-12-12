Return-Path: <SRS0=v2je=OV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_MIXED_ES,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E609C04EB8
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 06:52:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C7F1D20851
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 06:52:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544597550;
	bh=Gw9yZwcerAdqMANRjGQ/u3XhYBF2LO/puCDzmFnoiRo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:List-ID:From;
	b=VpkLR7m5KDv+y6ddMImjzVFsCimP06e1xx07+KYvlJMwB3rUNzCLOMyw/lyKg52iI
	 mYZpKph7CnaJR7eu4MXCCHOtf0WB1oMq5kCKsQ3BgRBGGh54CRRsMhs03FGB4dgJ6u
	 0aUvEZOvoSWTbgEX6fzlAK6p2frrPsCP7F9jO6DA=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C7F1D20851
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726551AbeLLGw2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Dec 2018 01:52:28 -0500
Received: from mga17.intel.com ([192.55.52.151]:36004 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726242AbeLLGw2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Dec 2018 01:52:28 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 11 Dec 2018 22:52:27 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,343,1539673200"; 
   d="asc'?scan'208";a="109701464"
Received: from pipin.fi.intel.com (HELO localhost) ([10.237.72.175])
  by orsmga003.jf.intel.com with ESMTP; 11 Dec 2018 22:52:23 -0800
From:   Felipe Balbi <balbi@kernel.org>
To:     Pawel Laszczak <pawell@cadence.com>,
        "devicetree\@vger.kernel.org" <devicetree@vger.kernel.org>,
        Kishon Vijay Abraham I <kishon@ti.com>
Cc:     "gregkh\@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "linux-usb\@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "rogerq\@ti.com" <rogerq@ti.com>,
        "linux-kernel\@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Alan Douglas <adouglas@cadence.com>,
        "jbergsagel\@ti.com" <jbergsagel@ti.com>,
        "nsekhar\@ti.com" <nsekhar@ti.com>, "nm\@ti.com" <nm@ti.com>,
        Suresh Punnoose <sureshp@cadence.com>,
        "peter.chen\@nxp.com" <peter.chen@nxp.com>,
        Pawel Jez <pjez@cadence.com>, Rahul Kumar <kurahul@cadence.com>
Subject: RE: [PATCH v1 2/2] usb:cdns3 Add Cadence USB3 DRD Driver
In-Reply-To: <BYAPR07MB47095110AF28CC11B4C9E144DDA60@BYAPR07MB4709.namprd07.prod.outlook.com>
References: <1544445555-17325-1-git-send-email-pawell@cadence.com> <1544445555-17325-3-git-send-email-pawell@cadence.com> <87h8fkmfar.fsf@linux.intel.com> <BYAPR07MB47095110AF28CC11B4C9E144DDA60@BYAPR07MB4709.namprd07.prod.outlook.com>
Date:   Wed, 12 Dec 2018 08:52:13 +0200
Message-ID: <87a7lbme3m.fsf@linux.intel.com>
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


Hi

Pawel Laszczak <pawell@cadence.com> writes:
>>> +	cdns->phy =3D devm_phy_get(dev, "cdns3,usbphy");
>>> +	if (IS_ERR(cdns->phy)) {
>>> +		ret =3D PTR_ERR(cdns->phy);
>>> +		if (ret =3D=3D -ENOSYS || ret =3D=3D -ENODEV) {
>>
>>Are you sure you can get ENOSYS here? Have you checked output of
>>checkpatch --strict?
>>-:852: WARNING: ENOSYS means 'invalid syscall nr' and nothing else
>
> Yes this error code can be returned by related to phy function if
> CONFIG_GENERIC_PHY is disabled.
>
> I have seen this warning in output of checkpatch --strict .

Kishon, seems like you shouldn't be using that error value.

<snip>

>>> +	case USB_REQ_SET_ISOCH_DELAY:
>>> +		sprintf(str, "Set Isochronous Delay Delay: %d ns", wValue);
>>> +		break;
>>> +	default:
>>> +		sprintf(str,
>>> +			"SETUP BRT: %02x BR: %02x V: %04x I: %04x L: %04x\n",
>>> +			bRequestType, bRequest,
>>> +			wValue, wIndex, wLength);
>>> +	}
>>> +
>>> +	return str;
>>> +}
>>
>>All of these are a flat out copy of dwc3's implementation. It's much,
>>much better to turn dwc3's implementation into a generic, reusable
>>library function then spinning your own as a duplicated effort.
> I agree,=20
> It would be nice to have a set of decoding function  in some generic libr=
ary. It could be used=20
> also by other drivers.
> Who should do this ?

since you're the first to reuse it, then it should be you :-)

>>> +static int cdns3_req_ep0_set_configuration(struct cdns3_device *priv_d=
ev,
>>> +					   struct usb_ctrlrequest *ctrl_req)
>>> +{
>>> +	enum usb_device_state device_state =3D priv_dev->gadget.state;
>>> +	struct cdns3_endpoint *priv_ep;
>>> +	u32 config =3D le16_to_cpu(ctrl_req->wValue);
>>> +	int result =3D 0;
>>> +	int i;
>>> +
>>> +	switch (device_state) {
>>> +	case USB_STATE_ADDRESS:
>>> +		/* Configure non-control EPs */
>>> +		for (i =3D 0; i < CDNS3_ENDPOINTS_MAX_COUNT; i++) {
>>> +			priv_ep =3D priv_dev->eps[i];
>>> +			if (!priv_ep)
>>> +				continue;
>>> +
>>> +			if (priv_ep->flags & EP_CLAIMED)
>>> +				cdns3_ep_config(priv_ep);
>>> +		}
>>> +
>>> +		result =3D cdns3_ep0_delegate_req(priv_dev, ctrl_req);
>>> +
>>> +		if (result)
>>> +			return result;
>>> +
>>> +		if (config) {
>>> +			cdns3_set_hw_configuration(priv_dev);
>>> +		} else {
>>> +			cdns3_gadget_unconfig(priv_dev);
>>> +			usb_gadget_set_state(&priv_dev->gadget,
>>> +					     USB_STATE_ADDRESS);
>>
>>this is wrong. If address is zero, state should be default, not
>>addressed. Addressed would be used on the other branch here, when you
>>have a non-zero address
>
> If address is zero then state should be USB_STATE_DEFAULT. Driver
> enters to this branch only if gadget.state =3D USB_STATE_ADDRESS
> (address !=3D 0). This state can be changed in composite.c file after
> delegating request to gadget driver. Because this state could be
> changed driver simple restore USB_STATE_ADDRESS if config =3D 0.

nevermind, I read this as being the handler for Set Address. This is Set
Config, instead.

>>> +		}
>>> +		break;
>>> +	case USB_STATE_CONFIGURED:
>>
>>where do you set this state?
> It's set in set_config in composite.c file.=20

indeed

>>> +	case USB_DEVICE_TEST_MODE:
>>> +		if (state !=3D USB_STATE_CONFIGURED || speed > USB_SPEED_HIGH)
>>> +			return -EINVAL;
>>> +
>>> +		tmode =3D le16_to_cpu(ctrl->wIndex);
>>> +
>>> +		if (!set || (tmode & 0xff) !=3D 0)
>>> +			return -EINVAL;
>>> +
>>> +		switch (tmode >> 8) {
>>> +		case TEST_J:
>>> +		case TEST_K:
>>> +		case TEST_SE0_NAK:
>>> +		case TEST_PACKET:
>>> +			cdns3_set_register_bit(&priv_dev->regs->usb_cmd,
>>> +					       USB_CMD_STMODE |
>>> +					       USB_STS_TMODE_SEL(tmode - 1));
>>
>>I'm 90% sure this won't work. There's a reason why we only enter the
>>requested test mode from status stage. How have you tested this?
>
> From USB spec:
> "The transition to test mode must be complete no later than 3 ms after th=
e completion of the status stage of the
> request."

exactly, _after_ completion of status stage :-)

> But I don't remember any issues with this test on other ours
> drivers. Maybe status stage is armed in this case by controller. I
> have to confirm how it works with hardware team.  Driver doesn't know
> when status stage was completed. We don't have any event on status
> stage completion.  I haven't checked it yet with tester on this
> driver.

Let's consider the scenario where you're requesting Test_Packet mode. If
you start transmitting the test pattern from setup stage, how can you
even transmit status stage?

>>> +void cdns3_gadget_unconfig(struct cdns3_device *priv_dev)
>>> +{
>>> +	/* RESET CONFIGURATION */
>>> +	writel(USB_CONF_CFGRST, &priv_dev->regs->usb_conf);
>>> +
>>> +	cdns3_allow_enable_l1(priv_dev, 0);
>>> +	priv_dev->hw_configured_flag =3D 0;
>>> +	priv_dev->onchip_mem_allocated_size =3D 0;
>>
>>clear all test modes? Reset ep0 max_packet_size to 512?
> Test mode should be reset automatically on exit.=20

on exit? Which exit? Did you test this on USB Reset? Did you run USBCV
on Super and High speed with any gadget?

> W can't clear this mode in register. It's WAC (write only and auto clear)=
  bit.
> This function only reset endpoint configuration in controller register.=20
> Ep0 max_packet_size should be unchanged here.  Ep0 max_packet it's update=
d on=20
> Connect/Disconnect/Reset events.=20=20

right, and this is called for both reset and disconnect (see below). If
you're telling me that test mode and ep0 wMaxPacketSize is handled
elsewhere, that's fine.

+	/* Disconnection detected */
+	if (usb_ists & (USB_ISTS_DIS2I | USB_ISTS_DISI)) {
+		if (priv_dev->gadget_driver &&
+		    priv_dev->gadget_driver->disconnect) {
+			spin_unlock(&priv_dev->lock);
+			priv_dev->gadget_driver->disconnect(&priv_dev->gadget);
+			spin_lock(&priv_dev->lock);
+		}
+
+		priv_dev->gadget.speed =3D USB_SPEED_UNKNOWN;
+		usb_gadget_set_state(&priv_dev->gadget, USB_STATE_NOTATTACHED);
+		cdns3_gadget_unconfig(priv_dev);
+	}
+
+	/* reset*/
+	if (usb_ists & (USB_ISTS_UWRESI | USB_ISTS_UHRESI | USB_ISTS_U2RESI)) {
+		/*read again to check the actuall speed*/
+		speed =3D cdns3_get_speed(priv_dev);
+		usb_gadget_set_state(&priv_dev->gadget, USB_STATE_DEFAULT);
+		priv_dev->gadget.speed =3D speed;
+		cdns3_gadget_unconfig(priv_dev);
+		cdns3_ep0_config(priv_dev);
+	}


> Maybe this function should be called cdns3_hw_reset_eps_config.=20

perhaps

> It doesn't unconfigure whole gadget but only reset endpoints configuratio=
n kept by=20
> controller.
> I will change this function.=20

ok

>>> +static irqreturn_t cdns3_device_irq_handler(int irq, void *data)
>>> +{
>>> +	struct cdns3_device *priv_dev;
>>> +	struct cdns3 *cdns =3D data;
>>> +	irqreturn_t ret =3D IRQ_NONE;
>>> +	unsigned long flags;
>>> +	u32 reg;
>>> +
>>> +	priv_dev =3D cdns->gadget_dev;
>>> +	spin_lock_irqsave(&priv_dev->lock, flags);
>>
>>you're already running in hardirq context. Why do you need this lock at
>>all? I would be better to use the hardirq handler to mask your
>>interrupts, so they don't fire again, then used the top-half (softirq)
>>handler to actually handle the interrupts.
>
> Yes, spin_lock_irqsave is not necessary here.=20
>
> Do you mean replacing devm_request_irq with a request_threaded_irq ?
> I have single interrupt line shared between  Host, Driver, DRD/OTG.=20
> I'm not sure if it will work more efficiently.=20

The whole idea for running very little in hardirq context is to give the
scheduler a chance to decide what should run. This is important to
reduce latency when running with RT patchset applied, for
example. However, I'll give you that, it's a minor requirement. It's
just that, to me, it's a small detail that's easy to implement.

>>> +	/* check USB device interrupt */
>>> +	reg =3D readl(&priv_dev->regs->usb_ists);
>>> +	writel(reg, &priv_dev->regs->usb_ists);
>>> +
>>> +	if (reg) {
>>> +		dev_dbg(priv_dev->dev, "IRQ: usb_ists: %08X\n", reg);
>>
>>I strongly advise against using dev_dbg() for debugging. Even more so
>>inside your IRQ handler.
> Ok, It's not necessary in this place, especially, that there is invoked t=
race point=20
> inside cdns3_check_usb_interrupt_proceed which makes the same.

overhead. Tracepoints are really, really low overhead. The string
decoding doesn't happen until you read the trace file.

=2D-=20
balbi

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEElLzh7wn96CXwjh2IzL64meEamQYFAlwQsB8ACgkQzL64meEa
mQZTFBAAzCz5Xjms6g/VgCfwqihk5jT43+4N333dW+KzDW9DpW7FMhEDcMhRt2eO
E39KB6wIKE9on6XiNppRkYG9XNzp7MBgLfF74/0NWEfmorsNUUrh1d3xRjXMJMGt
woETX8vC10MNq4naAjJMEBqvnFJ3qbjoTZcAVUosVXgVO3F2pxT+lprRg/nN3Uge
NEj0tHoFquHUIilw4ySQk4TtJM4+4w5bgusjbOLFqZdnNdpeLrwzksXvjP5Quyir
PTYWeP7uFfws/qI2LZW+2igwz/MSNW8cAG7eR28cr+chZaOdogqFoj+6mBlljTJG
XQd5jNvZQp4dlD98ZuYkoNVCprGf7O6tgU/Hc7/4Nls9TK1wVzUWj3Vzyep20pEg
PRTrA83Qv63zTgIPYntMZ0bmP1i48Vj2gmSrMKjbQ0FlGgEP84pGwJ3SrsuKTPPV
HVzi0HfJxGhZKaorKBB3B/isazgBGhxUegM3Jj5P4Cezb2nF2mMRp0ASu8n5jVMy
jJN1RHHtqCwSUGxYN7f9BFfrUiLl41ususK5LDGqn07gBRXWq/XM+6SMPWQopGng
KRjOEt2pTYsp24eFIBXdTo/49hO9s+JXYiMTI1fUJC8FK4x8Ug/pl+CUyrDArQtE
3JsUi55d83LWtKg9f799oYtx9dV28/aFRCFlJbM34uGmahnodu8=
=JcCE
-----END PGP SIGNATURE-----
--=-=-=--
