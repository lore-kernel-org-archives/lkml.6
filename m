Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1211789-1520118936-2-6102418096003271643
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520118936; b=tCiPPScD8UjjAbcEvlPP0oI1i60T3Wv53sS0kp3Y4nnk8Zn
    O292XyZS3D3xD4U6MweWd8q3f/JFjS7rdeONn2moHN/Pk8/xil1n1EhHD1+0jUJ2
    Yht78r00p9Q2sJvg+/pRRyL44XWKbEd0ykCkpGefPfo6XHCDycfUHLcO/7hv7Lfc
    0wNLKC9YYyYNnQjHOpKbatYlMEV0x52dKNybaDl6NxmWqArFga452F4kV6NNGneW
    wBgeQnrWLq3SrNA54j0UJzlgU4ENsaPjDikFB5Nii7BnT5hfJO5KHLh/wNs9V/d6
    gzXeAO9GKDVZofQd7LKouHcRZINWNxbJmrZFHBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1520118936; bh=bLnonb
    AMGIpGRxli06e/OmN3u0ddG3z+cDZVD+f42oc=; b=Iy9fltyiB2GeE6VRQec0EI
    hqekkgp5MRsAOvBzj3bkczD3J9+0iuiwz92hw5nlsEZhcFm7fLgMyv6oy3LRoxNH
    sHyy+QuGNa1GMWRtipTiT9Exhm5Hw65K/xOPj6UgOwNiuco0E1UvBjK5xv8kwPr6
    9S2tNO+LeXeafqgm2DDeXsdJtOqSVVjErvhmgo+eBILVC7fuw/E1iNYHUt6RpRjC
    wBZG4yv3AvBugb75Q655Jmqt3lXZyqvj24Z81pjEZ7FpeKzWEI9zDb0V5lpZIb2g
    i17O4B7WpzDCSACtBVRBqMUvlK/JhjkR8ncgnxF5SUGe4E/7GbZ06x6C3kndfiEA
    ==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=kedzdaFi x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=kedzdaFi x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751950AbeCCXOg (ORCPT <rfc822;greg@kroah.com>);
        Sat, 3 Mar 2018 18:14:36 -0500
Received: from mail-by2nam01on0114.outbound.protection.outlook.com ([104.47.34.114]:65056
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S935002AbeCCWjG (ORCPT <rfc822;stable@vger.kernel.org>);
        Sat, 3 Mar 2018 17:39:06 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Shaohua Li <shli@fb.com>, Jens Axboe <axboe@fb.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.4 038/115] blk-throttle: make sure expire time
 isn't too big
Thread-Topic: [PATCH AUTOSEL for 4.4 038/115] blk-throttle: make sure expire
 time isn't too big
Thread-Index: AQHTsz9ULu9CD2h4SUK+4tvMXQULAA==
Date: Sat, 3 Mar 2018 22:31:11 +0000
Message-ID: <20180303223010.27106-38-alexander.levin@microsoft.com>
References: <20180303223010.27106-1-alexander.levin@microsoft.com>
In-Reply-To: <20180303223010.27106-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MW2PR2101MB0938;7:L1Bl1d6VhpgxREhhFr9sWXgmwRkCo20W+DAO5ckNZWQOpe3FgdWDv/9iDf8/KFTEu3gjwfNBeS/iPAF5VE5lbut+v4zFjF//qG0v5Qrqd9KJXzXKQ9WjGqKCsEoM442hTAKg7w3aPEwptlefp3oCPmDmNeqO3nZwqJP0o6bftY8d4S3237MsIGmc5J6RZkrc2k7eAOLt4bIb6EqcuL4fNCjLXS09xyt4tbr7JpiBdcSHZt/4uhpFCv8Gn1v27Vez
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: af333eb7-9307-4be8-471e-08d5815791c2
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(48565401081)(5600026)(4604075)(3008032)(2017052603307)(7193020);SRVR:MW2PR2101MB0938;
x-ms-traffictypediagnostic: MW2PR2101MB0938:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <MW2PR2101MB0938D04D9D48955148B82A6FFBC40@MW2PR2101MB0938.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(67672495146484);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(5005006)(8121501046)(93006095)(93001095)(3002001)(10201501046)(3231220)(944501244)(6055026)(61426038)(61427038)(6041288)(20161123558120)(20161123564045)(20161123560045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:MW2PR2101MB0938;BCL:0;PCL:0;RULEID:;SRVR:MW2PR2101MB0938;
x-forefront-prvs: 0600F93FE1
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39380400002)(39860400002)(366004)(396003)(346002)(376002)(199004)(189003)(54906003)(4326008)(72206003)(22452003)(478600001)(25786009)(66066001)(6436002)(6512007)(14454004)(53936002)(2906002)(6486002)(105586002)(99286004)(10290500003)(3846002)(106356001)(6116002)(305945005)(5660300001)(110136005)(1076002)(36756003)(316002)(2900100001)(2501003)(5250100002)(10090500001)(59450400001)(102836004)(68736007)(2950100002)(26005)(97736004)(186003)(6506007)(8676002)(107886003)(3660700001)(6666003)(7736002)(86362001)(81166006)(86612001)(81156014)(76176011)(8936002)(3280700002)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:MW2PR2101MB0938;H:MW2PR2101MB1034.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
x-microsoft-antispam-message-info: Rzjzz0E/UFuTTnBnuVjJn4Jls7B1LVSdWBcKUwRQbEUmAo1Tw2Z5I3J5SePujhIrAA5CNOJlRkQZKJsnmIuM9HXHq4G3d1Pc0p+1zZyn7xizVXaxuL9UPfyAmLjMGJDsNRKEK9WcFGq/6qEc4FwoClpW613SQRCE0FMEY4cy+pI=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: af333eb7-9307-4be8-471e-08d5815791c2
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Mar 2018 22:31:11.1040
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR2101MB0938
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Shaohua Li <shli@fb.com>

[ Upstream commit 06cceedcca67a93ac7f7aa93bbd9980c7496d14e ]

cgroup could be throttled to a limit but when all cgroups cross high
limit, queue enters a higher state and so the group should be throttled
to a higher limit. It's possible the cgroup is sleeping because of
throttle and other cgroups don't dispatch IO any more. In this case,
nobody can trigger current downgrade/upgrade logic. To fix this issue,
we could either set up a timer to wakeup the cgroup if other cgroups are
idle or make sure this cgroup doesn't sleep too long. Setting up a timer
means we must change the timer very frequently. This patch chooses the
latter. Making cgroup sleep time not too big wouldn't change cgroup
bps/iops, but could make it wakeup more frequently, which isn't a big
issue because throtl_slice * 8 is already quite big.

Signed-off-by: Shaohua Li <shli@fb.com>
Signed-off-by: Jens Axboe <axboe@fb.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 block/blk-throttle.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/block/blk-throttle.c b/block/blk-throttle.c
index 2149a1ddbacf..17bdd6b55beb 100644
--- a/block/blk-throttle.c
+++ b/block/blk-throttle.c
@@ -505,6 +505,17 @@ static void throtl_dequeue_tg(struct throtl_grp *tg)
 static void throtl_schedule_pending_timer(struct throtl_service_queue *sq,
 					  unsigned long expires)
 {
+	unsigned long max_expire =3D jiffies + 8 * throtl_slice;
+
+	/*
+	 * Since we are adjusting the throttle limit dynamically, the sleep
+	 * time calculated according to previous limit might be invalid. It's
+	 * possible the cgroup sleep time is very long and no other cgroups
+	 * have IO running so notify the limit changes. Make sure the cgroup
+	 * doesn't sleep too long to avoid the missed notification.
+	 */
+	if (time_after(expires, max_expire))
+		expires =3D max_expire;
 	mod_timer(&sq->pending_timer, expires);
 	throtl_log(sq, "schedule timer. delay=3D%lu jiffies=3D%lu",
 		   expires - jiffies, jiffies);
--=20
2.14.1
