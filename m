Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1084890-1520489986-2-1037530056674168201
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
    t=1520489986; b=Z9mg+d0m9thEHLLBViFiDI5zUS+DtXW/loovNWH2tarce3y
    Pu83XG3WO1qJZXuQycWVs8eH/GXxmqoZgzhtKazjy4SJrMZr5aCalqCaby4eNayy
    vMIazC4DxflYuZus4xyOjiLAu4bz4NLHR1iJkXaxnxHqlCbYgDhmJ/nMS9uVcttw
    VXyUzN16MV4OwnwHsnp1s4GuNnAbu22c0uo/W0qpiYLp+DTBgTKDDf4ijeCKBWyY
    kmXAJMthO6cxOw9xm31AZM9xxU2vhfs2eGgdV4CPHGucaU0xc9fPdd6bO/wPV02V
    eRn546p/2oLDFnabqVSxtr7EypTg1sylTnqpNZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1520489986; bh=ss7sw2
    b6O9scvwoDw9IGTrA15CbTcJSYYDRcgV/YBvU=; b=RelFg8Xo4MsYMkKXqHLOQL
    jrdVjggolP7QHyp1EM5h6zlocJzPKVege7KDpGPPbDoW4R+VOUWnN66lN9+ao/hC
    NLMFVQKRCj8/rcMPG6nguBokt22f6gcd3XL2ukT2IOpezIiU+K10SZhJ1BXBN4rd
    kprTCEZ1XXOrzRlS+16zE+G76xzrl8m3KBGKGNJgept5t1yFTa7sQ2166rbL0Bhc
    tXbaEqAfomiqGYuKCH4o3vcD6XwC9ufzux4P7G2YyiGqwTO+fBPItIMqx0kmGFVF
    SiGHz2e1dLvdcaMmmTJ1skAYy8MrN3wa5oWgvKv1UgyhXd5sll84m4hG2TlxG8Vw
    ==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=Kx1syz1v x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=Kx1syz1v x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754066AbeCHGTb (ORCPT <rfc822;greg@kroah.com>);
        Thu, 8 Mar 2018 01:19:31 -0500
Received: from mail-co1nam03on0105.outbound.protection.outlook.com ([104.47.40.105]:45079
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S965592AbeCHFA7 (ORCPT <rfc822;stable@vger.kernel.org>);
        Thu, 8 Mar 2018 00:00:59 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Guoqing Jiang <gqjiang@suse.com>, Shaohua Li <shli@fb.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.9 056/190] md/raid10: wait up frozen array in
 handle_write_completed
Thread-Topic: [PATCH AUTOSEL for 4.9 056/190] md/raid10: wait up frozen array
 in handle_write_completed
Thread-Index: AQHTtpo1C4UgFK9U4UWQu2YKZ5s2Mg==
Date: Thu, 8 Mar 2018 04:59:16 +0000
Message-ID: <20180308045810.8041-56-alexander.levin@microsoft.com>
References: <20180308045810.8041-1-alexander.levin@microsoft.com>
In-Reply-To: <20180308045810.8041-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1109;7:tapk6Vs+zYbsWVVRYqQj0UDHW/5dcQzlxZkQuQgZYjgyOen0Ozz7D1kaakXgw+zY4RnRaMSMAEyvholcjAhjkoepvhnHiYaR8teqWYeiUJiFChl8X8n0k4RNUFgFvuIoc3+bfD1lvbvO8nH87MGkyDCmaiji8OgPeK41jRbXAhIPfP0OZew+YYwSviZ8DhH9D8POvIQsp+fdYr20di5GmF9vPf7ljID5J5FBw9IKaqtxqu5+fy6JcgXNjVFxHEsK;20:vkr+oxZuO3NLIuV1emkT4fuist6DP1NY/psEPiCv3CHhAxWQAT++/JKbWq6oiW9ENhfL3GUM2mw+NojqchHuGpWM48JBWVfom7jnZR84xWN8aXFpdGil5KYrGr6IjZB/1Y8AJz4V3dh4AvW1hxvB74Ooc+GNktW36OC7esNhzk4=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: affa0c46-cb97-4a40-5e4c-08d584b18e4a
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB1109;
x-ms-traffictypediagnostic: DM5PR2101MB1109:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB1109610DFA95F7A544F469CEFBDF0@DM5PR2101MB1109.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(67672495146484);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(8121501046)(5005006)(3231220)(944501244)(52105095)(93006095)(93001095)(10201501046)(3002001)(6055026)(61426038)(61427038)(6041288)(20161123558120)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123560045)(6072148)(201708071742011);SRVR:DM5PR2101MB1109;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1109;
x-forefront-prvs: 060503E79B
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(376002)(346002)(39380400002)(39860400002)(366004)(199004)(189003)(3660700001)(5250100002)(102836004)(6436002)(2501003)(81166006)(8936002)(6486002)(81156014)(53936002)(6512007)(8676002)(6506007)(5660300001)(86612001)(76176011)(10290500003)(86362001)(4326008)(59450400001)(105586002)(25786009)(10090500001)(26005)(2900100001)(316002)(106356001)(97736004)(54906003)(305945005)(7736002)(186003)(36756003)(22452003)(110136005)(14454004)(72206003)(6116002)(3846002)(68736007)(3280700002)(66066001)(2906002)(2950100002)(478600001)(6666003)(99286004)(1076002)(107886003)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1109;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
x-microsoft-antispam-message-info: P8rATezW3ZQdqOqrQsqaW0aFxvSMTwGMyZLT693kpihDLQFirYmLWoXiJ2Q9YnyDCyBL3+zhqngKzJVX3BLkhbCjNTXBjp7fOBFjlmOb8eW2coJ+FAnCNPwbQrDaHmziM6wrZGRnHUWzO+uGSfjN30DDJLGexLgdWsGRrA/1fXuDFgJvCRo62TQq45haXmMbJE/Rkq7kY9t8AAIDVL//xCalLlVfN1G3gV5Gv0mPnbsNj14VEdvEz1xsRsbptGfvxyDbImsyIKmcsgUEny7yjGLzHK1a/dFFGaQGxOptyP68fFqlR1jSK7TnjkZWyuw0SWSDUx0b+lc+G5aYH5uKQQ==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: affa0c46-cb97-4a40-5e4c-08d584b18e4a
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Mar 2018 04:59:16.6227
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1109
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Guoqing Jiang <gqjiang@suse.com>

[ Upstream commit cf25ae78fc50010f66b9be945017796da34c434d ]

Since nr_queued is changed, we need to call wake_up here
if the array is already frozen and waiting for condition
"nr_pending =3D=3D nr_queued + extra" to be true.

And commit 824e47daddbf ("RAID1: avoid unnecessary spin
locks in I/O barrier code") which has already added the
wake_up for raid1.

Signed-off-by: Guoqing Jiang <gqjiang@suse.com>
Reviewed-by: NeilBrown <neilb@suse.com>
Signed-off-by: Shaohua Li <shli@fb.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/md/raid10.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/md/raid10.c b/drivers/md/raid10.c
index b19b551bb34b..b1daff78f7b2 100644
--- a/drivers/md/raid10.c
+++ b/drivers/md/raid10.c
@@ -2704,6 +2704,11 @@ static void handle_write_completed(struct r10conf *c=
onf, struct r10bio *r10_bio)
 			list_add(&r10_bio->retry_list, &conf->bio_end_io_list);
 			conf->nr_queued++;
 			spin_unlock_irq(&conf->device_lock);
+			/*
+			 * In case freeze_array() is waiting for condition
+			 * nr_pending =3D=3D nr_queued + extra to be true.
+			 */
+			wake_up(&conf->wait_barrier);
 			md_wakeup_thread(conf->mddev->thread);
 		} else {
 			if (test_bit(R10BIO_WriteError,
--=20
2.14.1
