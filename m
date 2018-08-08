Return-Path: <SRS0=X6pY=KX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72C23C4646D
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 14:10:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 23D3F217B4
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 14:10:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eNdOrtOv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 23D3F217B4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727404AbeHHQaE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Aug 2018 12:30:04 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:44790 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727050AbeHHQaD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Aug 2018 12:30:03 -0400
Received: by mail-ed1-f68.google.com with SMTP id f23-v6so1311354edr.11;
        Wed, 08 Aug 2018 07:10:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=3K57tYUk11S7OC3pkkE7sadcHDy40WLoqhGzTiZe7Ps=;
        b=eNdOrtOvpXLVVDySagre4DfK80L1aKe0PxgnZW3dPaJ0p6mJPCRzh/p40/JJ01MLJp
         jTF90DvDFkZ/TdSD+BUrNPMIOy20T3OR2NyFe4adOPuwlCgOrQEaTd7b2UYnZ+s1K4K7
         VppEAWV1ikZSibepRFo51czw9qsXLHgUiEd3e0wdIf373G7RfYUFcoFwBnO2x+fA3bd3
         Wa9MJ8TvrLQjx3FRl1ZKg/eHlogSZ8s/enAeauVuLxiBWi7l46H9HkBdbNdQjAC3nyfR
         Br/Ys6x3C/rLIc4J+BDn59ox5/zOb44cxNpQMXfSYK/KwW/Fii6w1Z8etKqwxF9B4RHf
         gPig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=3K57tYUk11S7OC3pkkE7sadcHDy40WLoqhGzTiZe7Ps=;
        b=j6OdRn7douUv0/KaRXfrkndOItU8APAbXKWjLBSxJNFmDjZ2sZ2N0XkMGA4Sybdgqh
         5NvAAp8TRctuA8rRj+RMz/ddWksJB29pjm/ck0CWQRSzqcmJEG+83qitEMf3RVes74mY
         qv9OceOAuGb7EIDQ4fLGWluV6cnT7HkZdVVEX7KTzJZSV9kR9ijTK3FQQnvxZGFhEx4j
         x9rQKj/e46c/2xJVc+PJkvchNQxfjqJf2bWgZ9HKHGKjUrD512WSyQR3osQY/bHFI5jJ
         oTKw1OcFHkrrTDE+Ax5ewpFeq9cBfwfnB2BtVc3lNluwggKa9v+CnwwTQCbjV5q+r4kG
         5lSg==
X-Gm-Message-State: AOUpUlECxGFLvowwtAEYql7LaIxQaav/Njt9UKq8KZrxeacNp5DYNmse
        6Or8iwxwIImvvNfz1UcXVWYJqNi04usunTL0X7M=
X-Google-Smtp-Source: AA+uWPypbOpTTb0+ONsddMWgRrdpW7RSAZwv5bj4MV9N58LUWl1plIqSBj+mBKYEbqcF0Srp7WZRqT7wrJ1TftsO0HI=
X-Received: by 2002:a50:8921:: with SMTP id e30-v6mr3474321ede.213.1533737411941;
 Wed, 08 Aug 2018 07:10:11 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a50:f68b:0:0:0:0:0 with HTTP; Wed, 8 Aug 2018 07:10:11 -0700 (PDT)
In-Reply-To: <afc8a305-79ea-2194-0af0-919bbb8f675e@kapsi.fi>
References: <20180702114033.15654-1-mperttunen@nvidia.com> <20180702114033.15654-4-mperttunen@nvidia.com>
 <CABb+yY0_dKC_cYFwwb-aeRgrx=sjv=8VLP=C6DJEecFf=v+mkQ@mail.gmail.com>
 <907bac36-0c54-8f38-0f5e-f59196d414c6@kapsi.fi> <afc8a305-79ea-2194-0af0-919bbb8f675e@kapsi.fi>
From:   Jassi Brar <jassisinghbrar@gmail.com>
Date:   Wed, 8 Aug 2018 19:40:11 +0530
Message-ID: <CABb+yY2mpNV186=M2anmZANgMOra4JM7ybyUT4yCxhqAG6-AZg@mail.gmail.com>
Subject: Re: [PATCH v3 3/8] mailbox: Add transmit done by blocking option
To:     Mikko Perttunen <cyndis@kapsi.fi>
Cc:     Mikko Perttunen <mperttunen@nvidia.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jon Hunter <jonathanh@nvidia.com>,
        Devicetree List <devicetree@vger.kernel.org>,
        linux-serial@vger.kernel.org, linux-tegra@vger.kernel.org,
        <", linux-arm-kernel"@lists.infradead.org>,
        ", linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, srv_heupstream" 
        <linux-mediatek@lists.infradead.org>,
        srv_heupstream <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 8, 2018 at 5:08 PM, Mikko Perttunen <cyndis@kapsi.fi> wrote:
>
>
> On 04.08.2018 13:45, Mikko Perttunen wrote:
>>
>> On 08/03/2018 03:54 PM, Jassi Brar wrote:
>>>
>>> On Mon, Jul 2, 2018 at 5:10 PM, Mikko Perttunen <mperttunen@nvidia.com>
>>> wrote:
>>>>
>>>> Add a new TXDONE option, TXDONE_BY_BLOCK. With this option, the
>>>> send_data function of the mailbox driver is expected to block until
>>>> the message has been sent. The new option is used with the Tegra
>>>> Combined UART driver to minimize unnecessary overhead when transmitting
>>>> data.
>>>>
>>> 1) TXDONE_BY_BLOCK flag :-
>>>          Have you tried setting the flag mbox_chan->mbox_client->tx_block
>>> ?
>>
>>
>> No - I suppose I should have done that. I'm a bit concerned about overhead
>> as send_data may be called thousands of times per second, so I tried to make
>> it as close as possible to the downstream driver that just pokes the mailbox
>> register directly.
>
>
> I tried using polling in the mailbox framework. Some printing is done from
> atomic context so it seems tx_block cannot be used -
> wait_for_completion_timeout understandably does not work in atomic context.
> I also tried without tx_block, in which case I got some horribly garbled
> output, but "Try increasing MBOX_TX_QUEUE_LEN" was readable there.
>
> Any opinions?
>
The problems arise because your hardware (SM) supports TXDONE_BY_POLL,
but your client drives it by TXDONE_BY_ACK because the older DB
channels are so.

Please populate SM channels as a separate controller than DB.
The DB controller, as is, run by ACK method.
The SM controller should be run by polling, i.e, set txdone_poll =
true and the poll period small enough. The virtual tty client driver
should be able to safely set tx_block from appropriate context.
