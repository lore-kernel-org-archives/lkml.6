Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE715C07E85
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 11:55:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B500020811
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 11:55:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="n4uTqebz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B500020811
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726371AbeLKLy7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 06:54:59 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:40238 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726130AbeLKLy7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 06:54:59 -0500
Received: by mail-pl1-f194.google.com with SMTP id u18so6817567plq.7;
        Tue, 11 Dec 2018 03:54:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=V1I/kN0ZOHHiScIsAfE1Fw/hBDkr6a8KECSO0v3EfVA=;
        b=n4uTqebz5rH4NmIuHq7JVtd0DJEP8fnPKXExzE3D4ZzpK3QrX69AQXIjYySyDV5r0s
         o40wMcjLtGKEv/vwfCqx+DIIXS8/qy0U2AlFyJULroYa3ng8XXQYEIIklxsZliytYOOD
         OHSV7i3InOzY8pwr0dbFKyHam1d3QalsdmP+XnJqT992TfjmEB66LhkMMU4t0+yhdpVI
         ZuFColZExW2A5QztBcAzYu8IT56Q/I6Q4QZqVdJvrNqXG/xGCli7s1ZTyi8XR4nibkbY
         egjjw2sBdxVIbEmT7D+aIfEGwNCGGgmA8UrRyHyWFM614IetywJ6PV4o8bvylMjWiEsi
         l93A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=V1I/kN0ZOHHiScIsAfE1Fw/hBDkr6a8KECSO0v3EfVA=;
        b=psPItm23+kw6YGM6/AoHanT8uVpBiK8ezAyxrpXMvw4xhZ8sbp/zWHJT2NlEmXtQZi
         Q9QoLv8eWQb65vN9vBJoUC0W3VCZKPeFZqJ/DjyWqsdT+imwyYlo/CmSBboyKf5Wvh25
         G8J8B8FnfzGbstm1c0MGtJoBhqQUb/aehu0zm3fOTNhMCrfKxW/1+NBJfBgvyKXUzKAk
         WObPsnuOtQoXu71PqmTSMBrRPAxgEQJdHkPBRixA+ZwrJPkcEsRjhf6Zd/vJYsSeP76v
         O5NY5zh4eiPoK8QBGWY+2GrSVRxz5yp/hEHb9OLczM3YMZfvqBSOfKKf3Zp9UHgh1n56
         NhkA==
X-Gm-Message-State: AA+aEWarSxG1kHrIN5723oOJmi8M00eC1ZASR5AYs/Cbe10DAHoPgF1W
        FKPXh4ds2wGCcSLKHytx1OI=
X-Google-Smtp-Source: AFSGD/XWvP5AgUnvtUHJASpcxF10XwEUw5JPvxmlFQzrZgjKeH8vExuDzaoPJ53beSMTgpmwDUhf4Q==
X-Received: by 2002:a17:902:f01:: with SMTP id 1mr15210113ply.143.1544529297649;
        Tue, 11 Dec 2018 03:54:57 -0800 (PST)
Received: from localhost (219x123x27x194.ap219.ftth.ucom.ne.jp. [219.123.27.194])
        by smtp.gmail.com with ESMTPSA id h74sm22359143pfd.35.2018.12.11.03.54.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 11 Dec 2018 03:54:56 -0800 (PST)
From:   Alice Ferrazzi <alice.ferrazzi@gmail.com>
Cc:     ast@kernel.org, daniel@iogearbox.net, shuah@kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Alice Ferrazzi <alice.ferrazzi@gmail.com>
Subject: [PATCH 0/7] selftest/bpf fix PEP8 warnings
Date:   Tue, 11 Dec 2018 20:56:00 +0900
Message-Id: <20181211115607.13774-1-alice.ferrazzi@gmail.com>
X-Mailer: git-send-email 2.19.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

fixing PEP8 warning in the selftest bpf python files.

Alice Ferrazzi (7):
  selftest/bpf: Fix trailing semicolon in the statement
  selftest/bpf: optimize import
  selftest/bpf: PEP 8: multiple statements on one line (colon)
  selftest/bpf: test_offload PEP8 format style fix
  selftest/bpf: Fix PEP8 ambiguous variable name
  selftest/bpf: remove redundant parenthesis
  selftest/bpf: fix E501 line too long

 tools/testing/selftests/bpf/tcp_client.py   |  24 +++--
 tools/testing/selftests/bpf/tcp_server.py   |  27 +++--
 tools/testing/selftests/bpf/test_offload.py | 107 ++++++++++++++------
 3 files changed, 109 insertions(+), 49 deletions(-)

-- 
2.19.2

