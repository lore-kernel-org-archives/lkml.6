Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3968184-1523243202-2-12445532319209575321
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
    1523243201; b=w5JwOWRRnCejW6qNvXmnbRCZxTSE+i4CXrqViX/zYoTWzIeQJR
    iA8g4afAfbXAseB1oQE15MJi6pQofk9sf0DC1hi19m9yT4H7eL/gfCTW2B2cHdo4
    YSIH4t2mEfYpf6j33RUnByi3bWWsyr8ql3Re8vwTdQWvkzc3cdUfMvGM22n5PC2V
    rTOgCtOwRebbwjD6zGy0zrMK/Dmg7GVODkNUzmWtKMDfn9uCqGNtrIFHZjV/StFk
    7qiJ31S2ITBvlf8A17xHYYx5RWKWAOdqPKpHoXh5auVaPB/NTZ16OrHLyGl/cEvq
    d7osKbyS1IuVsYs2gfs4kIFfENJxlPvExicQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=fm2; t=1523243201; bh=+Nh5OfBqUb
    6QojyusF33h4UxSk1m23JIqHsIc585VZw=; b=EhaBKFyPE6qT308rx8uszJMthX
    I9QaP3Gsw3kDLtpTUrB3j9eSJPVhGcccvtaO4v2YOvg6RyxMJWy5Sf1nZUtwxx/a
    mo0anBlC85ws7vLaZ++GUMM337iTylRFlh2JdIuJUAeYwNlJmFmLc5W2tduVJTbh
    CLvzd3uWxmkrrW1IM3sPnEjG4yFtHZeAMOgdKT/N0+DiGycTGCaXuHvU/F0ICu0g
    Tn0awbDiJrfPZb2IP+/whQaO148m2CNq4LBtZVrSZnNUlApNQ8b3EnZfIoeok+qM
    1QAV6Kw4nKaIpNo4h4cQLhKRCZ0ArEsBtTfsHyRlGMbAEyrTw8/j2x9pTdNg==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=NzVNEE7M x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=NzVNEE7M x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfFXtQsyGBeLJDRH8vhbfS//suAQ8uFWNFhM5yRtDKa0vMAicof7iYKTa5kSV205cPgZ0EVMPSTGg77gphefqiV9cJcYPgLYwKJbS6xdKo1xXmppej6Ri
    og+HwjU7/G6D8Uzyg06aW/4x56c/UdGH2i4wZAFaS/2eh42vdNMksUTB7+g00cEE4xBHl3vvI5GbGNIoa+T1PquYvMxniMUSCwjEEg9Qf8QlsZgm7nIdurIA
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
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
        id S1752997AbeDIDGh (ORCPT <rfc822;greg@kroah.com>);
        Sun, 8 Apr 2018 23:06:37 -0400
Received: from mail-sn1nam02on0121.outbound.protection.outlook.com ([104.47.36.121]:44416
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932087AbeDIAYj (ORCPT <rfc822;stable@vger.kernel.org>);
        Sun, 8 Apr 2018 20:24:39 -0400
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
Subject: [PATCH AUTOSEL for 4.14 098/161] ocfs2: return error when we attempt
 to access a dirty bh in jbd2
Thread-Topic: [PATCH AUTOSEL for 4.14 098/161] ocfs2: return error when we
 attempt to access a dirty bh in jbd2
Thread-Index: AQHTz5io0YlAiXhm9kazmuNlNSLvvA==
Date: Mon, 9 Apr 2018 00:21:09 +0000
Message-ID: <20180409001936.162706-98-alexander.levin@microsoft.com>
References: <20180409001936.162706-1-alexander.levin@microsoft.com>
In-Reply-To: <20180409001936.162706-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0983;7:RuNzHSOZpKWaaMzbXnvzbIv0/LHLKsSHWyeMm63vlycsBFmbtzlDvwFOnQEORGjpotV5BXb5R9giR3BMSeh1dWu5OUc37pJabhGYZn9OETQ8Ke7AJpihweZtpQ6+dxauC6wpTxJlJa/TKlrvYg7i6lENcKTKSf6GhIpVTAwdzXLH3xPyugRlWEdx5y5ij1qvKfTGSxLyw/tO1VnE09Li5rHCdhRfDmb3hPi6P+422cH7wNSOevIlU/9MQOrFz/LE;20:N4cyQ3XaPijhrgT3CHLZ/DRDrsi5ECtvNhOxsKIG9kFxXF32vWDrp1rEg610IqyPN0uuaf1sQUE2ckcDnJBWa65N2Xz+43ghFkc0iQux2BwEBdl6Mxtt4moVF+tW3X4nCvFrd5WZobCxLp+TfyNL9hhroJVLDnHhv4w1Si2hX6U=
x-ms-office365-filtering-ht: Tenant
X-MS-Office365-Filtering-Correlation-Id: 9f0c52af-fa2a-48e6-7740-08d59db04772
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0983;
x-ms-traffictypediagnostic: DM5PR2101MB0983:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB0983B5B1DB9C38CA8328ED72FBBF0@DM5PR2101MB0983.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(50582790962513)(85827821059158)(42068640409301)(146099531331640);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231221)(944501327)(52105095)(3002001)(10201501046)(6055026)(61426038)(61427038)(6041310)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123564045)(20161123560045)(6072148)(201708071742011);SRVR:DM5PR2101MB0983;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0983;
x-forefront-prvs: 0637FCE711
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(39860400002)(346002)(376002)(39380400002)(366004)(199004)(189003)(43544003)(478600001)(59450400001)(72206003)(10290500003)(3846002)(102836004)(6506007)(551934003)(6116002)(25786009)(6436002)(66066001)(99286004)(54906003)(86612001)(6666003)(105586002)(53936002)(76176011)(316002)(486006)(7736002)(22452003)(3660700001)(86362001)(97736004)(106356001)(8936002)(110136005)(5660300001)(11346002)(446003)(81166006)(81156014)(2906002)(8676002)(2900100001)(1076002)(39060400002)(476003)(2616005)(10090500001)(6486002)(107886003)(36756003)(4326008)(966005)(2501003)(68736007)(186003)(305945005)(3280700002)(5250100002)(6306002)(6512007)(26005)(14454004)(22906009)(14143004)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0983;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: rkeBrb7EeEquWD2k6Lr8T/BR76vK+MM3UY8Y9R7PbrUyswYjllabsv8O+xmMH1ih3p0G6izjeNRSS8JzCqTWD37YYAu2f689jsRK+5O26naKMfluEKbqxnXkhSfy5v2rZGa02Ukn+PoXi4SZF/T1BKyr4SIYAllPQCT96kN0OXURME7dduR0g7eQ1uXnfW3/bjKGYrQkbY7nD9m1fFYw4ns7IbDjJ1QAzR2G6g//uiVQbyTfh5KEj1TggdDEgufLiRYSN+woWgBvJxQ7V9dstHG9gZpPUNbXYxd580pJsFmnqLAREKsUBjlKOpl+3Et2Bj0a5ilRhyC2X8N53WuTChhe+E9KVBzwlArbZD/63bc0x69Hk591Dk3k8E6MdZtJMZ2UKQxinBspyQA4wmolloWaeiTRfzMRLj73VS9kp0A=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f0c52af-fa2a-48e6-7740-08d59db04772
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2018 00:21:09.6907
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0983
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
index 36304434eacf..e5dcea6cee5f 100644
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
