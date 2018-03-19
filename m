Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3372889-1521481253-2-15115659226208736988
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
    t=1521481252; b=X96IfYWPZbVvWa9cNwVbolPN7sO2dVBYAfTD3hd4HUPjhfy
    6Z3qT67ob0JT2Pi+fwV1fefI4k5w0v0nZ308gEI9RSgcONGDhjmmiwVMtW1KBpes
    CcXA8bebCZtorZiOznbHFcEtd+8zrym93pTJBxygp6oh2b83Dbc5qieLXjBWEMLL
    +ADmYOJZaL5BP1PlYOS9LtKLrGvTw4GXtI7/QjYlja8HTY61ScvjPFEPwm4e2agD
    zs9pCrDbEo59/ZCk1BcFZejoHY4gaj5RCJ9dV5kUcc58+fEdlDtALjwq0rwrt/la
    xz9FdSdEnRdIcpWMk7/IPqWhWiOk9o/QQWLc+bw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1521481252; bh=ngvIMw
    CGUK+3bII3SNfTB4898s8l4ziO7wCwfGK3kq0=; b=HRm4MHfhO7/fMB7neEkdww
    RHjTOdpwym/mycRbavXsuVWcBBLdQMBwRRq7TXf5AOUV9t+HVvrsUv0Y5o1qvWHM
    Zs7mLN2HsAqyIGumjZ8yPM5bAIVtIuEiiFFlDrPSuoLnVmhPgQsT/139cb37jIzF
    b21cTqmAlsdXyUT8VveuXNAyoybsUn18a0W4zyI9A08BP7qPXBaUQAMNsrJtL6cD
    RRHAnPAoqd9cdaij5P97oI2eXTE92U4Spv9ivadRaV9WNTUEx6wEcMBEUWNUQHFV
    bk/IcCKLbkJQbxLLeKQaYGeEdaxCz6NRhtbb0vFsSNH3J/8WAAG/6/efZkLqhv+w
    ==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=NAQqjQIn x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgddutdegucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffuthffkfhfjghitgfggghsphejsehtqhertddttddunecuhfhrohhmpefurghshhgrucfnvghvihhnuceotehlvgigrghnuggvrhdrnfgvvhhinhesmhhitghrohhsohhfthdrtghomheqnecukfhppedvtdelrddufedvrddukedtrdeijedphedvrdduieekrdehgedrvdehvddpfhgvkedtmeemfegulegsmeejlegvjeemleegvggsmeehugeivdenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeoshhtrggslhgvqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpeejkeekudenucevlhhushhtvghrufhiiigvpeef;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=NAQqjQIn x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgddutdegucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffuthffkfhfjghitgfggghsphejsehtqhertddttddunecuhfhrohhmpefurghshhgrucfnvghvihhnuceotehlvgigrghnuggvrhdrnfgvvhhinhesmhhitghrohhsohhfthdrtghomheqnecukfhppedvtdelrddufedvrddukedtrdeijedphedvrdduieekrdehgedrvdehvddpfhgvkedtmeemfegulegsmeejlegvjeemleegvggsmeehugeivdenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeoshhtrggslhgvqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpeejkeekudenucevlhhushhtvghrufhiiigvpeef;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965556AbeCSQGG (ORCPT <rfc822;greg@kroah.com>);
        Mon, 19 Mar 2018 12:06:06 -0400
Received: from mail-dm3nam03on0092.outbound.protection.outlook.com ([104.47.41.92]:19136
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S965843AbeCSQGC (ORCPT <rfc822;stable@vger.kernel.org>);
        Mon, 19 Mar 2018 12:06:02 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Tang Junhui <tang.junhui@zte.com.cn>,
        Michael Lyle <mlyle@lyle.org>, Jens Axboe <axboe@kernel.dk>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.9 263/281] bcache: stop writeback thread after
 detaching
Thread-Topic: [PATCH AUTOSEL for 4.9 263/281] bcache: stop writeback thread
 after detaching
Thread-Index: AQHTv5vENKI7BK0lqEeUSD/SK6wnWA==
Date: Mon, 19 Mar 2018 16:03:05 +0000
Message-ID: <20180319155742.13731-263-alexander.levin@microsoft.com>
References: <20180319155742.13731-1-alexander.levin@microsoft.com>
In-Reply-To: <20180319155742.13731-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1015;7:fDLZfakU2yPIAtYgHBgsPolKlFl03A5zYFTa+zMiJOkck5pSjNeutoUtySPsOmJ57moRFuekmYBdinUDaRyRVHp9BTbz8dVCL2qI7IzIAG0TwLgcbpGsPIMo6ac1VDjj6fzG3815lZR4c8dHWvGPcsEJUXtzeQ2syyUI2LtSzRkgpOXFOR0rNavqGE90gH8aWASQg041KBE9TTTzu5PTg7MXymh0h0n6nfP+JXaRrnnftZ6O7sX/DU8s1mpKifde;20:K7lO7bCNZwf/33TAmP3bVNQYhvD/uj0o08esh6P6/Co2K0FDclh/BchBjZ1uMYYcFu1I7NKYXV0XLCKbTJ/5cWZiqKZbhtdkR9QL3jqQ/LRzZIqAYiBEVebgQnsW37F5/GEYFfJKvfmlNZa2hc3A8UiRpxecCzLWok15canpZso=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 393fee53-5f11-4c1b-bb80-08d58db3426a
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB1015;
x-ms-traffictypediagnostic: DM5PR2101MB1015:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB1015A59DCE86B1DC59B6E31CFBD40@DM5PR2101MB1015.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(10201501046)(3231221)(944501300)(52105095)(3002001)(6055026)(61426038)(61427038)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123562045)(20161123558120)(20161123560045)(6072148)(201708071742011);SRVR:DM5PR2101MB1015;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1015;
x-forefront-prvs: 06167FAD59
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(39380400002)(376002)(39860400002)(396003)(346002)(199004)(189003)(6506007)(106356001)(107886003)(2950100002)(6666003)(22452003)(316002)(10090500001)(59450400001)(76176011)(8676002)(81156014)(105586002)(81166006)(3280700002)(3660700001)(305945005)(7736002)(2501003)(6436002)(68736007)(6486002)(5890100001)(5250100002)(8936002)(6116002)(3846002)(2906002)(1076002)(186003)(36756003)(25786009)(10290500003)(4326008)(97736004)(72206003)(2900100001)(99286004)(53936002)(5660300001)(6512007)(14454004)(478600001)(102836004)(66066001)(86612001)(86362001)(26005)(54906003)(110136005)(575784001)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1015;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: Za++N5MP4sp9OmEgk4QFMDviFduPe0Vd7uiVX1IO4/mtpvjct5VOyosNEL5Hk3QsgiY4MP5mhu4iWy1VwoGBhsyLZ+0gElSqwsoRNluiBmuW5dOjo3NYISmGiNS4MYpL5b6ZsBRaBRvPOioykE9jTIhWich3zQzVE90GxHhHWaBSq2/XRWkggEUwq/pmEO602QeGLZxW1akAmoHHTxgg1POy8pehaI++nfvwNbolgmt4b96RSFTCX4GVPu021suTQyqTenERmW1sxvogkoGvC0P8hYghPqhS3e9HOzMg4CWPhYxvQLTOMA3PXYqBFVoXMrzYO/SCXH1ky4kk9l954w==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 393fee53-5f11-4c1b-bb80-08d58db3426a
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2018 16:03:05.8150
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1015
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Tang Junhui <tang.junhui@zte.com.cn>

[ Upstream commit 8d29c4426b9f8afaccf28de414fde8a722b35fdf ]

Currently, when a cached device detaching from cache, writeback thread is
not stopped, and writeback_rate_update work is not canceled. For example,
after the following command:
echo 1 >/sys/block/sdb/bcache/detach
you can still see the writeback thread. Then you attach the device to the
cache again, bcache will create another writeback thread, for example,
after below command:
echo  ba0fb5cd-658a-4533-9806-6ce166d883b9 > /sys/block/sdb/bcache/attach
then you will see 2 writeback threads.
This patch stops writeback thread and cancels writeback_rate_update work
when cached device detaching from cache.

Compare with patch v1, this v2 patch moves code down into the register
lock for safety in case of any future changes as Coly and Mike suggested.

[edit by mlyle: commit log spelling/formatting]

Signed-off-by: Tang Junhui <tang.junhui@zte.com.cn>
Reviewed-by: Michael Lyle <mlyle@lyle.org>
Signed-off-by: Michael Lyle <mlyle@lyle.org>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/md/bcache/super.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/md/bcache/super.c b/drivers/md/bcache/super.c
index 28ce342348a9..8a5fb63ad1d6 100644
--- a/drivers/md/bcache/super.c
+++ b/drivers/md/bcache/super.c
@@ -892,6 +892,12 @@ static void cached_dev_detach_finish(struct work_struc=
t *w)
=20
 	mutex_lock(&bch_register_lock);
=20
+	cancel_delayed_work_sync(&dc->writeback_rate_update);
+	if (!IS_ERR_OR_NULL(dc->writeback_thread)) {
+		kthread_stop(dc->writeback_thread);
+		dc->writeback_thread =3D NULL;
+	}
+
 	memset(&dc->sb.set_uuid, 0, 16);
 	SET_BDEV_STATE(&dc->sb, BDEV_STATE_NONE);
=20
--=20
2.14.1
