Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751378AbeEKAvU (ORCPT <rfc822;w@1wt.eu>);
        Thu, 10 May 2018 20:51:20 -0400
Received: from mga02.intel.com ([134.134.136.20]:55170 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750746AbeEKAvR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 May 2018 20:51:17 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,387,1520924400";
   d="scan'208";a="54205652"
Date: Fri, 11 May 2018 08:50:26 +0800
From: kbuild test robot <lkp@intel.com>
To: Steve French <smfrench@gmail.com>
Cc: kbuild-all@01.org, linux-cifs@vger.kernel.org,
        samba-technical@lists.samba.org, Ronnie Sahlberg <lsahlber@redhat.com>,
        Pavel Shilovsky <pshilov@microsoft.com>, linux-kernel@vger.kernel.org
Subject: [RFC PATCH cifs] smb3: cifs_dir_fsync() can be static
Message-ID: <20180511005026.GA57926@lkp-sb04>
References: <201805110802.lpBxehxn%fengguang.wu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <201805110802.lpBxehxn%fengguang.wu@intel.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: fengguang.wu@intel.com
X-SA-Exim-Scanned: No (on bee); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Fixes: c3d5c2a93abf ("smb3: directory sync should not return an error")
Signed-off-by: Fengguang Wu <fengguang.wu@intel.com>
---
 cifsfs.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/cifs/cifsfs.c b/fs/cifs/cifsfs.c
index 8e41186..62f1662 100644
--- a/fs/cifs/cifsfs.c
+++ b/fs/cifs/cifsfs.c
@@ -1053,7 +1053,7 @@ ssize_t cifs_file_copychunk_range(unsigned int xid,
  * Directory operations under CIFS/SMB2/SMB3 are synchronous, so fsync()
  * is a dummy operation.
  */
-int cifs_dir_fsync(struct file *file, loff_t start, loff_t end, int datasync)
+static int cifs_dir_fsync(struct file *file, loff_t start, loff_t end, int datasync)
 {
 	cifs_dbg(FYI, "Sync directory - name: %pD datasync: 0x%x\n",
 		 file, datasync);
