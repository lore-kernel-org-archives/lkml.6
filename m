Return-Path: <SRS0=OLKc=O6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63DCCC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 03:13:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DB6E9218FE
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 03:12:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="CsBEesqd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389063AbeLUDM7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Dec 2018 22:12:59 -0500
Received: from conuserg-12.nifty.com ([210.131.2.79]:53264 "EHLO
        conuserg-12.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388689AbeLUDM6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Dec 2018 22:12:58 -0500
Received: from pug.e01.socionext.com (p14092-ipngnfx01kyoto.kyoto.ocn.ne.jp [153.142.97.92]) (authenticated)
        by conuserg-12.nifty.com with ESMTP id wBL3Ci1o003819;
        Fri, 21 Dec 2018 12:12:44 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-12.nifty.com wBL3Ci1o003819
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1545361964;
        bh=uwc4h7OaYnqTtMRVaURUeVDBjbGaCXyizVdHE15ae9w=;
        h=From:To:Cc:Subject:Date:From;
        b=CsBEesqdpFekSo+Xj8X1sNVps9vZvdQXIjGppBx/mJ58EWAa3UWQpWvIKEqi/KOp4
         6jCqTtOyWgbVivuW/df/R0+hU/hvYGEKOPSSpPdj7ryGaNXpfroA/nYnsEbQ7IunVe
         9NdgmsPbQKYBOMmRimkSicmlranskbalqTfiMzkMdkmaRYH8GK911uOXSIyl0ie9mG
         nrpWtUcej4qwd+ydx+8jfoLoMnLxIIQoGCNeGteKUb7COhgbIvN2MrIxgh8eN662W+
         yQoCxHEkE/22HVEuujax2guA1/FhMAxNJgDvvufXRkne02AVkIjHVbYkB5Abx0jNOI
         tAIdcL4MC2LzA==
X-Nifty-SrcIP: [153.142.97.92]
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
To:     linux-kbuild@vger.kernel.org
Cc:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/3] scripts: remove unnecessary ihex2fw and check-lc_ctypes from .gitignore
Date:   Fri, 21 Dec 2018 12:12:39 +0900
Message-Id: <1545361961-31990-1-git-send-email-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit c512d2544c68 ("gitignore: ignore scripts/ihex2fw") was unneeded
because ihex2fw was generated in firmware/ instead of scripts/ at
that time. I guess it was accidentally added because ihex2fw.c was
pushed back and forth between those two directories according to
8b249b6856f1 ("fix modules_install via NFS") and 556b0f58bbcd (Revert
"fix modules_install via NFS"). Of course, you may cross file-moves
during git-bisect, but we do not generally add removed binaries to
the .gitignore file.

check-lc_ctype was removed by commit cb43fb5775df ("docs: remove
DocBook from the building system").

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 scripts/.gitignore | 2 --
 1 file changed, 2 deletions(-)

diff --git a/scripts/.gitignore b/scripts/.gitignore
index 12d302d..17f8cef 100644
--- a/scripts/.gitignore
+++ b/scripts/.gitignore
@@ -6,9 +6,7 @@ conmakehash
 kallsyms
 pnmtologo
 unifdef
-ihex2fw
 recordmcount
-check-lc_ctype
 sortextable
 asn1_compiler
 extract-cert
-- 
2.7.4

