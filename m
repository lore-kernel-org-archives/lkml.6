Return-Path: <SRS0=cKeY=I6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id CF0BFC5CFF1
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 08:11:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 903DE208AE
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 08:11:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 903DE208AE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sony.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933789AbeFLILG (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Jun 2018 04:11:06 -0400
Received: from seldsegrel01.sonyericsson.com ([37.139.156.29]:6070 "EHLO
        SELDSEGREL01.sonyericsson.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S933776AbeFLIJ7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jun 2018 04:09:59 -0400
From:   Peter Enderborg <peter.enderborg@sony.com>
To:     <peter.enderborg@sony.com>, Paul Moore <paul@paul-moore.com>,
        Stephen Smalley <sds@tycho.nsa.gov>,
        Eric Paris <eparis@parisplace.org>,
        James Morris <jmorris@namei.org>,
        Daniel Jurgens <danielj@mellanox.com>,
        Doug Ledford <dledford@redhat.com>, <selinux@tycho.nsa.gov>,
        <linux-security-module@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        "Serge E . Hallyn" <serge@hallyn.com>
Subject: [PATCH 10/13] selinux: Cleanup printk logging in netport
Date:   Tue, 12 Jun 2018 10:09:09 +0200
Message-ID: <20180612080912.7827-11-peter.enderborg@sony.com>
X-Mailer: git-send-email 2.15.1
In-Reply-To: <20180612080912.7827-1-peter.enderborg@sony.com>
References: <20180612080912.7827-1-peter.enderborg@sony.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replace printk with pr_* to avoid checkpatch warnings.

Signed-off-by: Peter Enderborg <peter.enderborg@sony.com>
---
 security/selinux/netport.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/security/selinux/netport.c b/security/selinux/netport.c
index 9ed4c5064a5e..7a141cadbffc 100644
--- a/security/selinux/netport.c
+++ b/security/selinux/netport.c
@@ -173,9 +173,8 @@ static int sel_netport_sid_slow(u8 protocol, u16 pnum, u32 *sid)
 out:
 	spin_unlock_bh(&sel_netport_lock);
 	if (unlikely(ret)) {
-		printk(KERN_WARNING
-		       "SELinux: failure in sel_netport_sid_slow(),"
-		       " unable to determine network port label\n");
+		pr_warn("SELinux: failure in %s(), unable to determine network port label\n",
+			__func__);
 		kfree(new);
 	}
 	return ret;
-- 
2.15.1

