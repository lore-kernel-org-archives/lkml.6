Return-Path: <SRS0=SFDS=MQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CAC4C64EBC
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 04:16:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 12ABE2098A
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 04:16:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="fzLQ74N+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 12ABE2098A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727091AbeJDLIB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Oct 2018 07:08:01 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:45876 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726813AbeJDLIB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Oct 2018 07:08:01 -0400
Received: by mail-pl1-f193.google.com with SMTP id y15-v6so4480522plr.12
        for <linux-kernel@vger.kernel.org>; Wed, 03 Oct 2018 21:16:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=ShjguVtKgx8USFMbbAaUpwPgJamNI5T7sPuXtPbQDdo=;
        b=fzLQ74N+cQWSvyN+AwzO5+kk5L2TALtw6DmbvhL4DTyiCFsVIMKC+n0MDq4bl81TT8
         8MGiw9JolUQaKMVG1AaraWJByeFDxY3GOz2UbA4DTOQrMO5tlYm22FzAOb6jCPa4UrGM
         cdcmgpOpCsYPlt38ykKNX0ZWTOdvug7u4X7DQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=ShjguVtKgx8USFMbbAaUpwPgJamNI5T7sPuXtPbQDdo=;
        b=B0cJY/qOH/yThGDRdvmvwupjatpf5m9va0egUyzWI8xXL6+ntL1WuldOAc1PXqElfy
         ltqPSnSbEbOpe4uoO3yu7lkTnIzFvxDhHjaO22oNT9nE+ygmpZtJFPCx0OgWx9yJxce2
         UVStR/okgso3BuG9rDFmJI3/B5V1A3JGuK61QoJ/fKWXQB5Q/onvgXTG+ctq+JHMEgTT
         eHn3b9xEDhsCaQWiY0S62vobi16ieCCfNJEk1TPj8HVjw62Lh7FCA1zXxlE+Mkqklwz4
         xOU5PDzGrOcan7t9h5s0GJttCvfNJdq38bd5zLJgAqnlduFbBYjBL0FOEdghPN8yglCC
         6qOQ==
X-Gm-Message-State: ABuFfoh7g7iiUGEXf64ZSKkuENMF0QWOPbnwBR7c+WkIMmaD5bVPB4uL
        8eIBocAow5wSsD53iZ2mage5fhoYuys=
X-Google-Smtp-Source: ACcGV60tLUzJ6AjSjIODohjmuLNn0So6mSbzjJWPGUKNcAitaIh+jGkohc4Djz4fzrkfS9s+m1Cuhg==
X-Received: by 2002:a17:902:261:: with SMTP id 88-v6mr4705778plc.331.1538626602558;
        Wed, 03 Oct 2018 21:16:42 -0700 (PDT)
Received: from localhost ([122.172.76.11])
        by smtp.gmail.com with ESMTPSA id y8-v6sm6985153pfd.168.2018.10.03.21.16.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 03 Oct 2018 21:16:41 -0700 (PDT)
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Nishanth Menon <nm@ti.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Stephen Boyd <sboyd@kernel.org>,
        Viresh Kumar <vireshk@kernel.org>
Cc:     Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        niklas.cassel@linaro.org, d-gerlach@ti.com,
        linux-kernel@vger.kernel.org
Subject: [PATCH 0/4] OPP: Fix more bugs and improve error handling
Date:   Thu,  4 Oct 2018 09:46:19 +0530
Message-Id: <cover.1538625101.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.18.0.rc1.242.g61856ae69a2c
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

Few more bugs have surfaced recently, few of which have been there
forever but came to light only after the recent changes in OPP core.

Dave already sent fix for one of them sometime back and as he isn't
around for a week, I picked up the patch, modified it and posting V2 of
it here.

Niklas already helped testing two of these on Qcom hardware where he
originally faced the issues.

--
Viresh

Dave Gerlach (1):
  PM / OPP: _of_add_opp_table_v2(): increment count only if OPP is added

Viresh Kumar (3):
  OPP: Improve error handling in dev_pm_opp_of_cpumask_add_table()
  OPP: Return error on error from dev_pm_opp_get_opp_count()
  cpufreq: dt: Try freeing static OPPs only if we have added them

 drivers/cpufreq/cpufreq-dt.c | 34 +++++++++++++-----------
 drivers/opp/core.c           |  2 +-
 drivers/opp/of.c             | 51 ++++++++++++++++++++++--------------
 3 files changed, 52 insertions(+), 35 deletions(-)

-- 
2.18.0.rc1.242.g61856ae69a2c

