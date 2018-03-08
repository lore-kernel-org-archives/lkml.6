Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1131037-1520491312-2-10911495560946768983
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
    t=1520491311; b=IPK43MPYtkR9d7FgOWdnOFPIbwS6RcjwZXq7cR2i6je69mf
    ++In9mcz5P31OQzb0xZGe4893ZdTpUo4Tjxuy68DV5XmLrOm740jEFqPCKye9G6E
    hm95AmDhcVPXTUrluEq8P7tqYt3/sTcWV9+i6Kyjhb/Ym8LLZLcmSCcege5s31ZY
    F8XTmYrp+yPDFIT/eM0J2sBd2SbqKmEmanQyq1cu8TlhHfswIDfZftwRDCd8AmMH
    GbtQFGGnuD6eMqJjC7zdEcH2XZVY1rNH7Ixt6aGEysjVQeWMjeSwWX6FZQjRAkD0
    LAlnF6G6Q9bA9ffnBDMZmMl5UvS92qsW2fNi5Jw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1520491311; bh=GyzK3+
    daz2YDSab7UVW3Tbm6OFaKpmz0tyrNeon4LUw=; b=HkRKcPfhVSggA6JShXPYYe
    dY9L2DG42N7JIL8QVNnYcLZaXpROQqnRYrqiYX9Cfxg5CS63nihqOghs+KnBspC/
    ZuTCqaEIwmp3nxZH4ivCjWzPPDm4q3b2DVho2sXmnUFXhcq20wrkShaeHDqjNkti
    8fI3nLTZV/Fo7+yird1rHoFrDFpTZvUQISpNqDeSNp1kWQaMEyHNxgN0r+3Ex86C
    Gc2TJd85wbd+Q/6BltNhVqiov1fT/fQaEkaMW+2B46NvVk9iTau8fRHjv10ST/hz
    ChFTnOQ4qkeYJlPPIr01GmG1XLj5V2P9WU/a/fLqT5ITr/YcCpMnRw8oZW3LL+AQ
    ==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=h+cFcyuX x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=h+cFcyuX x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965283AbeCHE7F (ORCPT <rfc822;greg@kroah.com>);
        Wed, 7 Mar 2018 23:59:05 -0500
Received: from mail-sn1nam01on0102.outbound.protection.outlook.com ([104.47.32.102]:61147
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S935347AbeCHE64 (ORCPT <rfc822;stable@vger.kernel.org>);
        Wed, 7 Mar 2018 23:58:56 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Shuah Khan <shuahkh@osg.samsung.com>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Mauro Carvalho Chehab <mchehab@s-opensource.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.14 34/67] media: s5p-mfc: Fix lock contention -
 request_firmware() once
Thread-Topic: [PATCH AUTOSEL for 4.14 34/67] media: s5p-mfc: Fix lock
 contention - request_firmware() once
Thread-Index: AQHTtpn/aEWbK2A190ix6vbZjYDghw==
Date: Thu, 8 Mar 2018 04:57:46 +0000
Message-ID: <20180308045641.7814-34-alexander.levin@microsoft.com>
References: <20180308045641.7814-1-alexander.levin@microsoft.com>
In-Reply-To: <20180308045641.7814-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1015;7:jl2Fb9AOGp+zvVB9CDIesNRGwegbTft5V1o++YlAWvvnDeIu9IWJTx3z9VmnK2pGqmAlrAL5aKqjVOw3ce1Te8a+oCiRW8OMyn6Mf1RdtVRSQ6jUF5KomW/ZbC6/WkueA/dAr/MlBL9QlDWYgQozgjX1BB00EMv1Q1SpAda0LNzYt9uEu+jVAuSSSphjcaKv2IIA1P1ECekKtEWy24izaSVsH2BW4cMt7FwWj9NHLcenYi/sg9lWinrTe0EWzM/m;20:rTZJ5T5xSgsM7dn5uEhXtc96br17Lokq2IgA8qJgDuFSqBi+nrlxn9hlOPu/f8w9t7QYJdnPLmDPdybMgd9JtDbWHDR6f8MArrjuvQljN0WbwnsWUEeVi2y+YjtlPWkKtyYNW2SYrnYb3fBt7a5Z2XlGiVarW+gmq9qg6Fm3U/4=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 0bf3e75f-6635-483b-abee-08d584b14aff
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB1015;
x-ms-traffictypediagnostic: DM5PR2101MB1015:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB10156D1839FE8102E75F2B69FBDF0@DM5PR2101MB1015.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(7411616537696);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231220)(944501244)(52105095)(10201501046)(3002001)(6055026)(61426038)(61427038)(6041288)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123564045)(20161123558120)(6072148)(201708071742011);SRVR:DM5PR2101MB1015;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1015;
x-forefront-prvs: 060503E79B
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(396003)(366004)(39860400002)(39380400002)(346002)(189003)(199004)(6116002)(53936002)(1076002)(107886003)(3846002)(3660700001)(10090500001)(6666003)(2950100002)(2906002)(6512007)(99286004)(8936002)(6486002)(76176011)(6506007)(68736007)(59450400001)(316002)(110136005)(81156014)(81166006)(8676002)(54906003)(3280700002)(2900100001)(6436002)(97736004)(72206003)(25786009)(10290500003)(86612001)(4326008)(305945005)(7736002)(66066001)(22452003)(478600001)(5660300001)(86362001)(575784001)(14454004)(106356001)(36756003)(102836004)(5250100002)(105586002)(26005)(2501003)(186003)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1015;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
x-microsoft-antispam-message-info: jW86nKNw+moEaw3Mn/IwxHOrqB+BZghx/cwVfqvfja1d4XFnDSUTLntDKXDioRf+roi7hIN933dpww4vCHa8klHAsuFTp0H95uGWgo0b4Uj9G+eMgLrXvUljOHRcvI8WM05wc/rRHxA1eBIQXcHasMmBPMjbh2WeskzAOACt1omW9r030BL6IdOTiBLtbxfp5kcl+NefMbd6WSPgTBroRhCUeyLJrix/XTqwDMhIDAOa2BBJ5QsmLJhAuYL8P52vVvAuc3oWGsy6kH+XGgqZE2ozuovxUoQqGaMyLz2+n3B6wmbnTGh00znOZvNklxa/FhRJUvkAk3v6g2DLng8ujg==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0bf3e75f-6635-483b-abee-08d584b14aff
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Mar 2018 04:57:46.4692
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1015
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Shuah Khan <shuahkh@osg.samsung.com>

[ Upstream commit f45ce9877561044090010e0eb0fad644232ded04 ]

Driver calls request_firmware() whenever the device is opened for the
first time. As the device gets opened and closed, dev->num_inst =3D=3D 1
is true several times. This is not necessary since the firmware is saved
in the fw_buf. s5p_mfc_load_firmware() copies the buffer returned by
the request_firmware() to dev->fw_buf.

fw_buf sticks around until it gets released from s5p_mfc_remove(), hence
there is no need to keep requesting firmware and copying it to fw_buf.

This might have been overlooked when changes are made to free fw_buf from
the device release interface s5p_mfc_release().

Fix s5p_mfc_load_firmware() to call request_firmware() once and keep state.
Change _probe() to load firmware once fw_buf has been allocated.

s5p_mfc_open() and it continues to call s5p_mfc_load_firmware() and init
hardware which is the step where firmware is written to the device.

This addresses the mfc_mutex contention due to repeated request_firmware()
calls from open() in the following circular locking warning:

[  552.194115] qtdemux0:sink/2710 is trying to acquire lock:
[  552.199488]  (&dev->mfc_mutex){+.+.}, at: [<bf145544>] s5p_mfc_mmap+0x28=
/0xd4 [s5p_mfc]
[  552.207459]
               but task is already holding lock:
[  552.213264]  (&mm->mmap_sem){++++}, at: [<c01df2e4>] vm_mmap_pgoff+0x44/=
0xb8
[  552.220284]
               which lock already depends on the new lock.

[  552.228429]
               the existing dependency chain (in reverse order) is:
[  552.235881]
               -> #2 (&mm->mmap_sem){++++}:
[  552.241259]        __might_fault+0x80/0xb0
[  552.245331]        filldir64+0xc0/0x2f8
[  552.249144]        call_filldir+0xb0/0x14c
[  552.253214]        ext4_readdir+0x768/0x90c
[  552.257374]        iterate_dir+0x74/0x168
[  552.261360]        SyS_getdents64+0x7c/0x1a0
[  552.265608]        ret_fast_syscall+0x0/0x28
[  552.269850]
               -> #1 (&type->i_mutex_dir_key#2){++++}:
[  552.276180]        down_read+0x48/0x90
[  552.279904]        lookup_slow+0x74/0x178
[  552.283889]        walk_component+0x1a4/0x2e4
[  552.288222]        link_path_walk+0x174/0x4a0
[  552.292555]        path_openat+0x68/0x944
[  552.296541]        do_filp_open+0x60/0xc4
[  552.300528]        file_open_name+0xe4/0x114
[  552.304772]        filp_open+0x28/0x48
[  552.308499]        kernel_read_file_from_path+0x30/0x78
[  552.313700]        _request_firmware+0x3ec/0x78c
[  552.318291]        request_firmware+0x3c/0x54
[  552.322642]        s5p_mfc_load_firmware+0x54/0x150 [s5p_mfc]
[  552.328358]        s5p_mfc_open+0x4e4/0x550 [s5p_mfc]
[  552.333394]        v4l2_open+0xa0/0x104 [videodev]
[  552.338137]        chrdev_open+0xa4/0x18c
[  552.342121]        do_dentry_open+0x208/0x310
[  552.346454]        path_openat+0x28c/0x944
[  552.350526]        do_filp_open+0x60/0xc4
[  552.354512]        do_sys_open+0x118/0x1c8
[  552.358586]        ret_fast_syscall+0x0/0x28
[  552.362830]
               -> #0 (&dev->mfc_mutex){+.+.}:
               -> #0 (&dev->mfc_mutex){+.+.}:
[  552.368379]        lock_acquire+0x6c/0x88
[  552.372364]        __mutex_lock+0x68/0xa34
[  552.376437]        mutex_lock_interruptible_nested+0x1c/0x24
[  552.382086]        s5p_mfc_mmap+0x28/0xd4 [s5p_mfc]
[  552.386939]        v4l2_mmap+0x54/0x88 [videodev]
[  552.391601]        mmap_region+0x3a8/0x638
[  552.395673]        do_mmap+0x330/0x3a4
[  552.399400]        vm_mmap_pgoff+0x90/0xb8
[  552.403472]        SyS_mmap_pgoff+0x90/0xc0
[  552.407632]        ret_fast_syscall+0x0/0x28
[  552.411876]
               other info that might help us debug this:

[  552.419848] Chain exists of:
                 &dev->mfc_mutex --> &type->i_mutex_dir_key#2 --> &mm->mmap=
_sem

[  552.431200]  Possible unsafe locking scenario:

[  552.437092]        CPU0                    CPU1
[  552.441598]        ----                    ----
[  552.446104]   lock(&mm->mmap_sem);
[  552.449484]                                lock(&type->i_mutex_dir_key#2=
);
[  552.456329]                                lock(&mm->mmap_sem);
[  552.462222]   lock(&dev->mfc_mutex);
[  552.465775]
                *** DEADLOCK ***

Signed-off-by: Shuah Khan <shuahkh@osg.samsung.com>
Signed-off-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
Signed-off-by: Mauro Carvalho Chehab <mchehab@s-opensource.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/media/platform/s5p-mfc/s5p_mfc.c        | 6 ++++++
 drivers/media/platform/s5p-mfc/s5p_mfc_common.h | 3 +++
 drivers/media/platform/s5p-mfc/s5p_mfc_ctrl.c   | 5 +++++
 3 files changed, 14 insertions(+)

diff --git a/drivers/media/platform/s5p-mfc/s5p_mfc.c b/drivers/media/platf=
orm/s5p-mfc/s5p_mfc.c
index 1afde5021ca6..8e9531f7f83f 100644
--- a/drivers/media/platform/s5p-mfc/s5p_mfc.c
+++ b/drivers/media/platform/s5p-mfc/s5p_mfc.c
@@ -1315,6 +1315,12 @@ static int s5p_mfc_probe(struct platform_device *pde=
v)
 		goto err_dma;
 	}
=20
+	/*
+	 * Load fails if fs isn't mounted. Try loading anyway.
+	 * _open() will load it, it it fails now. Ignore failure.
+	 */
+	s5p_mfc_load_firmware(dev);
+
 	mutex_init(&dev->mfc_mutex);
 	init_waitqueue_head(&dev->queue);
 	dev->hw_lock =3D 0;
diff --git a/drivers/media/platform/s5p-mfc/s5p_mfc_common.h b/drivers/medi=
a/platform/s5p-mfc/s5p_mfc_common.h
index 4220914529b2..76119a8cc477 100644
--- a/drivers/media/platform/s5p-mfc/s5p_mfc_common.h
+++ b/drivers/media/platform/s5p-mfc/s5p_mfc_common.h
@@ -290,6 +290,8 @@ struct s5p_mfc_priv_buf {
  * @mfc_cmds:		cmd structure holding HW commands function pointers
  * @mfc_regs:		structure holding MFC registers
  * @fw_ver:		loaded firmware sub-version
+ * @fw_get_done		flag set when request_firmware() is complete and
+ *			copied into fw_buf
  * risc_on:		flag indicates RISC is on or off
  *
  */
@@ -336,6 +338,7 @@ struct s5p_mfc_dev {
 	struct s5p_mfc_hw_cmds *mfc_cmds;
 	const struct s5p_mfc_regs *mfc_regs;
 	enum s5p_mfc_fw_ver fw_ver;
+	bool fw_get_done;
 	bool risc_on; /* indicates if RISC is on or off */
 };
=20
diff --git a/drivers/media/platform/s5p-mfc/s5p_mfc_ctrl.c b/drivers/media/=
platform/s5p-mfc/s5p_mfc_ctrl.c
index 69ef9c23a99a..d94e59e79fe9 100644
--- a/drivers/media/platform/s5p-mfc/s5p_mfc_ctrl.c
+++ b/drivers/media/platform/s5p-mfc/s5p_mfc_ctrl.c
@@ -55,6 +55,9 @@ int s5p_mfc_load_firmware(struct s5p_mfc_dev *dev)
 	 * into kernel. */
 	mfc_debug_enter();
=20
+	if (dev->fw_get_done)
+		return 0;
+
 	for (i =3D MFC_FW_MAX_VERSIONS - 1; i >=3D 0; i--) {
 		if (!dev->variant->fw_name[i])
 			continue;
@@ -82,6 +85,7 @@ int s5p_mfc_load_firmware(struct s5p_mfc_dev *dev)
 	}
 	memcpy(dev->fw_buf.virt, fw_blob->data, fw_blob->size);
 	wmb();
+	dev->fw_get_done =3D true;
 	release_firmware(fw_blob);
 	mfc_debug_leave();
 	return 0;
@@ -93,6 +97,7 @@ int s5p_mfc_release_firmware(struct s5p_mfc_dev *dev)
 	/* Before calling this function one has to make sure
 	 * that MFC is no longer processing */
 	s5p_mfc_release_priv_buf(dev, &dev->fw_buf);
+	dev->fw_get_done =3D false;
 	return 0;
 }
=20
--=20
2.14.1
