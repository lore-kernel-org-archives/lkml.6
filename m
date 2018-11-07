Return-Path: <SRS0=alsP=NS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4B32C46464
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 17:10:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A5BA12081D
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 17:10:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="IhLNADSL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A5BA12081D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=partner.samsung.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731489AbeKHClm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Nov 2018 21:41:42 -0500
Received: from mailout1.w1.samsung.com ([210.118.77.11]:54753 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727870AbeKHCll (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Nov 2018 21:41:41 -0500
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20181107171023euoutp01c58bc775ba2e32416df613347ea81094~k5rHPmF-f2204222042euoutp01o
        for <linux-kernel@vger.kernel.org>; Wed,  7 Nov 2018 17:10:23 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20181107171023euoutp01c58bc775ba2e32416df613347ea81094~k5rHPmF-f2204222042euoutp01o
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1541610623;
        bh=2Tl0v8vgsqcXWABbqtUZLHvnuhXk5TvAkw69FGiEAx4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=IhLNADSLmnKSS25qDx344zLpTZkkl4ttN64971mrLFbui70oEQ/UiSKNLUknYCy0+
         rl3Khze1aK1R/hE2yPhhmzkAyzXF8D8bfUseW1enPu1v/MtyQSsR2Abmcov/IvN4ha
         JQtZD7aaFQt1a9GA0rpiLXV80xe/rf5fi1JLW9o4=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20181107171023eucas1p293080dfae19c271a1748c8e22337a83b~k5rGlNAqo2800128001eucas1p2E;
        Wed,  7 Nov 2018 17:10:23 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id 9C.54.04294.E7C13EB5; Wed,  7
        Nov 2018 17:10:22 +0000 (GMT)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20181107171022eucas1p1c2431f0561d9b1357ab569ab77deca34~k5rFs8C421069210692eucas1p1Z;
        Wed,  7 Nov 2018 17:10:22 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20181107171021eusmtrp1a8b28f2c742779585f4cd72f7ba758b6~k5rFhCzhn2472724727eusmtrp1X;
        Wed,  7 Nov 2018 17:10:21 +0000 (GMT)
X-AuditID: cbfec7f4-84fff700000010c6-99-5be31c7eeb5a
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 71.23.04128.D7C13EB5; Wed,  7
        Nov 2018 17:10:21 +0000 (GMT)
Received: from AMDC3778.DIGITAL.local (unknown [106.120.51.20]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20181107171021eusmtip2597dad7f16cad0654585ff41af166db2~k5rE_fk-I0120301203eusmtip2d;
        Wed,  7 Nov 2018 17:10:21 +0000 (GMT)
From:   Lukasz Luba <l.luba@partner.samsung.com>
To:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org
Cc:     rui.zhang@intel.com, edubezval@gmail.com,
        daniel.lezcano@linaro.org, robh+dt@kernel.org,
        mark.rutland@arm.com, corbet@lwn.net, b.zolnierkie@samsung.com,
        krzk@kernel.org, Lukasz Luba <l.luba@partner.samsung.com>
Subject: [PATCH v2 01/11] thermal: remove unused function parameter
Date:   Wed,  7 Nov 2018 18:09:43 +0100
Message-Id: <1541610593-28542-2-git-send-email-l.luba@partner.samsung.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1541610593-28542-1-git-send-email-l.luba@partner.samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA0WSWUwTURSGuZ1OO1SLYyFyRJakEYMkLBowE1GDyMNENOFBX+gDVpmwyNph
        V6FEyxYgIgYQlYqFALUEqGURgbAFAihLMKAsCZsRNQVNiZFEQMqAvn3/f875z8nNJTBJE25H
        hEfHM4poeaRUIOI392+MuqXZL8k8l7fcqMbSepxa7spCVLnJgVL3jeCU+sMkTo2ONgipaaU9
        pV/aURWZlXxqou2ZgDLl9yGqamqcR6k6+oTU8kKBwNeK1pXrEP2mbE5Ia9q/8mi9NkdAz062
        C+jXlem0pqAIp7tX23l0gUGLaJPeMVAUJDoXwkSGJzIKjws3RGHv1EZh7GdR8mBzhVCJHljm
        IksCSC8orKrDcpGIkJA1CIZ1K0JOrCOYN2p4nDAhMGhasP2RmSIj4grVCNStI+jfyGLnxs48
        QQhId2jVxpl9G/IpAlOnZjcXI2cRDD3W7EZZk5eg5nsJMjOfdIYvszO4mcXkZdhWvd1b5wif
        RnJ22ZIMgPIJ424QkP1CGNooxbkmf8hbmEIcW8O3AYOQY3sYLsrjc8zC+2ytgOO7kDXYutfj
        A70D47j5aow8CfVtHpx9Ecb1ap7ZBtIKPhoPm21sBx81l2CcLYbsTAnX7QKGvDEex0egWle8
        F05DRXPd3pOWI7j/8xf+EDmV/V/2AiEtsmUS2KhQhj0dzSS5s/IoNiE61P1WTJQe7Xym4a2B
        9VbU9udmDyIJJD0oHmtakElweSKbEtWDgMCkNuL8V4syiThEnpLKKGKCFQmRDNuDjhF8qa34
        jsW8TEKGyuOZ2wwTyyj2qzzC0k6JMu4lGrxzk2x4hUcLbavOKqQWYuXx8CcBeX5BL3v9ak8U
        zAV2xIsPlaitlF3tGXCtMS1g2inVsDbecL7Y67mzdW3++oprpecPf1ltHD9xUJWUQLlc3Vxi
        3GYi+AtrS+mrnWW+1w/8To7vbjmTuRkhUfmQ3uFN23VXyqa3gx1cVVI+GyY/5YopWPlfknhq
        vEgDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprGIsWRmVeSWpSXmKPExsVy+t/xe7q1Mo+jDToPW1lsnLGe1eLJgXZG
        i3mfZS3mHznHajH/yjVWi/PnN7Bb3GqQsdj0GMhb2LaExeLyrjlsFp97jzBaLL1+kcmide8R
        dosnD/vYHPg81sxbw+ixc9Zddo/Fe14yeWxa1cnmcefaHjaPzUvqPRb3TWb1OPhuD5NH35ZV
        jB6fN8kFcEXp2RTll5akKmTkF5fYKkUbWhjpGVpa6BmZWOoZGpvHWhmZKunb2aSk5mSWpRbp
        2yXoZZyZ/5a94ClXxcltC9kbGFs4uxg5OSQETCRuT37L2MXIxSEksJRR4uD7xUwQCTGJSfu2
        s0PYwhJ/rnWxgdhCAp8YJb53eHUxcnCwCehJ7FhVCNIrIjCfUeLopstsIA6zwDNGiZXTX4IN
        EhZwlljxejojiM0ioCrx/M5tVhCbV8BL4n/rbmaIBXISN891gtmcAt4S8y6/ZYdY5iXxfdZ6
        tgmMfAsYGVYxiqSWFuem5xYb6RUn5haX5qXrJefnbmIExsm2Yz+37GDsehd8iFGAg1GJh1dj
        x8NoIdbEsuLK3EOMEhzMSiK8vasfRQvxpiRWVqUW5ccXleakFh9iNAU6aiKzlGhyPjCG80ri
        DU0NzS0sDc2NzY3NLJTEec8bVEYJCaQnlqRmp6YWpBbB9DFxcEo1MHowTz2Z11Gz73nh/bmG
        VYaTcvI6LqksSF5u3HOl89Hz5iSmenuXp+o+jYkyRoyRV9ieCnGZRBzaGa9Une7KtzQppXjh
        uh3v7x/7WL5S3HruF5uFWh28D8ysnv+rTN1il7H4ve/idbkT+nlcmF/GBy0/4pSgVnk2+ZzP
        SwZh9po/f6Kb9lyMUmIpzkg01GIuKk4EAKU767OpAgAA
X-CMS-MailID: 20181107171022eucas1p1c2431f0561d9b1357ab569ab77deca34
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20181107171022eucas1p1c2431f0561d9b1357ab569ab77deca34
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20181107171022eucas1p1c2431f0561d9b1357ab569ab77deca34
References: <1541610593-28542-1-git-send-email-l.luba@partner.samsung.com>
        <CGME20181107171022eucas1p1c2431f0561d9b1357ab569ab77deca34@eucas1p1.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Clean unused parameter from internal framework function.

Cc: Zhang Rui <rui.zhang@intel.com>
Cc: Eduardo Valentin <edubezval@gmail.com>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
Signed-off-by: Lukasz Luba <l.luba@partner.samsung.com>
---
 drivers/thermal/thermal_core.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_core.c
index d6ebc1c..39fc812 100644
--- a/drivers/thermal/thermal_core.c
+++ b/drivers/thermal/thermal_core.c
@@ -315,9 +315,7 @@ static void monitor_thermal_zone(struct thermal_zone_device *tz)
 	mutex_unlock(&tz->lock);
 }
 
-static void handle_non_critical_trips(struct thermal_zone_device *tz,
-				      int trip,
-				      enum thermal_trip_type trip_type)
+static void handle_non_critical_trips(struct thermal_zone_device *tz, int trip)
 {
 	tz->governor ? tz->governor->throttle(tz, trip) :
 		       def_governor->throttle(tz, trip);
@@ -418,7 +416,7 @@ static void handle_thermal_trip(struct thermal_zone_device *tz, int trip)
 	if (type == THERMAL_TRIP_CRITICAL || type == THERMAL_TRIP_HOT)
 		handle_critical_trips(tz, trip, type);
 	else
-		handle_non_critical_trips(tz, trip, type);
+		handle_non_critical_trips(tz, trip);
 	/*
 	 * Alright, we handled this trip successfully.
 	 * So, start monitoring again.
-- 
2.7.4

