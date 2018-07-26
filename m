Return-Path: <SRS0=7Z+k=KK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28EDEC28CF6
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 19:29:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D02A220671
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 19:29:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="fj3clX6H"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D02A220671
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731463AbeGZUrg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Jul 2018 16:47:36 -0400
Received: from merlin.infradead.org ([205.233.59.134]:42558 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730474AbeGZUrf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jul 2018 16:47:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=Evp98q7TGeMLWouw7IQaHciQ+h+CQTbno8nBiuRGlm0=; b=fj3clX6HWMJtmSku6ovk0EKnmX
        Ac3PbXd6WUUJx+EbvONznQ42foJ9b18EWH6KaV+DjukN7+eUK4Ge1O8Y2LrKW/tpVJg4vbBM45fGL
        NJ+h4X72EOmg8f7NQq2PoIhHRgDiOmm5kSBYaUJ0E/oa/rtlKK+xol0H1J1604wWZMQ1wBtk6UT0K
        T4/9DKGvJb2Yo7c4FbWT9xIczfvb5XGhzoP+xnwkMbOcbnOljO2mwJgOFgZ2pzL+fc6ogJBb/9sEm
        EFr7b2/g2EGDVTmA/6nuNsuuaEy4tyAeOvOVmSxdSFnn0e/w4IPFg2Zm2NOf5VAROWT7v1eX4rjHV
        HqJGplVA==;
Received: from static-50-53-52-16.bvtn.or.frontiernet.net ([50.53.52.16] helo=midway.dunlab)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1filwq-0006ZO-4x; Thu, 26 Jul 2018 19:29:16 +0000
Subject: Re: m68k allmodconfig build errors
To:     Finn Thain <fthain@telegraphics.com.au>
Cc:     Andreas Schwab <schwab@linux-m68k.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        linux-m68k@lists.linux-m68k.org
References: <28ebe45d-3dbd-2a82-f537-b0725f7a2bcf@infradead.org>
 <878t66idai.fsf@igel.home>
 <94dc0357-10d4-c3dc-ef2a-9643f08d2a09@infradead.org>
 <alpine.LNX.2.21.1807241423000.8@nippy.intranet>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <761399f0-0b10-716c-1e80-cfb19c06e455@infradead.org>
Date:   Thu, 26 Jul 2018 12:29:10 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <alpine.LNX.2.21.1807241423000.8@nippy.intranet>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/23/2018 09:49 PM, Finn Thain wrote:
> On Mon, 23 Jul 2018, Randy Dunlap wrote:
> 
>> On 07/20/2018 12:20 AM, Andreas Schwab wrote:
>>> On Jul 19 2018, Randy Dunlap <rdunlap@infradead.org> wrote:
>>>
>>>> block/partitions/ldm.o: In function `ldm_partition':
>>>> ldm.c:(.text+0x1900): undefined reference to `strcmp'
>>>> ldm.c:(.text+0x1964): undefined reference to `strcmp'
>>>> drivers/rtc/rtc-proc.o: In function `is_rtc_hctosys':
>>>> rtc-proc.c:(.text+0x290): undefined reference to `strcmp'
>>>> drivers/watchdog/watchdog_pretimeout.o: In function `watchdog_register_governor':
>>>> (.text+0x142): undefined reference to `strcmp'
>>>
>>> GCC has optimized strncmp to strcmp, but at a stage where macros are no
>>> longer available.  I think the right fix is to use strcmp directly,
>>> since strncmp doesn't make sense here.
>>
>> Hi Andreas,
>>
>> I don't see that all of these string compare fields are null-terminated.
>>
> 
> Some of the strncmp calls in ldm.c are null-terminated, some are not. 
> 
> That would imply that the compiler will emit both strcmp and strncmp 
> calls.
> 
> A strncmp call isn't a problem, because m68k doesn't define 
> __HAVE_ARCH_STRNCMP and so the one from lib/string.c gets built.
> 
>> How does one convert strncmp() users to strcmp()?
>>
>> thanks,
>>
> 
> The untested patch below may work. It seems that it may be relevant to 
> both arc and m68k:


I got back to looking at the build errors.  I agree with Andreas that
all of the fields in question are null-terminated, so Finn's patch looks
good to me.


-- 
~Randy
