Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3550853-1523233277-2-10660794825718919577
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
    1523233276; b=bSrT9kPLUiUIdktAY8nfWc5R/BMjRzCx4WXJpEJEk3WKyjgSFi
    +379X88v06UKlHAljw49vjuP1EFnGhbVEbZ31pNIq+M5zAToUy3iy6LXpsDFVQqo
    8XNACLBUTRwsPBuYzkar+aGRatGz2q6VrwD/7ATgxPNh5H7irPKHUEOSKPXUNnfj
    /3EKJdwQFW5fKHVcFl9/6vqhePCblyn6XJZmEqwXukF5uke9UNqUKSnLk31eiknL
    pkK3fY7W/WdzK4gdNjOtPLjuIU/UWKBkbYQhZ3G8qNYomij4yaat8WaRAB6zUufZ
    KdH32luLA91zTUg3GVhYL744be50TCj46H3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=fm2; t=1523233276; bh=BGqNP6qDw6
    TvVsUfEYzGInN4ueeSRhJnK1GbVIP9Qlg=; b=Mo9KsOz9E6aFs9a6UTJX8mgGm8
    MBdN/goAwXOJewTaxfZswUiCWTfuBnV0K4HVnBlCfTFIjbl67SYvz2KSDdtIM80J
    aSTXD4qB0amgAGwvyXEWldG85NdYBuZjjwxlBROs6rPAEISksGTdTNk9aBqtDmaL
    rK/ghnKnrpxrqDRwiw4y7aMivr8CDj3XMfmb6Daq3vJspe9/DaLScAgH/vkEpKfu
    ug2HXf5Gttf2VovnTVbpHQML3EsdktRtFu9G5gg/5cKS4DFMwhGXd+n5gWJ9+oEK
    w2z6riI43L32AOBUmvybiQIrmrsq0tN09G6fQhEd5jDJxaA8zRMU8ogNY1MQ==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=MZvMMBHK x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
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
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=MZvMMBHK x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfIOh6DQ0Q1+sDD54Ax/qhTfBeBKdFjuNuU2hzBNWZaiFRcCfsC2ccrkZ4zZppeyOZCJu/BpNRXFf+j7dd63Jggtc7yMgBQgZpoT1IfXt/Fjjh6NIZQoA
    4Hd0T55Vfaaxeijs8D/wyg3tZAOyKfuyeo+6BebVBKVwqgGtXVF1F7Zmi/5Vr2dVPE4hQp7LWT2W8xT2OGVzDu0jZ9yXLXRAFnmHvg3cBdBH5k972+ohMRIW
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=wRwT6uffUbIA:10 a=t_PdEiP4ckcA:10
    a=mw6kJ3eo-EIA:10 a=8nJEP1OIZ-IA:10 a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10
    a=Lf-vpJhqX20A:10 a=1RTuLK3dAAAA:8 a=uTJJjIG0AAAA:8 a=yMhMjlubAAAA:8
    a=VC0O-eKI9ZLkBgtH5m4A:9 a=wPNLvfGTeEIA:10 a=kRpfLKi8w9umh8uBmg1i:22
    a=Oxz5h5Y_mNNx07kSEfs-:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754391AbeDIAVL (ORCPT <rfc822;greg@kroah.com>);
        Sun, 8 Apr 2018 20:21:11 -0400
Received: from mail-bn3nam01on0124.outbound.protection.outlook.com ([104.47.33.124]:4000
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753254AbeDIAVJ (ORCPT <rfc822;stable@vger.kernel.org>);
        Sun, 8 Apr 2018 20:21:09 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: Tang Junhui <tang.junhui@zte.com.cn>, Jens Axboe <axboe@kernel.dk>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.15 163/189] bcache: return attach error when no
 cache set exist
Thread-Topic: [PATCH AUTOSEL for 4.15 163/189] bcache: return attach error
 when no cache set exist
Thread-Index: AQHTz5haGR2iRpd76keGFnORsw68xQ==
Date: Mon, 9 Apr 2018 00:18:58 +0000
Message-ID: <20180409001637.162453-163-alexander.levin@microsoft.com>
References: <20180409001637.162453-1-alexander.levin@microsoft.com>
In-Reply-To: <20180409001637.162453-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1110;7:XD9T82PgmQASZSV5IW/ksrdi/y/bkXQo1/IOTebaRHui29Ut59gwReqWJaC/6P+ImHbQ+dk/NCwUs+KJ+Hy26Cyk0ZzyiBlNkRdtSkRVQ83aN1d5eMKWfH9jypxhXh7FdZ1rw+XDr0+YjDMZXCyt49hlVJ4e67hWOTYwZzZ0E61EC3gYgcLcqNAI4rRsBFfUhUVHDMtoQ2IfsNrCyLIos8N6qooT3qAmRG4aVoHn0AUJtAMU1zap7OhiwZPO45uP;20:QHAztTMfkI6oJZRGmGluSHzfzP1xQ7GYuzjJw4JvS8qbL1F1xTwXqhzpy9IbXtmnyg6aH6mmDBWn1gu8CPW5YtpzWBMsCiwr/qogPMoYCKe4uXAihZvHM3bDlC16VZnYoCyGj0nsW6TmsylIHegKB6BsLCsb2u9XkyBBdobUVlM=
x-ms-office365-filtering-ht: Tenant
X-MS-Office365-Filtering-Correlation-Id: ecd5abee-201d-4287-1021-08d59dafc94f
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB1110;
x-ms-traffictypediagnostic: DM5PR2101MB1110:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB1110DAF8E7F1BFFEC3794090FBBF0@DM5PR2101MB1110.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(3231221)(944501327)(52105095)(3002001)(10201501046)(6055026)(61426038)(61427038)(6041310)(20161123558120)(20161123562045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(6072148)(201708071742011);SRVR:DM5PR2101MB1110;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1110;
x-forefront-prvs: 0637FCE711
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(366004)(346002)(396003)(39380400002)(39860400002)(199004)(189003)(5660300001)(478600001)(86612001)(3846002)(6116002)(106356001)(6486002)(72206003)(25786009)(10290500003)(8936002)(6436002)(76176011)(2616005)(6506007)(2900100001)(97736004)(486006)(26005)(36756003)(10090500001)(81166006)(8676002)(81156014)(102836004)(2906002)(99286004)(11346002)(476003)(3660700001)(66066001)(6512007)(86362001)(53936002)(105586002)(5890100001)(186003)(5250100002)(14454004)(22452003)(6666003)(2501003)(446003)(7736002)(316002)(1076002)(110136005)(3280700002)(54906003)(68736007)(107886003)(4326008)(305945005)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1110;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: apBPBm2ljoARFLdFHNgIdTjaO7M0IUkaGm60Bq8jZXWdm1XWMPfQ5OCI/16v6TKe9Go+d6nraLXerDtKN0vkbdeVcwFVMoH4rUHhKMZ5YTuzCjuyG1UhQc/8NWT+igzsbgpA47/caZoOrza4YAETh5NK1P/8zhUUP8HyCyJLcaZr5DFLCboOAnByg0ROGt/CzEJxFbOoKoOi9svTDq4OVq8mpooMLw5kBlMrSTh/3LUdgnfRKPQ8xVuhNylEV2fwxXFEfIlpTU0GUF9nZsZlip6Rfe9udOWwgxpdNvTKgMIj3Wt3BhekOkjrKsXbFmdmhEvYCEHtZxFXAV8TDdhiT/VTlHWjMUZETf2o6NiJO3HXzYwKsfoKvNulvvKKWkWICcNXpi/3HK60uu43ZQd6PypLD6DSR7izlfgkwN+MYeg=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ecd5abee-201d-4287-1021-08d59dafc94f
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2018 00:18:58.8774
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1110
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
index c54028b92bc0..6316399aa230 100644
--- a/drivers/md/bcache/sysfs.c
+++ b/drivers/md/bcache/sysfs.c
@@ -195,7 +195,7 @@ STORE(__cached_dev)
 {
 	struct cached_dev *dc =3D container_of(kobj, struct cached_dev,
 					     disk.kobj);
-	ssize_t v =3D size;
+	ssize_t v;
 	struct cache_set *c;
 	struct kobj_uevent_env *env;
=20
@@ -272,6 +272,7 @@ STORE(__cached_dev)
 		if (bch_parse_uuid(buf, set_uuid) < 16)
 			return -EINVAL;
=20
+		v =3D -ENOENT;
 		list_for_each_entry(c, &bch_cache_sets, list) {
 			v =3D bch_cached_dev_attach(dc, c, set_uuid);
 			if (!v)
@@ -279,7 +280,7 @@ STORE(__cached_dev)
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
