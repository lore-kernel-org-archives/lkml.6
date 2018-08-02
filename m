Return-Path: <SRS0=MSGh=KR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22B2FC43142
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 15:57:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5CC4521527
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 15:57:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="eJtjd2aA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5CC4521527
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387814AbeHBRtc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Aug 2018 13:49:32 -0400
Received: from mail-io0-f193.google.com ([209.85.223.193]:37327 "EHLO
        mail-io0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387538AbeHBRtc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Aug 2018 13:49:32 -0400
Received: by mail-io0-f193.google.com with SMTP id z19-v6so2364451ioh.4
        for <linux-kernel@vger.kernel.org>; Thu, 02 Aug 2018 08:57:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=z5gNJTB5VCneB4YuCnqOEvbyqaExEw0qX6x4rnVFy9I=;
        b=eJtjd2aAFdGVAaIApbi1v3iql1YnXPPvzHx/GXd7FwT+Y45zxq14QTZ9G5uCfge4LP
         Y18prJD5lHhDqUxYLNgcdNj1TxbigM7GBpC7fqhFF3WNLwkpaO6eyHS+mpy9WTounFLr
         5da9bjQLDMe4Ghqxcm2ga5mc6jzqL2RElKP+Byri5yjOvlqmIfwG3hczh+XhGyz9Tdoa
         JZZBywiaFUoheJYdS+bX+Zp9HkwiCIxiC9+bVLbLDFs+aD/TQfTzVgtjVgw6wZm6Wno7
         Xz52U+33v8BimE6sPXFUt3oo94i7nMCT2TO/EDABk3OxKWPUGvpAW+zZIFMfn4HD2wwv
         nbnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=z5gNJTB5VCneB4YuCnqOEvbyqaExEw0qX6x4rnVFy9I=;
        b=LVi8vc903pli3mJOW1k/5V3QWKeX021NePogAZ90PuW+iNrF1y51qPChDF/3BE2fOe
         bi0uXFeUePA4UDCw/9Aa1cdZ3eQHcwqPKm+c+AOJVmiNMWsUaVc3awb/w39vOhdOHLQt
         xHcQbWcQRDxFBu9V6g2vru0Qp25t6ALtcQqV7E1l6BF85+ZNcbfRl1Q2Ku2ZLLdj2ovo
         RPWcr+Tx7GeJSW9gu0c+wXQs/KARf+axTgsuc2NWM0rPiyzy9LQ8yt+dNP8nAMYnSqP3
         CYHQD97EDizz4wF1WQRptLttrfCoCh789LZ8tl85fDgs6UDJr3NuRkW3yykpzLU3GKUI
         oVOw==
X-Gm-Message-State: AOUpUlGmFl4IJXoIjck+yoa3DuI26nh98gXE0INMmZifriQgxtxUK5iz
        JYyh4fvl36X23EJvY3AYfuuhiw==
X-Google-Smtp-Source: AAOMgpdnsS8B8QI/YhHljYlWqXZdns7ON/vUtJX4hEIxsjs8CvxHB9FIpxmmiwHpIzAgu4rrAprfog==
X-Received: by 2002:a5e:c90e:: with SMTP id z14-v6mr2993406iol.268.1533225465699;
        Thu, 02 Aug 2018 08:57:45 -0700 (PDT)
Received: from [192.168.1.212] (107.191.0.158.static.utbb.net. [107.191.0.158])
        by smtp.gmail.com with ESMTPSA id c141-v6sm1028964itc.42.2018.08.02.08.57.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 02 Aug 2018 08:57:44 -0700 (PDT)
Subject: Re: [PATCH] lightnvm: pblk: take write semaphore on metadata
To:     =?UTF-8?Q?Javier_Gonz=c3=a1lez?= <javier@javigon.com>,
        mb@lightnvm.io
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        =?UTF-8?Q?Javier_Gonz=c3=a1lez?= <javier@cnexlabs.com>
References: <1533217674-9514-1-git-send-email-javier@cnexlabs.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <2436f855-7a87-9ecd-be3a-358939c9c750@kernel.dk>
Date:   Thu, 2 Aug 2018 09:57:40 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <1533217674-9514-1-git-send-email-javier@cnexlabs.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/2/18 7:47 AM, Javier González wrote:
> Take the write semaphore on metadata I/Os too.

I'm going to nit pick a little bit here, but this isn't a good
changelog at all. A good changelog tells you _why_ a change is
made, not how it's made. Your commit message doesn't really tell
me anything that I can't easily glean from looking at the patch.

A good commit message would tell me _why_ we are now also
grabbing the write sem for metadata.

-- 
Jens Axboe

