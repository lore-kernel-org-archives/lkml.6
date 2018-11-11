Return-Path: <SRS0=p8q0=NW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADC21C43441
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 05:00:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6A35B20854
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 05:00:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="AkrX3P7S"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6A35B20854
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727430AbeKKOrj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 11 Nov 2018 09:47:39 -0500
Received: from mail-wr1-f54.google.com ([209.85.221.54]:41540 "EHLO
        mail-wr1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727184AbeKKOrj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Nov 2018 09:47:39 -0500
Received: by mail-wr1-f54.google.com with SMTP id v18-v6so5841653wrt.8
        for <linux-kernel@vger.kernel.org>; Sat, 10 Nov 2018 21:00:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=3ZR0GX6zV5AaJMlllNZlFYuW1k9FVmH5E45X0UbSiao=;
        b=AkrX3P7SQXmtssqNKNhvpUjnF8+6pRvDZji8k/ICQLBrDdAP/2ZY2DDsqAKYg1gDMu
         qQjC6XTNt6LvVqN2CDqlgyDqmcymqe7GyTc9oi0sGHBUOBA9uqaMJJKtTo7AH8nRH0RQ
         yO4uuHL2UN5/427kAJGgV+EmijOHT9OEwmSvY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=3ZR0GX6zV5AaJMlllNZlFYuW1k9FVmH5E45X0UbSiao=;
        b=PZnO0A5OJ7ya2KvVKKz74fVSi0U55pgBDj74u4COvfwhrH76vSnhfOFLDuUNvD4ftH
         yvP07j6/u2shrlNmpANNBvILoH8wkCmSY9vRo3Fcr9p+EJQzDVCZFGppiZnMK3ic2vQH
         8xnXDg7W4nVfzJDFNkL182hARfK/tMNxVcVCKu/kAajNub2fOyKGW3UUt3Q+GyYQiRqk
         vF/J9heCRnLt/67v44h17TIDB9Tds28bDED5SqEDVu+cWQuVspgWbN8prjueSlEl3GNE
         feMwkWRF2gwdFslYjocJGHdddjyGuckgGXdzjQr746GdHe2pSz/3DUicqCQ7ieerI57I
         n2Ig==
X-Gm-Message-State: AGRZ1gKVsiJoclgp6c4+fqjk2Ex2y5UW6gdqBX6DRkkKexmsIancJXzy
        f2m8u1/bPqTx3vZm6vUvRUA2HQ==
X-Google-Smtp-Source: AJdET5e/ktTXgZblQHmQThOFqcWrBxgP7mm6cv65+2fWvEn4rAUpYcsq9vlYrFeupWyaG/KvLDao/Q==
X-Received: by 2002:adf:80c8:: with SMTP id 66-v6mr12951009wrl.57.1541912409657;
        Sat, 10 Nov 2018 21:00:09 -0800 (PST)
Received: from localhost.localdomain ([209.250.228.18])
        by smtp.gmail.com with ESMTPSA id t187-v6sm4463802wmt.45.2018.11.10.21.00.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 10 Nov 2018 21:00:08 -0800 (PST)
From:   Leo Yan <leo.yan@linaro.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Mike Leach <mike.leach@linaro.org>,
        Robert Walker <robert.walker@arm.com>,
        Al Grant <Al.Grant@arm.com>,
        Coresight ML <coresight@lists.linaro.org>
Cc:     Leo Yan <leo.yan@linaro.org>
Subject: [PATCH v1 0/5] perf cs-etm: Correct packets handling
Date:   Sun, 11 Nov 2018 12:59:38 +0800
Message-Id: <1541912383-19915-1-git-send-email-leo.yan@linaro.org>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

perf cs-etm module converts decoder elements to packets and then we have
more context crossing packets to generate synthenize samples, finally
perf tool can faciliate samples for statistics and report the results.

This patch series is to address several issues found related with
packets handling and samples generation when worked firstly on branch
sample flags support for Arm CoreSight trace data,  so this patch series
also is dependency for another patch series for sample flags.

The first two patches are mainly to fix issues in cs_etm__flush():
Patch 0001 corrects packets swapping in cs_etm__flush() and this can fix
the wrong branch sample caused by the missed packets swapping; patch
0002 is to fix the wrong samples generation with stale packets at the
end of every trace buffer.

Patch 0003 is used to support NO_SYNC packet, otherwise the trace
decoding cannot reflect the tracing discontinuity caused by NO_SYNC
packet.

Patch 0004/0005 has been published in the patch series 'perf cs-etm: Add
support for sample flags' before but at this time I move them into this
patch series due these two patches are more relative with packets
handling.  Patch 0004 is used to generate branch sample for exception
packets; and patch 0005 is to track the exception number.

This patch series is applied on the acme's perf core branch [1] with the
latest commit f1d23afaf677 ("perf bpf: Reduce the hardcoded .max_entries
for pid_maps") and has one prerequisite from Rob's patch 'perf: Support
for Arm A32/T32 instruction sets in CoreSight trace' [2].

With applying the dependency patch, this patch series has been tested
for branch samples dumping with below command on Juno board:

  # perf script -F,-time,+ip,+sym,+dso,+addr,+symoff -k vmlinux

[1] https://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git/log/?h=perf/core
[2] http://archive.armlinux.org.uk/lurker/message/20181109.091126.9d69489d.en.html


Leo Yan (5):
  perf cs-etm: Correct packets swapping in cs_etm__flush()
  perf cs-etm: Avoid stale branch samples when flush packet
  perf cs-etm: Support for NO_SYNC packet
  perf cs-etm: Generate branch sample for exception packet
  perf cs-etm: Track exception number

 tools/perf/util/cs-etm-decoder/cs-etm-decoder.c | 91 ++++++++++++++++++++++---
 tools/perf/util/cs-etm-decoder/cs-etm-decoder.h | 11 +--
 tools/perf/util/cs-etm.c                        | 65 +++++++++++++++---
 3 files changed, 146 insertions(+), 21 deletions(-)

-- 
2.7.4

