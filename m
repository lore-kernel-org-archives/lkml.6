Return-Path: <SRS0=Q/hc=JL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,URIBL_BLOCKED,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC3A2C43144
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 22:48:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5B1F5257D2
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 22:48:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="U6JkeUSh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5B1F5257D2
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934604AbeFYWsp (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Jun 2018 18:48:45 -0400
Received: from mail-io0-f202.google.com ([209.85.223.202]:49717 "EHLO
        mail-io0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754259AbeFYWk6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jun 2018 18:40:58 -0400
Received: by mail-io0-f202.google.com with SMTP id x13-v6so12886601iog.16
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jun 2018 15:40:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:date:in-reply-to:message-id:references:subject:from:to
         :cc;
        bh=smiMhu+/BeT5Pxdg509a30E1ghstaHTxE6n7qixOWlc=;
        b=U6JkeUShAN/4xy5Y0SstOVpLWKTCw19NJLX38E2AREFR2ACgKd58omFusy5Etlwy8R
         0XHCzp7jRmPO5UKgm78o4K9wqZKbRD8CnZ9/gFj1xjypBVh+O1NIIU20ZyGdGzfXLws8
         AYo/yDIdt366QqR219PkWtFoe/UZoM+KqkYKCaR02sREVOS+0RZBQ1u1BdGzZYxTPQ8D
         pOkvFvWWew0Ns4WZOwusHa+LUQobFWij47y4gnjm7uTW3wZEkoMtRTocRulmnzogm9+D
         cjGrib9HhmXhmbhwRLc+fnyarF46fZPeHmHg22LplU3Bl4n51bbwrGIidqHhL6XcA4P9
         fpEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id
         :references:subject:from:to:cc;
        bh=smiMhu+/BeT5Pxdg509a30E1ghstaHTxE6n7qixOWlc=;
        b=mf9oAGAGzALOGHQfqmgITzxrVXMo2eU3vQkgsEHkq0fBLL2cnozwZMrtQjbqtpllD4
         yQpLl6fMudEHa9PJjRDi9m9CGXrY0cjZHk9TWF52890D2Yd5bDxurjOF/r/vhYmH74TD
         /EtDzIVITVvA1iZdc3wXvBx6NJoNF+HUPMrZ5THiEXZmAGC0PnTluqXiytQz37uQAYJ+
         OpMf5iR27P+y1DiBzpthbLaTiXB5ZuG+1nMQg7AX4Q+vEqrVp+6SX51dlC0IgLqbdEcm
         ExKMcZhJSJtFwGQZ0Q9phG1xfpO3kjuRKqLsuq5BkGMdyMx8DDqRbAdnLmLW+MEXPBJU
         N6Pw==
X-Gm-Message-State: APt69E36DSITvoKb6My6qlazurC1UaHdWayQsey4zMbsBk5kUkscfkYJ
        lQctwFe4nYnY1k2ysWEya9RdUQvMe8EBYg==
X-Google-Smtp-Source: ADUXVKLwYmw/x5AjuGui7CGCkokkURkHf1n9bi8BHM6yCyuL/w2MGgbAiRtG5eOKFdXI7exKF94HhCT8RUksxw==
MIME-Version: 1.0
X-Received: by 2002:a24:b602:: with SMTP id g2-v6mr1171076itf.16.1529966457671;
 Mon, 25 Jun 2018 15:40:57 -0700 (PDT)
Date:   Mon, 25 Jun 2018 15:38:50 -0700
In-Reply-To: <20180625224014.134829-1-thgarnie@google.com>
Message-Id: <20180625224014.134829-3-thgarnie@google.com>
References: <20180625224014.134829-1-thgarnie@google.com>
X-Mailer: git-send-email 2.18.0.rc2.346.g013aa6912e-goog
Subject: [PATCH v5 02/27] x86: Use symbol name on bug table for PIE support
From:   Thomas Garnier <thgarnie@google.com>
To:     kernel-hardening@lists.openwall.com
Cc:     Thomas Garnier <thgarnie@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replace the %c constraint with %P. The %c is incompatible with PIE
because it implies an immediate value whereas %P reference a symbol.

Position Independent Executable (PIE) support will allow to extend the
KASLR randomization range 0xffffffff80000000.

Signed-off-by: Thomas Garnier <thgarnie@google.com>
---
 arch/x86/include/asm/bug.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/bug.h b/arch/x86/include/asm/bug.h
index 6804d6642767..3d690a4abf50 100644
--- a/arch/x86/include/asm/bug.h
+++ b/arch/x86/include/asm/bug.h
@@ -35,7 +35,7 @@ do {									\
 	asm volatile("1:\t" ins "\n"					\
 		     ".pushsection __bug_table,\"aw\"\n"		\
 		     "2:\t" __BUG_REL(1b) "\t# bug_entry::bug_addr\n"	\
-		     "\t"  __BUG_REL(%c0) "\t# bug_entry::file\n"	\
+		     "\t"  __BUG_REL(%P0) "\t# bug_entry::file\n"	\
 		     "\t.word %c1"        "\t# bug_entry::line\n"	\
 		     "\t.word %c2"        "\t# bug_entry::flags\n"	\
 		     "\t.org 2b+%c3\n"					\
-- 
2.18.0.rc2.346.g013aa6912e-goog

