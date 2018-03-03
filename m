Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1211789-1520118808-2-16253443641108079784
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
    t=1520118807; b=hboIK3HDprTBYuFTs7MQtvpHVhw7aTKcxyQwbwGK60IxeXs
    RzLJzd9XUHq3G5ed01gDlxzL5OC56RWhJavQy4DnWKeHR87YSjGm40xRNv1dCGeW
    7AKh8D/wVoqyhngjc/P13cQ+Cwtk0UDJJx6f2Hr+NCWXC0QP3Oi0K/zxzHr8BAfl
    UdKBQ0OVCUcMSaWPsmKPU7nN5GIyQ67FgMRtrpEf/5mPYawkeNwfZnoj/4qrP95X
    e7r5QbsqdVHxuZW9t+3QPmHWNsuOyaFUvC6Y/Jq6iiNOYYGTQyyZByMjaLxxm5Sk
    4JDmf92C4osd6g1Tlhhmeogw6IErN9v6jn+ciRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1520118807; bh=TJ6leh
    YwKpZOznHE4hVaH/FZFyTrUleCpP/RKFQpLSw=; b=JvGTPHJ3NXehb3/UNdzFmM
    D7xltSyKbKFM1nU0sslBg+VHpu95G8406do0Rh12pk0R31FC2x6vUqQnLOP2mRX/
    8XkdbXZUYhrjYOsuEOzKQDFLpIJ1p/f06hAuZFPaIJ9yDBT/Pd/Rgp2WLQc4tB80
    xtxyiUPAFyZlE085cioIt9C7HUbI65nHIRLYOKQAAIKbhx7Sr4LkhOzTDQf+NIub
    y4K6E6INlNSRv6M9h8fXlDbRvA+j/3SNWm1sBReyMk4U+z31/Nt+/muS1zhfspmx
    pXra7733YNlAefF9RflEgygKiVF1WEQuy23PIVq1s4hipRVOk9AOgP25NJrOsynQ
    ==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=W1smMEdH x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=W1smMEdH x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933998AbeCCXNX (ORCPT <rfc822;greg@kroah.com>);
        Sat, 3 Mar 2018 18:13:23 -0500
Received: from mail-by2nam01on0114.outbound.protection.outlook.com ([104.47.34.114]:65056
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S935023AbeCCWjK (ORCPT <rfc822;stable@vger.kernel.org>);
        Sat, 3 Mar 2018 17:39:10 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Eric Dumazet <edumazet@google.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.4 041/115] bonding: refine bond_fold_stats()
 wrap detection
Thread-Topic: [PATCH AUTOSEL for 4.4 041/115] bonding: refine
 bond_fold_stats() wrap detection
Thread-Index: AQHTsz9VIfoYxG1O/EKeWKv6ggJL0w==
Date: Sat, 3 Mar 2018 22:31:12 +0000
Message-ID: <20180303223010.27106-41-alexander.levin@microsoft.com>
References: <20180303223010.27106-1-alexander.levin@microsoft.com>
In-Reply-To: <20180303223010.27106-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MW2PR2101MB0938;7:Td7WHyV5EsvJzTyu0m/Dx7nAVIA2L9bC4Q+L1n8B85QnSD9BhmPupc0J3HPQBua28F37X1+pkSvGZVEj75c2AzUxsIpcNzAl7l9eg7V1EKQYTxDuOy0UPyXl4+Vd2UL3XVwKlL9IHbelqSnW5JL0hc6CrdCEqS69M8lS52hot/Emps0xktdUOJbS75gv157VPbvVIXzHCyyxPrL5asfZWFzxSQCDTLJ0JrRClcexJDUdcxZ8lrojBQySF7GrJmL0
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 083d23cc-22f8-4a96-2807-08d5815792c6
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(48565401081)(5600026)(4604075)(3008032)(2017052603307)(7193020);SRVR:MW2PR2101MB0938;
x-ms-traffictypediagnostic: MW2PR2101MB0938:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <MW2PR2101MB093873498AC4792DF95DBAA8FBC40@MW2PR2101MB0938.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(211936372134217)(153496737603132);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(5005006)(8121501046)(93006095)(93001095)(3002001)(10201501046)(3231220)(944501244)(6055026)(61426038)(61427038)(6041288)(20161123558120)(20161123564045)(20161123560045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:MW2PR2101MB0938;BCL:0;PCL:0;RULEID:;SRVR:MW2PR2101MB0938;
x-forefront-prvs: 0600F93FE1
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39380400002)(39860400002)(366004)(396003)(346002)(376002)(199004)(189003)(54906003)(4326008)(72206003)(22452003)(478600001)(25786009)(66066001)(6436002)(6512007)(14454004)(53936002)(2906002)(6486002)(105586002)(99286004)(10290500003)(3846002)(106356001)(6116002)(305945005)(5660300001)(110136005)(1076002)(36756003)(316002)(2900100001)(2501003)(5250100002)(10090500001)(102836004)(68736007)(2950100002)(26005)(97736004)(186003)(6506007)(8676002)(107886003)(3660700001)(6666003)(7736002)(575784001)(86362001)(81166006)(86612001)(81156014)(76176011)(8936002)(3280700002)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:MW2PR2101MB0938;H:MW2PR2101MB1034.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
x-microsoft-antispam-message-info: P7TrFvNURc179QGN0au5XUWNGaP2DoSOMrzGeNvjmknxtKw+BqR1k1eQJFN7uBsmA2XiqkRzOYuVkmR7EK5AoFP2eicUqdZpDtTUQOHxvbIYAiM79u7aJngRPo3XgmG9w4Zzh/DcVFp+j7nG6gn3HvwSVyfvv/YoOPnKakOeicI=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 083d23cc-22f8-4a96-2807-08d5815792c6
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Mar 2018 22:31:12.9165
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR2101MB0938
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Eric Dumazet <edumazet@google.com>

[ Upstream commit 142c6594acbcc32391af9c15f8cd65c6c177698f ]

Some device drivers reset their stats at down/up events, possibly
fooling bonding stats, since they operate with relative deltas.

It is nearly not possible to fix drivers, since some of them compute the
tx/rx counters based on per rx/tx queue stats, and the queues can be
reconfigured (ethtool -L) between the down/up sequence.

Lets avoid accumulating 'negative' values that render bonding stats
useless.

It is better to lose small deltas, assuming the bonding stats are
fetched at a reasonable frequency.

Fixes: 5f0c5f73e5ef ("bonding: make global bonding stats more reliable")
Signed-off-by: Eric Dumazet <edumazet@google.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/net/bonding/bond_main.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/drivers/net/bonding/bond_main.c b/drivers/net/bonding/bond_mai=
n.c
index 2cb34b0f3856..eadccf498589 100644
--- a/drivers/net/bonding/bond_main.c
+++ b/drivers/net/bonding/bond_main.c
@@ -3276,12 +3276,17 @@ static void bond_fold_stats(struct rtnl_link_stats6=
4 *_res,
 	for (i =3D 0; i < sizeof(*_res) / sizeof(u64); i++) {
 		u64 nv =3D new[i];
 		u64 ov =3D old[i];
+		s64 delta =3D nv - ov;
=20
 		/* detects if this particular field is 32bit only */
 		if (((nv | ov) >> 32) =3D=3D 0)
-			res[i] +=3D (u32)nv - (u32)ov;
-		else
-			res[i] +=3D nv - ov;
+			delta =3D (s64)(s32)((u32)nv - (u32)ov);
+
+		/* filter anomalies, some drivers reset their stats
+		 * at down/up events.
+		 */
+		if (delta > 0)
+			res[i] +=3D delta;
 	}
 }
=20
--=20
2.14.1
