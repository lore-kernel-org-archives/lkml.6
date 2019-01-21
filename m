Return-Path: <SRS0=RWde=P5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E56CDC2F3A0
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 13:50:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B406320879
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 13:50:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548078605;
	bh=a5V9Dr2nptFkv25pBxO7XCQflxPndvHw+4qU2EaC9vw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=qZA6eIwLVBwGMEzbZQ6GnzKBkduikFDxDAxGgeSpcv4sgUTQLta6Fk173yp/8zYXj
	 /Jq+ZTMpe6bliENxRlkTH4wlOIBRXyjawpzJrBd23LCUEY17bLYzPZgxO+lJuLGuiP
	 VEqllKEDNkadh+GHFt9KmfelPT/hkB3MR+sQZPvw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730457AbfAUNuD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Jan 2019 08:50:03 -0500
Received: from mail.kernel.org ([198.145.29.99]:60770 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730429AbfAUNuA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jan 2019 08:50:00 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D45FE20861;
        Mon, 21 Jan 2019 13:49:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548078599;
        bh=a5V9Dr2nptFkv25pBxO7XCQflxPndvHw+4qU2EaC9vw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=0+SfbgYptt1DjJVBQgznYRbrE5SbyOmy+f8WEIRM1PKYiQmnWJfG+5MTk/1+nu908
         ibDwrZv2bkTxp8SdadYtj/BqCE7mQz2HGldAn7zmsoLtnJRHgBfvcUM/xju4I/WuWF
         yD39wSH5Jsv0RFi8f7QgYzdZ28aKh9YdqzK1H5jI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Aurelien Jarno <aurelien@aurel32.net>,
        Paul Burton <paul.burton@mips.com>, linux-mips@vger.kernel.org,
        Dengcheng Zhu <dzhu@wavecomp.com>, ralf@linux-mips.org
Subject: [PATCH 4.20 051/111] MIPS: OCTEON: fix kexec support
Date:   Mon, 21 Jan 2019 14:42:45 +0100
Message-Id: <20190121122501.551202614@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190121122455.819406896@linuxfoundation.org>
References: <20190121122455.819406896@linuxfoundation.org>
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

4.20-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Aurelien Jarno <aurelien@aurel32.net>

commit 8a644c64a9f1aefb99fdc4413e6b7fee17809e38 upstream.

Commit 62cac480f33f ("MIPS: kexec: Make a framework for both jumping and
halting on nonboot CPUs") broke the build of the OCTEON platform as
the relocated_kexec_smp_wait() is now static and not longer exported in
kexec.h.

Replace it by kexec_reboot() like it has been done in other places.

Fixes: 62cac480f33f ("MIPS: kexec: Make a framework for both jumping and halting on nonboot CPUs")
Signed-off-by: Aurelien Jarno <aurelien@aurel32.net>
Signed-off-by: Paul Burton <paul.burton@mips.com>
Cc: linux-mips@vger.kernel.org
Cc: Dengcheng Zhu <dzhu@wavecomp.com>
Cc: ralf@linux-mips.org
Cc: stable@vger.kernel.org # 4.20+
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/mips/cavium-octeon/setup.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/arch/mips/cavium-octeon/setup.c
+++ b/arch/mips/cavium-octeon/setup.c
@@ -96,7 +96,7 @@ static void octeon_kexec_smp_down(void *
 	"	sync						\n"
 	"	synci	($0)					\n");
 
-	relocated_kexec_smp_wait(NULL);
+	kexec_reboot();
 }
 #endif
 


