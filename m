Return-Path: <SRS0=/0sc=JS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F8B4C3279B
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 14:27:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2B6522550D
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 14:27:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="hNbsq4mP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2B6522550D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752368AbeGBO1K (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Jul 2018 10:27:10 -0400
Received: from mail-io0-f173.google.com ([209.85.223.173]:44027 "EHLO
        mail-io0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752247AbeGBO1E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jul 2018 10:27:04 -0400
Received: by mail-io0-f173.google.com with SMTP id i23-v6so14877811iog.10
        for <linux-kernel@vger.kernel.org>; Mon, 02 Jul 2018 07:27:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=bjzSdOj9DQ+d/HcGgyZxG9lcsDXyXy57NtwCbeA3fcQ=;
        b=hNbsq4mPBNcNod8DxrK4YdrCBpwc3tziRPr41NrPM3Sw0Oi+a6OsQLrIzEZ/LGOx47
         TKQb3FGPPVgyMo7zV6JqbTBbozy3IOoCTMAd/apJr9Aa/8PtBj8A+Mh//j9ehYdnMpSz
         ITLtt4WDKG9x9mi6zSOy+mIX9BU2zub6Duswknj3J4JjtKV6vvsQ8YqG2hYcOmU/PPGE
         rttkLwMytORyqILJcAWEtgBJSkq2RpHK26pAIvXUeJ4MI8zNCdqclk4ood569Mq4Wf+k
         A3DMbWLQLKU4qvvwy3oWzY8tmpbO5vTb3b8HxrtswW0nJ2gWIcvCpVKLBEISnz2t5Cf3
         cvGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=bjzSdOj9DQ+d/HcGgyZxG9lcsDXyXy57NtwCbeA3fcQ=;
        b=XZV2CQvY3pe8PYvVM11l6aI/JIQmFQL/sEAZMI3vygNnH4VhPF2n5q1wieIi8fCo73
         alp8p/S1SGL9Ldu82j1In7uOAnYrhf9/VjOAcqqSC0LB6mQ/iCL7OU0xmfgsjM0nKNh2
         SGTRL75Oo4k60vovc2kOjb1oTQBKVpVW0Fjvan8ZWkRvHDz7qnjM3+jESz8wtf0RxvTw
         HEhQnb+jktTNVDqH0vucUpy+7M1osFb4SyKsvZLFMQ4Nx9uq8s6vSuJAKYjPtrQbLs4/
         59SXKPd33XAFsHqEKdmZGv5PBLVQGgowkWr8j38kIE4cGZhpNXbtAxb+ut32eHmWfH1s
         2+EQ==
X-Gm-Message-State: APt69E2JttWqVYcZqGt2yhkEvRdXkJN3cpRes6ONCm7kQb3Otyb1WetZ
        oqGS8pOZmEi4XEUW0rti5iBEj971IyI=
X-Google-Smtp-Source: AAOMgpd03x//UYq787yHe/Prgu6yX9hfUP2ePxz0uPJpK/Lm0/2s7w5DM38K+4vMX8YRgw9lDh17hA==
X-Received: by 2002:a6b:fd01:: with SMTP id c1-v6mr21233961ioi.6.1530541623225;
        Mon, 02 Jul 2018 07:27:03 -0700 (PDT)
Received: from [192.168.1.167] ([216.160.245.98])
        by smtp.gmail.com with ESMTPSA id j11-v6sm3951606itb.16.2018.07.02.07.27.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 02 Jul 2018 07:27:01 -0700 (PDT)
Subject: Re: [PATCH] block/floppy: remove redundant variable dflags
To:     Colin King <colin.king@canonical.com>,
        Jiri Kosina <jikos@kernel.org>, linux-block@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20180702074234.10435-1-colin.king@canonical.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <def4a200-a68a-3290-73d5-bd1c98626283@kernel.dk>
Date:   Mon, 2 Jul 2018 08:27:00 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <20180702074234.10435-1-colin.king@canonical.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/2/18 1:42 AM, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
> 
> Variable dflags is being assigned but is never used hence it is redundant
> and can be removed.
> 
> Cleans up clang warning:
> warning: variable 'dflags' set but not used [-Wunused-but-set-variable]

Applied for 4.19, thanks.

-- 
Jens Axboe

