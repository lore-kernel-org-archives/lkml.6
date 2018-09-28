Return-Path: <SRS0=0/YT=MK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67153C43143
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 22:01:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 28FB02073F
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 22:01:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="iDsLT83w"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 28FB02073F
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727315AbeI2E0s (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 29 Sep 2018 00:26:48 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:35367 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726554AbeI2E0r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Sep 2018 00:26:47 -0400
Received: by mail-wr1-f65.google.com with SMTP id o16so7842837wrx.2
        for <linux-kernel@vger.kernel.org>; Fri, 28 Sep 2018 15:01:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Jxs9d/gXaBBCFMd6LxJIZFCIksdkXIXa2sCozMKKNu8=;
        b=iDsLT83wYL5PKG+mHZZ8UtANwYR8wfdzDj3Qa580OJ8aQQF1fIU4OnUCQElZLQ2ixa
         a2iv6QmkYI9e7Ir884u5tcnkanuHFbS73oBlRuwHYFJ5gmdrk8PTE2S411BLGp1C/fzg
         LTRoaNZRCgGJWcIxuOXs4+OSurQOH6nukHVH7s6ZQ6yTJ0xz4REgUXGci5hJvHnS6+n8
         2EEyerJAFe1f9Q//uwb09UeNakbcTDuJlH5btiwtksczGS2pPgPvzX6be9Yq2uS6R6WG
         KVHApRfEuRRyhJm16AZ/v4KaEkxUiU5FO01Vc5iuGpGoa0FAfwA0ObBojiuYTLfPDsZi
         mh5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Jxs9d/gXaBBCFMd6LxJIZFCIksdkXIXa2sCozMKKNu8=;
        b=kXfFUo58eN58brfSztcEId6M8UIVRk+gsBMCi3Qaj4xfhZHGVFLNbjmmgcsZnmV8Jn
         Bm1hn72XWBwpR+PyTfEdyxzrpgYDXCFPVGNNTUIrjDuVvjFVlrW/G6OEAC2nw6tudhPF
         5CwNUo1LhpnCV6nlV4gpJI7Qg8wHABg2hC7nr6yXRy23/CNFKRBYE8BZjBByxxwVObo2
         kEsFLEeT1hU8qFcl/itisifhBqK8y9KQRQ0eN3iay6mDWrrpHbR3wg4ZmoPiVYN4JIpM
         NJ6mPpsGooUuimeLbQ73FIFd8GqLYHagYq/pdgWoijyeVwMefyiGJ6W65rQgqMNSUg7Y
         pspA==
X-Gm-Message-State: ABuFfohXPZlwh4hN35Ic45AssXuEJBJ0uxBmxpV2EWOwF6JijY+qpyMR
        OBq5MEtRzNBi5atOtTkgjCqvGG3X
X-Google-Smtp-Source: ACcGV63AKAZyEvg6FZjug6LPr2vCjZtlbdV18YnV9/lJyGkrHhIqk0ndm3NTqN48k0vsZB9uaD+Pug==
X-Received: by 2002:adf:806d:: with SMTP id 100-v6mr322066wrk.23.1538172061526;
        Fri, 28 Sep 2018 15:01:01 -0700 (PDT)
Received: from [192.168.0.20] ([94.1.124.175])
        by smtp.googlemail.com with ESMTPSA id i4-v6sm12676453wrs.87.2018.09.28.15.01.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 28 Sep 2018 15:01:00 -0700 (PDT)
Subject: Re: R8169: Network lockups in 4.18.{8,9,10} (and 4.19 dev)
To:     "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Azat Khuzhin <a3at.mail@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Realtek linux nic maintainers <nic_swsd@realtek.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
References: <54d8d7e9-a80d-dc2b-5628-22f9dc14e2ee@maciej.szmigiero.name>
From:   Chris Clayton <chris2553@googlemail.com>
Message-ID: <535f42c7-6c3b-8e5a-49de-5dc975879b21@googlemail.com>
Date:   Fri, 28 Sep 2018 23:00:52 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <54d8d7e9-a80d-dc2b-5628-22f9dc14e2ee@maciej.szmigiero.name>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks Maciej.

On 28/09/2018 16:54, Maciej S. Szmigiero wrote:
> Hi,
> 
>> Hi,
>>
>> I upgraded my kernel to 4.18.10 recently and have since been experiencing network problems after resuming from a
>> suspend to RAM or disk. I previously had 4.18.6 and that was OK.
>>
>> The pattern of the problem is that when I first boot, the network is fine. But, after resume from suspend I find that
>> the time taken for a ping of one of my ISP's nameservers increases from 14-15ms to more than 1000ms. Moreover, when I
>> open a browser (chromium or firefox), it fails to retrieve my home page (https://www.google.co.uk) and pings of the
>> nameserver fail with the message "Destination Host Unreachable". Often, I can revive the network by stopping it with
>> /sbin/if(down,up} but sometimes it is necessary to also remove the r8169 module and load it again.
> 
> Please have a look at the following thread:
> https://lkml.org/lkml/2018/9/25/1118
> 

I applied your patch for the 4.18 stable kernels to 4.18.10, but the problem is not solved by it. Similarly, I applied
Heiner's patch to the 4.19, but again the problem is not solved.

> Maciej
> 
Chris
