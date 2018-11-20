Return-Path: <SRS0=i6x1=N7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A329C04EBC
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 13:35:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B03D92087E
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 13:35:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RViZxl7Q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B03D92087E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726611AbeKUAEo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Nov 2018 19:04:44 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:38785 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725995AbeKUAEo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Nov 2018 19:04:44 -0500
Received: by mail-wm1-f66.google.com with SMTP id k198so2273046wmd.3;
        Tue, 20 Nov 2018 05:35:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=eG+UIlp2B6FrYwPrA4iw0S0K/xFSflGKxZ5DRSlwwdA=;
        b=RViZxl7QrFnITKIlHX2aqkz70BAlN1A+H2WHfaX2rc8cti19QVuu8Sr855NYZmNRL9
         jhmiFsfyGbMqMI5ymOcA8+4sdoWQhZd6vGLnDCkjhhdpThBACnYRCay1+trYfKQRDVPw
         9WPzbcIuIAUYb8w87N4N1bbCV5C8WHs2urb7A84eCe/xr59Igyk8JlAXgVsVYsuw1h+s
         wneJQSaglB3KTyIAiRvshaYvobTH61kT1bkSyrMtOPHdEo5YXe3alIZHDrC/H5DV7KO6
         KEvaGcoqjeaCzI5GKWs9WA/5TF5gFf76w4KVvGyofOWwpV8GDJHMjnj/hHkMxUciSDl/
         fZEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=eG+UIlp2B6FrYwPrA4iw0S0K/xFSflGKxZ5DRSlwwdA=;
        b=EEzkR1cFzVuIpdGqtBPWArfXXSKRUP/4I7Q+4WpQNMBRyoyGmpwl9EMdAzSrLIuqAo
         J5ca6fePmK2mgkjEhE/uykJ9DVDRrLjDmnCQ/HKMug4jn6jgYQgAJvC2V+5Ow635jSs6
         ZkAyPZtus262bDU1tAGuXpMyuCCdoWvohtTe/pIDbgViZRonCHeOLFbQK6+5BnscMHu3
         DXiZGC0Ui+AdvUFwuRUQszpoB3DeQBZf0xtLcrhgHQD8W8n2QcgRQ/DvEyexNxpDeSmr
         2bFJ7yVXDB06wkHaRoSkiMCPgpWjhB9RAULARwz7DR0fyF9yMlRooo32ZMWaJMLsiM75
         tJ1A==
X-Gm-Message-State: AGRZ1gJ6Z11qAiZ7iryo+Ls8NS/5YMUJ1koTKc2cfx52hUmFaDi6dFEk
        6BGkkSg1mIEpGq4Gnwt16LI=
X-Google-Smtp-Source: AJdET5flt2T19dVF5K3S/VSvxpVVB1xldkIB906Z59FrjbU5iEMwFf7MSxJV0xAK9BFBNfo9tdYSKw==
X-Received: by 2002:a1c:ce0e:: with SMTP id e14mr2323550wmg.53.1542720931767;
        Tue, 20 Nov 2018 05:35:31 -0800 (PST)
Received: from [192.168.1.4] (ip-86-49-110-70.net.upcbroadband.cz. [86.49.110.70])
        by smtp.gmail.com with ESMTPSA id 197-v6sm32710029wmh.44.2018.11.20.05.35.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 20 Nov 2018 05:35:31 -0800 (PST)
Subject: Re: [PATCH 1/2] spi: Add Renesas R-Car RPC SPI controller driver
To:     Boris Brezillon <boris.brezillon@bootlin.com>
Cc:     masonccyang@mxic.com.tw, broonie@kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Simon Horman <horms@verge.net.au>, juliensu@mxic.com.tw,
        linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        linux-spi@vger.kernel.org, tpiepho@impinj.com,
        zhengxunli@mxic.com.tw
References: <1542621690-10229-1-git-send-email-masonccyang@mxic.com.tw>
 <1542621690-10229-2-git-send-email-masonccyang@mxic.com.tw>
 <0223f43b-c6a6-eade-49af-4e7b7ef7f022@gmail.com>
 <OF4FAD10C5.F4F6D29B-ON4825834B.001FAB40-4825834B.00289635@mxic.com.tw>
 <6b024f18-d0bc-3e65-f07c-cef913f795ab@gmail.com>
 <20181120143209.49217efb@bbrezillon>
From:   Marek Vasut <marek.vasut@gmail.com>
Message-ID: <31c9518a-2088-7c3f-aec0-9e1b69b30745@gmail.com>
Date:   Tue, 20 Nov 2018 14:35:30 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20181120143209.49217efb@bbrezillon>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/20/2018 02:32 PM, Boris Brezillon wrote:
> On Tue, 20 Nov 2018 14:09:05 +0100
> Marek Vasut <marek.vasut@gmail.com> wrote:
> 
>> On 11/20/2018 08:23 AM, masonccyang@mxic.com.tw wrote:
>>> Hi Marek,  
>>
>> Hi,
>>
>>>> Marek Vasut <marek.vasut@gmail.com>
>>>> 2018/11/19 下午 10:12
>>>>
>>>> To
>>>>  
>>>>> +
>>>>> +static int rpc_spi_set_freq(struct rpc_spi *rpc, unsigned long freq)
>>>>> +{
>>>>> +   int ret;
>>>>> +
>>>>> +   if (rpc->cur_speed_hz == freq)
>>>>> +      return 0;
>>>>> +
>>>>> +   clk_disable_unprepare(rpc->clk_rpc);
>>>>> +   ret = clk_set_rate(rpc->clk_rpc, freq);
>>>>> +   if (ret)
>>>>> +      return ret;
>>>>> +
>>>>> +   ret = clk_prepare_enable(rpc->clk_rpc);
>>>>> +   if (ret)
>>>>> +      return ret;  
>>>>
>>>> Is this clock disable/update/enable really needed ? I'd think that
>>>> clk_set_rate() would handle the rate update correctly.  
>>>
>>> This is for run time PM mechanism in spi-mem layer and __spi_sync(),
>>> you may refer to another patch [1].
>>>
>>> [1]
>>> https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git/commit/?h=for-4.21&id=b942d80b0a394e8ea18fce3b032b4700439e8ca3  
>>
>> I think Geert commented on the clock topic, so let's move it there.
>> Disabling and enabling clock to change their rate looks real odd to me.
> 
> Look at the CLK_SET_RATE_GATE definition and its users and you'll see
> it's not unusual to have such constraints on clks. Maybe your HW does
> not have such constraints, but it's not particularly odd to do that
> (though it could probably be automated by the clk framework somehow).

I think you stated my concern right at the end, good, no need for me to
add to this. Yes, I don't think any random driver should deal with
peculiarities of the clock controller.

-- 
Best regards,
Marek Vasut
