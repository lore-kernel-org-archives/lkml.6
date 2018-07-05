Return-Path: <SRS0=71UW=JV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6025FC6778C
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 05:09:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 097F624069
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 05:09:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="K038HPgm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 097F624069
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752681AbeGEFJb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Jul 2018 01:09:31 -0400
Received: from mail-pf0-f196.google.com ([209.85.192.196]:40851 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751447AbeGEFJ3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jul 2018 01:09:29 -0400
Received: by mail-pf0-f196.google.com with SMTP id z24-v6so4327860pfe.7
        for <linux-kernel@vger.kernel.org>; Wed, 04 Jul 2018 22:09:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=xLLATyV3z36fvf4EY9Ds/QzGWUzJlAyW96zbGUyV69o=;
        b=K038HPgmmfADJ3eGsb90Cwqd1N1KjV859lkmEncUOobhYeBw2g5qloLw39kU/WCPbQ
         e+Fc4FFaTpBDsqPW6vsHzKKUgrruPlGN8x2rUr+wf2VqeFman68mqzNf28H8chbZv7tu
         uD1MdO0YBscg04jxXxVsNNmZ2C6ci/SauDt0M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=xLLATyV3z36fvf4EY9Ds/QzGWUzJlAyW96zbGUyV69o=;
        b=ValT2v+k3g+NxZOp8fJFzPWpV+aDlSg40CWYivq3DsprzDIazOooiOmB+OoCp5UG17
         tUWqymY36cVfSsCOwmkjRz1ZhogRJ/lmjrTWEG4jMZAgGkGYdl9Y/Z0d8pQBJTdR50NQ
         Oq0ESXu7xqVSqfGGK532Iq7DDV6azEjoi9fUANBd0HAO2bH3uj0cwwM4csr+XaFUbEHD
         AoC8K4Vzasx9jw5UYR9qU7CtHyzMFEgwVYdgVOIGhDxOIk/JYaCWB1bmfs35qBVQm0/0
         XvaQYKHGc9mJeZqDehbqaRWLebvUy+F2kVCI9Be/1wfBwdB2zqFDj+kPXrhpuMyuF8PQ
         HJ9w==
X-Gm-Message-State: APt69E11LLmhzPbn+6uAb5FTWvCtO1m8XjCc1OMuuYRsBtgWPdsmG7+w
        3J+6D7w0S9Tsqj01DT4Gwi02Jg==
X-Google-Smtp-Source: AAOMgpdkOcMQa1s846xrCH6xLNsVoeumqUpd/lozVD5o4A6E8ebp3SFz3CvcBtSYYraPgxXxHFab4A==
X-Received: by 2002:a65:6086:: with SMTP id t6-v6mr4246603pgu.424.1530767368454;
        Wed, 04 Jul 2018 22:09:28 -0700 (PDT)
Received: from localhost ([122.172.117.17])
        by smtp.gmail.com with ESMTPSA id r87-v6sm3899972pfb.1.2018.07.04.22.09.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 04 Jul 2018 22:09:27 -0700 (PDT)
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Zhang Rui <rui.zhang@intel.com>,
        Eduardo Valentin <edubezval@gmail.com>, robh@kernel.org,
        Wei Xu <xuwei5@hisilicon.com>
Cc:     Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        devicetree@vger.kernel.org, olof@lixom.net,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] dt: thermal: Fix broken cooling-maps
Date:   Thu,  5 Jul 2018 10:39:22 +0530
Message-Id: <cover.1530766981.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.18.0.rc1.242.g61856ae69a2c
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This is an attempt to fix the broken or partially defined DT bindings
for cooling-maps. We should list every device that participates in
cooling down at a certain trip point, instead of just the first in the
list as that depends on certain ordering of events to work properly.

The first patch extends the binding to allow a list of phandles in
"cooling-device" property and the second patch fixes one of the
platform's DT.

This will be followed up by fixing all platform DT bindings that have
these issues after this set is accepted.

The kernel also requires some changes to handle the phandle list, but
wouldn't break with these changes as it reads the first phandle in the
list for now. We can update that separately.

--
viresh

Viresh Kumar (2):
  dt-bindings: thermal: Allow multiple devices to share cooling map
  arm64: dts: hi6220: Add all CPUs in cooling maps

 Documentation/devicetree/bindings/thermal/thermal.txt | 11 +++--------
 arch/arm64/boot/dts/hisilicon/hi6220.dtsi             |  9 ++++++++-
 2 files changed, 11 insertions(+), 9 deletions(-)

-- 
2.18.0.rc1.242.g61856ae69a2c

