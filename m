Return-Path: <SRS0=BZo9=L2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E9C4C46469
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 04:53:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 262ED20839
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 04:53:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="urfNV2vT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 262ED20839
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726552AbeILJ4I (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Sep 2018 05:56:08 -0400
Received: from conuserg-11.nifty.com ([210.131.2.78]:60899 "EHLO
        conuserg-11.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725881AbeILJ4I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Sep 2018 05:56:08 -0400
Received: from pug.e01.socionext.com (p14092-ipngnfx01kyoto.kyoto.ocn.ne.jp [153.142.97.92]) (authenticated)
        by conuserg-11.nifty.com with ESMTP id w8C4r2en011858;
        Wed, 12 Sep 2018 13:53:02 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-11.nifty.com w8C4r2en011858
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1536727982;
        bh=X5Jas35lxuOzbGHHP0Twc1Ro553VoEQ5e1JfjRNfHmY=;
        h=From:To:Cc:Subject:Date:From;
        b=urfNV2vTOwEmvOVsdLO+G0eW+E5BC2vAHQLt9BcrZ6EmlMQ7ndDeAvP/nhjUpOhYT
         T6ui+NDMwcdRQfQdpFagf/IAggDKvptnB0RNGF3WOkwYDxrVXvxwFJ8+YmcqK7tS3L
         w+nP2k1a/dqYp9l97pei3yNkaldBWoWqfQIf0TAOKtDSeYPGGyoW7nN3UBaqKPVeFG
         UC6cfjdYAoeXTxTdp2CQ+BVi8T6miq+23v9hVeDEYlP2PyAL5Md0LlZLjomeDoG3Q6
         qo0phSi/BgHPF5FzqxkqzhOYwW1++eyVeo1cNpWkahBgJncHZ/7Wm5CBiRQPzgUq7D
         shu8Pu8/RGwFQ==
X-Nifty-SrcIP: [153.142.97.92]
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
To:     linux-kbuild@vger.kernel.org
Cc:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        Michal Marek <michal.lkml@markovi.net>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] kbuild: prefix Makefile.dtbinst path with $(srctree) unconditionally
Date:   Wed, 12 Sep 2018 13:52:54 +0900
Message-Id: <1536727974-28211-1-git-send-email-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

$(srctree) always points to the top of the source tree whether
KBUILD_SRC is set or not.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 scripts/Kbuild.include | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/Kbuild.include b/scripts/Kbuild.include
index ce53639..46cc43e 100644
--- a/scripts/Kbuild.include
+++ b/scripts/Kbuild.include
@@ -193,7 +193,7 @@ modbuiltin := -f $(srctree)/scripts/Makefile.modbuiltin obj
 # Shorthand for $(Q)$(MAKE) -f scripts/Makefile.dtbinst obj=
 # Usage:
 # $(Q)$(MAKE) $(dtbinst)=dir
-dtbinst := -f $(if $(KBUILD_SRC),$(srctree)/)scripts/Makefile.dtbinst obj
+dtbinst := -f $(srctree)/scripts/Makefile.dtbinst obj
 
 ###
 # Shorthand for $(Q)$(MAKE) -f scripts/Makefile.clean obj=
-- 
2.7.4

