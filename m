Return-Path: <SRS0=sqHT=JP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF36DC6778C
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 21:51:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A645E27E5C
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 21:51:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ngi0d5Zk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A645E27E5C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936663AbeF2Vvw (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Jun 2018 17:51:52 -0400
Received: from mail-ua0-f196.google.com ([209.85.217.196]:38905 "EHLO
        mail-ua0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934086AbeF2Vvu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jun 2018 17:51:50 -0400
Received: by mail-ua0-f196.google.com with SMTP id 59-v6so6680820uas.5;
        Fri, 29 Jun 2018 14:51:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=kuXk3NhRIJm/DsxF3N4MzQgQT4VXPZuoIs3D4yn05D4=;
        b=ngi0d5ZkQukaE0DVHlvvF1bc9gVLpt80/eu9CqXDrydfjgMcUHO11MCflgXfRNOz6i
         lXUytN7bobj1nQXVeBAVVKDy9nlq4K0fKXeLQRyuBX0LxvT/8TuGzQidoSJfo6EHbB9v
         9VHyQpfNXW59qvEyPamYhKkC6k7X+rRczup8tHwSjmho4if7FJbHCcx7+qJY0GrVvnUZ
         Qom6rV7LMGzx3l3yrQqo59mO4kW0eKzVeAO09fzAVFu6CgMHru7Z0wz64fqjCNFynjlJ
         112jfj26GcOTQrgM/31aAuPZutQ5s6QsSGM6ujwhFiP2TRSe30YLa9IkpoVkX84USOlR
         /qbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=kuXk3NhRIJm/DsxF3N4MzQgQT4VXPZuoIs3D4yn05D4=;
        b=fCTU28dx9ITG56tZywLy0moDg/sAYyAFKRRWekS0WGWcecSe8VVBYPY7hRM9LS9/FG
         ZJBzgWMfV32GZLMJP7p2hupKhoFzl5tz29EdD03ehLNsofKDQdiQRTlOiCQHQQ0WGCH/
         iDRiA02kMgNO5/2J78YeaTdHq1pHz3Jbg0c/CF7LGApBMHx7kbGbtwqzeoMWWnXa6QId
         /yX7BzR6qabsrKGwM+2dVWCTosS0NVxjRxf5NubObUiQZqo2FNz/gtGUtrkOVrASvIA+
         NnoDONIsrLV26897SrqiEB7RM8fvVMu59TJC/lZNCVx/eR4mNnQw5NmFSA+3YNBSE7dQ
         3rUQ==
X-Gm-Message-State: APt69E3fpjU6x+i9w+Mz4n54dnhhTEWcLg1zLwdmn0bWkafvRPGZBpS4
        VlTDsdAeGItHlhMTjQGwxqTrIONNcbVVa7xJmCCVhJFRNVU=
X-Google-Smtp-Source: AAOMgpejci6j2Sr29MYn9xAGXy9z8du8DmYhLlcx76xbSc7AZnbDNghx91eTL5K6uZDTKHzvSqA0xLJZT0aSyZO4Haw=
X-Received: by 2002:ab0:1a23:: with SMTP id a35-v6mr10361213uai.47.1530309110053;
 Fri, 29 Jun 2018 14:51:50 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a67:8b02:0:0:0:0:0 with HTTP; Fri, 29 Jun 2018 14:51:49
 -0700 (PDT)
In-Reply-To: <CAHp75Vet-vTz_Ld=Lturmm8NSpK1etvoj-7Wzn4-h=bM2FQgZg@mail.gmail.com>
References: <20180629025135.12236-1-yuehaibing@huawei.com> <CAHp75Vet-vTz_Ld=Lturmm8NSpK1etvoj-7Wzn4-h=bM2FQgZg@mail.gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Sat, 30 Jun 2018 00:51:49 +0300
Message-ID: <CAHp75VcTVtzLuwH=Ff6DBKJyQE4t=HT7hB2O=gvgN+V-38LH5g@mail.gmail.com>
Subject: Re: [PATCH] atmel: using strlcpy() to avoid possible buffer overflows
To:     YueHaibing <yuehaibing@huawei.com>
Cc:     simon@thekelleys.org.uk, Kalle Valo <kvalo@codeaurora.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        netdev <netdev@vger.kernel.org>,
        "open list:TI WILINK WIRELES..." <linux-wireless@vger.kernel.org>,
        "David S. Miller" <davem@davemloft.net>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 30, 2018 at 12:47 AM, Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
> On Fri, Jun 29, 2018 at 5:51 AM, YueHaibing <yuehaibing@huawei.com> wrote:
>> 'firmware' is a module param which may been longer than firmware_id,
>> so using strlcpy() to guard against overflows
>
> strncat() is against overflow, this does a bit more.
>
>>         priv->firmware_id[0] = '\0';
> ...
>>         if (firmware) /* module parameter */
>> -               strcpy(priv->firmware_id, firmware);
>> +               strlcpy(priv->firmware_id, firmware, sizeof(priv->firmware_id));
>
> In either case the above '\0' is not needed.
> But it looks like the intention was to use strncat() / strlcat().

Ah, this is under condition, yes. If no parameter supplied, this needs
to be clean, but
priv is allocated with zeroed memory
https://elixir.bootlin.com/linux/latest/source/net/core/dev.c#L8369

-- 
With Best Regards,
Andy Shevchenko
