Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-912290-1520485112-2-6423904517565594374
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES endaro, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520485111; b=e7JN/9QIdDCaq0QZ+TZh/rcD3HSiWNI6BkVHgb3HFAEz1wA
    OUCbiBGNMTUJe9F+6MAKSiggDeBH4OO5T3FFAsbcG7eEJ24WMZkayLCn5HumZAjg
    t3MBTra8J8Mkon5JyAQy9GYRk77XoLRcaBvk4pDO5aNLReH1CY8/DgqsUjGZluXb
    XJr63Ds1IsDynrhxEmoDhBmit7tCf47tsVb9XHZ5fhiOpDNsNUNpLZUaMiOkoZz4
    xq+a3m0APx22pItOKMnKkRfZUydEkSn2T697V0D/KRe5YgJNN7NbViarOxJjHTbC
    meM3RKobvpT+SBTi1J2RC2SqetjLe3uLut+HQOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1520485111; bh=MUiaeb
    ATege8eipSPXsvVVIMVh7kY0YMnGpu8n9ZymA=; b=qBX850G+aO0aIG83Moa1VW
    FMCB6VVK/iNLulKWYpKiQtXTfrsDo79IMyG8b9oPJTKI7NFfsimgkEUKO9BONqWK
    nU8eyAXBIJk9l90N9uKCim2phQi1ipzkC22rRgkcfG3b9h2Etd+D1ajfRSltaMP3
    Yd7Ov0kQlCdQcDVrmyTQ1r01Ur7VtKHG7/10Cd7qezZFlPf0D2vpI0AiH4936sdf
    OfFbjPhy1pDEZZoERsQqtKGfeCm835rQvTh2TXbr1ZtnaxgMaWFGe7bjkEQCGJHn
    lyN/MBW7lZs4aD8rHHumcj4LmB389MjphwRFqZ+WBKXkChSPxipDkPouvYO3ZwEQ
    ==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=CVSCC3ow x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=CVSCC3ow x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935278AbeCHE62 (ORCPT <rfc822;greg@kroah.com>);
        Wed, 7 Mar 2018 23:58:28 -0500
Received: from mail-by2nam03on0101.outbound.protection.outlook.com ([104.47.42.101]:17968
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S935243AbeCHE6V (ORCPT <rfc822;stable@vger.kernel.org>);
        Wed, 7 Mar 2018 23:58:21 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Stefan Potyra <Stefan.Potyra@elektrobit.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.14 21/67] serial: 8250_dw: Disable clock on
 error
Thread-Topic: [PATCH AUTOSEL for 4.14 21/67] serial: 8250_dw: Disable clock on
 error
Thread-Index: AQHTtpn8C7vB6TVAmEmOABGyfCHCpg==
Date: Thu, 8 Mar 2018 04:57:40 +0000
Message-ID: <20180308045641.7814-21-alexander.levin@microsoft.com>
References: <20180308045641.7814-1-alexander.levin@microsoft.com>
In-Reply-To: <20180308045641.7814-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0808;7:VrPY3nAHGB4EOgzLQ/GZRApvEN0QvL0IHGEMAwASNkqSp82eHdrvP9zHwGR2/3p7miqbWedxrdMU6wAfXTEV3+2wn8ngcGTT69rBNeEz3spc++MdMo43dMZ+dF5QpROAQresjNDY95z9B5N/zi5OLbXfwP+8gcw9A32nnnPtkNk5SmdNdyiIyCOGGqNpZlHN4fGe+xJp+4WiYb2ednYY8Q99CID7JZBWL5GCDNV777eqDVOxbabXF7l5ToCXrT1U;20:cpNCalIP07mjyWW585R3/oF9eSY5SLgBaTnYBmktMVkMDR/dl9oo8Ecqsrz1fbSDZZYxLlWrIOrOO2hKqLLYVKX3vAovD/gdOW4SbR007iacbDuBWCsQUlGP80pGEfUowlvxPK3ytWrr0hZX9PkhzC0xuGxB2AaNzyqxICcZhe8=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 1946e41f-a0a3-4fe4-39e2-08d584b132d3
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0808;
x-ms-traffictypediagnostic: DM5PR2101MB0808:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB0808E6FEF29E10BA5A18B598FBDF0@DM5PR2101MB0808.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231220)(944501244)(52105095)(10201501046)(3002001)(6055026)(61426038)(61427038)(6041288)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123560045)(20161123562045)(20161123558120)(6072148)(201708071742011);SRVR:DM5PR2101MB0808;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0808;
x-forefront-prvs: 060503E79B
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39380400002)(396003)(39860400002)(366004)(376002)(346002)(199004)(189003)(22452003)(99286004)(76176011)(2906002)(105586002)(3846002)(86612001)(478600001)(72206003)(14454004)(2900100001)(8676002)(102836004)(68736007)(5660300001)(316002)(6116002)(54906003)(26005)(6506007)(59450400001)(1076002)(86362001)(36756003)(186003)(10090500001)(110136005)(106356001)(4326008)(6512007)(6486002)(7736002)(5250100002)(3280700002)(3660700001)(2501003)(6666003)(81166006)(2950100002)(305945005)(53936002)(107886003)(8936002)(6436002)(81156014)(66066001)(25786009)(10290500003)(97736004)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0808;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
x-microsoft-antispam-message-info: OYWeZr4PPFongr1VmGbqdAExn0Jb85X/hwOoOQFcvJZG+YTIAeOQJ0n4SnpAta/Yw4ATMvEPq58LOjvrlumFr+Q3A9e4Dq/m7dMgFIL+OHPQonrcEvjN3xv7GGHH7sNC1F4UzmlL0bjPNuAWsT66TDXmFHXwXcpNPobdXt8aP/s2I/e3mRRka2Ae/Zr2D77ZbEjQmKhNsTo1/hWpei1wQiiIQ5XjcrT3E69aD2Gvuip+HRpt6qtbcuOm63iFaAiqWeHeceAuXdYHguNNviJke+Ol+XrrA9qmQC0i9CxfPJp6ZdOdR11uczx7G6bA6aKs79I+j8kgR//pXN6Oo7RxSw==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1946e41f-a0a3-4fe4-39e2-08d584b132d3
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Mar 2018 04:57:40.6542
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0808
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Stefan Potyra <Stefan.Potyra@elektrobit.com>

[ Upstream commit 8af016aa5a27c6a2505460eb4d83f1e70c38dc43 ]

If there is no clock rate for uartclk defined, disable the previously
enabled clock again.

Found by Linux Driver Verification project (linuxtesting.org).

Fixes: 23f5b3fdd04e serial: 8250_dw: only get the clock rate in one place
Signed-off-by: Stefan Potyra <Stefan.Potyra@elektrobit.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/tty/serial/8250/8250_dw.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/tty/serial/8250/8250_dw.c b/drivers/tty/serial/8250/82=
50_dw.c
index 7e638997bfc2..3015789265dd 100644
--- a/drivers/tty/serial/8250/8250_dw.c
+++ b/drivers/tty/serial/8250/8250_dw.c
@@ -513,7 +513,8 @@ static int dw8250_probe(struct platform_device *pdev)
 	/* If no clock rate is defined, fail. */
 	if (!p->uartclk) {
 		dev_err(dev, "clock rate not defined\n");
-		return -EINVAL;
+		err =3D -EINVAL;
+		goto err_clk;
 	}
=20
 	data->pclk =3D devm_clk_get(dev, "apb_pclk");
--=20
2.14.1
