Return-Path: <SRS0=ekB2=LK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FA39C433F5
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 02:34:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CE70A20645
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 02:34:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pi9hmmsZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CE70A20645
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727142AbeH0GTI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Aug 2018 02:19:08 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:36717 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726822AbeH0GTI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Aug 2018 02:19:08 -0400
Received: by mail-pg1-f194.google.com with SMTP id d1-v6so280728pgo.3
        for <linux-kernel@vger.kernel.org>; Sun, 26 Aug 2018 19:34:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=69aq2774xmLGSuL+Xi9eBTIF522CDJnQzUDYx4EDrdg=;
        b=pi9hmmsZN1jZtXpKuuMfu7WFgjxSFR7o64F3ff/Qn9Q+9mDGPWfG0eFOzl1rQkep09
         PkYTz7jCS2UR8nYWBv/nFUVKO/JHDTtRrnYrVryI1MS2K9Vjq3v0han+BTEAXoD1rxpO
         gFW+tx7hux0PU0ohC3YXtmj7J/qebqFE5VMjfAZO8kBpu8xeivwyEOU2th5hGTDw8PjP
         oD5D3jtYfjI3sDW5cnhTD6tIfjAsE4X3fb9rC4AA0whYkKaNiGlJ+RJcOBv/qaQOitZa
         Vv/3D6s34zOL43TznP7WBPl+CTwm2N5tt8EjMXFzo4+mAvHWKgERAxlyAmmjv8WHGcRM
         9Y/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=69aq2774xmLGSuL+Xi9eBTIF522CDJnQzUDYx4EDrdg=;
        b=ZUDDvMGvFYLA/sRiiSojuHF1b6XHYhgYLaNvW5YSrTAIx0vxjTv9PJc2EZC79gQ750
         VSmu7XdLqtnkVtCtuLOfljY9TGrpuZg+PK15BSyVD+6rzlCLXL+dh6EQkhaL/aZSxeK7
         x5X7l42XFUeyk+Bv518E52hyH+40ctNPoADwB52/ng5KCCCBRB2lsB72Uq9B7vjI5KNQ
         0Kc2snkrI1yFw73eqAcvrot5FFtEE9RBAbJ6ycybJ36vzrVqOfJb/rDLcFqH69GAWtiT
         VkRgzJia4GyfgIR7//UGRFKCK/Z+Dgt1wy2FRTNelgBKta7mp+wPw7WkYkbOtnC1Zbcd
         P0tw==
X-Gm-Message-State: APzg51DSl61sfbzscq+wIi3bjwpeSg5bmFysEKnLp7/IR7e2EvVfPCTq
        1XLdoSNl8zf7PS24OLKr0B0=
X-Google-Smtp-Source: ANB0VdaFbVNrnbdzkm3lcQw5WaehLw/91m4U0nLwq7o9v5G5SBpG2Z3tzkQnXo2X6wiEt+6ujUg9qg==
X-Received: by 2002:a63:7e1c:: with SMTP id z28-v6mr10286313pgc.246.1535337273738;
        Sun, 26 Aug 2018 19:34:33 -0700 (PDT)
Received: from localhost (45.62.100.246.16clouds.com. [45.62.100.246])
        by smtp.gmail.com with ESMTPSA id z5-v6sm18117949pfh.83.2018.08.26.19.34.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 26 Aug 2018 19:34:33 -0700 (PDT)
From:   Lei YU <mine260309@gmail.com>
To:     Philippe Ombredanne <pombredanne@nexb.com>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Laura Abbott <labbott@redhat.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Lei YU <mine260309@gmail.com>, linux-kernel@vger.kernel.org,
        Joel Stanley <joel@jms.id.au>
Subject: [PATCH] perf: Fix clean error
Date:   Mon, 27 Aug 2018 10:34:26 +0800
Message-Id: <1535337266-114190-1-git-send-email-mine260309@gmail.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When make perf with -O, it gets error when make clean with below log:

 $ make -C tools/perf O=<output/dir> # OK
 $ make -C tools/perf O=<output/dir>
    find: cannot delete ‘<output/dir>/builtin-script.o’: No such file or directory
    find: cannot delete ‘<output/dir>/.subcmd-config.o.cmd’: No such file or directory
    ...
    Makefile:38: recipe for target 'clean' failed
    make[2]: *** [clean] Error 1
    make[1]: *** [fixdep-clean] Error 2
    Makefile:90: recipe for target 'clean' failed
    make: *** [clean] Error 2

It happens because both fixdep-clean and libsubcmd-clean will delete
files by `find`, where libsubcmd-clean uses `| xargs $(RM)` and
fixdep-clean uses `-delete`.
When a file is find by fixdep-clean, and tries to delete it, it's found
that the file does not exist because it is deleted by libsubcmd-clean.

This commit changes the delete method of fixdep-clean to use
`| xargs $(RM)` as well, where RM is defined as `rm -f` so it does not
return error when file does not exist.

Signed-off-by: Lei YU <mine260309@gmail.com>
---
 tools/build/Makefile | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tools/build/Makefile b/tools/build/Makefile
index 5edf65e..ae38db2 100644
--- a/tools/build/Makefile
+++ b/tools/build/Makefile
@@ -18,6 +18,7 @@ $(call allow-override,LD,$(CROSS_COMPILE)ld)
 HOSTCC ?= gcc
 HOSTLD ?= ld
 HOSTAR ?= ar
+RM = rm -f
 
 export HOSTCC HOSTLD HOSTAR
 
@@ -36,7 +37,7 @@ all: $(OUTPUT)fixdep
 
 clean:
 	$(call QUIET_CLEAN, fixdep)
-	$(Q)find $(if $(OUTPUT),$(OUTPUT),.) -name '*.o' -delete -o -name '\.*.cmd' -delete -o -name '\.*.d' -delete
+	$(Q)find $(if $(OUTPUT),$(OUTPUT),.) -name '*.o' -o -name '\.*.cmd' -o -name '\.*.d' | xargs $(RM)
 	$(Q)rm -f $(OUTPUT)fixdep
 
 $(OUTPUT)fixdep-in.o: FORCE
-- 
2.7.4

