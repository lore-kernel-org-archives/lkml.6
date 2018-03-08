Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-912290-1520485998-2-11692496157484971283
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520485997; b=YYWQ1cHcOwlS8upYWJ8l3l4mpYmq3j8HryctRh7UjyFVDT+
    FuyE9YoG1DrkeUaqbKhQQWtMhOsr+laHcRITRvI/zicyg7DkP8T7Jh8z+QIVzoQq
    L4PmE6dhUBzDvImj8MwxHSbsWrgYnp2ZE2TDJFZGpZI1mBVBOzX+ORXgFczUQ2AV
    b4blvb9qcVD3t3M6yIgmHoSxZqi9vr4DXxjL4TIga1ukWCtrTrOv5MRjzXea/O4S
    LYKOhU3rnBe/IRfLwtNqD4zQVZwncNMD2LsK3ZtXZE/gpZjYvWAqDOXLpN6c77aI
    O7ZoSpSydwgE2ZFYNYvARLtRxSVY5ZRRXzDQV+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1520485997; bh=Wz1Tu1
    nMICnN5QA8sC1OW0V+KkqeS2NMyiU4E3yXYEI=; b=aEVKX4YulWU26bARh7xqVM
    N7kVIdzbwhFaHHPK/25YfPIwUhbyYuhEPZjEE3twlSdayPQzCo8WgpAcfeYoZxT/
    I6JdDzfoT6AZ6i4n2RrPk+rHudTA1nziQC/3//Uz+TUzRADvu11y6LQkCY8TB7QH
    z5MB0aBGd8rrajfj+FbMmAy5xE4jw8KsYgWCnSC8eK21BE8DnNdMAcznXDWr/qtU
    BAU1JVWj4fjM4FoWKcXcm4W8RBIq1D4S3Ei4BpbkeSOZU0/bnhbQtqde0KblNJwo
    EipQdOd9sRJWIcZGEUdIcDCltfefbZHXNuU2tNSgERZP0ZosvAk5F9tUt9+0DsMQ
    ==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=j7whhld2 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=j7whhld2 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966955AbeCHFLz (ORCPT <rfc822;greg@kroah.com>);
        Thu, 8 Mar 2018 00:11:55 -0500
Received: from mail-dm3nam03on0132.outbound.protection.outlook.com ([104.47.41.132]:45039
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S966479AbeCHFLv (ORCPT <rfc822;stable@vger.kernel.org>);
        Thu, 8 Mar 2018 00:11:51 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Peter Ujfalusi <peter.ujfalusi@ti.com>,
        Tomi Valkeinen <tomi.valkeinen@ti.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 3.18 51/53] drm/omap: DMM: Check for DMM readiness
 after successful transaction commit
Thread-Topic: [PATCH AUTOSEL for 3.18 51/53] drm/omap: DMM: Check for DMM
 readiness after successful transaction commit
Thread-Index: AQHTtprM++EQgp4A50igXo1ViMCDXA==
Date: Thu, 8 Mar 2018 05:03:29 +0000
Message-ID: <20180308050230.8876-51-alexander.levin@microsoft.com>
References: <20180308050230.8876-1-alexander.levin@microsoft.com>
In-Reply-To: <20180308050230.8876-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1112;7:wi9dkGEMDY0zueAwldiCrfPypjfDn95nANn7elEV1DPvgSA3uZN4KUumGMfW7nJRrPQlbnBLWLX6ELbQpyTdHILvDW9z6ngt7aF8oCy6YU5DncShD0GrLLquOb5uTB1xhg+rGjpnI3feTIBOGmuoAUbckwchlRcoc2oCOOUtj63oVPxqMA35CldJS4KQY3x9yeDRuRwAX/kBGjKCzlqIUyWmitcy1S3V1pb8FONCaP5PuVg/nK7PxszbxJ4EV1ji;20:Wi5PNz8GWedlKjhdeN4LbELwxlDu2fAeOA8Rt1EyKorWLYkKu5dlTO0Jwb3rtd88Xn2OUmoO5R89liAnO398qWNMJ34n0CoN5OuFQOwIt47JDskrwnYhCzObfttI9zAqDr+8kFX9ZaRbTyTeEDSz/GBDUYNrB2casd0S4IzrlNg=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: ef4faf48-ea88-41f2-784e-08d584b31856
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB1112;
x-ms-traffictypediagnostic: DM5PR2101MB1112:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB1112E9E5304F54C4938B51B2FBDF0@DM5PR2101MB1112.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(31051911155226)(89211679590171);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231220)(944501244)(52105095)(10201501046)(3002001)(6055026)(61426038)(61427038)(6041288)(20161123562045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123560045)(6072148)(201708071742011);SRVR:DM5PR2101MB1112;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1112;
x-forefront-prvs: 060503E79B
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(346002)(376002)(39380400002)(366004)(396003)(189003)(199004)(54906003)(81156014)(7736002)(86612001)(25786009)(81166006)(6512007)(6486002)(4326008)(3846002)(1076002)(6436002)(36756003)(305945005)(6116002)(8936002)(551934003)(2900100001)(6666003)(97736004)(66066001)(2950100002)(105586002)(68736007)(14454004)(72206003)(3660700001)(478600001)(10290500003)(3280700002)(53936002)(106356001)(10090500001)(5660300001)(102836004)(107886003)(316002)(110136005)(22452003)(86362001)(2501003)(5250100002)(6506007)(76176011)(99286004)(2906002)(26005)(186003)(8676002)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1112;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
x-microsoft-antispam-message-info: V8JGcUnn8hVCzgQeVfkpVULtT+1dlrTDFLch5Y7oCPtWcruDtIqu56Eaggu7UmjMdP58eMnudyhuv0yo/iHSOMC5/VnvNbKasTHgGzrQjh0nVn3F59Oa7j6GR49pvKtGoJf23I6yhVGGApzLSNdVFkL3Gy4H8HNrpqoW4+jp7oj63MwZNE3NrC5ZzcdtLHU6Urf4TDvS6EXhGZ+ey8GaXt8dId0X0vUOoIRAAvl/eNX7+LDWCA0ru3CLbAF3RaJkx1gYvw0nuulEzdVhexOm0GZTMfSx3aaM8Ca4l35p7eiFXET2dI1VgllXs+y8ksB+Yg6nvhU2LczH2D0LLDdx4w==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ef4faf48-ea88-41f2-784e-08d584b31856
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Mar 2018 05:03:29.8735
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1112
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Peter Ujfalusi <peter.ujfalusi@ti.com>

[ Upstream commit b7ea6b286c4051e043f691781785e3c4672f014a ]

Check the status of the DMM engine after it is reported that the
transaction was completed as in rare cases the engine might not reached a
working state.

The wait_status() will print information in case the DMM is not reached the
expected state and the dmm_txn_commit() will return with an error code to
make sure that we are not continuing with a broken setup.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/gpu/drm/omapdrm/omap_dmm_tiler.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/gpu/drm/omapdrm/omap_dmm_tiler.c b/drivers/gpu/drm/oma=
pdrm/omap_dmm_tiler.c
index 56c60552abba..f732d4ce7e4f 100644
--- a/drivers/gpu/drm/omapdrm/omap_dmm_tiler.c
+++ b/drivers/gpu/drm/omapdrm/omap_dmm_tiler.c
@@ -280,7 +280,12 @@ static int dmm_txn_commit(struct dmm_txn *txn, bool wa=
it)
 				msecs_to_jiffies(1)) <=3D 0) {
 			dev_err(dmm->dev, "timed out waiting for done\n");
 			ret =3D -ETIMEDOUT;
+			goto cleanup;
 		}
+
+		/* Check the engine status before continue */
+		ret =3D wait_status(engine, DMM_PATSTATUS_READY |
+				  DMM_PATSTATUS_VALID | DMM_PATSTATUS_DONE);
 	}
=20
 cleanup:
--=20
2.14.1
