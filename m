Return-Path: <SRS0=X6pY=KX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AADBC46470
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 14:39:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7D47B214FE
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 14:39:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="p3rxpHsq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7D47B214FE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727410AbeHHQ7Q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Aug 2018 12:59:16 -0400
Received: from mail-ed1-f50.google.com ([209.85.208.50]:46736 "EHLO
        mail-ed1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726875AbeHHQ7Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Aug 2018 12:59:16 -0400
Received: by mail-ed1-f50.google.com with SMTP id o8-v6so1355718edt.13;
        Wed, 08 Aug 2018 07:39:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=wFvJoD2zt0ssWKLR+WZ6A5JcLvcgfN2ruGKJXyUC4rI=;
        b=p3rxpHsqtu0Q0QZ1zZgxgzEOOrl0NCpy5yDl3q4n5zAYKOY7UmDXnAJMXquA7lXgrU
         UPDPTOtHkUa8Gorqu+1cdmYNXV6kugwDDLFGZ5/h26pdyALgtz0CpvfZB3JRFUWn06wC
         bLxwWOkxVqnZMU4NdJ2S52YE6ZPFxTsU962se1ftAb3PBHPiL7p9/wTJ1TLDHIk+VR9L
         2FbrRngTn9mjV1xMc16rcazr4WIOFaD7YPKjrFYHAghyszIVBNxtEjyYJ0K4vxC/4n4O
         zykHd1ajpKZel42fq5veGwqH+d11RGUuqCu42HavPXg+dl/KHmrGfWLjK51qzRB9wD3j
         CrVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=wFvJoD2zt0ssWKLR+WZ6A5JcLvcgfN2ruGKJXyUC4rI=;
        b=AdJ+a2ZMHlqOld8+YUWnVWQ57yfzi+pZVY4q+54KsxIGiP2p9kErbNiR+KZcAIaQzf
         /6L6JoqF2tQK0DYHwHidyqGxB8uYRTBkdCjUok0qats+qkfojBN0K6l5XctfTWdkEzY2
         9LEKYC1/+GfxNK5icVvuNvUhbTBESrg1V5hCofH5l4JKxPWU0gafZz+ZDmNE9XGsDDuI
         XVYP9lTM4kvBf0y8RoWTwJEtCeBWdHWPIIyNDvIv7KaSoGb6K+aKU1lnhWLfi8fdD7wG
         WARyUOAmQnVlD5jqVRxFCsJLD8O77V+I6LT5lnMhbXfHBKM4KhNb7LoJSBSeOKQXgUgA
         tTtA==
X-Gm-Message-State: AOUpUlF+HhjelYlHrrzEwwl66cD+qEHaurnFk+8bSPuNeZ7wRtJSZ9f3
        dK54xCFDJ7qwEPko0S5tXyB1TID2bm6vLSppof0=
X-Google-Smtp-Source: AA+uWPzjDlK5W36lM44IM1JSDAMxfUD2Rz0D5fkeg6gKwUkauOhAPEaFD/TyEKGrCmx3WZpFDLbB0hQfayl31vTcFOg=
X-Received: by 2002:a50:af03:: with SMTP id g3-v6mr3526054edd.220.1533739156985;
 Wed, 08 Aug 2018 07:39:16 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a50:f68b:0:0:0:0:0 with HTTP; Wed, 8 Aug 2018 07:39:16 -0700 (PDT)
In-Reply-To: <b5a91f9e-c3ff-371c-d355-4a5e8a147796@kapsi.fi>
References: <20180702114033.15654-1-mperttunen@nvidia.com> <20180702114033.15654-4-mperttunen@nvidia.com>
 <CABb+yY0_dKC_cYFwwb-aeRgrx=sjv=8VLP=C6DJEecFf=v+mkQ@mail.gmail.com>
 <907bac36-0c54-8f38-0f5e-f59196d414c6@kapsi.fi> <afc8a305-79ea-2194-0af0-919bbb8f675e@kapsi.fi>
 <CABb+yY2mpNV186=M2anmZANgMOra4JM7ybyUT4yCxhqAG6-AZg@mail.gmail.com> <b5a91f9e-c3ff-371c-d355-4a5e8a147796@kapsi.fi>
From:   Jassi Brar <jassisinghbrar@gmail.com>
Date:   Wed, 8 Aug 2018 20:09:16 +0530
Message-ID: <CABb+yY3Ng+rbKRYXTncfHKv6HXBW5hHjMKDpepz31MxpE9bwRQ@mail.gmail.com>
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

On Wed, Aug 8, 2018 at 8:04 PM, Mikko Perttunen <cyndis@kapsi.fi> wrote:
>
>
> On 08/08/2018 05:10 PM, Jassi Brar wrote:
>>
>> On Wed, Aug 8, 2018 at 5:08 PM, Mikko Perttunen <cyndis@kapsi.fi> wrote:
>>>
>>>
>>>
>>> On 04.08.2018 13:45, Mikko Perttunen wrote:
>>>>
>>>>
>>>> On 08/03/2018 03:54 PM, Jassi Brar wrote:
>>>>>
>>>>>
>>>>> On Mon, Jul 2, 2018 at 5:10 PM, Mikko Perttunen <mperttunen@nvidia.com>
>>>>> wrote:
>>>>>>
>>>>>>
>>>>>> Add a new TXDONE option, TXDONE_BY_BLOCK. With this option, the
>>>>>> send_data function of the mailbox driver is expected to block until
>>>>>> the message has been sent. The new option is used with the Tegra
>>>>>> Combined UART driver to minimize unnecessary overhead when
>>>>>> transmitting
>>>>>> data.
>>>>>>
>>>>> 1) TXDONE_BY_BLOCK flag :-
>>>>>           Have you tried setting the flag
>>>>> mbox_chan->mbox_client->tx_block
>>>>> ?
>>>>
>>>>
>>>>
>>>> No - I suppose I should have done that. I'm a bit concerned about
>>>> overhead
>>>> as send_data may be called thousands of times per second, so I tried to
>>>> make
>>>> it as close as possible to the downstream driver that just pokes the
>>>> mailbox
>>>> register directly.
>>>
>>>
>>>
>>> I tried using polling in the mailbox framework. Some printing is done
>>> from
>>> atomic context so it seems tx_block cannot be used -
>>> wait_for_completion_timeout understandably does not work in atomic
>>> context.
>>> I also tried without tx_block, in which case I got some horribly garbled
>>> output, but "Try increasing MBOX_TX_QUEUE_LEN" was readable there.
>>>
>>> Any opinions?
>>>
>> The problems arise because your hardware (SM) supports TXDONE_BY_POLL,
>> but your client drives it by TXDONE_BY_ACK because the older DB
>> channels are so.
>>
>> Please populate SM channels as a separate controller than DB.
>> The DB controller, as is, run by ACK method.
>> The SM controller should be run by polling, i.e, set txdone_poll =
>> true and the poll period small enough. The virtual tty client driver
>> should be able to safely set tx_block from appropriate context.
>>
>
> Sorry, I should have clarified that I already split up the controllers. The
> SM controller has txdone_poll = true. I didn't adjust txpoll_period so I
> guess it's zero.
>
Can you please share your code (controller and client) ? Maybe offline
if you wish.
