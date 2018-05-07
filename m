Return-Path: <linux-arch-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-722281-1525689865-2-11863573238492059044
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-charsets: 
X-Resolved-to: linux@kroah.com
X-Delivered-to: linux@kroah.com
X-Mail-from: linux-arch-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1525689865; b=mN9NYl0jN3wPfoPIdteehQpc82JFoO7TkyRZvVpkByH2p2EgMe
    4vhNiJpaFmRB+G+GJ0FmlUAJIYdM+XJNwRm+1YTrvwnVKbdkTRt/Sy7gsA6yAOo1
    HnmbB8D1XP+3lLdR5MKDBmYjddwwUo2R26e6eLbXXbaxKAGMaVXCC4El/5W2JbvU
    oEucdHJz6x3SB8RniCh3IeKuPmMH9l1XZ7JPzJm4VZMuAjL88WE6xeJJWhK1GELY
    1brIhr6n/sTgmH4A7enZtZinApv/QECrbgDsNCVSHn2TO0BhO2DF2chdfu67R9h7
    +PJNq2Eb53tzXZ0B/PxsbVFcjRrPRqUeLOQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:sender:list-id; s=fm2; t=1525689865; bh=
    fMK3bZ8DXYttf0uxQEWi+Q/Qkeszj88c6v7MKcLrIlU=; b=bJpc9fx6AGn634L8
    CncKk3bYA8urd9lqGiT3PR8TiAy0X3TR9eEN5PSdeXx949I8BJWs27QQwYAXo2X/
    Jm4LIxO6Cupy3TH6qX6kMHLCv4Uy2LfSmLxSzO46hxo6IZULwjcEt4zbQs0vIXLO
    5DNzMAuaRt8I7KOVEzPX3G6CZumg/GjPdPBrsw9iZVocKolxJnJhBe0srH6ENa3S
    DVbppeSsc3+spAJkwDMJdrx+mEdS0HUtWyQtG0l4iXjkeRd6AbM0w1K1ILf13Wzs
    CJRXh0bFWe9D3InPPXTf5JAXt7ORlq1uKNMIrNAz6EQxZcckRK04foeARfn5yh43
    sFntDw==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=amarulasolutions.com
    header.i=@amarulasolutions.com header.b=B59gCYWQ x-bits=1024
    x-keytype=rsa x-algorithm=sha256 x-selector=google;
    dmarc=none (p=none,has-list-id=yes,d=none)
    header.from=amarulasolutions.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-arch-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net
    header.i=@1e100.net header.b=qUynUSvs;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=amarulasolutions.com header.result=pass
    header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=amarulasolutions.com
      header.i=@amarulasolutions.com header.b=B59gCYWQ x-bits=1024
      x-keytype=rsa x-algorithm=sha256 x-selector=google;
    dmarc=none (p=none,has-list-id=yes,d=none)
      header.from=amarulasolutions.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-arch-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net
      header.i=@1e100.net header.b=qUynUSvs;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=amarulasolutions.com header.result=pass
      header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfPLeQCeBe+0jjmsBHp87iz8zwyQ3P6bh4k/Ah5Wp4LO4PtN0JJ1dqclT82Xpu/fnIjDEd6OoGzghlkUrcx7hkt/KmmtvDYEaheqH4plmVh9KuJL9sr95
    lixVUzExAPg0Ikp9nt0S8WwxkEx31TalDLdY6M74BcS7k7/4TThWbXP5lNEEhEoY56nNigvqtqfP2iayXAmxmeusMAyTvjCQdjPQDQcuhWXursm8+bqN+qCX
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=VUJBJC2UJ8kA:10 a=VwQbUJbxAAAA:8
    a=iP-xVBlJAAAA:8 a=07d9gI8wAAAA:8 a=Z4Rwk6OoAAAA:8 a=B0E6lrpk_Zy5dAi6s1oA:9
    a=AjGcO6oz07-iQ99wixmX:22 a=lHLH-nfn2y1bM_0xSXwp:22 a=e2CUPOnPG4QKp8I52DXD:22
    a=HkZW87K1Qel5hWWM3VKY:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752096AbeEGKoW (ORCPT <rfc822;linux@kroah.com>);
        Mon, 7 May 2018 06:44:22 -0400
Received: from mail-wr0-f194.google.com ([209.85.128.194]:38255 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752007AbeEGKoT (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 7 May 2018 06:44:19 -0400
X-Google-Smtp-Source: AB8JxZogeYrEcUnKsmeXt8zzdkFCD4xvpJZU7/iiBaO/+QNS5bJhe0vGWrRLVfFsInrxoyQSJtfe2Q==
From: Andrea Parri <andrea.parri@amarulasolutions.com>
To: Ingo Molnar <mingo@kernel.org>, Jonathan Corbet <corbet@lwn.net>
Cc: linux-doc@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        paulmck@linux.vnet.ibm.com,
        Andrea Parri <andrea.parri@amarulasolutions.com>
Subject: [RFC PATCH v3 1/6] Documentation/features: Add script that refreshes the arch support status files in place
Date: Mon,  7 May 2018 12:43:38 +0200
Message-Id: <1525689823-3340-2-git-send-email-andrea.parri@amarulasolutions.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1525689823-3340-1-git-send-email-andrea.parri@amarulasolutions.com>
References: <1525689823-3340-1-git-send-email-andrea.parri@amarulasolutions.com>
Sender: linux-arch-owner@vger.kernel.org
X-Mailing-List: linux-arch@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Provides the script:

	Documentation/features/scripts/features-refresh.sh

which operates on the arch-support.txt files and refreshes them in place.

This way [1],

   "[...] we soft- decouple the refreshing of the entries from the
    introduction of the features, while still making it all easy to
    keep sync and to extend."

[1] http://lkml.kernel.org/r/20180328122211.GA25420@andrea

Suggested-by: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Andrea Parri <andrea.parri@amarulasolutions.com>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: Jonathan Corbet <corbet@lwn.net>
Cc: Andrew Morton <akpm@linux-foundation.org>
---
 Documentation/features/scripts/features-refresh.sh | 98 ++++++++++++++++++++++
 1 file changed, 98 insertions(+)
 create mode 100755 Documentation/features/scripts/features-refresh.sh

diff --git a/Documentation/features/scripts/features-refresh.sh b/Documentation/features/scripts/features-refresh.sh
new file mode 100755
index 0000000000000..9e72d38a0720e
--- /dev/null
+++ b/Documentation/features/scripts/features-refresh.sh
@@ -0,0 +1,98 @@
+#
+# Small script that refreshes the kernel feature support status in place.
+#
+
+for F_FILE in Documentation/features/*/*/arch-support.txt; do
+	F=$(grep "^#         Kconfig:" "$F_FILE" | cut -c26-)
+
+	#
+	# Each feature F is identified by a pair (O, K), where 'O' can
+	# be either the empty string (for 'nop') or "not" (the logical
+	# negation operator '!'); other operators are not supported.
+	#
+	O=""
+	K=$F
+	if [[ "$F" == !* ]]; then
+		O="not"
+		K=$(echo $F | sed -e 's/^!//g')
+	fi
+
+	#
+	# F := (O, K) is 'valid' iff there is a Kconfig file (for some
+	# arch) which contains K.
+	#
+	# Notice that this definition entails an 'asymmetry' between
+	# the case 'O = ""' and the case 'O = "not"'. E.g., F may be
+	# _invalid_ if:
+	#
+	# [case 'O = ""']
+	#   1) no arch provides support for F,
+	#   2) K does not exist (e.g., it was renamed/mis-typed);
+	#
+	# [case 'O = "not"']
+	#   3) all archs provide support for F,
+	#   4) as in (2).
+	#
+	# The rationale for adopting this definition (and, thus, for
+	# keeping the asymmetry) is:
+	#
+	#       We want to be able to 'detect' (2) (or (4)).
+	#
+	# (1) and (3) may further warn the developers about the fact
+	# that K can be removed.
+	#
+	F_VALID="false"
+	for ARCH_DIR in arch/*/; do
+		K_FILES=$(find $ARCH_DIR -name "Kconfig*")
+		K_GREP=$(grep "$K" $K_FILES)
+		if [ ! -z "$K_GREP" ]; then
+			F_VALID="true"
+			break
+		fi
+	done
+	if [ "$F_VALID" = "false" ]; then
+		printf "WARNING: '%s' is not a valid Kconfig\n" "$F"
+	fi
+
+	T_FILE="$F_FILE.tmp"
+	grep "^#" $F_FILE > $T_FILE
+	echo "    -----------------------" >> $T_FILE
+	echo "    |         arch |status|" >> $T_FILE
+	echo "    -----------------------" >> $T_FILE
+	for ARCH_DIR in arch/*/; do
+		ARCH=$(echo $ARCH_DIR | sed -e 's/arch//g' | sed -e 's/\///g')
+		K_FILES=$(find $ARCH_DIR -name "Kconfig*")
+		K_GREP=$(grep "$K" $K_FILES)
+		#
+		# Arch support status values for (O, K) are updated according
+		# to the following rules.
+		#
+		#   - ("", K) is 'supported by a given arch', if there is a
+		#     Kconfig file for that arch which contains K;
+		#
+		#   - ("not", K) is 'supported by a given arch', if there is
+		#     no Kconfig file for that arch which contains K;
+		#
+		#   - otherwise: preserve the previous status value (if any),
+		#                default to 'not yet supported'.
+		#
+		# Notice that, according these rules, invalid features may be
+		# updated/modified.
+		#
+		if [ "$O" = "" ] && [ ! -z "$K_GREP" ]; then
+			printf "    |%12s: |  ok  |\n" "$ARCH" >> $T_FILE
+		elif [ "$O" = "not" ] && [ -z "$K_GREP" ]; then
+			printf "    |%12s: |  ok  |\n" "$ARCH" >> $T_FILE
+		else
+			S=$(grep -v "^#" "$F_FILE" | grep " $ARCH:")
+			if [ ! -z "$S" ]; then
+				echo "$S" >> $T_FILE
+			else
+				printf "    |%12s: | TODO |\n" "$ARCH" \
+					>> $T_FILE
+			fi
+		fi
+	done
+	echo "    -----------------------" >> $T_FILE
+	mv $T_FILE $F_FILE
+done
-- 
2.7.4
