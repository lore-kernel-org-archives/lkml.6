Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1486374-1517681686-2-10136988702204927951
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
    t=1517681685; b=k0VkkXuQ90O6B+yTwxKAeNjEVA53QRzKDx7aZMAKfSDgugi
    ula4YtowNISpZRkKR2516C+2tXoN9V4eW3bOz0ubbej9UEni7wYq+Qeqw1+TkSkU
    +eJei51JhTbyarauYD5E65u6MYbS0nN7rpv68r2tHY/w331FUqQD3oj8ZmSt65sN
    VRgTBFwjFNxu0l6D7dBSnEX4wwTQ6GrBvEQzqX5N+TheMEhPt1PeOt7ocPMIMBw8
    Db56oVVACbPWKKtnpQpkWg2Mfvgv4r+HZntOsWTDBm25YIZjTQSphlhIzh/bvCoZ
    0YWWuvQkf08Xmw/SBkZn17AK1ywh+6fM/YDkivg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1517681685; bh=oY941q
    SVkpYQ98WNfFOAPR3AL2znkK+hk9w2XnhU/A0=; b=VTDlfUE/g6lAB3nWGfUmHO
    ydhnOmH/I51XEijhsJp+h/HEft4VWZiN5YA4x660uBiXOq2WhdnT5+S5/ylZzRhV
    flR+hLup1pm+cs7z76SkkvKYPHhLKh9leCsa0XDdJGcy3+Hh3qYTZ/g8NnSTUPNL
    n21ctfLcvGGtg8Crm4cNN2T2/A9pQWdTHZZSL1LDw4QNdfRUOC4xdbbpVlKIdeW2
    nAX3uoeYYvd0wYwMmY0l/SqAOKBYQkx2KUkMbdJLCk79DQKNd38f9uusasmOGNQ4
    xlZtSAqseCMVgrZcP4mKv6r6sUn8KwMZnBknTiQBqv07Yy3YU1c9i7l2/LZKTtUw
    ==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=bbBHHag5 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=bbBHHag5 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753856AbeBCSOl (ORCPT <rfc822;greg@kroah.com>);
        Sat, 3 Feb 2018 13:14:41 -0500
Received: from mail-bl2nam02on0113.outbound.protection.outlook.com ([104.47.38.113]:13185
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752656AbeBCSHS (ORCPT <rfc822;stable@vger.kernel.org>);
        Sat, 3 Feb 2018 13:07:18 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Stefan Haberland <sth@linux.vnet.ibm.com>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 3.18 12/24] s390/dasd: fix wrongly assigned
 configuration data
Thread-Topic: [PATCH AUTOSEL for 3.18 12/24] s390/dasd: fix wrongly assigned
 configuration data
Thread-Index: AQHTnRmE9oKNh6Ao+0GOw4g6WHkItg==
Date: Sat, 3 Feb 2018 18:05:04 +0000
Message-ID: <20180203180444.10801-12-alexander.levin@microsoft.com>
References: <20180203180444.10801-1-alexander.levin@microsoft.com>
In-Reply-To: <20180203180444.10801-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BL0PR2101MB0993;7:SE7PpuUdjxg4QpPpYEbY9UWH8fwWGlEXnuStt+mWGn3nT42DZzgGBCE1VddSEf48ksT2DPbcotkYPDS2yoVKOjdIBWffy0YeijdzD3W9Bi/ZGtZAx/btth0k8qZIXSohw08U7Fa0X5gnpFC02ofUsjAHSiLYfxazhBr6YaIUHHOo3tFsKwKbfIj4+HL7KHzM8Fj994Mi5lsoWfPBUCCnyQlXIYxU4ySQJyQuNeTtUrAepxCS5rcAKIbnk4TQi15f
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 9723c1aa-f284-4523-35c6-08d56b30e03b
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(4604075)(3008032)(2017052603307)(7193020);SRVR:BL0PR2101MB0993;
x-ms-traffictypediagnostic: BL0PR2101MB0993:
x-microsoft-antispam-prvs: <BL0PR2101MB099314A745EDF7867BEDC399FBF80@BL0PR2101MB0993.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(190383065149520)(104084551191319);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(61425038)(6040501)(2401047)(5005006)(8121501046)(3002001)(10201501046)(3231101)(2400082)(944501161)(93006095)(93001095)(6055026)(61426038)(61427038)(6041288)(20161123558120)(20161123560045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(6072148)(201708071742011);SRVR:BL0PR2101MB0993;BCL:0;PCL:0;RULEID:;SRVR:BL0PR2101MB0993;
x-forefront-prvs: 05724A8921
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(39380400002)(39860400002)(376002)(366004)(396003)(189003)(199004)(6436002)(186003)(3660700001)(8936002)(105586002)(2906002)(6346003)(6116002)(3280700002)(3846002)(97736004)(6486002)(1076002)(2950100002)(6666003)(81156014)(86362001)(76176011)(102836004)(2501003)(5250100002)(26005)(68736007)(10090500001)(81166006)(8676002)(59450400001)(53936002)(5660300001)(22452003)(305945005)(107886003)(7736002)(4326008)(86612001)(36756003)(99286004)(316002)(6512007)(10290500003)(72206003)(6506007)(14454004)(478600001)(25786009)(106356001)(2900100001)(54906003)(110136005)(66066001)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:BL0PR2101MB0993;H:BL0PR2101MB1027.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-message-info: SULChFivrC7NGQgCK5pwISmTLApY64Grs0Zn8Lp6yS0B7xxxrW9nfBtsxP9TlEVepIktyeoqQkPRiv3yNexRFA==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9723c1aa-f284-4523-35c6-08d56b30e03b
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Feb 2018 18:05:04.5965
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR2101MB0993
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
