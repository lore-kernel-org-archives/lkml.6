Return-Path: <SRS0=RWde=P5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0806AC37121
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 23:18:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C179B21019
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 23:18:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548112697;
	bh=kDYX4WAGramf23UGTB9MbOo41Oq1Np9BkozJmB7SYmw=;
	h=Subject:To:Cc:References:From:Date:In-Reply-To:List-ID:From;
	b=RA+DueGd8/FQIXbM2++wOn1ihl/r4+IDEf30ipkTGhEUHTZ0frwpZRJU4c+l1h/HP
	 2XV8k0EQKE6eJ+6h+Z73Jme/uji3JdhxdQfUNzpU6O0A5kTA5WIKH9HdgFQcVjwO9y
	 fL13MV1hXjQiiAXlZiK56tud+48/qcFQgmNDfS/o=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727798AbfAUXSQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Jan 2019 18:18:16 -0500
Received: from mail.kernel.org ([198.145.29.99]:59016 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727012AbfAUXSP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jan 2019 18:18:15 -0500
Received: from [192.168.0.109] (cpe-174-109-247-98.nc.res.rr.com [174.109.247.98])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A490020870;
        Mon, 21 Jan 2019 23:18:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548112694;
        bh=kDYX4WAGramf23UGTB9MbOo41Oq1Np9BkozJmB7SYmw=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=SIWe5czRe5ch8i5KOYldPDLVGJZMHzBmcV6BRH3ztKT1kXrEG5vwfOuuaN+0rcApX
         ozwuDKeHr2luaqGypo8YjtDfkSLYztqlVBjHRwEWlveOclDprrnKD5Re3fwHAvdQF8
         ckaR/k7BufPe5VyoklMF2z5CwQ9upfu8UDYRKRwY=
Subject: Re: [for-next][PATCH] x86/Kconfig: Select PCI_LOCKLESS_CONFIG if PCI
 is enabled
To:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Borislav Petkov <bp@alien8.de>
Cc:     Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        "open list:X86 ARCHITECTURE (32-BIT AND 64-BIT)" 
        <linux-kernel@vger.kernel.org>
References: <20190117161722.3945-1-okaya@kernel.org>
 <20190117163722.GE5023@zn.tnic>
 <c0fa174a-2e7b-2ef2-4913-167934c68c06@kernel.org>
 <20190117215631.GF5023@zn.tnic>
 <CAJZ5v0hHFASeJb8z8QwQkh-tCs409pnaywtWcqLP5K5ZDGhTsw@mail.gmail.com>
 <20190117220959.GG5023@zn.tnic>
 <CAJZ5v0iR=0ZoS_=KpTRefZ+fdZOKAAH1PSxfS0cfyS+zx39Hgw@mail.gmail.com>
From:   Sinan Kaya <okaya@kernel.org>
Message-ID: <637e85ca-844b-0bab-1691-ecf14b55e80e@kernel.org>
Date:   Mon, 21 Jan 2019 18:18:12 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <CAJZ5v0iR=0ZoS_=KpTRefZ+fdZOKAAH1PSxfS0cfyS+zx39Hgw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/18/2019 6:45 AM, Rafael J. Wysocki wrote:
> On Thu, Jan 17, 2019 at 11:10 PM Borislav Petkov <bp@alien8.de> wrote:
>>
>> On Thu, Jan 17, 2019 at 11:05:43PM +0100, Rafael J. Wysocki wrote:
>>> I have patches for intel_ips and intel_pmc_ipc queued up (will be
>>> pushed for -rc3), plus some others.
>>
>> Yeah, I saw the patchset and applied some of them locally so that I be
>> able to do randconfig builds. Do you have a branch somewhere which I can
>> merge locally for testing?
> 
> You can pull the tag I've just pushed to Linus:
> https://lore.kernel.org/lkml/CAJZ5v0jiK=zLP4cUsw=y9ea7PLHHgy=xshAsHFhTgyDJH+kOiQ@mail.gmail.com/T/#u
> 

Here is a result of my randconfig analysis using next-20190116.

There are two issues that are related to my change:
1. x86/Kconfig: Select PCI_LOCKLESS_CONFIG if PCI is enabled
2. mfd: Fix unmet dependency warning for MFD_TPS68470

I'll post v2 for this patch to pick up the above commit #2.

and three unrelated changes as follows:
1. platform/x86: Fix unmet dependency warning for SAMSUNG_Q10
2. platform/x86: Fix unmet dependency warning for ACPI_CMPC
3. iwlwifi: Fix unmet dependency warning for MAC80211_LEDS

I'm posting these unrelated changes independently.
