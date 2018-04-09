Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3643807-1523234377-2-12895627632609873176
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
    1523234376; b=jlJleMbcpVVdn3133UXrLun4557URnMW+oVImiPAEpRFfAMq+w
    BkpKQcbCNehoofP1nkStv36mGnsEQdE7wKgV151FRqmtjEuNtg+F+p6M2fNu6Ng0
    RlPitFEaJgU20wPRs+JUenMnPewvJvQCkeJ3wfv+pjZpCtEBDx2XNZ0DBI4VbsOv
    bRWgeUReLogZ08MJNTICW9Q9XmddlnQM4G/4yHjMH5waBJsfywSUd+OlsPBOYc7n
    V4ClFG5neZ40I2TJjEgsHq4MGMWmvHltfLGI2HJeUc5Ako37ka7lYRDiddn8XaPF
    g+BoZqAE4aK5Wo/7sB+FZ/qIwE2I+gkFkF1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=fm2; t=1523234376; bh=wCF5xedl4b
    k9Kp7ZNoXBnhr0mw8rHfU3HqTN0oToiec=; b=nnaFJcBCLxj+lXJWJMjIJKwkvd
    bI6Vf1ZzAg3HzaUFXN9HkPtObg12QreqlXRagZjlytUzVjCaqvMcXqZo9bHjHWLE
    XZoFaYvKSlVijQASALrL4Jc+h2bvwvf8WMVkYh2DbV17tXlWufzVhcLcTYi/isRZ
    H6VAVMdJBarNUXZ4/LdzBN6OFSzmQVQZcvU1pmpHYM54+xPzHB2ksaTdyVWCExwj
    dI0cbvK072qpuamVD+4isbaI5P3tb45jOhv4xcQxQohme6FRut8VXTttpv1UyZqF
    iqx9d4y91rm8CJ2UsixkzT/1UhRJ4+mTmplb0rCx8n19ES2cywpjihvzmLKQ==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=hAuRcLNv x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=hAuRcLNv x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfEiZyPsjk63gy6qH7uDJEZ7tsiUud3dPqRwfuSGsQYpP1y6DrZx2mQRXfQTfMqzfHvK8jVO65NR5bxqU2+rBQr0B8VnXksGIwxHxa7rAJWDFqj9hBciy
    8dkemfKZJ9pyUgK1CKMwK8ReQR59+mYFE477Oe/HhASrzPXIe70qN84XzgK5hKsMIQs87trMSW8B211XnTZ5uqMdMJL2X18eVgzLqTCdn0JkQ5xZ3CR5ktvc
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=wRwT6uffUbIA:10 a=t_PdEiP4ckcA:10
    a=mw6kJ3eo-EIA:10 a=8nJEP1OIZ-IA:10 a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10
    a=Lf-vpJhqX20A:10 a=1RTuLK3dAAAA:8 a=uTJJjIG0AAAA:8 a=yMhMjlubAAAA:8
    a=VC0O-eKI9ZLkBgtH5m4A:9 a=wPNLvfGTeEIA:10 a=kRpfLKi8w9umh8uBmg1i:22
    a=Oxz5h5Y_mNNx07kSEfs-:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933123AbeDIAj3 (ORCPT <rfc822;greg@kroah.com>);
        Sun, 8 Apr 2018 20:39:29 -0400
Received: from mail-co1nam03on0104.outbound.protection.outlook.com ([104.47.40.104]:37663
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S933056AbeDIAj1 (ORCPT <rfc822;stable@vger.kernel.org>);
        Sun, 8 Apr 2018 20:39:27 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: Tang Junhui <tang.junhui@zte.com.cn>, Jens Axboe <axboe@kernel.dk>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.4 158/162] bcache: return attach error when no
 cache set exist
Thread-Topic: [PATCH AUTOSEL for 4.4 158/162] bcache: return attach error when
 no cache set exist
Thread-Index: AQHTz5nhhhhDwYWBF020iSxr0BGu+A==
Date: Mon, 9 Apr 2018 00:29:54 +0000
Message-ID: <20180409002738.163941-158-alexander.levin@microsoft.com>
References: <20180409002738.163941-1-alexander.levin@microsoft.com>
In-Reply-To: <20180409002738.163941-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1125;7:KYLW2PQx21ruQfXjNIfKI21ufUq+xDPlsqcMPieqF0XmZEpoy11joj18HNEC49A99D+JJmg+DDhtQscbAoIMO2ljXHk6YFHkf6aDK3b2Kdyts6UlHSjKlmVIKCLQjXJYQ/WErlt3xV1HSBo2mVJMOC7zuolyL4zgU1RC/u8wQ0wOhg3jBpoRcAVSX0yHYBeLhuOaewC5q2rfpOSzYwOuN3v3ygcOT1qoN4XBI41Ijuy7vHlHcvivmFsMizVoBU0I;20:gX5mQQKDyVePpqYP166dfPtO1RmEzFO2wxF3ifIiKQDLMyEHOWBzOPgumOiS04PmTiBFBBNv+I9NtflWeijOSWqK63S+qPtK0zx2cv9n5ZPS2ujYWPr1FifEzKSnbRXQ1f9SKQiSXbqrCnHhpNWnpf5yXo8AnP5Qq0wkrNBQPnI=
X-MS-Office365-Filtering-Correlation-Id: 325f2f63-395c-4bfa-e0fb-08d59db25646
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(4604075)(3008032)(48565401081)(2017052603328)(7193020);SRVR:DM5PR2101MB1125;
x-ms-traffictypediagnostic: DM5PR2101MB1125:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB11251545077243DF19260643FBBF0@DM5PR2101MB1125.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(8121501046)(5005006)(3231221)(944501327)(52105095)(3002001)(93006095)(93001095)(10201501046)(6055026)(61426038)(61427038)(6041310)(20161123560045)(20161123564045)(20161123558120)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:DM5PR2101MB1125;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1125;
x-forefront-prvs: 0637FCE711
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(39860400002)(39380400002)(366004)(376002)(396003)(189003)(199004)(2906002)(25786009)(6512007)(10090500001)(3280700002)(10290500003)(6666003)(3660700001)(316002)(110136005)(54906003)(11346002)(107886003)(2616005)(476003)(446003)(36756003)(99286004)(86612001)(53936002)(4326008)(486006)(6436002)(3846002)(81156014)(305945005)(5250100002)(1076002)(102836004)(14454004)(66066001)(5890100001)(7736002)(105586002)(81166006)(106356001)(8676002)(97736004)(6116002)(6506007)(6486002)(5660300001)(186003)(76176011)(22452003)(72206003)(478600001)(2501003)(2900100001)(26005)(86362001)(8936002)(68736007)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1125;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: JCRviiMrFlu9D5pWqEANm6PnOxv51TdNdnaVe4SoCZvZcevBxMxnPTtB6HvfMpnNbPjtFX/R68531sxtJDs1AJQMW73yaDZEich243PFkoqsFiABP4Y7cPzmTMv5WuMC20vz2PP6zuHvbTPmnOxv7e/+eWCsVEz2iVqes88/eSDru0WDfq2njWVW0s+k/k75nlBbbiw5c+2nwL5Wlgqmag2Hx8YxwG/nemSZR96me3xpD58OTP68EFqC8TmHw4zdCVR9oUGN6PRF7O1u/xMJSqjjS3iVfu6bznWnicK7R4xW3bgZhU1G/uLFSYDJzZHB/I1AYEB2ayYHF9L09o/NFAF1aM3ai/eWZIiF6hdfLNFlgULU3N2yR8HbeUcQbL9Tk5DZKFwrttvnHRfSR31Rr+4HnWS02lVrEb0DixpaBD4=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 325f2f63-395c-4bfa-e0fb-08d59db25646
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2018 00:29:54.3496
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1125
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
