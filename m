Return-Path: <SRS0=zRJA=NN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D3E5C32789
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 21:39:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0BA0B2082E
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 21:39:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O7RvnxNx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0BA0B2082E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728140AbeKCGsD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 3 Nov 2018 02:48:03 -0400
Received: from mail-pg1-f177.google.com ([209.85.215.177]:34069 "EHLO
        mail-pg1-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726100AbeKCGsD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Nov 2018 02:48:03 -0400
Received: by mail-pg1-f177.google.com with SMTP id k1-v6so1526657pgq.1;
        Fri, 02 Nov 2018 14:39:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=7gGFypwaejshENOyGBcvndgUcwhC1mGFoYuO6DLqYCQ=;
        b=O7RvnxNxDyPBTi29HDIx2K1rZ6n+yTYADNVazeUtuQ39ANAmqrozIs1QzS26wSroNG
         FeSXoz0xWdJfPkh0C8tYhUuz1fqOcrkxdzSj8CPpp3tedkawrkZwnRsIrwye53V1+sRA
         HdbJzAvqsfB/ChPJFZ+Vd7gcXNZ+WkJR8kGPdcyLM1cS68UvjI2AslD4TiFL+ly8Zb9c
         lLeRi/Ft+bVUsyEBTrV34nDiF4KZoQmCUKsJozbC7GojAEivaPkAdP5OpyBhnmqJ+kl1
         FKO1R1pAowK8FsXdSVmhl34wrl0AnQd8zU6/xellFPJtEWS+p330rr0J1hMx7WVwEY4D
         q8hQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=7gGFypwaejshENOyGBcvndgUcwhC1mGFoYuO6DLqYCQ=;
        b=Ap1VTGJZw+KGbekYaUHY7iWQf4V0BrmMlkDdqGzBfkVHPrbXlF8MzbRvAF+xTzoNeS
         jgF8APMOHZTrusp86txtAbQ/GFgOMwr5BjeRxkuz81pnQK1aAZmG5zf6NR66Rle1UBKS
         6qHlL37bJZpagHJMLosqx5ibsbuQOufaog2OlWmL2cxnWuchrK5iRMWmtR9f2ubg+Bgd
         Urx6wFM0xRELdSr23kwhE0aITXvAVFVES9w3E0+9y7wMmx67Djk0BsqjlOOxxu/kNhjK
         UcG/nBYlkyAgl2wTjs3VntvlRNdp4dV94ZEGRziGaVoAUDJLsb12M1aAw/kEbhQ3FG73
         13QA==
X-Gm-Message-State: AGRZ1gLuz1h3jH0WAHCmrCmmt5QzKVd9hSB8W05jasw5WxLcT475p+6f
        hzfIJnnkhbhAj/sL9wCWFerE88+o
X-Google-Smtp-Source: AJdET5eV2cKnVkw0bheo9V2FONYLP9BrIPD+hxCFNQG6ubZMjhmYxWfFT/MI0y7e3ReiedmqFGxRQA==
X-Received: by 2002:a63:561b:: with SMTP id k27mr12399465pgb.271.1541194754309;
        Fri, 02 Nov 2018 14:39:14 -0700 (PDT)
Received: from [192.168.86.235] (c-67-180-167-114.hsd1.ca.comcast.net. [67.180.167.114])
        by smtp.gmail.com with ESMTPSA id k13-v6sm35738194pff.30.2018.11.02.14.39.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 02 Nov 2018 14:39:13 -0700 (PDT)
Subject: Re: [PATCH] net/mlx5e: fix high stack usage
To:     Saeed Mahameed <saeedm@mellanox.com>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "leon@kernel.org" <leon@kernel.org>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Moshe Shemesh <moshe@mellanox.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        Boris Pismenny <borisp@mellanox.com>,
        Tariq Toukan <tariqt@mellanox.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        Eran Ben Elisha <eranbe@mellanox.com>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        Ilya Lesokhin <ilyal@mellanox.com>,
        Kamal Heib <kamalh@mellanox.com>
References: <20181102153316.1492515-1-arnd@arndb.de>
 <9f214f12ec89020ceb14c1aec25b3a0d968507aa.camel@mellanox.com>
From:   Eric Dumazet <eric.dumazet@gmail.com>
Message-ID: <2727f37b-1742-5532-317e-3be8a984266b@gmail.com>
Date:   Fri, 2 Nov 2018 14:39:11 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <9f214f12ec89020ceb14c1aec25b3a0d968507aa.camel@mellanox.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/02/2018 02:05 PM, Saeed Mahameed wrote:
 
> temp will be mem copied to priv->stats.sw at the end,
> memcpy(&priv->stats.sw, &s, sizeof(s)); 
> 
> one other way to solve this as suggested by Andrew, is to get rid of
> the temp var and make it point directly to priv->stats.sw 
> 

What about concurrency ?

This temp variable is there to make sure concurrent readers of stats might
not see mangle data (because another 'reader' just did a memset() and is doing the folding)


mlx5e_get_stats() can definitely be run at the same time by multiple threads.

