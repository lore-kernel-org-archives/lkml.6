Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3643807-1523234621-2-2490487833160397233
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, URIBL_SBL 1.623, URIBL_SBL_A 0.1, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523234621; b=ej+D/Eon80l10By5gPhJYa+TPutRy9nCBhuQ5fXDYV9PvWwpOg
    6dsZ0pUD1I4MnPMMBe9A1ExeRlJT6HLBtorzZe3etettsmeRLJabzGtqrG8L5AUq
    YYihyGvZy7uSIpIF/qIikuBxemyeRalQD3X9Pu73OGIU6+JL0CIpRe6OteEldees
    2W7zJwhgrW5b7Qmr++D3xKeQp1TR316zayJlPfGZp61HE48na5Hjnj5O2t0aqqER
    iEfaW0x483oU+B/KfSdqc89z+7bMuigpjOXfrU2k15Vr3s9BFS4JojLoNRoj/0PJ
    HB1aFiTeYT+j1cqghYmPAcg+3pijmvzUvMpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=fm2; t=1523234621; bh=wCF5xedl4b
    k9Kp7ZNoXBnhr0mw8rHfU3HqTN0oToiec=; b=ZxnIALkzikStwvO+OcWiJx8Kq6
    7hRo4gCj7w2VphKZ4pSmiFsYKW0yGZsdY3hwaQxEHeQ+lEVcLuEtsdvBfvXzG8US
    h5aDy7NuUIvDZOR3CWlcklvmGG0jnfRl2nOt0GY515SEhy1yMdC+dTeJBRWd5jn1
    V4n+wVPnYaG36MtdUZBw9PFj9bYLkva/0tRTjO4+cJmayJGeurO4Tzvo7MkmaT5A
    70cqiNhZ46tdBSg0+tlhco+s5u1yQIHb+mxmkabVK2sMYK56MNl5pnNNC7nUVcD4
    npAxcjioMg8iaGpxDhG0ERk8YLcURrhJSD5/vbF110tzGgKM2C+rzyLuv1dA==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=OUsiFuAK x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=OUsiFuAK x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfBPgw8/6FP3iOphJvYC9sKgDW9xuQ5lQw4PlSbvJgMRZMi6VT8NbeVDZs7TOYBzQ2yxwjo/OT0HsCjqnMEBFMg8KZEKvHPzRiQnsjqCtJHb9xvp0serD
    YHRThm9vd15JDvbdSmBniMZhG8IkHcVzbUdHMAIVofPpXWoakBeVzFYHFssAYtpSPoSzbThIqUf5vVXR5sskdwDjUVpOxb979nMGApnuMnEbHFONQtkGOf6o
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=wRwT6uffUbIA:10 a=t_PdEiP4ckcA:10
    a=mw6kJ3eo-EIA:10 a=8nJEP1OIZ-IA:10 a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10
    a=Lf-vpJhqX20A:10 a=1RTuLK3dAAAA:8 a=uTJJjIG0AAAA:8 a=yMhMjlubAAAA:8
    a=VC0O-eKI9ZLkBgtH5m4A:9 a=wPNLvfGTeEIA:10 a=kRpfLKi8w9umh8uBmg1i:22
    a=Oxz5h5Y_mNNx07kSEfs-:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756798AbeDIAmf (ORCPT <rfc822;greg@kroah.com>);
        Sun, 8 Apr 2018 20:42:35 -0400
Received: from mail-sn1nam02on0133.outbound.protection.outlook.com ([104.47.36.133]:59745
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753392AbeDIAm3 (ORCPT <rfc822;stable@vger.kernel.org>);
        Sun, 8 Apr 2018 20:42:29 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: Tang Junhui <tang.junhui@zte.com.cn>, Jens Axboe <axboe@kernel.dk>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 3.18 099/101] bcache: return attach error when no
 cache set exist
Thread-Topic: [PATCH AUTOSEL for 3.18 099/101] bcache: return attach error
 when no cache set exist
Thread-Index: AQHTz5uORhkRBGCrZ02bq5vrTs0Eqg==
Date: Mon, 9 Apr 2018 00:41:54 +0000
Message-ID: <20180409004042.164920-49-alexander.levin@microsoft.com>
References: <20180409004042.164920-1-alexander.levin@microsoft.com>
In-Reply-To: <20180409004042.164920-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1029;7:BJtJ42y0w/LHNpjRuRpTGfZObCVWnJLp3sgT/AWTsCJ2bqFwo1hvMBsdXVBLbCNWjZXgr2RgGNBhvXE7ennOGul13fetDrpKFsMWhFpiNiXgOM1uFf5iMBXGo2lj+Jp+MtVX/usEjtsA1xBCG4arE58NqHc+jSFCYgLGu190eVngNenk8Yk44h0jmo7WHIwvVsufOjmET/zBHjzLaQ1/nCNfd3QOFr4Dj/zzYd05bfK7Yld9neZQg5V2DQUOJS8l;20:k3NEtxYMJLrnERa2Ry636muU0alFUfYb7YLrsOi6hwENcfadDH7jXvCHPx1yAsI3KWFjvtsZD6GwGy2Yu1wp/6PgNAqyn1F0E74ssIQfvG9741dIpWdLLj8PrbZWKLu/LbmvLBjX1e5P++bssWKrC2mMtZ7/dWXDJtTlZntbFi0=
X-MS-Office365-Filtering-Correlation-Id: 77ee6dab-bfd9-4c26-619e-08d59db2c518
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(4604075)(3008032)(48565401081)(2017052603328)(7193020);SRVR:DM5PR2101MB1029;
x-ms-traffictypediagnostic: DM5PR2101MB1029:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB102955D1762FDFD26BE430FFFBBF0@DM5PR2101MB1029.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(5005006)(8121501046)(10201501046)(93006095)(93001095)(3231221)(944501327)(52105095)(3002001)(6055026)(61426038)(61427038)(6041310)(20161123562045)(20161123560045)(20161123564045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:DM5PR2101MB1029;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1029;
x-forefront-prvs: 0637FCE711
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39380400002)(396003)(376002)(346002)(39860400002)(366004)(189003)(199004)(7736002)(5250100002)(53936002)(66066001)(97736004)(22452003)(99286004)(68736007)(186003)(6506007)(26005)(2616005)(6486002)(86362001)(11346002)(486006)(305945005)(316002)(3280700002)(110136005)(76176011)(476003)(102836004)(6666003)(446003)(3660700001)(5660300001)(8936002)(8676002)(6512007)(81166006)(81156014)(2906002)(6436002)(36756003)(14454004)(86612001)(10090500001)(54906003)(2501003)(5890100001)(105586002)(25786009)(4326008)(478600001)(10290500003)(1076002)(3846002)(72206003)(6116002)(106356001)(107886003)(2900100001)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1029;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: i1dnNiWDa+Zr3W39P90ime2vp5dC2xGGoU4ZuVFnHKL5O0P9sfmf1dup9lIOvzdQh1sfr0U6cId3/7NcMWLdBeuyAA7YSP5dxHFDxghRQ5QQBN/xcvnYPSii9T9QhjsbXVMba3zqe90DiDw1LnBxBaE303TgH+ziR3jHtWwjFpT+8F8LPc9+zMER58KwAEIYWvWTSH0KNWS3kNTVOSOjfFTqENI8patJMsgxEvlusD9R2ENNNrI5w1+BmwgCNbvx2mQNH7JSdxDhyW5kQooTy4hIr201gKkHSPfnsGvHslVn6+wEtVNVsukTX+gCHm6RrxIkeE0b9XiI7bnusTs5ZkPZB8pTdxcct9vKrrJ9AGaFtx8+lh9//P0MSygJrPKrjRu+9tMbiiT0DUeci6BnDOl0kWCRFqrAx3Nrix+avP4=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 77ee6dab-bfd9-4c26-619e-08d59db2c518
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2018 00:41:54.5022
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1029
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
index 1efe31615281..5a5c1f1bd8a5 100644
--- a/drivers/md/bcache/sysfs.c
+++ b/drivers/md/bcache/sysfs.c
@@ -191,7 +191,7 @@ STORE(__cached_dev)
 {
 	struct cached_dev *dc =3D container_of(kobj, struct cached_dev,
 					     disk.kobj);
-	ssize_t v =3D size;
+	ssize_t v;
 	struct cache_set *c;
 	struct kobj_uevent_env *env;
=20
@@ -268,6 +268,7 @@ STORE(__cached_dev)
 		if (bch_parse_uuid(buf, set_uuid) < 16)
 			return -EINVAL;
=20
+		v =3D -ENOENT;
 		list_for_each_entry(c, &bch_cache_sets, list) {
 			v =3D bch_cached_dev_attach(dc, c, set_uuid);
 			if (!v)
@@ -275,7 +276,7 @@ STORE(__cached_dev)
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
