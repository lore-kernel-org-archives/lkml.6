Return-Path: <SRS0=qUjc=JZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA49DC6778A
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 10:19:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D26E220882
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 10:19:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=areca-com-tw.20150623.gappssmtp.com header.i=@areca-com-tw.20150623.gappssmtp.com header.b="fWZPRYA7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D26E220882
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=areca.com.tw
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754479AbeGIKTf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Jul 2018 06:19:35 -0400
Received: from mail-it0-f47.google.com ([209.85.214.47]:38281 "EHLO
        mail-it0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754437AbeGIKTd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jul 2018 06:19:33 -0400
Received: by mail-it0-f47.google.com with SMTP id v71-v6so15113108itb.3
        for <linux-kernel@vger.kernel.org>; Mon, 09 Jul 2018 03:19:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=areca-com-tw.20150623.gappssmtp.com; s=20150623;
        h=subject:from:to:cc:date:message-id:mime-version
         :content-transfer-encoding;
        bh=BUiCS/SkCPjpIGxcbztrs0YJD8wP7LLNqi3Do/XLowI=;
        b=fWZPRYA7eiG35yHnIXon7MJoYs8kdwcYh85FnHhvrGpHadjlLvhPPqjblHXrCSwcKI
         6jK4ELiphdkbAneecOEoPZVSZ99r0yxkiLwZjpSqu6JbG+C5XgOrinihDotxHa6RkHTy
         72z0gfUurFXjEvu6ZyZgkpWqMTl+FnIZi7YJBRTGWB8pMbLqvxNcHe3Hp8PhWDxw9H0b
         OwPR+XuZmYZ2xG0fvDvu0C+Cib7Z0bIU/NXpRVoPf+jKP0Yj8ErqNHfMMflKaW57z1WE
         qnMPM0e20AZhlciwLhvfC7mLuyxZutxPQAOJnAuXf65xhbtjIghUq6bqaCnFWblb2ef/
         OuPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:date:message-id:mime-version
         :content-transfer-encoding;
        bh=BUiCS/SkCPjpIGxcbztrs0YJD8wP7LLNqi3Do/XLowI=;
        b=KmOOdyVRW7DeIkPO9uoWn6D1ysjgNd6nmlm3jO1hg36cSWLamsEE0v1hg/44QWsa0Z
         4iIAxM8gdMmgoRSYGqmXXI04BadXlc2FOtxt/x9tlhHPg4xMjkQI46+dqc8w1g2XuEDl
         19HsPW3w8Lz6oAcgPaYaRQ/uAMQAJIIlUNfy7XCFrENDZdq7XhIEkmBKD7DyKwqwCTDl
         SS+3tJ9uyM2Zibfdd+cm3pVX9ERZ46wpcHqfsbd9paCcKBREP4kWXn/SnuefBUdAhUm3
         dUmmyo1+efdDUj2V2EbF0K68L4FASOFTsmEwnKMZDr+yhkUF6TTHg03ROuCCt2BbYBtJ
         vUFA==
X-Gm-Message-State: APt69E1LOaBLWMJJFHBE8xrcXRfdHiIFhQcSv6/uqB9aot25QWifUnpD
        Lcdff1JCYWiijox9EOG93w9QcA==
X-Google-Smtp-Source: AAOMgpfpaAJTEYEButuJSDEd/zcdX/XzMv1kz6MvAgsh2CT/yiW+3BDj8m4M++0j5n5bOPUB1v939w==
X-Received: by 2002:a24:7d0a:: with SMTP id b10-v6mr8568869itc.105.1531131572964;
        Mon, 09 Jul 2018 03:19:32 -0700 (PDT)
Received: from [192.168.0.108] (60-248-88-209.HINET-IP.hinet.net. [60.248.88.209])
        by smtp.gmail.com with ESMTPSA id y63-v6sm7915830ita.24.2018.07.09.03.19.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 09 Jul 2018 03:19:31 -0700 (PDT)
Subject: [PATCH 0/2] scsi: arcmsr: fix error of resuming from hibernation
From:   Ching Huang <ching2048@areca.com.tw>
To:     martin.petersen@oracle.com, James.Bottomley@HansenPartnership.com,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     dan.carpenter@oracle.com, hch@infradead.org,
        colin.king@canonical.com
Content-Type: text/plain; charset="UTF-8"
Date:   Mon, 09 Jul 2018 18:19:28 +0800
Message-ID: <1531131568.5779.8.camel@Centos6.3-64>
Mime-Version: 1.0
X-Mailer: Evolution 2.32.3 (2.32.3-37.el6) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series are against to mkp's 4.19/scsi-queue.

1. Fix error of resuming from hibernation for adapter type E.
2. Update driver version to v1.40.00.09-20180709

---

