Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BA8DC43441
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 00:10:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2CB4F20879
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 00:10:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="glzXTgP9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2CB4F20879
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727127AbeK2LOE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 06:14:04 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:34634 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726668AbeK2LOD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 06:14:03 -0500
Received: by mail-pg1-f194.google.com with SMTP id 17so69151pgg.1
        for <linux-kernel@vger.kernel.org>; Wed, 28 Nov 2018 16:10:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:in-reply-to:references:date:message-id
         :mime-version;
        bh=gxN6meZD+vL3jWc6RWDosS51Mvp7RAbZP0pEZDltb18=;
        b=glzXTgP9RVW3Q+fHtdm4Gmchbs/kUTHp3HHm7/q7fNJM7MJw94zUIOFCwk9FA3tRny
         chBx+lNb0h7BxU+LZ/DKE7ez0xAnhlde1Dx5/6T8v1AOPLzwvjSNUNkwLSRE8qSJjlU8
         akEmy8LOqPypxZPcwDl+bLU2Dg6nCPxq9Lui6jQnFExExeD+WFwVX9mErKMM5nz52W9v
         CFwVw6NHF7UiZg3UcwWuwuniWv3U/MsdPmNSMS25RRqlQ6bQ7D9paXy+/CmolrHzwG2B
         VOcINC0l6/AAURqYbRwFKxDKS+4LkxJKR4cWivZLgVDdkuVxr7BfIaLqBPBcze+2rjBR
         u/VA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=gxN6meZD+vL3jWc6RWDosS51Mvp7RAbZP0pEZDltb18=;
        b=AFSTvWDdTLwchpWyIVR24QJvURjZ/z1cECItMYTzmg7jbF912paSDzOlZ13G7kNxE5
         DZFLDzSlP7Izgbpsrr7q7suZ1WBM+u6ZfLij6JQwUJEH/hIJy2tBCN+Rfn+mNM+9UBEh
         cQzadR+5A3l1rWxEbhH65nSjnJOidQMcbFc9YV9IKC6bw+DnpMdolhKqXzm5dGDn2VcN
         VF/Pu8IvbqsIx1F5KxbB+4j2zkfjVSuUOqYA56O4BX9Z5W7eX3HsS2ItNj6hdX+vOmeR
         kOdNO1arf85jiiu34WnjAmnV3RrYS1J9xANfU6TCIuG9ISPeCVAY1MXwmEDv2kl+7dgn
         iZzw==
X-Gm-Message-State: AA+aEWbq6ePD6+eTFB/+1GPS+FLLszHZKDcyg6jS79tfzFiETyWdd000
        TczEVvos9mIuF+7EzO/GkZiWMQ==
X-Google-Smtp-Source: AFSGD/Whyayeeu/cJw7s5a8vSD3MBLZHxnydxg+Vzl6G9MqhcZqtSi3UUfjshdkPGA9YD1SoBOmMvA==
X-Received: by 2002:a63:b54f:: with SMTP id u15mr34801840pgo.420.1543450238990;
        Wed, 28 Nov 2018 16:10:38 -0800 (PST)
Received: from localhost (c-71-197-186-152.hsd1.wa.comcast.net. [71.197.186.152])
        by smtp.googlemail.com with ESMTPSA id y29sm87131pga.59.2018.11.28.16.10.38
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 28 Nov 2018 16:10:38 -0800 (PST)
From:   Kevin Hilman <khilman@baylibre.com>
To:     He Yangxuan <yangxuan8282@gmail.com>,
        linux-amlogic@lists.infradead.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, carlo@caione.org,
        narmstrong@baylibre.com, He Yangxuan <yangxuan8282@gmail.com>
Subject: Re: [PATCH v5 0/3] arm64: dts: meson-gxl: add support for phicomm n1
In-Reply-To: <20181110033904.4207-1-yangxuan8282@gmail.com>
References: <20181110033904.4207-1-yangxuan8282@gmail.com>
Date:   Wed, 28 Nov 2018 16:10:37 -0800
Message-ID: <7hsgzkd9qa.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

He Yangxuan <yangxuan8282@gmail.com> writes:

> This patch adds support for the Phicomm N1. This device based on P230 reference design.
> The phy is RTL8211F, need to disable Energy Efficient Ethernet (EEE) to make it stable.
> And this box doesn't have cvbs, so disable related section in device tree.

Thanks for the series.

Queued for v4.21 (branch: v4.21/dt64)

Kevin
