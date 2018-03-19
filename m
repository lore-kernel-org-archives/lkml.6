Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3891247-1521496684-2-15446126167665184964
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
    t=1521496683; b=fT2vGLWKCeCXmGH9eppeyLMaaWYkKxsXUABmGcgQ9EnndDt
    V3y9BGKsivs4X59++U1l5Y+h/dDVU7N/bVn9xuiOcDK8t6VwVgeeUY6e5P0cKnW8
    hmmj6wzl6KrvdefV0bDNYFqitHLMYgWRBV0bio+4RA7VnETIu+xR8y2YOkuHxU5y
    A6PeKrGAQMgXNKTaVfbTYWyLQMY/za3TSaQSUu1/G7zlVklg8cI+KIlkS9M7uOva
    Tq4rrPmM23/WLRnydVSndY8lC2DPD5fMUAa3QeTDOdsEREsBY70h04VHmYo4w62g
    Rwd0FRmJXL+MeIsgreMkmTGvaEj42fM76SspP9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1521496683; bh=GtB6lB
    U3wYEAXjEhIesVOD8sRntlUdsM9JaxDEFIT6M=; b=kAVCHdV81DxCQDsJsATex9
    0qx/vzTUzFGNoIQbeKyEC5ZPoMyosSP4Jxz8AeGrcUwfjQ9NrJxCilEw3rlPy+SN
    /6sVmNw9Hxp1aReQAEA80eyfSO69DNbQCMNUUxnLulfACCyjzTkp2bU9rB/4abxc
    Tad/8TpLBATt2Ys36/QEfRmzf142y63M412qZaqNg3ZyMARVMtrTmnP9+IaCNMej
    6RjnKAYDK9BWO8MJfVfq39ooSwWko+xYwQtiJO0hNx8ATQbHneO6GyvKeTNnQ21K
    BzC4XFU+WfiVAsj7+Yq4CRT6SEyb3rXpAv1n3DerDJoP/QcECdBOGgurfPOIvR+g
    ==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=DPapDHMu x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdduheeiucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffuthffkfhfjghitgfggghsphejsehtqhertddttddunecuhfhrohhmpefurghshhgrucfnvghvihhnuceotehlvgigrghnuggvrhdrnfgvvhhinhesmhhitghrohhsohhfthdrtghomheqnecukfhppedvtdelrddufedvrddukedtrdeijedphedvrdduieekrdehgedrvdehvddpfhgvkedtmeemfegulegsmeejlegvjeemleegvggsmeehugeivdenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeoshhtrggslhgvqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpeejkeejleenucevlhhushhtvghrufhiiigvpeduud;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=DPapDHMu x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdduheeiucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffuthffkfhfjghitgfggghsphejsehtqhertddttddunecuhfhrohhmpefurghshhgrucfnvghvihhnuceotehlvgigrghnuggvrhdrnfgvvhhinhesmhhitghrohhsohhfthdrtghomheqnecukfhppedvtdelrddufedvrddukedtrdeijedphedvrdduieekrdehgedrvdehvddpfhgvkedtmeemfegulegsmeejlegvjeemleegvggsmeehugeivdenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeoshhtrggslhgvqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpeejkeejleenucevlhhushhtvghrufhiiigvpeduud;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S964873AbeCSV5r (ORCPT <rfc822;greg@kroah.com>);
        Mon, 19 Mar 2018 17:57:47 -0400
Received: from mail-by2nam01on0117.outbound.protection.outlook.com ([104.47.34.117]:58464
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S934558AbeCSP4h (ORCPT <rfc822;stable@vger.kernel.org>);
        Mon, 19 Mar 2018 11:56:37 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Tang Junhui <tang.junhui@zte.com.cn>,
        Michael Lyle <mlyle@lyle.org>, Jens Axboe <axboe@kernel.dk>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.14 66/97] bcache: stop writeback thread after
 detaching
Thread-Topic: [PATCH AUTOSEL for 4.14 66/97] bcache: stop writeback thread
 after detaching
Thread-Index: AQHTv5rE4a8/xsPU7USliLbnrWVvYQ==
Date: Mon, 19 Mar 2018 15:55:56 +0000
Message-ID: <20180319155411.12348-66-alexander.levin@microsoft.com>
References: <20180319155411.12348-1-alexander.levin@microsoft.com>
In-Reply-To: <20180319155411.12348-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1031;7:C04ztbrgc1e05HxCP00R8B+AbwtyOiZvUwps1adh+tOBBOreH8NBk56UsCsNrJfEt8Z4qUwqInNB/Gny0kc4Uf6ytuIzYEyvRz+wxF8LaZvfTuX+InJjBowFuDAXropDW6fD+BlcrDRYT/ufeMp5pzF10H7PgGUOTnl1qTbgl8uXd9JbQnCrN+UVaJFmaIdvdapkRMDIs+yKTFFqsH4TKmVW4UVnCNMLdHcQ36STOb0LO/PKRQ2B3X9eton/nEDb;20:+Pha9ekLZsqGXzudHzgnDFw/pRxiMkCkBB0IzXU9MYahx+VCR4LvqlmwtMA+ziLqKFsxaMqbuha3Qty9zlA7mv0n6NTBeswMP0bXfS2APJFtITBTRNdRKV2ZhCvt8AKhYT0aFeOuVvLwbaQadUXQW+7WEhVwbrP1UqaRBZc4Zeo=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: f1179995-8a76-47a1-0a66-08d58db1fc7f
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB1031;
x-ms-traffictypediagnostic: DM5PR2101MB1031:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB10312B185B5C8FA2CB9AF266FBD40@DM5PR2101MB1031.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(10201501046)(3231221)(944501300)(52105095)(3002001)(6055026)(61426038)(61427038)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123562045)(20161123558120)(20161123560045)(6072148)(201708071742011);SRVR:DM5PR2101MB1031;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1031;
x-forefront-prvs: 06167FAD59
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(366004)(346002)(396003)(39860400002)(39380400002)(199004)(189003)(25786009)(6506007)(59450400001)(66066001)(99286004)(76176011)(10290500003)(54906003)(68736007)(3660700001)(97736004)(22452003)(575784001)(107886003)(53936002)(86362001)(110136005)(2501003)(5890100001)(5250100002)(86612001)(14454004)(478600001)(72206003)(316002)(102836004)(26005)(186003)(6116002)(3846002)(7736002)(2950100002)(10090500001)(6436002)(3280700002)(6512007)(6666003)(2900100001)(8676002)(8936002)(36756003)(106356001)(105586002)(4326008)(5660300001)(305945005)(1076002)(81156014)(6486002)(81166006)(2906002)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1031;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: rjXVhWPnXszBHpIPzFdKMnep/mL4b5OHGY2vAd1vDTvhcNWP/hT/jATjsBrPE9xLz9k8qKDClVYcOyV/AH9sjA9KKzZ2o9DAciUsmTbj1q+yQ2EKbNAKpVHThlYm21VKI3jGtoHnZ4cVlidR+5OxdMSNJdDd+Ixvov2nMRyvaWizLC3rT/qXrKqBFWxKEpU6kVIqp1Z3EXkU9GerrRLILXfaFMH2ihQvmT3FeVDwDMxcTYTxh9oMq+WWkh0mvQeAv3/6+EAP3rCwhzAJoTp+pBr+61JBoZShqh0ogn+Rc6/EgS6Ruy9lSFzNruKmPnaJPW15tfJTglpMw/B2qwji6Q==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f1179995-8a76-47a1-0a66-08d58db1fc7f
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2018 15:55:56.5447
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1031
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
index 9417170f180a..5d0430777dda 100644
--- a/drivers/md/bcache/super.c
+++ b/drivers/md/bcache/super.c
@@ -893,6 +893,12 @@ static void cached_dev_detach_finish(struct work_struc=
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
