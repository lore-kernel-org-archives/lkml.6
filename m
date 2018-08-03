Return-Path: <SRS0=+aXO=KS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74CD6C46469
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 21:42:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 25FA6217AA
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 21:42:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hftBzH2Z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 25FA6217AA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732230AbeHCXkd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Aug 2018 19:40:33 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:34980 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729985AbeHCXk1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Aug 2018 19:40:27 -0400
Received: by mail-wm0-f65.google.com with SMTP id o18-v6so7888550wmc.0
        for <linux-kernel@vger.kernel.org>; Fri, 03 Aug 2018 14:42:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=A1f4CDWh0tqNxurRFifBgG+DAwyoT6odptDX15QF0Ng=;
        b=hftBzH2ZlKXtO+uAkCbWVKMP69Lop9oWcaDbAfe7cmIXkLH3O4OgExwkhfwdFrTUaT
         5q9nv+KibNktl4AbWfjRKkXQLVMhc3zEyx+oQ0Aq5xYx7HMfsI9z66KujJf5vdMFhNKE
         FOC61BuWALjUDa+1nqy4Cfcu3FOTMv1U4YXmqiCuS62PhhupbAw05Ze2ov8UyMIUckjD
         wCh80vVIZIgcgLQbRL3lVjwCwKUA568AqDhIQAvF2KfTSe3wvujga7+oYolMiA1gXVOa
         m2Tc/8v7qF8pQvjCd21XjAs8yKrm5ZKutBx8OdI/AssWieLsPFcVC3ZsAA/lssi6yfFO
         bBGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=A1f4CDWh0tqNxurRFifBgG+DAwyoT6odptDX15QF0Ng=;
        b=GGDtLB3XJdy4OtSn4A4agu+Iq8XwGXZDzQSzUZZlLk1UO2ZfQOPL9DDYgtYdGZ/C1C
         oT4JseiRRFQKOM/EMTV0Kf3oX4Z8+ljVS+roA66gz7HrvH+rx6rlZK/v0fpF03dWDn9x
         yVXQeQs9d+k8bQYOAFVdUAY226WqBP2rv6jyNYhygCkMeXllepv+3XM8ohVH+/+kodYR
         LZhuMsb/+Qivf4mjqjKGjxsxbuegwyc8AatIR4bDSdl6IAApS5jKjVg8qGC+LzWndpkl
         FOtJoMpo0Li6CCtwq44p4SMPV1jyapPyxESM/RygonhC0Dx8VglbDJzt1W4ZSVmmJeo2
         rfeA==
X-Gm-Message-State: AOUpUlHNLPQiISa8gr9u2/M30Nmpf+kP2yh0+pOOOuEO3zYWI5pyB/fB
        H0PYbH13rM/nvTFqoAfdP3P6et2Q
X-Google-Smtp-Source: AAOMgpflYVPaQ7pusm2/0xlQsvJ4+ZSbQzeRDpJYh+k2GgpBqase63onnVTU0IivojFpWE/E/fAigg==
X-Received: by 2002:a1c:2108:: with SMTP id h8-v6mr5673848wmh.108.1533332542009;
        Fri, 03 Aug 2018 14:42:22 -0700 (PDT)
Received: from ?IPv6:2003:ea:8bd4:d600:9545:19fe:eae2:90aa? (p200300EA8BD4D600954519FEEAE290AA.dip0.t-ipconnect.de. [2003:ea:8bd4:d600:9545:19fe:eae2:90aa])
        by smtp.googlemail.com with ESMTPSA id r16-v6sm6389131wru.59.2018.08.03.14.42.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 03 Aug 2018 14:42:21 -0700 (PDT)
Subject: [PATCH 3/3] mei: Improve usage of mei_start
From:   Heiner Kallweit <hkallweit1@gmail.com>
To:     Tomas Winkler <tomas.winkler@intel.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <5e0250ff-2470-1128-d8eb-b36e3ca04417@gmail.com>
Message-ID: <8d5151fb-88dc-b4cf-843a-9519516ccd36@gmail.com>
Date:   Fri, 3 Aug 2018 23:42:09 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <5e0250ff-2470-1128-d8eb-b36e3ca04417@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

mei_start() prints an error message and returns -ENODEV on failure,
so we don't have to duplicate this in the caller.

Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
---
 drivers/misc/mei/pci-me.c  | 6 ++----
 drivers/misc/mei/pci-txe.c | 6 ++----
 2 files changed, 4 insertions(+), 8 deletions(-)

diff --git a/drivers/misc/mei/pci-me.c b/drivers/misc/mei/pci-me.c
index a60376f0..02ba830a 100644
--- a/drivers/misc/mei/pci-me.c
+++ b/drivers/misc/mei/pci-me.c
@@ -208,11 +208,9 @@ static int mei_me_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 		goto end;
 	}
 
-	if (mei_start(dev)) {
-		dev_err(&pdev->dev, "init hw failure.\n");
-		err = -ENODEV;
+	err = mei_start(dev);
+	if (err)
 		goto release_irq;
-	}
 
 	pm_runtime_set_autosuspend_delay(&pdev->dev, MEI_ME_RPM_TIMEOUT);
 	pm_runtime_use_autosuspend(&pdev->dev);
diff --git a/drivers/misc/mei/pci-txe.c b/drivers/misc/mei/pci-txe.c
index 3ea2b8f6..901574be 100644
--- a/drivers/misc/mei/pci-txe.c
+++ b/drivers/misc/mei/pci-txe.c
@@ -120,11 +120,9 @@ static int mei_txe_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 		goto end;
 	}
 
-	if (mei_start(dev)) {
-		dev_err(&pdev->dev, "init hw failure.\n");
-		err = -ENODEV;
+	err = mei_start(dev);
+	if (err)
 		goto release_irq;
-	}
 
 	pm_runtime_set_autosuspend_delay(&pdev->dev, MEI_TXI_RPM_TIMEOUT);
 	pm_runtime_use_autosuspend(&pdev->dev);
-- 
2.18.0


