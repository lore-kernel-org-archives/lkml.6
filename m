Return-Path: <SRS0=4ISz=MC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65156C433F4
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 02:51:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 16A2821521
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 02:51:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="l9Sn2ZcS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 16A2821521
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388450AbeITIak (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Sep 2018 04:30:40 -0400
Received: from mail-dm3nam03on0120.outbound.protection.outlook.com ([104.47.41.120]:36173
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2388412AbeITIah (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Sep 2018 04:30:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d6UjwnTxnFdlN6XczYr/X53UlERD5v/s9LdW770+LyE=;
 b=l9Sn2ZcS5qOjGLiTfe+ZheNPNKVb36f5y5IHv0bkogLtKhr33Fp+QucTxgcd1QGqtXuEJ1sg4e0z/WV84haKR0sTyHquGrsqYuGRygVX4klmhNotYDuSHr+wZyqakLDHI8sh/CdG48c9h8MeyP48eqInW9zZZNhUBGKth6StKQo=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0119.namprd21.prod.outlook.com (10.173.189.13) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1185.4; Thu, 20 Sep 2018 02:49:10 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36%5]) with mapi id 15.20.1185.010; Thu, 20 Sep 2018
 02:49:10 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Eric Sandeen <sandeen@redhat.com>, Jan Kara <jack@suse.cz>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.14 06/25] isofs: reject hardware sector size > 2048
 bytes
Thread-Topic: [PATCH AUTOSEL 4.14 06/25] isofs: reject hardware sector size >
 2048 bytes
Thread-Index: AQHUUIxiiEmaXx8UEE2wzNY0Q23JLw==
Date:   Thu, 20 Sep 2018 02:48:18 +0000
Message-ID: <20180920024810.58594-6-alexander.levin@microsoft.com>
References: <20180920024810.58594-1-alexander.levin@microsoft.com>
In-Reply-To: <20180920024810.58594-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0119;6:zLcKEVgHV0DakhIp1sEWE/oLdLqtuTIGlbXGHRGJno8hKQeUG+/zZ1sryutdXvNl/E6YgzQmNl3IJPCtRyyE2FXFFMtQ1WbYwL0x8P9DDDU7ixdA7YVD3sH03pQaqJuZ5cl7EazB8XeirmKjndYHwojXeEkcdSAuXJ8cv76WioXla7NRY0mPFk8cFtwGshEzVEETP2+SZ0V9yTcj5ATud+kF0uYd3PE2cfJQaQJJFgC/cZZKcimQYOhK1nYuicazhVpv31qUGL0+PNeItMbJx0hf/n3Nq5Ub3O4nIfnj/tg7vCe+AFHosutw9aypCDWqPa2G+YdoJuK1bjrpNLGxghrHlRYm4ERphBIbg04bKHv5d1UAG+uD6SBK7s8w0mivmSvoKeJKsz8GM3vxCXcto24U9jJwwricrkQweZGjQwPscOoKXbWmE9o8zkZEogYBT7G3CBEVNspJb/7X3jKsjQ==;5:rwrnhMdjyvTmmcTDB1OzsZaPeTZDniPY9iFJ+6LZVIYXff7A03ZuXYCSVbJmCfz0H0mRTmtGAbYLNdyfLkg8slh3Dgs2hDarS4VcrU6eVSa+lUxNe21W5xiJixuTpJXS7pLV/riIO+rVuDRwmCC6/E8KhW0bLNFys0CcUjNPAio=;7:tYme2pMBJaCHmChu6sgwWqsCDYRKvaPy/0J0Cmoq5hABifMpFjlWPspli1Iqk/hnt1v+PgfEc/AYMYgpBMoKcI95bAxSVQV50OZf1B01p17xTy0FSAqxz83BN7Sd3qxYt57ecRkj8XVb0xextGrkXiverjC+k0lkfQvwLCoW597uBDlMnL12Q9/I+GFSgY+bv0E2JyxrQCjqUy8f+cT6tAL5crgn8Z2dXQWdZev+8DFfZLx9eQvcYwPzaPDXxmuc
x-ms-office365-filtering-correlation-id: e68d7ef6-6e3c-4ec8-1482-08d61ea3a447
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534165)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0119;
x-ms-traffictypediagnostic: CY4PR21MB0119:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-prvs: <CY4PR21MB01196BB22EC6FE1E63E6DC4BFB130@CY4PR21MB0119.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231355)(944501410)(52105095)(2018427008)(93006095)(93001095)(3002001)(10201501046)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123558120)(20161123564045)(20161123560045)(201708071742011)(7699051)(76991041);SRVR:CY4PR21MB0119;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0119;
x-forefront-prvs: 0801F2E62B
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(366004)(396003)(376002)(136003)(39860400002)(189003)(199004)(5660300001)(54906003)(1076002)(478600001)(10090500001)(72206003)(22452003)(107886003)(110136005)(316002)(68736007)(4326008)(76176011)(3846002)(6116002)(25786009)(14454004)(106356001)(99286004)(105586002)(102836004)(6506007)(5250100002)(186003)(2501003)(26005)(6486002)(6436002)(53936002)(6512007)(66066001)(486006)(476003)(2616005)(10290500003)(11346002)(446003)(97736004)(36756003)(2900100001)(2906002)(8936002)(305945005)(575784001)(217873002)(7736002)(86362001)(8676002)(86612001)(256004)(71200400001)(14444005)(71190400001)(81156014)(81166006);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0119;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: 5vk0Lw798XKBlyy61QbUCPI5Kx23chihA88ncnq/Obww7oxa6LhzU5Ir3KVMqUSfVdjFPzWF6+PaxTGPD/ebuVoprU1ZYMZlm7Z6aPmV0JxCfqkPSl+SP7W3lMO7WErPP7BPnCH9zkg0p3Et5yK0Yh39d+Zu247jnIuZwUqi+DwJ5KnyOOHoI13GGAfMskEIAccoHCo+rwcYw92rE7xslyy8RXodZZRf/Y9WMsgd2dEzf9d5eZh0S1+mumCKtu/2IuQ1a4z1hZIgxYQQatvMUhyao8IhKZlqrFExsK0UvazBz4+/K1COzV0GE+PwkMZI1Rn6I6ClJXzlDQIlAB2hem5v2X0Y6Q75r5FICzVYPz8=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e68d7ef6-6e3c-4ec8-1482-08d61ea3a447
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Sep 2018 02:48:18.6321
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0119
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Eric Sandeen <sandeen@redhat.com>

[ Upstream commit 09a4e0be5826aa66c4ce9954841f110ffe63ef4f ]

The largest block size supported by isofs is ISOFS_BLOCK_SIZE (2048), but
isofs_fill_super calls sb_min_blocksize and sets the blocksize to the
device's logical block size if it's larger than what we ended up with after
option parsing.

If for some reason we try to mount a hard 4k device as an isofs filesystem,
we'll set opt.blocksize to 4096, and when we try to read the superblock
we found via:

        block =3D iso_blknum << (ISOFS_BLOCK_BITS - s->s_blocksize_bits)

with s_blocksize_bits greater than ISOFS_BLOCK_BITS, we'll have a negative
shift and the bread will fail somewhat cryptically:

  isofs_fill_super: bread failed, dev=3Dsda, iso_blknum=3D17, block=3D-2147=
483648

It seems best to just catch and clearly reject mounts of such a device.

Reported-by: Bryan Gurney <bgurney@redhat.com>
Signed-off-by: Eric Sandeen <sandeen@redhat.com>
Signed-off-by: Jan Kara <jack@suse.cz>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 fs/isofs/inode.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/fs/isofs/inode.c b/fs/isofs/inode.c
index ed4edcd2bc56..a4994e25e19e 100644
--- a/fs/isofs/inode.c
+++ b/fs/isofs/inode.c
@@ -24,6 +24,7 @@
 #include <linux/mpage.h>
 #include <linux/user_namespace.h>
 #include <linux/seq_file.h>
+#include <linux/blkdev.h>
=20
 #include "isofs.h"
 #include "zisofs.h"
@@ -653,6 +654,12 @@ static int isofs_fill_super(struct super_block *s, voi=
d *data, int silent)
 	/*
 	 * What if bugger tells us to go beyond page size?
 	 */
+	if (bdev_logical_block_size(s->s_bdev) > 2048) {
+		printk(KERN_WARNING
+		       "ISOFS: unsupported/invalid hardware sector size %d\n",
+			bdev_logical_block_size(s->s_bdev));
+		goto out_freesbi;
+	}
 	opt.blocksize =3D sb_min_blocksize(s, opt.blocksize);
=20
 	sbi->s_high_sierra =3D 0; /* default is iso9660 */
--=20
2.17.1
