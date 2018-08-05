Return-Path: <SRS0=mdhE=KU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E55BC46471
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Aug 2018 14:26:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AA61721885
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Aug 2018 14:26:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="HUhSr34y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AA61721885
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726708AbeHEQbF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 5 Aug 2018 12:31:05 -0400
Received: from mail-it0-f67.google.com ([209.85.214.67]:35967 "EHLO
        mail-it0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726254AbeHEQbE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Aug 2018 12:31:04 -0400
Received: by mail-it0-f67.google.com with SMTP id p81-v6so14755501itp.1
        for <linux-kernel@vger.kernel.org>; Sun, 05 Aug 2018 07:26:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=EBSpZbBoitTzl6dPRuWOGKPeqt2UObIJbQjX7zQLrzA=;
        b=HUhSr34yyXSuu+59idttIZbztJotyEyl8jTq/HX0zntwK/1Eg8MEukIOk163WNvBFy
         zVOCiButaGz00+D90RIzg0E5ZkcGxlzfcRPiRfBFduyKTuy3e20bbRFjLs1UvA68t75n
         HVQQc7xf9Jhixn9dukJk819B9R88O73FcuRwJAHRB6wbc4Wv5retO4nMBn49PJrbYatL
         W8BHZEGFEF+d27ykY+46R3prmLb62+/u8+wuTlM1hLjj920Dd5VNUzx2xKAj3U1DpI0A
         DN8l0kh8Wc4/1Zndly4fRKrJ3qQMdIx1YONaopzSmy2K6pW78uKd1Tn3JxS4MXeyG2fY
         HW9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=EBSpZbBoitTzl6dPRuWOGKPeqt2UObIJbQjX7zQLrzA=;
        b=M0a62TZwIEQc2gMFTXG7k5fad6tEer+SPBtuSXsmTxnf62o94StkOC9ZEBpmYmMXWy
         W3pgMvuzfuM4/sQX/Ty0vQdYkxhFC4jWaMRf3nPCg2DjgMJ4s/G2JIKMNinBV00DcUiW
         RjXYB+eh+YSTrQn0oqdev0QcNJ6+uSv+jPGoa7WE9QahZfCiokHRPydJXIJdlMW9wsaV
         /m3KCz74dQS8QhSnDXXDcQ3lb/EIXKiAhmAEXGqo4JeR8LkJ1PB71SnmpUVxdeo9pgTW
         GFDqhK2QHTsIlWGDM/kFo5cuGrHcrxez5rMMqwa+lTCZZQxYkDJJLmrEbT7nUgfe+6KG
         kn/g==
X-Gm-Message-State: AOUpUlGPFCY1/0Mk9iwuNkz0n6GDP98zI87Fq2OZRud8qP3Garhh2Rlc
        vrfwvlAEy8HYhK7Ph9S25DbIOmZTg58=
X-Google-Smtp-Source: AAOMgpdQr0I/VX3nxl+Eb3vUtbX24aSV71ygQk4qSRt2iOwM9nemRR0YhX055ugx11VNyBZk1semKQ==
X-Received: by 2002:a24:7d0a:: with SMTP id b10-v6mr12418695itc.105.1533479177927;
        Sun, 05 Aug 2018 07:26:17 -0700 (PDT)
Received: from [192.168.1.212] (107.191.0.158.static.utbb.net. [107.191.0.158])
        by smtp.gmail.com with ESMTPSA id w16-v6sm2962253iom.32.2018.08.05.07.26.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 05 Aug 2018 07:26:16 -0700 (PDT)
Subject: Re: [PATCH] lightnvm: remove minor version check for 2.0
To:     =?UTF-8?Q?Matias_Bj=c3=b8rling?= <mb@lightnvm.io>
Cc:     Javier Gonzalez <javier@cnexlabs.com>,
        "Konopko, Igor J" <igor.j.konopko@intel.com>,
        "marcin.dziegielewski@intel.com" <marcin.dziegielewski@intel.com>,
        Hans Holmberg <hans.holmberg@cnexlabs.com>,
        Heiner Litz <hlitz@ucsc.edu>,
        Young Tack Tack Jin <youngtack.jin@circuitblvd.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20180803090237.2022-1-mb@lightnvm.io>
 <7B08AEC1-90F8-4AE0-AE46-BADF8CC8D270@cnexlabs.com>
 <2f1d5972-3257-22e0-efd7-0038f979f438@lightnvm.io>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <e2436194-0de5-df6a-5912-3346d6fca75b@kernel.dk>
Date:   Sun, 5 Aug 2018 08:26:14 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <2f1d5972-3257-22e0-efd7-0038f979f438@lightnvm.io>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/5/18 2:29 AM, Matias Bjørling wrote:
> On 8/3/18 2:07 PM, Javier Gonzalez wrote:
>>> On 3 Aug 2018, at 11.02, Matias Bjørling <mb@lightnvm.io> wrote:
>>>
>>> A minor version number increase should not break backwards
>>> compatibility.
>>>
>>> Fixes: 3cb98f84d368b ("lightnvm: add minor version to generic geometry")
>>> Signed-off-by: Matias Bjørling <mb@lightnvm.io>
>>> ---
>>> drivers/nvme/host/lightnvm.c | 6 ------
>>> 1 file changed, 6 deletions(-)
>>>
>>> diff --git a/drivers/nvme/host/lightnvm.c b/drivers/nvme/host/lightnvm.c
>>> index d9e4cccd5b66..a156fe3ca7d3 100644
>>> --- a/drivers/nvme/host/lightnvm.c
>>> +++ b/drivers/nvme/host/lightnvm.c
>>> @@ -414,12 +414,6 @@ static int nvme_nvm_setup_20(struct nvme_nvm_id20 *id,
>>> 	/* Set compacted version for upper layers */
>>> 	geo->version = NVM_OCSSD_SPEC_20;
>>>
>>> -	if (!(geo->major_ver_id == 2 && geo->minor_ver_id == 0)) {
>>> -		pr_err("nvm: OCSSD version not supported (v%d.%d)\n",
>>> -				geo->major_ver_id, geo->minor_ver_id);
>>> -		return -EINVAL;
>>> -	}
>>> -
>>> 	geo->num_ch = le16_to_cpu(id->num_grp);
>>> 	geo->num_lun = le16_to_cpu(id->num_pu);
>>> 	geo->all_luns = geo->num_ch * geo->num_lun;
>>> --
>>> 2.11.0
>>
>> Looks good to me.
>>
>> Reviewed-by: Javier González <javier@cnexlabs.com>
>>
> 
> Hi Jens,
> 
> Would it be possible to pick this one up for 4.19?

Done.

-- 
Jens Axboe

