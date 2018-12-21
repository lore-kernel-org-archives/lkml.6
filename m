Return-Path: <SRS0=OLKc=O6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EB79C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 19:19:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0F77A21928
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 19:19:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391626AbeLUTTb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Dec 2018 14:19:31 -0500
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:57100 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391592AbeLUTT1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Dec 2018 14:19:27 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 13B2280D;
        Fri, 21 Dec 2018 11:19:26 -0800 (PST)
Received: from [10.1.196.105] (eglon.cambridge.arm.com [10.1.196.105])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4EBD13F575;
        Fri, 21 Dec 2018 11:19:25 -0800 (PST)
Subject: Re: [PATCH] firmware: arm_sdei: fix wrong of_node_put() in init
 function
To:     Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20181126121536.28739-1-nsaenzjulienne@suse.de>
 <08d6b9e6-7aa0-9342-193b-1ce6e0417f77@arm.com>
 <7a75afd030cbd17c986a3ad486aab35ad3418b28.camel@suse.de>
From:   James Morse <james.morse@arm.com>
Message-ID: <cf4e5313-c467-8343-ac90-bb4b937b63ff@arm.com>
Date:   Fri, 21 Dec 2018 19:19:23 +0000
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.1
MIME-Version: 1.0
In-Reply-To: <7a75afd030cbd17c986a3ad486aab35ad3418b28.camel@suse.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Nicolas,

On 03/12/2018 12:25, Nicolas Saenz Julienne wrote:
> On Fri, 2018-11-30 at 18:31 +0000, James Morse wrote:
>> On 26/11/2018 12:15, Nicolas Saenz Julienne wrote:
>>> After finding a "firmware" dt node arm_sdei tries to match it's
>>> compatible string with it. To do so it's calling
>>> of_find_matching_node()
>>> which already takes care of decreasing the refcount on the
>>> "firmware"
>>> node. We are then incorrectly decreasing the refcount on that node
>>> again.
>>>
>>> This patch removes the unwarranted call to of_node_put().
>>>
>>> Fixes: ad6eb31ef903 ("firmware: arm_sdei: Add driver for Software
>>> Delegated Exceptions")
>>> Signed-off-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
>>
>> Thanks!, I agree this is unwarranted.
>> Is there a tool that picks these up? I remember sparse giving me a
>> headache, but
>> I don't remember this one... I probably cargo-culted it from
>> somewhere else.
> 
> We stumbled upon this one on a test system. TBH I don't really know
> much about these tools so I can't tell. That said, I sent 4 more fixes
> on this bug (one more in drivers/firmware) so there definitively was
> some cargo-culting happening.

Well this is embarrassing. I was trying to test this before re-posting it, to
discover dt-probing hasn't worked properly since it was merged, so I evidently
didn't test it properly after the merge-window. (at the same time the OF core
code took over creating platform devices from the firmware node, meaning my
attempt here fails, and the driver never gets registered).

I'll post the additional patch, and drop the fixes tag as this has never worked.


Thanks!

James
