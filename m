Return-Path: <SRS0=awCL=P3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDAF3C5AE5E
	for <linux-kernel@archiver.kernel.org>; Sat, 19 Jan 2019 00:12:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B63132086A
	for <linux-kernel@archiver.kernel.org>; Sat, 19 Jan 2019 00:12:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tycho-ws.20150623.gappssmtp.com header.i=@tycho-ws.20150623.gappssmtp.com header.b="nLX8qGYk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730191AbfASAMr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Jan 2019 19:12:47 -0500
Received: from mail-qk1-f196.google.com ([209.85.222.196]:46363 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730132AbfASAMr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jan 2019 19:12:47 -0500
Received: by mail-qk1-f196.google.com with SMTP id q1so9031261qkf.13
        for <linux-kernel@vger.kernel.org>; Fri, 18 Jan 2019 16:12:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tycho-ws.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=rwJQTTpQtFTFa/VriVY6MbHV+teJCQS6DxG+RjP0O28=;
        b=nLX8qGYkkI8ta+WMxkrycHJ1Azark9ReqNBv927bdtpEguyLBd5cth/T4KmQJqOWeL
         usIsbENCBLNCt45SU/GafVqAR6+jyV8U7QGz9jrTDpoYO1Zr/Kxhc4qQLAl1jSHp/Tw0
         n7bb9u/v+n6zrOaq2DGEl7N+bYZTnNZ9rSQhzB2ADIH7gEAFgY9tEa2sa1yMiMBr71fV
         WuVVYtDaTQe5NNc1gsmwa8f6N4fWCOqR5L5Kp/R5AblCQyv6YWOfmro7W0t6d3gbNPM5
         74I09FRyTCVwcVc+zPjkkxwid/bIvM12mBJZJzqKGbd5bUz6sf8IfGekL2iAPJ8dNt+u
         vwTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=rwJQTTpQtFTFa/VriVY6MbHV+teJCQS6DxG+RjP0O28=;
        b=erOw5qQ2gF1sPfHsW4wxEDAXp5HVAdequxQ/f/4N9xEo5shBbrA/NbvWyJfLVQmhoc
         62UxQLNhuhiHyPA9Y3nPR9uu0/d4/UhiqRpOGIpIwCE/chPE/zcL/1V/MGYUkdQEFAQG
         bPbQApYx3CJAS4n17t/J2o7Djq82WaXJqiCtxg+mBiEmOvMtos8zDe31p3e9uHnqV+D4
         EWI/DNmkDvkVEm/99luoSfLpJ57g3PvXDpOQeDB73ecUA8HMCDgXnGFRRhPObl5xbrAn
         wTfvNRo06r0PYF8vLM5jCaJC5TSSWGMySg9s0TI7MZYUw4hX8rvI24zYlGfE4YzARtIt
         hTAA==
X-Gm-Message-State: AJcUukfjXom/ragdjilaai/kpwXCh775wd4JCSjyRy6ETbmC8fXJrbN7
        CTJnGRSFfglfFYJw9pe/QIvWMw==
X-Google-Smtp-Source: ALg8bN6jnWK3qTEf+DOENn0pA6k/6J1R4KeKPS9a30eGNIqvXvBZa60i7yHQ/enTWGbElDYWUPE8hQ==
X-Received: by 2002:a37:8fc1:: with SMTP id r184mr16865795qkd.32.1547856766113;
        Fri, 18 Jan 2019 16:12:46 -0800 (PST)
Received: from localhost.localdomain ([64.125.109.186])
        by smtp.gmail.com with ESMTPSA id m14sm41140501qka.21.2019.01.18.16.12.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 18 Jan 2019 16:12:45 -0800 (PST)
From:   Tycho Andersen <tycho@tycho.ws>
To:     Shuah Khan <shuah@kernel.org>, Kees Cook <keescook@chromium.org>
Cc:     linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        Tycho Andersen <tycho@tycho.ws>
Subject: [PATCH v1 0/6] seccomp test fixes
Date:   Fri, 18 Jan 2019 17:12:11 -0700
Message-Id: <20190119001217.12660-1-tycho@tycho.ws>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

Here are the fixes I previously mentioned I would send. I previously
assumed that the tests were mostly run as root, but it turns out
everything else besides the stuff I wrote in the seccomp tests either
sets NNP and doesn't require real root, so it all actually works. This
set of fixes should make most of the other tests work unprivileged,
while XFAIL-ing the one that requires real root.

Cheers,

Tycho

Tycho Andersen (6):
  selftests: don't kill child immediately in get_metadata() test
  selftests: fix typo in seccomp_bpf.c
  selftest: include stdio.h in kselftest.h
  selftests: skip seccomp get_metadata test if not real root
  selftests: set NO_NEW_PRIVS bit in seccomp user tests
  selftests: unshare userns in seccomp pidns testcases

 tools/testing/selftests/kselftest.h           |  1 +
 tools/testing/selftests/seccomp/seccomp_bpf.c | 42 ++++++++++++++++---
 2 files changed, 38 insertions(+), 5 deletions(-)

-- 
2.19.1

