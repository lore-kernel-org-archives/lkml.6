Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-981117-1520486128-2-369744498121196207
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
    t=1520486128; b=S3jkW7QGPAc6WFPxQhVw9QSMORFrQRAkozcBNXhi4W65Wrg
    iyL6pEKQtcjZN/1ILUqph18vYAuTty6EjRayoUN84Poqn9ain6FulQxEjapjC1T2
    n4L91We43+9yr9UhMkH+y6hTja+VDKW/voDsRAXIA+lVZmoNcSLfdpD9a+dRt+pG
    CeWH3b4O4Ze/YUdj2vqPPiyoMBItZiMOkx16cKsbATtqPEzeBkqcx0DJmkkMbyj/
    UtZbJvB+0vkU6L1/hMHVIJ6rTMnBqUBLdn8dz04tforXpZr4E7FYqp0KAYoXGwku
    /YZy8TaKpA2GDfLpFIy8vq8GLAjDY/EXafL8Uzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1520486128; bh=lcps0i
    773SsaFdnfBWH/nJUMFnOUpomkp8sVuETiWZc=; b=HnMDc1uIzU7AX1eXYeoRJc
    ZXgKkc036hKW+0kz3+BXNLHQV5hHJ0RJNkKin/aPFY91VcTNHSq+WKCFEoMIoZds
    Wfz16bdrhnGhdXHckGFFITbSEX4euAZ3Qywinuu/G94GN+O+Di25f+eeIaBUV9nv
    nfGbIXlyK6hlYYrCeTZo3oXTCO/m3QTSNg3nJYF1EgPInESq0i3nInbOJkV9GKJe
    67Eg5IgCs+MArfdayIfVArbQQY4yziKwGh6MaiO3xeJ1xuvXnPAkAR9wYd+pEZjf
    bX6D67vO6fZaCRp7ihaJQiTbptpqH0rSmC2np/AVkPG2OnDXAGy3K/cPW59FW5tg
    ==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=KH19b+Jd x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=KH19b+Jd x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966854AbeCHFPR (ORCPT <rfc822;greg@kroah.com>);
        Thu, 8 Mar 2018 00:15:17 -0500
Received: from mail-cys01nam02on0137.outbound.protection.outlook.com ([104.47.37.137]:8100
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S966886AbeCHFLo (ORCPT <rfc822;stable@vger.kernel.org>);
        Thu, 8 Mar 2018 00:11:44 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Prakash Kamliya <pkamliya@codeaurora.org>,
        Sharat Masetty <smasetty@codeaurora.org>,
        Rob Clark <robdclark@gmail.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 3.18 44/53] drm/msm: fix leak in failed get_pages
Thread-Topic: [PATCH AUTOSEL for 3.18 44/53] drm/msm: fix leak in failed
 get_pages
Thread-Index: AQHTtprKFnBLqvnuWEGsndS3QUfMOw==
Date: Thu, 8 Mar 2018 05:03:26 +0000
Message-ID: <20180308050230.8876-44-alexander.levin@microsoft.com>
References: <20180308050230.8876-1-alexander.levin@microsoft.com>
In-Reply-To: <20180308050230.8876-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1030;7:g+MvoYHf82Ir0Al40ILl2rt2nIio2fZxWF80UCNqBzcrWPY1vSGjcx4jzS/48FKua7LNBVgtiMfVp2Z0UNVMsoZ2QEKPLpQoJ25G7PGrzrU8ylLasENImKFej2Vp6nS6i0SsvNGJwSPKcn25A8KenHaMC8N5aaDLV5lBDSISJZ9iLtIRtumtQ5H10gFr4eQdwd1fIrWESPzfU4Pnk9wHN9RcbminZTHhASnmpiiFEvXjqR4PWlCJ2M9zRcOsWA7m;20:cPgVi0HSD7/E/G6XGpZEGhdSa0v/rvkB7+oS7zWL8veVfUPVCoEjMh7FgIraNXIQo07ur6fPM/PV+D1qtQj7o5eykKbV/xYhkVRbVMsrwp1zMHv8wlOfPYO5/4lqm1IYEfFacPO6/6/7w21uNSIPPRG0ceX5GeH8zudRI95Dkcw=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 9bf476f5-3a4b-4769-e3e4-08d584b31137
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB1030;
x-ms-traffictypediagnostic: DM5PR2101MB1030:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB1030623F4F12CAE5DE4E5CE1FBDF0@DM5PR2101MB1030.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(85827821059158);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(5005006)(8121501046)(3002001)(10201501046)(3231220)(944501244)(52105095)(93006095)(93001095)(6055026)(61426038)(61427038)(6041288)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123558120)(20161123564045)(6072148)(201708071742011);SRVR:DM5PR2101MB1030;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1030;
x-forefront-prvs: 060503E79B
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39380400002)(366004)(396003)(39860400002)(346002)(376002)(199004)(189003)(5250100002)(316002)(39060400002)(6666003)(6506007)(2950100002)(26005)(76176011)(68736007)(53936002)(6512007)(2900100001)(86612001)(3660700001)(106356001)(10090500001)(99286004)(2501003)(4326008)(14454004)(102836004)(25786009)(97736004)(6486002)(86362001)(36756003)(7736002)(6116002)(2906002)(478600001)(6436002)(107886003)(72206003)(186003)(3846002)(66066001)(81156014)(10290500003)(1076002)(22452003)(305945005)(110136005)(81166006)(105586002)(3280700002)(54906003)(8936002)(5660300001)(8676002)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1030;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
x-microsoft-antispam-message-info: lAmDt+xpRZX/3FPSlTrDWS3Zh9bMEkRLDKbcH4VVFZaaWTIiiS+qz935s/0I9NF+WwnKRvKmKCQSx+k4kpUScH6ED4lJfPt7ODxLtyItsRl/qXWmtJhtekTr6mzR52CcVzgKXadjIW5Rb8y0Qf71xsutkbeECwx/5iMHoLPSqIWxlUtdg0Vo2IpFswi1EruNXiu2FJt4obVK1hrMH/M+uajn/meLyQv4pZZ/9GCn9N+GuYqvohkOl7SkzE2OYc3Ha2KsJ2SfGM9tntcKAewqmMjUl1XV2LzbBOF7JLW7e+mWwRVuHtOycDYLgjfliDHrOp/nx2FBFb1rp/rw8mhhNQ==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9bf476f5-3a4b-4769-e3e4-08d584b31137
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Mar 2018 05:03:26.7612
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1030
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
index 4b1b82adabde..c7fa53b9a6c4 100644
--- a/drivers/gpu/drm/msm/msm_gem.c
+++ b/drivers/gpu/drm/msm/msm_gem.c
@@ -83,14 +83,17 @@ static struct page **get_pages(struct drm_gem_object *o=
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
@@ -113,7 +116,10 @@ static void put_pages(struct drm_gem_object *obj)
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
 		if (iommu_present(&platform_bus_type))
--=20
2.14.1
