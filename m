Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3461C282CE
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 12:03:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 78B87218A6
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 12:03:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727223AbfBKMDu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 07:03:50 -0500
Received: from mout.kundenserver.de ([212.227.126.131]:43347 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726943AbfBKMDs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 07:03:48 -0500
Received: from orion.localdomain ([95.117.94.93]) by mrelayeu.kundenserver.de
 (mreue010 [212.227.15.167]) with ESMTPSA (Nemesis) id
 1MwQGj-1hBedG0p41-00sJLb; Mon, 11 Feb 2019 13:03:43 +0100
From:   "Enrico Weigelt, metux IT consult" <info@metux.net>
To:     linux-kernel@vger.kernel.org
Cc:     michal.lkml@markovi.net, yamada.masahiro@socionext.com,
        linux-kbuild@vger.kernel.org
Subject: [PATCH 2/3] scripts: mkdebian: allow renaming generated debian/rules
Date:   Mon, 11 Feb 2019 13:03:35 +0100
Message-Id: <1549886616-12609-3-git-send-email-info@metux.net>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1549886616-12609-1-git-send-email-info@metux.net>
References: <1549886616-12609-1-git-send-email-info@metux.net>
X-Provags-ID: V03:K1:cJJ9mUaUk9TP9pXPEWXQKcltpKTLqO878u2WRanr2w+4UZK2aXL
 VlRqX5HWUJto7XwjRUzJkkRCi4t/eQonKGHtkhly1QUwZqhIR5B9gU0sHXyFILcaTd7C/nL
 PHTD7iHQJYH1ZW0sKbm1RqNO9oaSM2oq2sOqSw+VBljWWrtFhwvRT/W4seqy90lW2s94h2H
 WB60kKbJHRoHVauIUAhig==
X-UI-Out-Filterresults: notjunk:1;V03:K0:th+s5/H1Xec=:dEB0pbDjwNmjqgnowzZYZW
 J8ipcY9VnKcYO+eHTjM2kMEpu4BZvjHrxXrwSdRB94z6PQUXwSx4427qj+QEYXlZvIbaqEMyO
 rwzhyi8t+CqoRwE/+htYqA0kIEc33tUPsG2RBXaqHFGR2UH6teF/mMtivcyCDGh4GMvaBpFmj
 lj2w6CcmfrGyDt2PnhHOwR/6XDLkmTprZWFZtD9/vqZnN77Ug/pwYYd/dVaQ2dM0Cr8s/IjpR
 8Cc/C6YfThclYNJJ7K1bFZpuwSizdQdyPMZnhh40JrHjll8LnMC3/ZKgUmaf69523qQjqbfXF
 Seoy6DXCkcAQA3Q3R5vMAr7Ti298pdJ0Ofqw87XbDS8B+kuf4KgAwep88HY1xV4YyAL8DzuLj
 8m/7FYpHBWmM1Q86ZDZHmFyGeMfsnpj3gtWW4uHY2Zk/YmigdD85VCn3aSCa/O2d3S1jZUrS4
 PANPhgZ6E0p8PdtSEOnaMbaud8ECW1uqr+7b8idwIicfC4F2G9ggsrTP5bJzbpDoaF7+CpHmu
 VYjH4cVq4pTROLIU59efG1dnvN3l3vReFVGMv+Sefo78mYZbjEf5WnbcXL1aR4DYRutNue+H3
 TBRUi9sNF6B6ylfwTtObycy9k0UETGpSRW/7jkfPl0oj3UUr1mGmVAL/1fTYRDiEmCg/Ozorx
 VWSggQQAXI3xY/CSAbH0AsVuc2mtJlJsfhIfubb/PotiRqHI7M7i/MtY1yW5d6QkbUIQsFXmw
 rDPFylNlBiKBQX8z+8mTZFhIHqEklqnYJ/88ow==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add new environment variable KDEB_RULES for controlling where the
generated debian rules are written to. By defaults, it's debian/rules,
but packagers might override it for providing their own rules file.

Signed-off-by: Enrico Weigelt, metux IT consult <info@metux.net>
---
 scripts/package/mkdebian | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/scripts/package/mkdebian b/scripts/package/mkdebian
index edcad61..ff226be 100755
--- a/scripts/package/mkdebian
+++ b/scripts/package/mkdebian
@@ -99,6 +99,9 @@ kernel_headers_packagename=linux-headers-$version
 dbg_packagename=$packagename-dbg
 debarch=
 set_debarch
+if [ -z "$KDEB_RULES" ]; then
+    KDEB_RULES=debian/rules
+fi
 
 if [ "$ARCH" = "um" ] ; then
 	packagename=user-mode-linux-$version
@@ -202,7 +205,7 @@ Description: Linux kernel debugging symbols for $version
  all the necessary debug symbols for the kernel and its modules.
 EOF
 
-cat <<EOF > debian/rules
+cat <<EOF > $KDEB_RULES
 #!$(command -v $MAKE) -f
 
 build:
-- 
1.9.1

