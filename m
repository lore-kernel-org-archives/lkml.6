Return-Path: <SRS0=drEb=P7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,TVD_PH_SUBJ_META1,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA9FBC282C4
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 00:02:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8700520856
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 00:02:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="o+yxyYk2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727326AbfAWAB7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Jan 2019 19:01:59 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:53816 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727191AbfAWABc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jan 2019 19:01:32 -0500
Received: by mail-wm1-f67.google.com with SMTP id d15so315870wmb.3
        for <linux-kernel@vger.kernel.org>; Tue, 22 Jan 2019 16:01:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=4r3q2edasWImrjH8D55giCtepA4KRkTRWGFI1t43UwM=;
        b=o+yxyYk2QAkrwprkx+ELjaBSC1S7Hz1y3/foOt8mY3q5IYp7MJRYQwhYjN/U35IBpH
         A2LRGlJ3V/Dobl2eJUNmSN9qaqbthYAJnZoU0xBKifOV93fnx+rtaRU1W0NXSRfHhcvk
         Jj4d4jJsRAFRnI7BRjk+UkHnoceUgFG06RJhzbh3sIR8k1sBW0XWySiFqolXm8Ig2Pl9
         40067ci5yVbbjwyI3qoWOv2GJKVe3w5rK8Us4861pEB9WU3XGjB9mWv4gjobQINpieLx
         8SIJyZL9q6Xpbuedf5+wfHT2qHQnXFkqvc+l+309VjBeggoCQq019dkpLMmjp29rEbBj
         xgVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=4r3q2edasWImrjH8D55giCtepA4KRkTRWGFI1t43UwM=;
        b=PS8w9R7YjoIEpBUFGP1c9YHzdRRr6u+Zkyrsv+wkEc9ruRSdSxlyU0FhQLN2yt+Svn
         ZmlXdW0FMrpW1xeG3q01Ho163EKNVmRpiQV+W8Xs/n37NISAX8sGWY84FgJ721aEOQaH
         eYMnhiQVMoMvOAhT5KFEXm+NyE/nDi50BQr2B/UhOxK6/wQcF9ZHc3ECFFR2Jt4o6pEF
         D6vjE0qnzxa2MghHijbhad7GVTCI94jXNQqQRkJOJ8Y7JvAlpPIUV4tisw92LDuF1Mpo
         hJHuEfkQDxDaS9bLoEn9QIohohgVCcJVtn+O6lk7uwwPnKpu16DTvcHGzuO5hure0AGU
         qXwg==
X-Gm-Message-State: AJcUukeA+Grj612HAPSHFS1VQPBU8g+O+/ii59hhpTio5khlt47PUizb
        xK7lhOLGViG40IhsAJl8Jew=
X-Google-Smtp-Source: ALg8bN76gWkDpGaEHY8cLTnGyX1S+DYBCEjvMTr60ri2qo/bT90aAPKUVrtehhRAtSDAdFRnGyL8/A==
X-Received: by 2002:a1c:4683:: with SMTP id t125mr487812wma.9.1548201689820;
        Tue, 22 Jan 2019 16:01:29 -0800 (PST)
Received: from oded-ubuntu-desktop.habana-labs.com ([31.154.190.6])
        by smtp.gmail.com with ESMTPSA id 125sm97582630wmm.26.2019.01.22.16.01.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 22 Jan 2019 16:01:29 -0800 (PST)
From:   Oded Gabbay <oded.gabbay@gmail.com>
To:     gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org
Cc:     ogabbay@habana.ai
Subject: [PATCH 15/15] Update MAINTAINERS and CREDITS with habanalabs info
Date:   Wed, 23 Jan 2019 02:00:57 +0200
Message-Id: <20190123000057.31477-16-oded.gabbay@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190123000057.31477-1-oded.gabbay@gmail.com>
References: <20190123000057.31477-1-oded.gabbay@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The habanalabs driver was written from scratch from the very first days
of Habana and is maintained by Oded Gabbay.

Signed-off-by: Oded Gabbay <oded.gabbay@gmail.com>
---
 CREDITS     | 2 +-
 MAINTAINERS | 9 +++++++++
 2 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/CREDITS b/CREDITS
index e818eb6a3e71..03f3d67126fc 100644
--- a/CREDITS
+++ b/CREDITS
@@ -1222,7 +1222,7 @@ S: Brazil
 
 N: Oded Gabbay
 E: oded.gabbay@gmail.com
-D: AMD KFD maintainer
+D: HabanaLabs and AMD KFD maintainer
 S: 12 Shraga Raphaeli
 S: Petah-Tikva, 4906418
 S: Israel
diff --git a/MAINTAINERS b/MAINTAINERS
index 51029a425dbe..93e047336cab 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -6641,6 +6641,15 @@ F:	drivers/clocksource/h8300_*.c
 F:	drivers/clk/h8300/
 F:	drivers/irqchip/irq-renesas-h8*.c
 
+HABANALABS PCI DRIVER
+M:	Oded Gabbay <oded.gabbay@gmail.com>
+T:	git https://github.com/HabanaAI/linux.git
+S:	Supported
+F:	drivers/misc/habanalabs/
+F:	include/uapi/misc/habanalabs.h
+F:	Documentation/ABI/testing/sysfs-driver-habanalabs
+F:	Documentation/ABI/testing/debugfs-driver-habanalabs
+
 HACKRF MEDIA DRIVER
 M:	Antti Palosaari <crope@iki.fi>
 L:	linux-media@vger.kernel.org
-- 
2.17.1

