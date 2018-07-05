Return-Path: <SRS0=71UW=JV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3882BC6778A
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 14:54:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E5F21219E8
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 14:54:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="Jiw6IR4f"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E5F21219E8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753966AbeGEOyT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Jul 2018 10:54:19 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:34041 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753955AbeGEOwB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jul 2018 10:52:01 -0400
Received: by mail-wr1-f67.google.com with SMTP id c13-v6so1297830wrt.1
        for <linux-kernel@vger.kernel.org>; Thu, 05 Jul 2018 07:52:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=JzBMChz/lt4Gi+1CZj09sgYDAUw1QymR1m5+3Bq5ETc=;
        b=Jiw6IR4fxB6YFW5COfEzu6UmcLJP2zbj86ZlCF6HWLBbBDCM7UGQOheHxHQJPuIGbH
         F+gSv4Qon4IGrOGwgAN1OowCw5dweKMdB7jHHKxXdAs9Q2xjx12XC/QUDpIZjUFm5SOB
         ypsEpXxD8vfVPONCDyRP/9AWtC4+dvv/ok/Q0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=JzBMChz/lt4Gi+1CZj09sgYDAUw1QymR1m5+3Bq5ETc=;
        b=k5y4Kl+v+0xrYKTjPYiUVQ4FgtZMFNw0+GjW1zZnoQiHR84rGg2cjz7pVjRA4diPqN
         uFX9VHlW5NUGHScZAAOlpGyZuz0KMJihj4VkY+LLrCDd5KrN1whUBK4UUWfEZEcY0AY6
         GLf5oLBb40Bs/1kyCjmyHk2PoERCB0SbHnSrPrSOndvY1N/BzlWVj0hqbhPuk1zVLxyo
         gcGh9daZn0Db6W6qVnMrOqa2/aAi2upzlNVbQElAoCpljoKU12yN5sQFSnQVY6ztQhVQ
         YtcoEx0EjN4/eOQiR4AFOnHq0+3XJAHawAylJ70xKH1DwDArwLwp7JPRfb59j1eb9SGZ
         ksVQ==
X-Gm-Message-State: APt69E3QFt9CWbJcoljx3mo8XEXY7LQ0n2j5vc+0Dba7iSLRCE2fkK4K
        B8SC0SMHO9T0Mn1Cfo2r2lnmeg==
X-Google-Smtp-Source: AAOMgpc7qItLk1y+A64axfmkEJ3TEYor9QnPJCw59OnEf/4NSQ+i3gEmivnnHyuaak2uyawDk3DJJg==
X-Received: by 2002:adf:a9f0:: with SMTP id b103-v6mr4677985wrd.271.1530802320405;
        Thu, 05 Jul 2018 07:52:00 -0700 (PDT)
Received: from [192.168.27.209] ([37.157.136.206])
        by smtp.googlemail.com with ESMTPSA id 18-v6sm3682003wmg.19.2018.07.05.07.51.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 05 Jul 2018 07:51:59 -0700 (PDT)
Subject: Re: [PATCH v5 00/27] Venus updates
To:     Hans Verkuil <hverkuil@xs4all.nl>, Tomasz Figa <tfiga@chromium.org>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Linux Media Mailing List <linux-media@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        vgarodia@codeaurora.org, Alexandre Courbot <acourbot@chromium.org>
References: <20180705130401.24315-1-stanimir.varbanov@linaro.org>
 <CAAFQd5CQCF=QvTgq8v6K6W6C0Cy27CzHsMxQn+FnML97w9xnCw@mail.gmail.com>
 <150eb3b4-8b64-6050-6a4e-e06cfaf113cc@xs4all.nl>
From:   Stanimir Varbanov <stanimir.varbanov@linaro.org>
Message-ID: <6abf8da2-b2e1-1b4f-2727-f9d074081c30@linaro.org>
Date:   Thu, 5 Jul 2018 17:51:57 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <150eb3b4-8b64-6050-6a4e-e06cfaf113cc@xs4all.nl>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 07/05/2018 05:08 PM, Hans Verkuil wrote:
> On 05/07/18 16:07, Tomasz Figa wrote:
>> Hi Stanimir,
>>
>> On Thu, Jul 5, 2018 at 10:05 PM Stanimir Varbanov
>> <stanimir.varbanov@linaro.org> wrote:
>>>
>>> Hi,
>>>
>>> Changes since v4:
>>>  * 02/27 re-write intbufs_alloc as suggested by Alex, and
>>>    moved new structures in 03/27 where they are used
>>>  * 11/27 exit early if error occur in vdec_runtime_suspend
>>>    venc_runtime_suspend and avoid ORing ret variable
>>>  * 12/27 fixed typo in patch description
>>>  * added a const when declare ptype variable
>>>
>>> Previous v4 can be found at https://lkml.org/lkml/2018/6/27/404
>>
>> Thanks for the patches!
>>
>> Reviewed-by: Tomasz Figa <tfiga@chromium.org>

Thanks Tomasz!

> 
> Are we waiting for anything else? Otherwise I plan to make a pull request for
> this tomorrow.

I think we are done.

-- 
regards,
Stan
