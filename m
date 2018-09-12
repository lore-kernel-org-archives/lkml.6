Return-Path: <SRS0=BZo9=L2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA7D9C4646A
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 08:29:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 771F620866
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 08:29:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="Hkddc2GP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 771F620866
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727770AbeILNdO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Sep 2018 09:33:14 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:42860 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726552AbeILNdO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Sep 2018 09:33:14 -0400
Received: by mail-pl1-f196.google.com with SMTP id g23-v6so618259plq.9
        for <linux-kernel@vger.kernel.org>; Wed, 12 Sep 2018 01:29:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=+OmOlv50znc2tgHYJkRyI/UDE2I0tRf5T900X5bNP9A=;
        b=Hkddc2GPFBgqNXe25RLszXjOCkWhh39MV/uIK+libyf+2PiTX8Tv83xlV8f4KE++hy
         mFsz5zsPuNv9qaknsyQu2vc9TJxOyqMTv4G0/GuWnFXLEfA1eoZ6HdXgqPeYVcFe6RDG
         XPsbPBpVtrzcEzID+tjXCuFW2o27bGo7o7W/k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=+OmOlv50znc2tgHYJkRyI/UDE2I0tRf5T900X5bNP9A=;
        b=QX8T9wcQXCiA9G/vdtpwX6XNRryChPexdKjt8j4SKfPoLopR5i0YkQEGhvzy4AfrUX
         jygzrG2s3C5TU72QjCnPD/CNTuvVdJs+P4H4gjclY3tIlv6qwgqbcg0TcfcL3huqRxLp
         jxH3ZO/0XzTnvXFJt8mQU73ZFDkohbO0jO/ckHDcvR103tVxw0ViIVYdLY6OV5QpBG8N
         xFsgwg8WxYbNOJ6WtQgaSTcwSl4t+NE3Ddr/GvOhnq6tcDvUVvUx8hdGdQq7SWPJLINF
         0RsEIaiWjAyQgFo4CCmClWl71pxEGZFzg7uV6mPqWRO9sMRGDOX0OzkBhzg9hecxpwmR
         gFAA==
X-Gm-Message-State: APzg51CVHvD2/TnBgRlIXSwy7Kz/cykXTOyfesd/m7k6lnwGI9yhn6/S
        jSUkDYZg8ZlCNzhdIYWFB5+clA==
X-Google-Smtp-Source: ANB0VdYJqtfBY91TM0dX8B+b/jeNZQIaiOGXRvWI7one9MT1RMiE1cHpQpta7758x7zvDv69r31W7Q==
X-Received: by 2002:a17:902:aa49:: with SMTP id c9-v6mr855934plr.195.1536740986604;
        Wed, 12 Sep 2018 01:29:46 -0700 (PDT)
Received: from localhost ([122.171.64.45])
        by smtp.gmail.com with ESMTPSA id w81-v6sm977560pfk.92.2018.09.12.01.29.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 12 Sep 2018 01:29:45 -0700 (PDT)
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     niklas.cassel@linaro.org, Andrew Lunn <andrew@lunn.ch>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Jason Cooper <jason@lakedaemon.net>,
        Nishanth Menon <nm@ti.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Viresh Kumar <vireshk@kernel.org>
Cc:     Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        "4.18" <stable@vger.kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 00/11] OPP: Don't create multiple OPP tables for devices sharing OPP table
Date:   Wed, 12 Sep 2018 13:58:39 +0530
Message-Id: <cover.1536736872.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.18.0.rc1.242.g61856ae69a2c
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

Niklas Cassle recently reported some regressions with his Qcom cpufreq
driver where he was getting some errors while creating the OPPs tables.

After looking into it I realized that the OPP core incorrectly creates
multiple OPP tables for the devices even if they are sharing the OPP
table in DT. This happens when the request comes using different CPU
devices. For example, dev_pm_opp_set_supported_hw() getting called using
CPU0 and dev_pm_opp_of_add_table() getting called using CPU1.

This series redesigns the internals of the OPP core to fix that. The
redesign has simplified the core itself though.

@Niklas: Can you please confirm that this series fixes the issues you
have reported ? I have already tested it on Hikey960.

--
viresh

Viresh Kumar (11):
  OPP: Free OPP table properly on performance state irregularities
  OPP: Protect dev_list with opp_table lock
  OPP: Pass index to _of_init_opp_table()
  OPP: Parse OPP table's DT properties from _of_init_opp_table()
  OPP: Don't take OPP table's kref for static OPPs
  OPP: Create separate kref for static OPPs list
  cpufreq: mvebu: Remove OPPs using dev_pm_opp_remove()
  OPP: Don't remove dynamic OPPs from _dev_pm_opp_remove_table()
  OPP: Use a single mechanism to free the OPP table
  OPP: Prevent creating multiple OPP tables for devices sharing OPP
    nodes
  OPP: Pass OPP table to _of_add_opp_table_v{1|2}()

 drivers/cpufreq/mvebu-cpufreq.c |   9 +-
 drivers/opp/core.c              | 147 ++++++++++++++++---------
 drivers/opp/cpu.c               |  11 +-
 drivers/opp/of.c                | 186 +++++++++++++++++---------------
 drivers/opp/opp.h               |  19 ++--
 include/linux/pm_opp.h          |   6 ++
 6 files changed, 221 insertions(+), 157 deletions(-)

-- 
2.18.0.rc1.242.g61856ae69a2c

