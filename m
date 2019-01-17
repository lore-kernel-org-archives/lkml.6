Return-Path: <SRS0=R5eS=PZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B87B0C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 23:02:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 833E620859
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 23:02:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547766168;
	bh=9ds46BfJ/xCaq7/DEWfaigO1gGPU3gFvQg31+jgp2Qw=;
	h=Subject:To:Cc:References:From:Date:In-Reply-To:List-ID:From;
	b=bNHGr6ZTBNyYzDd0GCWu53Cj7FbQKghrBivN3v59LMB06EU57GNW4nuq6sZGIz9T0
	 szcZ8zZ/DZS7T37jEK7uUEunNV2Iio7D3UCQx8mXEZ8XX1Mk/yElvd56fmuuFcQITW
	 bDXv2JKJnT2ulf+0O/lYXoXVMtqq1omxj17ay2dQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726095AbfAQXCq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Jan 2019 18:02:46 -0500
Received: from mail.kernel.org ([198.145.29.99]:33178 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726981AbfAQXCp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jan 2019 18:02:45 -0500
Received: from [10.84.151.4] (unknown [167.220.149.4])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 29EE520855;
        Thu, 17 Jan 2019 23:02:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1547766165;
        bh=9ds46BfJ/xCaq7/DEWfaigO1gGPU3gFvQg31+jgp2Qw=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=EXvvTX0Po0zCyJWVd4w/F6ts1V+rsnWUyzYyX4YOvDTHwwqxAWO5WBjKSOmnM+mev
         IV24BbfxmknXLQfK5qN0JEDGm2nocLU0RGyaSqldXD4xqPHh6UcWma/5ZQiWSVN4tJ
         X7ZVoJdT/aZLxVXqVJmtOO/bFdhbUCr5Oe+vFqEQ=
Subject: Re: [for-next][PATCH] x86/Kconfig: Select PCI_LOCKLESS_CONFIG if PCI
 is enabled
To:     Borislav Petkov <bp@alien8.de>,
        "Rafael J. Wysocki" <rafael@kernel.org>
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
From:   Sinan Kaya <okaya@kernel.org>
Message-ID: <b92f439e-b95c-56e3-6960-52ae1e1afe71@kernel.org>
Date:   Thu, 17 Jan 2019 18:02:42 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190117220959.GG5023@zn.tnic>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/17/2019 5:09 PM, Borislav Petkov wrote:
> On Thu, Jan 17, 2019 at 11:05:43PM +0100, Rafael J. Wysocki wrote:
>> I have patches for intel_ips and intel_pmc_ipc queued up (will be
>> pushed for -rc3), plus some others.
> 
> Yeah, I saw the patchset and applied some of them locally so that I be
> able to do randconfig builds. Do you have a branch somewhere which I can
> merge locally for testing?
>

You can use this tag (next-20190116) for local test.
