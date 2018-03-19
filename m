Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3907919-1521498168-2-8271858391764041225
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
    t=1521498167; b=fFa2dXiRh47VAS4nRzB4yN2YmglcsUOk4TQNuiNiiYlJDJV
    XkXu70k47qarfvPhnhJPKyy1MlmL4CaKhY/sm//Uh0pFSXo0O/T2nh4gpzk8cEGA
    6TXhqmx+Vbn3+ApmS3N16hArPbHLCYKjSgCVIeUIlWl6lyEHsva3QeA+W2MXsglx
    baaeHi4P3iR09Fjpaqz5RiVHSN06jguaJ5AbQGZQwI4JJqeHZqtt/5kCMAz4uH5/
    ZBRcPhYMlPVyiE3ROLoEVInL4So1nqj1amK1cplj3KhcBse3HlVc25aOFo2yXOcd
    DAGUY5Khk+PzaDc4t6+uLwsnrMGgATw4gJs01EA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1521498167; bh=FrE4ph
    wodUbXKYEqNf2kcHLAl2XxLUUUbjWl4yxEF94=; b=VekzGVVsYRMlyNsVl1P/EG
    wq5BtItXxLIX0gA/yOGXWI6A+dPrONLyM51e4cUY/tVD/TYtL5NUfhLgolBqvKlB
    cddz291So5+ZYi5KmSRgKFON89yZnDAlxtpVZn1FhrEASJTdlic15HHwZphPzofu
    2Dp2LmBp6JUn4RNdGQfKVuYg5vzrtGsnsU4eKWXAV5tKtRb5PKfLnhMnSAyn/xG2
    oIBESgtlyJJaDnuZ9QSr2KQ97bBlwp9LuAl//TiId2TxyKBxa9VwbFMjov7LFFqh
    NHSMiQocd7gJLMxWMK8c6hsxYW1ZXE/7XAWhdc6Hb1lZoQSQgjyos+QTThcugrYw
    ==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=AWp4BVbQ x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdduieduucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffuthffkfhfjghitgfggghsphejsehtqhertddttddunecuhfhrohhmpefurghshhgrucfnvghvihhnuceotehlvgigrghnuggvrhdrnfgvvhhinhesmhhitghrohhsohhfthdrtghomheqnecukfhppedvtdelrddufedvrddukedtrdeijedphedvrdduieekrdehgedrvdehvddpfhgvkedtmeemfegulegsmeejlegvjeemleegvggsmeehugeivdenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeoshhtrggslhgvqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpeejleegheenucevlhhushhtvghrufhiiigvpeegfe;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=AWp4BVbQ x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdduieduucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffuthffkfhfjghitgfggghsphejsehtqhertddttddunecuhfhrohhmpefurghshhgrucfnvghvihhnuceotehlvgigrghnuggvrhdrnfgvvhhinhesmhhitghrohhsohhfthdrtghomheqnecukfhppedvtdelrddufedvrddukedtrdeijedphedvrdduieekrdehgedrvdehvddpfhgvkedtmeemfegulegsmeejlegvjeemleegvggsmeehugeivdenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeoshhtrggslhgvqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpeejleegheenucevlhhushhtvghrufhiiigvpeegfe;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933997AbeCSWWo (ORCPT <rfc822;greg@kroah.com>);
        Mon, 19 Mar 2018 18:22:44 -0400
Received: from mail-dm3nam03on0129.outbound.protection.outlook.com ([104.47.41.129]:48439
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S933898AbeCSPtK (ORCPT <rfc822;stable@vger.kernel.org>);
        Mon, 19 Mar 2018 11:49:10 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Tang Junhui <tang.junhui@zte.com.cn>,
        Michael Lyle <mlyle@lyle.org>, Jens Axboe <axboe@kernel.dk>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.15 083/124] bcache: stop writeback thread after
 detaching
Thread-Topic: [PATCH AUTOSEL for 4.15 083/124] bcache: stop writeback thread
 after detaching
Thread-Index: AQHTv5m7sMeYrX4/U0KRwWelry1bXA==
Date: Mon, 19 Mar 2018 15:48:31 +0000
Message-ID: <20180319154645.11350-83-alexander.levin@microsoft.com>
References: <20180319154645.11350-1-alexander.levin@microsoft.com>
In-Reply-To: <20180319154645.11350-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0936;7:iCMFqLxygl1jtrBqeKULCThZZawdeX5jvQF+XNB7QvgfIIJsCGUlkObnzppE5v7E3JVf84YoQAxMmRc6uB/IkB9XHr96/iRnyy17SXEzVGsxdKl0Ok2AMkPpWyQXi/y7awZb7Pqw4dM1n8VFOH44LGqlXo2CPismy49Fl/POcPgnkQ2qxHP4/LKbl1YCnaU1X+/eBUzh3ysyYNkf2Xj3p3bw0wv6Xq/N87YjBtl2N0vgn+sDDNyp9FSsYYoRbudB;20:TNWMHDhuaAZlgAIQCT+XBNW1J612iFAKNxipLp3mw2/jY4lJ65G2i59Kd9fBVY0aoKxbi8Ru93DXBa5zZYIQGE849baDMDibXk6VFCP0mjN64jRbJJ5qZVlTUR7fW9NONVVzkg/HI9PkZPS1x/fCcHv7woTjbSbrc0FvKMAz63A=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: feb90240-6199-4369-1b55-08d58db0efc4
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0936;
x-ms-traffictypediagnostic: DM5PR2101MB0936:
x-microsoft-antispam-prvs: <DM5PR2101MB0936941B0EFF595A10FB5AB9FBD40@DM5PR2101MB0936.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(5005006)(8121501046)(10201501046)(3002001)(93006095)(93001095)(3231221)(944501300)(52105095)(6055026)(61426038)(61427038)(6041310)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123560045)(20161123562045)(6072148)(201708071742011);SRVR:DM5PR2101MB0936;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0936;
x-forefront-prvs: 06167FAD59
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(979002)(39380400002)(346002)(39860400002)(366004)(376002)(396003)(199004)(189003)(2900100001)(3280700002)(2950100002)(10290500003)(66066001)(106356001)(76176011)(86612001)(6666003)(478600001)(5250100002)(6512007)(6486002)(107886003)(36756003)(97736004)(72206003)(25786009)(6436002)(53936002)(7736002)(5890100001)(2501003)(54906003)(110136005)(105586002)(10090500001)(2906002)(86362001)(305945005)(5660300001)(316002)(8676002)(6346003)(1076002)(3846002)(3660700001)(81156014)(4326008)(14454004)(26005)(6116002)(102836004)(8936002)(81166006)(6506007)(186003)(22452003)(59450400001)(99286004)(68736007)(575784001)(22906009)(217873001)(969003)(989001)(999001)(1009001)(1019001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0936;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-message-info: rwtJLlElJyiEEQZwbY5RIskXcpP4DItpN3eFqjHWPHS58x1arojwIQGHmh6UUykkDFzCTaygq3TbP/tftr7HqxOqrDJEnLPgkmgKc9hBffr/lgp1pDhANv+1+MuGsJN5aF1h2q+ZFgd5EIljsa/Q8xCBeAoYENQJ6MwbzfMDY5TkiztXgHvxWcLl4uO7swxI42uVfoPpcAF8KBRBjAynczKy4g6Sit1wd259fSdoMR9NNsNASO/o2mFszC1YBjX9K111HjmQn6eeR3gFXnTfFScPC1Sysd5ctjD+F0eZuqAo26rEqx9R8WAHOx1b0ySX/jPCq5JkJeudNQxprvjNdw==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: feb90240-6199-4369-1b55-08d58db0efc4
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2018 15:48:31.3807
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0936
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
index 14bdaf1cef2c..47785eb22aab 100644
--- a/drivers/md/bcache/super.c
+++ b/drivers/md/bcache/super.c
@@ -906,6 +906,12 @@ static void cached_dev_detach_finish(struct work_struc=
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
