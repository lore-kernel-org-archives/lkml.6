Return-Path: <SRS0=71UW=JV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 441E1C3279B
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 02:12:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C8B4524024
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 02:12:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linuxvaults.com header.i=@linuxvaults.com header.b="BZ2QU6tO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C8B4524024
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxvaults.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753069AbeGECMh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Jul 2018 22:12:37 -0400
Received: from crystal.urlnameserver.com ([99.198.127.110]:36478 "EHLO
        crystal.urlnameserver.com" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1752970AbeGECMg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jul 2018 22:12:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=linuxvaults.com; s=default; h=Message-Id:Date:Subject:Cc:To:From:Sender:
        Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=vEMt/ajJj9Mw7Blxco2HsorHtWHCh/Y6Mi7aBUkJgGw=; b=BZ2QU6tOVo1PWVCGR444DpphJf
        D0LsRjJ6eSlyYBIlxdV5nKQgUwoKAaxplpVybCqKza04GCtFxCWDH9r/10DhP6tdJbJgcIES/jTtt
        xmjSfBXvEFOYszRKCJCe6x3zdaeIwkxL9dCyhctxRBdD5thr6noLwtlwyGCpffhXpDxknDzAe0mK9
        y42lzKUIlOIh0llkhclbE7jz6WLAjqzvNIAMrTVzWlVRlaRcNKGAIAf7x2OUCoK3CScu3ygpUZEyn
        zI8ylxmFFjmaQnPF96ZWUTpeKYijO3vETBw5p/H1S9I6UKmhuAMZkiEFxVg0EetZ3IxrcNX9zZTx2
        5yrPmGMQ==;
Received: from [206.189.122.65] (port=34270 helo=kernel.local.domain)
        by crystal.urlnameserver.com with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.91)
        (envelope-from <tsuliman@linuxvaults.com>)
        id 1fatkx-0000xu-Un; Wed, 04 Jul 2018 21:12:28 -0500
From:   Tamir Suliman <tsuliman@linuxvaults.com>
To:     w.d.hubbs@gmail.com, speakup@linux-speakup.org,
        gregkh@linuxfoundation.org
Cc:     dhowells@redhat.com, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, chris@the-brannons.com,
        tsuliman@linuxvaults.com
Subject: [PATCH 3/3] drivers/speakup: kobjects : Fixed Coding issues -Debugging
Date:   Thu,  5 Jul 2018 02:12:20 +0000
Message-Id: <1530756740-14168-1-git-send-email-tsuliman@linuxvaults.com>
X-Mailer: git-send-email 1.8.3.1
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - crystal.urlnameserver.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - linuxvaults.com
X-Get-Message-Sender-Via: crystal.urlnameserver.com: authenticated_id: tsuliman@linuxvaults.com
X-Authenticated-Sender: crystal.urlnameserver.com: tsuliman@linuxvaults.com
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Updated printk() of i18n messages to include KERN_INFO facility level to improve debuggin.
then later noticed that I forgot to add a space on printk.

Signed-off-by: Tamir Suliman <tsuliman@linuxvaults.com>
---
 drivers/staging/speakup/kobjects.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/speakup/kobjects.c b/drivers/staging/speakup/kobjects.c
index 7e79f99..af664f0 100644
--- a/drivers/staging/speakup/kobjects.c
+++ b/drivers/staging/speakup/kobjects.c
@@ -740,7 +740,7 @@ static void report_msg_status(int reset, int received, int used,
 			snprintf(buf + (len - 1), sizeof(buf) - (len - 1),
 				 " with %d reject%s\n",
 				 rejected, rejected > 1 ? "s" : "");
-		printk(KERN_INFO "i18n messages rejected\n",buf);
+		printk(KERN_INFO "i18n messages rejected\n", buf);
 	}
 }
 
-- 
1.8.3.1

