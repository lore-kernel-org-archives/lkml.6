Return-Path: <SRS0=qqIy=KO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6481FC43142
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 21:34:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0B62220857
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 21:34:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="lTpex69z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0B62220857
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726872AbeG3XLN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Jul 2018 19:11:13 -0400
Received: from mail-io0-f202.google.com ([209.85.223.202]:47839 "EHLO
        mail-io0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726867AbeG3XLN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jul 2018 19:11:13 -0400
Received: by mail-io0-f202.google.com with SMTP id z9-v6so9856463iom.14
        for <linux-kernel@vger.kernel.org>; Mon, 30 Jul 2018 14:34:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=4CzUgBaQg7ruTML91u9knxPpbIeOBi9LX5HsFcrdDsw=;
        b=lTpex69zDufSJVAtYOf3Lc/rSNDntoDLYHGTrA6nrG4c31F6+y/HhTIh4HohpOlALZ
         8+0w7fSVD5QRB8c9IT6MwOWP8Hbzt4BDV5CBelHLL0r9JWZ188wQdHOtP9WoTbEpq4fu
         BOGDqIum16nJFKWlMS0Su8m61IuKWfe0osnI3RfopyveG13GDujHd5OGz2Ql1Tlx/S3s
         tYBIXcPV52pVgGox1dV1Fbto4jvh0+TO7J1QAS1XRVorSUdNuJBUW9zKoDwsfv6p06hi
         hU6YEmwfJLWN0VOtjWP/onZkXwOeajbzgTwVHMjE68MHxAfvUb4Vtttpx7kvXmb1rPoO
         r2yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=4CzUgBaQg7ruTML91u9knxPpbIeOBi9LX5HsFcrdDsw=;
        b=CbCn1aqd3o18q6ZfcY2orE/qJvi6h6v6GV8oK2QJ9y83rKo0s37yWySp/qnNplPOQn
         hKTCdWix2gMdchDCYa4CW17OeRIpVYWFQ9ZvBa3+20Ui8D8Ih2D1tg0TR8xA7txFQgk2
         8G09fc8llbbjCRdiKt68dHUjMcMA4EWtaA6YJpgGkKXGKmonRlSHriIsv7YJJRQdLh0u
         N+ApmbiF5APdMH69Ka17BoH0pnThzm4j8WP7bXyRhsfdGkTBzQaSEprVPGCPvhO77b3P
         NgGwLYRPVbB0bdBr/DJ+wbbQDQdHR1pru3StMFWiCG79oBzBnm7A03VJix+TIHL6DDRO
         S0zg==
X-Gm-Message-State: AOUpUlHmXC3ZlPOeLnb/kEc62k7rvd2UiLznVLlqS1M8n6jzTUH87AQM
        Pj9dM3QdoinzpxUXhXpdrGwrSiVg9EvtXRz2PMk=
X-Google-Smtp-Source: AAOMgpeM0jG9pYOX4LJe7F9pDwsHhKWaFmw3tKlSrdN+aIaBD4Ifn0+WuRVCKg2NSRPUlzDZ1hEQzVwu/EuHA/FGN/w=
X-Received: by 2002:a6b:3443:: with SMTP id b64-v6mr7321008ioa.68.1532986458051;
 Mon, 30 Jul 2018 14:34:18 -0700 (PDT)
Date:   Mon, 30 Jul 2018 14:34:10 -0700
Message-Id: <20180730213412.242849-1-ndesaulniers@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.18.0.345.g5c9ce644c3-goog
Subject: [PATCH v2 0/2] CLANG_VERSION and __diag macros
From:   Nick Desaulniers <ndesaulniers@google.com>
To:     akpm@linux-foundation.org, natechancellor@gmail.com
Cc:     arnd@arndb.de, paul.burton@mips.com, christophe.leroy@c-s.fr,
        shorne@gmail.com, yamada.masahiro@socionext.com,
        keescook@chromium.org, mingo@kernel.org,
        gregkh@linuxfoundation.org, tglx@linutronix.de,
        rdunlap@infradead.org, bp@suse.de, neilb@suse.com,
        linux-kernel@vger.kernel.org, aryabinin@virtuozzo.com,
        dwmw@amazon.co.uk, sandipan@linux.vnet.ibm.com,
        linux@rasmusvillemoes.dk, paullawrence@google.com,
        andreyknvl@google.com, will.deacon@arm.com, ghackmann@android.com,
        stable@vger.kernel.org, ghackmann@google.com, mka@chromium.org,
        jpoimboe@redhat.com, wvw@google.com, avagin@openvz.org,
        Nick Desaulniers <ndesaulniers@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

clang-7 has a new warning (-Wreturn-stack-address) for warning when a
function returns the address of a local variable.  This is in general a
good warning, but the kernel has a few places where GNU statement
expressions return the address of a label in order to get the current
instruction pointer (see _THIS_IP_ and current_text_addr).

In order to disable a warning at a single call site, the kernel already
has __diag macros for inserting compiler and compiler-version specific
_Pragma's.

This series adds CLANG_VERSION macros necessary for proper __diag
support, and whitelists the case in _THIS_IP_. current_text_addr will be
consolidated in a follow up series.

Nick Desaulniers (2):
  compiler-clang.h: Add CLANG_VERSION and __diag macros
  kernel.h: Disable -Wreturn-stack-address for _THIS_IP_

 include/linux/compiler-clang.h | 19 +++++++++++++++++++
 include/linux/compiler_types.h |  4 ++++
 include/linux/kernel.h         | 10 +++++++++-
 3 files changed, 32 insertions(+), 1 deletion(-)

-- 
2.18.0.345.g5c9ce644c3-goog

