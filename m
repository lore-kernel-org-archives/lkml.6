Return-Path: <SRS0=pNWC=KQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0E49C28CF6
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 15:31:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6DE0B208A4
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 15:31:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="vNOcfSRl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6DE0B208A4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389827AbeHARRP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Aug 2018 13:17:15 -0400
Received: from mail-ua0-f193.google.com ([209.85.217.193]:44300 "EHLO
        mail-ua0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389437AbeHARRP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Aug 2018 13:17:15 -0400
Received: by mail-ua0-f193.google.com with SMTP id k25-v6so12966713uao.11;
        Wed, 01 Aug 2018 08:30:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=GUqqP1qwfkZ+JyeiXNxXrY3dVLGjZ79Mq7H/DtjqQR8=;
        b=vNOcfSRlFKVHwcEeh57TP4s8/08rqRaidSQy5HCpqxYrY3qvAsjLQcXuFCM+9EyHEl
         bYqG3XiHJG/UxraV+4N6bD3aNJUQvyrYqqzTCEGzoWcj57pQdG8Sz2H8wuSJ7Sdyzyx0
         puKs+cXRQ2X4q2sUt6erYBukcCz/A+9gP6IznbhOEspnFKr6OrUbepiBvyzZEYTNbZ0S
         Rfnu1LdgHK+VdByMGxG36hzXrK92+bOfFzhS2NKhlBOow2Lw8ThNwZEyAvx5fljmEGIx
         1VJiOJpjdCmeVVZ3ZeqNdsjRNUs/AFpyC+9JHLek3zLxiOl/hWDTDsPrq2cOTSaeHgm4
         kVZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=GUqqP1qwfkZ+JyeiXNxXrY3dVLGjZ79Mq7H/DtjqQR8=;
        b=V1rlTy8vykuoQQKW+148xSyA6R+IGLWzNkkDhmvmzBNvoBXtvKs4tykF9MA7TgVV5e
         xE86KZTx1ZaUXkG/AAhbO+iMUhnEThF5YLdMHN2D2LKz9AN0Cqj6dODtWZ30joCd2hIJ
         yBInmQSEeD5cib+y5hrQ4GEi0PKQ7CWytw00ajn1CUH4z2iOC+yuICYRJv/x3h3ryZqH
         CYttSoWuVbZof+XllBLBG2v8eg6bqwiWLWWhwRzWNXZBgkG+7gKbmpWy92+d3iev8zu/
         gEwgXearnPBJKPYoGh8Px0ZkqCzO4gUFPMsLPK8ihoBzc/mVyJj+2qHkIn7ujW2+gy3V
         +NIA==
X-Gm-Message-State: AOUpUlE+/22KJmxWeqTFVJnfo/yg3n4zhYgBZ1535H3kMK6EbA06wTLV
        CGp1u0vBgLOvri+J2+p13Ut0dK5iu//YNO7n6+w=
X-Google-Smtp-Source: AAOMgpfLX59FkpqybGtDIkBQdxKVonYt11WJLZeEtBEMGkevbLQBLjcLHLWYrnI1PKSv/3SQmNoI0yua9gYvGwZ5jUM=
X-Received: by 2002:a9f:2187:: with SMTP id 7-v6mr19887350uac.49.1533137459406;
 Wed, 01 Aug 2018 08:30:59 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a67:2149:0:0:0:0:0 with HTTP; Wed, 1 Aug 2018 08:30:58 -0700 (PDT)
In-Reply-To: <1533129976-51930-2-git-send-email-zhongjiang@huawei.com>
References: <1533129976-51930-1-git-send-email-zhongjiang@huawei.com> <1533129976-51930-2-git-send-email-zhongjiang@huawei.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Wed, 1 Aug 2018 18:30:58 +0300
Message-ID: <CAHp75Vchu7QwNBeYQxa9fY8=PinGzPpUPaRbk_MyoZ+w07hA4A@mail.gmail.com>
Subject: Re: [PATCH 1/4] driver/scsi/fnic/fnic_trace: Use vzalloc to zero
 instead of vmalloc+memset
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
> The vzalloc is better than vmalloc+memset, so replace them to make
> the code concise.

> -       fnic_trace_buf_p = (unsigned long)vmalloc((trace_max_pages * PAGE_SIZE));
> +       fnic_trace_buf_p = (unsigned long)vzalloc((trace_max_pages * PAGE_SIZE));

At the same time you may get rid of unnecessary parens.

-- 
With Best Regards,
Andy Shevchenko
