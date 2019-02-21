Return-Path: <SRS0=r0+/=Q4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B64D5C4360F
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 11:29:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8626C2086C
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 11:29:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="aYG08bis"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727061AbfBUL3t (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Feb 2019 06:29:49 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:34847 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725385AbfBUL3r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Feb 2019 06:29:47 -0500
Received: by mail-pf1-f194.google.com with SMTP id j5so9110958pfa.2
        for <linux-kernel@vger.kernel.org>; Thu, 21 Feb 2019 03:29:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Ix1FwySAVgbgIZf9pHZHFMA62PotFx+DGTqjm2zedM4=;
        b=aYG08bisJ2AriwmT7Quk9gXRaeZyNJqVE7Q0sYlZOA4SPlZeLNEJYEgWgwRCoS/DQt
         y95q816s8+y70IK4KfmpcrJwZmK9y8CzXsyEzOZ3Dxf/wyvQbZoYTB7rE+PVC2BV1EFn
         0o3zTh3tEEhddRIjnJEYvew2Lwor5B8vL7eEuqypjEIapjN8L+tZ17jkUpm9DXbvVqWT
         gfIbWJ8mjoAal47xDHqEtQbbQUmp+ebJ0P4i6FKj61ISSIDI5sBLM5nkxCmDCrECHTLQ
         UYRI+GCLkRWOQt2fwGBrKRO/2cRU8uHS1k/dO1XY+6jaLtEOyx1cTxLcumX6f63sVMmI
         4mKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Ix1FwySAVgbgIZf9pHZHFMA62PotFx+DGTqjm2zedM4=;
        b=Nryv8yIkdEulGm6W2Oyo2/A/y2KAfTsnKidMZhIpynGYX8dWrZ3e6d1BJeU7glfHHp
         TNtG9aCk6Dkh6W7roP5DzX8PkDhU6RPKmzZSA0OlAV1fJv3q1Zuu+IE9TsXVkafx+W8J
         d4+9HLqBx0EV7gbfi5qI7BrPpiCnjzqDgPjO1RglzHgSCO55BZenarZ7JC9CIjCOtB9Q
         npzqJDuILPPFAzkNyC8+q9x2y8SkKRSAhdMa14woL5qEsYeKpM109mZSohyT6Uu5YwEA
         F63GROnBjHKXzocwMH/wB5KKdMPlNMEJV9+qSgcwU4zvkKkezvWAh1I4GBeLLgdT/veE
         C0rw==
X-Gm-Message-State: AHQUAuZQdDMxzGJnAJnjhXFs51kE8IrtfZ4sAs3H3I1o1eoLPI+BOe7o
        vtjo1x1mj7MzyTXGbShTzl3Ocg==
X-Google-Smtp-Source: AHgI3IYv2mQBRiIJTHZEkl4L4R9icmaCw41d+jXlgs+ncNjTDinzUFUhJfbmXFyomQD+z3vmp8tQOA==
X-Received: by 2002:a63:ce41:: with SMTP id r1mr19288196pgi.119.1550748586071;
        Thu, 21 Feb 2019 03:29:46 -0800 (PST)
Received: from localhost ([122.172.102.63])
        by smtp.gmail.com with ESMTPSA id g3sm8138422pfo.125.2019.02.21.03.29.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 21 Feb 2019 03:29:44 -0800 (PST)
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Rafael Wysocki <rjw@rjwysocki.net>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Kevin Hilman <khilman@kernel.org>,
        Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>,
        Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>, mka@chromium.org,
        juri.lelli@gmail.com, Qais.Yousef@arm.com,
        linux-kernel@vger.kernel.org
Subject: [PATCH V2 0/5] cpufreq: Use QoS layer to manage freq-constraints
Date:   Thu, 21 Feb 2019 16:59:26 +0530
Message-Id: <cover.1550748118.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.21.0.rc0.269.g1a574e7a288b
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

This patchset attempts to manage CPU frequency constraints using the PM
QoS framework. It only does the basic stuff right now and moves the
userspace constraints to use the QoS infrastructure.

Todo:
- Migrate all users to the QoS framework and get rid of cpufreq specific
  notifiers.
- Make PM QoS learn about the relation of CPUs in a policy, so a single
  list of constraints is managed for all of them instead of per-cpu
  constraints.

V1->V2:
- The previous version introduced a completely new framework, this one
  moves to PM QoS instead.
- Lots of changes because of this.

--
viresh

Viresh Kumar (5):
  PM / QOS: Pass request type to dev_pm_qos_{add|remove}_notifier()
  PM / QOS: Pass request type to dev_pm_qos_read_value()
  PM / QoS: Add support for MIN/MAX frequency constraints
  cpufreq: Register notifiers with the PM QoS framework
  cpufreq: Add QoS requests for userspace constraints

 Documentation/power/pm_qos_interface.txt |  12 +-
 drivers/base/power/domain.c              |   8 +-
 drivers/base/power/domain_governor.c     |   4 +-
 drivers/base/power/qos.c                 | 115 +++++++++++--
 drivers/base/power/runtime.c             |   2 +-
 drivers/cpufreq/cpufreq.c                | 202 ++++++++++++++++-------
 drivers/cpuidle/governor.c               |   2 +-
 include/linux/cpufreq.h                  |  12 +-
 include/linux/pm_qos.h                   |  71 ++++++--
 9 files changed, 323 insertions(+), 105 deletions(-)

-- 
2.21.0.rc0.269.g1a574e7a288b

