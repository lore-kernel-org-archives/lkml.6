Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3968184-1523242595-5-3003600195133997657
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, URIBL_SBL 1.623,
  URIBL_SBL_A 0.1, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523242595; b=vnf6XuXWuNEmDQUXS0/kbcr9QDs0DpRzGGICtBp1SYhzksvHKf
    bB9mJKb7hnrm/nQz3KwO0j12bhxSx8Kzvnm5kEkXwKYneVc64dk6r2QsHIlclmiN
    Nfww7QikcNKYejw9QzqoVcn4OuJSDekzke9oB4vZY6ugbwFANppyfRwF5gmv/acy
    JfnV9RXwjxCBLoTtAPx1SCYa53tNhrWqd0aLJttn2jhFseQxA+Hkn+vVXXGdCHiu
    c7K+qF55Iu3NEbIaXjgjqnxC1BiZjlDjcvUrm2peH3QWy1W7Msk5LH9dLMy9le6O
    RHoaExVh1wmO6eyY8dBupk563q8vYRZUba8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=fm2; t=1523242595; bh=HMobdrt0ql
    5M/FK0Mt6oweBfHI/eATYMO9Of8B+4YS4=; b=uQiN0T2azZXXdfIYhK8YHt0LR/
    qun96jLGK9qlEF1MUPvrqPpZrMf6u646Oe1w5HlPNOzKzgO3g25TmAvVMgxWZKxJ
    1R2/P+9G4740w+gpMx7z6SU0+kamdZhLedKoGNWrbzRJL7KPr8aSv7aF39lEmfbO
    jIh4iXlziYSKVIkFVfAp0sEM/d+wt+4GO9KpIZb0yqbXsH8M7a7X9UCkx6sKCU6X
    6wxNU6zPtg5i0oqlj2/oPBxIQ2XP4v0NG5xG7Y+BPrwTk3bhPSoGl7WjYR/P4w6B
    ll7msK0KsxqiHlE552hQgGJo3v2Up2tpLK3pGBFVfzao8aOHH3KHEHQQWbgg==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=iaVpEQ/H x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=iaVpEQ/H x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfFqJc+E5P3DyrVwaf6eHxYrOwGcZV3PlnhjwX2twramoayYehKH4lVWc9WpmIiOLwxWkPE7boppMmi8HaJgOHf3IXssLFNgzpNHcOlDbBUTWFu79DpOS
    hpog1n03T7o5+plKCjp6kNIAAHnc+QTc6+j0NBRpA0+BvCWgT4zr+rppf5d5WhE0xMtCSn2rvscVMqdGGfEOWm53hZ5YcCMmRlXjfBSkz/Wzj+nDwd2nJRK7
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=wRwT6uffUbIA:10 a=t_PdEiP4ckcA:10
    a=mw6kJ3eo-EIA:10 a=8nJEP1OIZ-IA:10 a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10
    a=Lf-vpJhqX20A:10 a=1RTuLK3dAAAA:8 a=uTJJjIG0AAAA:8 a=yMhMjlubAAAA:8
    a=VC0O-eKI9ZLkBgtH5m4A:9 a=wPNLvfGTeEIA:10 a=kRpfLKi8w9umh8uBmg1i:22
    a=Oxz5h5Y_mNNx07kSEfs-:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755248AbeDICzk (ORCPT <rfc822;greg@kroah.com>);
        Sun, 8 Apr 2018 22:55:40 -0400
Received: from mail-sn1nam02on0125.outbound.protection.outlook.com ([104.47.36.125]:42928
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1755247AbeDIAZr (ORCPT <rfc822;stable@vger.kernel.org>);
        Sun, 8 Apr 2018 20:25:47 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: Tang Junhui <tang.junhui@zte.com.cn>, Jens Axboe <axboe@kernel.dk>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.14 139/161] bcache: return attach error when no
 cache set exist
Thread-Topic: [PATCH AUTOSEL for 4.14 139/161] bcache: return attach error
 when no cache set exist
Thread-Index: AQHTz5i+OnON5eHjjkaohUxM9Hv7rQ==
Date: Mon, 9 Apr 2018 00:21:47 +0000
Message-ID: <20180409001936.162706-139-alexander.levin@microsoft.com>
References: <20180409001936.162706-1-alexander.levin@microsoft.com>
In-Reply-To: <20180409001936.162706-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0725;7:j9YU6YqV15zEVAUWWllm5vgIparRh/tYW63lR0UIBCT+QZPD0/Z6OE2raxOucJeH1JOWIOWm0vficUIqWkVRUa0biaPy+Al4emLV4fL4oaYacz3tshvCN1aOHAd4ictvobTB4fdc3n9FisuVisNO93y42M8vk94zjq39hjvEY7DOwKk9vnwr91vw4CP2rGrWp8n4bdsbElPZEGIb3kNOMeYcukrmCwD09ql65tqfWWtyFRUztrmdDCunOAcDr5e6;20:Jsf36wRsnmB7rRXXUaOzqt2S0O2PS5AbgCghOJQrtIDW+CTmVnJgJJSTVo1b/6pTRYWP0YO2jHv5TIriTGGxuf5GmO5No8s2VG0iOQ8J/DIecTS+Ap0xM7uMbnpuIiXHJSKmzd/zipiEfGRZTezUYNZWCF4+JP7ABaVz0Edgl7A=
x-ms-office365-filtering-ht: Tenant
X-MS-Office365-Filtering-Correlation-Id: 657a4d41-41fb-41de-3dd4-08d59db06eb6
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0725;
x-ms-traffictypediagnostic: DM5PR2101MB0725:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB0725D7E8A2BB02FA43F018C8FBBF0@DM5PR2101MB0725.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(5005006)(8121501046)(10201501046)(3231221)(944501327)(52105095)(93006095)(93001095)(3002001)(6055026)(61426038)(61427038)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123562045)(20161123558120)(20161123560045)(6072148)(201708071742011);SRVR:DM5PR2101MB0725;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0725;
x-forefront-prvs: 0637FCE711
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39380400002)(346002)(366004)(376002)(396003)(39860400002)(199004)(189003)(6486002)(81166006)(26005)(6512007)(4326008)(6436002)(81156014)(8676002)(97736004)(186003)(36756003)(72206003)(53936002)(107886003)(2906002)(86362001)(76176011)(110136005)(305945005)(10090500001)(486006)(3660700001)(102836004)(5660300001)(14454004)(476003)(86612001)(446003)(99286004)(68736007)(66066001)(11346002)(54906003)(2616005)(1076002)(7736002)(5250100002)(25786009)(8936002)(478600001)(2900100001)(2501003)(3280700002)(105586002)(316002)(106356001)(22452003)(6506007)(3846002)(10290500003)(5890100001)(6116002)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0725;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: DIzkQrNPNtB/uSqgD+zmJPNTuqOcY32/heZWCHXH38niT/+ZMaiICAtPjY1k99m20CbNUQ6YCcXqlSjceqT+vYl0O5rfkeXB+6xR0tC0q0VUW4IdNw/BnVbbYgzu0S9jRPT7hu5hoCafS1jOuQ0H3hKCcxbGGPa4UKK534YWm3NUJDPm/lBsB4ZFNKqX03N40N5+l45PuFMJAS5ai6kQcGo4ZLFV21PIK2cIkJAwK8XDaz3M1JoKhJlGKV0qeZKsypgR2kkWU+GHJllpXUwU0iNbjgUur6nZBVv7VgbHftSAUkFpyIxAdDcid9gCrGPGJgauVhFLj5uB0ClyHeFerfNC7rroXdYGTZJMsKDOmtK9h0FQfXYsJ9NjHfA6CBW7zYgd5GaPPx58EdF41av5C4MwNbCqgsFZHaLrPr4IaQA=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 657a4d41-41fb-41de-3dd4-08d59db06eb6
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2018 00:21:47.1280
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0725
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Tang Junhui <tang.junhui@zte.com.cn>

[ Upstream commit 7f4fc93d4713394ee8f1cd44c238e046e11b4f15 ]

I attach a back-end device to a cache set, and the cache set is not
registered yet, this back-end device did not attach successfully, and no
error returned:
[root]# echo 87859280-fec6-4bcc-20df7ca8f86b > /sys/block/sde/bcache/attach
[root]#

In sysfs_attach(), the return value "v" is initialized to "size" in
the beginning, and if no cache set exist in bch_cache_sets, the "v" value
would not change any more, and return to sysfs, sysfs regard it as success
since the "size" is a positive number.

This patch fixes this issue by assigning "v" with "-ENOENT" in the
initialization.

Signed-off-by: Tang Junhui <tang.junhui@zte.com.cn>
Reviewed-by: Michael Lyle <mlyle@lyle.org>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/md/bcache/sysfs.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/md/bcache/sysfs.c b/drivers/md/bcache/sysfs.c
index 6dd03cf9053b..5d81cd06af00 100644
--- a/drivers/md/bcache/sysfs.c
+++ b/drivers/md/bcache/sysfs.c
@@ -193,7 +193,7 @@ STORE(__cached_dev)
 {
 	struct cached_dev *dc =3D container_of(kobj, struct cached_dev,
 					     disk.kobj);
-	ssize_t v =3D size;
+	ssize_t v;
 	struct cache_set *c;
 	struct kobj_uevent_env *env;
=20
@@ -270,6 +270,7 @@ STORE(__cached_dev)
 		if (bch_parse_uuid(buf, set_uuid) < 16)
 			return -EINVAL;
=20
+		v =3D -ENOENT;
 		list_for_each_entry(c, &bch_cache_sets, list) {
 			v =3D bch_cached_dev_attach(dc, c, set_uuid);
 			if (!v)
@@ -277,7 +278,7 @@ STORE(__cached_dev)
 		}
=20
 		pr_err("Can't attach %s: cache set not found", buf);
-		size =3D v;
+		return v;
 	}
=20
 	if (attr =3D=3D &sysfs_detach && dc->disk.c)
--=20
2.15.1
