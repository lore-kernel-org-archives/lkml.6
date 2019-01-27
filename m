Return-Path: <SRS0=AJhT=QD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FD6AC282C0
	for <linux-kernel@archiver.kernel.org>; Sun, 27 Jan 2019 05:57:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 27EFF214D8
	for <linux-kernel@archiver.kernel.org>; Sun, 27 Jan 2019 05:57:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726487AbfA0F4v convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 27 Jan 2019 00:56:51 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:53988 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725835AbfA0F4u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Jan 2019 00:56:50 -0500
Received: from mail-pf1-f198.google.com ([209.85.210.198])
        by youngberry.canonical.com with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
        (Exim 4.76)
        (envelope-from <kai.heng.feng@canonical.com>)
        id 1gndR2-000052-LM
        for linux-kernel@vger.kernel.org; Sun, 27 Jan 2019 05:56:48 +0000
Received: by mail-pf1-f198.google.com with SMTP id a23so11280550pfo.2
        for <linux-kernel@vger.kernel.org>; Sat, 26 Jan 2019 21:56:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:content-transfer-encoding:mime-version
         :subject:message-id:date:cc:to;
        bh=4xRVWx0P9o3ianN9URrhECoEWa4/HNDtRpiCoJtoqns=;
        b=X9xwe5uWE8J4vnQTk4pyEq+Ch9AV+i1UbMwPiRE/43OsnoegClicuzt3pypRXphDJd
         rVKtgzchuFNBNHiWGC+Hu0SlM/KM6v4xUcU+c/Av/MxGaHjBN0HRy6p56ADB0Z5XlTWN
         qvI/a9OV9mfWGcDJrwWQbHsdDGuzDusZJakEkWTpozEFtLfr+hYyGJBRZ3V/SJkYwvu9
         6U5o5/j3cvZbAzQcLnsKzsuTRdf39DeLNGMzahfQlSLeaCbjj0BrDaicKsLpbHZ3P7wj
         GNuGQXo7VBfS405ESwQN5JVHinhKyRlRY7CVLxZkUwDq59L901YzEPRvoJrvr1Ej04US
         UB6g==
X-Gm-Message-State: AJcUukcVLWTOoGlnz2xV3bnV9a9K2myuxGkWFsGZafFZs/aBFkfALG/V
        feZm/y4e1IUVQc3aPxlps1p9t6t7J0x70abksdFqa7juhYc++X7OHCtZjWNPX/e0Y32wWb/YFCk
        mZB9WLbUh04ia5JQXvZPF+yiF51bm0n3HQxsWj1yjPw==
X-Received: by 2002:a17:902:1008:: with SMTP id b8mr16666688pla.252.1548568607056;
        Sat, 26 Jan 2019 21:56:47 -0800 (PST)
X-Google-Smtp-Source: ALg8bN7Os6Lpx5j4KxfvMW6wGpkca+X4FORQ4PW8Q3HyyHzKub9YPLO+A7ws+TPjWYpZUgC6Oeug8g==
X-Received: by 2002:a17:902:1008:: with SMTP id b8mr16666677pla.252.1548568606720;
        Sat, 26 Jan 2019 21:56:46 -0800 (PST)
Received: from 2001-b011-380f-13aa-5df5-fc0f-304e-fb4c.dynamic-ip6.hinet.net (2001-b011-380f-13aa-5df5-fc0f-304e-fb4c.dynamic-ip6.hinet.net. [2001:b011:380f:13aa:5df5:fc0f:304e:fb4c])
        by smtp.gmail.com with ESMTPSA id t24sm53955958pfm.127.2019.01.26.21.56.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 26 Jan 2019 21:56:46 -0800 (PST)
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
Content-Type: text/plain;
        charset=utf-8
Content-Transfer-Encoding: 8BIT
Mime-Version: 1.0 (Mac OS X Mail 12.2 \(3445.102.3\))
Subject: ipu3-imgu 0000:00:05.0: required queues are disabled
Message-Id: <7F8ED1B6-5070-437A-A745-AE017D8CE0DF@canonical.com>
Date:   Sun, 27 Jan 2019 13:56:42 +0800
Cc:     bingbu.cao@intel.com, yong.zhi@intel.com,
        linux-media@vger.kernel.org, devel@driverdev.osuosl.org,
        Linux Kernel <linux-kernel@vger.kernel.org>
To:     sakari.ailus@linux.intel.com
X-Mailer: Apple Mail (2.3445.102.3)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

We have a bug report [1] that the ipu3 doesn’t work.
Does ipu3 need special userspace to work?

[1] https://bugs.launchpad.net/bugs/1812114

Kai-Heng
