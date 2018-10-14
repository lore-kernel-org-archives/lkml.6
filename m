Return-Path: <SRS0=+AQW=M2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDC61C6787C
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Oct 2018 08:18:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B6D2420835
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Oct 2018 08:18:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BBauR0Ts"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B6D2420835
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726636AbeJNP63 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 14 Oct 2018 11:58:29 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:34121 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726115AbeJNP62 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Oct 2018 11:58:28 -0400
Received: by mail-lf1-f66.google.com with SMTP id y10-v6so12008689lfj.1
        for <linux-kernel@vger.kernel.org>; Sun, 14 Oct 2018 01:18:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:subject:message-id:mime-version
         :content-transfer-encoding;
        bh=+Ss6HiKcoou9AKR/vciEPA5uaI63+jSlf1NyiMToFVA=;
        b=BBauR0TswWeQ0AP068XE36AMjuHekz2h9gkpI06UIO3TN519ln4Ch/sxFHQjpUGXsw
         I7OF1Ef6pmnzAVRvA4B5RkzLOlXo5A+LA2dhu8sETVkGtWxbOcaDYbZgtvAvbl3O9S7z
         ERt63L/LZvBRrsFhjmNEoIdd6Iazro0+AYGTVvYvLOjm6IAdxrbB/DrWa8sWnrujg6pW
         xe/OzSORIkGAXOpBXv6uhIW243gQFVwzsd0sxw4/GnNTUmBvLUjQaBKLFFiCUfKDsZEJ
         58kn1PmXUOtpHMOQb5boit01RFLd2R/fl/aU1GKfchGRHMbkqO28LFX6bX4ZtW5ocPAy
         1LmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:mime-version
         :content-transfer-encoding;
        bh=+Ss6HiKcoou9AKR/vciEPA5uaI63+jSlf1NyiMToFVA=;
        b=m6aQ/q6lwigoVJUh0FRB2Odrj8ht6Yzn4GPZrbI3npP/fQsKwCoMi73vwv6H5cvAyB
         Xf7gpBKDauvvkEQcpD+r/AkOF/YaSiCEHRPym4+j12rfdUZ+hlaw0qxL5ddmkZKgwqtK
         Z7bQtUSW6FSBaWs9kSiFs2cVTKOSQQmPmrZYz6k4bIlL+z/2k+OactgaxMa1cK4Ap+nH
         Rj1rugMPxZZGx8i3xfiD6svLcHTA9st9NXjm0pTpiPFiyk3EWe3kfWPyeEjTQxjoM2aE
         VaHR51rSOay5c00NaUFNqPbhJ81xr3jqcEMoAPockrv3YSOGzwAU3a2OvzYXBM2nbm/T
         UTwQ==
X-Gm-Message-State: ABuFfog0KcIbuTVYHWLnkYu7+R4Gra90mkHhQkRrODIPaK1yXIWHJwgT
        UlN9Sm8rtwtAN0CrQ1swGHA=
X-Google-Smtp-Source: ACcGV630AQO17GGkVw0en/FsB/LTQ7xG8WWt61JH9hnN516Jmeyx/O5ODosQlRwZpP082s0BLjcXYw==
X-Received: by 2002:a19:480c:: with SMTP id v12-v6mr7255364lfa.46.1539505094439;
        Sun, 14 Oct 2018 01:18:14 -0700 (PDT)
Received: from Tarkus ([95.165.173.36])
        by smtp.gmail.com with ESMTPSA id u66-v6sm1493484lje.38.2018.10.14.01.18.13
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 14 Oct 2018 01:18:13 -0700 (PDT)
Date:   Sun, 14 Oct 2018 11:18:03 +0300
From:   Ivan Krylov <krylov.r00t@gmail.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] perf annotate: pass filename to objdump via execl
Message-ID: <20181014111803.5d83b806@Tarkus>
X-Mailer: Claws Mail 3.14.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The symbol__disassemble() function uses shell to launch objdump and filter
its output via grep. Passing filenames by interpolating them into the
command line via "%s" may lead to problems if said filenames contain
special characters.

Instead, pass the filename as a command line argument where it is not
subject to any kind of interpretation, then use quoted shell
interpolation to build the strings we need safely.

Signed-off-by: Ivan Krylov <krylov.r00t@gmail.com>
---
 tools/perf/util/annotate.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/tools/perf/util/annotate.c b/tools/perf/util/annotate.c
index 28cd6a174..4a870181e 100644
--- a/tools/perf/util/annotate.c
+++ b/tools/perf/util/annotate.c
@@ -1696,15 +1696,14 @@ static int symbol__disassemble(struct symbol *sym, struct annotate_args *args)
 	err = asprintf(&command,
 		 "%s %s%s --start-address=0x%016" PRIx64
 		 " --stop-address=0x%016" PRIx64
-		 " -l -d %s %s -C \"%s\" 2>/dev/null|grep -v \"%s:\"|expand",
+		 " -l -d %s %s -C \"$1\" 2>/dev/null|grep -v \"$1:\"|expand",
 		 opts->objdump_path ?: "objdump",
 		 opts->disassembler_style ? "-M " : "",
 		 opts->disassembler_style ?: "",
 		 map__rip_2objdump(map, sym->start),
 		 map__rip_2objdump(map, sym->end),
 		 opts->show_asm_raw ? "" : "--no-show-raw",
-		 opts->annotate_src ? "-S" : "",
-		 symfs_filename, symfs_filename);
+		 opts->annotate_src ? "-S" : "");
 
 	if (err < 0) {
 		pr_err("Failure allocating memory for the command to run\n");
@@ -1729,7 +1728,8 @@ static int symbol__disassemble(struct symbol *sym, struct annotate_args *args)
 		close(stdout_fd[0]);
 		dup2(stdout_fd[1], 1);
 		close(stdout_fd[1]);
-		execl("/bin/sh", "sh", "-c", command, NULL);
+		execl("/bin/sh", "sh", "-c", command, "--", symfs_filename,
+		      NULL);
 		perror(command);
 		exit(-1);
 	}
-- 
2.11.0
