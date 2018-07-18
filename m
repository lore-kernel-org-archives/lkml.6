Return-Path: <SRS0=35zj=KC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4CE4ECDFB8
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 17:40:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 761FF20854
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 17:40:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=micronovasrl.com header.i=@micronovasrl.com header.b="CA5NrO6l"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 761FF20854
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=micronovasrl.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731565AbeGRSTK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Jul 2018 14:19:10 -0400
Received: from mail.micronovasrl.com ([212.103.203.10]:49522 "EHLO
        mail.micronovasrl.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731221AbeGRSTJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jul 2018 14:19:09 -0400
Received: from mail.micronovasrl.com (mail.micronovasrl.com [127.0.0.1])
        by mail.micronovasrl.com (Postfix) with ESMTP id 895DEB00779
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jul 2018 19:40:11 +0200 (CEST)
Authentication-Results: mail.micronovasrl.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)" header.d=micronovasrl.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=micronovasrl.com;
         h=content-transfer-encoding:content-language:content-type
        :content-type:in-reply-to:mime-version:user-agent:date:date
        :message-id:from:from:references:to:subject:subject; s=dkim; t=
        1531935609; x=1532799610; bh=KwyYDZr44adwRiv3y37Tq+Chv1faQwsOYBg
        6X7aHRNo=; b=CA5NrO6lj25n3G6VPDbg8IieW8pNFQofzTlytOLpCBpqstn9wkK
        0KY0rcj39iusfkrsocaoxX4DHWj4h+zomXtq4YUxVcRBYa4jxUq2BMhY/LGEVPKJ
        5mzYTQbRZ0uBI0VB9WVvr9HRDgmZFz2di/QBrbcXqvf60cojDpngEjs8=
X-Virus-Scanned: Debian amavisd-new at mail.micronovasrl.com
Received: from mail.micronovasrl.com ([127.0.0.1])
        by mail.micronovasrl.com (mail.micronovasrl.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id YKm_jHAGUIW0 for <linux-kernel@vger.kernel.org>;
        Wed, 18 Jul 2018 19:40:09 +0200 (CEST)
Received: from [192.168.2.133] (62-11-51-166.dialup.tiscali.it [62.11.51.166])
        by mail.micronovasrl.com (Postfix) with ESMTPSA id 00E3BB002CD;
        Wed, 18 Jul 2018 19:40:08 +0200 (CEST)
Subject: Re: [PATCH v10 4/4] rtc: ds1307: add frequency_test_enable sysfs
 attribute to check tick on m41txx
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Alessandro Zummo <a.zummo@towertech.it>,
        "open list:REAL TIME CLOCK (RTC) SUBSYSTEM" 
        <linux-rtc@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
References: <CAHp75VcaALb8fYJExnZ=Ye=GcNHc3aPXgFihVK+rAu_a1A01Sg@mail.gmail.com>
 <20180718140946.115093-1-giulio.benetti@micronovasrl.com>
 <20180718140946.115093-3-giulio.benetti@micronovasrl.com>
 <CAHp75VeR8H-XhqkrSxBKoaVwcTx6__w4xpR0x2tm-0dxq9tZrw@mail.gmail.com>
From:   Giulio Benetti <giulio.benetti@micronovasrl.com>
Message-ID: <2a249756-3b3b-2a3e-f293-3a13d586e9ad@micronovasrl.com>
Date:   Wed, 18 Jul 2018 19:40:07 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <CAHp75VeR8H-XhqkrSxBKoaVwcTx6__w4xpR0x2tm-0dxq9tZrw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: it
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 18/07/2018 18:26, Andy Shevchenko ha scritto:
> On Wed, Jul 18, 2018 at 5:09 PM, Giulio Benetti
> <giulio.benetti@micronovasrl.com> wrote:
>> On m41txx you can enable open-drain OUT pin to check if offset is ok.
>> Enabling OUT pin with frequency_test_enable attribute, OUT pin will tick
>> 512 times faster than 1s tick base.
>>
>> Enable or Disable FT bit on CONTROL register if freq_test is 1 or 0.
> 
> Taking into consideration the amount of patches per hour you need to
> slow down a bit.
> 

You're right, I'm really sorry about it.

Giulio
