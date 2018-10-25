Return-Path: <SRS0=k9B+=NF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC2D6C46475
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 05:53:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 599A020831
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 05:53:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="V7Src/0/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 599A020831
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727199AbeJYOY0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Oct 2018 10:24:26 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:40333 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726652AbeJYOY0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Oct 2018 10:24:26 -0400
Received: by mail-pl1-f193.google.com with SMTP id b9-v6so3024217pls.7
        for <linux-kernel@vger.kernel.org>; Wed, 24 Oct 2018 22:53:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Tzyi/ZGPplqRmySLR5Ad2qLNX4GQSjbXCHd3ssSxWeE=;
        b=V7Src/0/TBHZBBC2eNOYWhLGf65tST2WcKGTKD4+UsOc3sRKSDgbKrRHpnOHbW3pzt
         hjRF2UsTf7j16UD9jQ+Trmp3Qbr0Z9VU++e4PKVWrDWhV2ruRempaheDab/dG2VDCI90
         nyW5YYwNOU9HJ/jIR6I4qst1gx3/IGdSL/FSk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Tzyi/ZGPplqRmySLR5Ad2qLNX4GQSjbXCHd3ssSxWeE=;
        b=LzwORJXlzwAAZV1TqYsKldoLvuZuOp1GY4IfmviaVYBcEy1UCCbhqxU1Z/bH7sIdg+
         B17kjBeZ1RwDTzzyl58WQ29zezORUFQmm6Y7ylyHwNCSSriTeClVjxIh4dhyhqStTEhO
         lwIexcz9ABjFmPBfKtkQTM3yPM6aCktIpfbRaRByaYJzpjXiwN2KssLIwG1uAvmP0mAW
         raVsVpiuraVBC2+SPN5vYxnMXI4IIFjj8A5987QL5a3NAp+Sq9691H4v8ksmBTDKDou1
         89ChYdM90SUYVOJ7nlIUvR7ERYwJ0sou7VVchyKWzt+HQNnXDooqtrz36nqQu3lx8f7N
         9tvQ==
X-Gm-Message-State: AGRZ1gIKqvPjDqljCYtzTKI+b8RblPUodtDzfaT8X73r51m4Y7PyV0B1
        EcjAXeHXVdIHcYyhbS/24jw9eA==
X-Google-Smtp-Source: AJdET5eL3SojRQHSZ25pFl9gCEyRG0qOWarST9ECNlqTqAUF1oIjZE6abc/FOhBU5gNiwmf/vhN+0A==
X-Received: by 2002:a17:902:b03:: with SMTP id 3-v6mr187573plq.141.1540446795558;
        Wed, 24 Oct 2018 22:53:15 -0700 (PDT)
Received: from localhost ([122.172.217.9])
        by smtp.gmail.com with ESMTPSA id y8-v6sm18558016pfd.168.2018.10.24.22.53.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 24 Oct 2018 22:53:14 -0700 (PDT)
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     ulf.hansson@linaro.org, Kevin Hilman <khilman@kernel.org>,
        Len Brown <len.brown@intel.com>, Nishanth Menon <nm@ti.com>,
        Pavel Machek <pavel@ucw.cz>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Stephen Boyd <sboyd@kernel.org>,
        Viresh Kumar <vireshk@kernel.org>
Cc:     Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        niklas.cassel@linaro.org, rnayak@codeaurora.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH V3 00/10] OPP: Support multiple power-domains per device
Date:   Thu, 25 Oct 2018 11:22:37 +0530
Message-Id: <cover.1540446493.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.19.1.568.g152ad8e3369a
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

This series improves the OPP core (and a bit of genpd core as well) to
support multiple phandles in the "required-opps" property, which are
only used for multiple power-domains per device for now.

We still don't propagate the changes to master domains for the
sub-domains, but this patchset is an important stepping stone for that
to happen.

Tested on Hikey960 after faking some power domains for CPUs.

V2->V3:
- Gained an additional patch to properly name the virtual device (1/10)
- Renamed the virtual device as virt_dev instead of genpd_dev.
- Few helpers renamed as well accordingly.
- Use container_of() instead of traversing list of genpd.
- Included tags received from Ulf.

V1->V2:
- Had a discussion at Linaro connect with Ulf regarding the changes V1
  did in the genpd core and what his objections are to them. Based on
  his suggestions many changes are made.
- The OPP core still needs the virtual device pointers to set the
  performance state for multiple domains, but the genpd core doesn't
  provide them automatically to the OPP core. One of the reasons behind
  this is to give more power to the consumer drivers which may not want
  to enable all the genpds at once.
- The consumer drivers would now need to call the APIs
  dev_pm_opp_{set|put}_genpd_device() in order to set/reset these
  virtual device pointers.
- More locking is put in place to protect the genpd device pointers in
  OPP core.
- Reorg of the code at many places to make code less redundant.

--
viresh

Viresh Kumar (10):
  PM / Domains: Rename genpd virtual devices as virt_dev
  OPP: Identify and mark genpd OPP tables
  OPP: Separate out custom OPP handler specific code
  OPP: Populate required opp tables from "required-opps" property
  OPP: Populate OPPs from "required-opps" property
  PM / Domains: Add genpd_opp_to_performance_state()
  OPP: Add dev_pm_opp_{set|put}_genpd_virt_dev() helper
  OPP: Configure all required OPPs
  OPP: Rename and relocate of_genpd_opp_to_performance_state()
  OPP: Remove of_dev_pm_opp_find_required_opp()

 drivers/base/power/domain.c |  70 ++++----
 drivers/opp/core.c          | 261 ++++++++++++++++++++++--------
 drivers/opp/of.c            | 313 +++++++++++++++++++++++++++++++-----
 drivers/opp/opp.h           |  20 +++
 include/linux/pm_domain.h   |   8 +-
 include/linux/pm_opp.h      |  16 +-
 6 files changed, 526 insertions(+), 162 deletions(-)

-- 
2.19.1.568.g152ad8e3369a

