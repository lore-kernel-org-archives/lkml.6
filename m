Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3763980-1521494158-2-197741011703934867
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
    t=1521494157; b=I33r+s8ouL6kBUsvxjUeXNR+n4CMgdplw02yxHPNMzmlic/
    HUVHxS7Lg7tkIaTp2+muNLxYZD7YYYKrzMaav6MgWni3YLx9O2dS1J6l1ZcGxg/i
    W3Jm9ZLigceClbEVazvrkZjPtEpsg4kuTeubOPa9EqP1Tzme0Dv13kwByE4+D3gw
    44N0qWP1SLWG/Wyd3zH5YpJjF13Q+CTmPG6hvMDoSswjLLQnpl9EWMfD7jYCbS86
    0vPz0uJS9Q0+OWW54XdFRhQ70wpHxmFQlJ6zLZ1qoMH5e0nAHil92tfLxfuJhbqJ
    YZDTa+lkYzCCbgUGQjgiWG/ONH2tGpZ/Fwe50Sw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1521494157; bh=jQiP1V
    Y8knZE0d9Dl3wNHAaRXq2QTY2/dVyXP2dceSE=; b=MfKO+2LoKdHRZumUZgsXpL
    KyUxP4qqnX6NwDGHOQ1xwYsqdI6SpOKfsN0BrvsmXyQIBN75+4Ev5EuH5Z5QZSmC
    q2CkKXCrjOSqgU7wtjXeT4HL1pbekAhs8KaK4vUkTrjfH25eQILwR7GcNI/4HMZD
    4q0cJ8GDz/E9rEOht493GdI43ZwrK4G50paxiRB7w2rYxLjltmZgfoKXe/MQkIIN
    63AWrXw3P+SPwar+qIlPZOKwkq3ZonYYTZ2LRp+QKEitwKaEc4a7E2HAcmt1iGTw
    No8pbg6rA1z6qtflgW68mIAttdo1cugikdTgiX69wbKwwcQPEqS2/jWkOutYg9KA
    ==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=c7hcIv3O x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgddugeekucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffuthffkfhfjghitgfggghsphejsehtqhertddttddunecuhfhrohhmpefurghshhgrucfnvghvihhnuceotehlvgigrghnuggvrhdrnfgvvhhinhesmhhitghrohhsohhfthdrtghomheqnecukfhppedvtdelrddufedvrddukedtrdeijedphedvrdduieekrdehgedrvdehvddpfhgvkedtmeemfegulegsmeejlegvjeemleegvggsmeehugeivdenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeoshhtrggslhgvqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpeejiedvheenucevlhhushhtvghrufhiiigvpedvie;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=c7hcIv3O x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgddugeekucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffuthffkfhfjghitgfggghsphejsehtqhertddttddunecuhfhrohhmpefurghshhgrucfnvghvihhnuceotehlvgigrghnuggvrhdrnfgvvhhinhesmhhitghrohhsohhfthdrtghomheqnecukfhppedvtdelrddufedvrddukedtrdeijedphedvrdduieekrdehgedrvdehvddpfhgvkedtmeemfegulegsmeejlegvjeemleegvggsmeehugeivdenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeoshhtrggslhgvqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpeejiedvheenucevlhhushhtvghrufhiiigvpedvie;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965488AbeCSVPo (ORCPT <rfc822;greg@kroah.com>);
        Mon, 19 Mar 2018 17:15:44 -0400
Received: from mail-dm3nam03on0113.outbound.protection.outlook.com ([104.47.41.113]:15552
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S965326AbeCSQBS (ORCPT <rfc822;stable@vger.kernel.org>);
        Mon, 19 Mar 2018 12:01:18 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Jordan Crouse <jcrouse@codeaurora.org>,
        Rob Clark <robdclark@gmail.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.9 120/281] drm/msm: Take the mutex before
 calling msm_gem_new_impl
Thread-Topic: [PATCH AUTOSEL for 4.9 120/281] drm/msm: Take the mutex before
 calling msm_gem_new_impl
Thread-Index: AQHTv5tfE+gH+Qd6/kupza1e37Jvuw==
Date: Mon, 19 Mar 2018 16:00:16 +0000
Message-ID: <20180319155742.13731-120-alexander.levin@microsoft.com>
References: <20180319155742.13731-1-alexander.levin@microsoft.com>
In-Reply-To: <20180319155742.13731-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1015;7:qKsJF69dScngKxURhT/aFujVGdDRCbbTZvUm/gJJFDs8UXmTE7X1xQgJiSiuRms/MaJfPFOtdFC+qry2/EjmOFZynA9ZHwrxrkMMnf8uL60OxIgboyMADrDs7oXH0iqSJvxyMUcL0PRfWKKBeO9d1kVkEvlOZCFuGLx6nEyw/9FXP1er2QnKCNjCNwpz+SXbnXzBItQoDt0J4tP8uHeN21dk0gF2Yuc89xntj5Qg6MwtU819Vinw5mFBNCO3TPv2;20:yZgYOn1s/N8MKw269UfjF5F+JAVvP+zJVB5M1F7qaIcZNdG2hEIJqHCl2KXgQSZgbSyzP5SaBe+3IlRIr4qnDA6aAhfKWxFSmJ6XJR4jcm3HMA4skYJVQ3dQP5bD2xjdM8sw1xdZG9XSMrJuLD0Mz3PjsCEeywhvM99Lj4aQIjI=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 6ab4c620-f1da-4ba0-54f6-08d58db2a18c
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB1015;
x-ms-traffictypediagnostic: DM5PR2101MB1015:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB1015088A2CBA99210705BE8EFBD40@DM5PR2101MB1015.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(85827821059158);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(10201501046)(3231221)(944501300)(52105095)(3002001)(6055026)(61426038)(61427038)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123562045)(20161123558120)(20161123560045)(6072148)(201708071742011);SRVR:DM5PR2101MB1015;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1015;
x-forefront-prvs: 06167FAD59
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(346002)(376002)(39380400002)(39860400002)(366004)(189003)(199004)(97736004)(72206003)(4326008)(99286004)(2900100001)(39060400002)(1076002)(186003)(10290500003)(36756003)(25786009)(66066001)(86612001)(102836004)(54906003)(110136005)(26005)(86362001)(53936002)(5660300001)(6512007)(14454004)(478600001)(106356001)(107886003)(316002)(2950100002)(6666003)(22452003)(6506007)(7736002)(3280700002)(3660700001)(305945005)(8936002)(2906002)(6116002)(3846002)(6436002)(68736007)(2501003)(5250100002)(6486002)(10090500001)(76176011)(8676002)(81156014)(105586002)(81166006)(59450400001)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1015;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: R7eEJ4fy+gcnQKdAnWY1DhNim9aqNXoDvF+aKAJ98VQS6bKUjZBDmQm+/u9nG+spKqA9ra4+AeShGgLueDVTo31bxrQjhy0Z1Fi7B58d1o2nKysnfHhd8uNn7Nt7WuCJBobPFRWyOLYX2Y/WpSYRtwU5IfZrQYQZYvp8NX9Bc6lKekkVsAfImwoQYgpq8kJLRL9lLlVaP/z/HRwwyfaN+WXsK1z/REyrw3ux1rVsB4c19EgSCqhKQuKg4uvU9ZFaOGKaZkGa1RX+wZ1Bvcq5B7X/PqzImoJTQMVDhBBsvtrUIzHABQK8i2D6vKWoehdMzpD71tg/kuuhL+A/a4Lfjw==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6ab4c620-f1da-4ba0-54f6-08d58db2a18c
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2018 16:00:16.2123
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1015
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Jordan Crouse <jcrouse@codeaurora.org>

[ Upstream commit 90dd57de4a043f642179b1323a31ca3ced826611 ]

Amongst its other duties, msm_gem_new_impl adds the newly created
GEM object to the shared inactive list which may also be actively
modifiying the list during submission.  All the paths to modify
the list are protected by the mutex except for the one through
msm_gem_import which can end up causing list corruption.

Signed-off-by: Jordan Crouse <jcrouse@codeaurora.org>
[add extra WARN_ON(!mutex_is_locked(&dev->struct_mutex))]
Signed-off-by: Rob Clark <robdclark@gmail.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/gpu/drm/msm/msm_gem.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/gpu/drm/msm/msm_gem.c b/drivers/gpu/drm/msm/msm_gem.c
index b6ac27e31929..7f488cd6130a 100644
--- a/drivers/gpu/drm/msm/msm_gem.c
+++ b/drivers/gpu/drm/msm/msm_gem.c
@@ -764,6 +764,8 @@ static int msm_gem_new_impl(struct drm_device *dev,
 	unsigned sz;
 	bool use_vram =3D false;
=20
+	WARN_ON(!mutex_is_locked(&dev->struct_mutex));
+
 	switch (flags & MSM_BO_CACHE_MASK) {
 	case MSM_BO_UNCACHED:
 	case MSM_BO_CACHED:
@@ -857,7 +859,11 @@ struct drm_gem_object *msm_gem_import(struct drm_devic=
e *dev,
=20
 	size =3D PAGE_ALIGN(dmabuf->size);
=20
+	/* Take mutex so we can modify the inactive list in msm_gem_new_impl */
+	mutex_lock(&dev->struct_mutex);
 	ret =3D msm_gem_new_impl(dev, size, MSM_BO_WC, dmabuf->resv, &obj);
+	mutex_unlock(&dev->struct_mutex);
+
 	if (ret)
 		goto fail;
=20
--=20
2.14.1
