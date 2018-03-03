Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1247250-1520121126-2-5675402530294062917
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
    t=1520121125; b=BhyfkptJlWh9stNgrCcaDWekRZKYhEVhsLbq6sfRIJTt6Zi
    8ZAf4RjzY0KBDIQbknGflucrLstQQyQ8b7MibRcLjj8w1Ko4NSjBD7kpB2OZCY2s
    pR53x5RjgIWABf4YtgXqTimN8pcs2dICDgHNa7RVoRSIwCWl6ysKbYlJbKhHVGf3
    V3vh6kPuBNkWRXfvrm6hPmXWZ8wNosYI1TSZsl4hsDHWIMqnQKezljWO0v5fsNSO
    nniYoGgr5PwlUBKNf6KQQPSEEfmvCC/0hM+M9J5BKgAIRuPEXVBdZGCfZLzi4rx7
    hXl1JEF4qHNIAVYZKlBMR0xOFTQ9Bu7W4wYGabQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1520121125; bh=vZDg+D
    SnJPT3KrxiuPBECF8KTA66xzkcpo47cnITSyw=; b=LnaVqz6gNo0us7SLfLTID7
    OnQONb4KGW84QUTV65uo8G4yVYnN4cwGB+SGZ+F0DveUdhRrAno/c9lHe25dOIoi
    nzmpXlWUhXz5nGQzvNZoZWjdUlZKHwWVe5iREcahnbC6iFE0xVf2OkZvmwBnNyF/
    +1XAN45SIM+lY7TvDo9kbORFC544cM9+my3pmheqgl2+QSTkl53ieEj+arRlmtc+
    Ppd8etP0oelqAL4vBg475Hb10z2Mri0Zae/6hz0Qbm6q1D2n4cMLwFm7gDua5f5H
    Sw8JyaRmrSMF7VCNMX7q0MvfyCCQWlbAESUspjTueu2ukUymkKTeS3GrCLKfCNHQ
    ==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=OsbOteg6 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=OsbOteg6 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933931AbeCCXvS (ORCPT <rfc822;greg@kroah.com>);
        Sat, 3 Mar 2018 18:51:18 -0500
Received: from mail-by2nam01on0133.outbound.protection.outlook.com ([104.47.34.133]:49841
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S933980AbeCCWdK (ORCPT <rfc822;stable@vger.kernel.org>);
        Sat, 3 Mar 2018 17:33:10 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Shaohua Li <shli@fb.com>, Jens Axboe <axboe@fb.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.9 081/219] blk-throttle: make sure expire time
 isn't too big
Thread-Topic: [PATCH AUTOSEL for 4.9 081/219] blk-throttle: make sure expire
 time isn't too big
Thread-Index: AQHTsz78U8tMbQs0vEKotOQze1kDBQ==
Date: Sat, 3 Mar 2018 22:28:42 +0000
Message-ID: <20180303222716.26640-81-alexander.levin@microsoft.com>
References: <20180303222716.26640-1-alexander.levin@microsoft.com>
In-Reply-To: <20180303222716.26640-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MW2PR2101MB1097;7:pG14eeuoBninh2YAzAEp1QlmUY9OVw6CB/vk5Pidbx56QaUuGNo8qSHggpAO8MVtTG0PiEGQBiHP6txst9cGVjZgdoDszERARZHx4vrGFQZ5vKxnivRE5t6pRUbZ5cy1E1egQls4mYljgSAnq5gB2Vh9BmDb0OGeiHlR+LOBZbYRc4fFVajShYR+ZXuGfDPYXFsTfXXiPLvsDZoSLWx6A7OKoPpnp3ToroXP0qdag6R3FD0azakDowsI7KBuvR9H
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: eb171aaf-1c04-4f40-55b3-08d58156bd29
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(48565401081)(5600026)(4604075)(3008032)(2017052603307)(7193020);SRVR:MW2PR2101MB1097;
x-ms-traffictypediagnostic: MW2PR2101MB1097:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <MW2PR2101MB109707A7DC4FBEA5DD86CF28FBC40@MW2PR2101MB1097.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(67672495146484);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(5005006)(8121501046)(10201501046)(3002001)(3231220)(944501244)(52105095)(93006095)(93001095)(6055026)(61426038)(61427038)(6041288)(20161123560045)(20161123558120)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(6072148)(201708071742011);SRVR:MW2PR2101MB1097;BCL:0;PCL:0;RULEID:;SRVR:MW2PR2101MB1097;
x-forefront-prvs: 0600F93FE1
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(366004)(39380400002)(396003)(39860400002)(346002)(189003)(199004)(305945005)(105586002)(36756003)(3660700001)(86362001)(6666003)(66066001)(2900100001)(5660300001)(8676002)(10090500001)(81166006)(81156014)(8936002)(22452003)(10290500003)(2950100002)(4326008)(25786009)(5250100002)(2501003)(68736007)(7736002)(72206003)(14454004)(478600001)(186003)(110136005)(26005)(316002)(2906002)(97736004)(6512007)(99286004)(107886003)(54906003)(1076002)(6506007)(106356001)(53936002)(59450400001)(6116002)(3846002)(102836004)(6486002)(86612001)(3280700002)(6436002)(76176011)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:MW2PR2101MB1097;H:MW2PR2101MB1034.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
x-microsoft-antispam-message-info: YdlM/snUv1M8ML5pUDcWKkJaTR3iekIiXME/wG0KsXGpv1XDOkgcWou1Pz000l+pfDyg5kSXjJmRRL3HBwhbQNCZGWYr2XMa209DBAedyHV0v8tPAHoPJX+RvfIrf+szjz2/dEgl3ArC8vFyxvTyLCk4meobbhNkghdfTIgHGTA=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eb171aaf-1c04-4f40-55b3-08d58156bd29
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Mar 2018 22:28:43.0100
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR2101MB1097
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
index a3ea8260c94c..3a4c9a3c1427 100644
--- a/block/blk-throttle.c
+++ b/block/blk-throttle.c
@@ -499,6 +499,17 @@ static void throtl_dequeue_tg(struct throtl_grp *tg)
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
