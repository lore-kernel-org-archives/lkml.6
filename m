Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1576849-1517682856-2-7091761166774294971
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1517682855; b=ECPGrfqAtf31kjWQyzBuekgv1Wfza3g5a9Afct1EkWZSzWv
    vGdpouxMAU2+GMSrWvfcbd4goCOQmjd5JTyI4QbABJVEDIViE4S0InatqGz4LyKC
    lEVhFIeUteUAXt1VG96vIzY1mqiiZrcm/TSa+sSB8LhkBIYKScaT6xuLJwRQU1zf
    DLDntmeN0AjdJFh6n2+aD6TLttpoND219oYnIFZyD//ss44CP+SB+/skG3CwXxoL
    dVkgQRjvO4H1SoCnGnmn0c28O2bP3d5yVfdbZdDdh99iytlz4rShYoVHpmLW+B1J
    n3YOCuVenJJlqG/KVchYUlyC2/bqt6f/cfLsFFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1517682855; bh=oY941q
    SVkpYQ98WNfFOAPR3AL2znkK+hk9w2XnhU/A0=; b=VBN7RuAzjmlht2IPafWeqz
    5X4Ja8Vy70TvH22OTue09wGK/ZMFKTNhiX+a1gtuscb1zHWJWb1NrJPLHZZYd64T
    BIEn+O1nMBlcQ/rqJY3m2qwTuqdkrtoiUweCcPNcFk9CRs4GNNCbVpix0k98ZK4z
    trysAoJvo+laCOtcNTSD3N/1B65M/+sr/6D1KroBFXuDXdFLS3Ngb0D8MbiwIu+l
    A3jUvwwIajZWw1rHTGj9AxZjc2+lsgVjmNHBuhCO1nFieefUtoHcM85G4JSiVpTi
    JlDj3HtVnZW6sofANpSvHzwTyRa0yJnFzNxtdKfwddOXCuKDRDPBkS8P18oqCxHg
    ==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=eCpZcKau x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=eCpZcKau x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754558AbeBCS1X (ORCPT <rfc822;greg@kroah.com>);
        Sat, 3 Feb 2018 13:27:23 -0500
Received: from mail-sn1nam02on0093.outbound.protection.outlook.com ([104.47.36.93]:35549
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753053AbeBCSGF (ORCPT <rfc822;stable@vger.kernel.org>);
        Sat, 3 Feb 2018 13:06:05 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Stefan Haberland <sth@linux.vnet.ibm.com>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.4 16/32] s390/dasd: fix wrongly assigned
 configuration data
Thread-Topic: [PATCH AUTOSEL for 4.4 16/32] s390/dasd: fix wrongly assigned
 configuration data
Thread-Index: AQHTnRlxCZrHoecpIEKNTNqNft93qg==
Date: Sat, 3 Feb 2018 18:04:32 +0000
Message-ID: <20180203180413.7438-16-alexander.levin@microsoft.com>
References: <20180203180413.7438-1-alexander.levin@microsoft.com>
In-Reply-To: <20180203180413.7438-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BL0PR2101MB1009;7:uYXtNWdTTPZ+qJ652oZITD6eo3Q+ygOuphhEZh69q6InB2SEFK/JMLYt8SeHoSy7cxPDZhFImFEcbnuhQh6UiZUrYCePrI44okhmcUhxXz0yqzmHU4OfwhlHj89C8JFRKMegfLohsLg9QTiwHj6bG4C+SdctSAKi3KWbOgasOoFjtJDFklCoF9b723fDfbjqHdT4fdIvOe1AC6nbKWqfIVFxMGvMYTnkW7Wg5BsiYhgmIodz7byqozk5sv7YC1oo
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 2af1a8da-21f0-4550-9806-08d56b30c215
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(4604075)(3008032)(2017052603307)(7193020);SRVR:BL0PR2101MB1009;
x-ms-traffictypediagnostic: BL0PR2101MB1009:
x-microsoft-antispam-prvs: <BL0PR2101MB10092BDB87D7A8247506EEA6FBF80@BL0PR2101MB1009.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(190383065149520)(104084551191319);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(61425038)(6040501)(2401047)(5005006)(8121501046)(10201501046)(3231101)(2400082)(944501161)(93006095)(93001095)(3002001)(6055026)(61426038)(61427038)(6041288)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123558120)(20161123562045)(20161123564045)(6072148)(201708071742011);SRVR:BL0PR2101MB1009;BCL:0;PCL:0;RULEID:;SRVR:BL0PR2101MB1009;
x-forefront-prvs: 05724A8921
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39380400002)(366004)(39860400002)(346002)(396003)(376002)(189003)(199004)(6346003)(1076002)(26005)(107886003)(186003)(25786009)(6116002)(3846002)(3660700001)(105586002)(2501003)(10290500003)(99286004)(2906002)(3280700002)(5250100002)(4326008)(66066001)(36756003)(81166006)(81156014)(97736004)(8676002)(8936002)(54906003)(110136005)(72206003)(6666003)(86612001)(22452003)(53936002)(478600001)(59450400001)(68736007)(5660300001)(76176011)(6486002)(316002)(6506007)(102836004)(6436002)(2900100001)(14454004)(305945005)(106356001)(10090500001)(86362001)(6512007)(2950100002)(7736002)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:BL0PR2101MB1009;H:BL0PR2101MB1027.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-message-info: C1F06FR/yjMRHavwoPsEMvQZNS/W0l9TwShPrqTmLxPj9fJ3ubycEeVjoIgwR6FGBdU10TPfuZ9f694GGK2cCw==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2af1a8da-21f0-4550-9806-08d56b30c215
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Feb 2018 18:04:32.7214
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR2101MB1009
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Stefan Haberland <sth@linux.vnet.ibm.com>

[ Upstream commit 8a9bd4f8ebc6800bfc0596e28631ff6809a2f615 ]

We store per path and per device configuration data to identify the
path or device correctly. The per path configuration data might get
mixed up if the original request gets into error recovery and is
started with a random path mask.

This would lead to a wrong identification of a path in case of a CUIR
event for example.

Fix by copying the path mask from the original request to the error
recovery request in case it is a path verification request.

Signed-off-by: Stefan Haberland <sth@linux.vnet.ibm.com>
Reviewed-by: Jan Hoeppner <hoeppner@linux.vnet.ibm.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/s390/block/dasd_3990_erp.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/s390/block/dasd_3990_erp.c b/drivers/s390/block/dasd_3=
990_erp.c
index d26134713682..d05c553eb552 100644
--- a/drivers/s390/block/dasd_3990_erp.c
+++ b/drivers/s390/block/dasd_3990_erp.c
@@ -2743,6 +2743,16 @@ dasd_3990_erp_action(struct dasd_ccw_req * cqr)
 		erp =3D dasd_3990_erp_handle_match_erp(cqr, erp);
 	}
=20
+
+	/*
+	 * For path verification work we need to stick with the path that was
+	 * originally chosen so that the per path configuration data is
+	 * assigned correctly.
+	 */
+	if (test_bit(DASD_CQR_VERIFY_PATH, &erp->flags) && cqr->lpm) {
+		erp->lpm =3D cqr->lpm;
+	}
+
 	if (device->features & DASD_FEATURE_ERPLOG) {
 		/* print current erp_chain */
 		dev_err(&device->cdev->dev,
--=20
2.11.0
