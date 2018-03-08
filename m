Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1086562-1520489359-2-4889872589706600563
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES enroca, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520489358; b=D1Tw0bIH5VgCsl4x9o+mRYh9fT02BIVKbdu/8XnwYnCPvqG
    pl6D1CyO+ofpJOqYOzQyoJiHPnBBWZY/EakXX/pURuITg+C/ztnpXF+v27pIbuka
    Yh7AkKZSGGqlrjO3QDgZ1DkvPa5jFtm1i4tlAgrNlW45R9q19kyIYU6ClIIiq+zz
    0POfeLVnrB+UrP3kK0ww3Y8p5/qg5Bj94ZvnbSLtbfP0kavmRlZC7ljgm0ticqNn
    1HbtUN5rA2P6gmfspKvyaHyit8chuKD6HMW+EOQqUmB0tkxsLtrSP81i5eGnBkKx
    4ngaBK5iWSrB0Y6ou13lCiLE4r2OGZ0OpZDcqNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1520489358; bh=es0/K+
    A+ramfzHg/A5Q5kM/L7C2VSRvO7I97m7/5dgI=; b=DXk5Lx1+mKXuRAbreaUdiE
    w7MiuA2rc0mlVemr4IvhzH9UfOz/DKnsKHr9A2xjVN2yDHlqf8VQJrqjMxRiuxkp
    i5XbSwUzmf2OaFW0OFzF1oEJk68sruV3MvJXYFFmTcLRmsoU0Lc/XuQwMHBCQ4cF
    31posYbZKL2hBju6s5XffQkwPpc5WX6QbYMe1bCvYivbqHkLIJZHF5dtSDLOFJUX
    mHH6o4DgpwCd6PO7Dd5e+ounD1/TaqZvJ/cJIVj8IonCIlYv0ktMMWZ9QkeGghvu
    fuebTORJ8Y0D9OC75RED6Kd4mHJRE9EVC46UCuwB7VXaCmiKthTHogAThHlLDTIw
    ==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=E2QeivpN x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=E2QeivpN x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755374AbeCHGJD (ORCPT <rfc822;greg@kroah.com>);
        Thu, 8 Mar 2018 01:09:03 -0500
Received: from mail-bl2nam02on0103.outbound.protection.outlook.com ([104.47.38.103]:23927
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751685AbeCHFCK (ORCPT <rfc822;stable@vger.kernel.org>);
        Thu, 8 Mar 2018 00:02:10 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Filipe Manana <fdmanana@suse.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.9 093/190] Btrfs: fix incorrect space accounting
 after failure to insert inline extent
Thread-Topic: [PATCH AUTOSEL for 4.9 093/190] Btrfs: fix incorrect space
 accounting after failure to insert inline extent
Thread-Index: AQHTtpo/ZI3PslDexkGatjWLSPMwhQ==
Date: Thu, 8 Mar 2018 04:59:32 +0000
Message-ID: <20180308045810.8041-93-alexander.levin@microsoft.com>
References: <20180308045810.8041-1-alexander.levin@microsoft.com>
In-Reply-To: <20180308045810.8041-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1063;20:W67F5MtRnWY28lzE4OmOnk2BrzbpHiyIKLBBbR0P7ixdiGDVk02UT7nFNCWPM+80fOtGTgMumE+z6kHKRSPI0oz0VoSZbCahmBlJ0B2V7EbVIy4G/q9OfbBsVp00ddAv3+lmoEDnUGT3R79OMkLkd9rQFRHlbJsqA6pNAoF2+Kc=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 67ab09cb-43cd-4a47-a89e-08d584b1bdc4
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB1063;
x-ms-traffictypediagnostic: DM5PR2101MB1063:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB1063E50075D08BFCECB01565FBDF0@DM5PR2101MB1063.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231220)(944501244)(52105095)(3002001)(10201501046)(6055026)(61426038)(61427038)(6041288)(20161123560045)(20161123564045)(20161123558120)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:DM5PR2101MB1063;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1063;
x-forefront-prvs: 060503E79B
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(39860400002)(396003)(39380400002)(346002)(376002)(199004)(189003)(51234002)(36756003)(186003)(2900100001)(6512007)(3280700002)(6436002)(110136005)(102836004)(5250100002)(99286004)(54906003)(2501003)(25786009)(26005)(4326008)(2906002)(10290500003)(86362001)(76176011)(6116002)(3846002)(6486002)(68736007)(106356001)(1076002)(22452003)(2950100002)(72206003)(6666003)(14454004)(478600001)(3660700001)(107886003)(59450400001)(81166006)(105586002)(316002)(66066001)(10090500001)(305945005)(6506007)(8936002)(7736002)(53936002)(81156014)(8676002)(97736004)(86612001)(5660300001)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1063;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
x-microsoft-antispam-message-info: ZSxXTa4NFKXJxoPgVaTYFOoMNk2CD+UYicz83N2Izy+8thDIKBUQSONSjltbvOGdOdeQ6O2QgtSOZ96EXJQPvOp2ZxRzBBbUPJNgjwxdVmJIojVn7mSkNOY23HgD2ebeW+AQYXQvJZOyU4kGY1wrO3A+JU+RovQg/MxqX26fyTPE0tvajoNTbbItog8Bx2f1DJ+5FlmNGhC8VlL/xfBCYYzmMyP7FEbwz6IATX35I0lC+9Mbz6qISGXyh9nikWjWdgoelU6hNYHIxOheazEtz1MBxjZKu5tdBY9WvOBBPPWVxibIOo5mVu8lz6d83Alq65809S75Vr8UlsYEEb7AUg==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 67ab09cb-43cd-4a47-a89e-08d584b1bdc4
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Mar 2018 04:59:32.5139
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1063
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Filipe Manana <fdmanana@suse.com>

[ Upstream commit 1c81ba237bcecad9bc885a1ddcf02d725ea38482 ]

When using compression, if we fail to insert an inline extent we
incorrectly end up attempting to free the reserved data space twice,
once through extent_clear_unlock_delalloc(), because we pass it the
flag EXTENT_DO_ACCOUNTING, and once through a direct call to
btrfs_free_reserved_data_space_noquota(). This results in a trace
like the following:

[  834.576240] ------------[ cut here ]------------
[  834.576825] WARNING: CPU: 2 PID: 486 at fs/btrfs/extent-tree.c:4316 btrf=
s_free_reserved_data_space_noquota+0x60/0x9f [btrfs]
[  834.579501] Modules linked in: btrfs crc32c_generic xor raid6_pq ppdev i=
2c_piix4 acpi_cpufreq psmouse tpm_tis parport_pc pcspkr serio_raw tpm_tis_c=
ore sg parport evdev i2c_core tpm button loop autofs4 ext4 crc16 jbd2 mbcac=
he sr_mod cdrom sd_mod ata_generic virtio_scsi ata_piix virtio_pci libata v=
irtio_ring virtio scsi_mod e1000 floppy [last unloaded: btrfs]
[  834.592116] CPU: 2 PID: 486 Comm: kworker/u32:4 Not tainted 4.10.0-rc8-b=
trfs-next-37+ #2
[  834.593316] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS =
rel-1.9.1-0-gb3ef39f-prebuilt.qemu-project.org 04/01/2014
[  834.595273] Workqueue: btrfs-delalloc btrfs_delalloc_helper [btrfs]
[  834.596103] Call Trace:
[  834.596103]  dump_stack+0x67/0x90
[  834.596103]  __warn+0xc2/0xdd
[  834.596103]  warn_slowpath_null+0x1d/0x1f
[  834.596103]  btrfs_free_reserved_data_space_noquota+0x60/0x9f [btrfs]
[  834.596103]  compress_file_range.constprop.42+0x2fa/0x3fc [btrfs]
[  834.596103]  ? submit_compressed_extents+0x3a7/0x3a7 [btrfs]
[  834.596103]  async_cow_start+0x32/0x4d [btrfs]
[  834.596103]  btrfs_scrubparity_helper+0x187/0x3e7 [btrfs]
[  834.596103]  btrfs_delalloc_helper+0xe/0x10 [btrfs]
[  834.596103]  process_one_work+0x273/0x4e4
[  834.596103]  worker_thread+0x1eb/0x2ca
[  834.596103]  ? rescuer_thread+0x2b6/0x2b6
[  834.596103]  kthread+0x100/0x108
[  834.596103]  ? __list_del_entry+0x22/0x22
[  834.596103]  ret_from_fork+0x2e/0x40
[  834.611656] ---[ end trace 719902fe6bdef08f ]---

So fix this by not calling directly btrfs_free_reserved_data_space_noquota(=
)
if an error happened.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 fs/btrfs/inode.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index d196ce4be31c..ffd5831ca15c 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -567,8 +567,10 @@ static noinline void compress_file_range(struct inode =
*inode,
 						     PAGE_SET_WRITEBACK |
 						     page_error_op |
 						     PAGE_END_WRITEBACK);
-			btrfs_free_reserved_data_space_noquota(inode, start,
-						end - start + 1);
+			if (ret =3D=3D 0)
+				btrfs_free_reserved_data_space_noquota(inode,
+							       start,
+							       end - start + 1);
 			goto free_pages_out;
 		}
 	}
--=20
2.14.1
