Return-Path: <SRS0=cv1S=JM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4AB9C43144
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 20:23:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3F24C26C14
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 20:23:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ri809LYd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3F24C26C14
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933615AbeFZUXK (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Jun 2018 16:23:10 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:37479 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932349AbeFZUXI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jun 2018 16:23:08 -0400
Received: by mail-wm0-f68.google.com with SMTP id n17-v6so2607656wmh.2
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jun 2018 13:23:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=B6atpzVcN6cAQ21rvOzMrJtevWk2dVnhur/AgzTeKYc=;
        b=ri809LYdVHq9c3Qp+yYeYcivqmzyAEJkBHWQrDgsSAliMaNgAzxv3lcFbNwdjFSWZ+
         yjkzTVcbhlQ+UNoGwAkRnWGM7I0qgPCY1AVK2VwGGTPvb13K6rA31ePb4WcTjzU6b5dr
         KrzavygWLyHbgYNBR+r6N1vAqB0LdofJPCQ8LINoKg8uNdXNWtZagE6aaiC4+VvXlnKy
         bo3B/hOv/F/morWZNuZKid2jcj4V9jpWwsV4mzx9v50W5ICxxn3At1NL2FDnTfVBuKFV
         96iSuaytKSyBpJBBQxmWdEsNhzPtzaKDOEtAG8+YQkLi4d3ziKCSBNw8yaK4TsjM8p4Y
         gp5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=B6atpzVcN6cAQ21rvOzMrJtevWk2dVnhur/AgzTeKYc=;
        b=RpMjTFcz6NdoW8s6Ny+K3y7lMzivhrV/+/Puixi3VGdbExjg2nLgnSWo0oPYG9nq1N
         B/tPHGttY1Qy1fH3bzrhrzlDedFE2idFl4iQhQnS7W3lJjJWypFZRpJTY9gU4i9gNoWb
         0UeJlD0qsVAGx7Is0qD8QKq4OOuAyAfJMLrx1gw1JEp0TWrx9PCcToaKE9rpKnokqs5w
         PkPeUZT6NMH/n5zkqsIGbJPz8tUD6sKmGHRLokcqLdCkVI/EobL5otVsRRHZGhZJG+wu
         MuEc0IVd6tIaQolElxiUGItgOvoAcUrgKs+crsQO/jSODglSTe0GXTzmlJcWgOT1hxB5
         fF0g==
X-Gm-Message-State: APt69E209iDucXEd94gFauv/SHxrBGEBcQ8wsxCGHcbzUiaXooPfu2z6
        zC3y76tdgwSSgKISl1iAGJs=
X-Google-Smtp-Source: AAOMgpfVn8xb05/WLqzgVrX5QHM4LNJI/5oieGRjF4dx/kZcGH30gDxoCgkcfCEPJ2O3iQJGO/3e6A==
X-Received: by 2002:a1c:2686:: with SMTP id m128-v6mr2944544wmm.65.1530044587739;
        Tue, 26 Jun 2018 13:23:07 -0700 (PDT)
Received: from macbookpro.malat.net (bru31-1-78-225-226-121.fbx.proxad.net. [78.225.226.121])
        by smtp.gmail.com with ESMTPSA id s12-v6sm3500848wrr.43.2018.06.26.13.23.06
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 26 Jun 2018 13:23:06 -0700 (PDT)
Received: by macbookpro.malat.net (Postfix, from userid 1000)
        id C9D5310C0487; Tue, 26 Jun 2018 22:23:05 +0200 (CEST)
From:   Mathieu Malaterre <malat@debian.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Mathieu Malaterre <malat@debian.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2] perf/core: Move inline keyword at the beginning of declaration
Date:   Tue, 26 Jun 2018 22:23:00 +0200
Message-Id: <20180626202301.20270-1-malat@debian.org>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20171226140913.16640-1-malat@debian.org>
References: <20171226140913.16640-1-malat@debian.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix non-fatal warning triggered during compilation with W=1:

kernel/events/core.c:6106:1: warning: ‘inline’ is not at beginning of declaration [-Wold-style-declaration]
 static void __always_inline
 ^~~~~~

Signed-off-by: Mathieu Malaterre <malat@debian.org>
---
v2: Explicit reference to W=1

 kernel/events/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index 80cca2b30c4f..8f0434a9951a 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -6482,7 +6482,7 @@ void perf_prepare_sample(struct perf_event_header *header,
 		data->phys_addr = perf_virt_to_phys(data->addr);
 }
 
-static void __always_inline
+static __always_inline void
 __perf_event_output(struct perf_event *event,
 		    struct perf_sample_data *data,
 		    struct pt_regs *regs,
-- 
2.11.0

