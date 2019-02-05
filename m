Return-Path: <SRS0=cBqk=QM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0619C282CB
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 17:31:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B2B97217D6
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 17:31:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730481AbfBERbc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Feb 2019 12:31:32 -0500
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:44082 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727097AbfBERbc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Feb 2019 12:31:32 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 54B07EBD;
        Tue,  5 Feb 2019 09:31:31 -0800 (PST)
Received: from [10.1.196.105] (eglon.cambridge.arm.com [10.1.196.105])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A74253F557;
        Tue,  5 Feb 2019 09:31:26 -0800 (PST)
Subject: Re: [PATCH] EDAC, dmc520:: add DMC520 EDAC driver
To:     Borislav Petkov <bp@alien8.de>
Cc:     Rui Zhao <ruizhao@microsoft.com>, Sasha Levin <sashal@kernel.org>,
        "mchehab@kernel.org" <mchehab@kernel.org>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Linux Kernel <linux-kernel@microsoft.com>,
        "will.deacon@arm.com" <will.deacon@arm.com>,
        "okaya@kernel.org" <okaya@kernel.org>
References: <20190118162324.17123-1-sashal@kernel.org>
 <0866a996-49f7-1498-4653-20232bef2f46@arm.com>
 <MW2PR2101MB09701C705250DAC025AFC251B3990@MW2PR2101MB0970.namprd21.prod.outlook.com>
 <7d404c61-a916-5d5e-35cc-0f6f016cd8a9@arm.com>
 <20190123184639.GD3227@zn.tnic>
From:   James Morse <james.morse@arm.com>
Message-ID: <e2105800-db52-513f-e163-3769a26d1dfb@arm.com>
Date:   Tue, 5 Feb 2019 17:31:24 +0000
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190123184639.GD3227@zn.tnic>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Boris,

On 23/01/2019 18:46, Borislav Petkov wrote:
> On Wed, Jan 23, 2019 at 06:36:23PM +0000, James Morse wrote:
>>> Would like to know what's the impact if this error happens, and how to fit it
>>> with current reporting in EDAC core.
>>
>> At a guess the interrupt triggers when link_err_count increases. (link_err has
>> an overflow bit, so the interrupt must be related to a counter).
>>
>> If we could associate a link with a layer in edac, we could report errors
>> against that point. But I've no idea how 'links' correspond with 'ranks and banks'!


> Well, I have no clue what kind of links you guys are talking but if
> those are per-chance coherent links used by cores to communicate in a
> coherent fabric, or cores and devices, what would showing those errors
> to the user bring ya?

(I mentioned this because its the next interrupt in the register, its an example
of something that may be added for another platform in the future, which affects
the DT and probing)


> Or are ya talking about different kinds of links?

... whatever the manual means by 'link', good point, it could be the
interconnect side.

'alert_mode_next', in the feature control register talks about DIMM training,
and says 'dfi_err' is treated a a link error. DFI is defined earlier as the 'DDR
PHY interface', so these must be links between the DMC520 and DDR.


> In any case, the first question to ask would be, can some agent or the
> user do something with the information that X or Y link errors happened?
> 
> If not, then why bother?
> If yes, then that's a different story.

I agree. Surely if the DIMMs are socketed link-errors are another reason to
replace the DIMM.

It looks like this doesn't matter on Rui's platform,


Thanks,

James
