Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3689844-1523236428-2-13663389561203776237
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523236427; b=DiBpkENbR2bgajnS0bRoCf/IEXeE2J84Lc4ximR3Nlu54UoghN
    2BSwiIura54GbGniZWIo1zvTT2IH33wI/sphd3xgLv1Je7SVy9bgGfYSWVabOzvv
    hrJ2XBsqhL3JQR1URnm36GFd0sUEPR9x4pjMjr/jeVy6f1iTuItbVzSEx9hcFzm/
    nhQEYvxSVc2jxbIqmCXDA8hYZCQlecouHOWp8i5Dy8msWAXNTMa3jIZc7bKDxsMN
    E2sNgWQOrNi7MXolKMMHUdFSYkWp1sQ4CNnEuJBdkjKI44frwSdtx+qV8HQglgfv
    Aw1OMFzBmpgH+QF5yH9xm2hwquod0HtvJVOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=fm2; t=1523236427; bh=FFIP7HPrtv
    Ir10thkKgbCTJuAevq0xb9esmBYQsfYKM=; b=hF6dqAyMBJP9LqvbOkODjCwR38
    lvxtbqNZVl6eye2NvIdHLADDTaWPBQddpk0IV4JeRYrOkBlNVyk1BvaTobc4omRL
    G2mo8YKHVEt77aAFgzemFqzkP5zR3nScd6oN2tMc+9dvnaL6V0iiK2Fx29BA2cqn
    l+1S0gLfCAO81G4E5aT1uJLp1E6egnTRV8ckyksDCsHOKakZC1TB5xFNP3lHoVts
    g8MhwzhBZ+tCdlH2TC4u2grDbO3BUzxt4H67hz23b0vqvPfrN+F14MVrCn+IQcIS
    B0GRnmaCJEADD4U9A8kYss/gyXrf1L2Uh6o+uz3zxbweTVfDhEj+5Q8ch2VA==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=YBMbzTLV x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=YBMbzTLV x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfNPqobJoVjxnnHgccT0gryf6aZSKKwpa4J16X93Rqrs+/z2tmWzJzM7c+Ya1Tc+PolXFw5DKEwtg7ykiKItJ9lxlUIsZvpTrd0qEWjfdd+GqVDrHgXdO
    Boq4ynJtt33FtbLhQitnxl8b6YSqaVaZ+6R9660fWgGi88lv/OkU69kjuVj6y5x1kFV0KaJCfHoLHxSx4Ds30zlh4iv9kWUFSOJ3pix4x8x82DJGZzct9fBq
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=wRwT6uffUbIA:10 a=t_PdEiP4ckcA:10
    a=mw6kJ3eo-EIA:10 a=8nJEP1OIZ-IA:10 a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10
    a=Lf-vpJhqX20A:10 a=i0EeH86SAAAA:8 a=EGYj-OwPAAAA:8 a=fk1lIlRQAAAA:8
    a=yMhMjlubAAAA:8 a=q7ZBISJrZ0O5DTBrg2AA:9 a=wPNLvfGTeEIA:10
    a=xQyHFheebwQZ3wMG2Lhb:22 a=U75ogvRika4pmaD_UPO0:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932917AbeDIBNk (ORCPT <rfc822;greg@kroah.com>);
        Sun, 8 Apr 2018 21:13:40 -0400
Received: from mail-co1nam03on0137.outbound.protection.outlook.com ([104.47.40.137]:26752
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1755519AbeDIAig (ORCPT <rfc822;stable@vger.kernel.org>);
        Sun, 8 Apr 2018 20:38:36 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: Wei Yongjun <weiyongjun1@huawei.com>,
        Corey Minyard <cminyard@mvista.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.4 124/162] ipmi/powernv: Fix error return code
 in ipmi_powernv_probe()
Thread-Topic: [PATCH AUTOSEL for 4.4 124/162] ipmi/powernv: Fix error return
 code in ipmi_powernv_probe()
Thread-Index: AQHTz5nN5rPT6N/A+UKh9Ngbr+6kmg==
Date: Mon, 9 Apr 2018 00:29:21 +0000
Message-ID: <20180409002738.163941-124-alexander.levin@microsoft.com>
References: <20180409002738.163941-1-alexander.levin@microsoft.com>
In-Reply-To: <20180409002738.163941-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1095;7:jsMnGrsBbWHmu56iSufgDaSL+JOz9NjxlANlqePh5RkiBoZaQUpqBMu/7Tmbuya7wEinmOf50JaFeEiE5rzcPABb6rvZFwexV/ttyFgllI6AhD89NAhOLoGnIJi++AaI+xsxL9Izfk6qbuv+9dde3NY6dDdHOeCVSzA/OH5ulZoIW21dBOBeY1Flro4IrXWxruR7t92UhL+4ynnv73IuBrBgebjvAG6pvCfMibvKYfJh7VqmmYX6vaIAbmzbMHhc;20:k1nZJBzkp5W6chB5yeCyVLDxNCIJizOwYPqlRWQala2vSOBRWsm3/LWTr1ZvS/slnYah2JtPXm8DaxZvr4CiuHMU/b1Qhnus1mo3o6+SvMU6QVVE8XR4oDaKdvXZC60sKjLfZY4MlfvSS6RVcOCoqqO5qEBjsFTkfRGRL42RaqU=
x-ms-office365-filtering-ht: Tenant
X-MS-Office365-Filtering-Correlation-Id: c25b0bfd-ef50-4fb4-9990-08d59db238dd
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB1095;
x-ms-traffictypediagnostic: DM5PR2101MB1095:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB109543EC9BC2F821A756F2FEFBBF0@DM5PR2101MB1095.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(50582790962513);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(8121501046)(5005006)(3231221)(944501327)(52105095)(10201501046)(3002001)(93006095)(93001095)(6055026)(61426038)(61427038)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123560045)(20161123562045)(20161123564045)(6072148)(201708071742011);SRVR:DM5PR2101MB1095;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1095;
x-forefront-prvs: 0637FCE711
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39380400002)(346002)(366004)(396003)(39860400002)(376002)(189003)(199004)(26005)(10090500001)(476003)(105586002)(86362001)(107886003)(11346002)(446003)(2616005)(102836004)(76176011)(6512007)(97736004)(575784001)(36756003)(6666003)(6506007)(8676002)(59450400001)(99286004)(4326008)(10290500003)(81156014)(86612001)(81166006)(186003)(486006)(2900100001)(106356001)(1076002)(72206003)(478600001)(305945005)(8936002)(25786009)(3660700001)(7736002)(68736007)(66066001)(110136005)(316002)(54906003)(3280700002)(2906002)(4477795004)(3846002)(6116002)(6436002)(53936002)(6486002)(22452003)(2501003)(5250100002)(14454004)(5660300001)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1095;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: pU5IyHtbdZYsMtU3UC1/G6BQRNXnd1/pCVUz1O3DbBLKQvpeFrWlY8ZQAsh+mJQai7Wt2AmAO9QdfkS2JXyC2CKceEm8Le8PVaX56mPJWZOqP4X8CKxh97WckVc4n7COy9NYm85EO2BYU31ll71NMOmaKoMXVQCEr1ZAG7yLiAvcpDlSGYOUk1Wy4R5lnZ2fC6GecmLn19D533Ub/M23eO/QmmbMBECI68PmqmOuCGXkRO8icnu0ttha3MjuvO8/tI7xbItmVuYs1iVf7KwTUqyXfAgSTjtHd01Oyc7m60nWocUIintmEarnPVrzSphW7+HSNCBgKFpfsZB0AChu7eQ7iTQxwgOpJmbIYFFGUnCHb2szTL9NOhq0AE8X+6mZAMDUKeaA5paMlGq1AJVYTNKWpLYCA5N6pOWTecsv9Bs=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c25b0bfd-ef50-4fb4-9990-08d59db238dd
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2018 00:29:21.2243
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1095
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Wei Yongjun <weiyongjun1@huawei.com>

[ Upstream commit e749d328b0b450aa78d562fa26a0cd8872325dd9 ]

Fix to return a negative error code from the request_irq() error
handling case instead of 0, as done elsewhere in this function.

Fixes: dce143c3381c ("ipmi/powernv: Convert to irq event interface")
Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
Reviewed-by: Alexey Kardashevskiy <aik@ozlabs.ru>
Signed-off-by: Corey Minyard <cminyard@mvista.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/char/ipmi/ipmi_powernv.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/char/ipmi/ipmi_powernv.c b/drivers/char/ipmi/ipmi_powe=
rnv.c
index 6e658aa114f1..a70518a4fcec 100644
--- a/drivers/char/ipmi/ipmi_powernv.c
+++ b/drivers/char/ipmi/ipmi_powernv.c
@@ -251,8 +251,9 @@ static int ipmi_powernv_probe(struct platform_device *p=
dev)
 		ipmi->irq =3D opal_event_request(prop);
 	}
=20
-	if (request_irq(ipmi->irq, ipmi_opal_event, IRQ_TYPE_LEVEL_HIGH,
-				"opal-ipmi", ipmi)) {
+	rc =3D request_irq(ipmi->irq, ipmi_opal_event, IRQ_TYPE_LEVEL_HIGH,
+			 "opal-ipmi", ipmi);
+	if (rc) {
 		dev_warn(dev, "Unable to request irq\n");
 		goto err_dispose;
 	}
--=20
2.15.1
