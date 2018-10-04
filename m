Return-Path: <SRS0=SFDS=MQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8185EC64EB8
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 08:36:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 437FD21470
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 08:36:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cogentembedded-com.20150623.gappssmtp.com header.i=@cogentembedded-com.20150623.gappssmtp.com header.b="i1NtUt4k"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 437FD21470
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=cogentembedded.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727631AbeJDP2q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Oct 2018 11:28:46 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:45101 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726808AbeJDP2p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Oct 2018 11:28:45 -0400
Received: by mail-lf1-f67.google.com with SMTP id m80-v6so6134009lfi.12
        for <linux-kernel@vger.kernel.org>; Thu, 04 Oct 2018 01:36:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cogentembedded-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=/LBR37Lgz421/EYf6/ISCqZcMWY/Q9fZrP8XaeRV5lU=;
        b=i1NtUt4kQE3EC6yNqcIv/4dpnCxZ6RTnYc0J8gP5HAatJTEBZhqPCNHWLKI8fBZzQN
         TliRK8OHjLz/Zy3iPFgbr7Kh+phpYrAgZsP8HJuyvxFFzBWb1QnSuICGxbOOXFy8C5Oe
         iLaDB32GF8vQbNf3twUQfYc+pKNvPAXxGA3KMlXGkrpUcjxYn6n0KpZ48xrUHWVKwskj
         2ST7PFSchPih1AH/8J8NEwn2UHBbZht4FvwCGSZQdj6RBJRvhOugrJH2f72qS9Ho32+p
         l9e/L/aplBHsxr/p0Jc+huWAFBR9rQkqrooDO/H6ThK64opkAvvRx+fCAPpSWTMTxU1m
         Hf+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=/LBR37Lgz421/EYf6/ISCqZcMWY/Q9fZrP8XaeRV5lU=;
        b=VcW5TcnRJaD8W4scx0p0+OL8sPb9N9EcrTdWfrYUNZJnaIOQutbgCjq6ivV/aDn8Lx
         eNyni7fPZQ9uueil/weJ7ovJU+IVRraPU3hIPMfJmDJ+DFtFR/F3brym+lhNmqs1e+Nl
         Z4Q9edyyR27OhDMb8UiXXxcEOEnQNA0lAAFL7lWsoauRp9nJjXQ/kbz7eLisor2NpuOQ
         3co79nA6qfUzokztpL1DyI9FZkBUBeAShWByr7BL76TYFxjkMgqHTB4CQ2tiBIeuE/PF
         YHpES/aCY2Bs8STQswPpSmtGjXddBEHGRvx/3T6jTthvYZUHUWRJAkbquyZDS6T/oDSr
         FHNg==
X-Gm-Message-State: ABuFfogWv7H3+SuyiViOgsTg0CRFtloh0/O0HJW0/rjibs56LavdS9Pm
        niEcZKbEVcMdbrpcKyjcWEckUNbHNmY=
X-Google-Smtp-Source: ACcGV609knavE19cCsJM8PgqCfDzCAIK36RuWBbVqa735lXN9/pkjg4fFT86dzZSk2VUJaOksG/keQ==
X-Received: by 2002:a19:dd0e:: with SMTP id u14-v6mr3315866lfg.109.1538642194556;
        Thu, 04 Oct 2018 01:36:34 -0700 (PDT)
Received: from [192.168.0.126] ([31.173.83.191])
        by smtp.gmail.com with ESMTPSA id j73-v6sm876345lfg.16.2018.10.04.01.36.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 04 Oct 2018 01:36:33 -0700 (PDT)
Subject: Re: [PATCH] mips: delete duplication of BUILTIN_DTB selection
To:     Maksym Kokhan <maksym.kokhan@globallogic.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>,
        James Hogan <jhogan@kernel.org>
Cc:     Andrii Bordunov <andrew.bordunov@gmail.com>,
        linux-mips@linux-mips.org, linux-kernel@vger.kernel.org
References: <1538587415-24126-1-git-send-email-maksym.kokhan@globallogic.com>
From:   Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Message-ID: <de95ca86-014d-77f6-6e2b-24f191147487@cogentembedded.com>
Date:   Thu, 4 Oct 2018 11:36:33 +0300
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <1538587415-24126-1-git-send-email-maksym.kokhan@globallogic.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

On 10/3/2018 8:23 PM, Maksym Kokhan wrote:

> CONFIG_BUILTIN_DTB selection is duplicated in menu
> "Machine selection" under MIPS_MALTA.
> 
> Fixes: e81a8c7dabac ("MIPS: Malta: Setup RAM regions via DT")
> Signed-off-by: Maksym Kokhan <maksym.kokhan@globallogic.com>
> Signed-off-by: Andrii Bordunov <andrew.bordunov@gmail.com>
> ---
>   arch/mips/Kconfig | 1 -
>   1 file changed, 1 deletion(-)
> 
> diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
> index 3551199..71d6549 100644
> --- a/arch/mips/Kconfig
> +++ b/arch/mips/Kconfig
> @@ -539,7 +539,6 @@ config MIPS_MALTA
>   	select USE_OF
>   	select LIBFDT
>   	select ZONE_DMA32 if 64BIT
> -	select BUILTIN_DTB
>   	select LIBFDT

    LIBFDT seems duplicated too.

[...]

MBR, Sergei
