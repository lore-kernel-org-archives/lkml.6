Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-966195-1520486751-2-382873627946107027
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
    t=1520486750; b=GlAOtqB5bcRFZL8iMCfW1K8YZVqE2pQcroN5y054azRut0Q
    RHom0E2tBzhcRdWkqQfDkNH0PlCRKzSLzx4OaxO+ZzQMNcBw4YYKBYFVCl9ex4Xl
    L5YP5B0FMp2it70CnZpFMWwnSdnLFnkRoNINPGSfYS++hjUh6xMGRrzqOBQZLyOM
    xR8npVj0dM8l484TM3xv0IEIpfEPFRWGIcnD+Ok0uE3cUx20kpbyjZkGgrGgPt6Q
    ClGSb3NbeIpuB3pQTXGpb4Z0FbOBlnTloToywBzu6bJuN0sTuWUXSNfLqIS9RPAH
    9gzwDOTp3hW/CbWw43KZQAULdE8h6iDwgIeFsuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1520486750; bh=MMvOPe
    jVbGNhpllJUoMK9wzHu0aYDw1B0XX9qw2Y+JM=; b=egQvZBX+Ql/GLRscIKRKnq
    9prZaIrk5tQSvXDguyMWP7guQNCqfdG1HwbybMqpR097fm4h50XE8HP4KYC/h5zR
    XZWj2GVvwYAvncJZC0vKYResGV2zVpm7T/GcGgbNS6ASNlkp9w4QzE9Qr1G0QSmq
    znWmTU99lAjn7S8CV4Fz04ujTKpHHwtQG7bnW3quuL5YlOdrJ/gmXp924jo+LUFk
    fq+xV3e3lao0MV10aTjklsMtQG8z0Vq43MoKziLZncIw0vTCHiqQvV3BdPssgHc7
    tqf/Up5wCBiSIoqJJnG/z4A7+WM/cCnFHNlxZjzEjMtoAnDZYw/MH9U3kPqqapIw
    ==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=RO+r+/rA x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=RO+r+/rA x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966578AbeCHFHR (ORCPT <rfc822;greg@kroah.com>);
        Thu, 8 Mar 2018 00:07:17 -0500
Received: from mail-bn3nam01on0110.outbound.protection.outlook.com ([104.47.33.110]:54752
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S966278AbeCHFHP (ORCPT <rfc822;stable@vger.kernel.org>);
        Thu, 8 Mar 2018 00:07:15 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Prakash Kamliya <pkamliya@codeaurora.org>,
        Sharat Masetty <smasetty@codeaurora.org>,
        Rob Clark <robdclark@gmail.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.4 080/101] drm/msm: fix leak in failed get_pages
Thread-Topic: [PATCH AUTOSEL for 4.4 080/101] drm/msm: fix leak in failed
 get_pages
Thread-Index: AQHTtpqbV5psikCv9Eiw2AAd6AfRUg==
Date: Thu, 8 Mar 2018 05:02:08 +0000
Message-ID: <20180308050023.8548-80-alexander.levin@microsoft.com>
References: <20180308050023.8548-1-alexander.levin@microsoft.com>
In-Reply-To: <20180308050023.8548-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1077;7:KjVPvlbOSo0UtWXnE9BicmEY2L7FB1KT+fm8O+ZomQlPZ+TKVBQfDllDbSgFz76WNZblil7jFYdPMSihiv6WE1YXR55+onNBA84/SXnuwiBsnZD/SRaAyIb/feH7+YyuymiROYNLxSukIEjfQ7kYnJ7yKSfaqdX5wF5CEL/3tKAgu1d4aC/XzBpLvDyyAvB1oTIj4me5Ku/qhVwK/VXVhxZjWN47cn3UY/mZvm56ipmC3hnVK39cCtsF4Qoys3jV;20:VY190SfHyjjLY2aZewXTPLR5/+i+30oFJiyUFsQAHvhDjzQwb3M694LhlT1nUz8O9J85GfGxwyzUP9F2O5bxfBm9zh9MGau38WXjEj7EOJj2eVK0Fpc2c1O+E4skc4/MCN8rmEIed3gs+EGilpSQeEZiztKFg4i+g5MQHJPKpxw=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 0ebcf77a-096e-40b2-5eb7-08d584b27161
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB1077;
x-ms-traffictypediagnostic: DM5PR2101MB1077:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB1077963D83659CE11929AAA5FBDF0@DM5PR2101MB1077.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(85827821059158);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231220)(944501244)(52105095)(10201501046)(3002001)(6055026)(61426038)(61427038)(6041288)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123560045)(20161123562045)(20161123558120)(6072148)(201708071742011);SRVR:DM5PR2101MB1077;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1077;
x-forefront-prvs: 060503E79B
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(376002)(346002)(39380400002)(396003)(39860400002)(199004)(189003)(86362001)(102836004)(6506007)(22452003)(2950100002)(186003)(68736007)(26005)(106356001)(105586002)(66066001)(86612001)(3846002)(3280700002)(2900100001)(25786009)(53936002)(5660300001)(2906002)(3660700001)(10090500001)(6512007)(39060400002)(1076002)(4326008)(6116002)(305945005)(110136005)(107886003)(54906003)(2501003)(5250100002)(8676002)(8936002)(81156014)(81166006)(14454004)(76176011)(7736002)(72206003)(10290500003)(478600001)(6486002)(6436002)(99286004)(36756003)(97736004)(316002)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1077;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
x-microsoft-antispam-message-info: aaXRsbM6lbHQlL6TDZQgsHK6YYq1n3pTml40ijpV9h4qbzpah4qMKjK/CsI03UKRUm+Xw2DHvqKTdk1P/wa/NCjVvXzqEl08epI8uWk9L7xYaCJhbPw3HLBnwuboofQLZJJDwp080Res0u5yDRup7Ilvb87GJXi/aBgLwE0ciay6tNiEO+oV4CAsyV/5v3WNMz6mnG38BRi8OQzDiv3ngTGGpukNP6WxJb6IUW+1qv1QEBUhZzNjOzM6RfJ+a+gMT2UCaE2OB8xRjB2IVlGcI0El188iWD7Yt+5/ebfp25O6kX7dscwEo0tWqAL8QHnLczgtf2bKS8Aqx5f1IB94DQ==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0ebcf77a-096e-40b2-5eb7-08d584b27161
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Mar 2018 05:02:08.1510
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1077
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Prakash Kamliya <pkamliya@codeaurora.org>

[ Upstream commit 62e3a3e342af3c313ab38603811ecdb1fcc79edb ]

get_pages doesn't keep a reference of the pages allocated
when it fails later in the code path. This can lead to
a memory leak. Keep reference of the allocated pages so
that it can be freed when msm_gem_free_object gets called
later during cleanup.

Signed-off-by: Prakash Kamliya <pkamliya@codeaurora.org>
Signed-off-by: Sharat Masetty <smasetty@codeaurora.org>
Signed-off-by: Rob Clark <robdclark@gmail.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/gpu/drm/msm/msm_gem.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/msm/msm_gem.c b/drivers/gpu/drm/msm/msm_gem.c
index c76cc853b08a..644faf3ae93a 100644
--- a/drivers/gpu/drm/msm/msm_gem.c
+++ b/drivers/gpu/drm/msm/msm_gem.c
@@ -89,14 +89,17 @@ static struct page **get_pages(struct drm_gem_object *o=
bj)
 			return p;
 		}
=20
+		msm_obj->pages =3D p;
+
 		msm_obj->sgt =3D drm_prime_pages_to_sg(p, npages);
 		if (IS_ERR(msm_obj->sgt)) {
+			void *ptr =3D ERR_CAST(msm_obj->sgt);
+
 			dev_err(dev->dev, "failed to allocate sgt\n");
-			return ERR_CAST(msm_obj->sgt);
+			msm_obj->sgt =3D NULL;
+			return ptr;
 		}
=20
-		msm_obj->pages =3D p;
-
 		/* For non-cached buffers, ensure the new pages are clean
 		 * because display controller, GPU, etc. are not coherent:
 		 */
@@ -119,7 +122,10 @@ static void put_pages(struct drm_gem_object *obj)
 		if (msm_obj->flags & (MSM_BO_WC|MSM_BO_UNCACHED))
 			dma_unmap_sg(obj->dev->dev, msm_obj->sgt->sgl,
 					msm_obj->sgt->nents, DMA_BIDIRECTIONAL);
-		sg_free_table(msm_obj->sgt);
+
+		if (msm_obj->sgt)
+			sg_free_table(msm_obj->sgt);
+
 		kfree(msm_obj->sgt);
=20
 		if (use_pages(obj))
--=20
2.14.1
