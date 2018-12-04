Return-Path: <SRS0=p5KC=ON=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0110C04EB9
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 00:39:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 586D22081C
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 00:39:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="Nf36vW1m"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 586D22081C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=synopsys.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726031AbeLDAjG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Dec 2018 19:39:06 -0500
Received: from smtprelay.synopsys.com ([198.182.60.111]:55740 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725903AbeLDAjG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Dec 2018 19:39:06 -0500
Received: from mailhost.synopsys.com (mailhost1.synopsys.com [10.12.238.239])
        by smtprelay.synopsys.com (Postfix) with ESMTP id 54AA410C06F2;
        Mon,  3 Dec 2018 16:39:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1543883946; bh=1rT30HIhQKuw3rjjCx7kfGPGB/h49KpBOl9q42cDGpE=;
        h=Subject:To:CC:References:From:Date:In-Reply-To:From;
        b=Nf36vW1mQo8key0R70pyAd3KxxA27eBws40sZc5e7NfJm0IBo/ixcIMc3/5u6kFyF
         fJJpS0XJ9e/ltbtvm29AxoT5OCm710bU69lk8LVn+N1Qione6HF4rKKPoGhmJDm64Q
         K0+v4XxtDGAZ35+kbXnZ0RscGYk2CNgM8fVN2h5Bi/bHoeuLo+MoBvhmZuWNH2BX3q
         99oBDvF+Xju58FD/eZBpBIhR8+MKd/yM6AmDa7njVX1GoGRnvaBAWLfnZXKMybC9rn
         iw0mmGit9nt9AND8b2GkHeiXJa7E/HEh1CCsUx8SsAueaO10b1IHJyWDHvzUtXmODd
         iAIiXyQVV7KZw==
Received: from US01WEHTC3.internal.synopsys.com (us01wehtc3.internal.synopsys.com [10.15.84.232])
        by mailhost.synopsys.com (Postfix) with ESMTP id 44B905B93;
        Mon,  3 Dec 2018 16:39:06 -0800 (PST)
Received: from DE02WEHTCB.internal.synopsys.com (10.225.19.94) by
 US01WEHTC3.internal.synopsys.com (10.15.84.232) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Mon, 3 Dec 2018 16:39:06 -0800
Received: from DE02WEHTCA.internal.synopsys.com (10.225.19.92) by
 DE02WEHTCB.internal.synopsys.com (10.225.19.94) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Tue, 4 Dec 2018 01:39:04 +0100
Received: from [10.0.2.15] (10.225.2.138) by DE02WEHTCA.internal.synopsys.com
 (10.225.19.80) with Microsoft SMTP Server (TLS) id 14.3.408.0; Tue, 4 Dec
 2018 01:39:03 +0100
Subject: Re: [PATCH] i3c: Rename dw-i3c-master.c into i3c-master-dw.c
To:     Boris Brezillon <boris.brezillon@bootlin.com>,
        vitor <vitor.soares@synopsys.com>
CC:     <linux-kernel@vger.kernel.org>
References: <20181126084514.23663-1-boris.brezillon@bootlin.com>
 <20181203110739.0959d6c0@bbrezillon>
From:   vitor <vitor.soares@synopsys.com>
Message-ID: <fd4905e9-a5d9-349c-0dce-be59f0100f31@synopsys.com>
Date:   Tue, 4 Dec 2018 00:38:59 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181203110739.0959d6c0@bbrezillon>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Originating-IP: [10.225.2.138]
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Boris,


On 03/12/18 10:07, Boris Brezillon wrote:
> Hi Vitor,
>
> On Mon, 26 Nov 2018 09:45:14 +0100
> Boris Brezillon <boris.brezillon@bootlin.com> wrote:
>
>> Follow the naming scheme introduced by the Cadence driver to keep things
>> consistent.
>>
>> Signed-off-by: Boris Brezillon <boris.brezillon@bootlin.com>
>> ---
>>   drivers/i3c/master/Makefile                             | 2 +-
>>   drivers/i3c/master/{dw-i3c-master.c => i3c-master-dw.c} | 0
>>   2 files changed, 1 insertion(+), 1 deletion(-)
>>   rename drivers/i3c/master/{dw-i3c-master.c => i3c-master-dw.c} (100%)
> Any opinion on this rename. If you disagree with this, then I'd like to
> know it.
>
> Regards,
>
> Boris
>
>> diff --git a/drivers/i3c/master/Makefile b/drivers/i3c/master/Makefile
>> index fc53939a0bb1..c5f52733aa10 100644
>> --- a/drivers/i3c/master/Makefile
>> +++ b/drivers/i3c/master/Makefile
>> @@ -1,2 +1,2 @@
>>   obj-$(CONFIG_CDNS_I3C_MASTER)		+= i3c-master-cdns.o
>> -obj-$(CONFIG_DW_I3C_MASTER)		+= dw-i3c-master.o
>> +obj-$(CONFIG_DW_I3C_MASTER)		+= i3c-master-dw.o
>> diff --git a/drivers/i3c/master/dw-i3c-master.c b/drivers/i3c/master/i3c-master-dw.c
>> similarity index 100%
>> rename from drivers/i3c/master/dw-i3c-master.c
>> rename to drivers/i3c/master/i3c-master-dw.c


I already reply on initial thread. Please check my answers.


Best regards,

Vitor Soares

