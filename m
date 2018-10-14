Return-Path: <SRS0=+AQW=M2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,UNWANTED_LANGUAGE_BODY autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84BA8C6787C
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Oct 2018 07:35:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 36D8920835
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Oct 2018 07:35:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qV0lA7DO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 36D8920835
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726444AbeJNPPW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 14 Oct 2018 11:15:22 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:33066 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726124AbeJNPPW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Oct 2018 11:15:22 -0400
Received: by mail-pf1-f196.google.com with SMTP id 78-v6so5776074pfq.0;
        Sun, 14 Oct 2018 00:35:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=xrEAzE94gTclvu/rFqA5CT7mODu4kML+W0LD6u+FTkw=;
        b=qV0lA7DOR/XSWBIl1ip1FTT9CQMvJOytZHIKeP9Ctw91I4PUeNpgDgGChc5gVxwoIM
         yS/Vwpx/aYLFOtsAkjgHyI4VJSIwQFiSwn9eAWDFG3cIvLo4YFKIb7UDUCAwm5x/g+26
         fYElyDOcJXtjSw/bHTcngUK5tr2RUT2p44frWIH0A/VUNC23n/+5gcr4mEwl2UQYzXjo
         5TtaE1L9R+PHUMIfJVmi2zw1KtrDwGjPFat5t8Ina8LXJNxDAjw078GWk7vVavY47+nP
         8P4yh487lNKAJPEvpJ+Vf9bsGzeqJXeUknBFxe3kidmMV/HstPZdwGTyQnRQS8TlpKIG
         i56A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:cc:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=xrEAzE94gTclvu/rFqA5CT7mODu4kML+W0LD6u+FTkw=;
        b=Qcys8jXdEsbsLxcA/JGeaIsp1HY85MYzqK3g6qAyq1sTe0yJpLmYWMSiWU/KWvqe6R
         GIIbIgyyfndNNoBwp8uvN5dmL0K9YKARAKzcIAoctMaqdEVF5rwRFNAJjS2qbIQ8vlFK
         JU7sUe8UCDvyCfEfOt/2QdgqE1Me7tOZsrBtRtGkRTAX34YEQKh6knlM6Vx77y1UN9rq
         Xz4CGbJ/9eQUT9HA/HCTpQgBkj8P0wgVmzDW0V+FSNMc3Bsn+RZ6i0VOEvzObYFXPqFm
         5hLCUdwO6ab8pjCYY4tuwQFe5dDaFKpnPvtkOHszWYE7yLd34CXF2yWs0+x1E1x+vej8
         BfxQ==
X-Gm-Message-State: ABuFfoj+6zhlaHX/qmlmiF6T8UowDSJH2Y6pFfvu5Et4ckA/LzCJhqYi
        Rnf+0vgUzW9eMkOVicm4GqR6camJZ2I=
X-Google-Smtp-Source: ACcGV60TCL3v2LSyAmh/KHwpbubiJhuHje/70ozSOJjsrmqGm745uCRUV/HCTB4eRMbaT2nCfKHBhQ==
X-Received: by 2002:a63:525c:: with SMTP id s28-v6mr11546902pgl.78.1539502515670;
        Sun, 14 Oct 2018 00:35:15 -0700 (PDT)
Received: from [192.168.1.101] (122-62-216-69-adsl.sparkbb.co.nz. [122.62.216.69])
        by smtp.gmail.com with ESMTPSA id a14-v6sm7947273pgi.75.2018.10.14.00.35.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 14 Oct 2018 00:35:15 -0700 (PDT)
Subject: Re: [PATCH v2 1/6] zorro_esp: Limit DMA transfers to 65535 bytes
To:     Finn Thain <fthain@telegraphics.com.au>,
        "James E.J. Bottomley" <jejb@linux.vnet.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
References: <cover.1539497520.git.fthain@telegraphics.com.au>
 <022a8c581d228f3f01dfa783aadd183a53169daa.1539497520.git.fthain@telegraphics.com.au>
Cc:     Hannes Reinecke <hare@suse.de>, linux-scsi@vger.kernel.org,
        linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org
From:   Michael Schmitz <schmitzmic@gmail.com>
Message-ID: <19de2671-ea20-3917-7ed6-4b8217fe17ad@gmail.com>
Date:   Sun, 14 Oct 2018 20:35:23 +1300
User-Agent: Mozilla/5.0 (X11; Linux ppc; rv:45.0) Gecko/20100101
 Icedove/45.4.0
MIME-Version: 1.0
In-Reply-To: <022a8c581d228f3f01dfa783aadd183a53169daa.1539497520.git.fthain@telegraphics.com.au>
Content-Type: text/plain; charset=iso-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Finn,

thanks for spotting this!

Am 14.10.2018 um 19:12 schrieb Finn Thain:
> The core driver, esp_scsi, does not use the ESP_CONFIG2_FENAB bit, so
> the chip's Transfer Counter register is only 16 bits wide (not 24).
> A larger transfer cannot work and will theoretically result in a failed
> command and a "DMA length is zero" error.
>
> Fixes: 3109e5ae0311
> Signed-off-by: Finn Thain <fthain@telegraphics.com.au>
> Cc: Michael Schmitz <schmitzmic@gmail.com>
> Tested-by: Michael Schmitz <schmitzmic@gmail.com>

Reviewed-by: Michael Schmitz <schmitzmic@gmail.com>

> ---
>  drivers/scsi/zorro_esp.c | 8 +-------
>  1 file changed, 1 insertion(+), 7 deletions(-)
>
> diff --git a/drivers/scsi/zorro_esp.c b/drivers/scsi/zorro_esp.c
> index bb70882e6b56..be79127db594 100644
> --- a/drivers/scsi/zorro_esp.c
> +++ b/drivers/scsi/zorro_esp.c
> @@ -245,7 +245,7 @@ static int fastlane_esp_irq_pending(struct esp *esp)
>  static u32 zorro_esp_dma_length_limit(struct esp *esp, u32 dma_addr,
>  					u32 dma_len)
>  {
> -	return dma_len > 0xFFFFFF ? 0xFFFFFF : dma_len;
> +	return dma_len > 0xFFFF ? 0xFFFF : dma_len;
>  }
>
>  static void zorro_esp_reset_dma(struct esp *esp)
> @@ -484,7 +484,6 @@ static void zorro_esp_send_blz1230_dma_cmd(struct esp *esp, u32 addr,
>  	scsi_esp_cmd(esp, ESP_CMD_DMA);
>  	zorro_esp_write8(esp, (esp_count >> 0) & 0xff, ESP_TCLOW);
>  	zorro_esp_write8(esp, (esp_count >> 8) & 0xff, ESP_TCMED);
> -	zorro_esp_write8(esp, (esp_count >> 16) & 0xff, ESP_TCHI);
>
>  	scsi_esp_cmd(esp, cmd);
>  }
> @@ -529,7 +528,6 @@ static void zorro_esp_send_blz1230II_dma_cmd(struct esp *esp, u32 addr,
>  	scsi_esp_cmd(esp, ESP_CMD_DMA);
>  	zorro_esp_write8(esp, (esp_count >> 0) & 0xff, ESP_TCLOW);
>  	zorro_esp_write8(esp, (esp_count >> 8) & 0xff, ESP_TCMED);
> -	zorro_esp_write8(esp, (esp_count >> 16) & 0xff, ESP_TCHI);
>
>  	scsi_esp_cmd(esp, cmd);
>  }
> @@ -574,7 +572,6 @@ static void zorro_esp_send_blz2060_dma_cmd(struct esp *esp, u32 addr,
>  	scsi_esp_cmd(esp, ESP_CMD_DMA);
>  	zorro_esp_write8(esp, (esp_count >> 0) & 0xff, ESP_TCLOW);
>  	zorro_esp_write8(esp, (esp_count >> 8) & 0xff, ESP_TCMED);
> -	zorro_esp_write8(esp, (esp_count >> 16) & 0xff, ESP_TCHI);
>
>  	scsi_esp_cmd(esp, cmd);
>  }
> @@ -599,7 +596,6 @@ static void zorro_esp_send_cyber_dma_cmd(struct esp *esp, u32 addr,
>
>  	zorro_esp_write8(esp, (esp_count >> 0) & 0xff, ESP_TCLOW);
>  	zorro_esp_write8(esp, (esp_count >> 8) & 0xff, ESP_TCMED);
> -	zorro_esp_write8(esp, (esp_count >> 16) & 0xff, ESP_TCHI);
>
>  	if (write) {
>  		/* DMA receive */
> @@ -649,7 +645,6 @@ static void zorro_esp_send_cyberII_dma_cmd(struct esp *esp, u32 addr,
>
>  	zorro_esp_write8(esp, (esp_count >> 0) & 0xff, ESP_TCLOW);
>  	zorro_esp_write8(esp, (esp_count >> 8) & 0xff, ESP_TCMED);
> -	zorro_esp_write8(esp, (esp_count >> 16) & 0xff, ESP_TCHI);
>
>  	if (write) {
>  		/* DMA receive */
> @@ -691,7 +686,6 @@ static void zorro_esp_send_fastlane_dma_cmd(struct esp *esp, u32 addr,
>
>  	zorro_esp_write8(esp, (esp_count >> 0) & 0xff, ESP_TCLOW);
>  	zorro_esp_write8(esp, (esp_count >> 8) & 0xff, ESP_TCMED);
> -	zorro_esp_write8(esp, (esp_count >> 16) & 0xff, ESP_TCHI);
>
>  	if (write) {
>  		/* DMA receive */
>
