Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1254417-1520121170-2-17274993917874886020
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES unknown, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520121169; b=OFthjAAk3Sy6yJbblZLve92aQoi/VkMrd2shYEigV/HaklN
    7yrrBIFek68r+rR3iBImknKgJraWYgzGN9gsACrxA/0jKUnWioT3xigE2jRlUczv
    4j4KfrV6ELIs76r8XABPi/jtrVFdfbaT5pZ92gHcN0hj160TM5zgcFPlobIxLdwW
    4sDhvGMN/s9q1B+ppBuNsFnsA/3VpdqN8pP25sxZpsLwHjiL2KGffh/sjVpn+FN7
    vK+GICbMi6a3T1LnIPz7w5Z8JSzj5nYcb9Q1r3yyYGG3Ptn/wwy+R7ZP1AQY9SsS
    SKNSEm13v1JTmv5ERp0TWIer+18bFfhx9C1kPNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1520121169; bh=m3Jxoa
    nppnJ+9Ooz6Wkm7ciqxDETO4CWnLCgyWzOcmU=; b=RdMnXLsBckcVmTReU2ygT1
    jE//7QNTcSomTqkpql7cA1z/XemFrE2lxRGMvYIBIcZwjL8PCi5wCnCTk40mf9GC
    oeqdV2UqXC6ivb5ijYs1nX7Lh3CQG+8hbP0+L5wmP0uAdPTvv5FQ/m66yty6BqL/
    790QYu2uJ+F6aCEB1NyOCKigtlXrdSU2AVAcv/m8gldk2j/dhFDJtloF54OxJvpz
    9uaXFsLB7bXII9k9sAvuOF8pFY1jbEdzslAhm+dumLgwFVcTF6Wlakav/vq1bE0j
    mQipiwU0TbEkaWZ8ZhVflK4cTyqseUIHUgSs8kfdoXDG5gjAqvsO1rqGC6cIsufw
    ==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=HibmYlcJ x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=HibmYlcJ x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933945AbeCCWdD (ORCPT <rfc822;greg@kroah.com>);
        Sat, 3 Mar 2018 17:33:03 -0500
Received: from mail-by2nam01on0107.outbound.protection.outlook.com ([104.47.34.107]:45280
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S933920AbeCCWdA (ORCPT <rfc822;stable@vger.kernel.org>);
        Sat, 3 Mar 2018 17:33:00 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Jitendra Bhivare <jitendra.bhivare@broadcom.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.9 074/219] scsi: be2iscsi: Check tag in
 beiscsi_mccq_compl_wait
Thread-Topic: [PATCH AUTOSEL for 4.9 074/219] scsi: be2iscsi: Check tag in
 beiscsi_mccq_compl_wait
Thread-Index: AQHTsz76OaHrq2vTWkOTCC7AqgeVBA==
Date: Sat, 3 Mar 2018 22:28:38 +0000
Message-ID: <20180303222716.26640-74-alexander.levin@microsoft.com>
References: <20180303222716.26640-1-alexander.levin@microsoft.com>
In-Reply-To: <20180303222716.26640-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MW2PR2101MB1097;7:Hr8vEbx2sRV3K4G3HfO3/8lK6IgJldI2fxMLyXkKyp/fWeJFNJLnrT0CJTZSOBUl4X5/0rwWC7Y2S4HgcD6dx/o2aGAVGzT9BV+NJtmNslQo690fi9J3vAbNA0kNvKvbKTvJpwdnIlzfb1BBINQADUUWwQeif2L9iiHWDU+uHrTTsafPwoP0+Np3SHE2R2u2R89pe4yob4x82B3z3vgq17IAusngK173Yr6N4TdlnbPJQL+T+al2POCzSLn39+0e
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 776d3cae-4699-4739-84b5-08d58156b7a3
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(48565401081)(5600026)(4604075)(3008032)(2017052603307)(7193020);SRVR:MW2PR2101MB1097;
x-ms-traffictypediagnostic: MW2PR2101MB1097:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <MW2PR2101MB10970A75188C4809AF58EF32FBC40@MW2PR2101MB1097.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(146099531331640);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(5005006)(8121501046)(10201501046)(3002001)(3231220)(944501244)(52105095)(93006095)(93001095)(6055026)(61426038)(61427038)(6041288)(20161123560045)(20161123558120)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(6072148)(201708071742011);SRVR:MW2PR2101MB1097;BCL:0;PCL:0;RULEID:;SRVR:MW2PR2101MB1097;
x-forefront-prvs: 0600F93FE1
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(366004)(39380400002)(396003)(39860400002)(346002)(189003)(199004)(305945005)(105586002)(36756003)(3660700001)(86362001)(575784001)(6666003)(66066001)(2900100001)(5660300001)(8676002)(10090500001)(81166006)(81156014)(8936002)(22452003)(10290500003)(2950100002)(4326008)(25786009)(5250100002)(2501003)(68736007)(7736002)(72206003)(14454004)(478600001)(186003)(110136005)(26005)(316002)(2906002)(97736004)(6512007)(99286004)(107886003)(54906003)(1076002)(6506007)(106356001)(53936002)(6116002)(3846002)(102836004)(6486002)(86612001)(3280700002)(6436002)(76176011)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:MW2PR2101MB1097;H:MW2PR2101MB1034.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
x-microsoft-antispam-message-info: pEOmWCOIg0PTZgTeLZiN/2Jw6Sn2NHwUUJn2LTWKweT8ZmbskCd94li+fy1ZCq8ytJzLGofIK+dq3UURTKSzUhhITBKLknkx41XzN34r4xP+UZoAKHiUPak/WlyXAvGWc1gm5eCskDzVaa3S7zSZJeS3Y109UnidCycOYgwnEuA=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 776d3cae-4699-4739-84b5-08d58156b7a3
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Mar 2018 22:28:38.9631
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR2101MB1097
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Jitendra Bhivare <jitendra.bhivare@broadcom.com>

[ Upstream commit eb419229be58dc6d4a3a814116a265908e088c39 ]

scsi host12: BS_1377 : mgmt_invalidate_connection Failed for cid=3D256
BUG: unable to handle kernel NULL pointer dereference at 0000000000000008
IP: [<ffffffff81332ebf>] __list_add+0xf/0xc0
PGD 0
Oops: 0000 [#1] SMP
Modules linked in:
...
CPU: 9 PID: 1542 Comm: iscsid Tainted: G               ------------ T 3.10.=
0-514.el7.x86_64 #1
Hardware name: HP ProLiant DL360 Gen9/ProLiant DL360 Gen9, BIOS P89 09/12/2=
016
task: ffff88076f310fb0 ti: ffff88076bba8000 task.ti: ffff88076bba8000
RIP: 0010:[<ffffffff81332ebf>]  [<ffffffff81332ebf>] __list_add+0xf/0xc0
RSP: 0018:ffff88076bbab8e8  EFLAGS: 00010046
RAX: 0000000000000246 RBX: ffff88076bbab990 RCX: 0000000000000000
RDX: 0000000000000000 RSI: ffff880468badf58 RDI: ffff88076bbab990
RBP: ffff88076bbab900 R08: 0000000000000246 R09: 00000000000020de
R10: 0000000000000000 R11: ffff88076bbab5be R12: 0000000000000000
R13: ffff880468badf58 R14: 000000000001adb0 R15: ffff88076f310fb0
FS:  00007f377124a880(0000) GS:ffff88046fa40000(0000) knlGS:000000000000000=
0
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000000000008 CR3: 0000000771318000 CR4: 00000000001407e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000ffff0ff0 DR7: 0000000000000400
Stack:
ffff88076bbab990 ffff880468badf50 0000000000000001 ffff88076bbab938
ffffffff810b128b 0000000000000246 00000000cf9b7040 ffff880468bac7a0
0000000000000000 ffff880468bac7a0 ffff88076bbab9d0 ffffffffa05a6ea3

Call Trace:
[<ffffffff810b128b>] prepare_to_wait+0x7b/0x90
[<ffffffffa05a6ea3>] beiscsi_mccq_compl_wait+0x153/0x330 [be2iscsi]
[<ffffffff810b1600>] ? wake_up_atomic_t+0x30/0x30
[<ffffffffa05981b1>] beiscsi_ep_disconnect+0x91/0x2d0 [be2iscsi]
[<ffffffffa0202ffa>] iscsi_if_ep_disconnect.isra.14+0x5a/0x70 [scsi_transpo=
rt_iscsi]
[<ffffffffa02042fb>] iscsi_if_recv_msg+0x113b/0x14a0 [scsi_transport_iscsi]
[<ffffffff811dffd8>] ? __kmalloc_node_track_caller+0x58/0x290
[<ffffffffa02046ee>] iscsi_if_rx+0x8e/0x1f0 [scsi_transport_iscsi]
[<ffffffff815a351d>] netlink_unicast+0xed/0x1b0
[<ffffffff815a38fe>] netlink_sendmsg+0x31e/0x690
[<ffffffff815a03e4>] ? netlink_rcv_wake+0x44/0x60
[<ffffffff815a19e3>] ? netlink_recvmsg+0x1e3/0x450

beiscsi_mccq_compl_wait gets called even when MCC tag allocation failed
for mgmt_invalidate_connection.  mcc_wait is not initialized for tag 0
so causes crash in prepare_to_wait.

Signed-off-by: Jitendra Bhivare <jitendra.bhivare@broadcom.com>
Reviewed-by: Tomas Henzl <thenzl@redhat.com>
Reviewed-by: Chris Leech <cleech@redhat.com>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/scsi/be2iscsi/be_cmds.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/scsi/be2iscsi/be_cmds.c b/drivers/scsi/be2iscsi/be_cmd=
s.c
index be65da2988fb..838edbba8aec 100644
--- a/drivers/scsi/be2iscsi/be_cmds.c
+++ b/drivers/scsi/be2iscsi/be_cmds.c
@@ -246,6 +246,12 @@ int beiscsi_mccq_compl_wait(struct beiscsi_hba *phba,
 {
 	int rc =3D 0;
=20
+	if (!tag || tag > MAX_MCC_CMD) {
+		__beiscsi_log(phba, KERN_ERR,
+			      "BC_%d : invalid tag %u\n", tag);
+		return -EINVAL;
+	}
+
 	if (beiscsi_hba_in_error(phba)) {
 		clear_bit(MCC_TAG_STATE_RUNNING,
 			  &phba->ctrl.ptag_state[tag].tag_state);
--=20
2.14.1
