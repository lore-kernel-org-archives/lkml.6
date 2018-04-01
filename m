Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753220AbeDAAdg (ORCPT <rfc822;w@1wt.eu>);
        Sat, 31 Mar 2018 20:33:36 -0400
Received: from mga17.intel.com ([192.55.52.151]:40156 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753045AbeDAAdd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 31 Mar 2018 20:33:33 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.48,389,1517904000";
   d="scan'208";a="42398398"
Date: Sun, 1 Apr 2018 08:32:41 +0800
From: kbuild test robot <lkp@intel.com>
To: Rahul Lakkireddy <rahul.lakkireddy@chelsio.com>
Cc: kbuild-all@01.org, netdev@vger.kernel.org, kexec@lists.infradead.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        davem@davemloft.net, viro@zeniv.linux.org.uk, ebiederm@xmission.com,
        stephen@networkplumber.org, akpm@linux-foundation.org,
        torvalds@linux-foundation.org, ganeshgr@chelsio.com,
        nirranjan@chelsio.com, indranil@chelsio.com,
        Rahul Lakkireddy <rahul.lakkireddy@chelsio.com>
Subject: [RFC PATCH] vmcore: __vmcore_add_device_dump() can be static
Message-ID: <20180401003241.GA77163@lkp-sb-ep06.lkp.intel.com>
References: <194d1e289b385f2cbd4cb2c2569af93723a9cfb8.1522483891.git.rahul.lakkireddy@chelsio.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <194d1e289b385f2cbd4cb2c2569af93723a9cfb8.1522483891.git.rahul.lakkireddy@chelsio.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: fengguang.wu@intel.com
X-SA-Exim-Scanned: No (on bee); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Fixes: 6bf7e2b7f850 ("vmcore: add API to collect hardware dump in second kernel")
Signed-off-by: Fengguang Wu <fengguang.wu@intel.com>
---
 vmcore.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/proc/vmcore.c b/fs/proc/vmcore.c
index b53698f..fe788dd 100644
--- a/fs/proc/vmcore.c
+++ b/fs/proc/vmcore.c
@@ -1196,7 +1196,7 @@ static void vmcoredd_write_note(const char *name, void *buf, size_t size)
  * Write Elf note at the beginning of the buffer to indicate vmcore device
  * dump and add the dump to global list.
  */
-int __vmcore_add_device_dump(struct vmcoredd_data *data)
+static int __vmcore_add_device_dump(struct vmcoredd_data *data)
 {
 	size_t note_size, data_size;
 	struct vmcoredd_node *dump;
