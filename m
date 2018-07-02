Return-Path: <SRS0=/0sc=JS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8737AC6778A
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 16:03:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3C24B254DA
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 16:03:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JIMYB/dc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3C24B254DA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752706AbeGBQDW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Jul 2018 12:03:22 -0400
Received: from mail-lf0-f67.google.com ([209.85.215.67]:37342 "EHLO
        mail-lf0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752491AbeGBQDV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jul 2018 12:03:21 -0400
Received: by mail-lf0-f67.google.com with SMTP id j8-v6so2827875lfb.4
        for <linux-kernel@vger.kernel.org>; Mon, 02 Jul 2018 09:03:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=KmG0p9Q9on3DNTSjXyEOm1BaBeY816qYMhHbgU8xZq8=;
        b=JIMYB/dc/zRQ0JGPuAY+F/uHIXoy0jvTUR7aNkqhCse9zXxAKUZqlUVCjB+a9UDRAE
         VJYC5DsBpia5Fd6Aq1JzwP/GhJBj6V2F3CYFTDDb5Lf4ri8GBTsBIZuDVPamJCzIeVlx
         DKZQjGgxEcoyAbw/ROmKfgq54XjZY+P5HcisNlZrWpYQAN8+UgdOSw/+h40/28D/uIR6
         SWAyz1yM1ea4sUQplw4DgirTGLVSKE7mAOaA4ZRpQpLy5UNrkFw5nUBTmerazeHObuVs
         G2QnOsOWzLr1XxsZ4Ehm7c1nieosdQhoYrPDtNu19SB00mdlKb07WL1SwX+W/kVNjdhF
         hriQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=KmG0p9Q9on3DNTSjXyEOm1BaBeY816qYMhHbgU8xZq8=;
        b=dU4NNaynKQ58yDSWN/Y2g+XPjNT8L7moJWDcr+d6lMedfixmAWVYu/4iWmaMfgbs7N
         Z5ZzFHDpRnC7xqtD2H30qS4BPqX8a7/j5qzkuXFG1B/S/dK1najYqLUf/VDVxAtJD7D1
         IOwUWVGO3DYZIW6MyQyrKubCL5Gok5JBGOy48l/upGy9bzDXu1Dtn5GRPAn2JBcJHjTd
         Mw/PUBo3f/CIFJBtx5sSVje2d+I6e5VPWiitPxjR3WZhnK26hXO42/CQZhjZ8Tljdlni
         1IEoiHKo9b9HXCpVWs0SrELZi/huzMX059IZFIhKpWW/tKoHM4SnetGE3oaXyYIFORgm
         VZHQ==
X-Gm-Message-State: APt69E3l3Lz2T5lD3+/RSiFCuOjECrGeYm4FlTw8bxYoizfd3Yq9bdwq
        NEeGVsjQqe6/RNeLpF1Q+fi83U2kRaCPZUfi3mo=
X-Google-Smtp-Source: AAOMgpfnKYiEmK9iF2J3BDN0rL56j77H3YeBs8Kqab9/vhEsb6gB7mf7zAFqjFDOJVz6W8gYMZ606b4wut65f5Feprw=
X-Received: by 2002:a19:a111:: with SMTP id k17-v6mr17934258lfe.60.1530547400193;
 Mon, 02 Jul 2018 09:03:20 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a19:2b14:0:0:0:0:0 with HTTP; Mon, 2 Jul 2018 09:03:19 -0700 (PDT)
In-Reply-To: <CAFqt6zYX-BsGsTHzEzWHWTLGA=7VtSMWYy7w8dBx+hTzxyhyfw@mail.gmail.com>
References: <20180521181704.GA19646@jordon-HP-15-Notebook-PC>
 <CAFqt6zZdb5+32CvvU_4Pmb1u-d15-iAFb3ab0ftBLP95257Z-Q@mail.gmail.com> <CAFqt6zYX-BsGsTHzEzWHWTLGA=7VtSMWYy7w8dBx+hTzxyhyfw@mail.gmail.com>
From:   Souptick Joarder <jrdr.linux@gmail.com>
Date:   Mon, 2 Jul 2018 21:33:19 +0530
Message-ID: <CAFqt6zYKOaieNEQE3TrXLoh9uXwcWH496EyuT_Tuyf8nZ1zd=w@mail.gmail.com>
Subject: Re: [PATCH v2] char: agp: Change return type to vm_fault_t
To:     airlied@linux.ie, Arnd Bergmann <arnd@arndb.de>,
        Greg KH <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, Matthew Wilcox <willy@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 18, 2018 at 5:07 PM, Souptick Joarder <jrdr.linux@gmail.com> wrote:
> On Thu, May 31, 2018 at 10:38 AM, Souptick Joarder <jrdr.linux@gmail.com> wrote:
>> On Mon, May 21, 2018 at 11:47 PM, Souptick Joarder <jrdr.linux@gmail.com> wrote:
>>> Use new return type vm_fault_t for fault handler. For now,
>>> this is just documenting that the function returns a
>>> VM_FAULT value rather than an errno. Once all instances are
>>> converted, vm_fault_t will become a distinct type.
>>>
>>> Ref-> commit 1c8f422059ae ("mm: change return type to
>>> vm_fault_t") was added in 4.17-rc1 to introduce the new
>>> typedef vm_fault_t. Currently we are making change to all
>>> drivers to return vm_fault_t for page fault handlers. As
>>> part of that char/agp driver is also getting changed to
>>> return vm_fault_t type from fault handler.
>>>
>>> Signed-off-by: Souptick Joarder <jrdr.linux@gmail.com>
>>> Reviewed-by: Matthew Wilcox <mawilcox@microsoft.com>
>>> ---
>>>  drivers/char/agp/alpha-agp.c | 2 +-
>>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/char/agp/alpha-agp.c b/drivers/char/agp/alpha-agp.c
>>> index 53fe633..c9bf2c2 100644
>>> --- a/drivers/char/agp/alpha-agp.c
>>> +++ b/drivers/char/agp/alpha-agp.c
>>> @@ -11,7 +11,7 @@
>>>
>>>  #include "agp.h"
>>>
>>> -static int alpha_core_agp_vm_fault(struct vm_fault *vmf)
>>> +static vm_fault_t alpha_core_agp_vm_fault(struct vm_fault *vmf)
>>>  {
>>>         alpha_agp_info *agp = agp_bridge->dev_private_data;
>>>         dma_addr_t dma_addr;
>>> --
>>> 1.9.1
>>>
>>
>> Any comment for this patch ?
>
> Any further comment on this patch ?

Greg, Can we get this patch in queue for 4.19 ?
