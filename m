Return-Path: <SRS0=kF4g=OX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60095C67839
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 10:15:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0764C2080F
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 10:15:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="iCYOTgFL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0764C2080F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729451AbeLNKPk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Dec 2018 05:15:40 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:32805 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728829AbeLNKPj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Dec 2018 05:15:39 -0500
Received: by mail-pl1-f195.google.com with SMTP id z23so2543267plo.0
        for <linux-kernel@vger.kernel.org>; Fri, 14 Dec 2018 02:15:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=xriaFx5+t28qBH2mZd8Es0YFEc0cKyBjyhEauROsazY=;
        b=iCYOTgFL+8VAAyBVht3+GmArRXrVh10/vUaNJvAiTsl/OGN4VHMHOpEsg6Bqam0sVp
         NYkqNvQg6589yBMufymhW74HHUXnULhQbnJqYY1XRuSFM+I2zmutdvc42oHQNVAZEwGR
         g0ZNeKAk70YSwpNO6gV1floaFXzJP4wgoxGqs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=xriaFx5+t28qBH2mZd8Es0YFEc0cKyBjyhEauROsazY=;
        b=SBGu/2O9JSUAhpdSWJXNpdibI79Lw1tCp37qCJq4XhWrzKkvjOJKMpbuYgp9H13o8B
         dOtTvpH7TGXGew/ABvPUu++xjhRDpKIlHNShrGznOgvPc8WhgcPrs0KHuSP8zYaZHpdG
         nZLn6aXY1LOQfjHLv/dKoXFnlQmAKvG77152KcQ2zkbO+1PiJ4qrhkxBRLHFtvpFkFy+
         xgD0Jvg68ZZUdxlfB3uwd3pYmoQY9xovACf/dybWNCL3Kxvj5kz51OJMERXDayUqr5R/
         LEq2XSfyug1iXngyHsTFBmPLWAs4ON1Zvur2XdYGKJt8fEcYcpN8iF1Rht5gVCON5SvW
         BUqA==
X-Gm-Message-State: AA+aEWY9OWygtqXKP7lMkaCm9upByb+vUQnFDJ3nCMJgVuHk8UcpTXyM
        xV1G+JjaXkAurahxh0oBBQp4hA==
X-Google-Smtp-Source: AFSGD/WgXRx3P27+6lYqfmpRTbX9ptTaEN90H5mwVv3/DwEDOXl4LrJs0+VMhN/pMM7JH2hYii5UTA==
X-Received: by 2002:a17:902:1126:: with SMTP id d35mr2154387pla.1.1544782538867;
        Fri, 14 Dec 2018 02:15:38 -0800 (PST)
Received: from localhost ([122.172.23.29])
        by smtp.gmail.com with ESMTPSA id g190sm5104829pgc.28.2018.12.14.02.15.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 14 Dec 2018 02:15:37 -0800 (PST)
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     ulf.hansson@linaro.org, Rafael Wysocki <rjw@rjwysocki.net>,
        Kevin Hilman <khilman@kernel.org>,
        Len Brown <len.brown@intel.com>, Nishanth Menon <nm@ti.com>,
        Pavel Machek <pavel@ucw.cz>, Stephen Boyd <sboyd@kernel.org>,
        Viresh Kumar <vireshk@kernel.org>
Cc:     Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        rnayak@codeaurora.org, niklas.cassel@linaro.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH V4 0/7] PM / Domains: Allow performance state propagation
Date:   Fri, 14 Dec 2018 15:45:26 +0530
Message-Id: <cover.1544782279.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.19.1.568.g152ad8e3369a
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This series adds performance state propagation support in genpd core.
The propagation happens from the sub-domains to their masters. More
details can be found in the individual commit logs.

This is tested on hikey960 by faking power domains in such a way that
the CPU devices have two power domains and both of them have the same
master domain. The CPU device, as well as its power domains have
"required-opps" property set and the performance requirement from the
CPU eventually configures all the domains (2 sub-domains and 1 master).

Based on opp/linux-next branch (which is 4.20-rc1 +
multiple-power-domain-support-in-opp-core + some OPP fixes).

Rajendra has already tested the previous version of this series and so I
have included his Tested-by for all patches.

V3->V4:
- dev_pm_opp_xlate_performance_state() returns negative values on error
  now.
- of_get_required_opp_performance_state() is also updated to do the
  same.
- _genpd_set_performance_state() is not called anymore from
  _genpd_reeval_performance_state() and we get rid of the extra
  declaration.
- Improved commit log in the last patch.
- dropped an unlikely.

V2->V3:
- Include Ulf's patch (sent separately earlier) with this series.
- The performance state update code doesn't rely anymore on the power
  on/off state of the genpd, it sets and propagates rate in all cases.
- That simplified a lot of code from V2 in _genpd_power_on().
- commit logs improved for few commits.
- s/mstate/master_state/
- and few more minor changes.

v1->V2:
- First patch (1/5) is new and an improvement to earlier stuff.
- Move genpd_status_on() check to _genpd_reeval_performance_state() from
  _genpd_set_performance_state().
- Improve dev_pm_opp_xlate_performance_state() to handle 1:1 pstate
  mapping between genpd and its master and also to fix a problem while
  finding the dst_table.
- Handle pstate=0 case properly.

--
viresh

Ulf Hansson (1):
  PM / Domains: Make genpd performance states orthogonal to the
    idlestates

Viresh Kumar (6):
  OPP: Improve _find_table_of_opp_np()
  OPP: Add dev_pm_opp_xlate_performance_state() helper
  OPP: Don't return 0 on error from
    of_get_required_opp_performance_state()
  PM / Domains: Save OPP table pointer in genpd
  PM / Domains: Factorize dev_pm_genpd_set_performance_state()
  PM / Domains: Propagate performance state updates

 drivers/base/power/domain.c | 202 ++++++++++++++++++++++++++----------
 drivers/opp/core.c          |  63 +++++++++++
 drivers/opp/of.c            |  24 +++--
 include/linux/pm_domain.h   |   6 ++
 include/linux/pm_opp.h      |  13 ++-
 5 files changed, 242 insertions(+), 66 deletions(-)

-- 
2.19.1.568.g152ad8e3369a

