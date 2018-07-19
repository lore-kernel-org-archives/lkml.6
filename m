Return-Path: <SRS0=/F/O=KD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7F17ECDE5F
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 18:19:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5C997206B7
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 18:19:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=micronovasrl.com header.i=@micronovasrl.com header.b="UmoYp9Wy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5C997206B7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=micronovasrl.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732133AbeGSTDm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Jul 2018 15:03:42 -0400
Received: from mail.micronovasrl.com ([212.103.203.10]:53984 "EHLO
        mail.micronovasrl.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732070AbeGSTDl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jul 2018 15:03:41 -0400
Received: from mail.micronovasrl.com (mail.micronovasrl.com [127.0.0.1])
        by mail.micronovasrl.com (Postfix) with ESMTP id F3E4DB008F4
        for <linux-kernel@vger.kernel.org>; Thu, 19 Jul 2018 20:19:19 +0200 (CEST)
Authentication-Results: mail.micronovasrl.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)" header.d=micronovasrl.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=micronovasrl.com;
         h=content-transfer-encoding:content-language:content-type
        :content-type:in-reply-to:mime-version:user-agent:date:date
        :message-id:from:from:references:to:subject:subject; s=dkim; t=
        1532024358; x=1532888359; bh=p+dJeNUxJt2No2LR/HYTlim5y79AS96f5fA
        ydHAUHPU=; b=UmoYp9WyL9Sc6/hN4P1ljwcTaSd/BBvW+W0ln0rRoSyvTNXxUuV
        UD8/PADd/ANZ96PO1GWKGy/deBzxZDrG0/aeDooeWO12mOOPjl+c6maMpf8BPXeZ
        n6IHsovic1/21+rYThgQB3RzQaNNnab5RCzt9NuNI+WuJPUcF54eNFKY=
X-Virus-Scanned: Debian amavisd-new at mail.micronovasrl.com
Received: from mail.micronovasrl.com ([127.0.0.1])
        by mail.micronovasrl.com (mail.micronovasrl.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id dlnV-Bjkpe69 for <linux-kernel@vger.kernel.org>;
        Thu, 19 Jul 2018 20:19:18 +0200 (CEST)
Received: from [192.168.2.133] (62-11-51-166.dialup.tiscali.it [62.11.51.166])
        by mail.micronovasrl.com (Postfix) with ESMTPSA id B70A2B00245;
        Thu, 19 Jul 2018 20:19:17 +0200 (CEST)
Subject: Re: [PATCH v9 4/4] rtc: ds1307: add frequency_test_enable sysfs
 attribute to check tick on m41txx
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Alessandro Zummo <a.zummo@towertech.it>,
        "open list:REAL TIME CLOCK (RTC) SUBSYSTEM" 
        <linux-rtc@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
References: <20180718094006.105675-1-giulio.benetti@micronovasrl.com>
 <20180718094006.105675-3-giulio.benetti@micronovasrl.com>
 <CAHp75VcaALb8fYJExnZ=Ye=GcNHc3aPXgFihVK+rAu_a1A01Sg@mail.gmail.com>
 <30d6b568-b785-ae93-9f56-d0a8b7e82901@micronovasrl.com>
 <CAHp75VchXfm6J+PPcB8ekoXcDktsPUNok3KKBMFyyk9XV=AUyQ@mail.gmail.com>
From:   Giulio Benetti <giulio.benetti@micronovasrl.com>
Message-ID: <d03aec28-a33a-5a07-4305-246508185b2b@micronovasrl.com>
Date:   Thu, 19 Jul 2018 20:19:17 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <CAHp75VchXfm6J+PPcB8ekoXcDktsPUNok3KKBMFyyk9XV=AUyQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: it
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andy,

Il 18/07/2018 18:26, Andy Shevchenko ha scritto:
> On Wed, Jul 18, 2018 at 5:06 PM, Giulio Benetti
> <giulio.benetti@micronovasrl.com> wrote:
> 
>>>> +       int ret;
>>>> +
>>>> +       ret = kstrtobool(buf, &freq_test_en);
>>>> +       if (ret == -EINVAL) {
> 
>>> What kind of other error code you may expect and why they are not
>>> considered as no error?
> 
>> According to documentation, kstrtobool can only fail with -EINVAL.
>> See:
>> https://elixir.bootlin.com/linux/v4.18-rc5/source/lib/kstrtox.c#L332
> 
> That's correct. So, what do you want to show by explicitly mentioned
> an error code in the condition?
> 

So you mean I should check for negative values instead of specific 
error, right?

Thanks

Giulio
