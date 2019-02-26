Return-Path: <SRS0=tlbf=RB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A10EFC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 15:08:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5CB1D217F9
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 15:08:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eMwVlefw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727513AbfBZPIX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Feb 2019 10:08:23 -0500
Received: from mail-lf1-f67.google.com ([209.85.167.67]:42044 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726245AbfBZPIW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Feb 2019 10:08:22 -0500
Received: by mail-lf1-f67.google.com with SMTP id p1so9851712lfk.9;
        Tue, 26 Feb 2019 07:08:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=+pcEeHrwtCiGe6gdPiA4q+CjVNxwZUhNttoPC2wu/cc=;
        b=eMwVlefwTSC9cC5ifsVmqjcKxkAGwFUUMkZH8A3g33PmGjAqRZm3AlBCP3NSE0vfJg
         6mhKJsrCCK+v2MDkSE46/WGD9M0vmI8sOJ/gUFc2grNw2QJgGq07xiSMfFSKVQbJvMya
         3OG4heXcgWnTRdgMpdWIEE7hH4+BLcuc/A/mMiNi8qRf03XP7mlZmmu07j08XA3UsRQ9
         GYpFZE8W3gEwhgA7A8XJsWvZKmzogvpZhRU3a1YMH+r72FqC4Thh0WOC+ipRM7RMpCB7
         m4ZyizT3UfosMjyPliL4CKN2SYqK0f3ExC5GDPZ5KQ+0Kmkuowu10G6EHTuz5S9YOaM8
         0JZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=+pcEeHrwtCiGe6gdPiA4q+CjVNxwZUhNttoPC2wu/cc=;
        b=jin7JBOB3Y834h2kcWLdztzrIF3HLJ0MvAbTFJAhP15/87u0pvlu/F1YvxrkUL6q5F
         X1M7A5A7j9TAJAWvBiMPCD6Hfsa0YDQafJCMVzOECQm0GmB/6gAYf+DYDG1SSR6Q6A4c
         9Ptg3EZZ1Rb/eF/7wiY3Pr/1Rosk7iNPJbK9Xg1rlr70vGTfFfN723g6d3cpn/UABNGT
         OhKOyW/+ze7VuwLlWa505txkZmr0cXO6JV9lNBmzdOv8LbanOID8iN19iW3sd0m5HfDq
         gjcnt8gmx4vtQ7xy0J6L7jHH6fuTumZU+WyTft4sQAW8Ocbeg4luEp/E7FpHVZ5C1fQC
         Y9Ew==
X-Gm-Message-State: AHQUAuZQIthFRNiMdTTPgXZWB91nQyl+nP2QrBfI+pCWkbEIvBevSnOv
        RpiX7fbaep8Jgkz6poKAI1pJFi6S
X-Google-Smtp-Source: AHgI3IbYApVYowWD6VHmTt2dZWxJgsNCE07VYct0mi4FJgviNeikLkUFoYXxsniUOEuNTMff8oQ7vw==
X-Received: by 2002:a19:1f52:: with SMTP id f79mr13491385lff.36.1551193699778;
        Tue, 26 Feb 2019 07:08:19 -0800 (PST)
Received: from [192.168.2.145] (ppp91-79-175-49.pppoe.mtu-net.ru. [91.79.175.49])
        by smtp.googlemail.com with ESMTPSA id t14sm275790lfk.83.2019.02.26.07.08.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 26 Feb 2019 07:08:19 -0800 (PST)
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
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <d5e80295-977e-79b0-4f27-2134c52a6e6e@gmail.com>
Date:   Tue, 26 Feb 2019 18:08:17 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <20190226145857.GB26080@kroah.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

26.02.2019 17:58, Greg Kroah-Hartman пишет:
> On Tue, Feb 26, 2019 at 05:33:05PM +0300, Dmitry Osipenko wrote:
>> 26.02.2019 13:56, Greg Kroah-Hartman пишет:
>>> On Mon, Feb 25, 2019 at 08:07:15AM +0300, Dmitry Osipenko wrote:
>>>> В Mon, 25 Feb 2019 02:27:19 +0000
>>>> Peter Chen <peter.chen@nxp.com> пишет:
>>>>
>>>>>  
>>>>>>
>>>>>> Fixes: dfebb5f43a78827a ("usb: chipidea: Add support for
>>>>>> Tegra20/30/114/124")  
>>>>>
>>>>> I suppose you need to apply at stable tree too, right?
>>>>>
>>>>
>>>> It is enough to have the "Fixes" tag to get patch backported into all
>>>> relevant kernel versions.
>>>
>>> No it is not.  My scripts do NOT trigger off of the fixes: tag, please
>>> read:
>>>     https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html
>>> for how to do this properly.
>>
>> Okay, my bad then. Maybe this is something that could warned by checkpatch.. adding Joe and Andy to the thread.
> 
> Why?  It's allowed to put fixes: tags for a patch that does not belong
> in a stable tree.  That happens all the time, and is encouraged.  Look
> at some of the stuff in linux-next now, we have Fixes: for commits that
> are still in linux-next as well, because we do not rebase our trees.
> When they all merge into Linus's tree, all is good.
> 
> So this is not something that checkpatch needs to do anything about.

At least that might help in cases like this if maintainer is also oblivious.

I guess it wouldn't hurt at all to add a "green" warning if there is a "Fixes" tag and no "stable", something like this:

WARNING: There is a "Fixes" tag and no "Cc: stable <stable@vger.kernel.org>", please add the stable tag if patch is intended to be backported to stable kernels.
