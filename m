Return-Path: <SRS0=sHJz=MZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4ACE8C28CF8
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Oct 2018 04:18:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E527920865
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Oct 2018 04:18:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iXP0ozMu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E527920865
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726125AbeJMLy2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 13 Oct 2018 07:54:28 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:34444 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725978AbeJMLy2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Oct 2018 07:54:28 -0400
Received: by mail-pl1-f193.google.com with SMTP id f18-v6so6805538plr.1;
        Fri, 12 Oct 2018 21:18:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=HLgpTTqDPpPvx9xM7j+WjRriOShXbI7V556iQO+rJXw=;
        b=iXP0ozMui/YC+exWrSQ7DSdKVSnLoV+FoVfAKamlnv6TfK0UnYM56u3s/fYFKqXJ+u
         PPQ/T8+lY8KJWFaXxSrOhn3XsdjPawLRjdYZxp+DiIrLmeiSvS0/Da2wT41wtt9Meb8f
         3x3oS2FdeARgiX83O6zAvzVAno61uM8j4rCIxBkFPtWwHwaXEqBWkgXpFPEnnQ9AGbj3
         XDpBOiSn5E2lnKRwY7LxfATVfUvCYA2fnDJkJTfaop7uAO6zTF9/xtCodwu9fEW0QBpE
         7aPewYhy/ASdQaDXU5TaXC8WEguVgXUnulepVfcJGC6tLrbSP3krdzm9Teop0IF4Oeqi
         P3Dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:cc:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=HLgpTTqDPpPvx9xM7j+WjRriOShXbI7V556iQO+rJXw=;
        b=ZD1hijmR0Z/tjFjs9bU4mEUS5GwR8cEwEbg58MVF08r5VyF8aJdwA5DporqOtlFy4a
         PXgER9/WyfcXexoSAkNSBsE3xE/MvQLJBglgD818BCxuVL52suacAf545+Z+7pobXLg/
         SdfYQBHrNNV4Lkqi3PtrxtwivqQRlwu/LXQXh109NBkN+OTaSC0XxPRNEeCVR4G8kEzz
         EmACEeblUK6KolJr6mTKvribCKD9Su1XhSSEZvfylqagxpE+4Il6ULQWgn8Prg0bdW3i
         Hvx72sMScm5xvmUaROSaESk8a4gU7kABTeUctP6eXsuccedY23z8qOxbomK2D7KXrSTg
         1zfQ==
X-Gm-Message-State: ABuFfoim7I9F7tgsqE93nfkzhWi0eOKbnYwsHAp4QAflkAjG6uy4RHhY
        Csm1AIGGeX6vZrPiCuaMv30Emf+q
X-Google-Smtp-Source: ACcGV61TLtUVKvdYBOJrDHN09XW65OhBhmq3n1CuiIgEtlAoOIWQz4jxLBws5/kBIlLl99oTKRwf9w==
X-Received: by 2002:a17:902:9a8b:: with SMTP id w11-v6mr4261489plp.94.1539404332306;
        Fri, 12 Oct 2018 21:18:52 -0700 (PDT)
Received: from [192.168.1.101] (122-62-216-69-adsl.sparkbb.co.nz. [122.62.216.69])
        by smtp.gmail.com with ESMTPSA id 76-v6sm5704902pfk.134.2018.10.12.21.18.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 12 Oct 2018 21:18:51 -0700 (PDT)
Subject: Re: [PATCH 6/6] esp_scsi: Optimize PIO loops
To:     Finn Thain <fthain@telegraphics.com.au>
References: <cover.1539391876.git.fthain@telegraphics.com.au>
 <3a2534bff570653de6897afa081017e2a359747e.1539391876.git.fthain@telegraphics.com.au>
 <3ba0d49c-57ce-40df-b406-98afc183275e@gmail.com>
 <alpine.LNX.2.21.1810131505230.375@nippy.intranet>
Cc:     "James E.J. Bottomley" <jejb@linux.vnet.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Hannes Reinecke <hare@suse.de>, linux-scsi@vger.kernel.org,
        linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org
From:   Michael Schmitz <schmitzmic@gmail.com>
Message-ID: <5b95b717-d9e8-8c8c-aa42-47f847bec5be@gmail.com>
Date:   Sat, 13 Oct 2018 17:18:59 +1300
User-Agent: Mozilla/5.0 (X11; Linux ppc; rv:45.0) Gecko/20100101
 Icedove/45.4.0
MIME-Version: 1.0
In-Reply-To: <alpine.LNX.2.21.1810131505230.375@nippy.intranet>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Finn,

Am 13.10.2018 um 17:09 schrieb Finn Thain:
> On Sat, 13 Oct 2018, Michael Schmitz wrote:
>
>> Hi Finn,
>>
>> Am 13.10.2018 um 13:51 schrieb Finn Thain:
>>> Avoid function calls in the inner PIO loops. On a Centris 660av this
>>> improves throughput for sequential read transfers by about 40% and
>>> sequential write by about 10%.
>>>
>>> Unfortunately it is not possible to have method calls like esp_write8()
>>> placed inline so this is always going to be slow (even with LTO).
>>>
>>> Tested-by: Stan Johnson <userm57@yahoo.com>
>>> Signed-off-by: Finn Thain <fthain@telegraphics.com.au>
>>> ---
>>>  drivers/scsi/esp_scsi.c | 14 +++++++-------
>>>  1 file changed, 7 insertions(+), 7 deletions(-)
>>>
>>> diff --git a/drivers/scsi/esp_scsi.c b/drivers/scsi/esp_scsi.c
>>> index 646701fc22a4..9f0e68cd0e99 100644
>>> --- a/drivers/scsi/esp_scsi.c
>>> +++ b/drivers/scsi/esp_scsi.c
>>> @@ -2788,7 +2788,7 @@ static inline unsigned int esp_wait_for_fifo(struct
>>> esp *esp)
>>>  		if (fbytes)
>>>  			return fbytes;
>>>
>>> -		udelay(2);
>>> +		udelay(1);
>>>  	} while (--i);
>>>
>>>  	pr_err("FIFO is empty (sreg %02x)\n", esp_read8(ESP_STATUS));
>>> @@ -2804,7 +2804,7 @@ static inline int esp_wait_for_intr(struct esp *esp)
>>>  		if (esp->sreg & ESP_STAT_INTR)
>>>  			return 0;
>>>
>>> -		udelay(2);
>>> +		udelay(1);
>>>  	} while (--i);
>>>
>>>  	pr_err("IRQ timeout (sreg %02x)\n", esp->sreg);
>>> @@ -2831,7 +2831,7 @@ void esp_send_pio_cmd(struct esp *esp, u32 addr, u32
>>> esp_count,
>>>  			if (!esp_wait_for_fifo(esp))
>>>  				break;
>>>
>>> -			*dst++ = esp_read8(ESP_FDATA);
>>> +			*dst++ = readb(esp->fifo_reg);
>>>  			--esp_count;
>>>
>>>  			if (!esp_count)
>>> @@ -2852,15 +2852,15 @@ void esp_send_pio_cmd(struct esp *esp, u32 addr, u32
>>> esp_count,
>>>  			}
>>>
>>>  			if (phase == ESP_MIP)
>>> -				scsi_esp_cmd(esp, ESP_CMD_MOK);
>>> +				esp_write8(ESP_CMD_MOK, ESP_CMD);
>>
>> You're no longer logging this command with this patch. (That'll be the reason
>> for the speedup you saw ...)
>>
>>>
>>> -			scsi_esp_cmd(esp, ESP_CMD_TI);
>>> +			esp_write8(ESP_CMD_TI, ESP_CMD);
>>
>> Same here..
>>
>>>  		}
>>>  	} else {
>>>  		unsigned int n = ESP_FIFO_SIZE;
>>>  		u8 *src = (u8 *)addr;
>>>
>>> -		scsi_esp_cmd(esp, ESP_CMD_FLUSH);
>>> +		esp_write8(ESP_CMD_FLUSH, ESP_CMD);
>>
>> here..
>>
>>>
>>>  		if (n > esp_count)
>>>  			n = esp_count;
>>> @@ -2894,7 +2894,7 @@ void esp_send_pio_cmd(struct esp *esp, u32 addr, u32
>>> esp_count,
>>>  			src += n;
>>>  			esp_count -= n;
>>>
>>> -			scsi_esp_cmd(esp, ESP_CMD_TI);
>>> +			esp_write8(ESP_CMD_TI, ESP_CMD);
>>
>> and here.
>>
>
> Yes, it's deliberate.

I'm sure it was... and I wasn't objecting to that.

>> The burst of ESP_CMD_TI's in the log was quite useful to spot what went
>> wrong during PIO.
>
> I don't think it's as useful as you seem to think. Compare
> mac_esp_send_pdma_cmd().
>
>> Maybe mention in the changelog that commands during PIO are no longer
>> logged? Or introduce a new ESP_EVENT_PIO and log that at the start of
>> PIO?
>>
>
> Yes, and I did leave a scsi_esp_cmd(esp, cmd) call at the start of PIO.

Which I missed from just looking at the patch, sorry.

> That should be sufficient, right?

It would indeed. Thanks for clarifying.

Cheers,

	Michael
