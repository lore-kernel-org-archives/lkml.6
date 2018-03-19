Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3907919-1521499137-2-4809891569823340148
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
    t=1521499136; b=sFDLhGHm/Md/pv0Cj3XywSYeo8PjKIPxnwSRTiqYiuvs4tj
    /TAlecheiw+zaC8Z7RoPtu4j5Pyj8aFXLiG0HnO2LUAq7qjxSd+4rkMjTItPNDWi
    GFy0HqrsD/yBRHT8R/Gj0E9uOiewUBGwizEfqrNaojHILfUb4cjzi5EDyJKajBfe
    J3Bb1PPqg69/TBXZA/22UyyMR5jxQ1SXnqTz5DGg/yCzelfut+e+rovpKc3fxj2X
    qNZ/7OR7pyWFigJxgDlvVBoa3a2n+UpYcV8e4FHK5x6LbovgZtD3YHoQogxdfOjV
    FJ4HZuhKSH8QdF/+FYuhtVv6c+X1y32fXdLNPiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1521499136; bh=jKRPTK
    9J/fiTzn2zmGh2sk/J4pJpAFWG01gQvpZ3LkE=; b=L2A4zVZovtpQgj8Mf4fAnk
    Gf0ahd6E/UovmCr1yq0uvQlwzN4oRF5lpAjzU2uG1JuoDyaOaolbyVNNrLBQnlQw
    UcTF8DK0WX0MpdqkGaKpH9AbNw/z96eGVy8sno+iOXv9oa2TQzKiyUfLZ8b4WJjr
    ln40e1oQ3AB2MgFjj9r+FTKKHBNTc3VV52jqDXr/nd393+v0fNMeUnMpQnn7j7eC
    oiOW+mDn1CSeHu0fFfiitgVQ9Uo45X3CPgJ1iCRZEGOK1jYu9zThpBo3L6M6RUOr
    cvEGObWhEnB9Ap0jJPOVb6E/u6+D7nSZk61/Jomo2cUt6I73kor2p6BTA3DOTF7w
    ==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=YOQWOUAi x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudegucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffuthffkfhfjghitgfggghsphejsehtqhertddttddunecuhfhrohhmpefurghshhgrucfnvghvihhnuceotehlvgigrghnuggvrhdrnfgvvhhinhesmhhitghrohhsohhfthdrtghomheqnecukfhppedvtdelrddufedvrddukedtrdeijedphedvrdduieekrdehgedrvdehvddpfhgvkedtmeemfegulegsmeejlegvjeemleegvggsmeehugeivdenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeoshhtrggslhgvqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpeejhedtjeenucevlhhushhtvghrufhiiigvpeeftd;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=YOQWOUAi x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudegucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffuthffkfhfjghitgfggghsphejsehtqhertddttddunecuhfhrohhmpefurghshhgrucfnvghvihhnuceotehlvgigrghnuggvrhdrnfgvvhhinhesmhhitghrohhsohhfthdrtghomheqnecukfhppedvtdelrddufedvrddukedtrdeijedphedvrdduieekrdehgedrvdehvddpfhgvkedtmeemfegulegsmeejlegvjeemleegvggsmeehugeivdenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeoshhtrggslhgvqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpeejhedtjeenucevlhhushhtvghrufhiiigvpeeftd;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1032618AbeCSWhp (ORCPT <rfc822;greg@kroah.com>);
        Mon, 19 Mar 2018 18:37:45 -0400
Received: from mail-cys01nam02on0090.outbound.protection.outlook.com ([104.47.37.90]:61852
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S933456AbeCSPrf (ORCPT <rfc822;stable@vger.kernel.org>);
        Mon, 19 Mar 2018 11:47:35 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: "Gustavo A. R. Silva" <garsilva@embeddedor.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.15 026/124] PM / devfreq: Fix potential NULL
 pointer dereference in governor_store
Thread-Topic: [PATCH AUTOSEL for 4.15 026/124] PM / devfreq: Fix potential
 NULL pointer dereference in governor_store
Thread-Index: AQHTv5mUC4G7QjqkmU+d9/2pNkDkWg==
Date: Mon, 19 Mar 2018 15:47:25 +0000
Message-ID: <20180319154645.11350-26-alexander.levin@microsoft.com>
References: <20180319154645.11350-1-alexander.levin@microsoft.com>
In-Reply-To: <20180319154645.11350-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0998;7:Rh7eZrwMHT7iQdbYYLM/wST67Wk3g6D23cU6na35aDAmM8ihGS2Suxz7fzvx45pzZTD2MNZC0Z0HAacVgX9+F+0NVPO3ySsh6R632VPgKyQXSnPIcAHq0x7q4XTGMPm77YZFRUQQWAGIEUypVa/OQ6NH6g2iD1S8z90WIVg1uufL3inTEqinw5Md30l1u1VxtsSXUpMRMWBedbHnpGhZg8bct6Gc8x/q+6tg6oMVR/fmo4wXfa5ON7lb5MXLT7VC;20:B/7iNB9yRDpyJOoBeP+FE6TxvM6CFIqG+T4xcaPEIakvGUMJRbxBQqvnlj1OhGWlPJGx5LfxrIFPxO8hEeF3jUX1E61+qGBy8slxXzDB6mVtQ+9xe9Si8s6wfwmM5124fHmwP8OWP6CteMAfP5ZpmCQjJaSBcwKUwOOcFnuVG2Y=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 84912e9d-e6e7-4393-0af5-08d58db0b875
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0998;
x-ms-traffictypediagnostic: DM5PR2101MB0998:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB0998C5DEC32A4E6B7E88111CFBD40@DM5PR2101MB0998.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(7411616537696);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(10201501046)(3231221)(944501300)(52105095)(3002001)(6055026)(61426038)(61427038)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123562045)(20161123558120)(20161123560045)(6072148)(201708071742011);SRVR:DM5PR2101MB0998;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0998;
x-forefront-prvs: 06167FAD59
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39380400002)(39860400002)(366004)(376002)(396003)(346002)(199004)(189003)(3846002)(6116002)(8936002)(6486002)(102836004)(68736007)(6506007)(2900100001)(22452003)(25786009)(3660700001)(7736002)(76176011)(6512007)(72206003)(86362001)(53936002)(8676002)(81156014)(6436002)(81166006)(305945005)(478600001)(99286004)(2950100002)(14454004)(6666003)(10290500003)(186003)(107886003)(2501003)(106356001)(26005)(86612001)(97736004)(5660300001)(10090500001)(110136005)(54906003)(316002)(2906002)(66066001)(105586002)(4326008)(36756003)(3280700002)(1076002)(5250100002)(59450400001)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0998;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: xi0cg7V+CN+x7+WL2rKQW6VCQUPOX95Nq3PLXR1RQffPjBJPFBfiy2eeOL6prZk5rpQjhcCA/LcoBPcWT9YHV8krpVnQT9F7zpsfg2FrqlybLBtEzYNIWtSKIAcGR3KdLIu2eiHNYE0+NQXt/l/LpYrZqy3E0x+t9exrnRHbr91e7iEKqxJAzGe2aronxl2wNwDlnRytnGcZN2L/AoPPeB40akx4uXyV1a2GxQ2XVSc6cL6JTpgHeRG+gN05fyJ2SqQgXruCDsLmrrITntPjrETVnyJt+Wi8rcvG3Y1Z7t9c/kyVlWI52/6aUqHcPLv4fyH4JAUVFGCmWIKk15mhag==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 84912e9d-e6e7-4393-0af5-08d58db0b875
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2018 15:47:25.8869
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0998
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: "Gustavo A. R. Silva" <garsilva@embeddedor.com>

[ Upstream commit 63f1e05f7fe9ca509c60154d6a833abf96eecdc9 ]

df->governor is being dereferenced before it is null checked,
hence there is a potential null pointer dereference.

Notice that df->governor is being null checked at line 1004:
if (df->governor) {, which implies it might be null.

Fix this by null checking df->governor before dereferencing it.

Addresses-Coverity-ID: 1401988 ("Dereference before null check")
Fixes: bcf23c79c4e4 ("PM / devfreq: Fix available_governor sysfs")
Signed-off-by: Gustavo A. R. Silva <garsilva@embeddedor.com>
Reviewed-by: Chanwoo Choi <cw00.choi@samsung.com>
Signed-off-by: MyungJoo Ham <myungjoo.ham@samsung.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/devfreq/devfreq.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
index 99c4021fc33b..fe2af6aa88fc 100644
--- a/drivers/devfreq/devfreq.c
+++ b/drivers/devfreq/devfreq.c
@@ -996,7 +996,8 @@ static ssize_t governor_store(struct device *dev, struc=
t device_attribute *attr,
 	if (df->governor =3D=3D governor) {
 		ret =3D 0;
 		goto out;
-	} else if (df->governor->immutable || governor->immutable) {
+	} else if ((df->governor && df->governor->immutable) ||
+					governor->immutable) {
 		ret =3D -EINVAL;
 		goto out;
 	}
--=20
2.14.1
