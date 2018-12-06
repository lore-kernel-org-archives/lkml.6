Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E22E8C64EB1
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 17:51:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A30BB20878
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 17:51:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="VIqjwJKw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A30BB20878
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726015AbeLFRvg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Dec 2018 12:51:36 -0500
Received: from mail-io1-f50.google.com ([209.85.166.50]:41827 "EHLO
        mail-io1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725930AbeLFRve (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Dec 2018 12:51:34 -0500
Received: by mail-io1-f50.google.com with SMTP id s22so1049542ioc.8
        for <linux-kernel@vger.kernel.org>; Thu, 06 Dec 2018 09:51:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=p+Rx8CLlS6c401nqoIEnCpIsNrBL9fyp9Oc6jt1Tq/4=;
        b=VIqjwJKw3smg1cWJh/wIPcBRMymm2SYM9WBebm5zk+ed2CV931tKYME84zMiLRDKnw
         2bch/XEgYWaAwrnUvIJ4ACQu78vbStAl5PQeTiMGqHsrrW+3Icq/XqrX+ifLa9z/1Dry
         dmebjcev4p0DY/xiKbvHYg3iEGLtvdztXo5TxJLxQOHD1gCdOJOKi2dcoJshkkWZvUPj
         Ry3FmLaAEv4UepKn8AcBCPHb0NpriDDy9+mW1puyYI+a6HFpyEtwXgTL7sDuLcmiHthf
         RDGwxEbKdn5My2vwCNdH/v7xnYPrV7W0na49tHoYwZgcFgy1fvM3F+E4OJB1vzG9jHFn
         /Z2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=p+Rx8CLlS6c401nqoIEnCpIsNrBL9fyp9Oc6jt1Tq/4=;
        b=MWb6uyG7uyDI8a/bHZqgOK38p+qIr883lZLjJJfOPEcxlkblywGegMl4EPCvNvYLXv
         LbvvkO1Hea2oBaauDnzLZNUIq+vl12THNP4dOZBK98kLr5ymiw0L13TpUZgTgpyGSHKB
         oapHoVwlqMRcfWn4wcJsbtPudRL8MTfV98aNXHx8p+HF6SP0uZMA2gZzzosTO8/NrYR2
         pRC+6l8E1Zwu8kg7d6DkkQtpTztN7YhIZO1zP/xn0otDvGO9SN5kR4dUPLuTVdfcGLIu
         ULrYdKERtxyZoO//AwRCplfVBq1AW2Rs6RgB3GnQCXKe/La4kd7mqTLZLDr6JiK98U6P
         uAbQ==
X-Gm-Message-State: AA+aEWaF2fOel5DFc1jXObvhqNU7o7+2YGwHx3xu05ADdYRZhK34UWc9
        UWM+B0u0OiF6TLTkz7FhVo6meQK06KQ=
X-Google-Smtp-Source: AFSGD/VhEVg4IpEMcqNRlzNeMlHtUoiv6smqrVQ6pAJ9+CnRVHj397rPiTCuEBptzrhB5P7bQmF78w==
X-Received: by 2002:a6b:c402:: with SMTP id y2mr1302259ioa.77.1544118693023;
        Thu, 06 Dec 2018 09:51:33 -0800 (PST)
Received: from [192.168.1.56] ([216.160.245.98])
        by smtp.gmail.com with ESMTPSA id w13sm692421itb.10.2018.12.06.09.51.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 06 Dec 2018 09:51:32 -0800 (PST)
Subject: Re: [PATCH] blkcg: put back rcu lock in blkcg_bio_issue_check()
To:     Dennis Zhou <dennis@kernel.org>, Tejun Heo <tj@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Josef Bacik <josef@toxicpanda.com>
Cc:     kernel-team@fb.com, linux-block@vger.kernel.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20181206174938.2326-1-dennis@kernel.org>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <d179c449-9593-8630-2a01-8a625f2b7e67@kernel.dk>
Date:   Thu, 6 Dec 2018 10:51:30 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181206174938.2326-1-dennis@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/6/18 10:49 AM, Dennis Zhou wrote:
> I was a little overzealous in removing the rcu_read_lock() call from
> blkcg_bio_issue_check() and it broke blk-throttle. Put it back.

Applied, thanks Dennis.

-- 
Jens Axboe

