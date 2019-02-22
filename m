Return-Path: <SRS0=t/yM=Q5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10985C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 09:10:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D42922077B
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 09:10:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726979AbfBVJKg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Feb 2019 04:10:36 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:48491 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726227AbfBVJKf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Feb 2019 04:10:35 -0500
Received: from mail-wr1-f69.google.com ([209.85.221.69])
        by youngberry.canonical.com with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
        (Exim 4.76)
        (envelope-from <juerg.haefliger@canonical.com>)
        id 1gx6qn-0006Qg-Jt
        for linux-kernel@vger.kernel.org; Fri, 22 Feb 2019 09:10:33 +0000
Received: by mail-wr1-f69.google.com with SMTP id e18so734784wrw.10
        for <linux-kernel@vger.kernel.org>; Fri, 22 Feb 2019 01:10:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=YVZBhaK6D9avjL/hTLFBzAI4PJCLQruWNjlgWecmsOg=;
        b=TS7iakAvYAegG/kkEOFukhaU1qAo35CdgbZYGTJo645ZE2r5aug8RHngb58lRoiB8o
         mAMqL5zVeWT0AJfA/QYYv9XYHBwTvgPabiUTcU821ZezWFR135ndO1i1svagHrqc3+5F
         kQFi7ZmXpXyWQET3+QlYhuspnPaYZEHXIejoajdzmP1r4kNMXfQOH6CFwfe7VJtVjIk9
         7RNEdwBcoFwfnVLDiZitAvRDBer4ePShCXpv3JuwZiHObm+yZraPuUMqAcRIUnWD0o+U
         OfdPpB/zlLO89wyEP7M/yQWV0edz7xU4SYHV4UffQm5JWXnraRhB1pLrDXppbLvHib4C
         jqjg==
X-Gm-Message-State: AHQUAuYnv2VU9ZZFvcKGpKjgwvAQ5SdevxGIwUT31jP5WVX+sISsJh5p
        aysFOwVtBri5u5lr+3BNqEpcayOJpAGt0RgJMUzAYQP1zzkXiceimVHMhYlO0dS1iNoQg7lK7oK
        +87jUTRTMDUaEnJRpxWgSr3/dY97IH6xsHUVpkoV65A==
X-Received: by 2002:a1c:2097:: with SMTP id g145mr1662911wmg.81.1550826633102;
        Fri, 22 Feb 2019 01:10:33 -0800 (PST)
X-Google-Smtp-Source: AHgI3IZSXkUodx7o+QlXVutld+YkibuT2dIppjxmJVyr2XqhrXCxtX+aYSO6+Wb/f0vWiOECbMCOCA==
X-Received: by 2002:a1c:2097:: with SMTP id g145mr1662891wmg.81.1550826632818;
        Fri, 22 Feb 2019 01:10:32 -0800 (PST)
Received: from localhost.localdomain ([194.204.107.10])
        by smtp.gmail.com with ESMTPSA id f126sm292559wmf.6.2019.02.22.01.10.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 22 Feb 2019 01:10:32 -0800 (PST)
From:   Juerg Haefliger <juerg.haefliger@canonical.com>
X-Google-Original-From: Juerg Haefliger <juergh@canonical.com>
To:     linux-kernel@vger.kernel.org, rostedt@goodmis.org,
        mingo@redhat.com, mhiramat@kernel.org
Cc:     Juerg Haefliger <juergh@canonical.com>
Subject: [PATCH v2 0/2] selftests/ftrace: Make ftracetest POSIX compliant
Date:   Fri, 22 Feb 2019 10:10:19 +0100
Message-Id: <20190222091021.10178-1-juergh@canonical.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190220161333.28109-1-juergh@canonical.com>
References: <20190220161333.28109-1-juergh@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The recent addition of colored output introduced some non-POSIX-compliant
constructs. Fix that.

Juerg Haefliger (2):
  selftests/ftrace: Replace echo -e with printf
  selftests/ftrace: Replace \e with \033

 tools/testing/selftests/ftrace/ftracetest | 17 +++++++++++------
 1 file changed, 11 insertions(+), 6 deletions(-)

-- 
2.19.1

