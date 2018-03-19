Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3293580-1521478454-2-12006423483543856728
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
    t=1521478453; b=mQwZ0/eDxf3ujLRtI4uah4pd07n+f3iy5dIv8dNagyiF73s
    dUXxVLRG1ucR6svGNpJYKC5Np80xannjqFbfaJe4oAOHknBzpD1rFCdjNz961MQf
    ZF2SXddycwzI1gdj2CdgXpdTLfsYSfBLh+GEG+xlORnsH8kg4pJ9+GlwC/J8uYrY
    YJIpODmMMZ+I6I8/32kd1frMXA7SUSfBEDUdbLjtYPq1YCgmVnwOQvX6cCtp/qRJ
    PKbpXJX2VPtD5WjWwmv9XDG87cBM+mgEbRhAmuHgc5joGSqoTNvFt0jgtu5I+9ys
    Aexk7oeXxTuh4l/TBlFOvHJvg8qrW0j3EIsInUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1521478453; bh=yal4zH
    It5uGxLPt6BtyTiRyQTL2706c3Jfa2/JJNt7A=; b=VXk6obFR9hSXiS4/Ig8i8l
    fcWke+J7Ni66pEEg6/Lnzb5R+e3DqRdalaiHx2zgbbrSjlYQjb+WLNynBtwk5LA8
    NcpFuu21hGtcCYBwVr9WSTwIZC+nh15bkyERuRNPIkljtMdV69W9SwEv+5xBiIYF
    CJ+8lkkGW2FbjIji94Fr5uU7+6Nr3GKfW0I1e/1BPD9ZChyR7fnrYO8d+ZILketp
    ZuGTtcV4Gu23/Yaci1+QYBsKxv7akPnp/ooF5jW6l57GtORh5JBgM9kWUXvVjbfC
    4CLVC65adwNhn6MBvOOTiDfvSJzEpY265FFI2/kvTBSYQk8u5ZAUMmUijcreLsFA
    ==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=ky2kuUdV x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdelgeculddtuddrgedtfedrtddtmdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvufhtfffkfhgjihgtgfggshhpjeesthhqredttddtudenucfhrhhomhepufgrshhhrgcunfgvvhhinhcuoeetlhgvgigrnhguvghrrdfnvghvihhnsehmihgtrhhoshhofhhtrdgtohhmqeenucfkphepvddtledrudefvddrudektddrieejpdehvddrudeikedrheegrddvhedvpdhfvgektdemmeefugelsgemjeelvgejmeelgegvsgemheguiedvnecurfgrrhgrmhepihhnvghtpedvtdelrddufedvrddukedtrdeijedphhgvlhhopehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhmrghilhhfrhhomhepoehsthgrsghlvgdqohifnhgvrhesvhhgvghrrdhkvghrnhgvlhdrohhrghequceuqfffjgepkeeukffvoffkoffgucfukfgkgfepjedvheefnecuvehluhhsthgvrhfuihiivgeptd;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=ky2kuUdV x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdelgeculddtuddrgedtfedrtddtmdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvufhtfffkfhgjihgtgfggshhpjeesthhqredttddtudenucfhrhhomhepufgrshhhrgcunfgvvhhinhcuoeetlhgvgigrnhguvghrrdfnvghvihhnsehmihgtrhhoshhofhhtrdgtohhmqeenucfkphepvddtledrudefvddrudektddrieejpdehvddrudeikedrheegrddvhedvpdhfvgektdemmeefugelsgemjeelvgejmeelgegvsgemheguiedvnecurfgrrhgrmhepihhnvghtpedvtdelrddufedvrddukedtrdeijedphhgvlhhopehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhmrghilhhfrhhomhepoehsthgrsghlvgdqohifnhgvrhesvhhgvghrrdhkvghrnhgvlhdrohhrghequceuqfffjgepkeeukffvoffkoffgucfukfgkgfepjedvheefnecuvehluhhsthgvrhfuihiivgeptd;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935113AbeCSQx4 (ORCPT <rfc822;greg@kroah.com>);
        Mon, 19 Mar 2018 12:53:56 -0400
Received: from mail-sn1nam01on0104.outbound.protection.outlook.com ([104.47.32.104]:3838
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S935058AbeCSQLo (ORCPT <rfc822;stable@vger.kernel.org>);
        Mon, 19 Mar 2018 12:11:44 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Steffen Klassert <steffen.klassert@secunet.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 3.18 003/102] af_key: Fix slab-out-of-bounds in
 pfkey_compile_policy.
Thread-Topic: [PATCH AUTOSEL for 3.18 003/102] af_key: Fix slab-out-of-bounds
 in pfkey_compile_policy.
Thread-Index: AQHTv5zvKVcMLgwXVEmO3eYy8y6aHQ==
Date: Mon, 19 Mar 2018 16:11:27 +0000
Message-ID: <20180319161117.17833-3-alexander.levin@microsoft.com>
References: <20180319161117.17833-1-alexander.levin@microsoft.com>
In-Reply-To: <20180319161117.17833-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0805;7:TXghnMjPDb/LJZPeWKv8GbzhqySY/hGagoI1xw0t4ZbZ0qzwFN6X6CR3ESplwCts2VBS40QHkH15j9v3EGM4cCfMWTspxpkX+Za5diG/KVI4WdyidpRd+UvnRnYxMBilPuPfEYsR9mfsVgileqcRL3m1Or99M0mXDnrn2kL+DXzmFnHUtgBmldAJmVceyN1tqBf6R8tQILPgrIMWAJPZdh+o8F5++10XXhTFAEyOzqduhhgnlwPm4daRrShuP8Wr;20:xU2W7U3joZIfni4EJYstIOr69PJJuoIDM+aSUdbJGAIgVHGn3anOjSUBOicafJk4aTCLhqU8Ic58KWRWFhWO4wEbf/xmaDRjRcNnQCXsw8tsg5N9KykfuKhbrLaR7LvTTw44C5A+49l9z4VJBVr4cBnPuwhsEq81a7Y6S3WyBqM=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 75a94603-ded8-4831-ea49-08d58db413e3
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0805;
x-ms-traffictypediagnostic: DM5PR2101MB0805:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB0805F0952945C8AEE6C419AAFBD40@DM5PR2101MB0805.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(192374486261705)(211936372134217)(153496737603132);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(10201501046)(3231221)(944501300)(52105095)(3002001)(6055026)(61426038)(61427038)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123562045)(20161123558120)(20161123560045)(6072148)(201708071742011);SRVR:DM5PR2101MB0805;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0805;
x-forefront-prvs: 06167FAD59
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39380400002)(376002)(346002)(366004)(396003)(39860400002)(199004)(189003)(575784001)(2950100002)(305945005)(186003)(86362001)(6506007)(3660700001)(6666003)(5660300001)(6116002)(8936002)(3846002)(1076002)(26005)(7736002)(6486002)(2900100001)(6436002)(2906002)(86612001)(68736007)(81166006)(81156014)(10090500001)(102836004)(59450400001)(8676002)(14454004)(105586002)(107886003)(25786009)(478600001)(2501003)(5250100002)(53936002)(3280700002)(316002)(54906003)(4326008)(6512007)(72206003)(66066001)(22452003)(10290500003)(99286004)(76176011)(36756003)(97736004)(106356001)(110136005)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0805;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: diAe0LCVZsnakdt5FTzl7ir3nyUer2WoWWxBk4Pdu6kZLMtHVfN5J6cxK+KYJmnWWe2UZNVXe+GYCQLGIdAQQJUR6yCxPe8tfJUB8vA6pLwwgJ5jn1hoQdzt/V7Agw50rhXS+78BCz6S4z/ZL99u14PPIsuKQbPa4G41ON8c9/ScAqZpqurb48kD5B29Gu7UBPsDAQzMOCAG0jPOFQsCy/hnvSMSIQ2oxazwOH8nF324JGn7f9bQAL6wwk5nUYgvuZ9f0Eeh8pTHdKSYVR4g+5hXhsNqDpoLvND8h1sqVyLaRWZbdgitfWhCZrOYa5YruuOPwkmPc1xDStp8zArWhA==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 75a94603-ded8-4831-ea49-08d58db413e3
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2018 16:11:27.1018
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0805
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Steffen Klassert <steffen.klassert@secunet.com>

[ Upstream commit d90c902449a7561f1b1d58ba5a0d11728ce8b0b2 ]

The sadb_x_sec_len is stored in the unit 'byte divided by eight'.
So we have to multiply this value by eight before we can do
size checks. Otherwise we may get a slab-out-of-bounds when
we memcpy the user sec_ctx.

Fixes: df71837d502 ("[LSM-IPSec]: Security association restriction.")
Reported-by: Andrey Konovalov <andreyknvl@google.com>
Tested-by: Andrey Konovalov <andreyknvl@google.com>
Signed-off-by: Steffen Klassert <steffen.klassert@secunet.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 net/key/af_key.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/key/af_key.c b/net/key/af_key.c
index 65cce8ceaead..64dbf0dbe358 100644
--- a/net/key/af_key.c
+++ b/net/key/af_key.c
@@ -3301,7 +3301,7 @@ static struct xfrm_policy *pfkey_compile_policy(struc=
t sock *sk, int opt,
 		p +=3D pol->sadb_x_policy_len*8;
 		sec_ctx =3D (struct sadb_x_sec_ctx *)p;
 		if (len < pol->sadb_x_policy_len*8 +
-		    sec_ctx->sadb_x_sec_len) {
+		    sec_ctx->sadb_x_sec_len*8) {
 			*dir =3D -EINVAL;
 			goto out;
 		}
--=20
2.14.1
