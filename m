Return-Path: <SRS0=cKeY=I6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 7C3B5C433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 17:01:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 32563208B4
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 17:01:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rwXAswb4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 32563208B4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934959AbeFLRBv (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Jun 2018 13:01:51 -0400
Received: from mail-vk0-f68.google.com ([209.85.213.68]:36625 "EHLO
        mail-vk0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934877AbeFLQxE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jun 2018 12:53:04 -0400
Received: by mail-vk0-f68.google.com with SMTP id o138-v6so14808941vkd.3;
        Tue, 12 Jun 2018 09:53:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=wpLzMSBL1xZqq2orn8uFXDye/DbTjPB27NZ5MMlQA3I=;
        b=rwXAswb4Bumm+r+gt5+6pLpLfF0bFMJbTY93YhBRIvXxgBisMwzGbc7N6R2m2xP9wR
         p+T+Zo+R0EFHqJGBFg7/LUnllrmKWVbAMj/lDdRVePDKP6LiNjrjhsT5It7yxylJqjKR
         HtiTnRPRbVYhCJdZBKrsRvhzybV0NSD/ulGu5yoQZw6anZdVD9YAMjEOs1Zkcjk0mb4f
         Ix0XDiXiQ8tM8MYT//Cl+0zTrbwqziTaMSXyFiEmij/sGdRm0HiN6vf9hYN8FzZf/lSG
         2iC0qt3LpE09eU9Mzhq6y0rqLy2Zzk62RvGEyPH+LX3RBUEe1MWJwZQgoqqJDc8GUV/I
         9Lmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=wpLzMSBL1xZqq2orn8uFXDye/DbTjPB27NZ5MMlQA3I=;
        b=GVrAzinZpJ50+nqic7InULHdTDe8G876HuOdwP1+6Ldlm/EbzFEtSj4kvY3RshnCNw
         m++f1ArHPXqj+/iUnDeZ5YpPTEQTmnFcuK//BgUYy/mgPB4fDI4TklKi9M092kKliE2Z
         Op+J0n16c7UTkyaZVn99pPRFzc1THZb0ZDveLikrCSOb/udYRtRfltynU9e3fdLo/ftc
         gkP2knOd+vP4kQcXC7Z6Afp+HspA4R+gYzqy50Z6B3VsAsSZdZedoZKFLT0Etfwfc3Xb
         8R6NxKeBBeIF7HSBSDsLEYmKHpz3Hh/yWAO0J496/oT85FpD3ZlTkFoPu9NOOHTnOIMU
         Mm+A==
X-Gm-Message-State: APt69E0t7H2f6GISFTrYo0EG7JiToe7jxfMBQN97Atr+SJPNilmTvrCl
        JHDpp73HFytJfiSZlhi/vH/t4soMmwsuMBQ5sRvFJxEcvYw=
X-Google-Smtp-Source: ADUXVKJsscgt2kPbIWQfSoMZkRpAXeIMFeemtPMPbvpkEgFYCS9D5HvlrG4c8PQcY3P/0Bmllgjk6EQYZ9qHmrfjjZM=
X-Received: by 2002:a1f:d1c5:: with SMTP id i188-v6mr782936vkg.131.1528822384031;
 Tue, 12 Jun 2018 09:53:04 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a67:8b02:0:0:0:0:0 with HTTP; Tue, 12 Jun 2018 09:53:03
 -0700 (PDT)
In-Reply-To: <53ef03b26a17738dc1465ce85562c9611ad415f8.camel@kernel.crashing.org>
References: <23be2945b593a36d8fa1970bb579389c0f892a3e.camel@kernel.crashing.org>
 <CAHp75VfJNrviiiam9p49+6_oSjW+YH8vwjcZ2hn5Ux5mHgDCQw@mail.gmail.com> <53ef03b26a17738dc1465ce85562c9611ad415f8.camel@kernel.crashing.org>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Tue, 12 Jun 2018 19:53:03 +0300
Message-ID: <CAHp75Vcdaejn=eq740YNdscSv9zX9xj3RzYp=AFs8HFprw34_Q@mail.gmail.com>
Subject: Re: [PATCH] drivers/of: Add devm_of_iomap()
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc:     devicetree <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 12, 2018 at 1:28 PM, Benjamin Herrenschmidt
<benh@kernel.crashing.org> wrote:
> On Tue, 2018-06-12 at 11:35 +0300, Andy Shevchenko wrote:
>> On Tue, Jun 12, 2018 at 3:01 AM, Benjamin Herrenschmidt
>> <benh@kernel.crashing.org> wrote:
>> > There are still quite a few cases where a device might want to get to a
>> > different node of the device-tree, obtain the resources and map them.
>> >
>> > Drivers doing that currently open code the whole thing, which is error
>> > proe.
>>
>> prone
>>
>> >
>> > We have of_iomap() and of_io_request_and_map() but they both have shortcomings,
>> > such as not returning the size of the resource found (which can be necessary)
>> > and not being "managed".
>> >
>> > This adds a devm_of_iomap() that provides all of these and should probably
>> > replace uses of the above in most drivers.
>>
>> It feels like a wrong approach.
>> Can OF graph help here? Would it be better approach?
>
> I don't quite understand what your objection is nor what "OF graph"
> is...

There is no objection per se, just a doubt that this is a right thing to do.
I might be wrong, of course.

OF graph nodes is a special API that allows you to access like you
said "different node of device-tree".
https://elixir.bootlin.com/linux/latest/source/Documentation/devicetree/bindings/graph.txt

> This is a direct replacement for the open coded equivalent that a
> number of drivers do, almost always without using devm_* or forgetting
> to request the resources etc... Ie, a less bug-prone tool in the
> toolbox.
>
> So there's a real use case here.

I believe you, though as I mentioned that simplification doesn't feel
right. Like jumping out of the frying pan into the fire.

> In fact a driver I'm going to submit soon uses it, which is why I wrote
> it in the first place, rather than adding yet another open-coded case.

Good, but check with graphs first. If it's not suitable would be nice
to know why.

> And to reply to the inevitable next reaction, NO this is not a case for
> creating yet another 237 layers of abstractions. Sometimes, a driver
> needs to directly access (no regmap overhead please) some regions
> represented by a specific DT node (it could be a child of the device
> for example representing a portion of its register space, or it could
> be a separate piece of HW that needs to be used by the device but
> doesn't fit in any abstract model and shouldn't).


-- 
With Best Regards,
Andy Shevchenko
