Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755772AbeDWQuD (ORCPT <rfc822;w@1wt.eu>);
        Mon, 23 Apr 2018 12:50:03 -0400
Received: from mail-ua0-f180.google.com ([209.85.217.180]:33733 "EHLO
        mail-ua0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755573AbeDWQuB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Apr 2018 12:50:01 -0400
X-Google-Smtp-Source: AIpwx4/9paP35bh5q91g1V2AAnSM0uzGaNjF6OglOfPvWHQdEnI4OxZ7GzvMzxlyVqZ9GC4Trox7oqmktVvj6hTb26o=
MIME-Version: 1.0
In-Reply-To: <d2ed3578-ca09-15a6-e688-ffb9a097c2aa@arm.com>
References: <20180418222905.10414-1-robh@kernel.org> <e7a2f4ca-40c2-05ef-097c-2cecd31fb731@gmail.com>
 <CAL_JsqKVCdk8nFwmtfNt4mMOVYFVxefgafP6JtXThvFhROFB8w@mail.gmail.com> <d2ed3578-ca09-15a6-e688-ffb9a097c2aa@arm.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 23 Apr 2018 18:49:59 +0200
X-Google-Sender-Auth: BAaTojsyLgo6HiRq-slUpM72zyk
Message-ID: <CAMuHMdU8q0VUxw-EXDqjjYbjeCwCkKuDJUjO0vSaCVrYLXqX4A@mail.gmail.com>
Subject: Re: [RFC PATCH] dt-bindings: add a jsonschema binding example
To: Grant Likely <grant.likely@arm.com>
Cc: Rob Herring <robh@kernel.org>, Frank Rowand <frowand.list@gmail.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
        <devicetree@vger.kernel.org>,
        devicetree-spec@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Linus Walleij <linus.walleij@linaro.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Mark Brown <broonie@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>, Stephen Boyd <sboyd@kernel.org>,
        Jonathan Cameron <jic23@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Grant,

On Mon, Apr 23, 2018 at 4:47 PM, Grant Likely <grant.likely@arm.com> wrote:
> On 21/04/2018 02:28, Rob Herring wrote:
>> On Fri, Apr 20, 2018 at 4:00 PM, Frank Rowand <frowand.list@gmail.com>
>> wrote:
>>>> +  interrupts:
>>>> +    # Either 1 or 2 interrupts can be present
>>>> +    minItems: 1
>>>> +    maxItems: 2
>>>> +    items:
>>>> +      - description: tx or combined interrupt
>>>> +      - description: rx interrupt
>>>> +
>>>> +    description: |
>>>> +      A variable number of interrupts warrants a description of what
>>>> conditions
>>>> +      affect the number of interrupts. Otherwise, descriptions on
>>>> standard
>>>> +      properties are not necessary.
>>>> +
>>>> +  interrupt-names:
>>>> +    # minItems must be specified here because the default would be 2
>>>> +    minItems: 1
>>>
>>> Why the difference between the interrupts property and the
>>> interrupt-names
>>> property (specifying maxItems for interrupt, but not interrupt-names)?
>>
>> I should probably have maxItems here too.
>>
>>> Others have already commented on a desire to have a way to specify that
>>> number of interrupts should match number of interrupt-names.
>>
>> Yeah, but I don't see a way to do that. You could stick the array size
>> constraints in a common definition and have a $ref to that definition
>> from both, but that doesn't really save you too much.
>
>
> There has been discussions in the jsonschema community regarding
> referencing data in the document when applying the schema.
>
> https://github.com/json-schema-org/json-schema-spec/issues/549
>
> However, those discussions are ongoing and have been pushed back to
> after draft-8 (the current release is draft-7). We can instead define
> DT-specific keywords and extend the validator to make it do what we
> want. We need to do something very similar to validate that the length
> of tuples in 'reg', 'interrupts', and '*gpios' match the '#*-cells' values.

Checking that property lengths match the corresponding #*-cells cannot
be done for a schema, but only for the final DTS, as #*-cells is a property
of the target node, right?

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
