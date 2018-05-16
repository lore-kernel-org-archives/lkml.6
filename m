Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752636AbeEPMsd (ORCPT <rfc822;w@1wt.eu>);
        Wed, 16 May 2018 08:48:33 -0400
Received: from mga01.intel.com ([192.55.52.88]:33630 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751671AbeEPMsL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 May 2018 08:48:11 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,390,1520924400";
   d="scan'208";a="54849658"
Date: Wed, 16 May 2018 20:47:21 +0800
From: kbuild test robot <lkp@intel.com>
To: Matthew Wilcox <willy@infradead.org>
Cc: kbuild-all@01.org, linux-kernel@vger.kernel.org,
        linux-scsi@vger.kernel.org, target-devel@vger.kernel.org,
        linux1394-devel@lists.sourceforge.net, linux-usb@vger.kernel.org,
        kvm@vger.kernel.org, virtualization@lists.linux-foundation.org,
        netdev@vger.kernel.org, Juergen Gross <jgross@suse.com>,
        qla2xxx-upstream@qlogic.com,
        Kent Overstreet <kent.overstreet@gmail.com>,
        Jens Axboe <axboe@kernel.dk>, Matthew Wilcox <mawilcox@microsoft.com>
Subject: [RFC PATCH] iscsit_wait_for_tag() can be static
Message-ID: <20180516124721.GA27100@ivb43.lkp.intel.com>
References: <20180515160043.27044-2-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180515160043.27044-2-willy@infradead.org>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: fengguang.wu@intel.com
X-SA-Exim-Scanned: No (on bee); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Fixes: 5aff7a710f13 ("Convert target drivers to use sbitmap")
Signed-off-by: Fengguang Wu <fengguang.wu@intel.com>
---
 iscsi_target_util.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/target/iscsi/iscsi_target_util.c b/drivers/target/iscsi/iscsi_target_util.c
index 28bcffa..e147aef 100644
--- a/drivers/target/iscsi/iscsi_target_util.c
+++ b/drivers/target/iscsi/iscsi_target_util.c
@@ -147,7 +147,7 @@ void iscsit_free_r2ts_from_list(struct iscsi_cmd *cmd)
 	spin_unlock_bh(&cmd->r2t_lock);
 }
 
-int iscsit_wait_for_tag(struct se_session *se_sess, int state, int *cpup)
+static int iscsit_wait_for_tag(struct se_session *se_sess, int state, int *cpup)
 {
 	int tag = -1;
 	DEFINE_WAIT(wait);
