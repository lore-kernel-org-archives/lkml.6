Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1576794-1517682427-2-16249216490844854095
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES endasv, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1517682426; b=VPYnyNV9jXa/eq7REiq96DevLFEMV2KJf7ue8StV9B5m0La
    sj3geNQC23gM0pU3QhnjXLQtgh7jgl7wS1Jw9O6Mci6IleToR5mx7MUd9frPk6BH
    nI7jBJPSG/GfYX2dDeb2aT11T7d/gpOt6p2108XoGdbxxZJ8bh8p4xzY3N02igDI
    7S9P/wzAc1sRHXIvVogU3nuPrdkFSwqwUA4ou0tt2ADRmAqJ6Gt0TsZWGtZPztmW
    FDap//iIGcnyGUHGyDBWsb3jVHu4VEFdmIYYw6zfp0fM/AbswYX7wJN6T6Qj6B16
    meJct48uwZvc0gt9AfBeKmWTniQGdZVElpvg1yQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1517682426; bh=73PvPJ
    9EERmzcCxZKTZ65Z+eWpslxSIpn+bvmBNEE10=; b=dKgkhpV14Q6ry0C+JCYRU0
    5mdhshL8duGvhM7gcH6YQhvFj28BinQ7k54ghcsLfwXgH+qTHXZ9EiEzEGs50CWD
    RN0YObXqRvrKfGgMDhFqEzFQ3VzyBmrec0wcyeSGgHfBEbObsrMGIxeLbpGN1H/V
    ztcowMTwww7iw6qbUMMPWRbYdXcdB69NjCbCafmrxaleC5ZQs15MfiFXpGSYzjP0
    R11+kQ4mOFYslSmCXEFUiRhEiDyi+OI9Z3h4jQwkfpGyS2AXan1v2Ou0RIRhpH5g
    kj+goXQn+7538eZ/GrWz8xKqN6mfofhWHBJwpIgvWQXYdBR0hy36/EazdPga9Gag
    ==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=dw8Dm4QQ x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=dw8Dm4QQ x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754427AbeBCSXt (ORCPT <rfc822;greg@kroah.com>);
        Sat, 3 Feb 2018 13:23:49 -0500
Received: from mail-bl2nam02on0091.outbound.protection.outlook.com ([104.47.38.91]:45338
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753205AbeBCSGV (ORCPT <rfc822;stable@vger.kernel.org>);
        Sat, 3 Feb 2018 13:06:21 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Al Viro <viro@zeniv.linux.org.uk>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 3.18 04/24] sget(): handle failures of
 register_shrinker()
Thread-Topic: [PATCH AUTOSEL for 3.18 04/24] sget(): handle failures of
 register_shrinker()
Thread-Index: AQHTnRmBy5dMhe8E80GfYWTEhAGqGA==
Date: Sat, 3 Feb 2018 18:04:59 +0000
Message-ID: <20180203180444.10801-4-alexander.levin@microsoft.com>
References: <20180203180444.10801-1-alexander.levin@microsoft.com>
In-Reply-To: <20180203180444.10801-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BL0PR2101MB0993;7:UZ4M28RywibYI34Vus8iPBoKpxhhuctkhFlM9H2sVZZtMVgIJLGCoF8KQqgDCnpE8I4vBOCrl2xhm9H4hIvCmYl5vCAWwRTwPu8WEST6BGw/sDfbEotw0xiUdgaHneH6OZtMbiR4/jRn+SzmbNh9Raji+90IT4gXHk3mGivBXHbjRuniDZfcoE+BNomlZvkv2YihPYinKwY54TrGPrpMzfOMc5JUl//Rt21Rv/LGIHPJIIUtqxjZ7EG2cgODc75S
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: d0d1cbf3-5cab-4856-689f-08d56b30cb25
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(4604075)(3008032)(2017052603307)(7193020);SRVR:BL0PR2101MB0993;
x-ms-traffictypediagnostic: BL0PR2101MB0993:
x-microsoft-antispam-prvs: <BL0PR2101MB099367C003C79FA0735ACDEAFBF80@BL0PR2101MB0993.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(61425038)(6040501)(2401047)(5005006)(8121501046)(3002001)(10201501046)(3231101)(2400082)(944501161)(93006095)(93001095)(6055026)(61426038)(61427038)(6041288)(20161123558120)(20161123560045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(6072148)(201708071742011);SRVR:BL0PR2101MB0993;BCL:0;PCL:0;RULEID:;SRVR:BL0PR2101MB0993;
x-forefront-prvs: 05724A8921
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(39380400002)(39860400002)(376002)(366004)(396003)(189003)(199004)(6436002)(186003)(3660700001)(8936002)(105586002)(2906002)(6346003)(6116002)(3280700002)(3846002)(97736004)(6486002)(1076002)(2950100002)(6666003)(81156014)(86362001)(76176011)(102836004)(2501003)(5250100002)(26005)(68736007)(10090500001)(81166006)(8676002)(59450400001)(53936002)(5660300001)(22452003)(305945005)(107886003)(7736002)(4326008)(86612001)(36756003)(99286004)(316002)(6512007)(10290500003)(72206003)(6506007)(14454004)(478600001)(25786009)(106356001)(2900100001)(54906003)(110136005)(66066001)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:BL0PR2101MB0993;H:BL0PR2101MB1027.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-message-info: 8CcyLsUvSzmFFJ+p5cc3tXWQ68XAuiXlN9ZwZ3pDyIeB68W3V+qTwVoibmRFPtduvmfDaQfr2tbGQY1fRiqXKg==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d0d1cbf3-5cab-4856-689f-08d56b30cb25
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Feb 2018 18:04:59.3777
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR2101MB0993
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Al Viro <viro@zeniv.linux.org.uk>

[ Upstream commit 9ee332d99e4d5a97548943b81c54668450ce641b ]

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 fs/super.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/fs/super.c b/fs/super.c
index 19fafe86071a..d4731c401278 100644
--- a/fs/super.c
+++ b/fs/super.c
@@ -476,7 +476,11 @@ retry:
 	hlist_add_head(&s->s_instances, &type->fs_supers);
 	spin_unlock(&sb_lock);
 	get_filesystem(type);
-	register_shrinker(&s->s_shrink);
+	err =3D register_shrinker(&s->s_shrink);
+	if (err) {
+		deactivate_locked_super(s);
+		s =3D ERR_PTR(err);
+	}
 	return s;
 }
=20
--=20
2.11.0
