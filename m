Return-Path: <SRS0=r7UP=JF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD1ECC5CFC1
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 17:14:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5B8BE20020
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 17:14:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="q9QcSpLe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5B8BE20020
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S967164AbeFSRON (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 13:14:13 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:53279 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S966368AbeFSROK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 13:14:10 -0400
Received: by mail-wm0-f67.google.com with SMTP id x6-v6so1602397wmc.3;
        Tue, 19 Jun 2018 10:14:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:openpgp:autocrypt:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=R4v+YPgoxTw5q8m6mMK1nARIOLdwA5htKqfnLaKCIJQ=;
        b=q9QcSpLeoqttuIFON0DscBrac+w/83wNyQS98/PrjIprtSWTYcxbpARhNaotd4PvXn
         Sa9Ub4hxsKEN7Mu6+N9jmf9kjB/hNut/leqyQQxfy/Fnolum/IKzS0hdRypcmy5c8Rvm
         B88LQw/FLPeqZ3q5YNsMolYj8bienxcf64TyQNRAOAI8MGOFZnJJZpAiXtu+jkDnKidp
         QyuBkTuh69ec5YY7ccaOMjOQ7aQ/jbIDtkeet7UX/xp8HGsyuHmKGoDfYfJDHzuPDD1A
         CUnLuRlpP+O3LRzBnk3A+1JYPFYLd9NxAkdUfXNk+4j0uiy/1/+ISW0e1HKhf9jjpq1b
         RgzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=R4v+YPgoxTw5q8m6mMK1nARIOLdwA5htKqfnLaKCIJQ=;
        b=DLa3m9qHULpK4V5fexULESFwIGOn+8/iv478eGl3K2TvHA9OQnrZZBDVl53FkDyOzF
         yGGA5aNcch4eRnGqg5B7lKIgMkdHR/afiGzRBc5r/Mfh5jEcYGPCVmBGhDCFP/+/9I2a
         7LAL67QQvDfcx55iDpfR1ZXGgvCjU3uXWzQuDCTuy/l4LJ5Vw7CK1F0Q0CSWxgKEAlGT
         ljdFvr5pTi/PkM0/t72I/W5KWKJlQ8sbfFOFkYh3/q5sURgeKXzw3qantIaoVOWFtHG6
         JytNoffoWaM93vCfc8pFAIjFYLdWcgNYc71PdV2LDJVbmyzK/nPuRZKWeSdyr3nM/1Ss
         ReOg==
X-Gm-Message-State: APt69E09V9UfjCspdZHxKLPJwSdwXkrv0QKPTnQbmAiFfXpph7qQEJrK
        BmDWcHqTx95XXPNRsK9MQIzw+Htn
X-Google-Smtp-Source: ADUXVKIaNrh7/M2z6EmuU+e2xbLGLw9OfT5ZR4GOU393HFyLAa3kISfU9sGmNchKeYSMaydUpjIyFQ==
X-Received: by 2002:a50:b3e4:: with SMTP id t33-v6mr15532199edd.14.1529428448985;
        Tue, 19 Jun 2018 10:14:08 -0700 (PDT)
Received: from [10.69.41.93] ([192.19.223.250])
        by smtp.googlemail.com with ESMTPSA id e46-v6sm336632edd.80.2018.06.19.10.14.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 19 Jun 2018 10:14:08 -0700 (PDT)
Subject: Re: [PATCH] net: nixge: Add __packed attribute to DMA descriptor
 struct
To:     Moritz Fischer <mdf@kernel.org>, davem@davemloft.net
Cc:     keescook@chromium.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20180619165453.31894-1-mdf@kernel.org>
From:   Florian Fainelli <f.fainelli@gmail.com>
Openpgp: preference=signencrypt
Autocrypt: addr=f.fainelli@gmail.com; prefer-encrypt=mutual; keydata=
 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
 HGuUuzv+GKZ6nsysJw==
Message-ID: <832bebb8-300d-e911-2946-5edfe82dc30a@gmail.com>
Date:   Tue, 19 Jun 2018 10:13:55 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180619165453.31894-1-mdf@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/19/2018 09:54 AM, Moritz Fischer wrote:
> Add __packed attribute to DMA descriptor structure  in order to
> make sure that the DMA engine's alignemnt requirements are met.
> 
> Fixes commit 492caffa8a1a ("net: ethernet: nixge: Add support for
> National Instruments XGE netdev")
> Signed-off-by: Moritz Fischer <mdf@kernel.org>
> ---
> 
> Hi David,
> 
> this addresses an issue where padding occured breaking the alignment
> in the array the descriptors are allocated in coherent memory.
> This was discovered when we tried to bring up the driver via a PCIe
> bridge on x86.

How could padding be inserted given than all of the structure members
are naturally aligned (all u32 type). Compiler bug?

Also

> 
> Thanks,
> 
> Moritz
> 
> ---
>  drivers/net/ethernet/ni/nixge.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/ni/nixge.c b/drivers/net/ethernet/ni/nixge.c
> index 09f674ec0f9e..fea0e994324b 100644
> --- a/drivers/net/ethernet/ni/nixge.c
> +++ b/drivers/net/ethernet/ni/nixge.c
> @@ -122,7 +122,7 @@ struct nixge_hw_dma_bd {
>  	u32 sw_id_offset;
>  	u32 reserved5;
>  	u32 reserved6;
> -};
> +} __packed;
>  
>  struct nixge_tx_skb {
>  	struct sk_buff *skb;
> 


-- 
Florian
