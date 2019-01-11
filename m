Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D492C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 02:52:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5268C2084C
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 02:52:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="sVtyKi36"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730084AbfAKCwH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Jan 2019 21:52:07 -0500
Received: from conuserg-07.nifty.com ([210.131.2.74]:31937 "EHLO
        conuserg-07.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728545AbfAKCwG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jan 2019 21:52:06 -0500
Received: from pug.e01.socionext.com (p14092-ipngnfx01kyoto.kyoto.ocn.ne.jp [153.142.97.92]) (authenticated)
        by conuserg-07.nifty.com with ESMTP id x0B2ppvE018284;
        Fri, 11 Jan 2019 11:51:53 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-07.nifty.com x0B2ppvE018284
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1547175113;
        bh=ZssUDTJPxhtl2sLS/pLQ+F9ODUGBpcQJANtbMV3emt8=;
        h=From:To:Cc:Subject:Date:From;
        b=sVtyKi36k53hFLXfhT16bo0ufcMZ4R4ziqwTD+XRX9nMLxkdhHSSGXsCG5G3a6vsR
         aBWMhA8XkwmaS/Vc0cQSwK7uCYu/O29onXBEQtyQdVHM8uArE2dR0DQ6EQzkrHg8X5
         KG+jo0i6BUSa6vLPgOVit7Sm1HTOQ4b1ennx2KaA+YD2iW3WYGGoIuWLYZQ1sdS4iV
         IZ667LAqTWUbeEFyNXSyWYpqaWUwc9cPZ7UP8kx6csnHjHW/xTdWxXI3V69A6Q6fsL
         Lb/SX+B+Xh3IBeU7cUxvXpLRxZKTyIKOMYhzsfXjDmNRSQgS+TCcL/0CjuL9xI6l0O
         ftujclnYx1yUQ==
X-Nifty-SrcIP: [153.142.97.92]
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
To:     linux-kbuild@vger.kernel.org
Cc:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] kconfig: clean generated *conf-cfg files
Date:   Fri, 11 Jan 2019 11:51:48 +0900
Message-Id: <1547175108-14744-1-git-send-email-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I accidentally dropped '*' in the previous renaming patch.

Revive it so that 'make mrproper' can clean the generated files.

Fixes: d86271af6460 ("kconfig: rename generated .*conf-cfg to *conf-cfg")
Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 scripts/kconfig/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/kconfig/Makefile b/scripts/kconfig/Makefile
index c05ab00..1819735 100644
--- a/scripts/kconfig/Makefile
+++ b/scripts/kconfig/Makefile
@@ -206,4 +206,4 @@ filechk_conf_cfg = $(CONFIG_SHELL) $<
 $(obj)/%conf-cfg: $(src)/%conf-cfg.sh FORCE
 	$(call filechk,conf_cfg)
 
-clean-files += conf-cfg
+clean-files += *conf-cfg
-- 
2.7.4

