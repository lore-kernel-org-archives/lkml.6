Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3836577-1523239360-2-5538232668315769947
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
    1523239359; b=U9Ngr4RAA2nRwHwIP2XgA7z50LwK1r1bddFpGlgSGda8QPlJvM
    hisC1gCOCi3w/lzbDFrsdDV/yoJXck+/G8LT7bJTxYKHJkGmYWxy12Re+z/h3+Ax
    12V8SuoLcxsNoo7FMXOfN6/pT/1sd302xh29JBXr+Zx3X+NYcGEWQkGXRka+s6hb
    PNAfOoN1efe4rkz1NuTigIPk/xun8xrx9CFSfuXQFGtKn1zWWApxYve2YvDr3d8v
    Gn9O8fWMoDC3UPMtPewohHB0LPCOjwe8VQfXlwEMPhgRVumZqLOFNZHeCgg6Su1h
    HKcUM7I5ZbMetckE4FUcdafCxXDdAHJNyRCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=fm2; t=1523239359; bh=UgeoqM5f2J
    yFNc1iuX81e7uxdOQML802PdKpbyehIAg=; b=GIoP0hNa0IVrFbUpMUU9nvw+Y8
    G8TAjTSoD8begvNewvHS0HScki86fb50XlrNIzCxbNRw8ICE3QUBhZlYebo0J7AK
    iFjuL9RQOuWMeF6e1p2UrKJnFA4TiLwE3RTjH5JpXOefFP4/BKrnS/ELwagMgQl0
    Wrokx5MITjv9BIlz01FM/QIFrnbvwcoKuwreh3gnMDZI6L3QCC5WFcUTVl8w75jU
    uu9A4/x05w2AmC3Jrpetz6zQr3TZy2RwWcyi2Tyru0HOxogHQEJ3XDnuTNcvVfvw
    2zcyRJnXWXFkFzM74pRPvHLP6nfFQN361STk11Is8BxMPHsqRpM+/hBQ0Vaw==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=FHLdw1Wp x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=FHLdw1Wp x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfLNyejoB7Q83NTpC+aHbelfJEzOtskSKtMDVpta+TXBwHreU6egGfKWavaje4EQcAYQjVn8NWAzEcI4RFiLm82zNsLqdiFD3SWb6DozChlgN1jE3jrA/
    Fnjc/mdGX6sX2ibtY65zuJwH4cuTmKNFVDDbwdc8fHnw8qNCJJBxmlScLj6H/vGUAu5s/+h6edIVkCIQcxCupT5ukjzNyD5daBzbF5kg9dAmZI+yJGzujV6R
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=wRwT6uffUbIA:10 a=t_PdEiP4ckcA:10
    a=mw6kJ3eo-EIA:10 a=8nJEP1OIZ-IA:10 a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10
    a=Lf-vpJhqX20A:10 a=J1Y8HTJGAAAA:8 a=yMhMjlubAAAA:8 a=bvT3chAHB8QEiKBnj3cA:9
    a=wPNLvfGTeEIA:10 a=y1Q9-5lHfBjTkpIzbSAN:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932223AbeDICCc (ORCPT <rfc822;greg@kroah.com>);
        Sun, 8 Apr 2018 22:02:32 -0400
Received: from mail-sn1nam01on0103.outbound.protection.outlook.com ([104.47.32.103]:45281
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1756420AbeDIAcJ (ORCPT <rfc822;stable@vger.kernel.org>);
        Sun, 8 Apr 2018 20:32:09 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: Tore Anderson <tore@fud.no>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.9 197/293] net: cdc_mbim: apply "NDP to end"
 quirk to HP lt4132
Thread-Topic: [PATCH AUTOSEL for 4.9 197/293] net: cdc_mbim: apply "NDP to
 end" quirk to HP lt4132
Thread-Index: AQHTz5lCd1KBRd1pk06MZa8yjDAiog==
Date: Mon, 9 Apr 2018 00:25:28 +0000
Message-ID: <20180409002239.163177-197-alexander.levin@microsoft.com>
References: <20180409002239.163177-1-alexander.levin@microsoft.com>
In-Reply-To: <20180409002239.163177-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0870;7:SLtAfyk8yNInDsJRJWlk3nMi3NFPWrLvD+TMBGq8oypjkj6SrmWgYYVcEfXzdVlNNELwMZty3wDiLbQ597fwo6AwI0CkqUZ5e/CaiH28UGOjj+l58/Jt8qGHQO7/lIbkhxbWaf+eE5fmaOHofr6TYOs6PQx51By1Fqnqa2CYEKV2ovQYTvyYCuaGDYcurojZhSbBaXd9Zw4V0PC7uQvme9mStfQo4/p5qu6Cz0KzLfCxTv7bwOBSj+pvvMRK/pVp;20:8k3K6/JBZR3KwTsuclZ9RUbkFXIJzwuU6BVldxAxdwoMda9I6QeiiilhZf0jm8SdEz2jtcR4EqYZhQ4Jrif8HUr/FB4Rd49IknRoTLIqQcKvmXEzP+m1WzZTNLU2pkp/yg5q8nmo3+MeT5ws4hETLGh2XOpepXk2dvFGhf65NME=
x-ms-office365-filtering-ht: Tenant
X-MS-Office365-Filtering-Correlation-Id: cbbde28b-045c-4a0e-7557-08d59db1523c
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0870;
x-ms-traffictypediagnostic: DM5PR2101MB0870:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB08709962FCC40FAC73308BF5FBBF0@DM5PR2101MB0870.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(8121501046)(5005006)(3002001)(10201501046)(3231221)(944501327)(52105095)(93006095)(93001095)(6055026)(61426038)(61427038)(6041310)(20161123558120)(20161123560045)(20161123564045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:DM5PR2101MB0870;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0870;
x-forefront-prvs: 0637FCE711
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(39860400002)(366004)(396003)(39380400002)(376002)(199004)(189003)(53936002)(2906002)(6512007)(102836004)(2616005)(76176011)(14454004)(446003)(10090500001)(11346002)(476003)(486006)(107886003)(2900100001)(97736004)(66066001)(6506007)(6436002)(106356001)(99286004)(105586002)(3660700001)(6116002)(86612001)(3280700002)(6666003)(2501003)(10290500003)(26005)(8676002)(8936002)(478600001)(68736007)(5250100002)(5660300001)(316002)(4326008)(72206003)(186003)(110136005)(6486002)(7736002)(25786009)(3846002)(86362001)(36756003)(22452003)(81156014)(81166006)(305945005)(54906003)(1076002)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0870;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: zegauIaSn7BeiPZVPCOlvmEi9hRn0/r+gy6ozsevOljgdACaRhMO710/5nZyGqh17b2eASI08qmMYU9kqQLMVIGFtF3VQTIEVWjbrx1gfrCCFhhcEVJmBHrp4s6fqcBOWPHZEzOyWcq9bqF9MQ11s2UQpBUPsiDIGuvhfcijW+Habx711Op3QCupsJ0H30qkCblzBl1xs7pkjG3yYKUvWVvIItx2BHyr39+5dcCeT5JFu7hyAnVIThv4bpr/y/AU2NLMR906lDcWnBnRdu38Ic9OCxhDkdO//iNMIQj6CmnWN11KH7SUia7ikgjOHyxJlYB47bimzNElOMc5s2kyHi45xRL4KnlZEBBXfm2n8cNYmH7ePIU5uI9zqiUcNl6Cmu6/xJjHDg9jFb0upNLOBeish41/WbPNtF2j7OEiC/g=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cbbde28b-045c-4a0e-7557-08d59db1523c
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2018 00:25:28.1127
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0870
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Tore Anderson <tore@fud.no>

[ Upstream commit a68491f895a937778bb25b0795830797239de31f ]

The HP lt4132 LTE/HSPA+ 4G Module (03f0:a31d) is a rebranded Huawei
ME906s-158 device. It, like the ME906s-158, requires the "NDP to end"
quirk for correct operation.

Signed-off-by: Tore Anderson <tore@fud.no>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/net/usb/cdc_mbim.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/net/usb/cdc_mbim.c b/drivers/net/usb/cdc_mbim.c
index 3a98f3762a4c..10862296c824 100644
--- a/drivers/net/usb/cdc_mbim.c
+++ b/drivers/net/usb/cdc_mbim.c
@@ -642,6 +642,13 @@ static const struct usb_device_id mbim_devs[] =3D {
 	  .driver_info =3D (unsigned long)&cdc_mbim_info_ndp_to_end,
 	},
=20
+	/* The HP lt4132 (03f0:a31d) is a rebranded Huawei ME906s-158,
+	 * therefore it too requires the above "NDP to end" quirk.
+	 */
+	{ USB_DEVICE_AND_INTERFACE_INFO(0x03f0, 0xa31d, USB_CLASS_COMM, USB_CDC_S=
UBCLASS_MBIM, USB_CDC_PROTO_NONE),
+	  .driver_info =3D (unsigned long)&cdc_mbim_info_ndp_to_end,
+	},
+
 	/* Telit LE922A6 in MBIM composition */
 	{ USB_DEVICE_AND_INTERFACE_INFO(0x1bc7, 0x1041, USB_CLASS_COMM, USB_CDC_S=
UBCLASS_MBIM, USB_CDC_PROTO_NONE),
 	  .driver_info =3D (unsigned long)&cdc_mbim_info_avoid_altsetting_toggle,
--=20
2.15.1
