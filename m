Return-Path: <SRS0=Se0q=LB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2665DC4321D
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Aug 2018 15:54:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C6B37215EB
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Aug 2018 15:54:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cogentembedded-com.20150623.gappssmtp.com header.i=@cogentembedded-com.20150623.gappssmtp.com header.b="cbmqMXvC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C6B37215EB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=cogentembedded.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726321AbeHRTCK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 18 Aug 2018 15:02:10 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:44855 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726189AbeHRTCJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Aug 2018 15:02:09 -0400
Received: by mail-lj1-f193.google.com with SMTP id q127-v6so8561777ljq.11
        for <linux-kernel@vger.kernel.org>; Sat, 18 Aug 2018 08:54:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cogentembedded-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:organization:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=UrVqMFZ73iAf5FyGrO/fouVKDgGyfsXmcEHmL2kqSfo=;
        b=cbmqMXvC6WVp6z1AB+MjD2ZWA+lC0wiNZ5pyh18DOr2+jJKItY5cI0YuvpQ4Hjy02R
         +7slSEoDGM/zmAZhK17bDgm1NqtvS7unTw1dt/f0utP53y1GpCJ80ZABV6DvKAOhlUIW
         qxVZtYsYix4BXpRkHjaL1Ityj4S5Yx6olhFlVKxWw5cvFKlvS6+rt65Q8GVb9UZcCdBR
         LO0IRwNY33ekUhrH30xMbL6YMB24cSMDOU3YJ7QtBNKZigsE7Fevo+SE6CoX3jCCMwNp
         a5Lpp9jarQOvzlBeua85zbKCIKjA92mzYflJdV5QUmLjrpILH6XAF7tCB5JX0jmcV47I
         hj4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=UrVqMFZ73iAf5FyGrO/fouVKDgGyfsXmcEHmL2kqSfo=;
        b=LobLanZb3xni3Md5t9sT1lGQzLKhEmfoMSVk0lFx2VL3mdsgKg9BaqFnqVlFBJ5CGW
         XIKC+fb0dgcn1NfYBk5XkR4XZQ+UhxgAQnjV0LT1IId5eaoAOvfkzH/+RbPVOX5opaDG
         pb1Uip7PFZUJnlh5WYUQ2S7jNq1RojsL3W73nZcvKB4QctJytDwcbp78BD98HrYAsOrC
         /Z+mXaZDj/WriQFF7lrmWZ2MlVPJR9TZBBWKkcX6ZA1cEx4Yh592qNyGlRcqyuu/3Tze
         gbUynaC9D+JdmTdYkT+Klvq2P4gSwI0tTDBYMt00M5bPa8ZUlfPw4TiQr2hIaPSKleR/
         OiCw==
X-Gm-Message-State: AOUpUlGvJ33RNLowr3dgbozBc9C0ttLhf1DLFkaPupgJRHXD63zG4SSC
        wmTg0s8B+5UH8s6eIIQfoH7YYkwkuJE=
X-Google-Smtp-Source: AA+uWPwFk/o6yO/kEq+rG8lT8iOqyUpiB98uUnukmov9nJT37W6NdMpzqIrxe+T0NvBzcWViNhrYwQ==
X-Received: by 2002:a2e:4619:: with SMTP id t25-v6mr28248605lja.96.1534607639410;
        Sat, 18 Aug 2018 08:53:59 -0700 (PDT)
Received: from wasted.cogentembedded.com ([31.173.86.12])
        by smtp.gmail.com with ESMTPSA id h90-v6sm810380lji.66.2018.08.18.08.53.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 18 Aug 2018 08:53:58 -0700 (PDT)
Subject: Re: [PATCHv2] ide: Use NULL to compare with pointer-typed value
 rather than 0
To:     zhong jiang <zhongjiang@huawei.com>, davem@davemloft.net
Cc:     benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au,
        linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1534572961-16423-1-git-send-email-zhongjiang@huawei.com>
From:   Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Organization: Cogent Embedded
Message-ID: <8badfdf8-ce69-1722-a489-fee161a1f4aa@cogentembedded.com>
Date:   Sat, 18 Aug 2018 18:53:58 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <1534572961-16423-1-git-send-email-zhongjiang@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-MW
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/18/2018 09:16 AM, zhong jiang wrote:

> We should use NULL to compare with pointer-typed value rather than
> 0. The issue is detected with the help of Coccinelle.

   Your description stopped to match the patch in v2.
   Actually, this X ==  NULL to !x preference is largely spocific to netdev...
Although, IDE maintainer is the same now person. :-)  
 
> Signed-off-by: zhong jiang <zhongjiang@huawei.com>
> ---
>  drivers/ide/pmac.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/ide/pmac.c b/drivers/ide/pmac.c
> index c5b902b..ca36a97 100644
> --- a/drivers/ide/pmac.c
> +++ b/drivers/ide/pmac.c
> @@ -1682,7 +1682,7 @@ static int pmac_ide_init_dma(ide_hwif_t *hwif, const struct ide_port_info *d)
>  	/* We won't need pci_dev if we switch to generic consistent
>  	 * DMA routines ...
>  	 */
> -	if (dev == NULL || pmif->dma_regs == 0)
> +	if (!dev || !pmif->dma_regs)
>  		return -ENODEV;
>  	/*
>  	 * Allocate space for the DBDMA commands.

MBR, Sergei
