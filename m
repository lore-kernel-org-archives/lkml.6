Return-Path: <SRS0=alsP=NS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B141AC0044C
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 18:04:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 78F422086C
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 18:04:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jQjjQwZz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 78F422086C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727998AbeKHDf2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Nov 2018 22:35:28 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:44793 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727604AbeKHDf2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Nov 2018 22:35:28 -0500
Received: by mail-pf1-f196.google.com with SMTP id j13-v6so8015577pff.11;
        Wed, 07 Nov 2018 10:03:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Z3bmz2HlEvYxNMctRBWVMf2OsR+VNaAgKpEUFqKAEWI=;
        b=jQjjQwZzx+7AOvihYumqB48dACecOnfHMvGYVWsGIDwdjVZ5KnQfPviHuqCH2AG3TG
         8QBBjm5kOP5WYWq852icBH+JQEIxgTKGe6LBMQRc/JnQrT0fGz0yHwpI5EmU0CUle/Dp
         OCs3cyYM7REhLF4CajcuBSoLwy9oJcA770hE4FumbWIib6gJxWJqsViIC1mc8lpq6k5F
         2NevHkSeoS92SXfzQbbz8rvOIG9eWSqnE3Bj5x3q0MUuz69c7aaUZluQBhWB2XstvYK+
         pVqY63oAsWUycLMjL1WTEzndiyk1vnnZeV7JNbkeuCcplLKz6IcvZ2WekcJ2RoDk+UPM
         ULUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Z3bmz2HlEvYxNMctRBWVMf2OsR+VNaAgKpEUFqKAEWI=;
        b=a0CtR4VEhr+SzC+hc+3n80Sr4sSTNB4ppgOVkaAsmIXGkGajtTuuT+qGLLWwSLt9/+
         qf4bFu6dflGIVpq9DvT+FlgH+hgEY4n26UeBtWQMq7kcx94LqjLRimHKFsOvrrM+tyft
         ME0dL/EcEv0Ma81d5IWs5Oxi/WHBMRXZfjyrqgaYfb8JHdSx7amkOggETnKBeu5eU8mf
         P306T9oHXu5+gg6ZGcHU/Gq0kpgspV2XF3RDkseKI8Qu7VpWsfrx0oEnhqdSWTJ5de3y
         KJ+E5tt159XFCXjojxz8jvqyi2rlbXFOMby+vPLc36yANKDl8oN3Ty0tZaNgftnv8j3P
         EEBw==
X-Gm-Message-State: AGRZ1gKSTdbbnIQvALPcoQ2lwa/CPV13DmLulW1FKGqACB3MHIfK4fFU
        jeGqCn4vSrJiMQaeZEG089tdSsiI
X-Google-Smtp-Source: AJdET5e1ObyA/jRRg3xPNjjG+TfmhqRvNxSUW3BcJ2blTZ/CoaPuA+SBhAAD/AzIPMYb8eoeMPuLog==
X-Received: by 2002:a63:e101:: with SMTP id z1mr1019627pgh.310.1541613837710;
        Wed, 07 Nov 2018 10:03:57 -0800 (PST)
Received: from ?IPv6:2620:15c:2c1:200:55c7:81e6:c7d8:94b? ([2620:15c:2c1:200:55c7:81e6:c7d8:94b])
        by smtp.gmail.com with ESMTPSA id d3sm1040685pgl.64.2018.11.07.10.03.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 07 Nov 2018 10:03:57 -0800 (PST)
Subject: Re: [PATCH net-next] inet: minor optimization for backlog setting in
 listen(2)
To:     Yafang Shao <laoar.shao@gmail.com>, davem@davemloft.net,
        edumazet@google.com
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1541589617-1607-1-git-send-email-laoar.shao@gmail.com>
From:   Eric Dumazet <eric.dumazet@gmail.com>
Message-ID: <4d902d32-c914-7cdd-be2a-e6595ebc8c7f@gmail.com>
Date:   Wed, 7 Nov 2018 10:03:56 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <1541589617-1607-1-git-send-email-laoar.shao@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/07/2018 03:20 AM, Yafang Shao wrote:
> Set the backlog earlier in inet_dccp_listen() and inet_listen(),
> then we can avoid the redundant setting.
> 
> Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
> ---
>

Reviewed-by: Eric Dumazet <edumazet@google.com>

