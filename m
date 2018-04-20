Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1262712-1524216965-2-5552684842639587245
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org', XOriginatingCountry='IN'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-usb-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1524216964; b=rX1IspkgD72DW7puXC0pxp4YXk1+MWUGxEGeVs6/KbIJHmCjIA
    pfLODeET+NejYl63i0VVRCRvoPUwXTOYjeYNawsYMFSzL8l3yB0w+VxVMKPM2WHX
    mRS5bzkIEvjKNItMOTAW5OQp3VBJVn13iDajyw0wQKlHweclnwidzbOZwtLRqKni
    /trC0wF0D48yaa0XvXJGzY/LnGtP3mivUmXjQIlgKr0t1401aNitCgSrp/JRmR0E
    W5AtUls9GDZRPrntQhDH/cfGqRO/j0/65ycxEHrbygyzvyaleKXBKyDtlvWBM4d4
    hr/feHusEQ4oAWJT209sPfc68J9EvVWfp5VQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=fm2; t=1524216964; bh=k4kUMU28bo
    Q47o8021Xzrn9t4FTpA7lSfJ7ABKTJAz4=; b=ez+3ZVrGqQjHysGneeaJQS9tG4
    d8liL0E1uKH4G16SPz6pr1mg8Lwyrqy8hBxqXZqqxahQLj1dGtvN3FULFmYiS6pK
    B39D6XXqoXZCLF/k1Y4yZ0TMPXb5HYUnqiF1mQ940h62vC+guLVQsbjQzk8WbMha
    C2a7Ou6eFxjUeu9PFyZ8qY+Gox19FZEsR8nuJALEC/dRyS5FeJDLwxyRxU01Cvdl
    jZuzGgoCPDkWpNRiYdyyrCjvWmCgEqyVmD7TxV21guE3gT0VK75Ygji5vaDdN+qU
    5yZHh1jieRQb0TBRRnbf2RXQAxMZcqavLvtCuoEWvhRcPgQWqLPlcBoYNb9Q==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered, 1024-bit rsa key sha256) header.d=nxp.com header.i=@nxp.com header.b=uIKUbYRJ x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=nxp.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=nxp.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (body has been altered, 1024-bit rsa key sha256) header.d=nxp.com header.i=@nxp.com header.b=uIKUbYRJ x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=nxp.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=nxp.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfIMGTbRHBI/VfmNvovos/2B9HdPz4yg6/LRdw5bwm1BlxbGaT/aGexQTM2Nbi2aLHeM5J7j3aCI/8wKvl3k2mlz1pFlU5JUJALkyllAU/ESQH7KXd/9t
    ko1bWJc4ctz9/hWXhduS1hzUEtFO44v0TlZx+HxKBVXYs0Uglr3eaRI3KDc4C5Td05XCvdCX/KcT4jwTS3+U3moHQ2yerrxSbd9uTgJhoraX72HEryxQlFNb
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=m-XU2MN_NUEA:10 a=-Vr38N3OkxwA:10
    a=EFEsHzkWX8YA:10 a=kj9zAlcOel0A:10 a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10
    a=dw2S5ISiLjYA:10 a=VwQbUJbxAAAA:8 a=jRF-l_Qkb7yinlLtE3UA:9 a=CjuIK1q_8ugA:10
    a=x8gzFH9gYPwA:10 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754358AbeDTJf7 (ORCPT <rfc822;greg@kroah.com>);
        Fri, 20 Apr 2018 05:35:59 -0400
Received: from mail-he1eur01on0068.outbound.protection.outlook.com ([104.47.0.68]:19822
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1754335AbeDTJf5 (ORCPT <rfc822;linux-usb@vger.kernel.org>);
        Fri, 20 Apr 2018 05:35:57 -0400
From: Peter Chen <peter.chen@nxp.com>
To: Jisheng Zhang <Jisheng.Zhang@synaptics.com>
CC: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Subject: RE: [PATCH resend] usb: chipidea: Don't select EXTCON
Thread-Topic: [PATCH resend] usb: chipidea: Don't select EXTCON
Thread-Index: AQHT17S23GjAgRoHOUOzcNsdlHwgEKQI32DwgAB9iQCAAAaj0A==
Date: Fri, 20 Apr 2018 09:35:54 +0000
Message-ID: <VI1PR04MB14558BCFB82A06C92F7AA0CA8BB40@VI1PR04MB1455.eurprd04.prod.outlook.com>
References: <20180419160144.0412a510@xhacker.debian>
        <HE1PR04MB1450E11255E0828180B3E8188BB40@HE1PR04MB1450.eurprd04.prod.outlook.com>
 <20180420170126.732e093b@xhacker.debian>
In-Reply-To: <20180420170126.732e093b@xhacker.debian>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: synaptics.com; dkim=none (message not signed)
 header.d=none;synaptics.com; dmarc=none action=none header.from=nxp.com;
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;VI1PR04MB2175;7:8Y1xpqVGYKDXa3ySD0z8XSSDB2WzVhnOoDob8gsfy76AHD12jO+blvmUrfkinR25nN5vN/1uiNg+bHzAD1/39ZotNpZ4mjWecSGVb9wZuuNeUMQ+wcfO7+poVc9iHO4KH25RxPXgTacFTefgsWtHsrV/wzc/DpwF0bdkSI6pq8J2gcwo6ryghdj2/xeMi3ZyeY2lhCxE9TcGCV1i42Bs20G5GreCm29OUefpRSCefG+8FhTflq3OP7VWcc9nFNtu
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(48565401081)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:VI1PR04MB2175;
x-ms-traffictypediagnostic: VI1PR04MB2175:
x-microsoft-antispam-prvs: <VI1PR04MB2175454A0C15B283A2D6FBC28BB40@VI1PR04MB2175.eurprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(3231232)(944501392)(52105095)(10201501046)(93006095)(93001095)(6055026)(6041310)(20161123560045)(20161123562045)(20161123558120)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:VI1PR04MB2175;BCL:0;PCL:0;RULEID:;SRVR:VI1PR04MB2175;
x-forefront-prvs: 0648FCFFA8
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39380400002)(346002)(39860400002)(376002)(396003)(366004)(25786009)(6436002)(5660300001)(7696005)(76176011)(4326008)(59450400001)(33656002)(5250100002)(6116002)(53936002)(305945005)(2900100001)(9686003)(478600001)(3846002)(6246003)(316002)(26005)(8936002)(2906002)(54906003)(3280700002)(74316002)(3660700001)(81166006)(7736002)(11346002)(229853002)(55016002)(446003)(8676002)(102836004)(44832011)(86362001)(6506007)(476003)(186003)(66066001)(6916009);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB2175;H:VI1PR04MB1455.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;MLV:sfv;
x-microsoft-antispam-message-info: UYRgzxmihUPVwPZQSj5gHXHdl+1YrxxkEybpOSnyYogmwCFtcGkqfmXaDuFs8Q971nAXPLTd6sD4Imt9yvFh4dbLaGD4EyPddThOeSgNdPWFxnDIBunYJ6ayRt00nWerZooa9EoHGkijTSOt0qqS406ZEBatpRxSGW15Lvp//7IElkBp7lSCKLBrL6Z+0++0
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Office365-Filtering-Correlation-Id: 1bc5fac3-8153-44c2-79e7-08d5a6a21cf4
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1bc5fac3-8153-44c2-79e7-08d5a6a21cf4
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Apr 2018 09:35:54.2708
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB2175
Sender: linux-usb-owner@vger.kernel.org
X-Mailing-List: linux-usb@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

=20
> >
> > Sorry to reply late, are you really care 2KB code side? Since many
> > users use EXTCON to handle vbus and id, it is hard just delete it. I
> > could accept patch for your specific platforms, like:
> >
> > +	select EXTCON if !ARCH_XXXX
>=20
> The patch doesn't remove extcon support from chipidea driver.
> I just want to not select EXTCON unconditionally, but let the users choos=
e. If the
> users need extcon, they could enable EXTCON themselves
>=20
> I just searched all the dts in arch/arm/boot/dts and arch/arm64/boot/dts =
only the four
> dts give extcon phandle to chipidea host, other users don't make use of i=
t:
>=20
> arch/arm64/boot/dts/qcom/apq8016-sbc.dtsi
>=20
> arch/arm/boot/dts/qcom-apq8074-dragonboard.dts
>=20
> arch/arm/boot/dts/qcom-msm8974-fairphone-fp2.dts
>=20
> arch/arm/boot/dts/qcom-msm8974-sony-xperia-castor.dts
>=20

I see, but I do not want to break msm platforms. You may try to create Glue=
 driver Kconfig
entry for chipidea like dwc3, and let msm depends on EXTCON.

Peter
