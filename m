Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C330C04EB8
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 19:22:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1264B20892
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 19:22:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c1yEoU33"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1264B20892
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726038AbeLFTWj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Dec 2018 14:22:39 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:45452 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725921AbeLFTWj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Dec 2018 14:22:39 -0500
Received: by mail-pl1-f195.google.com with SMTP id a14so600790plm.12;
        Thu, 06 Dec 2018 11:22:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id;
        bh=j3mRgxWICIf6/mjeVkmbS8iYLT86SrKGS/9bb0CeWeY=;
        b=c1yEoU33QNFQtV9vvRBYrnFpD9lzaZz4hz0uKMxocPSYaFC1Fh4MVng9okF2A5BvR7
         MHw217NSf3H1bgvpETWKeqKRavpUKwl6wZ+Sn+FLPZcciZm2nPQtF6iAuI80AilwdYWP
         /JIG+08Ve5YJJxBCgNQKVbeyNoKIkgw30dFmX9NjqYwWnav+5MzIN4dRtFntHODyO/Uq
         pp4uuy1D5jfa4zjQDw4gPPmGWOXJPjwuILvC/fn2RKRQwYOoWtjYPE1I5JuHQUtytIiA
         UYhrQYXGNBUeDi98jH0V1qOwWWQWRH2N+c6zSexL4ZQf0Lz391iGO2ZwKaCUjjUQapfT
         l7xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id;
        bh=j3mRgxWICIf6/mjeVkmbS8iYLT86SrKGS/9bb0CeWeY=;
        b=IlqjL2a0Kld17n/75XZ9qU9EWx3ZbDPuziKmk80zB0YouxBzmKZw4RwU4vwbYwLxYs
         iUvMRRq90v9ahV3n5VfAY13zU5rHmHgb7fqKVe1yWokO4Jd3sKGyi8lshSRpRvEN5VCz
         daoOh5vUya12R6uOCMJ1Rl8fe1bX8OZbKFYvbMuGI9SRehz540XonTqZITa2/wmrb3Gq
         ptIHGXGIx2gSPbcFsfCYgTM0/3r8bQGin/q4csLvJKh48Nbxe0SfdCD5qxpMyr969p7R
         be7AKv5YCIS9a3iuObjRv7PUj1PJmK1VZnxlXRyR3OT8GKUYsfFMnwWhAn4hSreCOZfy
         OXIQ==
X-Gm-Message-State: AA+aEWaJQb/tcfkRzhJiFqKPvzYCtvvlCnsrL/gsTyHcVrcUFqw/e2Kf
        kS+BwcCWvSovPT/Pt1ySJLXsA0EZ
X-Google-Smtp-Source: AFSGD/UQ5ZT1i5XkGEKoAERZJ7RdKMOLsB9fCWSwZtZGQX4KPLyn6x05CmA8MHtUCKphflI8wwxQ2g==
X-Received: by 2002:a17:902:7791:: with SMTP id o17mr28883830pll.60.1544124158344;
        Thu, 06 Dec 2018 11:22:38 -0800 (PST)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id v89sm1529851pfk.12.2018.12.06.11.22.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 06 Dec 2018 11:22:37 -0800 (PST)
From:   Guenter Roeck <linux@roeck-us.net>
To:     linux-hwmon@vger.kernel.org
Cc:     Jean Delvare <jdelvare@suse.com>, linux-kernel@vger.kernel.org,
        Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH 00/13] hwmon: Introduce SENSOR_DEVICE_ATTR_{RO, RW, WO} and variants
Date:   Thu,  6 Dec 2018 11:22:20 -0800
Message-Id: <1544124153-23961-1-git-send-email-linux@roeck-us.net>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Introduce SENSOR_DEVICE_ATTR_{RO,RW,WO} and SENSOR_DEVICE_ATTR_2_{RO,RW,WO}
as simplified variants of SENSOR_DEVICE_ATTR and SENSOR_DEVICE_ATTR_2 to
simplify the source code, improve readbility, and reduce the chance of
inconsistencies.

This series introduces the new macros and converts some of the drivers.
The first patch was first submitted almost two years ago and has since
been dormant. It is unchanged from the first submission.

The driver conversion was done with the Coccinelle script at
https://github.com/groeck/coccinelle-patches/raw/master/hwmon/sensor-devattr-w6.cocci

This series targets v4.21 (v5.0). More conversions will follow with
subsequent kernel releases.
