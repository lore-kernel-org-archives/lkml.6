Return-Path: <SRS0=k9B+=NF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F1A6ECDE46
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 00:09:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F23E120832
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 00:09:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HlW9hkwa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F23E120832
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726803AbeJYIjl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Oct 2018 04:39:41 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:44169 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726019AbeJYIjl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Oct 2018 04:39:41 -0400
Received: by mail-pf1-f196.google.com with SMTP id j2-v6so52768pfn.11
        for <linux-kernel@vger.kernel.org>; Wed, 24 Oct 2018 17:09:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=Dd9htmrIBxK1xqDAJaYeWVH09dIkotWYFY1BayV7uKA=;
        b=HlW9hkwaNyJ/JdKbXExQLNeggX0cy/VXQ73SduopQcEyFKm09gNU4OShy/l2Io36bq
         YT0ZK8aaZyAnsjb84v5T7Ez+4n0bEP9ZA/LUiX4vuWcLup8g9DxG8RTp2H5BI8g/OG8Z
         ucX3TygGxOEU5zOW2Fc9dwtdv8+9lErn9C/dUo7lAOh6dnrJ1NymGKoIDLHplYUMk1b/
         rfc4IRRQiJoJYI92E0pDnppkNjmRCwn15yyXegRX/dstJcHPlN6DJ9Fk1Vv8CqHceXF4
         rUM7vk+NxcALDmXCevjeFVkqnaNYfRtxAnuiOdKj8nHTMLMzjdL8aH8O3VXaD/ad6+18
         F7qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=Dd9htmrIBxK1xqDAJaYeWVH09dIkotWYFY1BayV7uKA=;
        b=Oxiehn+RaKRKrWTb/Dk2vlt++e/k97XvMiIdiYp0WRhzxNQ5tXVyyHT9twQC/iO9nx
         vy5h5+jnQQYgd834+i2H2A28USqqJpEvdoN7I6bmLpJikx9cGiiYRVIP3OuD95v84bFf
         Y8nY+irLtQRmiho7Lj/7v4itGP/eYQZjrfoxhrsFog+ow3ijRGogsMwX2exJY8FH/KVk
         PuZBJt8WVYmpVI23fUYUjzEmmyQkb7oEDg1ZTWYNqLPYLpRNj+K73cdaeF4sn6rNeLaP
         utR8aGxHf1wOOpgPXGwGDdHFAxYP0SMFhBCkipC4OA9L4+dcs7OGUZ99uDi2G5W8fzbQ
         m26A==
X-Gm-Message-State: AGRZ1gLLE2Q3ic9cIUI7rq4Q5oAvwPC0Lc/vCpYKx/7/iaB/iv8QgcJx
        YIRZpYQaoIzWa2qxEQXi8v8=
X-Google-Smtp-Source: AJdET5dWD+lGoGYAUQTVrhXMNJt+nvl332OkqlnCCCnewretH44k6shb+PCLABEtYh9TXr9mo3JqOw==
X-Received: by 2002:a62:9402:: with SMTP id m2-v6mr4683115pfe.255.1540426168261;
        Wed, 24 Oct 2018 17:09:28 -0700 (PDT)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.250])
        by smtp.gmail.com with ESMTPSA id o9-v6sm12008598pgn.30.2018.10.24.17.09.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 24 Oct 2018 17:09:27 -0700 (PDT)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Kim Phillips <kim.phillips@arm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ravi Bangoria <ravi.bangoria@linux.ibm.com>,
        Thomas Richter <tmricht@linux.ibm.com>,
        linux-kernel@vger.kernel.org (open list),
        rmk+kernel@armlinux.org.uk, l.stach@pengutronix.de
Subject: [PATCH 0/2] perf tests: Check for ARM [vectors] page
Date:   Wed, 24 Oct 2018 17:09:03 -0700
Message-Id: <20181025000905.6095-1-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

I just painfully learned that perf would segfault when
CONFIG_KUSER_HELPERS is disabled because it unconditionally makes use of
it. This patch series adds an ARM test for that by leveraging the
existing find_vdso_map() function and making it more generic and capable
of location any map within /proc/self/maps.

Florian Fainelli (2):
  perf tools: Make find_vdso_map() more modular
  perf tests: Add a test for the ARM 32-bit [vectors] page

 tools/perf/arch/arm/tests/Build          |  1 +
 tools/perf/arch/arm/tests/arch-tests.c   |  4 +++
 tools/perf/arch/arm/tests/vectors-page.c | 20 +++++++++++++++
 tools/perf/tests/tests.h                 |  5 ++++
 tools/perf/util/find-map.c               | 31 ++++++++++++++++++++++++
 tools/perf/util/find-vdso-map.c          | 30 +++--------------------
 6 files changed, 64 insertions(+), 27 deletions(-)
 create mode 100644 tools/perf/arch/arm/tests/vectors-page.c
 create mode 100644 tools/perf/util/find-map.c

-- 
2.17.1

