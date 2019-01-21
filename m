Return-Path: <SRS0=RWde=P5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61076C282F6
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 09:42:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 183AF2085A
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 09:42:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="IVDeJR3n"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728136AbfAUJmd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Jan 2019 04:42:33 -0500
Received: from mail-wr1-f54.google.com ([209.85.221.54]:45146 "EHLO
        mail-wr1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727869AbfAUJmc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jan 2019 04:42:32 -0500
Received: by mail-wr1-f54.google.com with SMTP id t6so22416241wrr.12
        for <linux-kernel@vger.kernel.org>; Mon, 21 Jan 2019 01:42:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=BF1tNERhAp9Dv8KkuTpsxbYR1BCLOGcza7snJ26RIdI=;
        b=IVDeJR3nJPmBaTkiGHcEi46XAPjGMi+RGvhh21kTad0apV5ligeyYTVDjtyfPhe4T2
         iwcAVvbCvDptWOUjbQO5L8MCuuxgX4zDAnS++nmFhtqyMgWoJXPxhKHDsdlWLo6zlh8N
         6pUpbLwwVFy2w4Biv2XZZQvguej0+Z8Hhqi7I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=BF1tNERhAp9Dv8KkuTpsxbYR1BCLOGcza7snJ26RIdI=;
        b=VRKjL+5vT32QjefI5MTGXyVAWJFkCqiKly6iepWHEXrIXilpQOBCFxWx6+8vCIUFBP
         ThhH1MQpkHKgsGX2/hIwKGS0Ch6JA3uyntToafbSkLa41Nt8w7wbllcqgeFTwfGZw5ic
         dtWQYIWr4d3/q1TE0gbLlvVN3se3nulqxf1TDLw0a0NhcaDj/bb299uaa6b91/Lh5x9p
         Hpevl/tjxZabxPUFQ/mq9BXAfVjPPyBRghklA8PI6RTnmBsuF4wQG2VOir2bNVcwaMsb
         i6qPVfctB2JMxHMMlC7qXYsjTMUPCU0Fu61YziBUDK8lmYbOd6shtM0rw7Z0gOxrAFqI
         i1tA==
X-Gm-Message-State: AJcUukc8FMHRpY41UWQSiJCsMHjEeEmc87m5oclYJktsWl8I+PBJBbZN
        ZyJ03bvcHlcwqlbgzboZnIZFStB3Adk=
X-Google-Smtp-Source: ALg8bN50LOdZCwkJtZTZHGaQHx2QAIaOi92EEQYkb/oB9MY2MkCe3f5Udmz8tMal1peWhBmjDF2Y9g==
X-Received: by 2002:adf:e08c:: with SMTP id c12mr26068189wri.199.1548063750478;
        Mon, 21 Jan 2019 01:42:30 -0800 (PST)
Received: from localhost ([49.248.61.1])
        by smtp.gmail.com with ESMTPSA id o81sm75669742wmd.10.2019.01.21.01.42.28
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 21 Jan 2019 01:42:29 -0800 (PST)
From:   Amit Kucheria <amit.kucheria@linaro.org>
To:     linux-kernel@vger.kernel.org
Cc:     linux-arm-msm@vger.kernel.org, edubezval@gmail.com,
        swboyd@chromium.org, Amit Daniel Kachhap <amit.kachhap@gmail.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Javi Merino <javi.merino@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Zhang Rui <rui.zhang@intel.com>,
        linux-pm@vger.kernel.org (open list:THERMAL)
Subject: [PATCH v1 0/2] thermal: trivial fixes to error messages
Date:   Mon, 21 Jan 2019 15:12:21 +0530
Message-Id: <cover.1548063429.git.amit.kucheria@linaro.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix up a couple of error messages

Amit Kucheria (2):
  thermal: of-thermal: Print name of device node with error
  thermal: cpu_cooling: Clarify error message

 drivers/thermal/cpu_cooling.c | 2 +-
 drivers/thermal/of-thermal.c  | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

-- 
2.17.1

