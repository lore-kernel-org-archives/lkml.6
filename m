Return-Path: <SRS0=aTzB=K7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 794C6C4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 19:48:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 307972147D
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 19:48:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="JClLgl1l"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 307972147D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726127AbeHPWsZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Aug 2018 18:48:25 -0400
Received: from mail-it0-f68.google.com ([209.85.214.68]:40090 "EHLO
        mail-it0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725762AbeHPWsY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Aug 2018 18:48:24 -0400
Received: by mail-it0-f68.google.com with SMTP id h23-v6so8333298ita.5
        for <linux-kernel@vger.kernel.org>; Thu, 16 Aug 2018 12:48:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=VrL2BgKt+//6IQ8NJg5P1GlAM8YAJpsRRATPQJgvsvw=;
        b=JClLgl1lke3Zf6DykB95rLiu0aqAlKhMGtrPz+DQqc4uUkKXtliuGcV61gbbThdOEO
         S3LlLpRGAYwrV54ndHTSHQ0AjMC4PIKJI5Xp3vTjRL+EqVMBD7wQoDwGNR6tkTnuX9hb
         GItdEq0vWiMZXPaN4sGkazFvqDEaAujai6L7fmdZT26JGJCTQNxenyCYAPXzO9dIfkjl
         zV7UzQ/SsfEOMIOcGzZdlaTAXDWQ3EcTmYYjYF+yYHt/nFe6UMiSIbcyH+LL9EcZlKiz
         Eu94HnZlFdwdCltAsYWB7iFE6ijeywfpY5lBlmeGXoMLRp6YNwWfrnRs75R5yKKpy7uH
         S4rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=VrL2BgKt+//6IQ8NJg5P1GlAM8YAJpsRRATPQJgvsvw=;
        b=hJrcdXN9FvBGZfBwZKqL0VhS02qeqbk4Xvy5oR7ZdWYCNx9Sw7tIp3VPO+jgKtDbZL
         6bqBgtWg+DRJKLVV4r1x+WuEidSCR8xFHom6vVTlowV2TDCAoTg4ziPGE1qDFe5+JWmg
         WxBaPA/oUkQ99voAw/I4J8blLeUY1C3ng6y5tsLtIloAfuIjR64SIvBg/AwaZxiVjqB4
         wKKvDHs/aRYJRnSPKyynSJUduyYXaGunVS6nDDtb+PA865+dxtEVN6iga0fvbuvGNhT/
         r3nKEiTHPphonc5sNWIYLKoJciuykkgEf4eKfPFqFv5Mujy3HAnugRvQEt7CtLqUFNM4
         AHgA==
X-Gm-Message-State: AOUpUlFF0qjCq3qDvwGgu2UEGkFHlawaZHGDsulHtb6sAcfCax6ZWCP1
        DKV6ImY3LLnfppjqwIiRTXJObulP+v0=
X-Google-Smtp-Source: AA+uWPzkugl/gKQ9UKnX/WoBkSbnHOeyAETTT/B3ZSmufj/N/HCRiCJScIozcfJpo2l9HlYceaEmAg==
X-Received: by 2002:a02:986d:: with SMTP id x42-v6mr28745441jaj.131.1534448880294;
        Thu, 16 Aug 2018 12:48:00 -0700 (PDT)
Received: from [192.168.1.212] (107.191.0.158.static.utbb.net. [107.191.0.158])
        by smtp.gmail.com with ESMTPSA id v5-v6sm53710ioe.61.2018.08.16.12.47.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 16 Aug 2018 12:47:59 -0700 (PDT)
Subject: Re: [PATCH] blktrace: Add SPDX License format header
To:     Steven Rostedt <rostedt@goodmis.org>,
        LKML <linux-kernel@vger.kernel.org>
Cc:     linux-block@vger.kernel.org
References: <20180816154403.3c53cddf@gandalf.local.home>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <762791fd-d0c2-c0fc-fbfe-5e01f4a858c0@kernel.dk>
Date:   Thu, 16 Aug 2018 13:47:57 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <20180816154403.3c53cddf@gandalf.local.home>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/16/18 1:44 PM, Steven Rostedt wrote:
> 
> [ Jens, I'm adding SPDX headers to the tracing directory. Can you ack
>   this patch? Thanks! ]
> 
> From: "Steven Rostedt (VMware)" <rostedt@goodmis.org>
> 
> Add the SPDX License header to ease license compliance management.

Acked-by: Jens Axboe <axboe@kernel.dk>

-- 
Jens Axboe

