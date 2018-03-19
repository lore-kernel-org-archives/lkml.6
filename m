Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3230508-1521476312-2-1410787978137901510
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
    t=1521476312; b=PI6Xo8HXeH9nD0kClL9emEn88wNQZpjrg06CFWeUTF8TlPX
    1QJi1SHi15m4z2lKKMnjTMezaWw2TLeFx5TYP23Q2RV/oOpBiOvg8P4GVvq8XqXl
    WWEsRXJvVbahD1aFtciWNwT+fC9bsJbx5lBi3YbKp5cEgWHaOqGvz4PsrtDk3fBT
    +veYVWc1KUuYep/zvPlO1NeecfCngO+NremaCotNv2mwsgo/+2iLVPlThmZ0N8my
    F/s8jliCQGaKFNa9TE8KOkYTwnLQXuINsMqp2tAet78ExXM72kCQtBDZmXmLpBAl
    QLhHQ6UXFmYVpBIEpQxZDN/A8+SnCeJYvAElt9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1521476312; bh=HD6h85
    osBmA1YlTtO/fs9HlgznG9Qa8ixF5WtQTrUDg=; b=GzqpWDYhJQQX5dDBFHC199
    2yaM4lxnxd5Ur//Yeg6ofz6tSkzTrIFU/onGsgJcJyDboTBJokS7mi5HSlsJpeAu
    V9YnsNgJJYNMgQSlCv2DRvVYRNeMar9zt9pydH8JpjCLA7ezJ8ODd+Qc9VPck3Xe
    F86cz4j+T96RRaLV3+8hkVdrJYkQ0wxURRy0SstCyEG+sQdBiYcdj0UMRELPpmcW
    RdNlZpCtf/NmaY71yc3XnvEAxlOHdYBaujjikc2Vm9KN2H/hY0dAmHt7ude1OG/7
    vY0UNBK/BwAQ6P+lqyqEJVfpvR4Chybbr957eIYGKn0BXVxvM4wv3LEtRyK/mt9A
    ==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=E4BMBMa4 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdekieculddtuddrgedtfedrtddtmdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvufhtfffkfhgjihgtgfggshhpjeesthhqredttddtudenucfhrhhomhepufgrshhhrgcunfgvvhhinhcuoeetlhgvgigrnhguvghrrdfnvghvihhnsehmihgtrhhoshhofhhtrdgtohhmqeenucfkphepvddtledrudefvddrudektddrieejpdehvddrudeikedrheegrddvhedvpdhfvgektdemmeefugelsgemjeelvgejmeelgegvsgemheguiedvnecurfgrrhgrmhepihhnvghtpedvtdelrddufedvrddukedtrdeijedphhgvlhhopehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhmrghilhhfrhhomhepoehsthgrsghlvgdqohifnhgvrhesvhhgvghrrdhkvghrnhgvlhdrohhrghequceuqfffjgepkeeukffvoffkoffgucfukfgkgfepjeekkeefnecuvehluhhsthgvrhfuihiivgepiedu;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=E4BMBMa4 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdekieculddtuddrgedtfedrtddtmdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvufhtfffkfhgjihgtgfggshhpjeesthhqredttddtudenucfhrhhomhepufgrshhhrgcunfgvvhhinhcuoeetlhgvgigrnhguvghrrdfnvghvihhnsehmihgtrhhoshhofhhtrdgtohhmqeenucfkphepvddtledrudefvddrudektddrieejpdehvddrudeikedrheegrddvhedvpdhfvgektdemmeefugelsgemjeelvgejmeelgegvsgemheguiedvnecurfgrrhgrmhepihhnvghtpedvtdelrddufedvrddukedtrdeijedphhgvlhhopehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhmrghilhhfrhhomhepoehsthgrsghlvgdqohifnhgvrhesvhhgvghrrdhkvghrnhgvlhdrohhrghequceuqfffjgepkeeukffvoffkoffgucfukfgkgfepjeekkeefnecuvehluhhsthgvrhfuihiivgepiedu;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966986AbeCSQSZ (ORCPT <rfc822;greg@kroah.com>);
        Mon, 19 Mar 2018 12:18:25 -0400
Received: from mail-co1nam03on0091.outbound.protection.outlook.com ([104.47.40.91]:37504
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S934196AbeCSQOe (ORCPT <rfc822;stable@vger.kernel.org>);
        Mon, 19 Mar 2018 12:14:34 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Tang Junhui <tang.junhui@zte.com.cn>,
        Michael Lyle <mlyle@lyle.org>, Jens Axboe <axboe@kernel.dk>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 3.18 093/102] bcache: stop writeback thread after
 detaching
Thread-Topic: [PATCH AUTOSEL for 3.18 093/102] bcache: stop writeback thread
 after detaching
Thread-Index: AQHTv502e9591xBbQUCqZoBmPZF7zw==
Date: Mon, 19 Mar 2018 16:13:28 +0000
Message-ID: <20180319161117.17833-93-alexander.levin@microsoft.com>
References: <20180319161117.17833-1-alexander.levin@microsoft.com>
In-Reply-To: <20180319161117.17833-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1112;7:UAE4hdjwYqSEAWOnrMJRrGrdM0J15QsPqkau4u95MnJEdrgRMJbLqcAmKI8cruUOw3UgD4ApnKIdm+P9ghuwZPX+tFevdfTeaaH96z6inBAIR26djx+iOxTsrsf87cJCP5ARjB+vintyojW7u0yDRSO+RKc524rFPvcEBnSql6d6/02wb7yC87uAMQFMTEZoIPeRyCt6upnSageb0bh2kOFaxXKxKtwGzUC1XGMB0md3UnO1jQqSaYknq1+iSfyn;20:FLghwNNA2921GBRxJgveld6P3ic7fRUg8G9hXeksFi1nIQ0wN2M90i/hoQxQdogp685MdjaHBR/uD6khCA+i6wpzeAmsZ14gqfP1y6UGSHpvAhAFBB6p90VVhiGoSPUf9mt8GPHgQr+7cTfLI0vIcZcTW2d7M3oZGY4eb681Gy8=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 7eab4d79-f48c-4a87-01e1-08d58db4776b
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB1112;
x-ms-traffictypediagnostic: DM5PR2101MB1112:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB111243870B88599436DCC3BDFBD40@DM5PR2101MB1112.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(5005006)(8121501046)(3231221)(944501300)(52105095)(3002001)(93006095)(93001095)(10201501046)(6055026)(61426038)(61427038)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123564045)(20161123558120)(6072148)(201708071742011);SRVR:DM5PR2101MB1112;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1112;
x-forefront-prvs: 06167FAD59
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(366004)(39860400002)(376002)(39380400002)(396003)(199004)(189003)(53936002)(26005)(14454004)(5890100001)(36756003)(2501003)(186003)(305945005)(86362001)(107886003)(316002)(575784001)(7736002)(6506007)(110136005)(5250100002)(4326008)(2900100001)(25786009)(102836004)(105586002)(72206003)(10090500001)(54906003)(2950100002)(478600001)(99286004)(106356001)(6436002)(3280700002)(3660700001)(10290500003)(66066001)(2906002)(6486002)(76176011)(81166006)(81156014)(8676002)(68736007)(8936002)(5660300001)(6666003)(22452003)(86612001)(6116002)(3846002)(1076002)(97736004)(59450400001)(6512007)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1112;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: iCBa4hrttjqsrLwe83qcey8V/CJr2lNMpDqvZI/xd+wTekggdmHYBm1f8PdvG67mDt1Hit/oP4VIpdkCrQm1W6VCae7/4t2AY7O2j5ViqtG/9OoewIlES31OVWysluQ8IhtQgsLEd0W8b8KXx8o1T8p3U7MVxcE7V4sOf6Tt01xJa4e9wDALYqSFjkkFtVzOqMHxCGTgIhEKkDFBTcor5890nViYjUyDzZbaGmyXYXxqsz7YgvCTahCvfQpbn6gOpsEJLSRYaGd3AQnCmAdDD2sfXpqi7OqvItMqjfxXnFWcJNHXtpTN+GsS15FQthFLEiQDi7b5xMFz1anno3GsqA==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7eab4d79-f48c-4a87-01e1-08d58db4776b
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2018 16:13:28.4595
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1112
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
index 9c56cf714b22..cb98bad58412 100644
--- a/drivers/md/bcache/super.c
+++ b/drivers/md/bcache/super.c
@@ -921,6 +921,12 @@ static void cached_dev_detach_finish(struct work_struc=
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
