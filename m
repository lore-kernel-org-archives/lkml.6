Return-Path: <SRS0=+aXO=KS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C6CBC43142
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 01:50:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 113EB21715
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 01:50:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aHbs7YZE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 113EB21715
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732445AbeHCDoB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Aug 2018 23:44:01 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:44213 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732415AbeHCDoA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Aug 2018 23:44:00 -0400
Received: by mail-pf1-f196.google.com with SMTP id k21-v6so2329324pff.11
        for <linux-kernel@vger.kernel.org>; Thu, 02 Aug 2018 18:50:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=XsSISeWDSOKCcpCQcmWdlT6PopwLqkF2RH8Ct45Npl0=;
        b=aHbs7YZEWth3LVZPWznvCRoh08HEomWN3mfdJ6Q/HfI0vf6VsoIPXOZtGXeArc3SLk
         Yg8J5TBO3T/nViXaAPaJYj+Lf3CDKNjYxb8eaoygsGLHuVUIHUTWEuQDpuw6k0GwsPAz
         NR5clmyhlW1rRkOjYjjnzn/GNwKaBtq8U/AtK99fRT/nVEsAQfGR1sqktPO/S0StrThU
         YGpZ8tXtNc5CT3nd5Dz/8qPdwN367A8cp89P46Tmc7hC2klF3f3M1jOo2y1xMv0v/un5
         lNakXAiZmxjoFdywsnZq8QrBEF0zN0lGaxJaSaQZ3vlmCDYaXctN6/DWJWD3bEEKZqUw
         m7kQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=XsSISeWDSOKCcpCQcmWdlT6PopwLqkF2RH8Ct45Npl0=;
        b=sErIixI46nQ65pR2yz4zYxDSOzOWWMJU/7xq6O+w2izNUv2lEZrz7VJZBTAaVODOfx
         FttwUEO3fwgWXeM39lu+t5x+Sdk8Vi01oe2i0Y+nHccei3DC+5uM41ZC+gIB3aFGGVSF
         ZrAynPS1pd7/ENncDAtJFWFBH0YLhhGccTf7oEHjcTnwalOq06jRh5xYCVlQmuDJp70C
         jizZdte4oPeZnRuSyA0xSu2yQw0WgZyUYRMjZ+nbDMTLCxpvNRHa2J2ZsxagJaqjl1AP
         sD1td7yBKGX0pql5FCv9Uf/VGe09IZG8MMUkFIR6g5qL+suboDT2Hfn57r5h4R2qLWaC
         S0sw==
X-Gm-Message-State: AOUpUlF17ietVAWk/egqvOMDW4NWUqCVTHC11ePXKSHUE7mvYOZMxuXI
        yfshgnqN3Cd08VJQ5CgxKsM=
X-Google-Smtp-Source: AAOMgpdRHrKuA+evf3nc/tNh4viDnsowp2N7p3LzoFox5ML1CJNxw35iIqeXZvBQA9je1oDaLytOKA==
X-Received: by 2002:a65:5cc5:: with SMTP id b5-v6mr1659169pgt.425.1533261007407;
        Thu, 02 Aug 2018 18:50:07 -0700 (PDT)
Received: from toddpoynor2.mtv.corp.google.com ([2620:0:1000:3701:7d29:cd13:d903:7908])
        by smtp.gmail.com with ESMTPSA id m81-v6sm7348315pfa.188.2018.08.02.18.50.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 02 Aug 2018 18:50:06 -0700 (PDT)
From:   Todd Poynor <toddpoynor@gmail.com>
To:     Rob Springer <rspringer@google.com>,
        John Joseph <jnjoseph@google.com>,
        Ben Chan <benchan@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Dmitry Torokhov <dtor@chromium.org>, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, Todd Poynor <toddpoynor@google.com>
Subject: [PATCH 4/4] Revert "staging: gasket: core: hold reference to pci_dev while used"
Date:   Thu,  2 Aug 2018 18:49:52 -0700
Message-Id: <20180803014952.104582-5-toddpoynor@gmail.com>
X-Mailer: git-send-email 2.18.0.597.ga71716f1ad-goog
In-Reply-To: <20180803014952.104582-1-toddpoynor@gmail.com>
References: <20180803014952.104582-1-toddpoynor@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Todd Poynor <toddpoynor@google.com>

There's no need to take an additional reference on the pci_dev structure
for the pointer copy saved in gasket data structures.

This reverts commit:
8dd8a48b9a7d ("staging: gasket: core: hold reference to pci_dev while used")

Reported-by: Dmitry Torokhov <dtor@chromium.org>
Signed-off-by: Todd Poynor <toddpoynor@google.com>
---
 drivers/staging/gasket/gasket_core.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/staging/gasket/gasket_core.c b/drivers/staging/gasket/gasket_core.c
index 93a4d9f08eaab..2d209e36cf372 100644
--- a/drivers/staging/gasket/gasket_core.c
+++ b/drivers/staging/gasket/gasket_core.c
@@ -255,7 +255,6 @@ static void gasket_free_dev(struct gasket_dev *gasket_dev)
 	internal_desc->devs[gasket_dev->dev_idx] = NULL;
 	mutex_unlock(&internal_desc->mutex);
 	put_device(gasket_dev->dev);
-	pci_dev_put(gasket_dev->pci_dev);
 	kfree(gasket_dev);
 }
 
@@ -1477,7 +1476,7 @@ static int gasket_pci_probe(struct pci_dev *pci_dev,
 	ret = gasket_alloc_dev(internal_desc, parent, &gasket_dev, kobj_name);
 	if (ret)
 		return ret;
-	gasket_dev->pci_dev = pci_dev_get(pci_dev);
+	gasket_dev->pci_dev = pci_dev;
 	if (IS_ERR_OR_NULL(gasket_dev->dev_info.device)) {
 		pr_err("Cannot create %s device %s [ret = %ld]\n",
 		       driver_desc->name, gasket_dev->dev_info.name,
-- 
2.18.0.597.ga71716f1ad-goog

