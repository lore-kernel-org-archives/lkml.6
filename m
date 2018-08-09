Return-Path: <SRS0=+sa6=KY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD2A8C46464
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 14:35:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 76ADF21EA2
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 14:35:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="Gm/gSf/F"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 76ADF21EA2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732600AbeHIRAk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Aug 2018 13:00:40 -0400
Received: from mail-yw1-f54.google.com ([209.85.161.54]:39002 "EHLO
        mail-yw1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732302AbeHIRAj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Aug 2018 13:00:39 -0400
Received: by mail-yw1-f54.google.com with SMTP id r184-v6so4376044ywg.6
        for <linux-kernel@vger.kernel.org>; Thu, 09 Aug 2018 07:35:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=gbu+4eqNCTqpCMyEE+7cdq1L13h/KvJ7jw03Spl4JnM=;
        b=Gm/gSf/Fpsp6YHEoOeslwVp8EeEonoZ9WEGJoBP32+rQSk9CVu4QkbsIMRH23gzhBI
         9+HGn1YaKQdpgI1KmLvHcq6tMbw5bZclgtFxmtGqksi1bdt1x5s8P/EjUk4LlpPxOTte
         4vj39LncdUWiG4DABn2Lhx/yu9BAQqujsrbiXip534W9S8OZszTNAie43vcjYjwjZa9z
         EmY9FgFtc+X/a/aWEqPeWzaMM2S8sfxE1VXGERX2tGKTkon74HBaX2pQY0arFWXBOF09
         Dlyod2oDkdCYT4bxXDOblQvY2ex2J4KvlG/usr6VAAtUZ4cK8WLsR0Wuzhp3Hnj9Y6Jw
         uSRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=gbu+4eqNCTqpCMyEE+7cdq1L13h/KvJ7jw03Spl4JnM=;
        b=Y2qKQmRmrRp/niu2oBI/PURUKEo1nBsjprKAar5oQSFc4oY2/crjG/El9fqFF5PG08
         pBAgNQUE+/7D4iyLFf4ledwk/X9KIvyia38JkEBK0YgjQ2UR5+2fVr60tIAYcRafhUj+
         /ggTb0D3Gupi63xvvvE9y0rzCelr4qJ4HWqwAyN7SYjy1nSWhu5HUCvsZbFrhvFFb9VS
         kliZoSkjOiO2FmK9E/JTMteZRcK7VOmt7VYNhb8SwxRSlKLyVVH3Ngl6of6tF3M3Q9Kc
         TqYOiV0MYfA7pQOzw0U6+SukxxfniXED7m1oOy3xyOKNuDsVkSmcbEvp322nGj8gz6Bn
         lE2A==
X-Gm-Message-State: AOUpUlFJkTgNws9ZNV9wJyvhSSDO7hHPJwjMRh9RqnHtjk1HMsRjy47l
        wM3xGTfmPyqBHiu4HXWFfMmrO+VCrX4=
X-Google-Smtp-Source: AA+uWPz6ON6/CizY8RytJn6ne83qH7EeXqaEK/it2xRw8YubtCDdHje7Y4r8OMetvLa1SZTK3fhK2g==
X-Received: by 2002:ab0:5c9:: with SMTP id e67-v6mr1600528uae.66.1533825328009;
        Thu, 09 Aug 2018 07:35:28 -0700 (PDT)
Received: from [192.168.1.56] ([216.160.245.98])
        by smtp.gmail.com with ESMTPSA id 12-v6sm2160268vkj.24.2018.08.09.07.35.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 09 Aug 2018 07:35:26 -0700 (PDT)
Subject: Re: [PATCH V3] blk-mq: count the hctx as active before allocate tag
To:     Jianchao Wang <jianchao.w.wang@oracle.com>
Cc:     tom.leiming@gmail.com, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <1533780598-23972-1-git-send-email-jianchao.w.wang@oracle.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <3b980395-5030-34e0-7736-4a5227d8d860@kernel.dk>
Date:   Thu, 9 Aug 2018 08:35:25 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <1533780598-23972-1-git-send-email-jianchao.w.wang@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/8/18 8:09 PM, Jianchao Wang wrote:
> Currently, we count the hctx as active after allocate driver tag
> successfully. If a previously inactive hctx try to get tag first
> time, it may fails and need to wait. However, due to the stale tag
> ->active_queues, the other shared-tags users are still able to
> occupy all driver tags while there is someone waiting for tag.
> Consequently, even if the previously inactive hctx is waked up, it
> still may not be able to get a tag and could be starved.
> 
> To fix it, we count the hctx as active before try to allocate driver
> tag, then when it is waiting the tag, the other shared-tag users
> will reserve budget for it.

Hand-applied for 4.19 (didn't apply directly).

-- 
Jens Axboe

