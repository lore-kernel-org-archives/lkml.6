Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-276252-1524188340-2-3847953959463481418
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
    1524188340; b=RZs+2IAmgOz9Sz/F9/ATlABo7vPxL5h7gwzmEa5VaOpXn0KL+B
    ntlSMuAO7fe15l0U2px92Z24orf6oGCqAyNH/pYWKxSDV/g+dulBzLXwrpFwaLOj
    qqwUlaEBo5WYc5oiXQVtvsZT46cGcGrqOwbw6kAm4+2SN3GfXR+qyD8/nw1xclSa
    mi2kEne8DTA5e+M+0OHLVMMH5EO3OcVOSAJEyL81yqBu5Wrd5wVii4+0ow0TVRLr
    o8ixVDQePDIzp5UmWjXyHVC6J9HmqzrJXE/2yE2oPWVPQkfiHQBevL9M+/xpM9yh
    9Dm1n4th8/n5AZ2Y029sN1/X9q+Ms1rWqZ2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=fm2; t=1524188340; bh=Vivp708RPl
    /T/MCzLF8jPzjsX1TQvl52QdcRWRQOb6A=; b=T+/Gfe92xNCS+HCIvAnpFHVtTK
    XZjI57Ks98uGtMppVtN1uYQpH2ruRVM6PcTW50op46HbriXEndzHCOy7Ghlzcc/M
    vTkpN030dk7b+dYy83T3MFd6aQgqg6i+xJI8WYaPA/KFvsp5kMNjZmTrhelOcyzN
    MJBKk8mFqIEQo8MCFEjkYCnsRYzFsNeDZ1N4mzOpDiHJQbwqC+Cy71eLs1zmTqdh
    zv/Vp4tnU0wxvkKpvi74RQbkZZMq2vV8Cxr20sFZmFHMQClBZE86mh9yQ9hXi+AB
    g7ez4HcxWp0aT6/S+v2r4bWSU3R+2o/8ZeF4XZOKyiX0ZnG8e1rH4uAnRWqA==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered, 1024-bit rsa key sha256) header.d=nxp.com header.i=@nxp.com header.b=F/07qyB+ x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=nxp.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=nxp.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (body has been altered, 1024-bit rsa key sha256) header.d=nxp.com header.i=@nxp.com header.b=F/07qyB+ x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=nxp.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=nxp.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfIyLzrjIAEgLFKY3DE3r8BSTLXMAMr388J5zDT8OvuYC6+ZiqoKufZbdq7R3Zez6+wTwfoPeRqyNMEuY60RJ89EDp4y/T0jLcZdGdJFfRB81ciqspYgD
    R8CYXD1ztYHGZxXANQUFnOYRLJiZBnAfZ6GsF5iADegn8oBhKf/K8yXeGkq230mhDz0RVYjGdHamWGFrNgxNSTfimEvFJ8ACK+159M+RtgPljrDTHcl+Ukhp
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=m-XU2MN_NUEA:10 a=-Vr38N3OkxwA:10
    a=EFEsHzkWX8YA:10 a=kj9zAlcOel0A:10 a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10
    a=dw2S5ISiLjYA:10 a=VwQbUJbxAAAA:8 a=8FnPhAn4IRZ-CitGH_wA:9 a=CjuIK1q_8ugA:10
    a=x8gzFH9gYPwA:10 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753937AbeDTBiq (ORCPT <rfc822;greg@kroah.com>);
        Thu, 19 Apr 2018 21:38:46 -0400
Received: from mail-eopbgr40054.outbound.protection.outlook.com ([40.107.4.54]:56855
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753761AbeDTBip (ORCPT <rfc822;linux-usb@vger.kernel.org>);
        Thu, 19 Apr 2018 21:38:45 -0400
From: Peter Chen <peter.chen@nxp.com>
To: Jisheng Zhang <Jisheng.Zhang@synaptics.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC: "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Subject: RE: [PATCH resend] usb: chipidea: Don't select EXTCON
Thread-Topic: [PATCH resend] usb: chipidea: Don't select EXTCON
Thread-Index: AQHT17S23GjAgRoHOUOzcNsdlHwgEKQI32Dw
Date: Fri, 20 Apr 2018 01:38:42 +0000
Message-ID: <HE1PR04MB1450E11255E0828180B3E8188BB40@HE1PR04MB1450.eurprd04.prod.outlook.com>
References: <20180419160144.0412a510@xhacker.debian>
In-Reply-To: <20180419160144.0412a510@xhacker.debian>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: synaptics.com; dkim=none (message not signed)
 header.d=none;synaptics.com; dmarc=none action=none header.from=nxp.com;
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;HE1PR04MB3019;7:2UimYHxnsPQkZff/JUZYHziHO1X7Sa2PgsojvC4kNN23rGQTSB/c/OtiIBSYyTB4J8+FOAZ78xHd0KucLCfuHBW+zqfO4w7eDozYGcH+N/LZEE38MX9ppUdgTk+QXPzkqOK3suR0yzZ8blKuAA7FYfjOwhKH5kmd6V7/CPXQOgsZ5CJ62DF+zUqKTZ4yeJYQXlDRBMyzOyk+tND1PBJTZfeeiFGqZ7V6Md8qTfI+nzDbGp5Fa3QoOdksFj0Mrf0Y
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(48565401081)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:HE1PR04MB3019;
x-ms-traffictypediagnostic: HE1PR04MB3019:
x-microsoft-antispam-prvs: <HE1PR04MB301926EEFE63479CA52AB5EC8BB40@HE1PR04MB3019.eurprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231232)(944501388)(52105095)(3002001)(93006095)(93001095)(10201501046)(6055026)(6041310)(20161123558120)(20161123562045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(6072148)(201708071742011);SRVR:HE1PR04MB3019;BCL:0;PCL:0;RULEID:;SRVR:HE1PR04MB3019;
x-forefront-prvs: 0648FCFFA8
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(39380400002)(39860400002)(376002)(396003)(346002)(186003)(81166006)(6246003)(11346002)(2906002)(44832011)(4326008)(575784001)(7736002)(86362001)(5250100002)(229853002)(25786009)(3280700002)(5660300001)(6436002)(26005)(6116002)(476003)(3846002)(33656002)(305945005)(478600001)(53936002)(6506007)(110136005)(76176011)(7696005)(8936002)(102836004)(316002)(66066001)(59450400001)(54906003)(9686003)(8676002)(55016002)(2900100001)(3660700001)(446003)(74316002);DIR:OUT;SFP:1101;SCL:1;SRVR:HE1PR04MB3019;H:HE1PR04MB1450.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;MLV:sfv;
x-microsoft-antispam-message-info: XnusGmGBOIiD/UKReyNzuHi9OWBiybJ6ukUTZs8SnfzlpDj2gEv8MHLsx5IA9R46rDPf7whASLARXyfsPNYNufcF+Z9N8E7CPZ+75i+LmLSsmHQ6SONgDDRFwrhoEkejRjORePDRVTYPLz/8DhJuQaC+xftTCIIECPjlOI3lOUgZJlsFKG6Sie2Chm21Catx
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Office365-Filtering-Correlation-Id: d3347fa1-2bde-4864-1725-08d5a65f72ed
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d3347fa1-2bde-4864-1725-08d5a65f72ed
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Apr 2018 01:38:42.2100
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR04MB3019
Sender: linux-usb-owner@vger.kernel.org
X-Mailing-List: linux-usb@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

=20
>  drivers/usb/chipidea/Kconfig | 1 -
>  1 file changed, 1 deletion(-)
>=20
> diff --git a/drivers/usb/chipidea/Kconfig b/drivers/usb/chipidea/Kconfig =
index
> 785f0ed037f7..97509172d536 100644
> --- a/drivers/usb/chipidea/Kconfig
> +++ b/drivers/usb/chipidea/Kconfig
> @@ -1,7 +1,6 @@
>  config USB_CHIPIDEA
>  	tristate "ChipIdea Highspeed Dual Role Controller"
>  	depends on ((USB_EHCI_HCD && USB_GADGET) || (USB_EHCI_HCD
> && !USB_GADGET) || (!USB_EHCI_HCD && USB_GADGET)) && HAS_DMA
> -	select EXTCON
>  	select RESET_CONTROLLER
>  	help
>  	  Say Y here if your system has a dual role high speed USB
> --
> 2.17.0

Hi Jisheng,

Sorry to reply late, are you really care 2KB code side? Since many users us=
e
EXTCON to handle vbus and id, it is hard just delete it. I could accept pat=
ch
for your specific platforms, like:

+	select EXTCON if !ARCH_XXXX

But please note, even your board uses SoC id/vbus pin to detect related ext=
ernal
signal, the other boards use the same SoC may use external gpios to do it.

Peter
