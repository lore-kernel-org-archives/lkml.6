Return-Path: <SRS0=3XDn=JT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 236F5C6778C
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 13:52:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C65FE2086E
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 13:52:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="QYj3ks2X"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C65FE2086E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753514AbeGCNw4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Jul 2018 09:52:56 -0400
Received: from mail-it0-f66.google.com ([209.85.214.66]:53087 "EHLO
        mail-it0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753490AbeGCNwx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jul 2018 09:52:53 -0400
Received: by mail-it0-f66.google.com with SMTP id p4-v6so3208720itf.2
        for <linux-kernel@vger.kernel.org>; Tue, 03 Jul 2018 06:52:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=+1LoksrLzcLmOkChyKNyGO36IRF4oIDoRG5qqOLhPPM=;
        b=QYj3ks2XioMp9sVelpd0Dbib2UDGmxpz+ECfi2hlfIgNFQdZ7l0MY3G7QnuuzOpMZz
         UmeQxchoMonoU2mpKTTb5RlDTIZj9st2JyueM6dlC5z3i2AD5RyUlnmeklKY4Rm3m+zL
         Of3TlIaxZAhapwWWrFcv07VPXH8qEeleQHnCyVhbUDyC2bPTr+FxEmWlIgn9d/YtuPz2
         Xm+Ruy89fOBX+v55kM89PRPmQA+mUGRlF4P0vQt/KsQVmGxHIcfJo178c9VH4LzqTgz3
         kbEg5Tn0358ljri3CCgjGMGbD1rxgL5GVk4rXV7lBd6sCGa+lHw3zv6UJcnxzUNadorQ
         knFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=+1LoksrLzcLmOkChyKNyGO36IRF4oIDoRG5qqOLhPPM=;
        b=UzM2CWYxOqp30/R0AMIYkgQfMzCuaAT3ElScy/6bxxhLJgx5LSEpGLEu0LgIsUH3sy
         etrOMe5l5ii/KRCqzhhSiRgK990dg11xQKZku4WAkZ8Z1Mtam2qIu7M/y+009jayGf3X
         3qVPl2b3kYnCw2r3cEgwDaPaxV9eKYCfTVWD3gkgjk8ywSy5EV9uNfeo3gdmdCXhi7V7
         awQHMSGQvBwJJ3/r3xJ3gmY/Zwft06GccI1SJfZvw/9ee0uYnoDAiSJzD+Ved9GrMQFZ
         N5uTeuNlZCLXLy0IbdOrds7iBaycgZd23EncY/Do49gOeJa1G+vGxWgT0+Q224w7MTwY
         UhMA==
X-Gm-Message-State: APt69E2+86ye0+NTYESqMreJ9eXK/CVVOj1VeTrmPnGU839a9d06Navy
        CuE+rUjWop9GFtp1U87r/ezDS1EBK6g=
X-Google-Smtp-Source: AAOMgpeFthL8wcP0HmTB5FXhG8SGWbm6k8gS4XWKg47y/P+cs4SQqp00Ikz9aDErlMi/DEyrK1Uk3w==
X-Received: by 2002:a02:35a:: with SMTP id y87-v6mr4151451jad.2.1530625973218;
        Tue, 03 Jul 2018 06:52:53 -0700 (PDT)
Received: from [192.168.1.167] ([216.160.245.98])
        by smtp.gmail.com with ESMTPSA id c25-v6sm414020ioi.3.2018.07.03.06.52.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 03 Jul 2018 06:52:52 -0700 (PDT)
Subject: Re: [PATCH] loop: Add LOOP_SET_BLOCK_SIZE in compat ioctl
To:     Evan Green <evgreen@chromium.org>, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Sam Hurst <shurst@google.com>
References: <20180702230346.72350-1-evgreen@chromium.org>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <c507d876-baa9-8294-f8f9-790be3bae3db@kernel.dk>
Date:   Tue, 3 Jul 2018 07:52:51 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <20180702230346.72350-1-evgreen@chromium.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/2/18 5:03 PM, Evan Green wrote:
> This change adds LOOP_SET_BLOCK_SIZE as one of the supported ioctls
> in lo_compat_ioctl. It only takes an unsigned long argument, and
> in practice a 32-bit value works fine.

Applied for 4.18, thanks.

-- 
Jens Axboe

