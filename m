Return-Path: <SRS0=G629=LR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98A11C433F5
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 17:06:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5DB3520843
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 17:06:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5DB3520843
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729690AbeICV1Y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Sep 2018 17:27:24 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:39650 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729364AbeICV1X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Sep 2018 17:27:23 -0400
Received: from localhost (ip-213-127-74-90.ip.prioritytelecom.net [213.127.74.90])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 84D58D02;
        Mon,  3 Sep 2018 17:06:22 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Pavel Shilovsky <pshilov@microsoft.com>,
        Steve French <stfrench@microsoft.com>,
        Ronnie Sahlberg <lsahlber@redhat.com>
Subject: [PATCH 4.9 056/107] smb3: dont request leases in symlink creation and query
Date:   Mon,  3 Sep 2018 18:56:20 +0200
Message-Id: <20180903165640.021505684@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180903165637.293735109@linuxfoundation.org>
References: <20180903165637.293735109@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Steve French <stfrench@microsoft.com>

commit 22783155f4bf956c346a81624ec9258930a6fe06 upstream.

Fixes problem pointed out by Pavel in discussions about commit
729c0c9dd55204f0c9a823ac8a7bfa83d36c7e78

Signed-off-by: Pavel Shilovsky <pshilov@microsoft.com>
Signed-off-by: Steve French <stfrench@microsoft.com>
Reviewed-by: Ronnie Sahlberg <lsahlber@redhat.com>
CC: Stable <stable@vger.kernel.org> # 3.18.x+
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/cifs/link.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/fs/cifs/link.c
+++ b/fs/cifs/link.c
@@ -419,7 +419,7 @@ smb3_query_mf_symlink(unsigned int xid,
 	struct cifs_io_parms io_parms;
 	int buf_type = CIFS_NO_BUFFER;
 	__le16 *utf16_path;
-	__u8 oplock = SMB2_OPLOCK_LEVEL_II;
+	__u8 oplock = SMB2_OPLOCK_LEVEL_NONE;
 	struct smb2_file_all_info *pfile_info = NULL;
 
 	oparms.tcon = tcon;
@@ -481,7 +481,7 @@ smb3_create_mf_symlink(unsigned int xid,
 	struct cifs_io_parms io_parms;
 	int create_options = CREATE_NOT_DIR;
 	__le16 *utf16_path;
-	__u8 oplock = SMB2_OPLOCK_LEVEL_EXCLUSIVE;
+	__u8 oplock = SMB2_OPLOCK_LEVEL_NONE;
 	struct kvec iov[2];
 
 	if (backup_cred(cifs_sb))


