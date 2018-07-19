Return-Path: <SRS0=/F/O=KD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5E55C468C6
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 14:46:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9D2562084E
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 14:46:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9D2562084E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731724AbeGSPaI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Jul 2018 11:30:08 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:50440 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727367AbeGSPaI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jul 2018 11:30:08 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 39C8A7A9;
        Thu, 19 Jul 2018 07:46:38 -0700 (PDT)
Received: from [10.1.206.34] (melchizedek.cambridge.arm.com [10.1.206.34])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 156193F93D;
        Thu, 19 Jul 2018 07:46:36 -0700 (PDT)
Subject: Re: [RFC PATCH] EDAC, ghes: Enable per-layer error reporting for ARM
To:     Borislav Petkov <bp@alien8.de>,
        Tyler Baicar <tbaicar@codeaurora.org>
Cc:     mchehab@kernel.org, linux-edac@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <1531762009-15112-1-git-send-email-tbaicar@codeaurora.org>
 <20180719140102.GB25185@nazgul.tnic>
From:   James Morse <james.morse@arm.com>
Message-ID: <94e3a0fb-9b7d-045f-733b-9f063dcb39e4@arm.com>
Date:   Thu, 19 Jul 2018 15:46:32 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180719140102.GB25185@nazgul.tnic>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi guys,

On 19/07/18 15:01, Borislav Petkov wrote:
> On Mon, Jul 16, 2018 at 01:26:49PM -0400, Tyler Baicar wrote:
>> Enable per-layer error reporting for ARM systems so that the error
>> counters are incremented per-DIMM.
>>
>> On ARM systems that use firmware first error handling it is understood

understood by whom? Is this written down somewhere, or is it the convention. (in
which case, lets get it written down somewhere)


>> that card=channel and module=DIMM on that channel. Populate that
I'm guessing this is the mapping between CPER records and the DMItable data.


>> information and enable per layer error reporting for ARM systems so that
>> the EDAC error counters are incremented based on DIMM number as per the
>> SMBIOS table rather than just incrementing the noinfo counters on the
>> memory controller.

Does this work on x86, and its just the dmi/cper fields have a subtle difference?


> I guess.
> 
> James?

I don't know anything about this stuff. Looks like the SMBIOS specification is
my new bedtime reading.



Thanks,

James
