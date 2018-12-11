Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7A64C5CFFE
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 15:45:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8C2FB208E7
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 15:45:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544543131;
	bh=f59Bi/JyA/iX+gguN+6ObBgTUs4K94xWT5y50aixXU4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=IOGPcBlsa8hYqFKI9Z4fQCTsxGbsLBnyIp2C/AUc/mG1iSG6Wz6wXHHB18gc46e3n
	 LCcs0MO17cRKO8J5zNUiP/aIK16wjMTcKXuTj2uGc+l5e8Qx0WYo9o4xDZ3BU7XcVh
	 uOQHW7kTwiqk1JK4AIOlVw6luZz4Bi9aQBgZck2M=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8C2FB208E7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727600AbeLKPpa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 10:45:30 -0500
Received: from mail.kernel.org ([198.145.29.99]:33868 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728092AbeLKPp1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 10:45:27 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 87F76208E7;
        Tue, 11 Dec 2018 15:45:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544543127;
        bh=f59Bi/JyA/iX+gguN+6ObBgTUs4K94xWT5y50aixXU4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=mvxb/iWmkRODMoXVhYOGoJNUoZBHIjATt4QquNChRyHIAvMUr+jifTGG57ydpLNRa
         YH6dY+4SgylC1bFfc7jZYzxwmi4Q9RTF3tF9hLGxfVGV6R9VzGmUhIA9cubR3bEW26
         rWYMLtWThepzpi6aHJ7YJoz4c1FgZiNku2NbBrls=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Stephen Rothwell <sfr@canb.auug.org.au>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: [PATCH 4.4 23/91] disable stringop truncation warnings for now
Date:   Tue, 11 Dec 2018 16:40:42 +0100
Message-Id: <20181211151607.656099472@linuxfoundation.org>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20181211151606.026852373@linuxfoundation.org>
References: <20181211151606.026852373@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Stephen Rothwell <sfr@canb.auug.org.au>

commit 217c3e0196758662aa0429863b09d1c13da1c5d6 upstream.

They are too noisy

Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 Makefile |    3 +++
 1 file changed, 3 insertions(+)

--- a/Makefile
+++ b/Makefile
@@ -793,6 +793,9 @@ KBUILD_CFLAGS += $(call cc-option,-Wdecl
 # disable pointer signed / unsigned warnings in gcc 4.0
 KBUILD_CFLAGS += $(call cc-disable-warning, pointer-sign)
 
+# disable stringop warnings in gcc 8+
+KBUILD_CFLAGS += $(call cc-disable-warning, stringop-truncation)
+
 # disable invalid "can't wrap" optimizations for signed / pointers
 KBUILD_CFLAGS	+= $(call cc-option,-fno-strict-overflow)
 


