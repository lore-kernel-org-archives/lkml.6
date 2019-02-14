Return-Path: <SRS0=fxkz=QV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACB73C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 01:31:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7C264222A1
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 01:31:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="FBL3q63Q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731575AbfBNBay (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 20:30:54 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:40078 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729558AbfBNBay (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 20:30:54 -0500
Received: by mail-pl1-f193.google.com with SMTP id bj4so2180158plb.7
        for <linux-kernel@vger.kernel.org>; Wed, 13 Feb 2019 17:30:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=oKV2+FrnhAHG8HfwAGfe/E7DaHLqiHL+qRM6QpM+8gE=;
        b=FBL3q63QX18QiYlcwkSrZVHEtt8kEQjnz1+ae05xjPlio+P/956cf7nAVzsr5C1R43
         ZDFbO92Ck4BzCqk+ERDY+RySjDdXFEgHJEP9UzjOqMwxZnoKGHid1iUukW65kXZkk6xi
         Ep+QOh3Of6EHzFBjfZYp1Q3+1pTbQ/Z/4oXnc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=oKV2+FrnhAHG8HfwAGfe/E7DaHLqiHL+qRM6QpM+8gE=;
        b=KUCJL+4PSqyJ5+IsVhS9XDgm5Or8cGBsllkRUTj/2pbOUhNdi0U8KjhPp1PQXL9dk7
         BIr8xnRzs+B0zX8MoVPu1REH05jYoRsQ2mu+pmtU5AaYPYd3T2dK9EiwOk/q4KNN6WI4
         9KeZXXHxa5nnifvJ2P6in3aBCkCB9a1mDPhzPv/P+SAcoxN6ym2gZpxKzwj91G1RNTep
         eiAOuyZ1wt4ifPihTbfjQaGrmfImZM9lBe1UptDj73lE0k7HXaNHLzcOLZJTaEsKOMrW
         I5kTDU6xCZ863yZzd9v37S9digqEW33BnR8UC3f+HEN0ljXFg3mn50sXjYDmyXs9eG15
         aPdQ==
X-Gm-Message-State: AHQUAuZrAbaw16b6PIa+Tmu841fTnE7W+/oEPrhxCdss/dMrd3l1Bfpy
        7F6zmpHZ7F6PtZG8qNv7sjhjhA==
X-Google-Smtp-Source: AHgI3IZJOAUNsUKFnq/K/WnvOtQf1XknnWWRhYXaS+GAejypGn2/jU9ApYIMx/1eJOMg3raEJ0ipxQ==
X-Received: by 2002:a17:902:209:: with SMTP id 9mr1339679plc.288.1550107853302;
        Wed, 13 Feb 2019 17:30:53 -0800 (PST)
Received: from mka.mtv.corp.google.com ([2620:15c:202:1:75a:3f6e:21d:9374])
        by smtp.gmail.com with ESMTPSA id p64sm811072pfi.56.2019.02.13.17.30.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 13 Feb 2019 17:30:52 -0800 (PST)
From:   Matthias Kaehlcke <mka@chromium.org>
To:     MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-tegra@vger.kernel.org,
        Lukasz Luba <l.luba@partner.samsung.com>
Cc:     Matthias Kaehlcke <mka@chromium.org>
Subject: [PATCH 0/4] PM / devfreq: Refactor load monitoring
Date:   Wed, 13 Feb 2019 17:30:38 -0800
Message-Id: <20190214013042.254790-1-mka@chromium.org>
X-Mailer: git-send-email 2.20.1.791.gb4d0f1c61a-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The devfreq core currently expects governors to call specific load
monitor functions on certain DEVFREQ_GOV_ events. Since the devfreq
core itself invokes the event handler it can as well call the
corresponding load monitor functions itself. This series refactors
the code to do this for DEVFREQ_GOV_START/STOP/SUSPEND and RESUME.

In the process it also moves some repeated code involved in starting
and stopping the governor into helper functions.


Unfortunately I could only do limited testing of this series with a 4.19
kernel and few rather inactive devfreq devices. In this sense additional
testing would be appreciated.

Thanks

Matthias


Matthias Kaehlcke (4):
  PM / devfreq: Track overall load monitor state instead of
    'stop_polling'
  PM / devfreq: Handle monitor suspend/resume in the devfreq core
  PM / devfreq: Add devfreq_governor_start/stop()
  PM / devfreq: Handle monitor start/stop in the devfreq core

 drivers/devfreq/devfreq.c                 | 185 +++++++++++++---------
 drivers/devfreq/governor.h                |   4 -
 drivers/devfreq/governor_simpleondemand.c |  16 --
 drivers/devfreq/tegra-devfreq.c           |   4 -
 include/linux/devfreq.h                   |   4 +-
 5 files changed, 111 insertions(+), 102 deletions(-)

-- 
2.20.1.791.gb4d0f1c61a-goog

