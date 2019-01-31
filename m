Return-Path: <SRS0=Wtxu=QH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BFAAC169C4
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 15:24:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2B48420869
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 15:24:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="r5Z8QD/t"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732184AbfAaPYb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Jan 2019 10:24:31 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:41181 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726060AbfAaPYa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Jan 2019 10:24:30 -0500
Received: by mail-lj1-f194.google.com with SMTP id k15-v6so3006542ljc.8;
        Thu, 31 Jan 2019 07:24:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=xNGpCt0dFRJzvyMaqTiKTlg+Ocg7wC/TGrFxIAwI8mE=;
        b=r5Z8QD/tyjlcCJXSonPOdyOxhlgnWqdsazdpSSNDYKbA33B8bSZwe4RR/A5pGclZoU
         gAm2aYH6dNnlnUAi43nJOvOuKdSYIl4MyHz+t/jo0dvFgN2yKQTF9G603Hk4bq7VarRi
         PKshG64NZT2qv1nF3/6dagh8i2vB+AboeNHEjWARJEpNKUy8g3IAuPMpcx3Kh+S2tiMj
         Zoxp49+jHoJtMN200z3tdjOfifNAculQSEddpY097rP0nj2aYg9RhWuNwfmpf440m8Oa
         UnE926z8xvW1WmcwD/E8Xu7U29w2tAmwRhe8SvAQgSfFTQXLDjKEBMtd7JhPfwk9CbxY
         0zlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=xNGpCt0dFRJzvyMaqTiKTlg+Ocg7wC/TGrFxIAwI8mE=;
        b=fbPAmuAASIcgpSByqfB6BTb0R+dvhCMxajx6bHEXpRib5L52NmAnJ5QMZHHrijm7Um
         Sft0ke5kOSvHZfbxZMgQelYclogjERk7WB4IcOCv9IyaM77OBZEtYnttlpwmxujdXnPr
         +jaDHdqoY5bW7D0GcFZ6StElaSFPucFOqMTH4sJsNtrLb5wfhomPNf2NLQKNOp2uD9NT
         1b6JQKEcz4QxHk7KR0qt/0/z1v4zHhO4lCzmHAXDwZ6b9IFHrMlxCVMW8+DnaQyt1VMe
         nS8iAjVzjfd0g3RPcziQY4hkcs5Uda1QuN1sBlQIj08tl2aMl4f0MDBL/c8Yhv+ooOlM
         CKiQ==
X-Gm-Message-State: AJcUuke+C1URZcALJGB+8l66WMaC/GycKnF2JSAyK8r84wLsaI42cdhb
        kffndLfWmNidZkzy/XSQbCEK1OpS
X-Google-Smtp-Source: ALg8bN4pH9bhMxJ6rQpUFl6J+sJoOvyGiWGitIGQ/ri7B0riImj+mzjMuG6u0tpFehY5VesCDRlW9w==
X-Received: by 2002:a2e:4a19:: with SMTP id x25-v6mr24990376lja.19.1548948268084;
        Thu, 31 Jan 2019 07:24:28 -0800 (PST)
Received: from [192.168.2.145] (ppp91-79-175-49.pppoe.mtu-net.ru. [91.79.175.49])
        by smtp.googlemail.com with ESMTPSA id z9sm865454lfj.79.2019.01.31.07.24.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 31 Jan 2019 07:24:27 -0800 (PST)
Subject: Re: [PATCH V8 3/5] i2c: tegra: Add DMA Support
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Sowjanya Komatineni <skomatineni@nvidia.com>,
        thierry.reding@gmail.com, jonathanh@nvidia.com,
        mkarthik@nvidia.com, smohammed@nvidia.com, talho@nvidia.com
Cc:     linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-i2c@vger.kernel.org
References: <1548915387-28826-1-git-send-email-skomatineni@nvidia.com>
 <1548915387-28826-3-git-send-email-skomatineni@nvidia.com>
 <4663c7b9-d306-1cd4-1bdc-f7be84af0667@gmail.com>
Message-ID: <8a88f8ee-24d3-00ac-f1fa-c43b576ed82c@gmail.com>
Date:   Thu, 31 Jan 2019 18:24:26 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <4663c7b9-d306-1cd4-1bdc-f7be84af0667@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

31.01.2019 18:12, Dmitry Osipenko пишет:
> 31.01.2019 9:16, Sowjanya Komatineni пишет:
>> This patch adds DMA support for Tegra I2C.
>>
>> Tegra I2C TX and RX FIFO depth is 8 words. PIO mode is used for
>> transfer size of the max FIFO depth and DMA mode is used for
>> transfer size higher than max FIFO depth to save CPU overhead.
>>
>> PIO mode needs full intervention of CPU to fill or empty FIFO's
>> and also need to service multiple data requests interrupt for the
>> same transaction. This adds delay between data bytes of the same
>> transfer when CPU is fully loaded and some slave devices has
>> internal timeout for no bus activity and stops transaction to
>> avoid bus hang. DMA mode is helpful in such cases.
>>
>> DMA mode is also helpful for Large transfers during downloading or
>> uploading FW over I2C to some external devices.
>>
>> Signed-off-by: Sowjanya Komatineni <skomatineni@nvidia.com>
>> ---
>>  [V8] : Moved back dma init to i2c probe, removed ALL_PACKETS_XFER_COMPLETE
>> 	interrupt and using PACKETS_XFER_COMPLETE interrupt only and some
>> 	other fixes
>> 	Updated Kconfig for APB_DMA dependency
>>  [V7] : Same as V6
>>  [V6] : Updated for proper buffer allocation/freeing, channel release.
>> 	Updated to use exact xfer size for syncing dma buffer.
>>  [V5] : Same as V4
>>  [V4] : Updated to allocate DMA buffer only when DMA mode.
>> 	Updated to fall back to PIO mode when DMA channel request or
>> 	buffer allocation fails.
>>  [V3] : Updated without additional buffer allocation.
>>  [V2] : Updated based on V1 review feedback along with code cleanup for
>> 	proper implementation of DMA.
>>
>>  drivers/i2c/busses/Kconfig     |   2 +-
>>  drivers/i2c/busses/i2c-tegra.c | 362 ++++++++++++++++++++++++++++++++++++++---
>>  2 files changed, 339 insertions(+), 25 deletions(-)
> 
> Tegra20 crashes because of this patch:
> 
[snip]
> <4>[    3.395915] ------------[ cut here ]------------
> <2>[    3.395919] kernel BUG at drivers/i2c/busses/i2c-tegra.c:810!
The BUG line is from:

	if (status & I2C_INT_PACKET_XFER_COMPLETE) {
		if (i2c_dev->is_curr_dma_xfer)
			i2c_dev->msg_buf_remaining = 0;
		BUG_ON(i2c_dev->msg_buf_remaining);
		complete(&i2c_dev->msg_complete);
	}
