Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1025811-1520488493-2-17857558995111625126
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
    t=1520488492; b=jtU+9eJ1kJYcGfygTo2j5rJ7PJ1wgCliaq6ars12p8g1XKu
    Nqb3oVINkw/UGW6xFT0vKxslo4cyAM4XetwTzWDdMBMQnesucXFuL7TnE+lMNbWZ
    gMeKRXsvUOwkh+wwCOAbvhWApTDHxnfw5cz63W3aLzzlAj7g9klXHzpYyizYwsst
    eYeCtHSE5sGunMuKcsFQd5SY7T056EDrcSw2HoUq8HKDT5MZyVo3xCyRZw6tveRV
    PI+3hAdKrE27zT1vBFESTpcYs6Io0w+Srk3SzIV0pexSt3Vj7Xx9r0WSb7N49H1i
    /MgYZMBRR1diQrEuNuFIwpIByW4dLtVN1pvmBiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1520488492; bh=rUrZiy
    k+KBJBZQ2gl+A5ddXsBFZC5ZHWN1MR0fu73uQ=; b=bU+PV4U7/ceg6GXhVIkj67
    wtPQ6u3XcAZCpoCY1dei6/s1V5lJeUvFM/4gFMrNZQ6phg/lOg4LMz8dSE9YSXBy
    DB7MNrv+LC8E9ksiOIYfumfkTGKoeRhvpH5MHRNi7xEdwXJPieaFGn5nbY+/obn6
    IHWZeBQO1OyIg6tE6O1mM3lMyuSY+2/k0B4a9AZ5F63WTqx7Lk7eEDzaLtO5JDIg
    zENIbk0VsWbuilkFm4P4lAKlZRHrAnGoRZ25fXDVq6eq/8Rn5Nw4ZDxq9ZAmqYPS
    VuMD0WfQY6Kb1NgFy2YPsecFfdOmFFVqkJPnMC8alZMetdAF66dFQYg6zH0//Iag
    ==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=FQvHec22 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=FQvHec22 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965893AbeCHFyr (ORCPT <rfc822;greg@kroah.com>);
        Thu, 8 Mar 2018 00:54:47 -0500
Received: from mail-co1nam03on0092.outbound.protection.outlook.com ([104.47.40.92]:45512
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S966092AbeCHFEC (ORCPT <rfc822;stable@vger.kernel.org>);
        Thu, 8 Mar 2018 00:04:02 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Prakash Kamliya <pkamliya@codeaurora.org>,
        Sharat Masetty <smasetty@codeaurora.org>,
        Rob Clark <robdclark@gmail.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.9 155/190] drm/msm: fix leak in failed get_pages
Thread-Topic: [PATCH AUTOSEL for 4.9 155/190] drm/msm: fix leak in failed
 get_pages
Thread-Index: AQHTtppQnC3vFnhfZ0Ggh65CTbnEDw==
Date: Thu, 8 Mar 2018 05:00:00 +0000
Message-ID: <20180308045810.8041-155-alexander.levin@microsoft.com>
References: <20180308045810.8041-1-alexander.levin@microsoft.com>
In-Reply-To: <20180308045810.8041-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0902;7:AcG4pv5f7oMPlqc3AB9NJIeX2TMeROTnwprnn86mKMJ54nS2v0zhVQrq5Bkf5YKaQidNcCBLiTAjRX7ocehYVDsCA1U0Op49bAi0gob/6qYWsJgyTZCqyk1OXcjreiSXBXIQQZbOUA1AOhDPsdlQpKNsGWsjLwhYi46ZdwFEU8Smnt2p7dcMJcWRXqEgXJazDEpwWhsBuskIkfeDPj+bvsG6M/MkamWa7yV5Incppy2mH2J0qr5x0pyS/VHQXQC3;20:tO+VVjKuz2dMpPhnpflClKkgZ+63Ebi5JXTqW+Gn1TtMDB8/HBkhtWJ98OV9Z+IVBXxN/OaLkpmgQdPR2JSAoydtjG+qJgQ/IAEbx/KtaerME6snU5X/zFgjvhfUYRo8Bz5C+DxzxzzDIc9voqRV1kRjig9UsTt4pf4+8pX3DD8=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 4c04e9c9-c1d1-464c-605a-08d584b1fe8e
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0902;
x-ms-traffictypediagnostic: DM5PR2101MB0902:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB0902DAD50EBF1EEE14C26763FBDF0@DM5PR2101MB0902.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(85827821059158);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(5005006)(8121501046)(10201501046)(3002001)(3231220)(944501244)(52105095)(93006095)(93001095)(6055026)(61426038)(61427038)(6041288)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123564045)(20161123558120)(6072148)(201708071742011);SRVR:DM5PR2101MB0902;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0902;
x-forefront-prvs: 060503E79B
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(39860400002)(39380400002)(376002)(366004)(396003)(189003)(199004)(8936002)(81156014)(81166006)(7736002)(5250100002)(8676002)(99286004)(26005)(107886003)(186003)(6666003)(2950100002)(106356001)(10090500001)(305945005)(66066001)(97736004)(2501003)(86362001)(3846002)(3660700001)(72206003)(6436002)(1076002)(6486002)(5660300001)(39060400002)(54906003)(110136005)(68736007)(53936002)(14454004)(36756003)(25786009)(478600001)(10290500003)(6506007)(2900100001)(102836004)(76176011)(6512007)(22452003)(6116002)(316002)(4326008)(105586002)(86612001)(2906002)(3280700002)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0902;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
x-microsoft-antispam-message-info: HzOR9TS1+y/c0yj/03Ey5U4/yKedcqBhp3GXuvl6YeVkYVRY/Xng4d4pdEILxfcxZHTrt3rnugDERmuaPHyVjlwZDQHAMEs4zGu7pPua5Yzn71+ivq79/8f9EKHWOE19Q5ID73GC0yHUHtYHOEXIwyJnU4vqNAVuJKHhgQYxAtoC9Lj6MPgo/rkT4gg0Fxr/x/9BMMN1Acpi2smuk63yMn8i8ECA2Puk1GTqcWQ2vxltxNpOg/2MOUmonGWc/+is6K8dxJRctcjs7WG6qygxEhIn1zy3erJYj4x0QKB7ZCQYj4brFBZoivypIKVrtiTDofKDk7ADBxv2TybjdoE9DQ==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4c04e9c9-c1d1-464c-605a-08d584b1fe8e
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Mar 2018 05:00:00.8099
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0902
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
index b6ac27e31929..797d1f8340b9 100644
--- a/drivers/gpu/drm/msm/msm_gem.c
+++ b/drivers/gpu/drm/msm/msm_gem.c
@@ -91,14 +91,17 @@ static struct page **get_pages(struct drm_gem_object *o=
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
@@ -121,7 +124,10 @@ static void put_pages(struct drm_gem_object *obj)
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
