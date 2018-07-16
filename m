Return-Path: <SRS0=eGoB=KA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0329FECDFAA
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 07:38:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BDA1B206B7
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 07:38:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BDA1B206B7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387784AbeGPIEx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Jul 2018 04:04:53 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:47012 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726898AbeGPIEx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jul 2018 04:04:53 -0400
Received: from localhost (LFbn-1-12247-202.w90-92.abo.wanadoo.fr [90.92.61.202])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 655E6C03;
        Mon, 16 Jul 2018 07:38:51 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        syzbot+08ab33be0178b76851c8@syzkaller.appspotmail.com,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Eric Sandeen <sandeen@redhat.com>
Subject: [PATCH 4.17 58/67] xfs: fix inobt magic number check
Date:   Mon, 16 Jul 2018 09:35:27 +0200
Message-Id: <20180716073452.939919041@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180716073443.294323458@linuxfoundation.org>
References: <20180716073443.294323458@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.17-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Darrick J. Wong <darrick.wong@oracle.com>

commit 2e050e648ad6c74a2f0a28f645155128be0626ca upstream.

In commit a6a781a58befcbd467c ("xfs: have buffer verifier functions
report failing address") the bad magic number return was ported
incorrectly.

Fixes: a6a781a58befcbd467ce843af4eaca3906aa1f08
Reported-by: syzbot+08ab33be0178b76851c8@syzkaller.appspotmail.com
Signed-off-by: Darrick J. Wong <darrick.wong@oracle.com>
Reviewed-by: Eric Sandeen <sandeen@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/xfs/libxfs/xfs_ialloc_btree.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/fs/xfs/libxfs/xfs_ialloc_btree.c
+++ b/fs/xfs/libxfs/xfs_ialloc_btree.c
@@ -296,7 +296,7 @@ xfs_inobt_verify(
 	case cpu_to_be32(XFS_FIBT_MAGIC):
 		break;
 	default:
-		return NULL;
+		return __this_address;
 	}
 
 	/* level verification */


