Return-Path: <SRS0=v2je=OV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6676DC65BAF
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 13:12:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2B81320839
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 13:12:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RuLhWzL2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2B81320839
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727539AbeLLNMS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Dec 2018 08:12:18 -0500
Received: from mail-ed1-f51.google.com ([209.85.208.51]:43715 "EHLO
        mail-ed1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727290AbeLLNMP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Dec 2018 08:12:15 -0500
Received: by mail-ed1-f51.google.com with SMTP id f9so15493511eds.10
        for <linux-kernel@vger.kernel.org>; Wed, 12 Dec 2018 05:12:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=qpZYTD9IxZqXqawa9zYWCHH0n0VHFjdJyXrqWGPFs0A=;
        b=RuLhWzL2a2H9DbggwMJhHNVSY9/GFtMgrQ4BTk4nYUP9lPe28jtbHn97uRDMytCiS5
         3WPf0mp4Tw4hsH7W5nZEyVF2X2PE/EvA1JetAlDzTMgGC7lxmm+3XZ/bkyAXUdxhrlpr
         InLJ07psc1lsqwZxlMdYwepMnrmkfSuRq9Fu7gNRpgHFdCK1sV1JNPcl2k5RPifc+eyg
         MAi5zQj7EJRpZmepn2+Bn85QOuLfsOH/X8Ww8q6SWTTFz2ltkjhRhb+ACpwC9njGrvX2
         keTpf0x2p5ANMYCLRaUg8aUwoF6UxAR2mcZ1YL7vuXa9GfbFLRCFSOq2DS/lynQ+O5dM
         barg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qpZYTD9IxZqXqawa9zYWCHH0n0VHFjdJyXrqWGPFs0A=;
        b=Y5OV9Gxqixm+W+dY7GhhgkjRXZkluf2z91bMxalDvE97vYchf8Z0fGKa75lxEYiS2T
         yD9urXfR7yDB15N7Tdo+2VfY3fxKMLSveXEPrs/vjoZfqpIdjbb4GKxGAC396O6xiUNY
         RZ4MbJ0MMAE7q6+7641uRkiyQ9lE8sVc/jYo4j1OwnrIvh21145/PkBRukksQd4twlmb
         ZeNDnhPb9/c+SsRG8MPZG9/ZSwlx98wYtjdlDBOioeQq383/GZPEnUGFTwsmA4jc1Qlk
         ZQloPc9QhXpUNYXK6ErzYIq8lo92kUoYWhGu5oC510AQ5nq4z9EYVOgRiBABOJcLQ+A2
         As5Q==
X-Gm-Message-State: AA+aEWZ+SwpxJ2Q48gHUN1YXwtBfzJ52zrSj7o4BD1o1GII7wcczEle9
        BPrkzsbkhVUO7+ljfiRengM=
X-Google-Smtp-Source: AFSGD/VHsQoM/xRED0o2jsoFl6An8PILQi5PSs2GP3sU31+JdVPjiQ7lYBPjpx0bp7BSP7FJBHQWsw==
X-Received: by 2002:a50:8bc9:: with SMTP id n9mr19058607edn.41.1544620333511;
        Wed, 12 Dec 2018 05:12:13 -0800 (PST)
Received: from localhost (pD9E51040.dip0.t-ipconnect.de. [217.229.16.64])
        by smtp.gmail.com with ESMTPSA id x10sm4890980edb.58.2018.12.12.05.12.12
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 12 Dec 2018 05:12:13 -0800 (PST)
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jonathan Corbet <corbet@lwn.net>, Joe Perches <joe@perches.com>,
        Jeremy Cline <jcline@redhat.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] scripts: Add spdxcheck.py self test
Date:   Wed, 12 Dec 2018 14:12:10 +0100
Message-Id: <20181212131210.28024-2-thierry.reding@gmail.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181212131210.28024-1-thierry.reding@gmail.com>
References: <20181212131210.28024-1-thierry.reding@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Thierry Reding <treding@nvidia.com>

Add a script that will run spdxcheck.py through a couple of self tests
to simplify validation in the future. The tests are run for both Python
2 and Python 3 to make sure all changes to the script remain compatible
across both versions.

The script tests a regular text file (Makefile) for basic sanity checks
and then runs it on a binary file (Documentation/logo.gif) to make sure
it works in both cases. It also tests opening files passed on the
command line as well as piped files read from standard input. Finally a
run on the complete tree will be performed to catch any other potential
issues.

Signed-off-by: Thierry Reding <treding@nvidia.com>
---
 scripts/spdxcheck-test.sh | 12 ++++++++++++
 1 file changed, 12 insertions(+)
 create mode 100755 scripts/spdxcheck-test.sh

diff --git a/scripts/spdxcheck-test.sh b/scripts/spdxcheck-test.sh
new file mode 100755
index 000000000000..cfea6a0d1cc0
--- /dev/null
+++ b/scripts/spdxcheck-test.sh
@@ -0,0 +1,12 @@
+#!/bin/sh
+
+for PYTHON in python2 python3; do
+	# run check on a text and a binary file
+	for FILE in Makefile Documentation/logo.gif; do
+		$PYTHON scripts/spdxcheck.py $FILE
+		$PYTHON scripts/spdxcheck.py - < $FILE
+	done
+
+	# run check on complete tree to catch any other issues
+	$PYTHON scripts/spdxcheck.py > /dev/null
+done
-- 
2.19.1

