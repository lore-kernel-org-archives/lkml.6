Return-Path: <SRS0=p5KC=ON=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FD35C04EB8
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 18:28:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0D9682082B
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 18:28:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="eRSieXz8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0D9682082B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=synopsys.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725988AbeLDS2T (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Dec 2018 13:28:19 -0500
Received: from smtprelay.synopsys.com ([198.182.60.111]:36940 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725839AbeLDS2T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Dec 2018 13:28:19 -0500
Received: from mailhost.synopsys.com (mailhost2.synopsys.com [10.13.184.66])
        by smtprelay.synopsys.com (Postfix) with ESMTP id 243D910C08CB;
        Tue,  4 Dec 2018 10:28:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1543948099; bh=+PdpExVMX+3D7APAGBkcyJjcK6TwJ649539QewZSdvs=;
        h=Subject:From:To:CC:References:Date:In-Reply-To:From;
        b=eRSieXz86cbSQX2Wbn7aTOQg++jPrKKIBxGtGEBz5FyXWKZNrGatU3kxaq0pehwEh
         AAYJ7r5sfo+5BwVqEYT/I8mfedcikgj3Bm7Dm1+BFFwE670VGy8fyCGlnH53d3wUHg
         OCnOj92eMmxB/fpPTJGY0AaWHgMiwhANOm+yah/4Q93XTWbLs52AeLRQS5M3Q38i6W
         BEmftBR79TDI4NL3uvyUTZPGNC1O8SXSIR9bUUKTOc4KG1Hf8CRLNdHonNnACpSaKq
         3mH0OC2A6OLnWgI7fZP/tQ4vUgPl2a/3pHozHXGi7lcMgA/A4ZUT2kGrPQ8bIqqreN
         7Rh9/3CE87azA==
Received: from us01wehtc1.internal.synopsys.com (us01wehtc1-vip.internal.synopsys.com [10.12.239.236])
        by mailhost.synopsys.com (Postfix) with ESMTP id E25763CE9;
        Tue,  4 Dec 2018 10:28:18 -0800 (PST)
Received: from DE02WEHTCB.internal.synopsys.com (10.225.19.94) by
 us01wehtc1.internal.synopsys.com (10.12.239.231) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Tue, 4 Dec 2018 10:28:18 -0800
Received: from DE02WEHTCA.internal.synopsys.com (10.225.19.92) by
 DE02WEHTCB.internal.synopsys.com (10.225.19.94) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Tue, 4 Dec 2018 19:28:16 +0100
Received: from [10.0.2.15] (10.107.19.104) by DE02WEHTCA.internal.synopsys.com
 (10.225.19.80) with Microsoft SMTP Server (TLS) id 14.3.408.0; Tue, 4 Dec
 2018 19:28:15 +0100
Subject: Re: [PATCH] i3c: Rename dw-i3c-master.c into i3c-master-dw.c
From:   vitor <vitor.soares@synopsys.com>
To:     Boris Brezillon <boris.brezillon@bootlin.com>,
        vitor <vitor.soares@synopsys.com>
CC:     <linux-kernel@vger.kernel.org>
References: <20181126084514.23663-1-boris.brezillon@bootlin.com>
 <20181203110739.0959d6c0@bbrezillon>
 <fd4905e9-a5d9-349c-0dce-be59f0100f31@synopsys.com>
Message-ID: <07f663b9-a973-39cf-c1ab-cc5ffb1a6210@synopsys.com>
Date:   Tue, 4 Dec 2018 18:28:12 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <fd4905e9-a5d9-349c-0dce-be59f0100f31@synopsys.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Originating-IP: [10.107.19.104]
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Boris,

On 04/12/18 00:38, vitor wrote:
> Hi Boris,
>
>
> On 03/12/18 10:07, Boris Brezillon wrote:
>> Hi Vitor,
>>
>> On Mon, 26 Nov 2018 09:45:14 +0100
>> Boris Brezillon <boris.brezillon@bootlin.com> wrote:
>>
>>> Follow the naming scheme introduced by the Cadence driver to keep 
>>> things
>>> consistent.
>>>
>>> Signed-off-by: Boris Brezillon <boris.brezillon@bootlin.com>
>>> ---
>>>   drivers/i3c/master/Makefile                             | 2 +-
>>>   drivers/i3c/master/{dw-i3c-master.c => i3c-master-dw.c} | 0
>>>   2 files changed, 1 insertion(+), 1 deletion(-)
>>>   rename drivers/i3c/master/{dw-i3c-master.c => i3c-master-dw.c} (100%)
>> Any opinion on this rename. If you disagree with this, then I'd like to
>> know it.
>>
>> Regards,
>>
>> Boris


I don't agree with the master folder name. The name is redundant.


If you want to change my driver name I don't mind.


>>
>>> diff --git a/drivers/i3c/master/Makefile b/drivers/i3c/master/Makefile
>>> index fc53939a0bb1..c5f52733aa10 100644
>>> --- a/drivers/i3c/master/Makefile
>>> +++ b/drivers/i3c/master/Makefile
>>> @@ -1,2 +1,2 @@
>>>   obj-$(CONFIG_CDNS_I3C_MASTER)        += i3c-master-cdns.o
>>> -obj-$(CONFIG_DW_I3C_MASTER)        += dw-i3c-master.o
>>> +obj-$(CONFIG_DW_I3C_MASTER)        += i3c-master-dw.o
>>> diff --git a/drivers/i3c/master/dw-i3c-master.c 
>>> b/drivers/i3c/master/i3c-master-dw.c
>>> similarity index 100%
>>> rename from drivers/i3c/master/dw-i3c-master.c
>>> rename to drivers/i3c/master/i3c-master-dw.c
>
>
> I already reply on initial thread. Please check my answers.
>
>
> Best regards,
>
> Vitor Soares


Best regards,

Vitor Soares

