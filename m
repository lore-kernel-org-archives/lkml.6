Return-Path: <SRS0=fL2C=MA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97F3CECE564
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 14:00:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 33441214C2
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 14:00:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NJT4delx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 33441214C2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729895AbeIRTcw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Sep 2018 15:32:52 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:42118 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728413AbeIRTcw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Sep 2018 15:32:52 -0400
Received: by mail-pg1-f196.google.com with SMTP id y4-v6so1085002pgp.9;
        Tue, 18 Sep 2018 07:00:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=WbkVvN1LUhXv3Q/jYb2aSay7vyKLJgWMT/iH+XRMaRM=;
        b=NJT4delx/78Rj6d+etPWbuScxEwTkBg3jD8mswPDsyrXjtNjqDN5mSE4lvZq+IMlVf
         ZB1OeY/AP2xn+sw1dHrpvXg333DERm2K/DyJy3Jl34uBhHtfCRc8YivmAIFzUC3x1qCS
         Y7XTqRMli0EsTwX/TPHsoGeXmppHEtM9iJIRn7+VCs8ZOWexTpf6hVx8NJ22ksGFWnng
         dS8YWoeWNs/LhL6HVlsTcEeUSqXjxkbssq5y866yR6pH4/gAChwXbpVB/llAt1n+fynQ
         O0TLPchahRq2Sq4IBtXJoAnk23N82bECHMvzd4koYIsTi87xic6KmgCOliRGDRKncqMT
         ik1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=WbkVvN1LUhXv3Q/jYb2aSay7vyKLJgWMT/iH+XRMaRM=;
        b=srwf/7iRBR5KhBT/kysAIJ9QvjpfVkZoMv7z77ypWldk7zmJiGDxxL7rNrFjyemXqU
         z5M31A7vOFFcVitKWiAT19oAZXjI1q4dxtWBpIq4HkZTyroWGnlDRxfpxt7+DkQeTtTQ
         UM3KPPMiPTDr+EjiY0SZOBmpQ1ni6x1jDQdWcXJcvOvClEGIDDqPC2ymhomy13oSmVWk
         J5zG0+3Jf6wSr4syNBXm8wQnJ+Ye+Mqbfr8rbJ5IqMYP6jI8rO2v7zlq4B0eyk7zH0Rp
         tn7O3mAAeouETJX0W5vrL3JT1T3WUlXnAPp+2qg2mNTCALG2gs/I8W79Oi5maurhJUf4
         LzLg==
X-Gm-Message-State: APzg51CU7SpDYub6IRVlxgVsJ66DO60QC503xbIDJyXW7x0oPdkdu5Zv
        /rh5OG4zqlaattNaQ8o4bkEcqBxn
X-Google-Smtp-Source: ANB0VdYFYVAUZNCqk2/AUU5PMrC3f62+XdqUe90VqrFtIShlWp5zlKbfJ4iqKDvuAgK7WtCK2BfvKA==
X-Received: by 2002:a63:1c1b:: with SMTP id c27-v6mr28878228pgc.48.1537279206999;
        Tue, 18 Sep 2018 07:00:06 -0700 (PDT)
Received: from [192.168.86.235] (c-67-180-167-114.hsd1.ca.comcast.net. [67.180.167.114])
        by smtp.gmail.com with ESMTPSA id r19-v6sm35196143pgg.39.2018.09.18.07.00.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 18 Sep 2018 07:00:06 -0700 (PDT)
Subject: Re: [PATCH] bonding: avoid repeated display of same link status
 change
To:     Manish Kumar Singh <mk.singh@oracle.com>,
        Eric Dumazet <eric.dumazet@gmail.com>, netdev@vger.kernel.org
Cc:     Jay Vosburgh <j.vosburgh@gmail.com>,
        Veaceslav Falico <vfalico@gmail.com>,
        Andy Gospodarek <andy@greyhouse.net>,
        "David S. Miller" <davem@davemloft.net>,
        linux-kernel@vger.kernel.org
References: <20180917072059.32657-1-mk.singh@oracle.com>
 <33a66a80-22ed-d6b3-f6b2-4463357c5ffa@gmail.com>
 <78bf3185-fbd1-4a6c-ae32-70da0af2cbb4@default>
From:   Eric Dumazet <eric.dumazet@gmail.com>
Message-ID: <05f57c08-3ebb-7ee5-7ab2-519cb5a70bd8@gmail.com>
Date:   Tue, 18 Sep 2018 07:00:05 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <78bf3185-fbd1-4a6c-ae32-70da0af2cbb4@default>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 09/17/2018 10:05 PM, Manish Kumar Singh wrote:
> 
> 
>> -----Original Message-----
>> From: Eric Dumazet [mailto:eric.dumazet@gmail.com]
>> Sent: 17 सितम्बर 2018 20:08
>> To: Manish Kumar Singh; netdev@vger.kernel.org
>> Cc: Jay Vosburgh; Veaceslav Falico; Andy Gospodarek; David S. Miller; linux-
>> kernel@vger.kernel.org
>> Subject: Re: [PATCH] bonding: avoid repeated display of same link status
>> change
>>
>>
>>
>> On 09/17/2018 12:20 AM, mk.singh@oracle.com wrote:
>>> From: Manish Kumar Singh <mk.singh@oracle.com>
>>>
>>> When link status change needs to be committed and rtnl lock couldn't be
>>> taken, avoid redisplay of same link status change message.
>>>
>>> Signed-off-by: Manish Kumar Singh <mk.singh@oracle.com>
>>> ---
>>>  drivers/net/bonding/bond_main.c | 6 ++++--
>>>  include/net/bonding.h           | 1 +
>>>  2 files changed, 5 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/drivers/net/bonding/bond_main.c
>> b/drivers/net/bonding/bond_main.c
>>> index 217b790d22ed..fb4e3aff1677 100644
>>> --- a/drivers/net/bonding/bond_main.c
>>> +++ b/drivers/net/bonding/bond_main.c
>>> @@ -2087,7 +2087,7 @@ static int bond_miimon_inspect(struct bonding
>> *bond)
>>>  			bond_propose_link_state(slave, BOND_LINK_FAIL);
>>>  			commit++;
>>>  			slave->delay = bond->params.downdelay;
>>> -			if (slave->delay) {
>>> +			if (slave->delay && !bond->rtnl_needed) {
>>>  				netdev_info(bond->dev, "link status down for
>> %sinterface %s, disabling it in %d ms\n",
>>>  					    (BOND_MODE(bond) ==
>>>  					     BOND_MODE_ACTIVEBACKUP) ?
>>> @@ -2127,7 +2127,7 @@ static int bond_miimon_inspect(struct bonding
>> *bond)
>>>  			commit++;
>>>  			slave->delay = bond->params.updelay;
>>>
>>> -			if (slave->delay) {
>>> +			if (slave->delay && !bond->rtnl_needed) {
>>>  				netdev_info(bond->dev, "link status up for
>> interface %s, enabling it in %d ms\n",
>>>  					    slave->dev->name,
>>>  					    ignore_updelay ? 0 :
>>> @@ -2301,9 +2301,11 @@ static void bond_mii_monitor(struct
>> work_struct *work)
>>>  		if (!rtnl_trylock()) {
>>>  			delay = 1;
>>>  			should_notify_peers = false;
>>> +			bond->rtnl_needed = true;
>>
>> How can you set a shared variable with no synchronization ?
> Thanks Eric for reviewing the patch. rtnl_needed is not a shared variable, it is part of bonding structure, that is one per bonding driver instance. There can't be two parallel instances of bond_miimon_inspect for a single  bonding driver instance at any given point of time. and only bond_miimon_inspect updates it. That’s why I think there is no need of any synchronization here.  
> 
>

If rtnl_trylock() can not grab RTNL, 
there is no way the current thread can set the  variable without a race, if the word including rtnl_needed is shared by other fields in the structure.

Your patch adds a subtle possibility of future bugs, even if it runs fine today.

Do not pave the way for future bugs, make your code robust, please.







