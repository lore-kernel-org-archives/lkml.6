Return-Path: <SRS0=FObM=LF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A10C7C4321D
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Aug 2018 17:28:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 555FC20A8B
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Aug 2018 17:28:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="FjZq26Lv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 555FC20A8B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727569AbeHVUyW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Aug 2018 16:54:22 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:45782 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727344AbeHVUyW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Aug 2018 16:54:22 -0400
Received: by mail-pg1-f194.google.com with SMTP id m4-v6so705098pgv.12
        for <linux-kernel@vger.kernel.org>; Wed, 22 Aug 2018 10:28:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=v/D5qVaix+k368XdLMYV1St5kO6zDNDBeSmyGDHqgCI=;
        b=FjZq26LvRih4ZovFQ5cv0EBVQzpH4rv5RoNmH1MjuxbCcc+Yc9BV99R1TGcvRKwGyu
         +E24lbUY2WlPzB/FSKdUtBDQ+6SRoJDdItysukCfU9OSqn23+gvdVjhI+3RJudH81IDD
         HDhrvo4gNQP8j3S+oBPVdhOceH+4HHsadRRr1blndhepo43f7h93acgquxAcfbU59vUL
         dxYJd+11DCwcLBuAouWAKGfOuwgUdi0H3IdPOIJldEyevX6jzAYi5Zzs6S8jEX8vrRh4
         AO83rR5wYGd51VhEAjnMyWzpEkYLBUUfZ3Ai67DLUgHUI7Q7cTnZcQMwWNIOuXc235Wo
         k4ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=v/D5qVaix+k368XdLMYV1St5kO6zDNDBeSmyGDHqgCI=;
        b=n+QrCFk0fFdk0DirC3X6w81HkZUXCbPFk4VluM/DiI05zw4NMjSoRHIK3f/tc3LStE
         62PFd+YzxgYpeM+T8s5IeqTNVq3Mvcw/qr6y4Qo/XB+1QEYFxp8XgVh9BwRt94sluw6V
         5aCG15UFAyXb4Z7QGPWo1ZtwBAT4q7vXSUZQTWoYHTnopmUo72U+fJriolDy7GZdBcpg
         Qk6RapFJzVp5wWGNDuw4F1R9GesfQ29+/FKEvDlbTcgzn3SdlbzXSONwNvAPU/OxzD/1
         2MUGf/hP8715rQJR+mbb/4Y6rYgZni0OaUN4JmZnkvyYRKA+0V6NM3c1LFmCam0nG2F7
         pYQA==
X-Gm-Message-State: AOUpUlGrLRrw9MzPY2pXi7x7bI8PNukRgInSaptxlQoNqvZ6FGfEnlKE
        ft73ucQTB83EHCCn9JsttemmcizH0GY=
X-Google-Smtp-Source: AA+uWPwJuUtalroMOvi8TKanQSy985YBZNo3Q7v5R0BS9GyGZebWyK8gOTgddRRiXBPBXplUhpSIlA==
X-Received: by 2002:a63:e647:: with SMTP id p7-v6mr51218871pgj.218.1534958914525;
        Wed, 22 Aug 2018 10:28:34 -0700 (PDT)
Received: from ?IPv6:2620:10d:c081:1130::1153? ([2620:10d:c090:180::1:bf4f])
        by smtp.gmail.com with ESMTPSA id q26-v6sm2853222pff.9.2018.08.22.10.28.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 22 Aug 2018 10:28:32 -0700 (PDT)
Subject: Re: [PATCH] blk-wbt: Avoid lock contention and thundering herd issue
 in wbt_wait
From:   Jens Axboe <axboe@kernel.dk>
To:     =?UTF-8?Q?Holger_Hoffst=c3=a4tte?= <holger@applied-asynchrony.com>,
        Anchal Agarwal <anchalag@amazon.com>
Cc:     fllinden@amazon.com, sblbir@amazon.com, msw@amazon.com,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
References: <6bab69c9-b787-b12f-7738-72e05bf74444@kernel.dk>
 <72f90be2-0b63-d3a0-e953-da9232f44d5b@kernel.dk>
 <761bb0ab416649b8bf3bac1706124456@EX13D13UWB002.ant.amazon.com>
 <7f6c399d-bda1-0bbf-4ea1-07fc510ed1eb@kernel.dk>
 <3498fbfb-e9f3-7606-1fc3-904a0e61ff57@kernel.dk>
 <168d80ac73a44a6f9242c47c164778fc@EX13D13UWB002.ant.amazon.com>
 <c5152431-6e36-6f6e-616e-1cfbd974817d@kernel.dk>
 <20180820224241.GA72523@8c8590bceeee.ant.amazon.com>
 <70e2063a-53fa-2475-eed9-07db277c8c0d@kernel.dk>
 <b2adf708-d396-94ac-b123-8027d3839fd1@kernel.dk>
 <20180822040126.GA18736@kaos-source-ops-60001.pdx1.amazon.com>
 <76ecb022-f167-67eb-8801-111fc209bbaa@kernel.dk>
 <834649ab-62d6-bc7f-ec60-6c1654ea3f26@applied-asynchrony.com>
 <d8c171ce-6dfe-e9e5-5673-8443cfec5f01@kernel.dk>
Message-ID: <ed71fb8f-1f36-c216-5886-269c77250e29@kernel.dk>
Date:   Wed, 22 Aug 2018 11:28:30 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <d8c171ce-6dfe-e9e5-5673-8443cfec5f01@kernel.dk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/22/18 8:27 AM, Jens Axboe wrote:
> On 8/22/18 6:54 AM, Holger Hoffstätte wrote:
>> On 08/22/18 06:10, Jens Axboe wrote:
>>> [...]
>>> If you have time, please look at the 3 patches I posted earlier today.
>>> Those are for mainline, so should be OK :-)
>>
>> I'm just playing along at home but with those 3 I get repeatable
>> hangs & writeback not starting at all, but curiously *only* on my btrfs
>> device; for inexplicable reasons some other devices with ext4/xfs flush
>> properly. Yes, that surprised me too, but it's repeatable.
>> Now this may or may not have something to do with some of my in-testing
>> patches for btrfs itself, but if I remove those 3 wbt fixes, everything
>> is golden again. Not eager to repeat since it hangs sync & requires a
>> hard reboot.. :(
>> Just thought you'd like to know.
> 
> Thanks, that's very useful info! I'll see if I can reproduce that.

Any chance you can try with and see which patch is causing the issue?
I can't reproduce it here, seems solid.

Either that, or a reproducer would be great...

-- 
Jens Axboe

