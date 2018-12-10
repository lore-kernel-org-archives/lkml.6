Return-Path: <SRS0=GJN7=OT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FBA1C04EB8
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 20:52:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CC86A2082F
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 20:52:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CC86A2082F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729472AbeLJUwv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Dec 2018 15:52:51 -0500
Received: from mout.kundenserver.de ([212.227.126.131]:33511 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726100AbeLJUwv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Dec 2018 15:52:51 -0500
Received: from wuerfel.lan ([109.192.41.194]) by mrelayeu.kundenserver.de
 (mreue009 [212.227.15.129]) with ESMTPA (Nemesis) id
 1MLi4W-1gnzQC0PvE-00HbuU; Mon, 10 Dec 2018 21:52:20 +0100
From:   Arnd Bergmann <arnd@arndb.de>
To:     qla2xxx-upstream@qlogic.com,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     Bart Van Assche <bvanassche@acm.org>,
        Laurence Oberman <loberman@redhat.com>,
        Himanshu Madhani <himanshu.madhani@cavium.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Arnd Bergmann <arnd@arndb.de>,
        Himanshu Madhani <hmadhani@marvell.com>,
        Quinn Tran <quinn.tran@cavium.com>,
        Hannes Reinecke <hare@suse.de>, Jens Axboe <axboe@kernel.dk>,
        Darren Trapp <darren.trapp@cavium.com>,
        Bill Kuzeja <William.Kuzeja@stratus.com>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] scsi: qla2xxx: fix unused function warning
Date:   Mon, 10 Dec 2018 21:51:43 +0100
Message-Id: <20181210205215.2703138-1-arnd@arndb.de>
X-Mailer: git-send-email 2.20.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:McxYStCKdDFilTdcSXx15TImaTGWkmXm18OnKWlNfLgZm1Johr+
 BN9U0v17D3TyGyUjVjNK2vSOIbjnrWVdE3CikNnTOm5Iy1Tgf+DThIr8QhykN4M5RYLiA2u
 GsCR058HfWj4KsvOqBeybdgEz7RV6E6Eg7u9uYC6WzL2oZNyeZmSd/PdC0oFqH6Cr9onghy
 MMmtMf7XG6rPMvgo4GR5Q==
X-UI-Out-Filterresults: notjunk:1;V03:K0:kCozPeBj9B4=:Ft1jPuR9NUEGfjaN3ApMN+
 N7XJUSaJXucpnow2W/53oyeWA0Bqsa0iC18sYzr/zGR7AWadYrgUWLVbGHAvjn+2cTXpOfitk
 frsUKmpOwF2TtV+eYM9ZJOtwgRA8TFpqPU7UfYIQw1SIJMnl/VrJYAc6GXgl4MF5hi9NA6EeL
 G4zokpsJMEMRpMD0Y/xVFpv+NNKRz8PQTxTrTqkKcAsdVh4xJJLnQGOOjLQRnka1mtT4kcNlw
 s1PnM9lBD9Th3s0jrgGtT0Wl+xsh8IM4y8zUeNHIjCa4WJlSZoETFUVBQEqJ8FBDeQt+CMC1H
 ySsrUz/llLowIzH3VauWc162tqnwX98OCa8WcfZGkrWodiwSIj+8e+LE+w291wZFtGqt4zKCI
 C2mjh0+mdxjsEQ5gWcrnpA/E0wsscIJpgA49x9zfC1u08tEUZM9Cj7bcUBOkM2ofh/ok/l64d
 vac1aQV3qU0ae6ZEXPgz5ji+D+5dxGdyp4v4YniL2TH/CGOs2lw/uCHGpS1h7+ph3SgMQ6Sx9
 +4icMJ56N6JjBbtICHefqoXKHtv2yLyQ9dLY8J2jN95LNm19zKFG70fYdVeDDNV328/Ua2pH8
 /MvQfKvE3xMWOJNN8CMw0bHTsMMWcU7+iw2Sglwq0HPxrLcPne/6yNbuQLaxCrw4W1/FU82qX
 BjXBMiC5de5LwDAHBw4+1TUOlmTh9IQEN9QdctCU+/jnLjsL2Rb6Yvtu9h7mzzGFnMugdpDs+
 N+nuCPv6TyvHbf9t6j4CKNjbL39fJipet8x/KQ==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In what seems to be a mismatch between the scsi-fixes branch and
the scsi-mkp/for-next branch, a newly introduced variable from
one patch got obsoleted in another one:

drivers/scsi/qla2xxx/qla_os.c: In function '__qla2x00_abort_all_cmds':
drivers/scsi/qla2xxx/qla_os.c:1791:11: error: unused variable 'status' [-Werror=unused-variable]

Remove the variable again.

Fixes: c4e521b654e1 ("scsi: qla2xxx: Split the __qla2x00_abort_all_cmds() function")
Fixes: f2ffd4e5bc7b ("scsi: qla2xxx: Timeouts occur on surprise removal of QLogic adapter")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
Maybe check carefully that the merge in linux-next is otherwise correct
---
 drivers/scsi/qla2xxx/qla_os.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/scsi/qla2xxx/qla_os.c b/drivers/scsi/qla2xxx/qla_os.c
index 63c47bc7ae59..db331cb5ba3c 100644
--- a/drivers/scsi/qla2xxx/qla_os.c
+++ b/drivers/scsi/qla2xxx/qla_os.c
@@ -1788,7 +1788,7 @@ static void qla2x00_abort_srb(struct qla_qpair *qp, srb_t *sp, const int res,
 static void
 __qla2x00_abort_all_cmds(struct qla_qpair *qp, int res)
 {
-	int cnt, status;
+	int cnt;
 	unsigned long flags;
 	srb_t *sp;
 	scsi_qla_host_t *vha = qp->vha;
-- 
2.20.0

