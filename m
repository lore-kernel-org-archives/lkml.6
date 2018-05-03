Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751069AbeECPBe (ORCPT <rfc822;w@1wt.eu>);
        Thu, 3 May 2018 11:01:34 -0400
Received: from mail-ua0-f193.google.com ([209.85.217.193]:42897 "EHLO
        mail-ua0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751121AbeECPB3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 May 2018 11:01:29 -0400
X-Google-Smtp-Source: AB8JxZp+p/vco1Q3AKbjahT2jdBQxPmeRJLvg0jL6UvZT6Y9vV5RPleLazR0ZyQFsE/W+eWuh8m7HshVQJYXw59+cPk=
MIME-Version: 1.0
In-Reply-To: <db8970ea-05f4-e7c0-52fa-070c7a6b8d2e@codeaurora.org>
References: <cover.1523673467.git.collinsd@codeaurora.org> <39b676d2ba7dac2436196cc5a090c6f151498dc8.1523673467.git.collinsd@codeaurora.org>
 <CAD=FV=UDUKg58xe+3C5QUbFwFkO8d3c_tzxmfPDzdv1KXZ3W9g@mail.gmail.com> <db8970ea-05f4-e7c0-52fa-070c7a6b8d2e@codeaurora.org>
From: Doug Anderson <dianders@chromium.org>
Date: Thu, 3 May 2018 08:01:27 -0700
X-Google-Sender-Auth: Kljf5i9n4wfK832Ckzx9m-oYOgo
Message-ID: <CAD=FV=UC4CqOut0GoJ-heqdZ9NTHzzgBpVWy3XAMFax26HoZmg@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] regulator: dt-bindings: add QCOM RPMh regulator bindings
To: David Collins <collinsd@codeaurora.org>
Cc: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>,
        Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        linux-arm-msm@vger.kernel.org,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        devicetree@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Stephen Boyd <sboyd@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, May 2, 2018 at 5:13 PM, David Collins <collinsd@codeaurora.org> wrote:
> On 05/02/2018 09:37 AM, Doug Anderson wrote:
>> On Fri, Apr 13, 2018 at 7:50 PM, David Collins <collinsd@codeaurora.org> wrote:
>>> +- vdd_l26-supply
>>> +- vdd_lvs1_lvs2-supply
>>> +- vdd_lvs1_lvs2-supply
>>> +       Usage:      optional (PM8998 only)
>>> +       Value type: <phandle>
>>> +       Definition: phandle of the parent supply regulator of one or more of the
>>> +                   regulators for this PMIC.
>>
>> One small additional nit here is that "vdd_lvs1_lvs2-supply" is listed twice.
>
> I'll remove the duplicate.
>
>
>> Also on the schematics (and in the PM8998 datasheet) I have this is
>> "VIN_LVS_1_2".  It seems like you should be consistent here and call
>> this "vin-lvs-1-2-supply".
>
> I was trying to keep the naming consistent within device tree binding
> documentation for LVS vs LDO and SMPS (e.g. 'vdd' vs 'vin' prefix).  I
> suppose that I can change this to match the hardware documentation pin
> name.  I can also change '_' to '-' in the supply names if that is preferred.

I'd rather it match the docs.  I personally have no idea for why the
writer of the docs used "vdd" vs. "vin", but even if they had no good
reason matching the docs makes this searchable.

As far as the "_" to "-", Rob asked for that earlier in this thread
and you says "I will change this on the next patch set."  In general
the desire to convert "_" to "-" makes this less searchable (since the
docs use "_"), but that's the way device tree guys want it so so c'est
la vie.  Luckily it's easily to mentally change the "-"s back to "_"s
when searching...

-Doug
