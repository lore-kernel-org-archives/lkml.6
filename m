Return-Path: <SRS0=JLMu=PM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F550C43387
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 22:05:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D731F2087F
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 22:05:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726488AbfADWFv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Jan 2019 17:05:51 -0500
Received: from smtp07.smtpout.orange.fr ([80.12.242.129]:43014 "EHLO
        smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726217AbfADWFv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Jan 2019 17:05:51 -0500
Received: from [192.168.1.12] ([90.126.241.217])
        by mwinf5d66 with ME
        id LN5l1z0024i89ZE03N5l9k; Fri, 04 Jan 2019 23:05:48 +0100
X-ME-Helo: [192.168.1.12]
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Fri, 04 Jan 2019 23:05:48 +0100
X-ME-IP: 90.126.241.217
Subject: Re: [PATCH] octeontx2-af: Fix a resource leak in an error handling
 path in 'cgx_probe()'
To:     David Miller <davem@davemloft.net>
Cc:     sgoutham@marvell.com, lcherian@marvell.com, gakula@marvell.com,
        jerinj@marvell.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
References: <20181229164222.15791-1-christophe.jaillet@wanadoo.fr>
 <20190104.124626.1177296586022194416.davem@davemloft.net>
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Message-ID: <dd1f46d1-8ab7-260d-6e3c-e1ecdcc745d5@wanadoo.fr>
Date:   Fri, 4 Jan 2019 23:05:45 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.3
MIME-Version: 1.0
In-Reply-To: <20190104.124626.1177296586022194416.davem@davemloft.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le 04/01/2019 à 21:46, David Miller a écrit :
> From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> Date: Sat, 29 Dec 2018 17:42:22 +0100
>
>> If an error occurs after the call to 'pci_alloc_irq_vectors()', we must
>> call 'pci_free_irq_vectors()' in order to avoid a	resource leak.
>>
>> The same sequence is already in place in the corresponding 'cgx_remove()'
>> function.
>>
>> Fixes: 1463f382f58d ("octeontx2-af: Add support for CGX link management")
>> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> Applied and queued up for -stable.
>
> Please fix the date and time on your computer, putting improper dates into
> the email headers of your patch postings makes your patch appear out
> of order in my patchwork queue.
>
> Thank you.
>
Hi,

yes, I've spotted this time issue.
For some reason my VM get out of synch when restored from a saved state.
It was not the case before. It is likely due to an update of VirtualBox 
(i.e. 5.x --> 6.0) performed a few days ago.
Will try to give it a look.

For now, I have to manually do some ntpdate to get the time/date 
fixed... until the next save/restore of the VM.

Sorry for the inconvenience.

CJ

