Return-Path: <SRS0=tq6k=PW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72751C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 20:37:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 417A420659
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 20:37:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E2N70rc7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727070AbfANUhJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Jan 2019 15:37:09 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:39990 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726788AbfANUhJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jan 2019 15:37:09 -0500
Received: by mail-wr1-f68.google.com with SMTP id p4so435621wrt.7
        for <linux-kernel@vger.kernel.org>; Mon, 14 Jan 2019 12:37:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/Gf6avfxFFWWRO/1fqEft/05aZjlhTesWsbA4oKEyYE=;
        b=E2N70rc7pW+w6myDm72wKDMCuQimvcMvaOKzh5v7aOOFxDL3gChNDI8XcTey58Ky7x
         EHp9OAH0T03vM7z6tK9P/nGC9ZFSlxH+Endi027JwjoWPnReWRCEWoIWOnyMUvn8Ye5O
         Lq4o4FOWN9croUwftJN1mv+Qvt5LZDl5sE/9iZft+tq2Vg2aN4GoPbg33dRuP4IDr7w6
         bYaNIhdebR/4GBmifzQRLBPxHYAxJze/Mq5zFsbAUAjHFqWUkVoTkWXsx7E4P6kHWtyn
         8mh1rX1ATWK/+wLunsyxpbHoJrdwYh73UzTQl1TuNIv48gd1iVidRsCr9/GyGUf0iw0L
         K6qA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=/Gf6avfxFFWWRO/1fqEft/05aZjlhTesWsbA4oKEyYE=;
        b=n8ZoJ65X1C9zwV8S1IuuYteywKA8bDpVEsO4f/dRKkWtO9ZbEuRu/CiFNXtyYyRqrG
         PKoxOWaFQ39vgi9cgWEnaSZ5kP4wmgnqvlI9Z4d0bdzixZZhxfK7CU3tFGxja3LKd4gQ
         SECM8ORABVlbqKVg5RlCtIuwe2Y/YrN0KPmMR4pT2CSZ6+nl5r5D4Wub63RpHRwYwGjm
         ydZRHyFMEzcoA8kWNV8HbHs7ILW2RWjAPtXrcVeRroSTQsXL6/xY5IVxXHnIEzp4Ctrf
         jwMFBLLtCG/vMMVqN1/znr18Vrzo+UX9C/oc74YHQVy2wV3hwgyUYPNUL1r4hO0ltLjO
         xDYQ==
X-Gm-Message-State: AJcUukedQyfzIW9sRT9gJyrGYTy6Vm0+mfYYJ7CmJ+Isv/JV54uFiEbA
        1U9s79y9r133GhFeRbmWEsc=
X-Google-Smtp-Source: ALg8bN5bu+vT0EcUYv3cwzAt1R4EzxaAedRzouvf9uG6tKbW7adGlVF72KEo54l0dFEGGyAdbe3VXw==
X-Received: by 2002:a5d:488f:: with SMTP id g15mr212420wrq.15.1547498227465;
        Mon, 14 Jan 2019 12:37:07 -0800 (PST)
Received: from macbookpro.malat.net (bru31-1-78-225-224-134.fbx.proxad.net. [78.225.224.134])
        by smtp.gmail.com with ESMTPSA id t4sm77660963wrm.6.2019.01.14.12.37.06
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 14 Jan 2019 12:37:06 -0800 (PST)
Received: by macbookpro.malat.net (Postfix, from userid 1000)
        id B3A6511422AD; Mon, 14 Jan 2019 21:37:05 +0100 (CET)
From:   Mathieu Malaterre <malat@debian.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Mathieu Malaterre <malat@debian.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] perf/core: annotate implicit fall through
Date:   Mon, 14 Jan 2019 21:37:01 +0100
Message-Id: <20190114203701.19010-1-malat@debian.org>
X-Mailer: git-send-email 2.19.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is a plan to build the kernel with -Wimplicit-fallthrough and
this place in the code produced a warning (W=1).

This commit remove the following warning:

  kernel/events/core.c:8945:11: warning: this statement may fall through [-Wimplicit-fallthrough=]

Signed-off-by: Mathieu Malaterre <malat@debian.org>
---
 kernel/events/core.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index 3cd13a30f732..11bf8bf606ee 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -8943,6 +8943,7 @@ perf_event_parse_addr_filter(struct perf_event *event, char *fstr,
 		case IF_SRC_KERNELADDR:
 		case IF_SRC_KERNEL:
 			kernel = 1;
+			/* fall through */
 
 		case IF_SRC_FILEADDR:
 		case IF_SRC_FILE:
-- 
2.19.2

