Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3384037-1521481604-2-9985273841574165887
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
    t=1521481603; b=sro20uPOZUOBVXHW40BMuo6IGi5dbnOkR4I2vYAYytKGhDd
    5p/YWi3rxfKsL4RALiT5zGiNf08kcDX5Mg3B9BQzHL0EDrkXGuG/uABDaw15PEmT
    op0hiB6FVoIBPdWL4HulbeRa69dwStGjJqBCmc1BC2AEEsk5q9zrO0Ip96PZp5aC
    GsZ+Z+O1a+cu4EG+zO/Pm5rluDCdJcmziCQ3bdBW4xEkxDT8GNlmLd8S5I88zcSX
    cS9MTcG9VxshBW/l0c2foYFHdfJJTgzOrlt1AUEcZBZUlrhQZ1l6J4BxAz+uIXdw
    blgIDx3Dgzezsoj/X8bx6IQHrMY7w9CfsZ2AkZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1521481603; bh=WWLU0g
    I/StaatZYcPyy2wYE4L989bZrvOd6WzqVQw90=; b=J+S6VP1kRPKFQdze4XVK0m
    mz1gEmtgcYHhBZr7/+vLvqNZkVpobXcrXh5W/Y7/SaI5TLsgK7jkJBiUbsPyNarG
    NNjTYT1Wrg+oEs83J1Ks+VWduJwhAPgg9T7JDsckTxfNNm/HI5hjMaUmurW00RA9
    0xVMv10mz5bhCC068yLjfuUcZi/fUN7DC/jTH8veuXw6XSvsLyRqTpph2z5N9T9o
    9RbPtxhvhxMmaY6Il/WO1rTnawG63Za20LNNr79ote8NO0eCtfzl1pL7BvzLll/u
    GVi8ct4Va8z/XXiq5AjdpboStvDCOGaHr7rRBM7zgEHk/R98dcKJ5JI3BxKJno7w
    ==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=UBsv5DIl x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgddutdehucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffuthffkfhfjghitgfggghsphejsehtqhertddttddunecuhfhrohhmpefurghshhgrucfnvghvihhnuceotehlvgigrghnuggvrhdrnfgvvhhinhesmhhitghrohhsohhfthdrtghomheqnecukfhppedvtdelrddufedvrddukedtrdeijedphedvrdduieekrdehgedrvdehvddpfhgvkedtmeemfegulegsmeejlegvjeemleegvggsmeehugeivdenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeoshhtrggslhgvqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpeekjeekieenucevlhhushhtvghrufhiiigvpeduud;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=UBsv5DIl x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgddutdehucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffuthffkfhfjghitgfggghsphejsehtqhertddttddunecuhfhrohhmpefurghshhgrucfnvghvihhnuceotehlvgigrghnuggvrhdrnfgvvhhinhesmhhitghrohhsohhfthdrtghomheqnecukfhppedvtdelrddufedvrddukedtrdeijedphedvrdduieekrdehgedrvdehvddpfhgvkedtmeemfegulegsmeejlegvjeemleegvggsmeehugeivdenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeoshhtrggslhgvqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpeekjeekieenucevlhhushhtvghrufhiiigvpeduud;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965872AbeCSRou (ORCPT <rfc822;greg@kroah.com>);
        Mon, 19 Mar 2018 13:44:50 -0400
Received: from mail-bl2nam02on0126.outbound.protection.outlook.com ([104.47.38.126]:2671
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S935017AbeCSQFi (ORCPT <rfc822;stable@vger.kernel.org>);
        Mon, 19 Mar 2018 12:05:38 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Netanel Belgazal <netanel@amazon.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.9 247/281] net: ena: fix race condition between
 submit and completion admin command
Thread-Topic: [PATCH AUTOSEL for 4.9 247/281] net: ena: fix race condition
 between submit and completion admin command
Thread-Index: AQHTv5u4LbdBa49ttkevXPB0/6P5Zw==
Date: Mon, 19 Mar 2018 16:02:46 +0000
Message-ID: <20180319155742.13731-247-alexander.levin@microsoft.com>
References: <20180319155742.13731-1-alexander.levin@microsoft.com>
In-Reply-To: <20180319155742.13731-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0727;7:sBX4Txero0wKLRmuPVzyDe6G45EN1HGhIS0m7KE2MhVi6nrXDtI3x/iBdLiPU/TKjA9aph0Ce4qejT3mbodAAMC5MdeWtw453R1/sfKMNWIIE8iEaAQxpmTG02x9OOyMSfNgO2cTSk3WsPlh0nRlZGJrmLL8S753LVU9rkmFim5GjSvFaU8Z8tkAcZOAX0X2WQkgDAc7LT8RwdahJR95kjDejwTxwr9nVWZzjlhZM1YcU0xk2+BsJF/2AoHhfHW3;20:ousYYa109gvJiH62eL684d/4aFERNtrjNF7IOTyaNAtNKqt4+UCn4+pt8QibCXBlHLUuJBlPhb5nKrEcS+7dqIbNjIPNjNR5jl6+IJswQ7p5FvuXZQ+2+i1QC5eLRewJkpVZPj6Dv4xi5P62Tg0rHzq4+AxwOWJA+Bs/u6FC0lw=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 1eb04c1a-38ad-4184-1b80-08d58db33ca3
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0727;
x-ms-traffictypediagnostic: DM5PR2101MB0727:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB0727A8D9F94FB07494CE1DF7FBD40@DM5PR2101MB0727.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(33061846794335)(47284530071512);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(5005006)(8121501046)(3231221)(944501300)(52105095)(3002001)(93006095)(93001095)(10201501046)(6055026)(61426038)(61427038)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123564045)(20161123558120)(6072148)(201708071742011);SRVR:DM5PR2101MB0727;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0727;
x-forefront-prvs: 06167FAD59
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(376002)(39380400002)(366004)(346002)(39860400002)(189003)(199004)(4326008)(53936002)(6512007)(81156014)(305945005)(81166006)(14454004)(6486002)(106356001)(76176011)(2900100001)(6436002)(6506007)(68736007)(22452003)(66066001)(3280700002)(6116002)(59450400001)(110136005)(8676002)(54906003)(10090500001)(3846002)(316002)(2950100002)(26005)(575784001)(86362001)(105586002)(6666003)(99286004)(36756003)(478600001)(2501003)(186003)(5250100002)(86612001)(97736004)(107886003)(7736002)(1076002)(102836004)(72206003)(5660300001)(25786009)(10290500003)(2906002)(3660700001)(8936002)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0727;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: 1U+1T5biyNk1SefDcpc1ziwtrKKizPVzOJ5gQeSycGdfvGNHqPypx2lk0t1nbE1FbxH4EyuUyXaX/ZI7hFzTd5yPHp5mmMJutCfPKHssAD2uDsALai59nZg3QhmGzUO4GB3BtFEn6icd6trRls5fEtkWVNIPl1r8+TIpUdR8Nmy2R2SIwaRSXtf49XaHUVzH51UrCg9UzEOTy3dQepKwM29eDLpciJ6EabQ7tzebG7xIS9OpURloCh1PVlKlRuo3V6WZU8B3ODn4noRWSl5j72ZBjXLa+mMPHJEAT5WZdmtG9iay2cfNU1/GHxkt4Ss3N15eEeEoB5AL3dAIGq5VlA==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1eb04c1a-38ad-4184-1b80-08d58db33ca3
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2018 16:02:46.8854
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0727
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Netanel Belgazal <netanel@amazon.com>

[ Upstream commit 661d2b0ccef6a63f48b61105cf7be17403d1db01 ]

Bug:
"Completion context is occupied" error printout will be noticed in
dmesg.
This error will cause the admin command to fail, which will lead to
an ena_probe() failure or a watchdog reset (depends on which admin
command failed).

Root cause:
__ena_com_submit_admin_cmd() is the function that submits new entries to
the admin queue.
The function have a check that makes sure the queue is not full and the
function does not override any outstanding command.
It uses head and tail indexes for this check.
The head is increased by ena_com_handle_admin_completion() which runs
from interrupt context, and the tail index is increased by the submit
function (the function is running under ->q_lock, so there is no risk
of multithread increment).
Each command is associated with a completion context. This context
allocated before call to __ena_com_submit_admin_cmd() and freed by
ena_com_wait_and_process_admin_cq_interrupts(), right after the command
was completed.

This can lead to a state where the head was increased, the check passed,
but the completion context is still in use.

Solution:
Use the atomic variable ->outstanding_cmds instead of using the head and
the tail indexes.
This variable is safe for use since it is bumped in get_comp_ctx() in
__ena_com_submit_admin_cmd() and is freed by comp_ctxt_release()

Fixes: 1738cd3ed342 ("Add a driver for Amazon Elastic Network Adapters (ENA=
)")
Signed-off-by: Netanel Belgazal <netanel@amazon.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/net/ethernet/amazon/ena/ena_com.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/amazon/ena/ena_com.c b/drivers/net/ethern=
et/amazon/ena/ena_com.c
index 564b556baba9..f4c107b66af4 100644
--- a/drivers/net/ethernet/amazon/ena/ena_com.c
+++ b/drivers/net/ethernet/amazon/ena/ena_com.c
@@ -232,11 +232,9 @@ static struct ena_comp_ctx *__ena_com_submit_admin_cmd=
(struct ena_com_admin_queu
 	tail_masked =3D admin_queue->sq.tail & queue_size_mask;
=20
 	/* In case of queue FULL */
-	cnt =3D admin_queue->sq.tail - admin_queue->sq.head;
+	cnt =3D atomic_read(&admin_queue->outstanding_cmds);
 	if (cnt >=3D admin_queue->q_depth) {
-		pr_debug("admin queue is FULL (tail %d head %d depth: %d)\n",
-			 admin_queue->sq.tail, admin_queue->sq.head,
-			 admin_queue->q_depth);
+		pr_debug("admin queue is full.\n");
 		admin_queue->stats.out_of_space++;
 		return ERR_PTR(-ENOSPC);
 	}
--=20
2.14.1
