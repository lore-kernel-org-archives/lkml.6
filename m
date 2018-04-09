Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3689844-1523236196-2-10473970609739418485
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523236196; b=I43x8pwVl6SF8mtI/Hz2FGG7Tdnc303c+2Dt1bsRcitQ1hHUMG
    PxWJ8ScDCw9ullShiAs9t/M501jX1XxdKodO1kcJPQtilqBhY60TD9l2u0g2naTi
    8952jYle5vmd2UFGYk6KT1x9tIpeeBSjaAr3YYNFnapFisYBEvTwRkZvwDM9aFVv
    tQ5ahUD3ySnA3sPKmsmWxsTvQxq5RaVRQnEwAiBF/UPUktyx2iHcSPGKhzkPecjF
    pPqofxUYxEnjs6zF0v8PEc1FzWsdUNtKKav7+LOTtzlj57xEyIUVXFJiA5PWgqNU
    N1rx6YS+XmoekDbebs7PM1HzqIutRghnuHLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=fm2; t=1523236196; bh=oKfaYSi6vl
    jBuBKuEac3hmWJb9c19FG9GHjNhiUQGK0=; b=hMf/Oa3zXKI1wrfh4tD9z7/1T+
    f2UZpl74dAcrmPyqrVkqX9mHmdpoDmPdtb0H6WR5ZGrhawS0rDk9CkzNe+pIAv/x
    KbzKjLs4cR31rsIdzWWtxnvbvZKRMd7u1cHFNvZig8ut2I/Epya37+pGez4uLzT/
    mQzMyh751BflL0UmOFIzU71cN7eqhXvAGsluzPRJ0PBWRAGt/IvAFfvDcvGyNiKw
    GONObYI4b76jW0nkBReM7Z+q5qt/Vwja/VnTvoLEbhP5GWoD7jFRjE/9fNEActem
    Y4pnuzdtC0EKqC9t4RfVKfTQoiQWdFM509FFBRK4ALF+icCAyRLvONBw9OIA==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=RJ83hjyp x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=RJ83hjyp x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfJNGKg4Rjr0h/di75kmlORg37stiIrwBsl4AeFk1f9j/zPMjsu/uG70s60sTdqCi/HxZzjXDGKYKGezzQSefxBrWnsjppXvStGwHbhwtNECdjBOi3b7E
    WR8dzJlpazHarm76Ju13tt6oSiR82YtN78zMC4yQa9aOQ0RpeNu8wpyGeLI7UhFNCWfmpbm/bMxk0daeatZ1HuyDRJY23/WH4/Cda/3Irxhyz8yBAG9nA/3K
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=wRwT6uffUbIA:10 a=t_PdEiP4ckcA:10
    a=mw6kJ3eo-EIA:10 a=8nJEP1OIZ-IA:10 a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10
    a=Lf-vpJhqX20A:10 a=i0EeH86SAAAA:8 a=VwQbUJbxAAAA:8 a=UtV5FjuMAAAA:8
    a=o8Bf2xIQAAAA:8 a=IXr_WNlcAAAA:8 a=yPCof4ZbAAAA:8 a=pGLkceISAAAA:8
    a=Z4Rwk6OoAAAA:8 a=yMhMjlubAAAA:8 a=FreliyUT6uAS0AdjSgsA:9 a=wPNLvfGTeEIA:10
    a=AjGcO6oz07-iQ99wixmX:22 a=ehT88nhQmDs7a44Z_RBH:22 a=kLeBEu5l8tkQtVp4YdQK:22
    a=K24ECnMRWNUKRqF_MnsZ:22 a=HkZW87K1Qel5hWWM3VKY:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757078AbeDIBJw (ORCPT <rfc822;greg@kroah.com>);
        Sun, 8 Apr 2018 21:09:52 -0400
Received: from mail-co1nam03on0137.outbound.protection.outlook.com ([104.47.40.137]:26752
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S933010AbeDIAiq (ORCPT <rfc822;stable@vger.kernel.org>);
        Sun, 8 Apr 2018 20:38:46 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: piaojun <piaojun@huawei.com>, Mark Fasheh <mfasheh@versity.com>,
        Joel Becker <jlbec@evilplan.org>,
        Junxiao Bi <junxiao.bi@oracle.com>,
        Joseph Qi <jiangqi903@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.4 138/162] ocfs2: return error when we attempt
 to access a dirty bh in jbd2
Thread-Topic: [PATCH AUTOSEL for 4.4 138/162] ocfs2: return error when we
 attempt to access a dirty bh in jbd2
Thread-Index: AQHTz5nVf6u8KOP5BE2b8KxLj/kltg==
Date: Mon, 9 Apr 2018 00:29:33 +0000
Message-ID: <20180409002738.163941-138-alexander.levin@microsoft.com>
References: <20180409002738.163941-1-alexander.levin@microsoft.com>
In-Reply-To: <20180409002738.163941-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1095;7:NKlYTz9BE6Z2n2cvmv+sAW4HAvtyCUzaK/Izqqgo4PZANZU8Ck8dQNT9e6fAiWtW2h7qpiWnatGNv2YRNr7TyYC7beZJ679uMK0DFPNwn2F6Yu3jb3t1JgJxk9zVZ6vMwNUPL8UzCmkZc43JPRB961YfB+xPIXvinxU5BFfo40T2sBbqKoSvFlOy1uYlJbvdhhXB6WnRcd+n6Fdud/ogZrsp2glOVvlWEcmig+yEUyBXUIxhHVE/DGyUHiAwdhCb;20:abxOmVod6cbzull1SlaQ4d7Cqdnlb0VWqHrd5qzhbrDFZbS53LtQ8k3rqgxR6Ej/4/cZ7Aq1/JzNorIacniOJGGw2WU5XCtfMzeqDIYQ4nY/tmO3aYHMgI14tELR7b/EFwFFk2IEHIDTgRz4RLGUQwUzGJrLbV+jdUp1Y2QpH1k=
x-ms-office365-filtering-ht: Tenant
X-MS-Office365-Filtering-Correlation-Id: 99f7ffc5-d7ca-43df-003e-08d59db23d94
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB1095;
x-ms-traffictypediagnostic: DM5PR2101MB1095:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB10953DC49C2FA4E2A6056577FBBF0@DM5PR2101MB1095.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(50582790962513)(85827821059158)(42068640409301)(146099531331640);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(8121501046)(5005006)(3231221)(944501327)(52105095)(10201501046)(3002001)(93006095)(93001095)(6055026)(61426038)(61427038)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123560045)(20161123562045)(20161123564045)(6072148)(201708071742011);SRVR:DM5PR2101MB1095;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1095;
x-forefront-prvs: 0637FCE711
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39380400002)(346002)(366004)(396003)(39860400002)(376002)(43544003)(189003)(199004)(26005)(10090500001)(476003)(105586002)(39060400002)(86362001)(107886003)(11346002)(446003)(2616005)(102836004)(6306002)(76176011)(6512007)(97736004)(36756003)(6666003)(6506007)(8676002)(59450400001)(99286004)(4326008)(10290500003)(81156014)(86612001)(81166006)(186003)(486006)(2900100001)(106356001)(1076002)(72206003)(478600001)(305945005)(8936002)(25786009)(3660700001)(7736002)(966005)(68736007)(66066001)(110136005)(316002)(54906003)(3280700002)(2906002)(3846002)(6116002)(6436002)(551934003)(53936002)(6486002)(22452003)(2501003)(5250100002)(14454004)(5660300001)(22906009)(14143004)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1095;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: +SPtdkq2cNetaNFtL+zpIY+C8y4HmWKr8cxoLWTPxBlbdHB1X8ZU5R366xR5BcxFdnPqClkw28EqfUjdeJlbqYDTruYbwddLcPexX+WzKFsLr5GF8q59iaz+PDjgEOcbnNHQ53FQX/aMwMDAb1Ox/ia26MDyTSeCCfE41lZN3u8nye5dJHSRrivlUuvnEqWsw9om3T+zccx1bjs9LiqNKq0ZyMPu83OfYufTwC47/l1/G9FJQV1IEdSN6sF0nj5eH/Dzctg5KmC0vdNoBU7Ad701mZ0NLLWWzBFwSp5t3dCS8QDW/xWZ0o6tsTyeNDxQ8bb4k/oDp/wKKuI6mqmaHP1/SnzSLE1i+mVV2sh1LSLm2m2QPTHUJ+KkYdg8i7bQ+6I5dFo3JE/GAbzEbCQKU30njawbylj3BQ5xXUHd560=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 99f7ffc5-d7ca-43df-003e-08d59db23d94
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2018 00:29:33.7869
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1095
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: piaojun <piaojun@huawei.com>

[ Upstream commit d984187e3a1ad7d12447a7ab2c43ce3717a2b5b3 ]

We should not reuse the dirty bh in jbd2 directly due to the following
situation:

1. When removing extent rec, we will dirty the bhs of extent rec and
   truncate log at the same time, and hand them over to jbd2.

2. The bhs are submitted to jbd2 area successfully.

3. The write-back thread of device help flush the bhs to disk but
   encounter write error due to abnormal storage link.

4. After a while the storage link become normal. Truncate log flush
   worker triggered by the next space reclaiming found the dirty bh of
   truncate log and clear its 'BH_Write_EIO' and then set it uptodate in
   __ocfs2_journal_access():

   ocfs2_truncate_log_worker
     ocfs2_flush_truncate_log
       __ocfs2_flush_truncate_log
         ocfs2_replay_truncate_records
           ocfs2_journal_access_di
             __ocfs2_journal_access // here we clear io_error and set 'tl_b=
h' uptodata.

5. Then jbd2 will flush the bh of truncate log to disk, but the bh of
   extent rec is still in error state, and unfortunately nobody will
   take care of it.

6. At last the space of extent rec was not reduced, but truncate log
   flush worker have given it back to globalalloc. That will cause
   duplicate cluster problem which could be identified by fsck.ocfs2.

Sadly we can hardly revert this but set fs read-only in case of ruining
atomicity and consistency of space reclaim.

Link: http://lkml.kernel.org/r/5A6E8092.8090701@huawei.com
Fixes: acf8fdbe6afb ("ocfs2: do not BUG if buffer not uptodate in __ocfs2_j=
ournal_access")
Signed-off-by: Jun Piao <piaojun@huawei.com>
Reviewed-by: Yiwen Jiang <jiangyiwen@huawei.com>
Reviewed-by: Changwei Ge <ge.changwei@h3c.com>
Cc: Mark Fasheh <mfasheh@versity.com>
Cc: Joel Becker <jlbec@evilplan.org>
Cc: Junxiao Bi <junxiao.bi@oracle.com>
Cc: Joseph Qi <jiangqi903@gmail.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 fs/ocfs2/journal.c | 23 ++++++++++++-----------
 1 file changed, 12 insertions(+), 11 deletions(-)

diff --git a/fs/ocfs2/journal.c b/fs/ocfs2/journal.c
index 13534f4fe5b5..722eb5bc9b8f 100644
--- a/fs/ocfs2/journal.c
+++ b/fs/ocfs2/journal.c
@@ -666,23 +666,24 @@ static int __ocfs2_journal_access(handle_t *handle,
 	/* we can safely remove this assertion after testing. */
 	if (!buffer_uptodate(bh)) {
 		mlog(ML_ERROR, "giving me a buffer that's not uptodate!\n");
-		mlog(ML_ERROR, "b_blocknr=3D%llu\n",
-		     (unsigned long long)bh->b_blocknr);
+		mlog(ML_ERROR, "b_blocknr=3D%llu, b_state=3D0x%lx\n",
+		     (unsigned long long)bh->b_blocknr, bh->b_state);
=20
 		lock_buffer(bh);
 		/*
-		 * A previous attempt to write this buffer head failed.
-		 * Nothing we can do but to retry the write and hope for
-		 * the best.
+		 * A previous transaction with a couple of buffer heads fail
+		 * to checkpoint, so all the bhs are marked as BH_Write_EIO.
+		 * For current transaction, the bh is just among those error
+		 * bhs which previous transaction handle. We can't just clear
+		 * its BH_Write_EIO and reuse directly, since other bhs are
+		 * not written to disk yet and that will cause metadata
+		 * inconsistency. So we should set fs read-only to avoid
+		 * further damage.
 		 */
 		if (buffer_write_io_error(bh) && !buffer_uptodate(bh)) {
-			clear_buffer_write_io_error(bh);
-			set_buffer_uptodate(bh);
-		}
-
-		if (!buffer_uptodate(bh)) {
 			unlock_buffer(bh);
-			return -EIO;
+			return ocfs2_error(osb->sb, "A previous attempt to "
+					"write this buffer head failed\n");
 		}
 		unlock_buffer(bh);
 	}
--=20
2.15.1
