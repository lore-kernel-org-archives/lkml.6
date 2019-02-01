Return-Path: <SRS0=KKla=QI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 007F8C282D8
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 15:34:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C3DCA2086C
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 15:34:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="oFsuI+hZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730111AbfBAPev (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Feb 2019 10:34:51 -0500
Received: from mail-it1-f195.google.com ([209.85.166.195]:38886 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729175AbfBAPeu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Feb 2019 10:34:50 -0500
Received: by mail-it1-f195.google.com with SMTP id z20so10320935itc.3
        for <linux-kernel@vger.kernel.org>; Fri, 01 Feb 2019 07:34:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=7Vp+DGBZGxEE2s5PpXWlcivBg5TYRjRohltMhSZAA08=;
        b=oFsuI+hZ+gGJk5IiMJQHDxIc+yOBR7gU198U+S4AR9cnjLDwVRkHuY97NrHy9viyMX
         o72I5eEpNcQG0u/fKE5ZVvKW7uN8Eg4o6vtc408/XLyCl4LdlUGPvuWlmeLYFaNqL9In
         UYoC92lymBiub5uajO3/xSdsnOlvchpCjtLk3bUABkJ7UHzzA1zK8wlY7GQh/sBXmmDI
         4iHw/bzL7SrLvfHg0MX/D8y94Q4rAcGn6buKey8RYbha9uLMtlKigcVq6/HAFC3KIk5b
         rKGbpJ+w2nzxkydXOLZ/klQcQz/VgU3pvtFyRh6mK8EoMVozmNvbcILdFc+vq08MNzuk
         lNdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=7Vp+DGBZGxEE2s5PpXWlcivBg5TYRjRohltMhSZAA08=;
        b=nGAmw2GJNnwxoNtZK+EBHLiKqJbU1GX8VF3Wbxu1tEJscN6giZmVL0qe00x6TkC42X
         NAsPLFaXJH6BRYZVFdGNFuQcdEp7lvIjK46Rc+GpAcWxquTvL4jr0GhPL6OTSKuV3x6t
         s2FiPuECvfltoqT17hzg/V41S3tFud2ipBmm81uUu+x+bRL784uVEyDLIzaktDxWnyhN
         4ke1yaKphJ++qsMIKm6dqk1XeIUeB1BwUAz/hQI2wW8wcw/RP8TFUBLbwDx8KPZdsyTc
         hSyre7Rc79tDa79PN3qkIvQjvWkZ3cJTE2DfMCwVReXZLhuAxmYWVDgK4yMHix8LgrYH
         CqOQ==
X-Gm-Message-State: AHQUAuaiWRBaQf2LIqbZ6ZjgZtah9ne53o+Vpv0UsJCAN8kK+Hs177C8
        Tw6s5uQYYulVIe04fWKfNjVMUXagY6g=
X-Google-Smtp-Source: AHgI3IaHJ1ruAD8kh+MPcHRHHwj62n0G27svaFXj1uQgUdU8CVpEQiJsXo3lX2RbFdZjgJCTUrz7wg==
X-Received: by 2002:a24:3391:: with SMTP id k139mr1760528itk.25.1549035289024;
        Fri, 01 Feb 2019 07:34:49 -0800 (PST)
Received: from [192.168.1.158] ([216.160.245.98])
        by smtp.gmail.com with ESMTPSA id v4sm2061636itv.20.2019.02.01.07.34.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 01 Feb 2019 07:34:48 -0800 (PST)
Subject: Re: [PATCH 0/2] small optimization for accessing queue map
To:     Jianchao Wang <jianchao.w.wang@oracle.com>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1548325533-1695-1-git-send-email-jianchao.w.wang@oracle.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <94a2634f-24e2-b846-9c13-2fc9c0117e0c@kernel.dk>
Date:   Fri, 1 Feb 2019 08:34:46 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <1548325533-1695-1-git-send-email-jianchao.w.wang@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/24/19 3:25 AM, Jianchao Wang wrote:
> Hi Jens
> 
> These two patches are small optimization for accessing the queue mapping
> in hot path. It saves the queue mapping results into blk_mq_ctx directly,
> then we needn't do the complicated bounce on queue_hw_ctx[] map[] and
> mq_map[].

Doing some targeted testing, the cycles wasted on the double indirect
are reclaimed with this. I've applied both for 5.1, thanks.

-- 
Jens Axboe

