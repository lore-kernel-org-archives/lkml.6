Return-Path: <SRS0=ZsYk=KH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B24E4ECDFB8
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 02:40:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6B0482075B
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 02:40:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pBS/Yxk5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6B0482075B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387763AbeGWDii (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 22 Jul 2018 23:38:38 -0400
Received: from mail-pg1-f180.google.com ([209.85.215.180]:33836 "EHLO
        mail-pg1-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387732AbeGWDii (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Jul 2018 23:38:38 -0400
Received: by mail-pg1-f180.google.com with SMTP id y5-v6so11134666pgv.1;
        Sun, 22 Jul 2018 19:39:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:subject:to:cc:message-id:date:user-agent:mime-version
         :content-transfer-encoding:content-language;
        bh=OiW7dNAZjvEXmSzT3V5UIsnDJ30DuHBwnXy9+RXreSM=;
        b=pBS/Yxk53WbpyA7tFC47QYNBrIa+dKZ1XW5hn08mHcvmoPJPehHjz07yzNbRVs7ybA
         5yc1at8LpxgOxh2+bwBAd2hprB3lhmv35dc75waU82SabKOF+Zf3YrnqHJmfQ77Q/LCw
         4zYiIBn0JAsn7zYz02L/G0thNJCG8shnihDvZ10DSottEY/vtSDIBdogWD2GtCmKgpQm
         eOjGwwp5JEIkZtkexpGIGQKs7x3ACYui0x4bEgKCvalXXoMCu5Ad3g24Z9kahOigC4uy
         lxeFX39JvoHAXzUku+xZw6yX4UeNr8A3M17/rjrBq0fnoC+dgV91ui5KL7vMLA+S/Jze
         3BpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:to:cc:message-id:date:user-agent
         :mime-version:content-transfer-encoding:content-language;
        bh=OiW7dNAZjvEXmSzT3V5UIsnDJ30DuHBwnXy9+RXreSM=;
        b=JMGxQytI69B9pf8ogdBcV0166N1qiPs+qs0mhlMzi2W/OuyT/naDT+v64+8ozL8aTi
         2Wgd8d9gEtJE76atlb7UY8akGSN8tfuQQKFrp5p6WFdzeQRAzv9kmDcct2XcculaVzdD
         DNviPqYhKFDd/s9f7bh99mvVnxEVIEbbD47OXBsbr71TAGGMqxBLxMGp1wzVTzYI/xKC
         Ba4AJ7q/yeZci2fUD248g+dyKtdZQMokX2Qu0YcmW6UrlxeWW9qFjBRJNU0rnebMsB8B
         /nq2kLQsPks1oUHjQELJs6/NCxZuByP73sCREhlco2g7x+dsPIFOCKCd5K+ZwHphYLTK
         tS9Q==
X-Gm-Message-State: AOUpUlGbqlHGaBMr45hU0XuXTAde05V7mP8P30WH31caAMu/LqcA0u9L
        iaQk8RMvjAtQjhj/tGF6GYpshLyd
X-Google-Smtp-Source: AAOMgpdkkOxJQijCGluKwAXXO28FQRz+HT8E5DAY5WyqZjBmaFhj8mriwvVe47dMoBHraAj08oW0Tw==
X-Received: by 2002:a63:2704:: with SMTP id n4-v6mr10219812pgn.87.1532313584011;
        Sun, 22 Jul 2018 19:39:44 -0700 (PDT)
Received: from ?IPv6:2402:f000:1:1501:200:5efe:101.5.211.5? ([2402:f000:1:1501:200:5efe:6505:d305])
        by smtp.gmail.com with ESMTPSA id j191-v6sm12605478pfc.136.2018.07.22.19.39.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 22 Jul 2018 19:39:43 -0700 (PDT)
From:   Jia-Ju Bai <baijiaju1990@gmail.com>
Subject: [REPORT] Possible unnecessary usages of GFP_ATOMIC in
 crypto/ablkcipher.c
To:     herbert@gondor.apana.org.au
Cc:     linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org
Message-ID: <78a7d726-f2fa-3afb-3451-bbd51a41a48a@gmail.com>
Date:   Mon, 23 Jul 2018 10:39:40 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

My tool DCNS reports three unnecessary usages of GFP_ATOMIC in 
crypto/ablkcipher.c:
crypto/ablkcipher.c, 162: kmalloc(GFP_ATOMIC) in ablkcipher_next_slow
crypto/ablkcipher.c, 199: kmalloc(GFP_ATOMIC) in ablkcipher_copy_iv
crypto/ablkcipher.c, 315: kmalloc(GFP_ATOMIC) in setkey_unaligned

I meant to manually check the code, but I find that there are many 
functions calling ablkcipher_next_slow(),
ablkcipher_copy_iv() and setkey_unaligned(), so I am not sure whether 
the above three reports are true.

Could someone help me to validate these reports?
Thanks a lot in advance :)


Best wishes,
Jia-Ju Bai

