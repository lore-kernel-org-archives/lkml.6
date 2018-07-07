Return-Path: <SRS0=3LFY=JX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC1EAC6778F
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Jul 2018 07:08:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 78030224F4
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Jul 2018 07:08:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CNCfjegg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 78030224F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753486AbeGGHIk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 7 Jul 2018 03:08:40 -0400
Received: from mail-qk0-f194.google.com ([209.85.220.194]:36975 "EHLO
        mail-qk0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752836AbeGGHIi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Jul 2018 03:08:38 -0400
Received: by mail-qk0-f194.google.com with SMTP id t79-v6so7425940qke.4
        for <linux-kernel@vger.kernel.org>; Sat, 07 Jul 2018 00:08:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=pL13yxBa7hyjQxCD9aTWPyUUSZlU+P/+Izhkn8lFOxI=;
        b=CNCfjeggvhhTlrbH+FpAYww6NfJPqp8SJEoyQMndN744GTVed5OMKkj5JXGawvGJyL
         tQJWfQo2Tk/hfcatAyfgiqWutbA0PkBrJfG1mS4xmK4/8FO+X1L4HByGu1sq69Y8ywpL
         V2JpL2cVxuJ3cbly5JuWX4rqFJJ4OpnaJGJKjpdH7mwAhgsY1Vd+krSGJV8ph7QUgjz2
         gcUWsKy9KM3xW8+WRNzhVIe0oBNd+4Bpwqgiiej0c5nYKBfPV8cYDf1ghmGRE129YbPI
         8Eb4M2/S1J9WdnNmMcSjrXWcqKD2pBm8Pok49NornE9eG2n7LeSi8UaFP0xMSW1yn13N
         Bajw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=pL13yxBa7hyjQxCD9aTWPyUUSZlU+P/+Izhkn8lFOxI=;
        b=pD5kqXW8zhWf7s2RigdXbBmtwnU/OOk1vPqGwhocf4l3x40tEbl/WTNvvkpi6OVVBw
         d4D536ItZI1eG5fzIyQsBg2UYOHynBBBxLSbYbrzObVZ1lyZ8FOoJoywcu9Q2kEme3yy
         DfdEyG3FKeLYuffBDttukF2XKdkXj+5zMJH7XpJPmLRYjcKUVS6UMM8jd8sTN0cE1Epf
         xz3UhH1sOOb+npa9ov0vhur2AHpIcJh7pwYwEpXSN5V55tSM8ieGNHk3Mx0y2wfb1j58
         /cVHn6MDFYkcb9R7c+a7LSiYPSXRNzWxW3tcK/NHpHYuU9/2vi+5Dl9gdIbrfw9SCh7w
         PugQ==
X-Gm-Message-State: APt69E3rVF11Nb+kDnkH5WJ8VuinJtWRj++ZTSgN86MHA/SM+o7BalSE
        kmlUywVfrs1I56m5n/b4Aes=
X-Google-Smtp-Source: AAOMgpfYgr5wRCXeFr75i65nCD22lV/NWK+mwClYAcQPNBXYHSRxWKdYuPwb0Hh+oKgsR9EpdhG/Sg==
X-Received: by 2002:a37:3cc3:: with SMTP id j186-v6mr4319892qka.218.1530947318299;
        Sat, 07 Jul 2018 00:08:38 -0700 (PDT)
Received: from peter-ThinkPad-X220-Tablet (pool-108-18-228-108.washdc.fios.verizon.net. [108.18.228.108])
        by smtp.gmail.com with ESMTPSA id k67-v6sm6956428qte.95.2018.07.07.00.08.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 07 Jul 2018 00:08:37 -0700 (PDT)
Date:   Sat, 7 Jul 2018 03:08:36 -0400
From:   Peter Vernia <peter.vernia@gmail.com>
To:     peter.vernia@gmail.com
Cc:     gregkh@linuxfoundation.org, neil@brown.name,
        peter.vernia@gmail.com, blogic@openwrt.org,
        sankalpnegi2310@gmail.com, christian@lkamp.de,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/4] staging: mt7621-pci: Fix spacing around equals sign
Message-ID: <20180707070836.GA26575@peter-ThinkPad-X220-Tablet>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add spaces in front of the equals sign in assignment operations

Signed-off-by: Peter Vernia <peter.vernia@gmail.com>
---
 drivers/staging/mt7621-pci/pci-mt7621.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/mt7621-pci/pci-mt7621.c b/drivers/staging/mt7621-pci/pci-mt7621.c
index ded58ba..c7932ae 100644
--- a/drivers/staging/mt7621-pci/pci-mt7621.c
+++ b/drivers/staging/mt7621-pci/pci-mt7621.c
@@ -292,7 +292,7 @@ pci_config_write(struct pci_bus *bus, unsigned int devfn, int where, int size, u
 	}
 }
 
-struct pci_ops mt7621_pci_ops= {
+struct pci_ops mt7621_pci_ops = {
 	.read		= pci_config_read,
 	.write		= pci_config_write,
 };
@@ -480,8 +480,8 @@ static int mt7621_pci_probe(struct platform_device *pdev)
 	unsigned long val = 0;
 
 	iomem_resource.start = 0;
-	iomem_resource.end= ~0;
-	ioport_resource.start= 0;
+	iomem_resource.end = ~0;
+	ioport_resource.start = 0;
 	ioport_resource.end = ~0;
 
 	val = RALINK_PCIE0_RST;
-- 
2.7.4

