Return-Path: <SRS0=6SfI=LH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34C93C4321D
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 15:14:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ABA8920893
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 15:14:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tEJlFzND"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ABA8920893
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727446AbeHXStp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Aug 2018 14:49:45 -0400
Received: from mail-ua1-f66.google.com ([209.85.222.66]:34861 "EHLO
        mail-ua1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726264AbeHXStp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Aug 2018 14:49:45 -0400
Received: by mail-ua1-f66.google.com with SMTP id m26-v6so4266002uap.2;
        Fri, 24 Aug 2018 08:14:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=43WYDvHLcx0fXpHNTENgKbQyforMevd73OtDbcBEhOc=;
        b=tEJlFzND0HzxNKar+cmPlh2On2B1WmNPr/PC04VWiuncTcmDBGVJ6g/ZST/UMbWF4F
         Ok3x2QBOj0d075XGqKnq1uWqtmO90XyX9Pjsz/HLwzslUHzLwotpbSCsbwMro3THZDpC
         BI/oXzfx3e60vpfXCGNYNabe49EzRqrdtA+dKKh0ozgDRi8cvwYIXwqkeNkVNA2a9Emv
         3BSzo/cyC7LM3TqYbHjkYtUNNaVS4eYypjO3hGR55jQWmZ1TnxGjGh+749KqLzNuF4lr
         10quXn/5eLPYYOf1d+zCyoTy/pO3BYVsric/d4Ru/1X0G1CWnJsTc9WNzERpQk/LZF+7
         CGFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=43WYDvHLcx0fXpHNTENgKbQyforMevd73OtDbcBEhOc=;
        b=B8C7mkcYcwFYyILP763tnZhzz+paBtLg+pVIYqwsgRALaOW7UmgMU99GDG/0XYC0Mx
         fCyI2f/uY5TbC9SfR6ftmkM6ZZnn+Ujc+jAJk+g2ow3ha2Prym2RqCDYuUS24M3LkrSs
         AUD3lkq/TfmppHmqKF4OxF3nXvwxWh2YT1JrdPBs3S6x8kzBNxsUIPXMVSBuhwSCKEpX
         bX8yzrW+vaVNlSzwCmXUs8o8wt42nx3RzaKrPFeuwVsQzXXFZZT9rbt+BiaRk0KnA8/M
         OILsdidkvKidvkDhlTvhhjIjZrHtZh4VKfTR/ZU9RHNJr0pjVR/NJY0GoZSazkcPRz5Q
         +t/g==
X-Gm-Message-State: APzg51CXeoP5rB2rLWbzpvZmGDVr5Vi2Bu7EAaHgJw0I+DVO2feVmfpF
        wzhvSfT/F9KFDhqDduE0uwTIdYZ3Lrk9qbOg95jJBw==
X-Google-Smtp-Source: ANB0VdYlF5oxvWFT1YQrZhf39eNbgOPzT0X3nOrawFOtdY63erhaXRK54Eh6OU3Ul3rcUj/mJM2YT9lL9gMI0/KTxpA=
X-Received: by 2002:ab0:48a4:: with SMTP id x33-v6mr1373580uac.138.1535123679205;
 Fri, 24 Aug 2018 08:14:39 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ab0:5e5c:0:0:0:0:0 with HTTP; Fri, 24 Aug 2018 08:14:38
 -0700 (PDT)
In-Reply-To: <68a800c7-446e-9b6b-1847-6e45a1d17262@arm.com>
References: <1531762009-15112-1-git-send-email-tbaicar@codeaurora.org>
 <20180719140102.GB25185@nazgul.tnic> <94e3a0fb-9b7d-045f-733b-9f063dcb39e4@arm.com>
 <45fefe7d-c6ea-5791-4477-13ecce39ce48@codeaurora.org> <b568fdcc-ca39-67ea-2799-8ed246c8ffb6@arm.com>
 <CABo9ajA7SPrVE-oiG=RicH+nL9_pp7fVATCdMugY5fuNAPzHaQ@mail.gmail.com> <68a800c7-446e-9b6b-1847-6e45a1d17262@arm.com>
From:   Tyler Baicar <baicar.tyler@gmail.com>
Date:   Fri, 24 Aug 2018 11:14:38 -0400
Message-ID: <CABo9ajAvo-bskhrM8h95Y9D4U88zFUZfVW_HTMLK3o_5Q1VSUw@mail.gmail.com>
Subject: Re: [RFC PATCH] EDAC, ghes: Enable per-layer error reporting for ARM
To:     James Morse <james.morse@arm.com>
Cc:     Tyler Baicar <tbaicar@codeaurora.org>, wufan@codeaurora.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        harba@qti.qualcomm.com, Borislav Petkov <bp@alien8.de>,
        mchehab@kernel.org,
        arm-mail-list <linux-arm-kernel@lists.infradead.org>,
        linux-edac@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 24, 2018 at 5:48 AM, James Morse <james.morse@arm.com> wrote:
> On 23/08/18 16:46, Tyler Baicar wrote:
>> On Thu, Aug 23, 2018 at 5:29 AM James Morse <james.morse@arm.com> wrote:
>>> On 19/07/18 19:36, Tyler Baicar wrote:
>>>> This seems pretty hacky to me, so if anyone has other suggestions please share
>>>> them.
>>>
>>> CPER's "Memory Error Record 2" thinks that "NODE, CARD and MODULE should provide
>>> the information necessary to identify the failing FRU". As EDAC has three
>>> 'levels', these are what they should correspond to for ghes-edac.
>>>
>>> I assume NODE means rack/chassis in some distributed system. Lets ignore it as
>>> it doesn't seem to map to anything in the SMBIOS table.
>>
>> I believe NODE should map to socket number for multi-socket systems.
>
> Isn't the Memory Array Structure still unique in a multi-socket system? If so
> the node isn't telling us anything new.

Yes, the Memory Array structure in SMBIOS is still unique, but the NODE value
is needed in NODE, CARD, MODULE because the CARD number here typically
maps to channel number which each socket has their own channel numbers.

(i.e. socket 0 can have channel 0 and socket 1 can have a channel 0)

> Do sockets show up in the SMBIOS table? We would need to know how many there are
> in advance. For arm systems the cpu topology from PPTT is the best bet for this
> information, but what do we do if that table is missing? (also, does firmware
> count from 1 or 0?) I suspect we can't use this field unless we know what the
> range of values is going to be in advance.

An Fan mentioned in his response, what the customers really care about
is mapping to
a particular DIMM since that is what they can replace. To do this, the
Memory Device
handle should be enough since those are all unique regardless of
Memory Array handle
and which socket the DIMM is on. The Firmware I've worked with counts
from 0, but I'm
not sure if that is required. That won't matter if we just use the
Memory Device handle.

>> I think the proper way to get this working would be to use these handles. We can
>> avoid populating this layer information and instead have a mapping of type 17
>> index number (how edac is numbering the DIMMs today) to the handle number.
>
> Why get avoid the layer stuff? Isn't counting DIMM/memory-devices what
> EDAC_MC_LAYER_SLOT is for?

The problem with the layer reporting is that you need to know all the
layer information
as Fan mentioned. SoCs can support multiple board combinations (ie
1DPC vs. 2DPC)
and there is no standardized way of knowing whether you are booted on a 1DPC or
2DPC board.

>> Then we will need a new function to increment the counter based on the handle
>> number rather than this layer information. Is that how you are envisioning it?
>
> I'm not familiar with edac's internals, so I didn't have any particular vision!
>
> Isn't the problem that ghes_edac_report_mem_error() does this:
> |       e->top_layer = -1;
> |       e->mid_layer = -1;
> |       e->low_layer = -1;

The other problem is that the sysfs nodes are all setup with a single
layer representing
all of the memory on the board.

https://elixir.bootlin.com/linux/latest/source/drivers/edac/ghes_edac.c#L469

So the DIMM counters exposed in sysfs are all under a single memory
controller and just
numbered from 0 to n-1 based on the order in which the type 17 SMBIOS
entries show up
in the DMI walk.

> so edac_raw_mc_handle_error() has no clue where the error happened. (I haven't
> read what it does with this information yet).
>
> ghes_edac_report_mem_error() does check CPER_MEM_VALID_MODULE_HANDLE, and if its
> set, it uses the handle to find the bank/device strings and prints them out.

Yes, I think this is where we need to add support to increment the
count based on that module
handle.

> Naively I thought we could generate some index during ghes_edac_count_dimms(),
> and use this as e->${whichever}_layer. I hoped there would be something we could
> already use as the index, but I can't spot it, so this will be more than the
> one-liner I was hoping for!

We could use what ghes_edac_register does by setting up a single layer
with all memory and
then keep a map of which module handle maps to which index into that
layer. From that it would
be easy to increment the proper sysfs exposed DIMM counters using the
single layer (that way
we can probably avoid the custom increment function I eluded to in my
previous response).

Thanks,
Tyler
