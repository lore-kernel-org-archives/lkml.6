Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3757758-1523239021-2-9416437670944914029
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
    1523239020; b=OJAfTHcVlzlhTpubn3+7pCV+4lVccuvF1w75wWo/krjcqlmCWQ
    yieM2HBQo4YYrNcHTEBdPjcHxcXF/VMNO+rxWmTHDclGRQK4ORduKqUw43ncvoVy
    52BMe0JDyPlbTrrFBHBXvaMQAS0J190llL8UldgWpoF+N3GEF4X49TrRDxsMoVuH
    POtcw5PrHKFPgA3DWaELdkck9484DX/Wbbclt0JQ0xR5aE3zWDh7rWLxjZY+ecuT
    ohKSY2/HcBcrxA8fxcGwHfwM1fEIKpzJZTON+xtBVr9D66Frp5CYLvYroA4GT3CE
    xKcYJTOdVYRagoKRGEhO3W4iHLwNqy07iX6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=fm2; t=1523239020; bh=9sTMgBD6p0
    LrxnIG3Zyuxa2k3+ks4pVp37RsZ0wazRU=; b=qzgsogdtYvPejsRjz3Rs6rzBBX
    diglsxRKQ3gY7uwepq2ImXoxPrSZJmD9owba/sBuDlT6NKQcdXfc8gIajmxgiGOh
    VJeulE8SXrc4vJGvSsUpIxHfYF7DGgraK9hTmPeKsiWsDXANKRZpZv2aUDPlohvy
    WSVWd+wQ/+E8CR967Daz05HgbTo3DUAixJgLdu/zeU0oty94uglyY7GJQ4HAEhf9
    yhFHeKGIyK3rpx/jWosLdkuav+xX6xTfeHstOirum6oZz7huEZxyBGfVV4ll4JZV
    rO3w6kYFdAzS9FtH0ulgt30zqPtqAdHxfI1yV1GQ8/evqMONzNNRBXBwu1pw==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=SjwvQzy2 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
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
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=SjwvQzy2 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfF7fHmLdCuMFewpd86NxFcwkLNf1mxBrIu26i97UY9KjdM9aCeQpLOe4GMk2q4yi1ZrLtKE+p7x4R5rnQ3tSQfox3ljTPuIrqJ9Yt2bDRbvRZ2ffUb9Y
    droDrOFdOagbdgWpz9+MoBhKgtpSB3QAppV7l1vtYYKF/QaUAFGubtoYPdUMihofuBAqopYkcfpqfBz8cH1LilwF1FvQu4vLCRUVn9674I93RYwBw7JyJwHC
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=wRwT6uffUbIA:10 a=t_PdEiP4ckcA:10
    a=mw6kJ3eo-EIA:10 a=8nJEP1OIZ-IA:10 a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10
    a=Lf-vpJhqX20A:10 a=QyXUC8HyAAAA:8 a=CbDCq_QkAAAA:8 a=yMhMjlubAAAA:8
    a=OyVWofH8j1v_oT0GuxAA:9 a=wPNLvfGTeEIA:10 a=1qrBK16LubpBFNPVNq2M:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932860AbeDIB4d (ORCPT <rfc822;greg@kroah.com>);
        Sun, 8 Apr 2018 21:56:33 -0400
Received: from mail-by2nam01on0100.outbound.protection.outlook.com ([104.47.34.100]:61248
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932164AbeDIAcy (ORCPT <rfc822;stable@vger.kernel.org>);
        Sun, 8 Apr 2018 20:32:54 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: Shiraz Saleem <shiraz.saleem@intel.com>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.9 220/293] i40iw: Zero-out consumer key on
 allocate stag for FMR
Thread-Topic: [PATCH AUTOSEL for 4.9 220/293] i40iw: Zero-out consumer key on
 allocate stag for FMR
Thread-Index: AQHTz5lNHcOfFeAsfUSBa5vxRe6UKw==
Date: Mon, 9 Apr 2018 00:25:45 +0000
Message-ID: <20180409002239.163177-220-alexander.levin@microsoft.com>
References: <20180409002239.163177-1-alexander.levin@microsoft.com>
In-Reply-To: <20180409002239.163177-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0998;7:c5iOdaacU6FzrNxIM4j7gCqKnHqc4HgHX3F1rjwSbQ6gP3V6DTt3d1jLLZh49axPuGzuVKCDQPBP6KHJqEIMvorRJQjhY+xk3/FIt+peBxhvr11UCIc66QPO6t3ImGrzQxLSiIPSWFWOronQPvr6xSEFcwAcSAHVUl3MscmKvR2pPgvikxl7Tfl15uqWREhoTtvFW59e6qnsG7SUhuv5TRRUH2Ck6czFK9LV9zZi4vKB0RpxB2QQUogAFv3w5JBG;20:rWY8Bt489JrvKqdGOg8zaVA4vBsMqTwkjvZgnTJuaLzFIlQAr541apFai7e9H49B/mG8xOs5ypLz/E2NFeWHY+FkpvtxQMJAyPI/nEXZWOqzR0tWDtU4YqzX3gB2C53n1QFU8kW6hdSmjCtC8ltjcPaNhOgMoh0/C59CcTHyuos=
x-ms-office365-filtering-ht: Tenant
X-MS-Office365-Filtering-Correlation-Id: 155d4e73-380f-4837-1c59-08d59db16d92
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0998;
x-ms-traffictypediagnostic: DM5PR2101MB0998:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB09980F6ADD13AD2CC6E974A9FBBF0@DM5PR2101MB0998.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(228905959029699);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(3231221)(944501327)(52105095)(3002001)(10201501046)(6055026)(61426038)(61427038)(6041310)(20161123558120)(20161123562045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(6072148)(201708071742011);SRVR:DM5PR2101MB0998;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0998;
x-forefront-prvs: 0637FCE711
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(39380400002)(376002)(396003)(366004)(39860400002)(189003)(199004)(25786009)(105586002)(14454004)(76176011)(68736007)(2906002)(316002)(97736004)(8676002)(86612001)(3660700001)(3280700002)(102836004)(6116002)(4326008)(8936002)(36756003)(22452003)(81166006)(81156014)(54906003)(6506007)(10090500001)(2501003)(6512007)(186003)(6666003)(3846002)(486006)(5660300001)(26005)(7736002)(5250100002)(305945005)(99286004)(2900100001)(110136005)(1076002)(6436002)(53936002)(106356001)(107886003)(72206003)(86362001)(476003)(446003)(66066001)(11346002)(478600001)(10290500003)(2616005)(6486002)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0998;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: sps85xyAOefE5y4SeOaA6EsuW7ijX3ZX47odO9FjVkY00PcQMpsUIpJ76+vj1pCmFUc+gL3rhuyy+4paUF2Y+z2+kUF3y2mGKh69kcrpmLOaeG3tMKF3NnQQclHhJssC8cKiotvr7M6f7uIMiEX05fDza3zv2inN9bW15vvKB9NW3gdgCJEAqRe7sdneqaZVrrgd18WZEinX8fTS0CuU78qRXVIW9gDlp0SO04G9WRYH+OCouNoi72LL4xiVOr217spSF2CqTr6yRJJwd6QKGmCaZMJzS4TjZcgFrmnQ1jXR+FpKZqQa1c83msOyytc1R9i2oq24Dns7ZcYqVswQex9A1OazHKNvT4U72G+4IsPZ8Qafh2rh4aaF3gJoo8w2CR6OLqdU+A2ifaJOVu6/5HOjTocV1dqYZxOz0QT5qNU=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 155d4e73-380f-4837-1c59-08d59db16d92
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2018 00:25:45.9722
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0998
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Shiraz Saleem <shiraz.saleem@intel.com>

[ Upstream commit 6376e926af1a8661dd1b2e6d0896e07f84a35844 ]

If the application invalidates the MR before the FMR WR, HW parses the
consumer key portion of the stag and returns an invalid stag key
Asynchronous Event (AE) that tears down the QP.

Fix this by zeroing-out the consumer key portion of the allocated stag
returned to application for FMR.

Fixes: ee855d3b93f3 ("RDMA/i40iw: Add base memory management extensions")
Signed-off-by: Shiraz Saleem <shiraz.saleem@intel.com>
Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/infiniband/hw/i40iw/i40iw_verbs.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/infiniband/hw/i40iw/i40iw_verbs.c b/drivers/infiniband=
/hw/i40iw/i40iw_verbs.c
index 4b892ca2b13a..095912fb3201 100644
--- a/drivers/infiniband/hw/i40iw/i40iw_verbs.c
+++ b/drivers/infiniband/hw/i40iw/i40iw_verbs.c
@@ -1515,6 +1515,7 @@ static struct ib_mr *i40iw_alloc_mr(struct ib_pd *pd,
 		err_code =3D -EOVERFLOW;
 		goto err;
 	}
+	stag &=3D ~I40IW_CQPSQ_STAG_KEY_MASK;
 	iwmr->stag =3D stag;
 	iwmr->ibmr.rkey =3D stag;
 	iwmr->ibmr.lkey =3D stag;
--=20
2.15.1
