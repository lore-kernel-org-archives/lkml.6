Return-Path: <SRS0=G629=LR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7A41C43334
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 02:50:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7218B20857
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 02:50:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NHRGNaWJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7218B20857
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727620AbeICHIs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Sep 2018 03:08:48 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:42366 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725780AbeICHIr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Sep 2018 03:08:47 -0400
Received: by mail-pl1-f193.google.com with SMTP id g23-v6so7923801plq.9
        for <linux-kernel@vger.kernel.org>; Sun, 02 Sep 2018 19:50:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=JKzEOEUO2DRxfTwskQ84j7TNDFgiRDD87gcOymPsLks=;
        b=NHRGNaWJ1Q4g5YT6hkmOFsMPEO8jF28eX4LmvDo4GCuO8XUmr/VAfgpGjzqnqfAoyu
         HVsadhsQq3lvh7WSFt8yd0ZGsuqdEMut+2NggfsFN8y9dbc5cdaWWv2Hm1NhiANPm1oE
         /ejGxsYK+2mb7Tn++bB5BudQ1mEhtDAGmBtzqxmxmquIHRUOTjeyLG7RDQa987sev1Sm
         FTCeUfZ3ckzGuVb8G+cixZfolaLbhurJCyPYey8BGzpQZBgRUFsG9vGIDIx4kRUXLRF1
         WGoQjkv4f87TCXIjK/vOxjwyg4krDwRKWExMDlZEC/Vfnu5kUEwgL2kMfe7EybxljFHo
         S07w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=JKzEOEUO2DRxfTwskQ84j7TNDFgiRDD87gcOymPsLks=;
        b=DuSeOmJZ1AP/5zpttLy7ooE/9B4Mm8KY2qAf9sW22Oqc0HNIBA37S44yomRrL8eoaj
         UvPQS9zp5v2NY0vJ2HmbDbB//s0KRyTGky3hKDqUHnLmtHHEOWaadnGUA+ljtlChT5mF
         JQ7In+QgKi+T7aLwExU5aoDXvzDdMdwC4j7ny8K+XlPuRvkqci3BvX9+GVoV6AEpXEea
         8DwLmdDq+f2O6xyTpvw26nSV0ICdtaVEQATJZIpef4tZLzBF8Rzuh/9rm/WW6VX7ImpJ
         pCVgehROTuxruHCHQL05jTf5V6BVXmUtGLCJwIiAQQHejbFZOiHMj+gN7rasOLhcdRcV
         X3oQ==
X-Gm-Message-State: APzg51Aby5AF2W8xOhAadOJx4dprhkY6DZmXykKeOq/CrztiWm6IxY6h
        pR6yjqzAYLvUS8YjgVwX6aQ=
X-Google-Smtp-Source: ANB0VdbyZ2t8tiB3o+JGNn+XG2P9LD62uHE7f03N7db/N6NV7WvoPFan1ACkFqYvqh+npHxKuKiAiw==
X-Received: by 2002:a17:902:8506:: with SMTP id bj6-v6mr25915476plb.210.1535943043760;
        Sun, 02 Sep 2018 19:50:43 -0700 (PDT)
Received: from localhost (45.62.100.246.16clouds.com. [45.62.100.246])
        by smtp.gmail.com with ESMTPSA id j15-v6sm20794512pfn.52.2018.09.02.19.50.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 02 Sep 2018 19:50:42 -0700 (PDT)
From:   Lei YU <mine260309@gmail.com>
To:     Philippe Ombredanne <pombredanne@nexb.com>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Laura Abbott <labbott@redhat.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Lei YU <mine260309@gmail.com>, linux-kernel@vger.kernel.org,
        Joel Stanley <joel@jms.id.au>
Subject: [PATCH v2] perf: Fix clean error
Date:   Mon,  3 Sep 2018 10:50:28 +0800
Message-Id: <1535943028-60049-1-git-send-email-mine260309@gmail.com>
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
 $ make -C tools/perf O=<output/dir> clean # Got below error

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
v2: Fix missing "make clean" in commit message
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

