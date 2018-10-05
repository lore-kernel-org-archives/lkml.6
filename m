Return-Path: <SRS0=9Qwj=MR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C056C00449
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 23:59:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AF8BB2064D
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 23:59:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O2YkIHbV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AF8BB2064D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729377AbeJFHAR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 6 Oct 2018 03:00:17 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:32904 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726759AbeJFHAR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Oct 2018 03:00:17 -0400
Received: by mail-pl1-f193.google.com with SMTP id s4-v6so7511245plp.0;
        Fri, 05 Oct 2018 16:59:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=JlxZSGsM8aEAB10CMOopyMTx/bqNXZo1sB016iaLHRE=;
        b=O2YkIHbVOk8AsKMXjXVRWRwA3iDIUlyR6fy07dzilf7VPqYnPpR/+qWTEN7te3QIu6
         cFF4CyV+b0dKwvQCL9h31W49t+9ZQuOClrK0LVvc8XDyP0UkP2duZ8CWfdWH7ziTvyoX
         tklYhW+BbwYtpE3/A9sgFnqTu0J/xH6XoEK7H5TrmT0RKEB33pDO1LU6E+n5wpnNZH+w
         NbZHTSQQUZlkKrTEP59kmhX7/gBx0bkCBxAv857+t5csyYojvhoYzmhi+MNlaC6yR6Wt
         MlAEABIDXSlBdK4Q//5Cd+FN7HHAG6Yj0yVDrud6rOKIvcKp+QbxjTKAm5Yf2lgAw94c
         iMQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=JlxZSGsM8aEAB10CMOopyMTx/bqNXZo1sB016iaLHRE=;
        b=aQH0nRiuS3lbrT/0iITkUC6tu6y2FsUCN5WYggCTSCpKkeWeCHgO6Qe2QkC1xKha3P
         YYoeadr/uDwOSUWh2sZmMqgZ9LmFONJCT0/JzaRryAANfnmx3dVqnwN09NMeHu6NJeDV
         E+942PRoOreMvIySgVHHU0ml9begs42yLTqX42nzR+tGczeneubIp1Tx1L+H/e/fvznx
         9OZ+dW5oh5NkYIsvAKG8EhVGh3RN9D5DQ6+NyHL0Va+1wvHhYZj1wpfLCK1iRAPfrOsV
         5CVcBGJGMRFIJ+pLezJ3twV0SnpknaHxkeUG6+3q0qqdLt/02/2pdKlPoU/u1Xvuw4HQ
         5deQ==
X-Gm-Message-State: ABuFfohNsZgr+NJwE2TNwX/nE4cX0IJGw9VLemxg31BFpdUUjQsIcITc
        vpIQFbKoZNn8mQLm8YK22sA=
X-Google-Smtp-Source: ACcGV60aU/p0dct+3krL5QSYiQdKccZ7IDka+hMUAz24odDEzvw8ldxCb4R0oOBr4B1vdxRiKt40Vg==
X-Received: by 2002:a17:902:8c90:: with SMTP id t16-v6mr13413149plo.251.1538783953975;
        Fri, 05 Oct 2018 16:59:13 -0700 (PDT)
Received: from Asurada-Nvidia.nvidia.com (thunderhill.nvidia.com. [216.228.112.22])
        by smtp.gmail.com with ESMTPSA id x24-v6sm12137181pfh.67.2018.10.05.16.59.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 05 Oct 2018 16:59:13 -0700 (PDT)
From:   Nicolin Chen <nicoleotsuka@gmail.com>
To:     jdelvare@suse.com, linux@roeck-us.net
Cc:     afd@ti.com, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] hwmon: (ina3221) Apply _info API
Date:   Fri,  5 Oct 2018 16:59:03 -0700
Message-Id: <20181005235905.29403-1-nicoleotsuka@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series of patches applies _info API of hwmon core to
the ina3221 hwmon driver.

Nicolin Chen (2):
  hwmon: (core) Add hwmon_in_enable attribute
  hwmon: (ina3221) Use _info API to register hwmon device

 drivers/hwmon/hwmon.c   |   1 +
 drivers/hwmon/ina3221.c | 528 +++++++++++++++++++---------------------
 include/linux/hwmon.h   |   2 +
 3 files changed, 248 insertions(+), 283 deletions(-)

-- 
2.17.1

