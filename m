Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1602359-1517683858-2-7611232640351530414
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES enro, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1517683857; b=i6W8amcu5TXbUoO9zcDfqgb6ZI/mY0QALcGZlbveszgZDlu
    aksJA5LKArm6DQShIpaWid6RxQrWzVFZjw/d4YqXuWXuo78+3w11GXKE3jpz+mca
    KVpH2jA+bPGd1EmLstxiyqfuu096Y2RDab3uk06XybN2ZSiCz96LWSbDQstu7p97
    BQXCCOEtp2lczR6WGQ946unSTFf1qNfLMXSyhBUyR2LKgHuQS5YYO7OwHV4YG5CC
    rLPwlAE5PMrU4eyxUNuMw6b09Zceap9wMRakG5FOxwNjIWxKhJtKhQ1d7ZwZpV9G
    XG8MtbR3C/tf5T+7DiZV/tDAkAF8R65e+oi8Rxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1517683857; bh=l6AqnZ
    qB80Le+99KvaXVkVsTj2OpLhaqizk0HKupchU=; b=aLOUQ8cGrcZAEkGPk+1Hnk
    Q8zPsh2pM4MpWXCmKVxpHIG/o+jRuyIRZv9hZ2dtkwFKaaR4oDKTrrvXx1vd5IqO
    FHgDoHp8O/6DDpqfkFrCYSUjonY7wHRalIw5r+dppVQtGpu2Cht4lwYnTtfz+ay4
    sQLJY+qjhRmlmnnFrXcockja+nx3jtIxfqqByPcSQDrv3TaHojelkeUFjzBrOIZZ
    VKIABPrIVA1fMJjEvqLCrgZR4d8EBOsBiH1UkJtiSYKHe5tKTNkUKpu/rhcBcp2Q
    WAJ5+0CY6Y0K9UIijBaFKC+7y/ZBy1ngHQiPyfMT9fSKfI8/5XpY6e5LHVz74HoA
    ==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=kzFg/Gjy x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=kzFg/Gjy x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754967AbeBCSqa (ORCPT <rfc822;greg@kroah.com>);
        Sat, 3 Feb 2018 13:46:30 -0500
Received: from mail-by2nam03on0111.outbound.protection.outlook.com ([104.47.42.111]:44500
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752926AbeBCSBe (ORCPT <rfc822;stable@vger.kernel.org>);
        Sat, 3 Feb 2018 13:01:34 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Tommi Rantala <tommi.t.rantala@nokia.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.14 059/110] tipc: error path leak fixes in
 tipc_enable_bearer()
Thread-Topic: [PATCH AUTOSEL for 4.14 059/110] tipc: error path leak fixes in
 tipc_enable_bearer()
Thread-Index: AQHTnRjwXrELSCMjH06Uk63o02ohBw==
Date: Sat, 3 Feb 2018 18:00:56 +0000
Message-ID: <20180203180015.29073-59-alexander.levin@microsoft.com>
References: <20180203180015.29073-1-alexander.levin@microsoft.com>
In-Reply-To: <20180203180015.29073-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BL0PR2101MB1105;7:8R8CQ+g5Ighi8SDMRbflFPeS7avdJQJGpA+/rDNXILopsDi1+OxwVkP764ORrhZNB1WTzOqB420g9Pe1oxdyq/ZyodJfC9+TqGu+n2hh7OF70+Z0Qo3VoTxEuR4vSMkgeR2bFJaWglCOknYHbBP6I8vr5jjPCo7Bto5TZD0hY5988Yjb2JbfuuyW5dM8NALBi8mqgUxcR4slqwT4UPf+zTXiujJ4r11J8CWzdZX4h6EKlIYlifWMWas5rOHxXG2h
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 8f5ae824-da43-49da-1988-08d56b302804
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(4604075)(3008032)(2017052603307)(7193020);SRVR:BL0PR2101MB1105;
x-ms-traffictypediagnostic: BL0PR2101MB1105:
x-microsoft-antispam-prvs: <BL0PR2101MB11057A96DEE2ABF16CBC65D9FBF80@BL0PR2101MB1105.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(37575265505322)(28532068793085)(89211679590171)(82608151540597);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(61425038)(6040501)(2401047)(5005006)(8121501046)(3002001)(10201501046)(3231101)(2400082)(944501161)(93006095)(93001095)(6055026)(61426038)(61427038)(6041288)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123558120)(6072148)(201708071742011);SRVR:BL0PR2101MB1105;BCL:0;PCL:0;RULEID:;SRVR:BL0PR2101MB1105;
x-forefront-prvs: 05724A8921
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(396003)(39380400002)(39860400002)(346002)(376002)(199004)(189003)(6346003)(97736004)(6512007)(7736002)(26005)(305945005)(102836004)(105586002)(68736007)(5250100002)(8936002)(59450400001)(6486002)(6436002)(106356001)(6506007)(81166006)(81156014)(2501003)(2906002)(10090500001)(99286004)(66066001)(54906003)(6116002)(3846002)(36756003)(1076002)(8656006)(8676002)(110136005)(107886003)(72206003)(2950100002)(478600001)(10290500003)(22452003)(6666003)(5660300001)(2900100001)(4326008)(25786009)(14454004)(316002)(86362001)(53936002)(3280700002)(186003)(3660700001)(76176011)(86612001)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:BL0PR2101MB1105;H:BL0PR2101MB1027.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-message-info: 8t3/QHwzGPY6DVWYWWAaR6W1LVSdt2JQKA+CzAa8bs8F1/xVLg4pxPiwhZwJPhTTVIMq3zJb5ltrbvUR6CpbGg==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8f5ae824-da43-49da-1988-08d56b302804
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Feb 2018 18:00:56.8784
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR2101MB1105
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Tommi Rantala <tommi.t.rantala@nokia.com>

[ Upstream commit 19142551b2be4a9e13838099fde1351386e5e007 ]

Fix memory leak in tipc_enable_bearer() if enable_media() fails, and
cleanup with bearer_disable() if tipc_mon_create() fails.

Acked-by: Ying Xue <ying.xue@windriver.com>
Acked-by: Jon Maloy <jon.maloy@ericsson.com>
Signed-off-by: Tommi Rantala <tommi.t.rantala@nokia.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 net/tipc/bearer.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/net/tipc/bearer.c b/net/tipc/bearer.c
index 47ec121574ce..c8001471da6c 100644
--- a/net/tipc/bearer.c
+++ b/net/tipc/bearer.c
@@ -324,6 +324,7 @@ restart:
 	if (res) {
 		pr_warn("Bearer <%s> rejected, enable failure (%d)\n",
 			name, -res);
+		kfree(b);
 		return -EINVAL;
 	}
=20
@@ -347,8 +348,10 @@ restart:
 	if (skb)
 		tipc_bearer_xmit_skb(net, bearer_id, skb, &b->bcast_addr);
=20
-	if (tipc_mon_create(net, bearer_id))
+	if (tipc_mon_create(net, bearer_id)) {
+		bearer_disable(net, b);
 		return -ENOMEM;
+	}
=20
 	pr_info("Enabled bearer <%s>, discovery domain %s, priority %u\n",
 		name,
--=20
2.11.0
