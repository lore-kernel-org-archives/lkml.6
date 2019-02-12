Return-Path: <SRS0=NGUq=QT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64F97C282C4
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 07:06:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3161B21773
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 07:06:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="CQl5MHsU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727004AbfBLHGy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 02:06:54 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:43691 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725916AbfBLHGy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 02:06:54 -0500
Received: by mail-pf1-f193.google.com with SMTP id q17so849163pfh.10
        for <linux-kernel@vger.kernel.org>; Mon, 11 Feb 2019 23:06:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=lvhBXbt0lGYX/dVbL9FsSQn2IWcD8JIicvk9bDMMnZg=;
        b=CQl5MHsUNP4Ceptu2q6BpBhkIwziIrEmd10/rPSSpsDZf9Gr9carRURUy09uMTr9J0
         YJusX/Jp1ybUysC5DGVz6BgGznUEYaT8zGyacWJKnYhPoUMheJxm1qv6VltuLYpOk5ZV
         PGaebHuUBY5ti62yba00/2sCkTvRxrzT35U18LxxHWgYFn36n3+J23plkcVtMftKqCK3
         1S74JhyZUEBG6/AsvLu7IzPqjoIC88QixUUy/Eo6tseUC1Hl5CTR6gLdF5i063euPZ4S
         QiACaum0MExwRtaVP1Mu/tuiz38UOL8zZtqWyYURB3JYfTt77ER8OcslTrm4nUq/09T9
         k25g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=lvhBXbt0lGYX/dVbL9FsSQn2IWcD8JIicvk9bDMMnZg=;
        b=tcDv4gdiqr4CouOpYJCh5/gVRStvsQoJGzDpxLOpfWOyWzRZD1x03pkEwh1yw1l9aW
         uZClFWldLxmi486I+GHW5REW8aI5hFWsVYskJbhJGuloZMeLK/WScpjMqh8RkPbm9suX
         hW4ELNWm/cWSw7TAZx2ujRUeGry2BcxgtXSjvBubqjFZXiR6h4Oykw47CeV6mWmpTwMt
         NfAUg0EEFpNtg0uPmQl2midAk74J3xybF05gP5uDqeBb/EmrdV9GcwjFijA99hMeBWjy
         9gY/xOD4eQWV6+IpgQjtppdEJPf97aF37An8sESWKtGdIRuThfUZG/aF+2AZxrErsj/4
         N8bg==
X-Gm-Message-State: AHQUAub6GbptI8ZpCLWUGOgHk9tyAD+MVyc2xwM5vIh6Dgp70DhXuQv5
        3rbw3vlMrotBCZ3+F+240xYTQQ==
X-Google-Smtp-Source: AHgI3IbtBHyBEr6WHr9jwYImY6v4QZNtpajIG0x75moMoBw4XGSH1CsLyDpYrZs3Zbuo0xbmZ73yUA==
X-Received: by 2002:a63:dc53:: with SMTP id f19mr2271375pgj.406.1549955213146;
        Mon, 11 Feb 2019 23:06:53 -0800 (PST)
Received: from localhost ([122.172.102.63])
        by smtp.gmail.com with ESMTPSA id n27sm24104171pfb.8.2019.02.11.23.06.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 11 Feb 2019 23:06:52 -0800 (PST)
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Rafael Wysocki <rjw@rjwysocki.net>
Cc:     Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH V2 0/2] cpufreq: Allow light-weight tear down and bring up of CPUs
Date:   Tue, 12 Feb 2019 12:36:45 +0530
Message-Id: <cover.1549955027.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.20.1.321.g9e740568ce00
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The cpufreq core doesn't remove the cpufreq policy anymore on CPU
offline operation, rather that happens when the CPU device gets
unregistered from the kernel. This allows faster recovery when the CPU
comes back online. This is also very useful during system wide
suspend/resume where we offline all non-boot CPUs during suspend and
then bring them back on resume.

This patcset takes the same idea a step ahead to allow drivers to do
light weight tear-down and bring up during CPU offline/online operations
and updates the cpufreq-dt driver to implement the new helpers.

V1->V2:
- s/light_weight_exit()/offline()
- Also introduce the online() counterpart

Viresh Kumar (2):
  cpufreq: Allow light-weight tear down and bring up of CPUs
  cpufreq: dt: Implement online/offline() callbacks

 drivers/cpufreq/cpufreq-dt.c | 17 +++++++++++
 drivers/cpufreq/cpufreq.c    | 55 +++++++++++++++++++++++-------------
 include/linux/cpufreq.h      |  2 ++
 3 files changed, 55 insertions(+), 19 deletions(-)

-- 
2.20.1.321.g9e740568ce00

