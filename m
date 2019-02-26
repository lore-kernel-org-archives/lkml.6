Return-Path: <SRS0=tlbf=RB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9763C4360F
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 15:40:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 76ECB2173C
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 15:40:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pEnYwgfV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728153AbfBZPkv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Feb 2019 10:40:51 -0500
Received: from mail-lf1-f67.google.com ([209.85.167.67]:43608 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726507AbfBZPku (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Feb 2019 10:40:50 -0500
Received: by mail-lf1-f67.google.com with SMTP id j1so9938673lfb.10;
        Tue, 26 Feb 2019 07:40:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=R2CXcB9EqW2zho5Ji02Vx2BL+7xB8ASw/pY867WM5fc=;
        b=pEnYwgfV64Ma62ddPihXUnLfU9WIblWLwyww8oCmqOv1T9HxOKabhQ6Yj7oRcPdHqx
         y+ClCgljVB2aQXvClluZN0xMAgPgwA1flvO/blS3P+7Yh4GZVZNC9GWrdonb5qnxziCh
         pJ69tb9MFCYaZw0kCqvZvQmEooxmtNEFgMLvxdSmCgLWEaWlIa1ylwjDHSjxshRtKpgv
         qTV9coIVhuU9BUpfaddTZVVDKnJQqVydNGzhJjmpA2uRc2/ox2/+nYh9i+8oruiKMy7u
         +zbTUlVFvsoTkjJPNcfJBjntpSfxALSCKVkrpLB0H6nlS4Fj5ApNnfAmJEK4KDFQUDgS
         fSaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=R2CXcB9EqW2zho5Ji02Vx2BL+7xB8ASw/pY867WM5fc=;
        b=Scb/n/j/vuJJRfEnFQmgNsdh8WuvtbevfqPmmovJru3ovOAM4ZDmA+LauYboHTvAbO
         LBY6UbQygpPI7ukXwxyNC0yckakkCU/vCP6O09HESsWIRH0Foh2dHIhon/X0UCgmwDWl
         /39sj+AbQsZcyjKDqglaGApi0YOQ31kKdWlW6pc7IlPBbqkjwj+d/HoyzLX6gBAHD2uK
         CxmdNiuU9CkDmZrnAl86VqfSr4prHrCjN73xgmtoEwVbGCYXlNqLQAxan7OHbR65U+dV
         qtDDb2koq2xPEv2rKBt9hIQFKEwhmTmkuwD10t4j3nTgH0JNlaArgHU2M77Fd5nBlKzw
         SjOA==
X-Gm-Message-State: AHQUAubKorXZzz+VCZ838vRj4N8rZJr9y222AQHOtkRadSfcOOtX+ycf
        u9pZWLoqMrhihI/XK1ZUL498j+M3
X-Google-Smtp-Source: AHgI3IakBT/sZ+/WSGdvAb8XXln1dh5+KJmWts7IwLBFyZOc8Hq8NhUBKIWvP4eX2jQn0AMxSUoWNQ==
X-Received: by 2002:a19:384c:: with SMTP id d12mr13562901lfj.105.1551195646952;
        Tue, 26 Feb 2019 07:40:46 -0800 (PST)
Received: from [192.168.2.145] (ppp91-79-175-49.pppoe.mtu-net.ru. [91.79.175.49])
        by smtp.googlemail.com with ESMTPSA id 5sm2899641ljf.86.2019.02.26.07.40.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 26 Feb 2019 07:40:46 -0800 (PST)
Subject: Re: [PATCH v1] usb: chipidea: tegra: Fix missed
 ci_hdrc_remove_device()
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Joe Perches <joe@perches.com>, Andy Whitcroft <apw@canonical.com>,
        Peter Chen <peter.chen@nxp.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20190224153622.8877-1-digetx@gmail.com>
 <VI1PR04MB5327FE97DC8C68B4D56DE0A98B7A0@VI1PR04MB5327.eurprd04.prod.outlook.com>
 <20190225080715.4965810a@dimatab> <20190226105615.GA12397@kroah.com>
 <e7693387-9ac5-b2d8-0a0f-d507dfe05830@gmail.com>
 <20190226145857.GB26080@kroah.com>
 <d5e80295-977e-79b0-4f27-2134c52a6e6e@gmail.com>
 <20190226152144.GA17948@kroah.com>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <ed54d07e-0fc5-4e7c-448f-a4b59ad43873@gmail.com>
Date:   Tue, 26 Feb 2019 18:40:45 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <20190226152144.GA17948@kroah.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

26.02.2019 18:21, Greg Kroah-Hartman пишет:
> On Tue, Feb 26, 2019 at 06:08:17PM +0300, Dmitry Osipenko wrote:
>> 26.02.2019 17:58, Greg Kroah-Hartman пишет:
>>> On Tue, Feb 26, 2019 at 05:33:05PM +0300, Dmitry Osipenko wrote:
>>>> 26.02.2019 13:56, Greg Kroah-Hartman пишет:
>>>>> On Mon, Feb 25, 2019 at 08:07:15AM +0300, Dmitry Osipenko wrote:
>>>>>> В Mon, 25 Feb 2019 02:27:19 +0000
>>>>>> Peter Chen <peter.chen@nxp.com> пишет:
>>>>>>
>>>>>>>  
>>>>>>>>
>>>>>>>> Fixes: dfebb5f43a78827a ("usb: chipidea: Add support for
>>>>>>>> Tegra20/30/114/124")  
>>>>>>>
>>>>>>> I suppose you need to apply at stable tree too, right?
>>>>>>>
>>>>>>
>>>>>> It is enough to have the "Fixes" tag to get patch backported into all
>>>>>> relevant kernel versions.
>>>>>
>>>>> No it is not.  My scripts do NOT trigger off of the fixes: tag, please
>>>>> read:
>>>>>     https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html
>>>>> for how to do this properly.
>>>>
>>>> Okay, my bad then. Maybe this is something that could warned by checkpatch.. adding Joe and Andy to the thread.
>>>
>>> Why?  It's allowed to put fixes: tags for a patch that does not belong
>>> in a stable tree.  That happens all the time, and is encouraged.  Look
>>> at some of the stuff in linux-next now, we have Fixes: for commits that
>>> are still in linux-next as well, because we do not rebase our trees.
>>> When they all merge into Linus's tree, all is good.
>>>
>>> So this is not something that checkpatch needs to do anything about.
>>
>> At least that might help in cases like this if maintainer is also oblivious.
> 
> If the maintainer is "oblivious", they are not going to be running
> checkpatch :)
> 
> Remember, the "Fixes:" tag is a relatively new thing compared to the cc:
> stable tag, which has been a documented requirement for over a decade.
> Yes, some subsystems do not even do cc: stable, but that is because
> those subsystem maintainers do not want to do it, or do not care.
> Again, checkpatch is not going to help them.
> 
> checkpatch is not a panacea, people still have to use their brains.

My point that either submitter or maintainers may catch up the problem if at least there are means to report the problem. So I'm still thinking it's not a bad idea to add the warning message, maybe even for the "checkpatch --strict" option only. I'm not insisting that it is something super-necessary and it's up to you guys to decide in the end.  
