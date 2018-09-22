Return-Path: <SRS0=j7Hi=ME=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,URIBL_SBL,URIBL_SBL_A autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE799ECE561
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Sep 2018 12:28:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 80BF92150F
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Sep 2018 12:28:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XS16lXWg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 80BF92150F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729998AbeIVSVt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 22 Sep 2018 14:21:49 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:41283 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728381AbeIVSVt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Sep 2018 14:21:49 -0400
Received: by mail-pl1-f195.google.com with SMTP id b12-v6so7133375plr.8;
        Sat, 22 Sep 2018 05:28:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=34AiWf0Zk2gR11ztDu7Xs2S0y8BXvwR1qi+t6j4dTJo=;
        b=XS16lXWgvdBxjryjY3eKaUzeorTrcJv/jpTJu0zB0hCNGYlyNZZ8jP2EqtXyxQ3hY/
         5ThOQDmDOl5BOcCnDJ9F3XErRZCXFG52qIPcYuuBOB3A6EAdkNEiP0jbqNAhhX5ADuPV
         96V0XDFrxScbpyqpKvahKKBp46TRGkJjml4dcbR3m6eB3kF9HBEx2ZakZWgQ7PC55ITM
         q7mv1eZoFoVhC6Wp7UMrCHfPMR+yLioZnSQBZ8SSeTnHPlz/xWtuKXjQ32iY4igESdmJ
         ZgnNYxnjOMm6oV17zBPmd8Qk8Y2gv7Kioqr6OEXB6aVRCdK8Mh/HO4jTK4+87k7WNIA8
         Lfpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=34AiWf0Zk2gR11ztDu7Xs2S0y8BXvwR1qi+t6j4dTJo=;
        b=q8O5uIzfUUNfBBP/+LcA4v7jhm0gKBa5+XUqLcdb0uwA3ZzAJgWcL1TwGJlOmw/01u
         mukAlKqnzSxL+MGSLA0p/KXqWebimWipt7ZE6a4STDm1nIm7QE4UhpReaee9iw7tWIK+
         0Swg/Qdb4U9wKVNZGq8p+YSzxz2m6Ui1ng/XPNxBm9soJq9BqjkPrb/NhONf3bLlIdpq
         7vdN+zpeASSwG18LUaqdl9tF/bHlprOo2rj2ppTKqrhKBCx1mFphJz/8jXNQM/8DjU36
         RP+VNTaMoT3cnGpcHTPH/9wmbmZK7L0cZinOYbMExy2DZRuYcZUGZrlU1Y4BestuKNyF
         iPJQ==
X-Gm-Message-State: ABuFfohRmJmV2/S3JE8ISykv0qEUHftcUqSaEmvKklqAcxvY/ocGJULw
        FwL785blgZ4iyP2vMCs9ODxNBzBF
X-Google-Smtp-Source: ACcGV61dCDhAojbdfj/CWAGcEoO1ovXvmbRbcjPrDlW2XDdSUKq6ykMeKszvsr+mgbh6qXq5ki9A5g==
X-Received: by 2002:a17:902:b089:: with SMTP id p9-v6mr2510415plr.254.1537619304489;
        Sat, 22 Sep 2018 05:28:24 -0700 (PDT)
Received: from server.roeck-us.net (108-223-40-66.lightspeed.sntcca.sbcglobal.net. [108.223.40.66])
        by smtp.gmail.com with ESMTPSA id a16-v6sm32510695pgv.29.2018.09.22.05.28.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 22 Sep 2018 05:28:23 -0700 (PDT)
Subject: Re: [PATCH 3.16 00/63] 3.16.58-rc1 review
To:     Ben Hutchings <ben@decadent.org.uk>, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
Cc:     torvalds@linux-foundation.org, akpm@linux-foundation.org
References: <lsq.1537575341.194909669@decadent.org.uk>
From:   Guenter Roeck <linux@roeck-us.net>
Message-ID: <3c4507c7-d805-5895-e634-09e7ba4e2c4f@roeck-us.net>
Date:   Sat, 22 Sep 2018 05:28:21 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <lsq.1537575341.194909669@decadent.org.uk>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/21/2018 05:15 PM, Ben Hutchings wrote:
> This is the start of the stable review cycle for the 3.16.58 release.
> There are 63 patches in this series, which will be posted as responses
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Mon Sep 24 00:15:41 UTC 2018.
> Anything received after that time might be too late.
> 

Build results:
	total: 139 pass: 139 fail: 0
Qemu test results:
	total: 217 pass: 217 fail: 0

Details are available at https://kerneltests.org/builders/.

Guenter
