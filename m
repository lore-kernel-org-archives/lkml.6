Return-Path: <SRS0=OLKc=O6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFAD8C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 08:33:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9D78E218FD
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 08:33:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="ecwg+YWN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387818AbeLUId3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Dec 2018 03:33:29 -0500
Received: from conuserg-12.nifty.com ([210.131.2.79]:38268 "EHLO
        conuserg-12.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387773AbeLUId2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Dec 2018 03:33:28 -0500
Received: from pug.e01.socionext.com (p14092-ipngnfx01kyoto.kyoto.ocn.ne.jp [153.142.97.92]) (authenticated)
        by conuserg-12.nifty.com with ESMTP id wBL8XAIB008714;
        Fri, 21 Dec 2018 17:33:12 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-12.nifty.com wBL8XAIB008714
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1545381193;
        bh=g7sZEau6L6Ouy/B1r4t010I0LvMXXxn2pV3G1cEPXIg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ecwg+YWNTBIREoqhB8KuLcsbcjMpTOnRu1uuZf/wBfHKU9BuCbOydjg0ccaC6PbjF
         8lT31Wzyh9ZZRbLt6CTv4meoz3ccH6CgNBLBO0E1IHIRgtEAYjOg+nVMlND65SyAeD
         3TTE6YwomrBrxPCJ23Q8WcIAOXzQpgKI+ODnnOxsPogJEUkcHH5Xoy1VhlJKkpR/nX
         WHIF6n9Kpbi0eFkyOxWgs94xJy6TZVHryMCBnA+0teYW/nN8xyt6EnDnvr2mxWGoV6
         3LqDy1YIss2b8gNZUJsJlsO6oCvSdr2BnBX4igzlIWik6ZRcsqerFZQYWoJBjCe+Aw
         ltJr/5PsGtE4Q==
X-Nifty-SrcIP: [153.142.97.92]
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
To:     linux-kbuild@vger.kernel.org
Cc:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 5/5] kconfig: surround dbg_sym_flags with #ifdef DEBUG to fix gconf warning
Date:   Fri, 21 Dec 2018 17:33:08 +0900
Message-Id: <1545381188-514-5-git-send-email-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1545381188-514-1-git-send-email-yamada.masahiro@socionext.com>
References: <1545381188-514-1-git-send-email-yamada.masahiro@socionext.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix the following warning:

  no previous prototype for ‘dbg_sym_flags’ [-Wmissing-prototypes]

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 scripts/kconfig/gconf.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/scripts/kconfig/gconf.c b/scripts/kconfig/gconf.c
index b3d438c..5d4ecf3 100644
--- a/scripts/kconfig/gconf.c
+++ b/scripts/kconfig/gconf.c
@@ -75,7 +75,7 @@ static gchar **fill_row(struct menu *menu);
 static void conf_changed(void);
 
 /* Helping/Debugging Functions */
-
+#ifdef DEBUG
 static const char *dbg_sym_flags(int val)
 {
 	static char buf[256];
@@ -105,6 +105,7 @@ static const char *dbg_sym_flags(int val)
 
 	return buf;
 }
+#endif
 
 static void replace_button_icon(GladeXML *xml, GdkDrawable *window,
 				GtkStyle *style, gchar *btn_name, gchar **xpm)
-- 
2.7.4

