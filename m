Return-Path: <SRS0=ekB2=LK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1DAAC433F4
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 01:41:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6D5BC2174A
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 01:41:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZsJXRmaf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6D5BC2174A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727078AbeH0FZ2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Aug 2018 01:25:28 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:38913 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726822AbeH0FZ2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Aug 2018 01:25:28 -0400
Received: by mail-pg1-f193.google.com with SMTP id m3-v6so5733566pgp.6
        for <linux-kernel@vger.kernel.org>; Sun, 26 Aug 2018 18:41:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=5HIlNkStmeTQ3VJbawrUOEP8sP0xBaalnS04adiIfHk=;
        b=ZsJXRmafkp8uCA8yYKMa9jEHqK4Sd8DClMDdqIdZJ3IL6yBi6/0DE0QkH+W1aT/jn2
         96nsKTE8KyMxkw+GNYU4SlfmzoeVu1Yl/PgbAEyBfU97Asfyhn+EVLXb0jvR9UIKZ5dS
         cXQU32NKrETksb5wKu1ePvLTxXQMTXEa9W9DbSOm6RjxuV+1QgSTZdezfah4EpzNhWHo
         Nl9GFyYUXpOE858u4Z7nM/vk17Uv/tVXQ5zTLZ78o82cPI42MQ942s/P1Pf0YR0ViP+W
         chPDUMITkimHPmUC+B2mm4DbBM/0En7z85Oth7laDQjCpmglRxDt0N/vUWMKgSEsVJLj
         326g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=5HIlNkStmeTQ3VJbawrUOEP8sP0xBaalnS04adiIfHk=;
        b=TnIYvxvyXkMgJupNRbuyd17xtHpHZwzkdHVolye9JwrUvt4xau+W2x8+shYPAMzocq
         GfYV4AKZA0ks0QrECy9lIlELFuJeWid433478v/PyM6XPe838yCCPxXtvkxEfpsCk3xa
         oojPIf7Ll9NWdl2CI3FRuQXbDeRUZCGqSqxGsoiYYaXnRPE9DgrSzlVPSbn2vjXTswZq
         pZ1WrV8HrNOhD0xGHmrl2gioWVes9CAFNOcp6tVcP4d8BONOqcMGeMoiapivHH5jbRmx
         RdxqFilcMd0YIwFzelWOIhAHZlh78WDNELm+t+DkAYu5KzUnmCg6S8YeYBMdzmPHlEgL
         XFUw==
X-Gm-Message-State: APzg51A/FICt8U5wng5JRGIoY6hbSPHv0EbjZiZqvy6E48R5usCpkKqv
        LCWMWRp0y54dBvEQfUmytPY=
X-Google-Smtp-Source: ANB0VdYvCqixHGsN+ma454P0eaElyxdQlsLkCG+0tz+aN0UT2ay+GvNZ8KFp/plRxa+SF5EdzOciwg==
X-Received: by 2002:a62:c60e:: with SMTP id m14-v6mr12180058pfg.40.1535334063397;
        Sun, 26 Aug 2018 18:41:03 -0700 (PDT)
Received: from [0.0.0.0] (96.45.178.72.16clouds.com. [96.45.178.72])
        by smtp.gmail.com with ESMTPSA id x2-v6sm23388098pfi.166.2018.08.26.18.40.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 26 Aug 2018 18:41:02 -0700 (PDT)
Subject: Re: [PATCH] irqchip/gic-v3-its: add allocation max order limitation
 for lpi_id_bits
To:     Marc Zyngier <marc.zyngier@arm.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Jia He <jia.he@hxt-semitech.com>
References: <1535274051-2418-1-git-send-email-jia.he@hxt-semitech.com>
 <868t4tx88w.wl-marc.zyngier@arm.com>
From:   Jia He <hejianet@gmail.com>
Message-ID: <81286c7a-8e16-0925-7646-7d422d10114f@gmail.com>
Date:   Mon, 27 Aug 2018 09:41:04 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <868t4tx88w.wl-marc.zyngier@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marc
Thanks for the comments

On 8/27/2018 3:01 AM, Marc Zyngier Wrote:
> [I'm travelling, so expect some major delays in responding to email]
> 
> Hi Jia,
> 
> On Sun, 26 Aug 2018 10:00:51 +0100,
> Jia He <hejianet@gmail.com> wrote:
>>
>> There is a WARN_ON when my QDF2400 server boots up (pagesize is 4k)
> 
> [snip]
> 
>> In its_alloc_lpi_tables, lpi_id_bits is 24, without this patch,
>> its_allocate_prop_table will try to allocate 16M(order 12 if
>> pagesize=4k). Thus it causes the WARN_ON.
> 
> Gah! QDF and its 24bit INTIDs... Making life hell for everyone ;-)
> 
> Sorry for breaking it.

np, maybe QDF2400 is a little bit special

> 
>>
>> This patch fixes it by limiting the lpi_id_bits.
>>
>> Signed-off-by: Jia He <jia.he@hxt-semitech.com>
>> ---
>>  drivers/irqchip/irq-gic-v3-its.c | 5 ++++-
>>  1 file changed, 4 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/irqchip/irq-gic-v3-its.c b/drivers/irqchip/irq-gic-v3-its.c
>> index 316a575..79e6993 100644
>> --- a/drivers/irqchip/irq-gic-v3-its.c
>> +++ b/drivers/irqchip/irq-gic-v3-its.c
>> @@ -1624,8 +1624,11 @@ static void its_free_prop_table(struct page *prop_page)
>>  static int __init its_alloc_lpi_tables(void)
>>  {
>>  	phys_addr_t paddr;
>> +	u32 max_bits;	 /*max order limitation in alloc_page*/
>>  
>> -	lpi_id_bits = GICD_TYPER_ID_BITS(gic_rdists->gicd_typer);
>> +	max_bits = PAGE_SHIFT + MAX_ORDER - 1;
>> +	lpi_id_bits = min_t(u32, max_bits,
>> +			GICD_TYPER_ID_BITS(gic_rdists->gicd_typer));
>>  	gic_rdists->prop_page = its_allocate_prop_table(GFP_NOWAIT);
>>  	if (!gic_rdists->prop_page) {
>>  		pr_err("Failed to allocate PROPBASE\n");
>> -- 
>> 1.8.3.1
>>
> 
> I find it rather odd that we end-up with different interrupt ranges
> depending on the CPU page size. Also, allocating that much memory for
> LPIs is rather pointless, as we actually have a pretty low limit of
> interrupts the system can deal with (see IRQ_BITMAP_BITS, which is
> slightly more than 8k). I've so far seen *one* request to push it up,
> but I doubt that it is a real use case.
> 
> Capping lpi_id_bits at 16 (which is what we had before) is plenty,
> will save a some memory, and gives some margin before we need to push
> it up again.

Do you want me to revert commit fe8e93504 to cap the lpi_id_bits
to no greater than ITS_MAX_LPI_NRBITS(16) instead this patch?
-- 
Cheers,
Jia
