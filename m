Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-4024283-1524620873-2-440424350317228261
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
    1524620872; b=BPe4Py7deYA4q+8FZetLzcSU6mRHE7E5PerkUeBx+nc2wcrIvf
    +0nDyHK0M0SxQaKk2ryO04MjXZF9kTnAez4iCDJrHLcWlSCxM/PgxwojPXTAJ2Fg
    CPYCSOneUjUaDzMZPH/EBHvS7yJQRo6zv1MZ1n920KF2RYSWgEwPuCs9d3gyxXkL
    SwXGv3722WguLqiNTmtBMgnWR7NGDHJchFWr5oAVgx1It9o8SDLS0WhAfFzgsZjV
    u4uRQ/bJsvWnRqw9eLI5IclZM5H5Xd50wjPtxYfkhmzXDIZtmnh3F9LPsxk1QF0w
    Dq5by6RVpLU8aDIQpiZxTidf8W+m82CT5nZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=fm2; t=1524620872; bh=0zoy9pyhYk
    qhWny6kJ41yvsnsOf4mxQilKSN0GJPKcY=; b=Eh20kKp5GIv/sCN23dwoD5/YBu
    FAt0JL+ZshkFdYiC8q93E0CoM70CbEaw3GkpeKGHcesseqG3Svi0TRIGC2NTAnTQ
    USNXA0sXFRoax09Y1EX/zVx5C6/cBWWGpPalLlnNhxrcNrk9CBMiJfCwhfzo4Mln
    QxMLvunOLIPzcrLHunqchZwd1XvK3uKSGH2ha3vmPXETdNzfxa25eJewIq7SUddD
    89jxntQpKAS0WQoNBdFtiLP92qrSjzTDtyzAYokPbu7fu4KYBOCJI9wIOx5B2RVV
    CIuohJTvt5+L13Vh8ClOPTor0RFgwO7gBY0UvjDrXsn9gQkfzu+uJpzGhzWg==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered, 1024-bit rsa key sha256) header.d=nxp.com header.i=@nxp.com header.b=EAPVtT6s x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=nxp.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=nxp.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (body has been altered, 1024-bit rsa key sha256) header.d=nxp.com header.i=@nxp.com header.b=EAPVtT6s x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=nxp.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=nxp.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfDNIbmmO4zl+TBxfAb2lO/PU8SE2eELXXRMk+dcASzc0NmVsfvUZXM+CTkSEY/PqPsdPx+QxexUHCgEhzdv3/u6JY2kBAPT0zq1/BIQ5zTAKJahLbO4+
    74Z9N14PiKjM9Xi6pYakxeQJnO1B77ne16b5cIEBnAMPFKYhVBXyPZ9qtmIL+nM7ZYed/NoyTOWdcfe8tqVeKd/lh8rWJGOQp1OQ1aHujbn2EIbmSFaGxo2p
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=m-XU2MN_NUEA:10 a=-Vr38N3OkxwA:10
    a=EFEsHzkWX8YA:10 a=kj9zAlcOel0A:10 a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10
    a=dw2S5ISiLjYA:10 a=VwQbUJbxAAAA:8 a=4ZGZTCFmBJs_d2HA79MA:9 a=CjuIK1q_8ugA:10
    a=x8gzFH9gYPwA:10 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750929AbeDYBrs (ORCPT <rfc822;greg@kroah.com>);
        Tue, 24 Apr 2018 21:47:48 -0400
Received: from mail-db5eur01on0079.outbound.protection.outlook.com ([104.47.2.79]:33760
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750791AbeDYBrp (ORCPT <rfc822;linux-usb@vger.kernel.org>);
        Tue, 24 Apr 2018 21:47:45 -0400
From: Peter Chen <peter.chen@nxp.com>
To: Jisheng Zhang <Jisheng.Zhang@synaptics.com>,
        "yossim@codeaurora.org" <yossim@codeaurora.org>,
        Stephen Boyd <sboyd@codeaurora.org>
CC: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Subject: RE: [PATCH resend] usb: chipidea: Don't select EXTCON
Thread-Topic: [PATCH resend] usb: chipidea: Don't select EXTCON
Thread-Index: AQHT17S23GjAgRoHOUOzcNsdlHwgEKQI32DwgAB9iQCAAAaj0IAEl7MAgALC9JA=
Date: Wed, 25 Apr 2018 01:47:42 +0000
Message-ID: <HE1PR04MB14509924E386B58D5A95C4D38B8F0@HE1PR04MB1450.eurprd04.prod.outlook.com>
References: <20180419160144.0412a510@xhacker.debian>
        <HE1PR04MB1450E11255E0828180B3E8188BB40@HE1PR04MB1450.eurprd04.prod.outlook.com>
        <20180420170126.732e093b@xhacker.debian>
        <VI1PR04MB14558BCFB82A06C92F7AA0CA8BB40@VI1PR04MB1455.eurprd04.prod.outlook.com>
 <20180423153310.47a20e6d@xhacker.debian>
In-Reply-To: <20180423153310.47a20e6d@xhacker.debian>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=peter.chen@nxp.com;
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;HE1PR04MB3018;7:bCBN+J3gSuavc4MsritxhjAvwlfvzqb5TqKq4uFrSp5p72ERhk/d3+DzmoNQmW3itztrXevwCJrOCb9wSqxAM2SPL1cEF2L7iwEtlLbxG9ZtwwUoU7W9zwhKWuo8MeIjbzDRNvq5KFtgSmTa5Tp7YCgIge7tOMGn33An+pewZXARAmXNocukhWDkjuLHZaVBNmM3MnBPjKDb3t6iRaCSl74Afnmo5nNSSVrYwmAxRxSTMxCcmCRtQ+6oxnLDCahV
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4534165)(4627221)(201703031133081)(201702281549075)(48565401081)(2017052603328)(7153060)(7193020);SRVR:HE1PR04MB3018;
x-ms-traffictypediagnostic: HE1PR04MB3018:
x-microsoft-antispam-prvs: <HE1PR04MB30183FD88A0B307CFAD4428F8B8F0@HE1PR04MB3018.eurprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3002001)(10201501046)(3231232)(944501410)(52105095)(6055026)(6041310)(20161123564045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123560045)(6072148)(201708071742011);SRVR:HE1PR04MB3018;BCL:0;PCL:0;RULEID:;SRVR:HE1PR04MB3018;
x-forefront-prvs: 06530126A4
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(346002)(396003)(376002)(39380400002)(366004)(189003)(199004)(3280700002)(2900100001)(97736004)(446003)(11346002)(476003)(229853002)(186003)(26005)(105586002)(25786009)(59450400001)(102836004)(6436002)(3660700001)(5660300001)(486006)(6116002)(76176011)(7696005)(106356001)(6506007)(3846002)(2906002)(54906003)(74316002)(6246003)(478600001)(44832011)(99286004)(316002)(14454004)(110136005)(53936002)(93886005)(9686003)(55016002)(68736007)(81166006)(5250100002)(4326008)(8676002)(33656002)(86362001)(305945005)(2501003)(66066001)(8936002)(7736002)(81156014);DIR:OUT;SFP:1101;SCL:1;SRVR:HE1PR04MB3018;H:HE1PR04MB1450.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: ROfquJw+ZzXqhhWz6Zd2urxkZ0gmnkRy1YiGqWw3S0KSFv6fQu23nXYxC5INVfhyCbTO3DONYuZdVdMCvNmz/kvC36GvB2MRmwjdHhZ+n9PN9a/IB63/qR5GlTRkquPb4iYggBsuqAI8YuX/lUXpNRni2XD4U7fBZP+lS7LN1pl+Vrpwb4CKNEnSMBcmpgwm
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Office365-Filtering-Correlation-Id: 6157e891-ed81-45eb-a6f3-08d5aa4e88df
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6157e891-ed81-45eb-a6f3-08d5aa4e88df
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Apr 2018 01:47:42.1603
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR04MB3018
Sender: linux-usb-owner@vger.kernel.org
X-Mailing-List: linux-usb@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

=20
> > >
> > > The patch doesn't remove extcon support from chipidea driver.
> > > I just want to not select EXTCON unconditionally, but let the users
> > > choose. If the users need extcon, they could enable EXTCON
> > > themselves
> > >
> > > I just searched all the dts in arch/arm/boot/dts and
> > > arch/arm64/boot/dts only the four dts give extcon phandle to chipidea=
 host, other
> users don't make use of it:
> > >
> > > arch/arm64/boot/dts/qcom/apq8016-sbc.dtsi
> > >
> > > arch/arm/boot/dts/qcom-apq8074-dragonboard.dts
> > >
> > > arch/arm/boot/dts/qcom-msm8974-fairphone-fp2.dts
> > >
> > > arch/arm/boot/dts/qcom-msm8974-sony-xperia-castor.dts
> > >
> >
> > I see, but I do not want to break msm platforms. You may try to create
> > Glue driver Kconfig entry for chipidea like dwc3, and let msm depends o=
n EXTCON.
>=20
> Got your points. Since multi_v7_defconfig has selected EXTCON, and
> EXTCON_USB_GPIO(which depends on EXTCON) is enabled in arm64 defconfig,
> so what about:
>=20
> enable EXTCON explicitly in arm64 defconfig?
> then add this patch?
>=20

I am not sure if Qualcomm platforms use these, add Qualcomm guys to confirm=
 it.

Peter
