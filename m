Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3891259-1521498607-2-11343377643933380790
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES enro, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521498607; b=GQQFVqeWrwLCo7ajlGbaqv4lOAX373TQv+SoWlZmINckAOi
    +1Agv3gYe4GhMmmg5OERAi9e3BwBRbSL6sJ5ALPorWy1lqgnV/epWbFFglwUFhk8
    70f+HblP6ZHz1MZdZYJsVVwUiw/5qXrH6T/qTBZn5gEM1jC8EZ721dCt1zrtOL7w
    kuHTWcXK1nRYdm5qP8t5J5mAd0ky2LuQ/gU4Oe0+X3bJqKMHu9ddnfmIOMCWbrbH
    SusfjyGS2pd5j2ZqT1oqzsUz/es0Lk16T3sUai57yt+2kDZh/w9ux7FdT1XjL+uf
    sNAABzOKOutX/FmGvZFSAcRc/L+nFpgmn0Zc4eg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1521498607; bh=EfvyHP
    JKQG6aSJZL8QAZeqFDqTr3ET3y6lGfB7BuWsc=; b=r1auWpDWLvMR9JVL7u/Jz8
    DITw2lqJb8CMOZHgFu5YUqW/weZYkh3f3gqRuTuWV2BXIBTYb6K6Gv/H32Hx2BNi
    F+gNfOtbqFc1mgIpJ1wLDiD3cOPWDMrFdguVd26b6KxoWCAj2Q6+15xHgNXUkEKP
    ZtpdpCP1QyenccbVIO79A2md0O+Sb2mYKsn9m7ee0ozP7dRBin+WCRKzAVJMUCrQ
    MgnC/C+NZaRBcQbYAIgzF/PJvk3BVZQgtLiU/FoCK5tzqrDywRaJVLMez25LEtQq
    11j5++P6v0AyF72nnkUH//FUxd241tjxfLThDhIFcws7mSomWAyMsaJFT5uwvxZQ
    ==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=YziISiTH x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdduiedvucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffuthffkfhfjghitgfggghsphejsehtqhertddttddunecuhfhrohhmpefurghshhgrucfnvghvihhnuceotehlvgigrghnuggvrhdrnfgvvhhinhesmhhitghrohhsohhfthdrtghomheqnecukfhppedvtdelrddufedvrddukedtrdeijedphedvrdduieekrdehgedrvdehvddpfhgvkedtmeemfegulegsmeejlegvjeemleegvggsmeehugeivdenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeoshhtrggslhgvqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpeejjeeiieenucevlhhushhtvghrufhiiigvpeejie;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=YziISiTH x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdduiedvucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffuthffkfhfjghitgfggghsphejsehtqhertddttddunecuhfhrohhmpefurghshhgrucfnvghvihhnuceotehlvgigrghnuggvrhdrnfgvvhhinhesmhhitghrohhsohhfthdrtghomheqnecukfhppedvtdelrddufedvrddukedtrdeijedphedvrdduieekrdehgedrvdehvddpfhgvkedtmeemfegulegsmeejlegvjeemleegvggsmeehugeivdenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeoshhtrggslhgvqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpeejjeeiieenucevlhhushhtvghrufhiiigvpeejie;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933786AbeCSWaC (ORCPT <rfc822;greg@kroah.com>);
        Mon, 19 Mar 2018 18:30:02 -0400
Received: from mail-by2nam01on0106.outbound.protection.outlook.com ([104.47.34.106]:41792
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S933784AbeCSPsc (ORCPT <rfc822;stable@vger.kernel.org>);
        Mon, 19 Mar 2018 11:48:32 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Archit Taneja <architt@codeaurora.org>,
        Rob Clark <robdclark@gmail.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.15 038/124] drm/msm: Fix NULL deref in
 adreno_load_gpu
Thread-Topic: [PATCH AUTOSEL for 4.15 038/124] drm/msm: Fix NULL deref in
 adreno_load_gpu
Thread-Index: AQHTv5mb5CwE9tlgT02e6XgMUdHekA==
Date: Mon, 19 Mar 2018 15:47:38 +0000
Message-ID: <20180319154645.11350-38-alexander.levin@microsoft.com>
References: <20180319154645.11350-1-alexander.levin@microsoft.com>
In-Reply-To: <20180319154645.11350-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1030;7:sHlOoXUTBFcl+Ac4FmAX7G+xKXFKrygJbM82J+kutZ8JXd1p/7lGhkmMwU85WxiFCaC5tz3g8IBFfB9wIEEjYjqGVt5CFVw842JhrPVSWqRdxSqC8yaKMRZPtQq91VIgsvsrhzGvbH1MywqaYhcvx6y4+UTibP/4X9r6LhLSIROCMBPsUDvFsNoClEvTrXkgk1ssBth12k/6f4slVUvSZKMQaXGafHUYLCMcBD8IxtM08pAkQbXNeHHi5RfIDSmq;20:yyarYxpGhL2JfgSS0tYwyo/hjJor5kMq9hu4cKq+U5WEXoVqpYKYwvViv71YgAqK16IvmpXyYEeLDlYfQS95LFYuX9TG+IGyPmMRQlhbhpLUv8srIUlgPviCO/5tGpnqY8emFa0ImLNWW408UrA4FUsLkPJqQkFGDFXiCgQ80r4=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: cfbea06c-7bfd-4bf3-7638-08d58db0ce5a
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB1030;
x-ms-traffictypediagnostic: DM5PR2101MB1030:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB103070DB8793612B14D58683FBD40@DM5PR2101MB1030.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(85827821059158);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(10201501046)(3231221)(944501300)(52105095)(3002001)(6055026)(61426038)(61427038)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123562045)(20161123558120)(20161123560045)(6072148)(201708071742011);SRVR:DM5PR2101MB1030;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1030;
x-forefront-prvs: 06167FAD59
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(396003)(39380400002)(366004)(346002)(376002)(199004)(189003)(2501003)(6486002)(5250100002)(478600001)(86612001)(102836004)(1076002)(97736004)(575784001)(99286004)(72206003)(6436002)(2906002)(107886003)(66066001)(10090500001)(81166006)(6116002)(81156014)(305945005)(8676002)(86362001)(7736002)(68736007)(54906003)(110136005)(26005)(3846002)(105586002)(3280700002)(316002)(53936002)(8936002)(186003)(39060400002)(76176011)(2900100001)(6506007)(36756003)(10290500003)(2950100002)(22452003)(25786009)(5660300001)(106356001)(3660700001)(4326008)(14454004)(6512007)(6666003)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1030;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: gkESxPIxjxNczPQrvPQUcqmZNtjswRhA5f2MmyiaKKG3GWE3qsIoopM32QOnJ7ofJFBIMy132OGGyViQt/Ui32f3j9VRJECQSHvr1JvEwlLEvSrwNH5jHS49KSOhbY6JEf4lULZifn2N7fiv2iawNkRVvtK4Bg+lias9WeOMppr/9eDeQWstb9wZrKbTW0BC/1pfKyCy9KppSfLfJUmUZ9iFGvpSL6hZ/kLfsPqJipmL2YYtK55vQY9/Kgg+5zVI7TQb+dWIQfsK5OjbSS/ysynalOk6JtVgKqgl8p2f1wC9LNctIPRtBI1pRr6Yyv+XM72GABOiy5lx+P1Sx24UIg==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cfbea06c-7bfd-4bf3-7638-08d58db0ce5a
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2018 15:47:38.6878
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1030
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Archit Taneja <architt@codeaurora.org>

[ Upstream commit 9dcfbc182f1aac0aa5ea194733d21e67dd2ba1fd ]

The msm/kms driver should work even if there is no GPU device specified
in DT. Currently, we get a NULL dereference crash in adreno_load_gpu
since the driver assumes that priv->gpu_pdev is non-NULL.

Perform an additional check on priv->gpu_pdev before trying to retrieve
the msm_gpu pointer from it.

v2: Incorporate Jordan's comments:
- Simplify the check to share the same error message.
- Use dev_err_once() to avoid an error message every time we open the
  drm device fd.

Fixes: eec874ce5ff1 (drm/msm/adreno: load gpu at probe/bind time)

Signed-off-by: Archit Taneja <architt@codeaurora.org>
Acked-by: Jordan Crouse <jcrouse@codeaurora.org>
Signed-off-by: Rob Clark <robdclark@gmail.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/gpu/drm/msm/adreno/adreno_device.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/msm/adreno/adreno_device.c b/drivers/gpu/drm/m=
sm/adreno/adreno_device.c
index 05022ea2a007..bfb3d689f47d 100644
--- a/drivers/gpu/drm/msm/adreno/adreno_device.c
+++ b/drivers/gpu/drm/msm/adreno/adreno_device.c
@@ -125,11 +125,14 @@ struct msm_gpu *adreno_load_gpu(struct drm_device *de=
v)
 {
 	struct msm_drm_private *priv =3D dev->dev_private;
 	struct platform_device *pdev =3D priv->gpu_pdev;
-	struct msm_gpu *gpu =3D platform_get_drvdata(priv->gpu_pdev);
+	struct msm_gpu *gpu =3D NULL;
 	int ret;
=20
+	if (pdev)
+		gpu =3D platform_get_drvdata(pdev);
+
 	if (!gpu) {
-		dev_err(dev->dev, "no adreno device\n");
+		dev_err_once(dev->dev, "no GPU device was found\n");
 		return NULL;
 	}
=20
--=20
2.14.1
