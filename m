Return-Path: <SRS0=pNWC=KQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7DCCC28CF6
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 15:32:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5C301208A4
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 15:32:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SouoTD2l"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5C301208A4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389901AbeHARTC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Aug 2018 13:19:02 -0400
Received: from mail-vk0-f68.google.com ([209.85.213.68]:32907 "EHLO
        mail-vk0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388988AbeHARTC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Aug 2018 13:19:02 -0400
Received: by mail-vk0-f68.google.com with SMTP id y70-v6so9501679vkc.0;
        Wed, 01 Aug 2018 08:32:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=/CVGwgrtfZ+fQeMBDW7x1DZyW90d5yudnimfRxtF+jk=;
        b=SouoTD2lIPMsaQhxCHhhRfBmLv476NgRmB63r0Wol3H5Jh7I4tAA5BPZhR843bjkmi
         VyTZJ2U5JgW8FAEpKcOenYqeAhXI/O5XHqtzBQBaau2X6uCPkbAZZZLLdYXlpzVXbTWy
         53S7YTI9pr5QMbbJ1H+hrtz9L6G6/ytWSlIY57uVkyX3a45bZiTWVtIZ/5PbDxRTo9uE
         onq4xnZJr5FZF4kBncIKJcnAbSZzxn/XEk4DTbJqDLThini/FzeOojCgj0oED6WILvLc
         HipY7ey3vxNLDRBgvm7GXgfzcxKtiRhnyakEVfoMxRaaVL7IJKTCgZMRbRksrEc2PbhH
         Mweg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=/CVGwgrtfZ+fQeMBDW7x1DZyW90d5yudnimfRxtF+jk=;
        b=aSRuepO8x5SjV81Y8Tz9E+1rPtEMhqP8L1WXhyW3TzkZS8HkpC4C4s3ew2VPVL1vAn
         K0NHAbjEQfqWTcR356V6G7hsYAYxH2yZx9VdHvEN9Y8+QFWXKbHbFO2ZQejt5j1jN0fx
         DvH4SkGYoE7Dj4vF1YyWA9ocDhJCBJZV0+dTG2iEDAi7KbZI0k5rLhUS1eyR68VCf7Nm
         bl6g8OkKBqrJzTbIH/VbdES/2pdACcv8CrQV8aBbgWsWCFiV0eoLbv+kYQ9cvkvhJZDr
         L/KtpUbKvDenWyz2jOMlJNDhShcmFmnR1KNFYexJGALXO0f8huV6B0wJd4GDu/bPodZ7
         iYbg==
X-Gm-Message-State: AOUpUlHgEu4hhitwzTpUMsf4Oz+36Lwp9Qrme+qP/HSC0KSV2dul6SN5
        X9u3ntnYEdTaAAkPXSDPQH/70z9K6Xi/tbUPsOQ=
X-Google-Smtp-Source: AAOMgpeVRolvqjAggs/klELsQYCYSI4jWTj7SleAcDkRmRnKBpLpNxAu2WAbe9698CGlwI7AN/1ek4hmAVzx+D8LAIA=
X-Received: by 2002:a1f:844e:: with SMTP id g75-v6mr17283892vkd.16.1533137566391;
 Wed, 01 Aug 2018 08:32:46 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a67:2149:0:0:0:0:0 with HTTP; Wed, 1 Aug 2018 08:32:45 -0700 (PDT)
In-Reply-To: <1533129976-51930-3-git-send-email-zhongjiang@huawei.com>
References: <1533129976-51930-1-git-send-email-zhongjiang@huawei.com> <1533129976-51930-3-git-send-email-zhongjiang@huawei.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Wed, 1 Aug 2018 18:32:45 +0300
Message-ID: <CAHp75VenNAyShMv_GhMZrwnOKpDHTxRTsx_h_sQcLR-RkJj5Zg@mail.gmail.com>
Subject: Re: [PATCH 2/4] drivers/scsi/dpt_i2o: Use dma_zalloc_coherent to
 repalce dma_alloc_coherent+memset
To:     zhong jiang <zhongjiang@huawei.com>
Cc:     John Garry <john.garry@huawei.com>,
        "James E . J . Bottomley" <jejb@linux.vnet.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        aacraid@microsemi.com, linux-scsi <linux-scsi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 1, 2018 at 4:26 PM, zhong jiang <zhongjiang@huawei.com> wrote:
> we prefer to dma_zalloc_coherent rather than open code dma_alloc_coherent+memset
> , so just replace them.

Capitalize your sentences along with proper use of function()
references and comma(s).

... dma_alloc_coherent() + memset(), ...

-- 
With Best Regards,
Andy Shevchenko
