Return-Path: <SRS0=ZsYk=KH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00452ECDFB8
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 13:20:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AEAFA20854
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 13:20:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tz2f746Z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AEAFA20854
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388467AbeGWOVc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Jul 2018 10:21:32 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:41849 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388053AbeGWOVb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jul 2018 10:21:31 -0400
Received: by mail-wr1-f66.google.com with SMTP id j5-v6so679068wrr.8;
        Mon, 23 Jul 2018 06:20:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=4Xh647zvBThDev2pQsWZu7xDkeLtpoOMx3tsadwRcCw=;
        b=tz2f746ZzNpQOMcoUMmm/PXZD/4d53PP4bktpYiW8FDXF1/tR8YrsHPKe2v7ss+QJw
         3qmYSS4x4xERtX7Pq8sAKv70a+pNUtp6WLP+KFPkE0YtzLb5P+xkhhM2alUvlFv5xnqu
         vsOtGaTQQTNo062Nb/dL7Sb8d1SZ245YpqERiJxPbgZ2Gt55t7mKENOtkxYR+aiqp3Wy
         4uaGV68yb8DZxmNuIiqR3RPxXF7DfpuXTkwQ9O/CuvBcNeBE4Gwz4jaMU26T0Rpstlax
         C+v2u8CWjiQvF4Joc7dAV2iaZfl6ajKbdLXkX+OxiLvrx/UuKEx8x+e9/WlwptN7nPgC
         CcSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=4Xh647zvBThDev2pQsWZu7xDkeLtpoOMx3tsadwRcCw=;
        b=fIFtisHd0Imcku28KRZocfdRkdC0Se2J9tNdinKc1VnWxclhdITfrf3XmRtkgbZ4sU
         nZUI/HnsWxB+9EVfumCofD2YAeCPNQzWIk9ppEpnyfUZybIkQKEFhGZAxcQ8HCSV5tKK
         ztUPgwEYoRrVmfxaQj6ySuj621tzzwm/BKPgxR1zl/5BYmbuK9syIFM8fT5a5z9snF48
         ZNysuI1wTU3X4YIsB1QpeZ1Xs1KGgIDtKfrcXi9XenLz2cHY0IemrpRBhttyMa4klOqZ
         8Ob+tKLomgVFVufeX/Obv5g+t1tf227ogwd5HhtM02vyi1R/yJQ/fXJS5FBxwE+InRJ4
         1UPg==
X-Gm-Message-State: AOUpUlGpo/QNusdkSTf8f84ql69vWLsae40B0G3he9bgzK00aYXiwt78
        D2Oj5oI4cuW00tMGJTBmz3o=
X-Google-Smtp-Source: AAOMgpduX0jXS4Ag8rnt7nW0qzNnoxraPhzShNmQtHfO/X+U4dbroGNhfdFeJp2b8ks7iqPsQgaPog==
X-Received: by 2002:adf:94e2:: with SMTP id 89-v6mr8326367wrr.48.1532352017648;
        Mon, 23 Jul 2018 06:20:17 -0700 (PDT)
Received: from localhost.localdomain ([2a01:4f8:201:1487::2])
        by smtp.gmail.com with ESMTPSA id t184-v6sm8368459wmf.18.2018.07.23.06.20.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 23 Jul 2018 06:20:17 -0700 (PDT)
From:   dev-harsh1998 <harshitjain6751@gmail.com>
To:     trivial@kernel.org
Cc:     Harshit Jain <harshitjain6751@gmail.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Andi Shyti <andi@etezian.org>,
        Simon Budig <simon.budig@kernelconcepts.de>,
        Luca Ceresoli <luca@lucaceresoli.net>,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 06/11] touchscreen: ili210x: Use octal permissions
Date:   Mon, 23 Jul 2018 18:49:21 +0530
Message-Id: <20180723131954.30739-5-harshitjain6751@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180723131954.30739-1-harshitjain6751@gmail.com>
References: <20180723131954.30739-1-harshitjain6751@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

WARNING: Symbolic permissions 'S_IWUSR' are not preferred. Consider using octal permissions '0200'.
+static DEVICE_ATTR(calibrate, S_IWUSR, NULL, ili210x_calibrate);

Signed-off-by: Harshit Jain <harshitjain6751@gmail.com>
---
 drivers/input/touchscreen/ili210x.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/input/touchscreen/ili210x.c b/drivers/input/touchscreen/ili210x.c
index 6f76eeedf465..07526a6f2cb7 100644
--- a/drivers/input/touchscreen/ili210x.c
+++ b/drivers/input/touchscreen/ili210x.c
@@ -169,7 +169,7 @@ static ssize_t ili210x_calibrate(struct device *dev,
 
 	return count;
 }
-static DEVICE_ATTR(calibrate, S_IWUSR, NULL, ili210x_calibrate);
+static DEVICE_ATTR(calibrate, 0200, NULL, ili210x_calibrate);
 
 static struct attribute *ili210x_attributes[] = {
 	&dev_attr_calibrate.attr,
-- 
2.17.1

