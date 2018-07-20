Return-Path: <SRS0=cuzA=KE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3DD4ECDFB8
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 13:50:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 86076204EC
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 13:50:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=micronovasrl.com header.i=@micronovasrl.com header.b="WQbH/FiT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 86076204EC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=micronovasrl.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732017AbeGTOie (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Jul 2018 10:38:34 -0400
Received: from mail.micronovasrl.com ([212.103.203.10]:52980 "EHLO
        mail.micronovasrl.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731678AbeGTOie (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jul 2018 10:38:34 -0400
Received: from mail.micronovasrl.com (mail.micronovasrl.com [127.0.0.1])
        by mail.micronovasrl.com (Postfix) with ESMTP id 8CB46B00A16
        for <linux-kernel@vger.kernel.org>; Fri, 20 Jul 2018 15:50:09 +0200 (CEST)
Authentication-Results: mail.micronovasrl.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)" header.d=micronovasrl.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=micronovasrl.com;
         h=content-transfer-encoding:content-language:content-type
        :content-type:in-reply-to:mime-version:user-agent:date:date
        :message-id:from:from:references:to:subject:subject; s=dkim; t=
        1532094608; x=1532958609; bh=tqdJTSbfqj8a7MsMYsk+bzeXNduZdOy1b+b
        ZEhtzm9s=; b=WQbH/FiT7R1+3+VTzXT/d+OPHDFsaOQAVZeO0zFNmHr0032cLRv
        lo7JXyoL7+blepaCv5RPGol6M2LM7ml2G9L1YmTG5qRLVEDBRz0VBM1ZpQJaBHsk
        igVBhrJcFi9EJaCobrcEg4/izunSdXeEx9/fdZqdBaYTa6CpyYgXVH4w=
X-Virus-Scanned: Debian amavisd-new at mail.micronovasrl.com
Received: from mail.micronovasrl.com ([127.0.0.1])
        by mail.micronovasrl.com (mail.micronovasrl.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id oGY4cHisiM-n for <linux-kernel@vger.kernel.org>;
        Fri, 20 Jul 2018 15:50:08 +0200 (CEST)
Received: from [192.168.2.133] (62-11-51-166.dialup.tiscali.it [62.11.51.166])
        by mail.micronovasrl.com (Postfix) with ESMTPSA id 536D1B005DF;
        Fri, 20 Jul 2018 15:50:07 +0200 (CEST)
Subject: Re: [PATCH v10 2/4] rtc: ds1307: support m41t11 variant
To:     Rob Herring <robh@kernel.org>
Cc:     Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Mark Rutland <mark.rutland@arm.com>,
        "open list:REAL TIME CLOCK (RTC) SUBSYSTEM" 
        <linux-rtc@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
References: <CAHp75VcaALb8fYJExnZ=Ye=GcNHc3aPXgFihVK+rAu_a1A01Sg@mail.gmail.com>
 <20180718140946.115093-1-giulio.benetti@micronovasrl.com>
 <20180720134301.GA23613@rob-hp-laptop>
From:   Giulio Benetti <giulio.benetti@micronovasrl.com>
Message-ID: <a5dd8289-9d87-252c-e2a6-3af7237f165e@micronovasrl.com>
Date:   Fri, 20 Jul 2018 15:49:59 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180720134301.GA23613@rob-hp-laptop>
Content-Type: text/plain; charset=iso-8859-15; format=flowed
Content-Language: it
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 20/07/2018 15:43, Rob Herring ha scritto:
> On Wed, Jul 18, 2018 at 04:09:43PM +0200, Giulio Benetti wrote:
>> The m41t11 variant is very similar to the already supported m41t00 and
>> m41t0, but it has also 56 bytes of NVRAM.
>>
>> Add it to driver taking into account NVRAM section.
>>
>> Signed-off-by: Giulio Benetti <giulio.benetti@micronovasrl.com>
>> ---
>>   .../devicetree/bindings/rtc/rtc-ds1307.txt         |  1 +
> 
> Please add acks when posting new versions.
> 
>>   drivers/rtc/rtc-ds1307.c                           | 14 ++++++++++++++
>>   2 files changed, 15 insertions(+)

Thank you for pointing me that.
v11 patchset will include them all.

Giulio
