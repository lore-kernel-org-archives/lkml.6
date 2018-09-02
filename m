Return-Path: <SRS0=aodX=LQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D488FC433F5
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Sep 2018 13:16:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 837DD20652
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Sep 2018 13:16:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="eYO4uid7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 837DD20652
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730203AbeIBRcK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Sep 2018 13:32:10 -0400
Received: from mail-dm3nam03on0125.outbound.protection.outlook.com ([104.47.41.125]:63162
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728738AbeIBRcJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Sep 2018 13:32:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p/UXuWKvN7WFsckRW3hQm9x81uAXll2Ig67srGBbfAU=;
 b=eYO4uid7by9FCnGja4XXKbKHPpn8yVbhJZMEQcyybIsU4bu9mXizSYD/xmttJfgx78fh3moeF+NS3Q4LnynxtOI2V4uXpMm0I3htW3xB466Y+WfmNs/OLcB+mDCY/2I+x5pOSPECkfaSNLTs+h09LvI93H2Ay/+QE9BxR2TOA6o=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0629.namprd21.prod.outlook.com (10.175.115.19) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1122.7; Sun, 2 Sep 2018 13:16:19 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611%7]) with mapi id 15.20.1143.000; Sun, 2 Sep 2018
 13:16:19 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Yunlong Song <yunlong.song@huawei.com>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.4 11/47] f2fs: do not set free of current section
Thread-Topic: [PATCH AUTOSEL 4.4 11/47] f2fs: do not set free of current
 section
Thread-Index: AQHUQr8Rx/4qiDuqtkiitOCDUo1Aeg==
Date:   Sun, 2 Sep 2018 13:15:49 +0000
Message-ID: <20180902131533.184092-11-alexander.levin@microsoft.com>
References: <20180902131533.184092-1-alexander.levin@microsoft.com>
In-Reply-To: <20180902131533.184092-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0629;6:fSBE53HtENbJyn74ZqDaV9nO8BV44ZuoQrQlG5vO0sNpe/CXfFUgU+0+YH/moZfOx45CZ37H893yYy8BPAuQMOk/sPLEZ0dt/Ye0EJWyQsj1mSmb3ZnkbSieDud3OgyLvdQLiO7QWBWhTMyMeeJTV4FfxkhkK91VnFV5ZFVNkyn2SfgZ3MPQ1lyGHFxI6XzbjAo4ltP6B3TXES8XMPGqPS/3cdjeDW2kHEZenQZco29uOEPsSIUdFsotWdyxxEuDMOyistR6yG38F318h7uirVfxqo78onRf1qjtvVAC9FGR5U9cDeQqTtPPohLfkqpwbKYwDQW4YBXkEzyNvRhKm/bBy0w4djVQFANkk3kPpaus/VWD3VKPZ1xE12NDtdseDwFGTHrYf6tjpPX3PO4SlzX59/zRC3F99PgZJcKAHPr4FsOzApshY+UEzGfdNq7Em0sT4kOE6eiHmeHxfAHarg==;5:zpFZkTbTkT792Zxh0dArdXRpgKzlccwLZwhnd03pLCtLCuWmbr4jxdktTmlZ+UZOA8AxXeg5TM0CUj1bGkvPGyQGjvrli++ciN04tjRDvDOWbWYvY9FAklC+yPMtKZSn8//FnRpmH4WChbzWnTsHDOv+ZvnbRcfL+/rHZsr0LnM=;7:it8Mj+oKiyCeA1PEbyakmAJw+3PSJKL8nt6SK5IXjEoNg7gddtshaxSvQTNnpxeRoGI49LQ9rECAH/jfXbZ7v9fmGdZEs3kw6I9JLJRhl8PXCrLfKwLzLAcsSiuOeDTmPypA2e5raXFOMYY0qi0AEY7FqBwvXrYJvYaKtamGp739nrwSxk7aH6OA8dPaMAaA2yxMJ4mr/+jU7wgmH/kH9D4qbfhsU9PZ5hX8AsnRm7JQlUZLUxcwGA16M5qhmtY1
x-ms-office365-filtering-correlation-id: 1d241b2d-cc90-42cb-445e-08d610d645b5
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(4534165)(4627221)(201703031133081)(201702281549075)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0629;
x-ms-traffictypediagnostic: CY4PR21MB0629:
x-microsoft-antispam-prvs: <CY4PR21MB06298F3392566CCC70341361FB0D0@CY4PR21MB0629.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(50582790962513);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(10201501046)(3002001)(3231340)(944501410)(52105095)(2018427008)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123558120)(20161123562045)(201708071742011)(7699049)(76991033);SRVR:CY4PR21MB0629;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0629;
x-forefront-prvs: 078310077C
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(136003)(366004)(39860400002)(346002)(376002)(199004)(189003)(8676002)(478600001)(10090500001)(14454004)(10290500003)(72206003)(476003)(5660300001)(5250100002)(106356001)(110136005)(54906003)(316002)(105586002)(86612001)(102836004)(14444005)(26005)(256004)(6506007)(2616005)(6116002)(217873002)(305945005)(446003)(1076002)(3846002)(2906002)(11346002)(97736004)(6346003)(81166006)(81156014)(7736002)(6436002)(66066001)(25786009)(86362001)(4326008)(186003)(53936002)(8936002)(6486002)(22452003)(6512007)(99286004)(2501003)(36756003)(68736007)(6666003)(2900100001)(486006)(107886003)(76176011);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0629;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-message-info: UfUcTEL5DXcY7dUxj4FIzNhgPgFySYPyg5T2FIRXzbzqnYDeC61qq4flxm+lRgC5hkTqkfpNDg5xcW/L+02KYIQ/kXOSBKKp/yiWrpyDizreCsj+Gou59JUslEhWdvg40ALG5CNgZJa7n20oJW3mXdRhVcRuGhLSgT2AWZ0NHT9MR6DaYPo7HuhoIw055o1CQ0rHUVaX+o097eqRRzAQ2CcK0FNJp/lHyxhYGVRYpq0Wqd7r4xd+RPzQRpvQLiuhUWfUIORbaVBm9Foua9fqu71+hRDEeGtKdZbGZ2biX1wIbVwJG5d4HLxvFK+Ohn3Bl7kHzE5zhUKqnTgWleRfswvHrz9NZPOC1fvWVcei6F4=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1d241b2d-cc90-42cb-445e-08d610d645b5
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Sep 2018 13:15:49.5978
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0629
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yunlong Song <yunlong.song@huawei.com>

[ Upstream commit 3611ce9911267cb93d364bd71ddea6821278d11f ]

For the case when sbi->segs_per_sec > 1, take section:segment =3D 5 for
example, if segment 1 is just used and allocate new segment 2, and the
blocks of segment 1 is invalidated, at this time, the previous code will
use __set_test_and_free to free the free_secmap and free_sections++,
this is not correct since it is still a current section, so fix it.

Signed-off-by: Yunlong Song <yunlong.song@huawei.com>
Reviewed-by: Chao Yu <yuchao0@huawei.com>
Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 fs/f2fs/segment.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/fs/f2fs/segment.h b/fs/f2fs/segment.h
index ee44d346ea44..bfa1d31f79aa 100644
--- a/fs/f2fs/segment.h
+++ b/fs/f2fs/segment.h
@@ -381,6 +381,8 @@ static inline void __set_test_and_free(struct f2fs_sb_i=
nfo *sbi,
 	if (test_and_clear_bit(segno, free_i->free_segmap)) {
 		free_i->free_segments++;
=20
+		if (IS_CURSEC(sbi, secno))
+			goto skip_free;
 		next =3D find_next_bit(free_i->free_segmap,
 				start_segno + sbi->segs_per_sec, start_segno);
 		if (next >=3D start_segno + sbi->segs_per_sec) {
@@ -388,6 +390,7 @@ static inline void __set_test_and_free(struct f2fs_sb_i=
nfo *sbi,
 				free_i->free_sections++;
 		}
 	}
+skip_free:
 	spin_unlock(&free_i->segmap_lock);
 }
=20
--=20
2.17.1
