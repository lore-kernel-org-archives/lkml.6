Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-966195-1520485257-2-17259178836177429005
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES enro, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520485257; b=UE1lUcTZBeAVYKk7H9za82vnP6SxxYdphyqy8uv1ktT317H
    O+MbzGbBfzphWjwjCCTfAhU+42F0nug8LkpkUgr3eowcixDuxOmGodqh5pDpjx+4
    M/Sie5T5Sw/5tNJhGcIjSX/1m377DS22sxjAE0Exu43avChee0NrKtbg5ldoqdir
    YbbzijR84CbYWheFItWPd3WQhGWN5wthZ2Ske3c6JH3CM8k4qjoRCVIzst1Z3BMP
    aktYz61lH9Klew3hVc4t79/2NTXYOG29Cpki95VxDHG4EtQ/MD5JZ9pSA5ev2Bkg
    4K6LBizNbTaqJbxiTCL0apNe5tLJzS4sas+cOow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1520485257; bh=2xgHLE
    QXk17J9lhNTWSxYkK9p5jZl2VfQdVgpWYD00I=; b=Wh0/pMl3uxPkzE1wQKwQR6
    yWK09VmU770d3ToveYv6Vjv8vucHIHQGrS/c/Swvc914kbbHwrom7iW0V1yjEtJU
    m9ZIXbYDdDX9pmWByZ5mN8kz1JDv0PVn8KgKot70ppMXcHKEC3bMGqiKJxu9NGjy
    mJd7SQixLRHdMMi8erf9ZMN5wSNU9kmZLnpy0QVlyD8drFOLmSjmZhHs2pyxUoEo
    Mbe8WBheDDmy6aKQ2D/tGSnCTmr7ZGj5bZg3VXtjgDzTCNXkEILqpeGdIZ/5CiGC
    9ImYcyHz8lY/xQZClREv1dV1qKipCFTLT3BfVy2D/JHlZgu3MzfCFWy7UqJoBhjA
    ==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=eFuvLqTE x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=eFuvLqTE x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S964787AbeCHFAy (ORCPT <rfc822;greg@kroah.com>);
        Thu, 8 Mar 2018 00:00:54 -0500
Received: from mail-sn1nam01on0111.outbound.protection.outlook.com ([104.47.32.111]:53598
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S935408AbeCHFAq (ORCPT <rfc822;stable@vger.kernel.org>);
        Thu, 8 Mar 2018 00:00:46 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Adam Borowski <kilobyte@angband.pl>,
        David Sterba <dsterba@suse.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.9 040/190] btrfs: fix a bogus warning when
 converting only data or metadata
Thread-Topic: [PATCH AUTOSEL for 4.9 040/190] btrfs: fix a bogus warning when
 converting only data or metadata
Thread-Index: AQHTtpox/FZbNVD6NEW/s5lPKnxqOw==
Date: Thu, 8 Mar 2018 04:59:08 +0000
Message-ID: <20180308045810.8041-40-alexander.levin@microsoft.com>
References: <20180308045810.8041-1-alexander.levin@microsoft.com>
In-Reply-To: <20180308045810.8041-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1112;7:s+7lLM6FGg1A67eKryQnBHRUF0bq7WZwumtEFoZwh0z4TwiISap1dyWC95YzEUSPCsoW71+cDn1hGFieAiDsHsSARVnRvbvaUnjz3hCjYFo2ian62zJZYPawglU5Dy8haUg3FmhACp/9oKFOzrjM8LKULw7xp+sookIf9eaYlbSl53Fcy4CeELb/5D4kluYpSKsjH7AD9n7uZ18MzlvCLg501xZFuRngl5YIdXKbtXIFTJlEo352123XizsppV7N;20:TFb+OCDtmrDE+oHGe7EbWSkX3ybIQ2zpcvgT7JvKnbjY2P0OoXtOVjiFLZ7n+oWhzTdfnZOHaXA1M/0gkIOu7TdeMo23nkvbSzkjTlxbCYlRbaBvMPApojxasoO9NK2wS9uVOHemXrOm8nspJ0P0AwhzveQR7fQNS5FUHjZhZXA=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 2bd70c1b-8786-4f45-a62e-08d584b18a1d
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB1112;
x-ms-traffictypediagnostic: DM5PR2101MB1112:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB11127662385FBF29101F7B6AFBDF0@DM5PR2101MB1112.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(146099531331640);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231220)(944501244)(52105095)(10201501046)(3002001)(6055026)(61426038)(61427038)(6041288)(20161123562045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123560045)(6072148)(201708071742011);SRVR:DM5PR2101MB1112;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1112;
x-forefront-prvs: 060503E79B
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(346002)(376002)(39380400002)(366004)(396003)(189003)(199004)(54906003)(81156014)(7736002)(86612001)(25786009)(81166006)(6512007)(6486002)(4326008)(3846002)(1076002)(6436002)(36756003)(305945005)(6116002)(8936002)(2900100001)(6666003)(97736004)(66066001)(2950100002)(105586002)(68736007)(14454004)(72206003)(3660700001)(478600001)(10290500003)(3280700002)(53936002)(106356001)(10090500001)(5660300001)(102836004)(107886003)(316002)(59450400001)(110136005)(22452003)(86362001)(575784001)(2501003)(5250100002)(6506007)(76176011)(99286004)(2906002)(26005)(186003)(8676002)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1112;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
x-microsoft-antispam-message-info: rjfPAvKDncoiMfHcSXJOg6jkamyG0x2vqEIs+M8eQZer4eEj9pQeuyF602EtREnREtvfVOiQ7Ayyo/fkbGAbsd6tit3R6zpw0As8tK8FhnpBSnzVratIO4/zURWZjJ3JDKClnJqgTvHYoq91KgYhdlW/N91xNv/Kj8+sPfmwwXSowIJHSrR5ii2EoEgZnz80toBhTawyPlVhQZC2LPzPT7vy92RuwLy2EXwEW2oKh2Pzd9okBk/T/SAXOHfD4D9Qy5Q54eGH/IfEjAgEnst1ZFwuN8lFYkcZVQS3seJp6MUaLalb5kstg4AkfH1m31xojUUbw9inhkjk0HbTgy9+2w==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2bd70c1b-8786-4f45-a62e-08d584b18a1d
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Mar 2018 04:59:08.9652
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1112
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Adam Borowski <kilobyte@angband.pl>

[ Upstream commit 14506127979a5a3d0c5d9b4cc76ce9d4ec23b717 ]

If your filesystem has, eg, data:raid0 metadata:raid1, and you run "btrfs
balance -dconvert=3Draid1", the meta.target field will be uninitialized.
That's otherwise ok, as it's unused except for this warning.

Thus, let's use the existing set of raid levels for the comparison.

As a side effect, non-convert balances will now nag about data>metadata.

Signed-off-by: Adam Borowski <kilobyte@angband.pl>
Reviewed-by: Liu Bo <bo.li.liu@oracle.com>
Signed-off-by: David Sterba <dsterba@suse.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 fs/btrfs/volumes.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index 06a77e47957d..cc0f5383a55a 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -3764,6 +3764,7 @@ int btrfs_balance(struct btrfs_balance_control *bctl,
 		  struct btrfs_ioctl_balance_args *bargs)
 {
 	struct btrfs_fs_info *fs_info =3D bctl->fs_info;
+	u64 meta_target, data_target;
 	u64 allowed;
 	int mixed =3D 0;
 	int ret;
@@ -3860,11 +3861,16 @@ int btrfs_balance(struct btrfs_balance_control *bct=
l,
 		}
 	} while (read_seqretry(&fs_info->profiles_lock, seq));
=20
-	if (btrfs_get_num_tolerated_disk_barrier_failures(bctl->meta.target) <
-		btrfs_get_num_tolerated_disk_barrier_failures(bctl->data.target)) {
+	/* if we're not converting, the target field is uninitialized */
+	meta_target =3D (bctl->meta.flags & BTRFS_BALANCE_ARGS_CONVERT) ?
+		bctl->meta.target : fs_info->avail_metadata_alloc_bits;
+	data_target =3D (bctl->data.flags & BTRFS_BALANCE_ARGS_CONVERT) ?
+		bctl->data.target : fs_info->avail_data_alloc_bits;
+	if (btrfs_get_num_tolerated_disk_barrier_failures(meta_target) <
+		btrfs_get_num_tolerated_disk_barrier_failures(data_target)) {
 		btrfs_warn(fs_info,
 			   "metadata profile 0x%llx has lower redundancy than data profile 0x%l=
lx",
-			   bctl->meta.target, bctl->data.target);
+			   meta_target, data_target);
 	}
=20
 	if (bctl->sys.flags & BTRFS_BALANCE_ARGS_CONVERT) {
--=20
2.14.1
