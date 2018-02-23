Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751607AbeBWHGP (ORCPT <rfc822;w@1wt.eu>);
        Fri, 23 Feb 2018 02:06:15 -0500
Received: from mail-qk0-f194.google.com ([209.85.220.194]:37730 "EHLO
        mail-qk0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751425AbeBWHGN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Feb 2018 02:06:13 -0500
X-Google-Smtp-Source: AG47ELsMGJ8uw9V5FUDEEIa4AfwARLJJZ/MEeFz+LdUAfX0wKpZJewD+xk5jGiKX7h5Ot34vuZPKNRGBPxe8Z6PSEEk=
MIME-Version: 1.0
In-Reply-To: <20180222155411.gnn42poawtlf3rze@verge.net.au>
References: <1519139541-18783-1-git-send-email-jacopo+renesas@jmondi.org>
 <1519139541-18783-20-git-send-email-jacopo+renesas@jmondi.org>
 <cf157266-5ea7-6795-1e31-0d1ccf85e7e8@cogentembedded.com> <20180221100716.GF7203@w540>
 <cbeb1b6b-1b02-7665-0f1f-847ab8de69e3@cogentembedded.com> <20180221173106.vgyshbz3kkc4p3cu@verge.net.au>
 <321c6c8c-8853-ac00-7567-c0be82b510f4@cogentembedded.com> <35959135-cb3b-040a-1944-26845e0c07b0@cogentembedded.com>
 <20180221182340.wvdvgtv5pw7pvd3v@verge.net.au> <eaf3c72b-a482-86cf-88e7-4af457f74558@cogentembedded.com>
 <20180222155411.gnn42poawtlf3rze@verge.net.au>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Fri, 23 Feb 2018 08:06:11 +0100
X-Google-Sender-Auth: gqWkx6LgD9BEJhZiyjfzKH0vh5Q
Message-ID: <CAMuHMdWj1v6WmfLY5JttZ+LMpSn2XvjgBS95Ag9TBohRRU1qTA@mail.gmail.com>
Subject: Re: [PATCH v2 19/19] ARM64: dts: r8a77965: Add EtherAVB device node
To: Simon Horman <horms@verge.net.au>
Cc: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>,
        jacopo mondi <jacopo@jmondi.org>,
        Jacopo Mondi <jacopo+renesas@jmondi.org>,
        Magnus Damm <magnus.damm@gmail.com>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
        <devicetree@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Simon,

On Thu, Feb 22, 2018 at 4:54 PM, Simon Horman <horms@verge.net.au> wrote:
> On Wed, Feb 21, 2018 at 09:53:58PM +0300, Sergei Shtylyov wrote:
>> On 02/21/2018 09:23 PM, Simon Horman wrote:
>>
>> > ...
>> >
>> >>>>>>>> +                    clocks = <&cpg CPG_MOD 812>;
>> >>>>>>>> +                    power-domains = <&sysc 32>;
>> >>>>>>>> +                    resets = <&cpg 812>;
>> >>>>>>>> +                    phy-mode = "rgmii-txid";
>> >>>>>>>
>> >>>>>>>    Why not just "rgmii"? TX delay is a board specific detail, no?
>> >>>>>>>
>> >>>>>> I admit I took this one straight from r8a7796 dtsi.
>> >>>>>> Would you like to me resend and change this?
>> >>>>>
>> >>>>>    Yes, unless Simon would fix it while merging...
>> >>>>
>> >>>> Can I confirm the desired change is s/rgmii-txid/rgmii/ ?
>> >>>
>> >>>    Yes.
>> >>
>> >>    Apparently that means that this prop should be overridden in the board file
>> >> (which may not be an easy task given the board is Salvator-XS again).
>> >>
>> >> [...]
>> >
>> > Can we override it in r8a77965-salvator-x.dts or r8a77965-salvator-xs.dts?
>>
>>    In salvator-common.dtsi most probably -- it has the PHY data for Ether AVB.
>>
>> > I feel that I'm missing an important point here.
>>
>>    Well, r8a779{5|6}.dtsi also have phy-mode = "rgmii-txid" (which was
>>    unjustified in my current understanding). Thus such board override
>>    wouldn't hurt them. But we lack a patch modifying salvator-common.dtsi
>>    in htis series, so I'm now thinking a respin of this series is needed
>>    anyway... sorry for being unclear. :-)
>
> While I've applied other patches in this series I have
> not applied this one - mainly to allow this discussion to conclude.
>
> Is an appropriate solution to do the following?
>
> 1) Atomically update
>    a) r8a779{5|6}.dtsi to use "rgmii" and
>    b) salvator-common.dtsi to use "rgmii-txid"
> 2) Update this patch to use "rgmii"

No need for atomics.
It can all be done by patches touching single files only:
  1) Add "rgmii-txid" to board .dts(i) files,
  2) Change s/rgmii-txid/rgmii/ in SoC .dtsi files.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
