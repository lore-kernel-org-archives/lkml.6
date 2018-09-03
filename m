Return-Path: <SRS0=G629=LR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 097B6C43334
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 07:35:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A42CA20843
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 07:35:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HH3u2IO5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A42CA20843
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726206AbeICLyV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Sep 2018 07:54:21 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:34305 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725866AbeICLyU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Sep 2018 07:54:20 -0400
Received: by mail-pl1-f195.google.com with SMTP id f6-v6so8262837plo.1;
        Mon, 03 Sep 2018 00:35:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=MX9rkrEhdmxLFk0aEZI7Sr5zdnPjJJ7FGLQ/0RUHnQg=;
        b=HH3u2IO5bO/rdnD1XEAv+oZciQKjUUvqdf630TcxXXY8TDlNd23hLX7wtLPB4IWtp0
         Vb+skVoX9q0V1+CRdwHRB0yEsWoTiUXQbXFA+PC6m65RNozxm/kuTCDJMQZhXTP0swVZ
         cqARaMl97iiCvUI8iDG7HEySjYRgErBOgbLL4hH8eJgxDjYErRHDc9UXtqQLjYAkY+an
         VzEY59W+kj9hW4a/qSI4WrgjNpg25oGQ0NVxgxLDfdPfBzVwOtEPDpUL4o3StPGIRawE
         hanHqlfCjOEbYGQL8l0Tmin+bPICFAPf+/TWiGVK+6yAwtQnMRWRKVeMHv2dSchMc9H/
         A9eQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=MX9rkrEhdmxLFk0aEZI7Sr5zdnPjJJ7FGLQ/0RUHnQg=;
        b=patlQDk+SHCz84kJJJ/vqiOvB/ANIu4ZoSFqdu26b7w8OfEmDF2YwW7zzsk4AYv2uP
         TrKJguhpiLPfTCjKj3ZkfEh0w6vDKvbvo155bEzHqgSl5CRc3cI31Xcj8dlAT+hta9VE
         DPw42oTeJ9V32GbrXGmOdU76rrtXCpDQO0atf/c4wx28eIPEDSRgkJcNC8SDVEgUt9ET
         EpoxlJzgtlK5WhgF8ggkof0Y369HYcOEO3vYQPMEAhvxjlnsHedYxMFNSGH7sIsmkyZQ
         F6upkt4yKusEtPvgDQSsAVWAqejl1Vmyzb7uErEsqsov0eMQdSqgfJuWoFkYMT1NeDwQ
         2fdQ==
X-Gm-Message-State: APzg51DAHF+t28IfNpFiY7ednd0elxn9cl1dPuBlYQFDxp2cJKkjZqmi
        kejWF0AtG6Bl5b6jZr4ALsqz23QA
X-Google-Smtp-Source: ANB0VdaRw6s7p8t6R8cVQ89zYbAaoMcng5zbf4sFONtfnZllvKg6LBnUhs24V2Hf9gA0jClgF2fOVQ==
X-Received: by 2002:a17:902:7587:: with SMTP id j7-v6mr27398607pll.256.1535960126970;
        Mon, 03 Sep 2018 00:35:26 -0700 (PDT)
Received: from ?IPv6:2402:f000:1:1501:200:5efe:166.111.71.58? ([2402:f000:1:1501:200:5efe:a66f:473a])
        by smtp.gmail.com with ESMTPSA id g5-v6sm26684019pfc.77.2018.09.03.00.35.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 03 Sep 2018 00:35:26 -0700 (PDT)
Subject: Re: [EXT] [BUG] net: wireless: mwifiex: A possible
 sleep-in-atomic-context bug in mwifiex_wait_queue_complete()
To:     Ganapathi Bhat <gbhat@marvell.com>,
        "amitkarwar@gmail.com" <amitkarwar@gmail.com>,
        "nishants@marvell.com" <nishants@marvell.com>,
        "huxinming820@gmail.com" <huxinming820@gmail.com>,
        "kvalo@codeaurora.org" <kvalo@codeaurora.org>
Cc:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <35980039-f268-2db3-5c7d-19ab0c917d44@gmail.com>
 <5fbe17917c344f318c25a688f2e94823@SC-EXCH02.marvell.com>
From:   Jia-Ju Bai <baijiaju1990@gmail.com>
Message-ID: <3ecba946-7656-3f86-df81-c0b5aff2e3d3@gmail.com>
Date:   Mon, 3 Sep 2018 15:35:23 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.0
MIME-Version: 1.0
In-Reply-To: <5fbe17917c344f318c25a688f2e94823@SC-EXCH02.marvell.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2018/9/3 14:41, Ganapathi Bhat wrote:
> Hi Jia-Ju,
>
>> [FUNC] schedule_timeout
>> drivers/net/wireless/marvell/mwifiex/sta_ioctl.c, 63:
>>       schedule_timeout in mwifiex_wait_queue_complete
>> drivers/net/wireless/marvell/mwifiex/cmdevt.c, 673:
>>       mwifiex_wait_queue_complete in mwifiex_send_cmd
> Here, mwifiex_send_cmd does not call mwifiex_wait_queue_complete, because the sync parameter is false.
> Note that the function mwifiex_multi_chan_resync did call mwifiex_send_cmd with sync = false.

Thanks for the reply.
I check the code again, and find my report it false, sorry for that.


Best wishes,
Jia-Ju Bai
