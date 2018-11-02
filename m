Return-Path: <SRS0=zRJA=NN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 288A9C32789
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 11:41:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D56E62082E
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 11:41:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="NMF1q5mG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D56E62082E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726687AbeKBUs2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Nov 2018 16:48:28 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:35835 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726021AbeKBUs2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Nov 2018 16:48:28 -0400
Received: by mail-lf1-f68.google.com with SMTP id d7-v6so1134014lfi.2
        for <linux-kernel@vger.kernel.org>; Fri, 02 Nov 2018 04:41:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=Mj2QZxUx6dVHSn2ZCozI/Vd9NNqleLHIpi3vz3MvkLE=;
        b=NMF1q5mGzw/98bEjtQILZ5uky78p9bTsaHK7klILVQ2s+wV4x0D7In1RNDQTJd/o1f
         iuaL4CEdJaiVWbAc09r/jZub31Ev0pR6QauLktPLenv61KCydYRC1R/ci4Lekzit+eN8
         rQT/KhXjsPCOXwQPmlr+Jng1MoTyuDPUur2yg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=Mj2QZxUx6dVHSn2ZCozI/Vd9NNqleLHIpi3vz3MvkLE=;
        b=dTbi/Rl5IbW3KUT16ummAWOHR6tyCB2NlHtv8n/r/brR5+wOGQlNOHWKYSoZ3fU7Kg
         KBD4ofWKN/5WZ4wfy7Q6jQ2jPg8PBHQUwsmU7M3sGGKU0dkZk3WGeCdMV2s8tf0e1zip
         uYlO8ArKUFtDXryQ1SqHP+NOyBYw7ckBgtNYXp2caM9TxNiWK12CwBfaIh7d4ptJ1LD9
         kLtkhyfObnXyTdlNAqOPUbFu5NQfqpoEHEKzLBgKreuQa+Tj9TIXkmo5mK2+z56YzJko
         Na1XF252RFKGxF0AUK0JqZw1Cr9PapSXfxd3bPpZLLEJdl3KA746QQe88/qQ+IL2EQwO
         Hq5w==
X-Gm-Message-State: AGRZ1gKBsY2iHvKyzKxKRuQopeBVtyaqoFSBAoXPt/j9BGmaE0IlHHGq
        Rt/2Drdk3gAAObDhZwcQgonLoA==
X-Google-Smtp-Source: AJdET5cEbNjTJzF8LdoF+A2UfOO/3Dp+e3TmYNsMNlnzb7/I2HXZ9qEE14LtWzsXhGwMGg3KazBE+g==
X-Received: by 2002:a19:914b:: with SMTP id y11mr6351934lfj.98.1541158892788;
        Fri, 02 Nov 2018 04:41:32 -0700 (PDT)
Received: from localhost (c-732171d5.07-21-73746f28.bbcust.telenor.se. [213.113.33.115])
        by smtp.gmail.com with ESMTPSA id k9-v6sm630668ljk.97.2018.11.02.04.41.31
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 02 Nov 2018 04:41:32 -0700 (PDT)
From:   Anders Roxell <anders.roxell@linaro.org>
To:     yamada.masahiro@socionext.com
Cc:     linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
        dvhart@infradead.org, arnd@arndb.de,
        Anders Roxell <anders.roxell@linaro.org>
Subject: [PATCH] scripts/kconfig/merge_config: don't redefine 'y' to 'm'
Date:   Fri,  2 Nov 2018 12:41:19 +0100
Message-Id: <20181102114119.23859-1-anders.roxell@linaro.org>
X-Mailer: git-send-email 2.11.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In today's merge_config.sh the order of the config fragment files dictates
the output of a config option. With this approach we will get different
.config files depending on the order of the config fragment files.
Adding a switch to add precedence for builtin over modules, this will
make the .config file the same

Suggested-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
---
 scripts/kconfig/merge_config.sh | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/scripts/kconfig/merge_config.sh b/scripts/kconfig/merge_config.sh
index da66e7742282..902a60b45614 100755
--- a/scripts/kconfig/merge_config.sh
+++ b/scripts/kconfig/merge_config.sh
@@ -32,6 +32,7 @@ usage() {
 	echo "  -m    only merge the fragments, do not execute the make command"
 	echo "  -n    use allnoconfig instead of alldefconfig"
 	echo "  -r    list redundant entries when merging fragments"
+	echo "  -y    make builtin have precedence over modules"
 	echo "  -O    dir to put generated output files.  Consider setting \$KCONFIG_CONFIG instead."
 	echo
 	echo "Used prefix: '$CONFIG_PREFIX'. You can redefine it with \$CONFIG_ environment variable."
@@ -40,6 +41,7 @@ usage() {
 RUNMAKE=true
 ALLTARGET=alldefconfig
 WARNREDUN=false
+BUILTIN=false
 OUTPUT=.
 CONFIG_PREFIX=${CONFIG_-CONFIG_}
 
@@ -64,6 +66,11 @@ while true; do
 		shift
 		continue
 		;;
+	"-y")
+		BUILTIN=true
+		shift
+		continue
+		;;
 	"-O")
 		if [ -d $2 ];then
 			OUTPUT=$(echo $2 | sed 's/\/*$//')
@@ -122,7 +129,13 @@ for MERGE_FILE in $MERGE_LIST ; do
 		grep -q -w $CFG $TMP_FILE || continue
 		PREV_VAL=$(grep -w $CFG $TMP_FILE)
 		NEW_VAL=$(grep -w $CFG $MERGE_FILE)
-		if [ "x$PREV_VAL" != "x$NEW_VAL" ] ; then
+		if test "$BUILTIN" = "true" && echo $PREV_VAL |grep -Eq '^\w+=y' && echo $NEW_VAL |grep -Eq '^\w+=m' ; then
+			echo Value of $CFG is \'y\' and we don\'t want to redefine the fragment $MERGE_FILE:
+			echo Previous  value: $PREV_VAL
+			echo New value:       $NEW_VAL
+			echo Will use previous value.
+			echo
+		elif [ "x$PREV_VAL" != "x$NEW_VAL" ] ; then
 			echo Value of $CFG is redefined by fragment $MERGE_FILE:
 			echo Previous  value: $PREV_VAL
 			echo New value:       $NEW_VAL
-- 
2.11.0

