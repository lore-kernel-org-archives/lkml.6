Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3757758-1523238630-2-6991949532099445418
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES enro,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523238629; b=ozNOJn7YlTRK2VjHN+c6x4+PHIBQ/AerIINjiDmCx5awSIUj0B
    TMceVTv/PQoYbUVEu+S7BTklQSQB0XZfBAsBRjlYRpQr30ucu45pz/arIGE4ksZh
    Kr2KLYJoGzVKYDqXiboxQF52w8riwkDSXxqekzVm342BHALkIZX9WcO5gbKcCr/V
    P3ggn/vklUIQ6388fjoLro6kPlfPx9mCPfnU070mqm1xjw6haa+IaRpuoF0YcwmY
    kyH+nuvmhsCaNBHQ2XBsKfHAwgIWG00GKHCrNQY3dX5aK9YXOWiKorP707bPmOBZ
    2a6g9nIyBaSVDQj3Rop5A7T9DCNlDK9/0FXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=fm2; t=1523238629; bh=uzwqB+jJ+q
    qZ1NI1KDJl0eBC8tW4kWY8v7vHVc4aWpo=; b=M3yfl8BRyxE5260b/r+4dlmHDs
    5dfSpaJc3TEXtyi4/Tg4Gn6iU/M9yJPSz++RCPHXq0vnoiV71jaIQfEpfh8tNA8B
    ijpahtbOEuILaheMxSl/DkH2jPuzVT4IuHiw56YJ3c/MiygoUYmNnmayT3Espqgy
    iAvtJt22J8bv/9g731MLdi0Xuuh07DNFhadM3O82JFnASa3CmD3zyPj6NiQ/k/de
    3s9BbJWn+u9OXF4WFcgYMrUkhE7s+7hoLVoQiPG2E0ELWZ+LYDGAU+OV/uinkaIu
    8WiDayQyxru7L04KZVzOy/GO1Qa4uA65L6MD4w7Y8uaDYPteOtJIEOF1/tjQ==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=L81HSrpm x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=L81HSrpm x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfNByC+CPS7j4AWaSvgoaJp7/MhLga7kgRX45tbPAE4oRQLeiDdP9BJphAKfIIyTxG8bMzLBbrKyjZmA+e3flLcC6TGfWRkzU9qMDeS53sj09LNWYL04i
    gonPvZvB3cGShIqv2YDe6p/kNhQpAnpXTEcke8fphlP/F/4o19oMOYVv89+Lva41kyoluuCg7xLv4wEjb5Fmfnk4c979UL1pvFLb6Q/LxPreSJ/M3t+H9rMF
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=wRwT6uffUbIA:10 a=t_PdEiP4ckcA:10
    a=mw6kJ3eo-EIA:10 a=8nJEP1OIZ-IA:10 a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10
    a=Lf-vpJhqX20A:10 a=i0EeH86SAAAA:8 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8
    a=UtV5FjuMAAAA:8 a=iox4zFpeAAAA:8 a=o8Bf2xIQAAAA:8 a=IXr_WNlcAAAA:8
    a=yPCof4ZbAAAA:8 a=Z4Rwk6OoAAAA:8 a=yMhMjlubAAAA:8 a=B78LKRQ_DW_JVSYieywA:9
    a=NtKC-p29CZ7d8Mlf:21 a=WSM2Z_KrRPBDvc3E:21 a=wPNLvfGTeEIA:10
    a=AjGcO6oz07-iQ99wixmX:22 a=ehT88nhQmDs7a44Z_RBH:22 a=WzC6qhA0u3u7Ye7llzcV:22
    a=kLeBEu5l8tkQtVp4YdQK:22 a=K24ECnMRWNUKRqF_MnsZ:22 a=HkZW87K1Qel5hWWM3VKY:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757081AbeDIBuZ (ORCPT <rfc822;greg@kroah.com>);
        Sun, 8 Apr 2018 21:50:25 -0400
Received: from mail-by2nam01on0130.outbound.protection.outlook.com ([104.47.34.130]:18358
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932362AbeDIAdy (ORCPT <rfc822;stable@vger.kernel.org>);
        Sun, 8 Apr 2018 20:33:54 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: piaojun <piaojun@huawei.com>, Mark Fasheh <mfasheh@versity.com>,
        Joel Becker <jlbec@evilplan.org>,
        Junxiao Bi <junxiao.bi@oracle.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.9 254/293] ocfs2: return -EROFS to mount.ocfs2
 if inode block is invalid
Thread-Topic: [PATCH AUTOSEL for 4.9 254/293] ocfs2: return -EROFS to
 mount.ocfs2 if inode block is invalid
Thread-Index: AQHTz5lc7y3BvHcHckefqAJBPB9tbA==
Date: Mon, 9 Apr 2018 00:26:10 +0000
Message-ID: <20180409002239.163177-254-alexander.levin@microsoft.com>
References: <20180409002239.163177-1-alexander.levin@microsoft.com>
In-Reply-To: <20180409002239.163177-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0806;7:56lRjWYwX68SrXwRKkt2PPNva3p6z0SwU2ljBDoj44cYvzH7YYY/klUSoP4Opx6ar4FPlTy5O3oQJ4gS7C77CDixiq5S78d5GkGksCNPOGQEjsTWOQkfJugrwhFPibRoswBLISBPzUdTXWWE8p8mfqDi8fQ9MucTlOpUy8wmtAiq+9roFUwYETyuj3JgBFLE2gXJH+SYG4feMlWAxWRAdjY73EZIyxvoIIct6TxiWUdCJbTZDue+cO8kSq/d1Zqe;20:6dQp7Mb2pHou9kzcF2x4YQVoP60kwu9ND/EWPEtIWzb+z7/J7FHSZ920a5+MG/FvFuqKIXrRJttKMi1BbCTqAzd/S8m1JkX/Tho/INovbdpJwySTVa+Hmh/0U2nEs0hbltxU5SenqlkOAXeKRca7zVgJpHJNAAmgTBMEEoGCTi0=
x-ms-office365-filtering-ht: Tenant
X-MS-Office365-Filtering-Correlation-Id: 47ee9d31-ac34-4003-0e99-08d59db19087
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0806;
x-ms-traffictypediagnostic: DM5PR2101MB0806:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB080696F8304507BF092F7923FBBF0@DM5PR2101MB0806.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(50582790962513)(85827821059158)(42068640409301)(146099531331640);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(8121501046)(5005006)(3231221)(944501327)(52105095)(93006095)(93001095)(10201501046)(3002001)(6055026)(61426038)(61427038)(6041310)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123560045)(20161123558120)(6072148)(201708071742011);SRVR:DM5PR2101MB0806;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0806;
x-forefront-prvs: 0637FCE711
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(39860400002)(376002)(396003)(366004)(39380400002)(199004)(189003)(2906002)(25786009)(2501003)(10290500003)(476003)(11346002)(446003)(97736004)(5250100002)(68736007)(2616005)(102836004)(6506007)(59450400001)(3846002)(3660700001)(486006)(3280700002)(305945005)(6666003)(99286004)(5660300001)(76176011)(1076002)(186003)(26005)(7736002)(6116002)(81156014)(81166006)(86612001)(4326008)(105586002)(10090500001)(2900100001)(54906003)(22452003)(316002)(36756003)(110136005)(107886003)(8676002)(6436002)(478600001)(53936002)(66066001)(6486002)(6512007)(6306002)(86362001)(966005)(14454004)(72206003)(8936002)(106356001)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0806;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: cPvg8aPjysnsP6Zm1mdPiVh/d6xUYgCBhWT/izg2wbqZ1U7yMozy4AcY996NN9bshatM5NWnkmoISTtBs17NmmC7vTyfoMkCUBTChqoF8wbTc+yfacclMAWKIqmwrru3+AVQLhC0w6GxQPldR6SbmAd6URODTPd3nGPq8BwfUHVxAkrBosvRGXvYhXPte8h05D8q+sHes64VP4XSIyOxdU/DzwYrSgtlK3FopZMx3YQFozXXsFmRUJIa39lCdLzv4LfV0Xxt1UegQYwHL6tbdrnccXX9upRBoFtPTtmeTqTGZdpaE5fsXN1WntXhFhcbb48bFSxjehjTwxVBOpQKHi5J7N87pkF7rcdWIYnuk1Rwk/zrpDDqyDtgN6etElRBpTcPvFT6uFa81FEszLBZVan81udQiVhUyDqF+Je7s7I=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 47ee9d31-ac34-4003-0e99-08d59db19087
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2018 00:26:10.8944
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0806
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: piaojun <piaojun@huawei.com>

[ Upstream commit 025bcbde3634b2c9b316f227fed13ad6ad6817fb ]

If metadata is corrupted such as 'invalid inode block', we will get
failed by calling 'mount()' and then set filesystem readonly as below:

  ocfs2_mount
    ocfs2_initialize_super
      ocfs2_init_global_system_inodes
        ocfs2_iget
          ocfs2_read_locked_inode
            ocfs2_validate_inode_block
	      ocfs2_error
	        ocfs2_handle_error
	          ocfs2_set_ro_flag(osb, 0);  // set readonly

In this situation we need return -EROFS to 'mount.ocfs2', so that user
can fix it by fsck.  And then mount again.  In addition, 'mount.ocfs2'
should be updated correspondingly as it only return 1 for all errno.
And I will post a patch for 'mount.ocfs2' too.

Link: http://lkml.kernel.org/r/5A4302FA.2010606@huawei.com
Signed-off-by: Jun Piao <piaojun@huawei.com>
Reviewed-by: Alex Chen <alex.chen@huawei.com>
Reviewed-by: Joseph Qi <jiangqi903@gmail.com>
Reviewed-by: Changwei Ge <ge.changwei@h3c.com>
Reviewed-by: Gang He <ghe@suse.com>
Cc: Mark Fasheh <mfasheh@versity.com>
Cc: Joel Becker <jlbec@evilplan.org>
Cc: Junxiao Bi <junxiao.bi@oracle.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 fs/ocfs2/super.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/fs/ocfs2/super.c b/fs/ocfs2/super.c
index f56fe39fab04..64dfbe5755da 100644
--- a/fs/ocfs2/super.c
+++ b/fs/ocfs2/super.c
@@ -473,9 +473,8 @@ static int ocfs2_init_global_system_inodes(struct ocfs2=
_super *osb)
 		new =3D ocfs2_get_system_file_inode(osb, i, osb->slot_num);
 		if (!new) {
 			ocfs2_release_system_inodes(osb);
-			status =3D -EINVAL;
+			status =3D ocfs2_is_soft_readonly(osb) ? -EROFS : -EINVAL;
 			mlog_errno(status);
-			/* FIXME: Should ERROR_RO_FS */
 			mlog(ML_ERROR, "Unable to load system inode %d, "
 			     "possibly corrupt fs?", i);
 			goto bail;
@@ -504,7 +503,7 @@ static int ocfs2_init_local_system_inodes(struct ocfs2_=
super *osb)
 		new =3D ocfs2_get_system_file_inode(osb, i, osb->slot_num);
 		if (!new) {
 			ocfs2_release_system_inodes(osb);
-			status =3D -EINVAL;
+			status =3D ocfs2_is_soft_readonly(osb) ? -EROFS : -EINVAL;
 			mlog(ML_ERROR, "status=3D%d, sysfile=3D%d, slot=3D%d\n",
 			     status, i, osb->slot_num);
 			goto bail;
--=20
2.15.1
