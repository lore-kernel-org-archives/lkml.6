Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932496AbeCISwB (ORCPT <rfc822;w@1wt.eu>);
        Fri, 9 Mar 2018 13:52:01 -0500
Received: from mail-wr0-f172.google.com ([209.85.128.172]:39630 "EHLO
        mail-wr0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932072AbeCISwA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Mar 2018 13:52:00 -0500
X-Google-Smtp-Source: AG47ELu4uA0uJonWxRJLrOBCcc55fvx6PgDbHKZfnJ8RUA1iAuX6hLJ0+sbaxwq3DO6QRWPrvdJhFs47uuNC5cLYmkA=
MIME-Version: 1.0
In-Reply-To: <20180307143629.GG7290@sirena.org.uk>
References: <1520283457-31637-1-git-send-email-tharvey@gateworks.com>
 <20180306145749.GC5799@atomide.com> <20180307143629.GG7290@sirena.org.uk>
From: Tim Harvey <tharvey@gateworks.com>
Date: Fri, 9 Mar 2018 10:51:58 -0800
Message-ID: <CAJ+vNU3NjR2jT7WSr-mYgKUV1suEGka76_eGdWHFqUDm59nRgQ@mail.gmail.com>
Subject: Re: [PATCH v2] regmap: irq: fix ack-invert
To: Mark Brown <broonie@kernel.org>
Cc: Tony Lindgren <tony@atomide.com>, linux-kernel@vger.kernel.org,
        Benjamin Gaignard <benjamin.gaignard@linaro.org>,
        Lee Jones <lee.jones@linaro.org>, Guo Zeng <Guo.Zeng@csr.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 7, 2018 at 6:36 AM, Mark Brown <broonie@kernel.org> wrote:
> On Tue, Mar 06, 2018 at 06:57:49AM -0800, Tony Lindgren wrote:
>
>> > By using regmap_irq_update_bits to ACK the interrupts we use the masked
>> > status bits so we take care not to affect any other bits then use
>> > ack_invert to determine if we clear or set those bits.
>
>> This change to use regmap_irq_update_bits() now breaks things for
>> me with cpcap interrupts. So it seems to cause a non-inverted mode
>> regression. There should be no need to read the ack register, I
>> gues that's the whole idea of having a separate ack register :)
>
> Yes, that'd be my expectation as well - the register should be just
> write only.  regmap_update_bits() definitely isn't the right thing here
> since it will suppress the write part of the read/modify/write cycle if
> it detects that it didn't actually modify anything as an optimization.

understood. I will put together a v3 soon.

Thanks,

Tim
