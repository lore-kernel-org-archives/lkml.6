Return-Path: <SRS0=/Ixz=KV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24D2FC4646D
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 19:06:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D17D721A29
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 19:06:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l5MHWaNH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D17D721A29
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732857AbeHFVRO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Aug 2018 17:17:14 -0400
Received: from mail-ua0-f193.google.com ([209.85.217.193]:37219 "EHLO
        mail-ua0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728198AbeHFVRN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Aug 2018 17:17:13 -0400
Received: by mail-ua0-f193.google.com with SMTP id y10-v6so13411166uao.4;
        Mon, 06 Aug 2018 12:06:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=kQmupFj6wki3WKHYFu5y7WPu+tUN8me/ZT0QDlj+oYo=;
        b=l5MHWaNHExGL2JUXtin+Kx0ajAQgHtadk1NyGIrdyyjEdKGuKeUyQlAH5K4Hv539/5
         9YwdcfVwnmNw1hym2lyVzFDs7/G8ufZQ2k3Hf8K7AJx0Wy9EX2lCKuC6u4Kg3mP6BulV
         LVCxMfqmV+QpjgVAnw3gUNNriJ4Gx4qyw3vbH4g9W6+zUsFcEDujI83Sipdwl2WSO+nJ
         mx9+VbdG/VcpnNqGy+ipWaHchXX4iZdfjrs+76ThotO2I7GG/Y52wGdR7teU09G6soBv
         9l5jz9Gdq5DgeMId3uQ2gAl61RRrTj2tBrfb3fYB4UV0rOSUF3tLgbLHUaKO5P5IOn1y
         kMig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=kQmupFj6wki3WKHYFu5y7WPu+tUN8me/ZT0QDlj+oYo=;
        b=bU+7gJZ8nvCnP81DPrVs76rxaIFZLVnrzUCJhpPqGi0HI2tJqkHUFJBny8lqgccTmO
         u5nLdp7QrfEmtmOScq+6J78M9VEStm6xDhS95MqBE2krbcSsgTMkiOVxulPZ9z0/TXTX
         fbP0sIPBnIzDG/d3zeVo8X6H4fZVA3h2Iat3eC25OdTH6yw+gENlZmxXs8t4ixhXkxPH
         4RtyXIFBP2KgeRIfECGTDj4s8a5uOSgHSQmx0eAKQTS6z1bc9AOJ8+XeIv8AobhKSZzQ
         8qoE+MbtRmwIUv/6AHqlax4zJFL04FM3xRk1d5dTI6bliRPaGHF2nOYeU/gM3Ve+Bn9J
         YsNg==
X-Gm-Message-State: AOUpUlGEQra5WRjIZeDzh+E9ZvrgwGRiSnx5/dZizP8iK9+NCJ1gvhB1
        b3wau+wIvOUEBlD/BNMaZJqyDDjlVaerAoHUW0mgPSla
X-Google-Smtp-Source: AAOMgpcc/OsWPTxSZMNfIwjsI277G846Hl/47fsmhuPvoXdYcGTco+obd9ysOP+2HWuG+A71K1whTdNrFxHi1Z/GB2c=
X-Received: by 2002:ab0:4c24:: with SMTP id l36-v6mr11232472uaf.199.1533582405100;
 Mon, 06 Aug 2018 12:06:45 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a67:2149:0:0:0:0:0 with HTTP; Mon, 6 Aug 2018 12:06:44 -0700 (PDT)
In-Reply-To: <fa7980ee38e6cbb31883e1b942fa1e1d6f0e72b0.camel@perches.com>
References: <20180805001839.GA22975@embeddedor.com> <CAHp75Vc=HLMVhQ30z9LTM7z+nmYgYPSRJib0PVTVW8H25eYg5g@mail.gmail.com>
 <e92131c3b6e04a848f2a7922719f4747@AcuMS.aculab.com> <fa7980ee38e6cbb31883e1b942fa1e1d6f0e72b0.camel@perches.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Mon, 6 Aug 2018 22:06:44 +0300
Message-ID: <CAHp75VcCDnVjBv_8aFt3y4=6XzX45KWRhc=LZjDPw0LbtMsR7w@mail.gmail.com>
Subject: Re: [PATCH] platform/x86: acer-wmi: use true and false for boolean values
To:     Joe Perches <joe@perches.com>
Cc:     David Laight <David.Laight@aculab.com>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        "Lee, Chun-Yi" <jlee@suse.com>, Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 6, 2018 at 7:42 PM, Joe Perches <joe@perches.com> wrote:
> On Mon, 2018-08-06 at 16:41 +0000, David Laight wrote:
>> From: Andy Shevchenko
>> > Sent: 05 August 2018 11:26

>> > >  static bool has_cap(u32 cap)
>> > >  {
>> > >         if ((interface->capability & cap) != 0)
>> > > -               return 1;
>> > > +               return true;
>> > >
>> > > -       return 0;
>> > > +       return false;
>> > >  }
>> >
>> > this entire function can be oneliner:
>> >
>> > return !!(...);
>>
>> Why the !! ?? Just:
>>       return (interface->capability & cap) != 0;
>
> Because the return is bool you don't need the !! either.
> The compiler does that.

True, I use that pattern, but in most cases the return value is int
and this is just to guarantee the 0,1 possible range.

-- 
With Best Regards,
Andy Shevchenko
