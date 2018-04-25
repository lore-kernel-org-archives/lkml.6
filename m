Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-557887-1524653759-2-17065817050945389962
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1524653759; b=hyUyxcbx/D0e6yN+wXhFgnUVfltpS0/rwaLp2awtYw/3i5ExPL
    xqleD68Fof2ocC7OD59x0qQFyrnA6T2q5XJw4B7CZBmk0AEyEx97X4PVKB1o8D+k
    V61MTqQ2nHdWrj9WViWt+7emn3ebynFi4EpTsFnHGm2RUn9PBPvKr07tjgYIM9Nw
    rjVJH2D3JrRQYYB+x9T54ICB5eDbzPT7ysLCaHXD83TbipzH8Cpa0vpm1fuRtZjF
    ZwbpUB0lVKtvRlwyBHa0X6rd7P2SRyZ+9XhMPV5F64ts+MF5S260f0vmTzfV+spl
    nV/ZtvHrchpVrNU2IO64/193GAiGuOFFWoUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1524653759; bh=uNaqFertqxW0m1cW5TsLLju5wySsju
    wPIT0Z1HvymTo=; b=gEWUVS6hP/ZxEEPd4CEsHeAVpvr+HRGFdv7d/tWDFByQE5
    fYGvIssE01wSiP4zVG/gnMHF8ru7/mhMa5yjSRsGeK9wKbc1buux4OSYdyVF8CJl
    o7HX/OIRl1gF1JEsaU1TxrZ+pg4SUhRxCyTDSpMEk79CfibsxqVn12oeS2o65buh
    DpWQ7fj1UXVe+3BYPAFQV5mJebaM6XHzeoJgPdtWfV6hnv37g5lYQTOZ9lQZlLRg
    WkNVIZfhc5D6TURm9AYgb7pkjFjHzZbM+KTCXW6d/gfsZyo3dhoDc6K4N/OX1cnR
    4cReZzHWFNTXQ81c/nfO8pffsTWdCXwMM0XN6oHQ==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfJprLhBraQ7ZFVhRo+oUIV4UAbeuuEAJF2zPjnVQ3jQd4xxvjBV0SqWyEzcHJjhs0IzH0Wm7h35C1WiUWzyx4z1m8pUiLWB+tz/NY/A1Cvk2gtwXxEsp
    PqgT7jnRml5GGFl+3qE+7JdSQDYsZVt64Kja268GXAVCiGVZjgQRVXIV0TtZoozJllPTii4yQdVbUDw/PoSKZnkMfOKJEqWrwtckojlD870Qvtf1MIHMiCE3
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=i0EeH86SAAAA:8 a=VwQbUJbxAAAA:8 a=UtV5FjuMAAAA:8 a=o8Bf2xIQAAAA:8
    a=IXr_WNlcAAAA:8 a=yPCof4ZbAAAA:8 a=pGLkceISAAAA:8 a=Z4Rwk6OoAAAA:8
    a=yMhMjlubAAAA:8 a=ag1SF4gXAAAA:8 a=FreliyUT6uAS0AdjSgsA:9 a=QEXdDO2ut3YA:10
    a=AjGcO6oz07-iQ99wixmX:22 a=ehT88nhQmDs7a44Z_RBH:22 a=kLeBEu5l8tkQtVp4YdQK:22
    a=K24ECnMRWNUKRqF_MnsZ:22 a=HkZW87K1Qel5hWWM3VKY:22 a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754088AbeDYKzi (ORCPT <rfc822;greg@kroah.com>);
        Wed, 25 Apr 2018 06:55:38 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:52920 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753858AbeDYKnQ (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 25 Apr 2018 06:43:16 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jun Piao <piaojun@huawei.com>,
        Yiwen Jiang <jiangyiwen@huawei.com>,
        Changwei Ge <ge.changwei@h3c.com>,
        Mark Fasheh <mfasheh@versity.com>,
        Joel Becker <jlbec@evilplan.org>,
        Junxiao Bi <junxiao.bi@oracle.com>,
        Joseph Qi <jiangqi903@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.14 110/183] ocfs2: return error when we attempt to access a dirty bh in jbd2
Date: Wed, 25 Apr 2018 12:35:30 +0200
Message-Id: <20180425103246.874406810@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180425103242.532713678@linuxfoundation.org>
References: <20180425103242.532713678@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

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
             __ocfs2_journal_access // here we clear io_error and set 'tl_bh' uptodata.

5. Then jbd2 will flush the bh of truncate log to disk, but the bh of
   extent rec is still in error state, and unfortunately nobody will
   take care of it.

6. At last the space of extent rec was not reduced, but truncate log
   flush worker have given it back to globalalloc. That will cause
   duplicate cluster problem which could be identified by fsck.ocfs2.

Sadly we can hardly revert this but set fs read-only in case of ruining
atomicity and consistency of space reclaim.

Link: http://lkml.kernel.org/r/5A6E8092.8090701@huawei.com
Fixes: acf8fdbe6afb ("ocfs2: do not BUG if buffer not uptodate in __ocfs2_journal_access")
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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/ocfs2/journal.c |   23 ++++++++++++-----------
 1 file changed, 12 insertions(+), 11 deletions(-)

--- a/fs/ocfs2/journal.c
+++ b/fs/ocfs2/journal.c
@@ -666,23 +666,24 @@ static int __ocfs2_journal_access(handle
 	/* we can safely remove this assertion after testing. */
 	if (!buffer_uptodate(bh)) {
 		mlog(ML_ERROR, "giving me a buffer that's not uptodate!\n");
-		mlog(ML_ERROR, "b_blocknr=%llu\n",
-		     (unsigned long long)bh->b_blocknr);
+		mlog(ML_ERROR, "b_blocknr=%llu, b_state=0x%lx\n",
+		     (unsigned long long)bh->b_blocknr, bh->b_state);
 
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
