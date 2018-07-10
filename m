Return-Path: <SRS0=n7Wc=J2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A2C1C3279B
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 18:27:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5092A20936
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 18:27:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5092A20936
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732719AbeGJS2A (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Jul 2018 14:28:00 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:44910 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732632AbeGJS17 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jul 2018 14:27:59 -0400
Received: from localhost (LFbn-1-12247-202.w90-92.abo.wanadoo.fr [90.92.61.202])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 46BD9D66;
        Tue, 10 Jul 2018 18:27:48 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Theodore Tso <tytso@mit.edu>,
        stable@kernel.org
Subject: [PATCH 4.4 27/47] ext4: include the illegal physical block in the bad map ext4_error msg
Date:   Tue, 10 Jul 2018 20:24:51 +0200
Message-Id: <20180710182338.285158331@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180710182337.047502999@linuxfoundation.org>
References: <20180710182337.047502999@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Theodore Ts'o <tytso@mit.edu>

commit bdbd6ce01a70f02e9373a584d0ae9538dcf0a121 upstream.

Signed-off-by: Theodore Ts'o <tytso@mit.edu>
Cc: stable@kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/ext4/inode.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -380,9 +380,9 @@ static int __check_block_validity(struct
 	if (!ext4_data_block_valid(EXT4_SB(inode->i_sb), map->m_pblk,
 				   map->m_len)) {
 		ext4_error_inode(inode, func, line, map->m_pblk,
-				 "lblock %lu mapped to illegal pblock "
+				 "lblock %lu mapped to illegal pblock %llu "
 				 "(length %d)", (unsigned long) map->m_lblk,
-				 map->m_len);
+				 map->m_pblk, map->m_len);
 		return -EFSCORRUPTED;
 	}
 	return 0;


