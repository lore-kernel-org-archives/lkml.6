Return-Path: <SRS0=eGoB=KA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A711ECDFB3
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 21:28:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1B36F20647
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 21:28:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="o3vRzYjs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1B36F20647
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730079AbeGPV5m (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Jul 2018 17:57:42 -0400
Received: from mail-yw0-f195.google.com ([209.85.161.195]:36720 "EHLO
        mail-yw0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728413AbeGPV5l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jul 2018 17:57:41 -0400
Received: by mail-yw0-f195.google.com with SMTP id v197-v6so2304044ywg.3
        for <linux-kernel@vger.kernel.org>; Mon, 16 Jul 2018 14:28:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=d53myzn0QbaJyHytaN8vLBqiiC4WT1n54JmZmVJ/TVo=;
        b=o3vRzYjsU+58h1Ulw+ZghlW6gMPsj9TG6SPTdwauFc116l8L+OotC614SQIoNKbvem
         fwL17SMemboqAy/T8M2zHxeTknqY68uPhB0it5WjFSQ8xEUPZKBus9hoIjXoq2rb2Qbx
         tLKKeqUfBXt2tFf7NrESu4nvQ7RiacZmYxGV9VMhdISS21obD5DsjalOCO/+rV5U6MWs
         LGLnCaCKDCa2qN9PbJNbpbZldHVeB+yUJWapSWM87l+Pk941u93wXrzhcRWg0rj/PZP3
         QxQ9xQgoxpnM1gRLSSgt2l71K02Ej3GGM6DNr8sfGv84f/BKIPMLWl7ZPZCUXLer3v48
         GDhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=d53myzn0QbaJyHytaN8vLBqiiC4WT1n54JmZmVJ/TVo=;
        b=Mj9bPMgTO9/whDHJ6fjkko5FTitvxJOO3ezKkFqEG+bQXlT88GRyEX3SkF7O5IHO87
         v6mnPDi/QHKCcjSLMjS+s3xo2lRzNeqMnrU23A/xHjVUaF7a/tPynLehrb0I/rzkzHiS
         TOfaEN7wq3JKuChC5s9RJs0tXWbtqSkuRRIRGhz9rX7vRMaExEMkGFetVEs+FV6j6sRV
         XG8c3ipvCOTXg8cqsC/xNc3+cwESxVQtOnfl5fqr9xGn4Jr2py56oJm6q9Q6jVOzlkRG
         DXNBFDK/8Bb2NIc7IehxDi3+Iz0NiXa4FwuavC5CR++OSxxjDeXIUey99Ksd6QwUVb5u
         y23A==
X-Gm-Message-State: AOUpUlFr2zPaV1LWJzoYHqLczbFlb4p1VYNfba3+PDSP7fcxWgqAMgCY
        9ZtD56k+vxraKDLLETK7qLNeR9VrDEsbHoZt7gU=
X-Google-Smtp-Source: AAOMgpe80m44q4yhWXLm+EP2ioZ6Ej5T/AdLh8xIW0ZzTWA1lxX6C7nt+6qifYn0D17vLwWteXYZcHPWyzNAZWQrhig=
X-Received: by 2002:a81:8c1:: with SMTP id 184-v6mr8955333ywi.126.1531776505445;
 Mon, 16 Jul 2018 14:28:25 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a25:5e42:0:0:0:0:0 with HTTP; Mon, 16 Jul 2018 14:28:24
 -0700 (PDT)
In-Reply-To: <20180714063904.GH20451@kroah.com>
References: <20180714055816.223754-1-toddpoynor@gmail.com> <20180714055816.223754-14-toddpoynor@gmail.com>
 <20180714063904.GH20451@kroah.com>
From:   Todd Poynor <toddpoynor@gmail.com>
Date:   Mon, 16 Jul 2018 14:28:24 -0700
Message-ID: <CAO3upoaJ8R9svW1kTOu6aGdRpPzjM0i6+YL0YV29xCDwvgSqjA@mail.gmail.com>
Subject: Re: [PATCH 13/18] staging: gasket: gasket_enable_dev fixups
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Rob Springer <rspringer@google.com>,
        John Joseph <jnjoseph@google.com>,
        Ben Chan <benchan@chromium.org>, devel@driverdev.osuosl.org,
        Zhongze Hu <frankhu@chromium.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Simon Que <sque@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        Todd Poynor <toddpoynor@google.com>,
        Dmitry Torokhov <dtor@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 13, 2018 at 11:39 PM, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
> On Fri, Jul 13, 2018 at 10:58:11PM -0700, Todd Poynor wrote:
>> From: Todd Poynor <toddpoynor@google.com>
>>
>> Remove unnecessary variable.
>>
>> Bail out if no physical device.
>>
>> Signed-off-by: Todd Poynor <toddpoynor@google.com>
>> ---
>>  drivers/staging/gasket/gasket_core.c | 19 ++++++-------------
>>  1 file changed, 6 insertions(+), 13 deletions(-)
>>
>> diff --git a/drivers/staging/gasket/gasket_core.c b/drivers/staging/gasket/gasket_core.c
>> index 65aa7cf454fb..f7d8f66e8746 100644
>> --- a/drivers/staging/gasket/gasket_core.c
>> +++ b/drivers/staging/gasket/gasket_core.c
>> @@ -915,8 +915,6 @@ static int gasket_enable_dev(
>>  {
>>       int tbl_idx;
>>       int ret;
>> -     bool has_dma_ops;
>> -     struct device *ddev;
>>       const struct gasket_driver_desc *driver_desc =
>>               internal_desc->driver_desc;
>>
>> @@ -934,26 +932,21 @@ static int gasket_enable_dev(
>>               return ret;
>>       }
>>
>> -     has_dma_ops = true;
>> +     if (!gasket_dev->pci_dev) {
>> +             gasket_log_error(gasket_dev,
>> +                              "%s: no physical device", __func__);
>> +             return -ENODEV;
>> +     }
>
> How can this ever be true?  I don't see where this can be removed to
> enable this error check to be hit.  What am I missing?

Agree, I'll split this into two patches for the two things it does,
and just remove the unnecessary check.  Thanks,

>
> thanks,
>
> greg k-h



-- 
Todd
