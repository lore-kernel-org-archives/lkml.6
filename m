Return-Path: <SRS0=Se0q=LB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12B62C4321D
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Aug 2018 16:21:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B06182083B
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Aug 2018 16:21:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cogentembedded-com.20150623.gappssmtp.com header.i=@cogentembedded-com.20150623.gappssmtp.com header.b="ZTD3Cwd5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B06182083B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=cogentembedded.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726322AbeHRT3U (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 18 Aug 2018 15:29:20 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:43689 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726219AbeHRT3U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Aug 2018 15:29:20 -0400
Received: by mail-lj1-f194.google.com with SMTP id r13-v6so8582127ljg.10
        for <linux-kernel@vger.kernel.org>; Sat, 18 Aug 2018 09:21:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cogentembedded-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:organization:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=MTwjGmwwDSBgrTR5aLJxWrUxU9WNYnU1JiGjoa4hCxg=;
        b=ZTD3Cwd5g9LuutCZ/aYBTJ/b/l1EPbDdnN912l9psMJuL2H8rdjJCAeBHJoUcg4pPf
         DGVKxYDxoqyiCibwQEneHV6KlI65WCcpreEgUkug1soc+EVysLCCop/sd9l/pz9/G+7G
         deCd2YM6JTNPti0OofBz9EQhaBbFcvBPvQnlYdL9tE4VJXKPPSqtjEUWltKShPNEem3h
         IA9RgY9mM4XCP9FLdrssIfz7cOpbzBZCCubh0g6drb5Nw74ofQhD+cokiG/9iSpoudTF
         1C26kUevn7aPdnJRTFtkgHUW4tB7fnixBwXSf8zzEmk1CpiP/A9QcWM+J/8RAQdp/Xvj
         og2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=MTwjGmwwDSBgrTR5aLJxWrUxU9WNYnU1JiGjoa4hCxg=;
        b=HCCbBgstOKjRK60wW5XE2L/TfGwEKud7+M+bJvZ/FNKZRXIrDMWdf8C9rWM74ETUrQ
         aFBufTmkSH5Mdm5M/XjiYz33OLxM9ju1gv/p8pmQoNHUmv+9RDmVP3qr1ctLrf2kRdZW
         v3i0F1CFX2TYJ5xJVWRj7ZQ+o3Djbrr2520annJhawvz+TZWJU0h857poC/ot0UEzOTB
         IGBdNHELV3Mw4cI6/8KgUYGFjDuVvNtVhB3sfky5B1mpgS/ZABWd0y51bcU4sTym8lgf
         xT+SNP/s2FhUu+evxtiZ8Cmu3JB0VXIWmMDNPU1ja0r24g+pPgqLF9yUMEQlW3Uuf3mz
         b9ZQ==
X-Gm-Message-State: AOUpUlH5q/4c3NHAoIzmnqybhEmuM6q2gv/iV29WypAb3h6PJJR66iGY
        A+BV76EL8ZYDXFZ7KPfrDuXcWt3Tch0=
X-Google-Smtp-Source: AA+uWPxmDZX2gjblOUWXF2UI5tclSaTDxrZRFQgiCgAipdtkNIEWnEzniFFlSx2o3zht1yV8AQ2q0Q==
X-Received: by 2002:a2e:4d9d:: with SMTP id c29-v6mr26121459ljd.132.1534609264191;
        Sat, 18 Aug 2018 09:21:04 -0700 (PDT)
Received: from wasted.cogentembedded.com ([31.173.86.12])
        by smtp.gmail.com with ESMTPSA id a4-v6sm910250lfe.54.2018.08.18.09.21.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 18 Aug 2018 09:21:03 -0700 (PDT)
Subject: Re: [PATCHv2] ide: Use NULL to compare with pointer-typed value
 rather than 0
To:     Joe Perches <joe@perches.com>, zhong jiang <zhongjiang@huawei.com>,
        davem@davemloft.net
Cc:     benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au,
        linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1534572961-16423-1-git-send-email-zhongjiang@huawei.com>
 <8badfdf8-ce69-1722-a489-fee161a1f4aa@cogentembedded.com>
 <14b562e7acdb37158190e14045fe276e9899422e.camel@perches.com>
From:   Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Organization: Cogent Embedded
Message-ID: <94bdada0-e0f9-4dd2-ed6d-ad84f7114954@cogentembedded.com>
Date:   Sat, 18 Aug 2018 19:21:03 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <14b562e7acdb37158190e14045fe276e9899422e.camel@perches.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-MW
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/18/2018 07:15 PM, Joe Perches wrote:

>>> We should use NULL to compare with pointer-typed value rather than
>>> 0. The issue is detected with the help of Coccinelle.
>>
>>    Your description stopped to match the patch in v2.
>>    Actually, this X ==  NULL to !x preference is largely spocific to netdev...
>> Although, IDE maintainer is the same now person. :-)  
>>  
>>> Signed-off-by: zhong jiang <zhongjiang@huawei.com>
>>> ---
>>>  drivers/ide/pmac.c | 2 +-
>>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/ide/pmac.c b/drivers/ide/pmac.c
>>> index c5b902b..ca36a97 100644
>>> --- a/drivers/ide/pmac.c
>>> +++ b/drivers/ide/pmac.c
>>> @@ -1682,7 +1682,7 @@ static int pmac_ide_init_dma(ide_hwif_t *hwif, const struct ide_port_info *d)
>>>  	/* We won't need pci_dev if we switch to generic consistent
>>>  	 * DMA routines ...
>>>  	 */
>>> -	if (dev == NULL || pmif->dma_regs == 0)
>>> +	if (!dev || !pmif->dma_regs)
>>>  		return -ENODEV;
>>>  	/*
>>>  	 * Allocate space for the DBDMA commands.
>>
>> MBR, Sergei
> 
> Perhaps discourage trivial changes to this old subsystem.
> 
> checkpatch could bleat something if a patch was submitted for ide
> if the IDE MAINTAINERS entry was marked obsolete.

   Note that the IDE fixes are still OK...

> ---
> diff --git a/MAINTAINERS b/MAINTAINERS
> index e9336962d0f2..3c4992cf5249 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -6933,7 +6933,7 @@ M:	"David S. Miller" <davem@davemloft.net>
>  L:	linux-ide@vger.kernel.org
>  Q:	http://patchwork.ozlabs.org/project/linux-ide/list/
>  T:	git git://git.kernel.org/pub/scm/linux/kernel/git/davem/ide.git
> -S:	Maintained
> +S:	Maintained / Obsolete (prefer LIBATA)

   What about "S: Odd Fixes"? Perhaps it better reflects the reality...

>  F:	Documentation/ide/
>  F:	drivers/ide/
>  F:	include/linux/ide.h

MBR, Sergei
