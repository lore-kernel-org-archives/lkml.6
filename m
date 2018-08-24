Return-Path: <SRS0=6SfI=LH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88C44C4321D
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 12:35:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 31B9221564
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 12:35:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="bCxTmBRl";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="IyQPEzeu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 31B9221564
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727392AbeHXQJa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Aug 2018 12:09:30 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:39022 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727059AbeHXQJa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Aug 2018 12:09:30 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 4DCDD604BE; Fri, 24 Aug 2018 12:35:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1535114101;
        bh=oWqZlc23RRXg2iix32BxNCJ0HWcMyRDZP+TlPMoHcxg=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=bCxTmBRl027yzcscREty9/mogBmWkNqp7lWNA5AeFF1CQ7fXUccqoX2w1BeKgMMET
         Umhh3s//eYRMjLayyYhO3ljGJKJxI0jOmFdtCOWuv7Ro6O11/0yw0wD9kdbkWmEmF/
         U+tQVnI8GLEVcupg13ai9Ze0FhHPtB4seS7VfXj0=
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        by smtp.codeaurora.org (Postfix) with ESMTP id 8AEEB60227;
        Fri, 24 Aug 2018 12:35:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1535114100;
        bh=oWqZlc23RRXg2iix32BxNCJ0HWcMyRDZP+TlPMoHcxg=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=IyQPEzeu9RISss7Z4oBXVBIQv8r0+MnXzXQ22ux5wOktdraCLQEqRRvxCLF1vkzx0
         BBso0tz+SpJBJvt6/5MRYpvyMCIG0ZGSmsWV4GkqBA7PWuRyLuC+1tFl3s1R8V99on
         ewrnGt3BRw7EsN3TF/FrxEy6Uz4jMYecZCCxCud4=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Fri, 24 Aug 2018 18:05:00 +0530
From:   Vikash Garodia <vgarodia@codeaurora.org>
To:     Stanimir Varbanov <stanimir.varbanov@linaro.org>
Cc:     Alexandre Courbot <acourbot@chromium.org>,
        Hans Verkuil <hverkuil@xs4all.nl>,
        Mauro Carvalho Chehab <mchehab@kernel.org>, robh@kernel.org,
        mark.rutland@arm.com, Andy Gross <andy.gross@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>, bjorn.andersson@linaro.org,
        Linux Media Mailing List <linux-media@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-media-owner@vger.kernel.org
Subject: Re: [PATCH v6 1/4] venus: firmware: add routine to reset ARM9
In-Reply-To: <51cc9d6b-0483-76a6-d413-3f5cc63f3f56@linaro.org>
References: <1535034528-11590-1-git-send-email-vgarodia@codeaurora.org>
 <1535034528-11590-2-git-send-email-vgarodia@codeaurora.org>
 <CAPBb6MUZawT84Wcrhi+MEyn+zSCWOpn_iOZMMudZz+_Urixsrw@mail.gmail.com>
 <51cc9d6b-0483-76a6-d413-3f5cc63f3f56@linaro.org>
Message-ID: <d6661f5a8f6c64b017dad5b7b8000042@codeaurora.org>
X-Sender: vgarodia@codeaurora.org
User-Agent: Roundcube Webmail/1.2.5
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-08-24 14:27, Stanimir Varbanov wrote:
> Hi Alex,
> 
> On 08/24/2018 10:38 AM, Alexandre Courbot wrote:
>> On Thu, Aug 23, 2018 at 11:29 PM Vikash Garodia 
>> <vgarodia@codeaurora.org> wrote:
>>> 

[snip]

>>> index c4a5778..a9d042e 100644
>>> --- a/drivers/media/platform/qcom/venus/firmware.c
>>> +++ b/drivers/media/platform/qcom/venus/firmware.c
>>> @@ -22,10 +22,43 @@
>>>  #include <linux/sizes.h>
>>>  #include <linux/soc/qcom/mdt_loader.h>
>>> 
>>> +#include "core.h"
>>>  #include "firmware.h"
>>> +#include "hfi_venus_io.h"
>>> 
>>>  #define VENUS_PAS_ID                   9
>>>  #define VENUS_FW_MEM_SIZE              (6 * SZ_1M)
>> 
>> This is making a strong assumption about the size of the FW memory
>> region, which in practice is not always true (I had to reduce it to
>> 5MB). How about having this as a member of venus_core, which is
> 
> Why you reduced to 5MB? Is there an issue with 6MB or you don't want to
> waste reserved memory?
> 
>> initialized in venus_load_fw() from the actual size of the memory
>> region? You could do this as an extra patch that comes before this
>> one.

I would go with existing design than relying on the size specified in 
the
memory-region for venus. size loaded is always taken from DT while the
VENUS_FW_MEM_SIZE serves the purpose of sanity check.

> The size is 6MB by historical reasons and they are no more valid, so I
> think we could safely decrease to 5MB. I could prepare a patch for 
> that.

Thanks Stan. Initial patch in this series had 5MB. We discussed earlier 
to keep
it as is and take it as a separate patch to update from 6MB to 5MB.
