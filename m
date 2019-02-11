Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8485C169C4
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 08:41:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 95CAB214DA
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 08:41:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="MlEuXla+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727073AbfBKIls (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 03:41:48 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:35411 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726530AbfBKIlr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 03:41:47 -0500
Received: by mail-pg1-f194.google.com with SMTP id s198so4660890pgs.2
        for <linux-kernel@vger.kernel.org>; Mon, 11 Feb 2019 00:41:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=6AvAaas+e705CQxvZAcdFXvJqKvDYPUuobqQ4PnARmk=;
        b=MlEuXla+b+NTAIT9O23uEXO9pz8HQbAndLudE8ffNJc30CrAq/elvxARW9K6ufpwj7
         2vIrJH5i65j1kf1fbjCa0U/hexNzonmSM7zeaOxg9SW6tdpYrC59MkC6jIXLIKclieAz
         Sk2YCMsweI8Sddfxqw7SXYg9yEIndeszB8x0LofZHv13AlhZYx8ZdeN+udv/QxcwkR4f
         UR/2yXx7WZ1WD2bH5RY00MPCwofB2xCfgsQ/aGXUx6E2B4d67/4WNv5uGpyPLutCiPcg
         J5UwSQrCBGbCIwYEogZLpgxfVpWp/sC0J8df+qXpgYb5EYwvmE9seWylvOz6HkfyZuGB
         fxCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=6AvAaas+e705CQxvZAcdFXvJqKvDYPUuobqQ4PnARmk=;
        b=glmKT64LRdIylwRYZbdQofe5hgCwtfIeHYoiiMKTlJPy7Rg43Tz7uHzhpZbNxcI+XI
         1ekPN+DzKWfMa6ujnk0u8tGkPph3XIumf1wkz2ijVFZ/FyzBsUEtTG2UWRYkIDI+Sx1P
         Vgd+dl4vGgxuJBeSaf9LK0L5jZhvSmxHFegsHYzq0jIJrytGIAmCfxdMD8LdFpxee9Ow
         FEkWdE7hyLvC1+ymrrg8gf2McgqUWhV1clbkgrUYSHpeUFGM2RCPcDvTZuuMSw0A1V0R
         Yvl5JE8HpRpMdMi5XzZx3MP67MN7tM+eZY0+UfmzeXFZjOoM17ageG3Dlsvxh8sjggVW
         CXhg==
X-Gm-Message-State: AHQUAuZc1drkL3BH7pk+TsDRAT8yCJMP+klHmVni/2LK0zNjygReqDxg
        V5/GKIGi9bf2zSR+XsYGac6JWQ==
X-Google-Smtp-Source: AHgI3IYN/NFvVWfPayVNhL0j4ROFBucT+m2cPATPHtQNX41vXzcSGreYhqeX99B3fwiNuaZY9+7ogg==
X-Received: by 2002:a63:db08:: with SMTP id e8mr13713111pgg.293.1549874506719;
        Mon, 11 Feb 2019 00:41:46 -0800 (PST)
Received: from localhost ([122.172.102.63])
        by smtp.gmail.com with ESMTPSA id k71sm18665458pga.44.2019.02.11.00.41.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 11 Feb 2019 00:41:45 -0800 (PST)
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Rafael Wysocki <rjw@rjwysocki.net>
Cc:     Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] cpufreq: Allow light-weight tear down on CPU offline
Date:   Mon, 11 Feb 2019 14:11:34 +0530
Message-Id: <cover.1549874368.git.viresh.kumar@linaro.org>
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
light weight tear-down during CPU offline operation and updates the
cpufreq-dt driver to implement the new helper.

Viresh Kumar (2):
  cpufreq: Allow light-weight tear down on CPU offline operation
  cpufreq: dt: Implement light_weight_exit() callback

 drivers/cpufreq/cpufreq-dt.c | 19 +++++++++++++++++++
 drivers/cpufreq/cpufreq.c    | 16 +++++++++++-----
 include/linux/cpufreq.h      |  1 +
 3 files changed, 31 insertions(+), 5 deletions(-)

-- 
2.20.1.321.g9e740568ce00

