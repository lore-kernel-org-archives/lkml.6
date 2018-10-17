Return-Path: <SRS0=uOC5=M5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CE89C5ACC6
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 01:24:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CD719214C2
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 01:24:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JcV7dyH7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CD719214C2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727087AbeJQJRo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Oct 2018 05:17:44 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:42931 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726691AbeJQJRn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Oct 2018 05:17:43 -0400
Received: by mail-pg1-f196.google.com with SMTP id i4-v6so11677458pgq.9;
        Tue, 16 Oct 2018 18:24:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=NYb20OAYMJ0XFw0XOoYbYR6F+RciKt6fYmDI0LaV6Rc=;
        b=JcV7dyH7y4KYrKcNG8sHl/Wp9Yws4EODPmmswah0L9lyF+k0Y8i1BeABBhCxlNdNcL
         MDdmr+dPnVYJpORlTEwPGBtUrzHxJLHuWORRB2JADTyYtvs3oUGCjvhlgX4bunh9RXQa
         POJv8WTDY+CB9CkFunIQeiYzbEgEmDAqlezTkrybutdSGxHM73F+UkJC0j3gs5Vgokd3
         g30TB6vME/0Ljie6BnFp5UChby7jH9IJPzKqzfQRTyVUj99ORzhg0P4mpQZjTUaiVNxa
         XWjWwwjsFz8ar6VGpVMEY6PZIh/+IOb3jSHEkPMeOj29GP1eXr6h97PqaB+AqiB5e0x3
         bIug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=NYb20OAYMJ0XFw0XOoYbYR6F+RciKt6fYmDI0LaV6Rc=;
        b=b/N3luUfFwmvzngcSvWYHS6drDG4H0BDea3954DguiImxsE0tZtduVC7qTK0Pv9Fyp
         ZH24QH1youuk8bHWBYMcNOBEa3JhR+bn7/Oidhk4aBdOjfkeKYqtFXNlMPod9x3AjqY5
         GnvMevEn1949uLIM2kIr1FhUZPUdjJeeUuaicZIoPrfZ5AM2rOOBYWJHUfqnSnMA3hR7
         OoEdHFMWdCycLgQy6EeqtHRyX/QoSd9ap0qEHVZ0kb720s3y39O1wQM+Gl8ys5MDbSNq
         vU4RqpqX2Ig/kAzdBJPwytixlLlGCfUhQ65lpOXQ1UjCd5ge8cg4BmLLGVnBdh7R2Ngf
         fZlw==
X-Gm-Message-State: ABuFfog5Wb28IdbSHb2CSDcPbiLx+4a5ChBkL/IOSZdS/tw4qwE9nlxU
        ryxi5QfOh2U1sjFrdGv43I8=
X-Google-Smtp-Source: ACcGV634KH6hweZUdsmpPPd2TUiTRQtKpuc3vOp8RI6lMx3sO7pT9io7jzlaU07yX9Xe2VdoqC2SCA==
X-Received: by 2002:a62:1e83:: with SMTP id e125-v6mr24213875pfe.231.1539739473114;
        Tue, 16 Oct 2018 18:24:33 -0700 (PDT)
Received: from Asurada-Nvidia.nvidia.com (thunderhill.nvidia.com. [216.228.112.22])
        by smtp.gmail.com with ESMTPSA id n64-v6sm22841851pfi.185.2018.10.16.18.24.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 16 Oct 2018 18:24:32 -0700 (PDT)
From:   Nicolin Chen <nicoleotsuka@gmail.com>
To:     jdelvare@suse.com, linux@roeck-us.net
Cc:     linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 0/5] hwmon: (ina3221) Implement PM runtime to save power
Date:   Tue, 16 Oct 2018 18:24:21 -0700
Message-Id: <20181017012426.26958-1-nicoleotsuka@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series patches implement PM runtime feature in the ina3221 hwmon
driver (PATCH-5). However, PATCH-[1:4] are required to make sure that
the PM runtime feature would be functional and safe.

Nicolin Chen (5):
  hwmon: (core) Inherit power properties to hdev
  hwmon: (ina3221) Return -ENODATA for two alarms attributes
  hwmon: (ina3221) Serialize sysfs ABI accesses
  hwmon: (ina3221) Make sure data is ready after channel enabling
  hwmon: (ina3221) Add PM runtime support

 drivers/hwmon/hwmon.c   |   3 +
 drivers/hwmon/ina3221.c | 185 ++++++++++++++++++++++++++++++++++------
 2 files changed, 162 insertions(+), 26 deletions(-)

-- 
2.17.1

