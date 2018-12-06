Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCAC8C04EB9
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 14:44:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9F65F20661
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 14:44:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544107477;
	bh=NSuiJsUwtGCFeMnv2ps1gvJjzmOxEfvvoHMMdHCUFSI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=HrezEMluTLYnwfcuYGhtzgxUNj5EYmKKu9/2S3I44X1xGSeoIZrMU14b8BL3yCQPJ
	 U5FZg81eYQ7UttI8lzMUs5uS1ETidVamSlVU/hlefSzW3XlHrCwIA4JF2P7h2ZLHPG
	 vdSKNCpAkZ9c0gkfK+uNUm22p2eVC1a2/arsFvjg=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9F65F20661
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730448AbeLFOog (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Dec 2018 09:44:36 -0500
Received: from mail.kernel.org ([198.145.29.99]:49240 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730091AbeLFOod (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Dec 2018 09:44:33 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C810620661;
        Thu,  6 Dec 2018 14:44:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544107473;
        bh=NSuiJsUwtGCFeMnv2ps1gvJjzmOxEfvvoHMMdHCUFSI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=m+IWlcIrSK1QC/Fog27/lxXUDdl3NGTbtRwIiq3H5j0uwlqnStL97rEIT5b9SJQnl
         t5XNCK0C/gwDO3oWVYg+Au08jgRFAKvadYzRiTu2wOmM0W0vlzJq4RzMoPiuBcL1pJ
         iyt1snIDUX1sk+ohib9rYr3lfBPLFEtNnGfejLZ0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Stephen Rothwell <sfr@canb.auug.org.au>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: [PATCH 4.9 002/101] disable stringop truncation warnings for now
Date:   Thu,  6 Dec 2018 15:38:01 +0100
Message-Id: <20181206143011.636731430@linuxfoundation.org>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181206143011.174892052@linuxfoundation.org>
References: <20181206143011.174892052@linuxfoundation.org>
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

4.9-stable review patch.  If anyone has any objections, please let me know.

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
@@ -802,6 +802,9 @@ KBUILD_CFLAGS += $(call cc-option,-Wdecl
 # disable pointer signed / unsigned warnings in gcc 4.0
 KBUILD_CFLAGS += $(call cc-disable-warning, pointer-sign)
 
+# disable stringop warnings in gcc 8+
+KBUILD_CFLAGS += $(call cc-disable-warning, stringop-truncation)
+
 # disable invalid "can't wrap" optimizations for signed / pointers
 KBUILD_CFLAGS	+= $(call cc-option,-fno-strict-overflow)
 


