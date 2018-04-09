Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3757758-1523238210-2-3547547515858542893
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
    1523238209; b=eZ0pX1j8sV6rVpdV6l09XbV0YxxGMCBqZiHZkcv9X7EKFIL8qY
    l7JfNTAZ3dprVBWjMF4VtetDceLUiYB7e0NT5vRVh+KYO6PuNgnz6DDmTjVIPTgJ
    r1mX36hYpgl1HFX72oPIFLjvW2jC0iWdAjFdrvy8iaIY56IyPSDQP8/lrxNmu0An
    hiY8C+o+XTpgfX2B4heBUNbKPH/hARynCGbBJi7u2OeO1dVBL8drKDH6xBVWS0+P
    a7DnK6DwNp8szXJY/Z5KElFvW3L3LYbontOr2zvnZjgSSjhEPucoiAn3ctupgt9M
    MfHbzpSJS4AbCUoI5fTihAkkK7HD+dtYF4ww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=fm2; t=1523238209; bh=wCF5xedl4b
    k9Kp7ZNoXBnhr0mw8rHfU3HqTN0oToiec=; b=oI1jm3cysGcgm2+vsKO1dK6R5v
    sC3vxj95nFtiSL0ZLeX9Q8mLf28gi/LUwfz+S1qUlwyXplYZNvNgJaMvRbuwA/rY
    jMtOvUv9iuIaAR7GpK1kBS53zYglsmkXKQuJW7RvPgVd1b8gp991+SlNXhrqvDmO
    lhFP2HhyfaIl7/Ft7zMjFP304GRPC4PeD6VcscBjG+vrE2HGAuWx4ikrAZqmwskF
    DNvO/cDgfqI+tSfmPmhlVztTsGd8sD2ZctHaz7yZHWNwal95dgd6s7lgQ/2zNKxH
    dKUkB18XX0h7b2GlTXiAaNvKrKmFrk7JvHNtA8YVx/PXy1lwL1nRmd6B1n/w==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=EvRBIoxk x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=EvRBIoxk x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfMQvMOUSd/L6Wt/M14upLPZK3H7/mPfntGy4H4E1D6eft0riZ8ZRzqAz0U5Oy0ZEWzIgnGj0pltpLxzZk2ieZPUPlTUsUGQWfAxehttNN5PyVIhP4xpX
    ylAUw4t+LPl/4exBA/Pp4a7KC6prKaGMFpdZVE4flQ5uHH90G1P49gUzAd8xGO2vCByZFki+wRBdC0i0uvweptbMS+wxwg+CgrG4L9eE3NmaukKtnACPxZO8
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=wRwT6uffUbIA:10 a=t_PdEiP4ckcA:10
    a=mw6kJ3eo-EIA:10 a=8nJEP1OIZ-IA:10 a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10
    a=Lf-vpJhqX20A:10 a=1RTuLK3dAAAA:8 a=uTJJjIG0AAAA:8 a=yMhMjlubAAAA:8
    a=VC0O-eKI9ZLkBgtH5m4A:9 a=wPNLvfGTeEIA:10 a=kRpfLKi8w9umh8uBmg1i:22
    a=Oxz5h5Y_mNNx07kSEfs-:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932662AbeDIBnO (ORCPT <rfc822;greg@kroah.com>);
        Sun, 8 Apr 2018 21:43:14 -0400
Received: from mail-by2nam01on0123.outbound.protection.outlook.com ([104.47.34.123]:51296
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932513AbeDIAeq (ORCPT <rfc822;stable@vger.kernel.org>);
        Sun, 8 Apr 2018 20:34:46 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: Tang Junhui <tang.junhui@zte.com.cn>, Jens Axboe <axboe@kernel.dk>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.9 284/293] bcache: return attach error when no
 cache set exist
Thread-Topic: [PATCH AUTOSEL for 4.9 284/293] bcache: return attach error when
 no cache set exist
Thread-Index: AQHTz5lsql1ublw1iEGbxSDPb32/Sw==
Date: Mon, 9 Apr 2018 00:26:38 +0000
Message-ID: <20180409002239.163177-284-alexander.levin@microsoft.com>
References: <20180409002239.163177-1-alexander.levin@microsoft.com>
In-Reply-To: <20180409002239.163177-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0806;7:jgyVG76Tc1UG/JzyPBQjCTQ4eEeRuvQJJ0KKWjeGWMYFdRsS3qsl/bVkwd/n8XQ9OmhYRmB8SxAx8fIwKC1nh9fBWCczEieQV/F0+cGRkhMSiNqAkBy3fi+HCf+BfBgB62UNCx6/jQYo0VQm3gA88/3BpxM0TIq62sp0bqVKi0CwocnU6PHvL/D46O36MwGN5wipe5ZVJNb0cq8fuDZr1NFjZKqhXI5Q9A1+mmS70luiO2te5mqJmFuJkfpScDJs;20:Sf6rzJNRudJlmqVr/HILoxC9CTdcW/0fEOcsQtURKHhbZvCs4K7o23GsQiF5MmPztIkAPsNy2mPbVaZo91D0zPm4VC4k7F3vIRkC/VrbZ1zLL8S1pyaTla50pMMAVu120ZP2I5kr8XYYbYQ/Bh4zUTcBWhCHLh2LZt4ASlGAhFE=
x-ms-office365-filtering-ht: Tenant
X-MS-Office365-Filtering-Correlation-Id: 0b80b240-fb66-48c1-0c86-08d59db1b024
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0806;
x-ms-traffictypediagnostic: DM5PR2101MB0806:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB0806BE661256C99B9F2887F0FBBF0@DM5PR2101MB0806.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(8121501046)(5005006)(3231221)(944501327)(52105095)(93006095)(93001095)(10201501046)(3002001)(6055026)(61426038)(61427038)(6041310)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123560045)(20161123558120)(6072148)(201708071742011);SRVR:DM5PR2101MB0806;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0806;
x-forefront-prvs: 0637FCE711
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(39860400002)(376002)(396003)(366004)(39380400002)(199004)(189003)(2906002)(25786009)(2501003)(10290500003)(476003)(11346002)(446003)(97736004)(5250100002)(5890100001)(68736007)(2616005)(102836004)(6506007)(3846002)(3660700001)(486006)(3280700002)(305945005)(6666003)(99286004)(5660300001)(76176011)(1076002)(186003)(26005)(7736002)(6116002)(81156014)(81166006)(86612001)(4326008)(105586002)(10090500001)(2900100001)(54906003)(22452003)(316002)(36756003)(110136005)(107886003)(8676002)(6436002)(478600001)(53936002)(66066001)(6486002)(6512007)(86362001)(14454004)(72206003)(8936002)(106356001)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0806;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: YjFQnOttpyh7GgmdebkxpeVPdf8nbW1KtZpWey2o0JArBcCMRGTr1F2hkPVZc0Nim3HwqvYUAJn5Cwrsb9LX1BA7imEo4WEfbnEzw1DF9whn45Qk5ZKlT+F3FSqifcyuT1hiTA44ba6R7iRSB3bBNyufugr1sebn8thZn9e1b8d0XHCEROVetuzVwim5mNtDU2szLe1st/El+Ek8aHnNsMCiwagMwwLkBgFaaVNdG5mnsi8jaFV3Xy8j2qRwhAuYBMjV120CPPyjrIfv0IZTik04JJ1dz5zBlYkHQyp1TiOSrMkyjqc9tpDYzU7yEAgjzUp+5AzaMvmM6yPieP7dSH4UFuDs2VBa17oUySyLnFIZLPP8hkIcYpFBMYXbh4CDW06p6B7HJ0VIw5/RheRxqhkV3nCbEzSsJL1cLMy6GQY=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b80b240-fb66-48c1-0c86-08d59db1b024
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2018 00:26:38.3946
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0806
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
