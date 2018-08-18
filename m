Return-Path: <SRS0=Se0q=LB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99F0CC4321D
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Aug 2018 18:16:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 63EA421746
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Aug 2018 18:16:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 63EA421746
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726399AbeHRVYc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 18 Aug 2018 17:24:32 -0400
Received: from mga06.intel.com ([134.134.136.31]:31121 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726219AbeHRVYc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Aug 2018 17:24:32 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 18 Aug 2018 11:15:58 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.53,257,1531810800"; 
   d="scan'208";a="81415494"
Received: from anshuma1-pnp-server.iind.intel.com ([10.223.107.119])
  by fmsmga004.fm.intel.com with ESMTP; 18 Aug 2018 11:14:07 -0700
From:   Anshuman Gupta <anshuman.gupta@intel.com>
To:     puneethx.prabhu@intel.com, lgirdwood@gmail.com, broonie@kernel.org,
        perex@perex.cz, rafael@kernel.org
Cc:     alsa-devel@alsa-project.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, anshuman.gupta@intel.com
Subject: [PATCH v2 0/1] cover-letter hdac-codec runtime suspended at PM:Suspend.
Date:   Sat, 18 Aug 2018 23:42:02 +0530
Message-Id: <1534615923-8541-1-git-send-email-anshuman.gupta@intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <CAJZ5v0hyk=jto8Wt0er==YmKEsgvfvZhO2wDbGOhxZaWWCNgBg@mail.gmail.com>
References: <CAJZ5v0hyk=jto8Wt0er==YmKEsgvfvZhO2wDbGOhxZaWWCNgBg@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Current implementation of hdac hdmi codec driver uses its
suspend/resume operation callback in its prepare/complete callback
which has issues with hdac direct-complete, it has been reviewed earlier
that hdac hdmi codec driver requires a rework
(https://patchwork.kernel.org/patch/10276021/),
but as there is no rework with driver, it require to fix hdac direct complete
issue to leverage hdac direct complete in order to optimize its resume latency
while resuming from system wide suspend.

Anshuman Gupta (1):
  hdac-codec runtime suspended at PM:Suspend.

 sound/soc/codecs/hdac_hdmi.c | 6 ++++++
 1 file changed, 6 insertions(+)

-- 
2.7.4

