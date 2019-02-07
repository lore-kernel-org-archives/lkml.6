Return-Path: <SRS0=4Txr=QO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89244C282C4
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 16:41:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5C45B21928
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 16:41:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726994AbfBGQla (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Feb 2019 11:41:30 -0500
Received: from mout.kundenserver.de ([212.227.126.131]:39471 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726319AbfBGQlU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Feb 2019 11:41:20 -0500
Received: from orion.localdomain ([77.2.6.87]) by mrelayeu.kundenserver.de
 (mreue010 [212.227.15.167]) with ESMTPSA (Nemesis) id
 1MuUza-1hA04p3n4U-00rULW; Thu, 07 Feb 2019 17:41:13 +0100
From:   "Enrico Weigelt, metux IT consult" <info@metux.net>
To:     linux-kernel@vger.kernel.org
Cc:     linux-kbuild@vger.kernel.org, kernel-janitors@vger.kernel.org,
        yamada.masahiro@socionext.com, michal.lkml@markovi.net
Subject: [PATCH 2/4] scripts: mkdebian: allow renaming generated debian/rules
Date:   Thu,  7 Feb 2019 17:40:57 +0100
Message-Id: <1549557659-19137-3-git-send-email-info@metux.net>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1549557659-19137-1-git-send-email-info@metux.net>
References: <1549557659-19137-1-git-send-email-info@metux.net>
X-Provags-ID: V03:K1:gZVyorJExdgvq4+yfy3xJptj6yVCO8rrang2FIp9enttiF2MdP0
 tcGbz5GD1safIVbONoZBljE5SZiCRkrfHr/jYaE5keKsywwM+8Ya8mE8vZRTBoclBa0P4bp
 rRPH90XgRfVqsGmPB3tv0JIoU1g7B27Ggg5BFTOe6yvAzRdYyQhusoj7hjmK6fbqrXL8/Av
 ho2vsFrhg23V+yRSC5g1w==
X-UI-Out-Filterresults: notjunk:1;V03:K0:oHyUN9qFUO0=:a7ZgNNLHVevVCAYhuTGjwP
 EYU573iU8yHxYRbwv/pBF8jV5eL8z4v8/xC6xPoWSDFwHf+dIjgRCS52XQEMksnBzkSCiRylo
 +HNVUdz9qMduBHfMJkDd3KOkxmst4rq9UCFAzpyUGFOLaZP6l4VVZ1J/M/2bhF6Ynrw33v3aO
 GM1iNEnBBuJOJEBeviODuRNG4qhlYxAgL8yIno9bYzviYZ7T72QddCr7fDMdMVJy8P1U8VQ3B
 HhDj+WpDxN+jBiAkIjvdpaIcCiErhDYHgHqZIVxkGxccDEWVdU2W0VS3Wu1QU78X1hVGLYSVQ
 AmrXyyUYH67NXyWUN68SWb6wPtrcLxoQhfyOIstg254ZvuEdw48i7MKaA2GtjZ/LjP7QAJz1w
 cWrAUlOptCFcOjCi82MxfnI91PKOePWnkUR2xTElKYJIrDtJtThjMpBaj3Yw+E88cLMKSR+pn
 fXPIPK2smkSeEAtjFE/V8vufhCJASxsbTnEG+6wKAuo1in9vxy4uH2lFq5/9nZWE5Hu7s9OeX
 fmXpITLnkG4IvY5NEyYQYRcGeRcsB052iArCJOvvJdRGamG14py8JgLyjLztcqWoTBiGX7u/Z
 Yx3uEiNs6ueSTh3ifDEkz2muKsj6/Mdnve7KB+MCm0DC5QooVTq8cE8EaqWVc08Qjsu/0LHt8
 y2Yd+ztIZzO8SaFcZBSPMqm422tPhrPZbFWWBFxKSdsgXD0abe2Erk3Q5vMYAHpsaDhLIA5EX
 6nUNObsi2G7uz42roeIn8Kj9oD2oDBkytu4Qeg==
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

