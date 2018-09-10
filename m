Return-Path: <SRS0=FvrY=LY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D523C4321E
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 17:03:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BAA7C2087F
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 17:03:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=lechnology.com header.i=@lechnology.com header.b="J+8HJ+Qn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BAA7C2087F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lechnology.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728906AbeIJV60 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Sep 2018 17:58:26 -0400
Received: from vern.gendns.com ([206.190.152.46]:60859 "EHLO vern.gendns.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726603AbeIJV6Z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Sep 2018 17:58:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=lechnology.com; s=default; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=KSFBg+0bAVX9vbPXlRh0pJaFGq8a89ebTnq4iCpn8CY=; b=J+8HJ+QnMqYOoveLK9wUiBwjKZ
        8qLVM29IbgU1b15CS9hYiqFJ3Wpj856pXZ50NIvUph8M5rst33837N5DZWV+jBedgGHXV7Z2An16W
        8dTPdjEs2T5e5liaasmrXJvrrhbwY6Zk7kYQimbcty9ekjF+8RAUd15dG4FKrPJXvCWroPVWDd615
        h19D7p1xoic6jNG/kfzNkLQXq1ZNF0/z/6jmR+cwg9PBNJZBfzV7r2GK7heAwRsKKJNN4L1v7NCOj
        2zoar7SbLFTAjO/JPUf5Ci/k9nS8eMmFPTYu6JhWq355QDpUj42JZL1125e24aJlJgzdsrTYb0EyI
        6+iw8ncQ==;
Received: from 108-198-5-147.lightspeed.okcbok.sbcglobal.net ([108.198.5.147]:59438 helo=[192.168.0.134])
        by vern.gendns.com with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.91)
        (envelope-from <david@lechnology.com>)
        id 1fzPar-004Hng-Kt; Mon, 10 Sep 2018 13:03:21 -0400
Subject: Re: [PATCH 2/5] gpio: davinci: Use dev name for label and automatic
 base selection
To:     Sekhar Nori <nsekhar@ti.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Grygorii Strashko <grygorii.strashko@ti.com>
Cc:     Keerthy <j-keerthy@ti.com>, "Andrew F. Davis" <afd@ti.com>,
        Kevin Hilman <khilman@kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Adam Ford <aford173@gmail.com>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
References: <20180831191326.25106-1-afd@ti.com>
 <20180831191326.25106-2-afd@ti.com>
 <2a02c241-ac91-1bac-380d-122858bb03c3@ti.com>
 <CACRpkdYvNeKyfRf5Et5zC4=hcu9cfDubftRFRHtrKLN-5Snd1Q@mail.gmail.com>
 <040ce524-f6e2-81a2-68db-57a645de22ea@ti.com>
 <0e199aa3-2d9d-4e7d-af23-8523722f017a@ti.com>
 <CACRpkdYcuSpfZ0=UFUOx_-5kaAtCA4=AyXmSMbfrcqjf0r_xmQ@mail.gmail.com>
 <b1f74d63-c9e8-2a7f-bd13-8f5fff27fc22@ti.com>
From:   David Lechner <david@lechnology.com>
Message-ID: <caa67be6-a7be-4448-2a4a-7ad623176d26@lechnology.com>
Date:   Mon, 10 Sep 2018 12:03:21 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <b1f74d63-c9e8-2a7f-bd13-8f5fff27fc22@ti.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - vern.gendns.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - lechnology.com
X-Get-Message-Sender-Via: vern.gendns.com: authenticated_id: davidmain+lechnology.com/only user confirmed/virtual account not confirmed
X-Authenticated-Sender: vern.gendns.com: davidmain@lechnology.com
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/10/2018 02:37 AM, Sekhar Nori wrote:
> On Monday 10 September 2018 12:55 PM, Linus Walleij wrote:
>> On Sat, Sep 8, 2018 at 9:41 PM Grygorii Strashko
>> <grygorii.strashko@ti.com> wrote:
>>> On 09/06/2018 09:16 AM, Keerthy wrote:
>>
>>>> Okay now its numbered differently:
>>>>
>>>> cat /sys/class/gpio/gpiochip340/ngpio
>>>> 144
>>>>
>>>> cat /sys/class/gpio/gpiochip272/ngpio
>>>> 68
>> (...)
>>
>> So:
>>
>>>>> Are there applications that rely on the sysfs ABI on DaVinci?
>>>>>
>>>>> In that case base needs to be prerseved.
>>>
>>> Not only base, but label also - /sys/class/gpio/gpiochip0/label, as this is
>>> the way to find proper GPIO chip in sysfs using legacy GPIO ABI.
>>>
>>> Linus, this platform is old and most of the users do not use new ABI (chardev),
>>> so we could try change this, but need to be prepared for regressions reports.
>>
>> So what I'm trying to ask you guys is if there are applications that you
>> are aware of that use the old ABI, and who will upgrade their
>> kernels and be upset.
>>
>> We must not break userspace, but as you know if a tree falls in the
>> forest and nobody is there to hear it, it doesn't make a sound.
>>
>> If you're not aware of any such applications I guess we should try
>> changing this.
> 
> Personally I am not really aware of any application which relies on the
> ABI. I may have some scripts, but I can adjust them. I am also copying
> some frequent users of DaVinci in mainline for any comments from them.
> 
> Thanks,
> Sekhar
> 

It won't break anything that I am aware of.
