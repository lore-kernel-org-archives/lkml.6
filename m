Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3827995-1521496388-2-3940476800504871646
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
    t=1521496388; b=a57OFGHKKX1lw/AkJZ4gAyaaVwfPXFoBGHJhEUuLofhjQSS
    27i32LcKAHs32aT5WPN3k0ymt3mDl8lV4ixX7ahQiOAB7cpzxnMTIoXgJV65Xo7B
    ZzWGp9p/LDUri/ACJ0kH1bo0v2SiT3EHhFb3pIdgPdjOKC5vQ+aLu9MCvw3ZnKrC
    LgbONDe1JzSc3iB2gfMdR6POiWIX4RDkDMUsZUHr0AHT46nb2INPMJ2wdeMxa0OD
    8ZMOIKSjWdmKPMFWPpK2T1wviD6dL8d91pzjj+Tw7njJxRCillpUeh5EpOzLgdxo
    fDzUunu+AqfkbuqgPaEfAom05cy7Yo4fjuUIcXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1521496388; bh=A0zlzw
    YaL5XKatQ4I+wigv8gEFqcq29IpAEM1yy7eaE=; b=X8crpRLfIPRStqCzYrGviJ
    fPI+LNy/O3WzcNVCQmIFSpE0fIiC09nUAo+aD95kzRvzvdX9TJ0TcQvfHJJzo0FY
    8k2tsO6YbR8RkqSKpBnd9aYihev4eTeuBrAoOznKmJuFvT8OVYGFNJeLpIGggmEx
    O4J0czeg+ySQM4yosfK1WHVmBdxeX2hSxZvlNa884LxDx1y99EaMz4fcQ27IO88P
    3PW/ZBmhUMlLCQ4Mxp0gRb4xdBVdDGjrZK6E5qyEPq2jjX1QYjXpZxNqtsWfs0F/
    T9WOmyNh5SKBWHeR100kkLU1wz2GE3Zq3ARNOzQovVHKzDGqZWtknZma0chCV75g
    ==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=ed+tHdzi x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdduheehucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffuthffkfhfjghitgfggghsphejsehtqhertddttddunecuhfhrohhmpefurghshhgrucfnvghvihhnuceotehlvgigrghnuggvrhdrnfgvvhhinhesmhhitghrohhsohhfthdrtghomheqnecukfhppedvtdelrddufedvrddukedtrdeijedphedvrdduieekrdehgedrvdehvddpfhgvkedtmeemfegulegsmeejlegvjeemleegvggsmeehugeivdenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeoshhtrggslhgvqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpeejjedvleenucevlhhushhtvghrufhiiigvpeduie;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=ed+tHdzi x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdduheehucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffuthffkfhfjghitgfggghsphejsehtqhertddttddunecuhfhrohhmpefurghshhgrucfnvghvihhnuceotehlvgigrghnuggvrhdrnfgvvhhinhesmhhitghrohhsohhfthdrtghomheqnecukfhppedvtdelrddufedvrddukedtrdeijedphedvrdduieekrdehgedrvdehvddpfhgvkedtmeemfegulegsmeejlegvjeemleegvggsmeehugeivdenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeoshhtrggslhgvqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpeejjedvleenucevlhhushhtvghrufhiiigvpeduie;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S964881AbeCSVxE (ORCPT <rfc822;greg@kroah.com>);
        Mon, 19 Mar 2018 17:53:04 -0400
Received: from mail-cys01nam02on0101.outbound.protection.outlook.com ([104.47.37.101]:31200
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S934709AbeCSP5f (ORCPT <rfc822;stable@vger.kernel.org>);
        Mon, 19 Mar 2018 11:57:35 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Mike Christie <mchristi@redhat.com>,
        Nicholas Bellinger <nab@linux-iscsi.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.14 96/97] tcmu: release blocks for partially
 setup cmds
Thread-Topic: [PATCH AUTOSEL for 4.14 96/97] tcmu: release blocks for
 partially setup cmds
Thread-Index: AQHTv5rdF3i80K4sVkimgh1/vVI4Lg==
Date: Mon, 19 Mar 2018 15:56:38 +0000
Message-ID: <20180319155411.12348-96-alexander.levin@microsoft.com>
References: <20180319155411.12348-1-alexander.levin@microsoft.com>
In-Reply-To: <20180319155411.12348-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1096;7:p9/fnW1nx55/NdEgD8EQ1P0xJwY55nmaYPgglhcY92K9mWyQ2sTz702ZZFcvI3QxyUvonQJlCBlg7b6HlXBF+XftajZvKs/WJ7/JfnWD91WliefHFXt5XnRkh8EKBueRPgTqNlu9YWmwEXoFxrN9zVEhrMEneFDfC11kXBSlD0IcCucRuGXDlIIZ2QFCSo9aMtcld4kevY5XvLJVYjGsqaDVb9Y51qfsUZuts5OrAtvoBaQWNu4NTmLG9KboYX0T;20:JJMtZSDioPD6mMrY67u8n87MA/DVg4mdLnSnO60Kdp6jf9Jmv0mmVu7b0y7p4spGM/L9NExLUbCPF/iOixO+rFisiB576vNLusJsMoLErrz5ZBfI3sMcY6reAKucXa+CjRGGolNSNNn9ZzMuhqLpWc3t8DVSo/SM8qcoKA7ttZM=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 51bde32e-a5f6-472f-1332-08d58db21d6e
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB1096;
x-ms-traffictypediagnostic: DM5PR2101MB1096:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB10963CC2D161D1EB6C581D11FBD40@DM5PR2101MB1096.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(5005006)(8121501046)(3231221)(944501300)(52105095)(3002001)(93006095)(93001095)(10201501046)(6055026)(61426038)(61427038)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123564045)(20161123558120)(6072148)(201708071742011);SRVR:DM5PR2101MB1096;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1096;
x-forefront-prvs: 06167FAD59
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(39860400002)(396003)(366004)(376002)(39380400002)(189003)(199004)(86612001)(316002)(26005)(72206003)(4326008)(25786009)(110136005)(10290500003)(86362001)(54906003)(59450400001)(14454004)(53936002)(36756003)(107886003)(3280700002)(22452003)(6506007)(5660300001)(68736007)(186003)(99286004)(478600001)(76176011)(6666003)(10090500001)(102836004)(2950100002)(6116002)(5250100002)(2501003)(97736004)(3660700001)(106356001)(81156014)(81166006)(8936002)(8676002)(7736002)(305945005)(2900100001)(105586002)(3846002)(1076002)(2906002)(6436002)(66066001)(6512007)(6486002)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1096;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: de82n5B9YnguShPxvXDk6vGTLT1sVeBjLvhI7VHqq5Nil4mw8BtK7mJKDU0HlpIuSyV45xWR4I5bRYqW7gIas27poNUcUS2BtglJZgfjGtD/e1CeriN/JuOUdCHqJtmDZtfPu7fvVBcOF8lSvuNXPmzBWhW+lepONL3zGKREGPX8F8Ehfdhc+hK73Hyus8U+0awCWCUOMzdrUVot5Rxnbpi3XJiGCSB2VPKjZkAP0ApFn3jb8HXZdt/qNYhCYGLcUQ2z+ud1yZUngwZavdUvkI0BFSic3b+PZFutXf5j/GUu2r3DoxzcZerID3REEN1zUJWIZDQFT/giDXPb+yRUhg==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 51bde32e-a5f6-472f-1332-08d58db21d6e
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2018 15:56:38.7969
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1096
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Mike Christie <mchristi@redhat.com>

[ Upstream commit 810b8153c4243d2012a6ec002ddd3bbc9a9ae8c2 ]

If we cannot setup a cmd because we run out of ring space
or global pages release the blocks before sleeping. This
prevents a deadlock where dev0 has waiting_blocks set and
needs N blocks, but dev1 to devX have each allocated N / X blocks
and also hit the global block limit so they went to sleep.

find_free_blocks is not able to take the sleeping dev's
blocks becaause their waiting_blocks is set and even
if it was not the block returned by find_last_bit could equal
dbi_max. The latter will probably never happen because
DATA_BLOCK_BITS is so high but in the next patches
DATA_BLOCK_BITS and TCMU_GLOBAL_MAX_BLOCKS will be settable so
it might be lower and could happen.

Signed-off-by: Mike Christie <mchristi@redhat.com>
Signed-off-by: Nicholas Bellinger <nab@linux-iscsi.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/target/target_core_user.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/target/target_core_user.c b/drivers/target/target_core=
_user.c
index 942d094269fb..c4a5fb6f038f 100644
--- a/drivers/target/target_core_user.c
+++ b/drivers/target/target_core_user.c
@@ -796,6 +796,13 @@ tcmu_queue_cmd_ring(struct tcmu_cmd *tcmu_cmd)
 		int ret;
 		DEFINE_WAIT(__wait);
=20
+		/*
+		 * Don't leave commands partially setup because the unmap
+		 * thread might need the blocks to make forward progress.
+		 */
+		tcmu_cmd_free_data(tcmu_cmd, tcmu_cmd->dbi_cur);
+		tcmu_cmd_reset_dbi_cur(tcmu_cmd);
+
 		prepare_to_wait(&udev->wait_cmdr, &__wait, TASK_INTERRUPTIBLE);
=20
 		pr_debug("sleeping for ring space\n");
--=20
2.14.1
