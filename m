Return-Path: <SRS0=4jry=KT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6D11C4646D
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Aug 2018 20:56:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 823372177A
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Aug 2018 20:56:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="an08PJWN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 823372177A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729683AbeHDW6O (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 4 Aug 2018 18:58:14 -0400
Received: from mail-ua0-f195.google.com ([209.85.217.195]:42911 "EHLO
        mail-ua0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728309AbeHDW6O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Aug 2018 18:58:14 -0400
Received: by mail-ua0-f195.google.com with SMTP id w7-v6so8147535uan.9;
        Sat, 04 Aug 2018 13:56:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=9HHw2o+h/0TcGBYciG0pmbAcAy5ZINsPVGQpXRd4AX0=;
        b=an08PJWNtzRsLXUtP8kPKExUIjPSapAcf9BWQijPdANg6To8Fg/7420vVQpqW/15tk
         NyzRQ77rLJjMPgqFcxkyOyFOE64u6fojo/qje41tV4hIvthWbzxXCE7/vguRiSYFfbLB
         qvdmu2vSB/rsBVdf8zB/eqYdocEGoRVa93EkDnwhIUpp74kuQoOHhlzTTBnpioEYIfgg
         zAISk1yVtE0t6egNN0kGsFUfaLanNhbk5CSi+8tbr1pyxx3m7bqkfcFXWym3qW18yRVc
         Q5WEq6Mq4PybKyzhBdlBAPrQ4e+sn7SOoVGQUrL6vM33cFgMhgSmuP0mF7wc2EN4Fc5N
         h3Kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=9HHw2o+h/0TcGBYciG0pmbAcAy5ZINsPVGQpXRd4AX0=;
        b=DewgG8abv+SrvxFQB7fGDJC4UE+NlKk1i6TwaUvzhVxlJtsSTExnfYORMRklOYjD0C
         AHZ16hPgYXL2cVCmy6ZXoD58HLH79ojiiMLwNhK6cUsDneLhjTpFgxc1dITLJZ3/7gJo
         /n/NVw8++BYxKCpPMznvtahrzCebu0o0yP2f6gQ7G6hmTThm/jNjxIBkvFkgPoiMcQW1
         U+Zgikjs/uxfRxT+LS5PuCej89UkPEhmZEXWkH45kgnN/cPQzzal9epTNHFQzrNq9pmP
         LQLTisfWQJnmBkp0gCmhwHGGZVxPROZykle1W0nU/FwYUFSJxK5Zz71uJvJdk3ckoVPP
         rG6g==
X-Gm-Message-State: AOUpUlHTwGiGCFU4snB7RMmMPxJtOc/OxTgdVUQHnyujLXBGKHFOoK8u
        evdVwtTAmWRQHaCnNugAmWUWlPX5Rijc4vLU6cQ=
X-Google-Smtp-Source: AAOMgpevIiNEqgG/rODraHn2RhSXQs/6V0ULMZ1jSPIbzNArZOhmYOCNnhJWfnLkrQAeWptowMWdfMa1rFL/0PKFRf0=
X-Received: by 2002:a1f:c884:: with SMTP id y126-v6mr5593921vkf.76.1533416178074;
 Sat, 04 Aug 2018 13:56:18 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a67:2149:0:0:0:0:0 with HTTP; Sat, 4 Aug 2018 13:56:17 -0700 (PDT)
In-Reply-To: <20180804065506.GB1727@gmail.com>
References: <20180802191554.20176-1-marcus.folkesson@gmail.com>
 <CAHp75Vf8kMLsoFN_EK150yW_FvH8XfgjiETYAtvW63et5NNurw@mail.gmail.com>
 <20180803230922.22d628fc@archlinux> <20180804065506.GB1727@gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Sat, 4 Aug 2018 23:56:17 +0300
Message-ID: <CAHp75VeDy=9o84K-PnASOMNXrNc9B1v9azWkx-wb4uLcomj_Vw@mail.gmail.com>
Subject: Re: [PATCH v3 1/3] iio: adc: add support for mcp3911
To:     Marcus Folkesson <marcus.folkesson@gmail.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Kent Gustavsson <kent@minoris.se>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-iio <linux-iio@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 4, 2018 at 9:55 AM, Marcus Folkesson
<marcus.folkesson@gmail.com> wrote:
> On Fri, Aug 03, 2018 at 11:09:22PM +0100, Jonathan Cameron wrote:
>> On Thu, 2 Aug 2018 22:52:00 +0300
>> Andy Shevchenko <andy.shevchenko@gmail.com> wrote:
>>
>> > On Thu, Aug 2, 2018 at 10:15 PM, Marcus Folkesson
>> > <marcus.folkesson@gmail.com> wrote:
>> > > MCP3911 is a dual channel Analog Front End (AFE) containing two
>> > > synchronous sampling delta-sigma Analog-to-Digital Converters (ADC).
>> > >
>> > > Signed-off-by: Marcus Folkesson <marcus.folkesson@gmail.com>
>> >
>> > > Signed-off-by: Kent Gustavsson <kent@minoris.se>
>> >
>> > What is this? Why it's here (presense and location in the message)?
>> To clarify... If Kent wrote the patch and you are simply acting
>> as gatekeeper / upstreamer you should set the mail to be from Kent
>> and put your own Signed-off after his to basically act as a submaintainer
>> certifying you believe his sign off and all that entails.

Yep. And here the ordering is incorrect, right?

>> If it is a bit of a joint effort then that's fine but for copyright
>> purposes there should be some indication of the split.
>
> First, thank you Andy for noticing.
>
> I actually intended to use Co-Developed-by (a pretty new tag)
> in combination with Signed-off-by.
> But the tag must have disappeared in some preparation stage..
>
> From Documentation/process/submitting-patches.rst ::
>
>         A Co-Developed-by: states that the patch was also created by another developer
>         along with the original author.  This is useful at times when multiple people
>         work on a single patch.  Note, this person also needs to have a Signed-off-by:
>         line in the patch as well.
>
> I will switch order and add the Co-Developed-by-tag.
> Is this correct?
>
> Co-Developed-by: Kent Gustavsson <kent@minoris.se>
> Signed-off-by: Kent Gustavsson <kent@minoris.se>
> Signed-off-by: Marcus Folkesson <marcus.folkesson@gmail.com>

Yep, this looks good!

>> > > +       of_property_read_u32(of_node, "device-addr", &adc->dev_addr);

>> > Isn't what we called CS (chip select)?
>> Nope. We went around this in an earlier revision. It's an address transmitted
>> in the control byte to allow you to 'share' a chip select line between multiple
>> chips (crazy but true).

OK.

-- 
With Best Regards,
Andy Shevchenko
