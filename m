Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1171329-1520491887-2-12709130031673555098
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
    t=1520491887; b=Jziu00p0tSHtcCS6i2ji4MpB6ivP/G6TeC/1Ln8NbhBMpYX
    yiML8HsClHo7PAefBP3npKBpWSsHvak3M4tb+XSGTQg6Z+XHfJaEQbxB/cHjbp5O
    bb+HWW1SJZ75OLbaFBPy6IXNX3oDfy0vsTZlqCGdUcWUGt3ody/owynkDcCxMEWJ
    ksDc+XR2g2bMNNBbq8FOLl0aQTlIGeuDYxSYhYAMU9hzwrueulpHXt8SkCJxQBdI
    ZDYSEKS/8tGnJ1ICPwsa1wOL1qKjXWQyhnclkAbe+6Lw++44cNEqdy1ywviOUK41
    qC7qYy8upKZN887I3sRRMx4IuY8/Qp+VqBRtgnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1520491887; bh=4pufOC
    Uzq1Qyv914OdO/ylMSNYahTAzPaCqywOe7Brc=; b=C9QL7GwEtVYG6zQgDqsQW0
    vuXv4bEhQUpsIhv+VTDkhsppwRgWegkbWWqLZtTNemE1Tn2WtEuhG8v9NvDTX7zc
    itWpH4m1qfmxPDvWEKCx3W1SId8F2pNG+qXhHzirAbSIHs+0rREOPHdLXgmMX4Kd
    lvlxkSUBhCqmPaerghphGS5gIKH/o5qFUswo83Jbie6HFjw7zkqqsXYEYMrd5wyz
    oehpgP5vZnt/Lub3BC2r4wGn2Fj3mTcKS7NyKEAjeil91g8LP8KqMBqnuDDjCW+P
    uHADILs7ex9+fjvXMXNBQO+xHcTc75DsTv+PtdhhLjVHnWcWfRA6zYDg5DWS6n2Q
    ==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=FfsQjiUJ x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=FfsQjiUJ x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965288AbeCHGvY (ORCPT <rfc822;greg@kroah.com>);
        Thu, 8 Mar 2018 01:51:24 -0500
Received: from mail-co1nam03on0091.outbound.protection.outlook.com ([104.47.40.91]:60295
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S935168AbeCHE6J (ORCPT <rfc822;stable@vger.kernel.org>);
        Wed, 7 Mar 2018 23:58:09 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Prakash Kamliya <pkamliya@codeaurora.org>,
        Sharat Masetty <smasetty@codeaurora.org>,
        Rob Clark <robdclark@gmail.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.14 06/67] drm/msm: fix leak in failed get_pages
Thread-Topic: [PATCH AUTOSEL for 4.14 06/67] drm/msm: fix leak in failed
 get_pages
Thread-Index: AQHTtpn4AYlkXotSlkyUcWZrwMv7nA==
Date: Thu, 8 Mar 2018 04:57:33 +0000
Message-ID: <20180308045641.7814-6-alexander.levin@microsoft.com>
References: <20180308045641.7814-1-alexander.levin@microsoft.com>
In-Reply-To: <20180308045641.7814-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0888;7:2AZWA7rd3AEuVBEWwCHSK5r6TpIQpkc19bn2EPe4TKb7z4byx5tJ0viu3Rjhxu3rZkDIcYELhAbCiP2TXMGwiPcUaOxbpP60nlGgAmKNLEOFJ9oDJbSsUFQn1tCqcKBiagAnUh0N11vWnQjfBeqiIOV2txADjj636CWJgHmyAXE8sJEtcJJ2PPs5nezfQcy7B8DEtkyjN0GHXBI1eWom0ddMY0NYZUTx8UFRzvrcBAV6cvvmUZdQe7bw3f0GYW5n;20:XHl4FyvoMaTAXiIkJds0ptHdqh057hYdKcbLJgwST/nsGXA0EAtnU9Z3ykeDrd16bzbqbzVc0ivQgJvSVW/nykpfWZJAtssS5KHPNUAhdOEoGbOGGZiO33/wftoOPbUupBD8GM/f6lt0Z4Dl7Yb/Wsoa5+5O/sdoEGwx/oSE1x4=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 70f9e1a1-be1e-4896-83ae-08d584b12d2d
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0888;
x-ms-traffictypediagnostic: DM5PR2101MB0888:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB0888B790EEEA0C4F6E8A5EBFFBDF0@DM5PR2101MB0888.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(85827821059158);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231220)(944501244)(52105095)(10201501046)(3002001)(6055026)(61426038)(61427038)(6041288)(20161123562045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123560045)(6072148)(201708071742011);SRVR:DM5PR2101MB0888;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0888;
x-forefront-prvs: 060503E79B
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(366004)(346002)(376002)(39380400002)(396003)(189003)(199004)(6116002)(99286004)(2950100002)(6512007)(6666003)(10290500003)(36756003)(5660300001)(106356001)(1076002)(22452003)(39060400002)(3846002)(97736004)(316002)(53936002)(68736007)(105586002)(4326008)(25786009)(54906003)(478600001)(2501003)(186003)(66066001)(76176011)(3280700002)(86362001)(575784001)(14454004)(2900100001)(5250100002)(110136005)(305945005)(7736002)(72206003)(3660700001)(6436002)(2906002)(26005)(6486002)(10090500001)(8676002)(81156014)(107886003)(81166006)(86612001)(6506007)(8936002)(102836004)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0888;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
x-microsoft-antispam-message-info: 8zK1Tt0NOYz1lt6ZwM4WWTJYZK9lpjqWTuqmfZ9ZXZ0N0DSaglUTYt2fUDueIhGSnyJkcuvAsIN4ER6VScLU4CGmtuaucxwD5iRjn6qhD3v7vpVdOFSq8+Rsbuvqva5yIav+YV1msX4tbBwGXtFdxEXFeNRZn4k5kPrTXRcu1wudoNrNRW7s+zFkMC0voo4XnrFdE9uprYKCjXwQOgjt+/W1AZ93YUCasvNYHRGIBzPddf7Qet3L+9YgxBq3EX3fnmEHvKpDqrXLVD3jzXP75/ZwJRDsfobGG6sQC6Va+44mYv/gMVDgmVlR6rfRyY05IKxDShclseIBQguq7FbtGg==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 70f9e1a1-be1e-4896-83ae-08d584b12d2d
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Mar 2018 04:57:33.9965
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0888
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
index ea5bb0e1632c..6e0fb50d0de4 100644
--- a/drivers/gpu/drm/msm/msm_gem.c
+++ b/drivers/gpu/drm/msm/msm_gem.c
@@ -93,14 +93,17 @@ static struct page **get_pages(struct drm_gem_object *o=
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
@@ -135,7 +138,10 @@ static void put_pages(struct drm_gem_object *obj)
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
