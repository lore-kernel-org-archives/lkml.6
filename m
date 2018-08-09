Return-Path: <SRS0=+sa6=KY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6F24C46464
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 09:27:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7C92E21CD2
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 09:27:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oZonKDn0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7C92E21CD2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730252AbeHILu6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Aug 2018 07:50:58 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:40868 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727579AbeHILu5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Aug 2018 07:50:57 -0400
Received: by mail-ed1-f67.google.com with SMTP id e19-v6so2544446edq.7;
        Thu, 09 Aug 2018 02:26:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=+1csdFyNq7a2Wb7SlXHCwKIKeKiS7tTzRKA5GYgzbAI=;
        b=oZonKDn0ePY+2z1dkkvqhQvBmHOyv+vLa8Ya/e6TfHFPj1SAuXjBJ5cpeTPOM3S4pc
         j0FDYSaZa79B9zQaRH1D2eQKaSUPCXVGC98SSi/WaEuzq2vD8IqKX1N4+wRoZrJbU1zQ
         CDC6A09DGM+Z7fkF7WvODRxNddDVifOU8aXGgBo3KUh0MhuDiALKf/iHNdwS79EKvexz
         7TGtltNZcbKIX3/NIn71r62n8EYxOtoV9afkYf1JBoSHqtyR3IK3BuBWIMjjEXEiYzDJ
         i8Mu+tPXBv2mEqfLLj7G5hpFDeKtMQTZmg3ht40YJ1tG41LtjxOHaSBgWupRE5TIX9fa
         eAoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=+1csdFyNq7a2Wb7SlXHCwKIKeKiS7tTzRKA5GYgzbAI=;
        b=qHhyV0czqptTFhcgrHIjPwLOV9isLWiix8HEq9F/w6hO7qfx8REhw7wSlGuniShxfV
         Y64KsjwoMs6tveg+fvggyha/XR0eAStxSFaR7KtHKhLwFB/yfQLDxtNtp9TSzERtXfXt
         pfbDAfUQVeY+WlVdG1bUyK1r7185+G/trFDjqYmI7ZIhd0TVKMttqWMlV13jIxHugm6m
         Tkn9QjagEV2c9YBerba8iplQYYI6+bVNE0FpJkaPZotdmuM5HaL9DTjyvRoKLds+oYQn
         XauuskaG5qNBwyf8ZDJgt7CM0vFmaJakg78BPJMrxHFxgNqHCk+kPyXErK013xkw1bHm
         HXAw==
X-Gm-Message-State: AOUpUlGDw6KrB3uzK4nweasfv6dY3gUZHV7ce8DFG4CZg7OjIOLLDRqB
        7Ptxm15Vj1r+cJFe5c+4ZAGVgT/bAOQI0DlkyQ4=
X-Google-Smtp-Source: AA+uWPwyNG98D5vuUO44X9sA3iw/YVoYC2MuAkK4bkxx9jcTal4IOD7Tst6Lxaj+6PIP1eGv2IqsADM6kX4Dy1/OpOk=
X-Received: by 2002:a50:8921:: with SMTP id e30-v6mr2160163ede.213.1533806816557;
 Thu, 09 Aug 2018 02:26:56 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a50:f68b:0:0:0:0:0 with HTTP; Thu, 9 Aug 2018 02:26:56 -0700 (PDT)
In-Reply-To: <b3045f85-eacb-a5ec-1690-b9c63d0f3373@kapsi.fi>
References: <20180702114033.15654-1-mperttunen@nvidia.com> <20180702114033.15654-4-mperttunen@nvidia.com>
 <CABb+yY0_dKC_cYFwwb-aeRgrx=sjv=8VLP=C6DJEecFf=v+mkQ@mail.gmail.com>
 <907bac36-0c54-8f38-0f5e-f59196d414c6@kapsi.fi> <afc8a305-79ea-2194-0af0-919bbb8f675e@kapsi.fi>
 <CABb+yY2mpNV186=M2anmZANgMOra4JM7ybyUT4yCxhqAG6-AZg@mail.gmail.com>
 <b5a91f9e-c3ff-371c-d355-4a5e8a147796@kapsi.fi> <CABb+yY3Ng+rbKRYXTncfHKv6HXBW5hHjMKDpepz31MxpE9bwRQ@mail.gmail.com>
 <a57fccaa-fcfe-6611-45a5-8c224f4ee2b6@kapsi.fi> <b3045f85-eacb-a5ec-1690-b9c63d0f3373@kapsi.fi>
From:   Jassi Brar <jassisinghbrar@gmail.com>
Date:   Thu, 9 Aug 2018 14:56:56 +0530
Message-ID: <CABb+yY3fVGX_aegHhJCNN2ftyz1NA9ejHqZrB=qbDRm+bLaY9A@mail.gmail.com>
Subject: Re: [PATCH v3 3/8] mailbox: Add transmit done by blocking option
To:     Mikko Perttunen <cyndis@kapsi.fi>
Cc:     Mikko Perttunen <mperttunen@nvidia.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jon Hunter <jonathanh@nvidia.com>,
        Devicetree List <devicetree@vger.kernel.org>,
        linux-serial@vger.kernel.org, linux-tegra@vger.kernel.org,
        <", linux-arm-kernel"@lists.infradead.org>,
        srv_heupstream <linux-mediatek@lists.infradead.org>,
        srv_heupstream <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[dropping everyone else while we discuss the code]

Thanks. I assume that branch as all the code that there is. Let me
look and get back to you.

On Thu, Aug 9, 2018 at 2:19 PM, Mikko Perttunen <cyndis@kapsi.fi> wrote:
> Here's my current code:
>
> https://github.com/cyndis/linux/commits/wip/t194-tcu-4
>
> "fixup! mailbox: tegra-hsp: Add support for shared mailboxes" splits up the
> controller into two. "tegra-hsp: use polling" changes it to use polling.
>
> There are two lines in the top patch with comments:
>
> - at the end of tegra_hsp_mailbox_send_data, I left a "while
> (!tegra_hsp_mailbox_last_tx_done(chan));". Without it I wasn't able to see
> even a few garbled characters in the output.
>
> - as mentioned, if I enable tx_block on the client side, I get a BUG:
> scheduling while atomic. I assume this gets printed through the earlycon as
> it's printing out correctly.
>
> Thanks,
> Mikko
>
>
> On 08.08.2018 17:46, Mikko Perttunen wrote:
>>
>> On 08/08/2018 05:39 PM, Jassi Brar wrote:
>>>
>>> On Wed, Aug 8, 2018 at 8:04 PM, Mikko Perttunen <cyndis@kapsi.fi> wrote:
>>>>
>>>>
>>>>
>>>> On 08/08/2018 05:10 PM, Jassi Brar wrote:
>>>>>
>>>>>
>>>>> On Wed, Aug 8, 2018 at 5:08 PM, Mikko Perttunen <cyndis@kapsi.fi>
>>>>> wrote:
>>>>>>
>>>>>>
>>>>>>
>>>>>>
>>>>>> On 04.08.2018 13:45, Mikko Perttunen wrote:
>>>>>>>
>>>>>>>
>>>>>>>
>>>>>>> On 08/03/2018 03:54 PM, Jassi Brar wrote:
>>>>>>>>
>>>>>>>>
>>>>>>>>
>>>>>>>> On Mon, Jul 2, 2018 at 5:10 PM, Mikko Perttunen
>>>>>>>> <mperttunen@nvidia.com>
>>>>>>>> wrote:
>>>>>>>>>
>>>>>>>>>
>>>>>>>>>
>>>>>>>>> Add a new TXDONE option, TXDONE_BY_BLOCK. With this option, the
>>>>>>>>> send_data function of the mailbox driver is expected to block until
>>>>>>>>> the message has been sent. The new option is used with the Tegra
>>>>>>>>> Combined UART driver to minimize unnecessary overhead when
>>>>>>>>> transmitting
>>>>>>>>> data.
>>>>>>>>>
>>>>>>>> 1) TXDONE_BY_BLOCK flag :-
>>>>>>>>            Have you tried setting the flag
>>>>>>>> mbox_chan->mbox_client->tx_block
>>>>>>>> ?
>>>>>>>
>>>>>>>
>>>>>>>
>>>>>>>
>>>>>>> No - I suppose I should have done that. I'm a bit concerned about
>>>>>>> overhead
>>>>>>> as send_data may be called thousands of times per second, so I tried
>>>>>>> to
>>>>>>> make
>>>>>>> it as close as possible to the downstream driver that just pokes the
>>>>>>> mailbox
>>>>>>> register directly.
>>>>>>
>>>>>>
>>>>>>
>>>>>>
>>>>>> I tried using polling in the mailbox framework. Some printing is done
>>>>>> from
>>>>>> atomic context so it seems tx_block cannot be used -
>>>>>> wait_for_completion_timeout understandably does not work in atomic
>>>>>> context.
>>>>>> I also tried without tx_block, in which case I got some horribly
>>>>>> garbled
>>>>>> output, but "Try increasing MBOX_TX_QUEUE_LEN" was readable there.
>>>>>>
>>>>>> Any opinions?
>>>>>>
>>>>> The problems arise because your hardware (SM) supports TXDONE_BY_POLL,
>>>>> but your client drives it by TXDONE_BY_ACK because the older DB
>>>>> channels are so.
>>>>>
>>>>> Please populate SM channels as a separate controller than DB.
>>>>> The DB controller, as is, run by ACK method.
>>>>> The SM controller should be run by polling, i.e, set txdone_poll =
>>>>> true and the poll period small enough. The virtual tty client driver
>>>>> should be able to safely set tx_block from appropriate context.
>>>>>
>>>>
>>>> Sorry, I should have clarified that I already split up the controllers.
>>>> The
>>>> SM controller has txdone_poll = true. I didn't adjust txpoll_period so I
>>>> guess it's zero.
>>>>
>>> Can you please share your code (controller and client) ? Maybe offline
>>> if you wish.
>>>
>>
>> I'll upload a git branch tomorrow -- I'm not at the machine with the code
>> now.
>>
>> Mikko
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-tegra" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
