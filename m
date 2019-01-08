Return-Path: <SRS0=iEdC=PQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B948EC43387
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 23:09:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7757F2084D
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 23:09:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZpHmRU/H"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729569AbfAHXJs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Jan 2019 18:09:48 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:46346 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728484AbfAHXJr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jan 2019 18:09:47 -0500
Received: by mail-pf1-f194.google.com with SMTP id c73so2631255pfe.13;
        Tue, 08 Jan 2019 15:09:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:openpgp:autocrypt:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=K26lFJm092fof6+5LVsiwuiU7mbHNx2Ng8cvgr0lex4=;
        b=ZpHmRU/Hu6UM0n/74om7fv8EpC/nWWCW7m7lowjLNPmtK7cfv7528Z2BTI4EYzZeNr
         oforl/Luj74JDU4TZc/XZexRgSzdBerMhuXfQR1hAduaOz7/q3ULPu0bYfRCzxQBbXzm
         M9u3UC3QfeIijnSIhiCn7DhxTT4ggAX8EN1GjYFQnF1UyMWWcPT8yVudC9AR20IGKjmv
         OCJpaE36JHPGyeE4YOQ4SzlO6KBnElPj3F7pjIyOVHirKkf4DVKFO0YFYaExpS8mN0qB
         UTVJScQ54W45oojfiQM2zP3mk6pc8sa7Qgm2FjA6XQQ9cUFDhZZ+XoUMbwRHg8nTuBts
         gRDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=K26lFJm092fof6+5LVsiwuiU7mbHNx2Ng8cvgr0lex4=;
        b=d7ALsYcRCKi0sS970acD38UD/1uIJJzafm/qjJGCUhiBuoJS7yZm9Kiq8BdcJKDZY4
         ei3Og157y/mFb4NiyNIANmLb5bsHjUb/5juzsCf4mkVgt45M5zVByQzmBhueGPL6b2dt
         k06LcxDuJHRKNVm3JxBR7ZBvQL0AlE+pDJIJMRJUnxzekVJ3xxQdo9wV85f+7o5A8k1b
         3dzz9j1thbFtK1/B6UjKCk5+/HFOYq2y4Sg5PftUZVuLkgbXxSJL4DBNZmlwxX3i5lJP
         TskO8DXCcxyMzm1wwWMaKcsH3A/bJq3NMvYgo6ASY1mlfp/GU61BY+fgfyw/3hv0mCdE
         iAgw==
X-Gm-Message-State: AJcUukcimniCBJNTxqt6opdFFrOafhdRfaIQpDEqpbMtifFS2TvrzqCA
        XimgFiKZjGeXExeV4FIoIwiZ9QEQ
X-Google-Smtp-Source: ALg8bN4vdwxXKaeJf1Yt5hh7eGw5BbV7vAJGM9Z+l518grdGQaw6xZvDqFYbTz6+WCul00gQ6u4pvg==
X-Received: by 2002:a63:cc4e:: with SMTP id q14mr3193641pgi.291.1546988985949;
        Tue, 08 Jan 2019 15:09:45 -0800 (PST)
Received: from [10.67.49.9] ([192.19.223.250])
        by smtp.googlemail.com with ESMTPSA id n70sm109600080pfi.185.2019.01.08.15.09.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 08 Jan 2019 15:09:45 -0800 (PST)
Subject: Re: [BUG] v4.20 - bridge not getting DHCP responses? (works in
 4.19.13)
To:     Ian Kumlien <ian.kumlien@gmail.com>,
        Stephen Hemminger <stephen@networkplumber.org>
Cc:     Linux Kernel Network Developers <netdev@vger.kernel.org>,
        jeffrey.t.kirsher@intel.com,
        Roopa Prabhu <roopa@cumulusnetworks.com>,
        nikolay@cumulusnetworks.com,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <CAA85sZsiifWTKq=Mw30f-UVyrzywnYYX7GvyqG+O+ndSYBML9A@mail.gmail.com>
 <CAA85sZsj5PxZeiXSVK92QXi93fc+Ch2x2KHqzzPcT2OffaKsEQ@mail.gmail.com>
 <CAA85sZsyEnkmwO2grp3H5pXErrNV=prOjEfPy=odoQ8iSHox4Q@mail.gmail.com>
 <20190108145112.65fc554f@hermes.lan>
 <CAA85sZt=mrqprwkKLGbv2UMy6vQb0XSc58YrWvqxzK4yhdbpGQ@mail.gmail.com>
From:   Florian Fainelli <f.fainelli@gmail.com>
Openpgp: preference=signencrypt
Autocrypt: addr=f.fainelli@gmail.com; prefer-encrypt=mutual; keydata=
 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
 M5kY0ACeNhCZJvZ5g4C2Lc9fcTHu8jxmEkI=
Message-ID: <02fbd1e8-8ad1-3a47-c3e1-86adbb73185d@gmail.com>
Date:   Tue, 8 Jan 2019 15:09:38 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <CAA85sZt=mrqprwkKLGbv2UMy6vQb0XSc58YrWvqxzK4yhdbpGQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/8/19 3:00 PM, Ian Kumlien wrote:
> On Tue, Jan 8, 2019 at 11:51 PM Stephen Hemminger
> <stephen@networkplumber.org> wrote:
>> On Tue, 8 Jan 2019 23:10:04 +0100
>> Ian Kumlien <ian.kumlien@gmail.com> wrote:
>>> On Sun, Jan 6, 2019 at 11:21 PM Ian Kumlien <ian.kumlien@gmail.com> wrote:
>>>>
>>>> [Sorry for the repost, screwed up the netdev address...]
>>>>
>>>> Hi,
>>>>
>>>> Switching from 4.19.x -> 4.20 resulted in DHCP not working for my VM:s.
>>>>
>>>> My firewall (which also runs the dhcpd) runs VM:s and it does this by
>>>> having physical
>>>> interfaces attached to bridges - which the VM:s in turn attach to.
>>>>
>>>> Since 4.20 the VM:s can't use DHCP, it's odd since the requests are
>>>> seen - a response is sent but
>>>> it never enters the interface attached to the bridge.
>>>>
>>>> Basically:
>>>> VM vnet2: -> br0 -> eno2 -> switch -> eno1 (dhcpd)
>>>> dhcpd eno1 -> siwtch and... gone.
>>>>
>>>> Any clues?
>>>>
>>>> All the nics are handled by ixgbe
>>>
>>> So, doing similar tests at work with other drivers works - could it be
>>> related to the mac address filter that was added?
>>> I don't *really* use VF:s though... (can't really find anything else atm)
>>>
>>> Will try to test, but the VM:s on this machine is in use.
>>
>> The default MAC address of the bridge device is the first device assigned
>> to the bridge.  Remember most VF interfaces will only allow single MAC address
>> and no promiscious mode.
> 
> Yeah, I'm not running any VF:s and it just seems like the responses
> are dropped somewhere
> 
> when looking at "git log v4.19...v4.20
> drivers/net/ethernet/intel/ixgbe/" nothing else really stands out...
> The machine is also running NAT for my home network and all of that
> works just fine...
> 
> I started with tcpdump, prooving that packets reached all the way
> outside but replies never made it, reboorting
> with 4.19.13 resulted in replies appearing in the tcpdump.
> 
> I don't quite know where to look - and what can i do to test - i tried
> disabling all offloading (due to the UDP
> offloading changes) but nothing helped...
> 
> Ideas? Patches? ;)

Running a bisection would certainly help find the offending commit if
that is something that you can do?
-- 
Florian
