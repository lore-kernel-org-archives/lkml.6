Return-Path: <SRS0=fxkz=QV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03856C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 10:46:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C605B222A4
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 10:46:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="iMtbLXiX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405310AbfBNKq2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 05:46:28 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:40480 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727954AbfBNKq1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 05:46:27 -0500
Received: by mail-pg1-f194.google.com with SMTP id z10so2872933pgp.7
        for <linux-kernel@vger.kernel.org>; Thu, 14 Feb 2019 02:46:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=aaYeH8nV1OLgBDYYMNbC3cE4BCJm7aABuoHzkKFCk5g=;
        b=iMtbLXiXXoBPvri2HV3z8WJqExe3XZs9kjSQYKNHDIIgguaJu+M2XSiN2ptuwOg1zk
         /c9SvT+1wp2Xri2zHmr6pIIHelbCMQnoH06DAObNOUD0gcm/hPzOoHqKMmt6TT18OVyo
         hCmFX3sytDE81mqgg9iVz1SeVvdlr7izfpEE8mQ6h/NMhni8f7RNkonpnkC3opwl6zUZ
         6GD6Bp2iAzNNjr/peV3ky6yFRyrdHlxRRYybGjZMZWl/SCHQxFukn01N9Wr/8Tr43UUU
         6WpeNcCdIw8UkIoA18+leJkNHSlfxsxDHQ4nY0yErla3xZAvOeNPPKUrppFTrD48qoto
         5ChQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=aaYeH8nV1OLgBDYYMNbC3cE4BCJm7aABuoHzkKFCk5g=;
        b=JVkQRYq07DgkUbseHmPXStbt6slFp82Qw+lV0pxRaXw2Yw3tHKgjTjs2s+eCpWqf1q
         z4KhQnPW1GZzaZ4RB9MwYfRmioFgVEIlpL1mRXqdib7EzUgFhk4rSZWp1h0/SQg2oYfa
         v3X4afzzAUpDn/OhB9FirF5s1lvlFeNGLBXZyX6svoe97dJUb7cB3+r2gZGgA8ZOb6wU
         hPGIrySI5kimQMxKhfg0eoLS6f9RZh5+MI1lcBEuJVbj87KkC9Bf9Jt7S7hmTMEaQZsx
         r0aijkq0VCaZgPAXl5CbwEHV1dkM2v4n8OFnt7YyIxY6VbFSibBLTwrgoZscyPrCqJhd
         dt6g==
X-Gm-Message-State: AHQUAuYFOsRW/eA8BtYEluVGH0ac8hdPHGDBHaQka9RL1sj1cEcnhIaP
        C3+n94x8wNHscfpQEd2qTR6snw==
X-Google-Smtp-Source: AHgI3IY4/1ZkelKSvbp8jSbbwio93IKO5dCJA+9THbE5EzQDK/lGDqELUOrJT62cq4Vyz17xKFKp3g==
X-Received: by 2002:a63:e10:: with SMTP id d16mr3158981pgl.148.1550141186964;
        Thu, 14 Feb 2019 02:46:26 -0800 (PST)
Received: from localhost ([122.172.102.63])
        by smtp.gmail.com with ESMTPSA id z186sm2902120pfz.119.2019.02.14.02.46.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 14 Feb 2019 02:46:25 -0800 (PST)
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Rafael Wysocki <rjw@rjwysocki.net>
Cc:     Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] cpufreq: Replace double NOT (!!) with single NOT (!)
Date:   Thu, 14 Feb 2019 16:16:21 +0530
Message-Id: <e0ea5fc21f9d3bd38eb4eb678d39359d66c8e79e.1550141092.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.21.0.rc0.269.g1a574e7a288b
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Double NOT (!!) operation is normally done to convert a non-zero value
to 1 and keep zero as is, but that isn't the requirement in this case.
All we wanted was to make sure that only one of the two routines isn't
set, i.e. either both function pointers are set or both are unset.

This can be done with a single NOT (!) operation as well.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/cpufreq/cpufreq.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
index 55e9795801a4..ad4e9991c3cc 100644
--- a/drivers/cpufreq/cpufreq.c
+++ b/drivers/cpufreq/cpufreq.c
@@ -2505,7 +2505,7 @@ int cpufreq_register_driver(struct cpufreq_driver *driver_data)
 		    driver_data->target) ||
 	     (driver_data->setpolicy && (driver_data->target_index ||
 		    driver_data->target)) ||
-	     (!!driver_data->get_intermediate != !!driver_data->target_intermediate) ||
+	     (!driver_data->get_intermediate != !driver_data->target_intermediate) ||
 	     (!driver_data->online != !driver_data->offline))
 		return -EINVAL;
 
-- 
2.21.0.rc0.269.g1a574e7a288b

