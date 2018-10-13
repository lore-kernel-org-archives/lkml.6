Return-Path: <SRS0=sHJz=MZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21B37C28CF8
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Oct 2018 04:02:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C13A420877
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Oct 2018 04:02:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oUlMc35w"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C13A420877
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726388AbeJMLhg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 13 Oct 2018 07:37:36 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:41684 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726125AbeJMLhg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Oct 2018 07:37:36 -0400
Received: by mail-pg1-f195.google.com with SMTP id 23-v6so6701714pgc.8;
        Fri, 12 Oct 2018 21:02:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=mVkQPUUBWYic4DfiRsFBs59QxNFJOg64Ec3/iEu3Gdc=;
        b=oUlMc35wuXpSuRnJ98KKsXME5vsGUQxlu0jCQJPoGOFkOuMrQoPgM5xSOBLSFq1avM
         WYIt+oBKkaT3ho9PVis0RCf2tUvgrg39KqjaKPhQoLuB6bEHXKkc13u8q8hw1sFf7jk7
         vhPRiqQiZV1OH0dcKzHBX2XeoLlu4x10dXxl6P/BGZG2+lMwXm0RSdYuNlef6d0oVxYw
         b/FakJYVjM3NkhWDkiI1nwIV/2/wdA8d7BvSLLgmqExVCzl4AlkjoRMshAZh8yg8tFz3
         cVahuvj6UMtuQW1KvMR17dAdf+1bZ/l8PCTqb/mh9grEXkaOVyGCPxE1gsvHb9Hibo0m
         M8Ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:cc:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=mVkQPUUBWYic4DfiRsFBs59QxNFJOg64Ec3/iEu3Gdc=;
        b=ZUBkbQ0/TklFlVOBMw/y0ueEy8Bnpyz0qkwi1Ca3PSXb0Vzt34eGe21tYa3jpd4Nau
         WfEgjqnL1WCFohvK5V0lP9bpGfqTKvTGZyY34XcPXcPZk4XUIa6Asli5bzHXaSiPRnMG
         2X7npMuDMnNr9PMlcs+hQLc4494MLGgM8Pr7NjWfwo76jaMKImmDsnRgsxqnQRNz9kcE
         0z25wTVuzL3T/qQ1adiY0vU8f9TPa9CA4P1pDAuCsP1E7ydWHplk8noUkQ443ugnhPXz
         qa9nM1CmL9zNtQui5VgZsr8AjSXc3w0gUfP2IpxDXHNYsJT4bJvP5VmZSqTt1iDE0aud
         uGBQ==
X-Gm-Message-State: ABuFfojAd/j1LgonwbKKEJqTqjsz9Asd1gw/aoIIdgnbzR0mgwNy2njs
        KPdjcDdEh14gxdQ0yqalDoAP5N9N
X-Google-Smtp-Source: ACcGV62cJeInav1mTa/JZbbgi3PsLC/zerDyt6TaPsSvDoGZ9WrT8gv/yO+s6+GgMFvebXSBCU4PBQ==
X-Received: by 2002:a63:9a42:: with SMTP id e2-v6mr8090017pgo.340.1539403322568;
        Fri, 12 Oct 2018 21:02:02 -0700 (PDT)
Received: from [192.168.1.101] (122-62-216-69-adsl.sparkbb.co.nz. [122.62.216.69])
        by smtp.gmail.com with ESMTPSA id p7-v6sm4272802pfb.101.2018.10.12.21.01.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 12 Oct 2018 21:02:01 -0700 (PDT)
Subject: Re: [PATCH 6/6] esp_scsi: Optimize PIO loops
To:     Finn Thain <fthain@telegraphics.com.au>,
        "James E.J. Bottomley" <jejb@linux.vnet.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
References: <cover.1539391876.git.fthain@telegraphics.com.au>
 <3a2534bff570653de6897afa081017e2a359747e.1539391876.git.fthain@telegraphics.com.au>
Cc:     Hannes Reinecke <hare@suse.de>, linux-scsi@vger.kernel.org,
        linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org
From:   Michael Schmitz <schmitzmic@gmail.com>
Message-ID: <3ba0d49c-57ce-40df-b406-98afc183275e@gmail.com>
Date:   Sat, 13 Oct 2018 17:02:09 +1300
User-Agent: Mozilla/5.0 (X11; Linux ppc; rv:45.0) Gecko/20100101
 Icedove/45.4.0
MIME-Version: 1.0
In-Reply-To: <3a2534bff570653de6897afa081017e2a359747e.1539391876.git.fthain@telegraphics.com.au>
Content-Type: text/plain; charset=iso-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Finn,

Am 13.10.2018 um 13:51 schrieb Finn Thain:
> Avoid function calls in the inner PIO loops. On a Centris 660av this
> improves throughput for sequential read transfers by about 40% and
> sequential write by about 10%.
>
> Unfortunately it is not possible to have method calls like esp_write8()
> placed inline so this is always going to be slow (even with LTO).
>
> Tested-by: Stan Johnson <userm57@yahoo.com>
> Signed-off-by: Finn Thain <fthain@telegraphics.com.au>
> ---
>  drivers/scsi/esp_scsi.c | 14 +++++++-------
>  1 file changed, 7 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/scsi/esp_scsi.c b/drivers/scsi/esp_scsi.c
> index 646701fc22a4..9f0e68cd0e99 100644
> --- a/drivers/scsi/esp_scsi.c
> +++ b/drivers/scsi/esp_scsi.c
> @@ -2788,7 +2788,7 @@ static inline unsigned int esp_wait_for_fifo(struct esp *esp)
>  		if (fbytes)
>  			return fbytes;
>
> -		udelay(2);
> +		udelay(1);
>  	} while (--i);
>
>  	pr_err("FIFO is empty (sreg %02x)\n", esp_read8(ESP_STATUS));
> @@ -2804,7 +2804,7 @@ static inline int esp_wait_for_intr(struct esp *esp)
>  		if (esp->sreg & ESP_STAT_INTR)
>  			return 0;
>
> -		udelay(2);
> +		udelay(1);
>  	} while (--i);
>
>  	pr_err("IRQ timeout (sreg %02x)\n", esp->sreg);
> @@ -2831,7 +2831,7 @@ void esp_send_pio_cmd(struct esp *esp, u32 addr, u32 esp_count,
>  			if (!esp_wait_for_fifo(esp))
>  				break;
>
> -			*dst++ = esp_read8(ESP_FDATA);
> +			*dst++ = readb(esp->fifo_reg);
>  			--esp_count;
>
>  			if (!esp_count)
> @@ -2852,15 +2852,15 @@ void esp_send_pio_cmd(struct esp *esp, u32 addr, u32 esp_count,
>  			}
>
>  			if (phase == ESP_MIP)
> -				scsi_esp_cmd(esp, ESP_CMD_MOK);
> +				esp_write8(ESP_CMD_MOK, ESP_CMD);

You're no longer logging this command with this patch. (That'll be the 
reason for the speedup you saw ...)

>
> -			scsi_esp_cmd(esp, ESP_CMD_TI);
> +			esp_write8(ESP_CMD_TI, ESP_CMD);

Same here..

>  		}
>  	} else {
>  		unsigned int n = ESP_FIFO_SIZE;
>  		u8 *src = (u8 *)addr;
>
> -		scsi_esp_cmd(esp, ESP_CMD_FLUSH);
> +		esp_write8(ESP_CMD_FLUSH, ESP_CMD);

here..

>
>  		if (n > esp_count)
>  			n = esp_count;
> @@ -2894,7 +2894,7 @@ void esp_send_pio_cmd(struct esp *esp, u32 addr, u32 esp_count,
>  			src += n;
>  			esp_count -= n;
>
> -			scsi_esp_cmd(esp, ESP_CMD_TI);
> +			esp_write8(ESP_CMD_TI, ESP_CMD);

and here.

The burst of ESP_CMD_TI's in the log was quite useful to spot what went 
wrong during PIO. Maybe mention in the changelog that commands during 
PIO are no longer logged? Or introduce a new ESP_EVENT_PIO and log that 
at the start of PIO?

Cheers,

	Michael



>  		}
>  	}
>
>
