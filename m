Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755088AbeCSCOp convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Sun, 18 Mar 2018 22:14:45 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:53441 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754383AbeCSCOm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Mar 2018 22:14:42 -0400
X-Google-Smtp-Source: AG47ELsWXQUC7oM8CNhArmPHlknLzVYXnQ8IKQt5lU0Z0PZRhO1WKYll+skoHkjuDR8GzbhzcvDWSA==
MIME-Version: 1.0
In-Reply-To: <20180318200715.363f3135@dell-desktop.home>
References: <20180223133742.26044-1-mylene.josserand@bootlin.com>
 <20180223133742.26044-11-mylene.josserand@bootlin.com> <6329fbb6-13a1-41fe-f6cf-f2f0d4b2e5f9@arm.com>
 <20180318200715.363f3135@dell-desktop.home>
From: Chen-Yu Tsai <wens@csie.org>
Date: Mon, 19 Mar 2018 10:14:19 +0800
X-Gmail-Original-Message-ID: <CAGb2v65QHkuM2GmT4MC+tp+HqN2ecqeZt8bB5OvZm2br1AJJ-w@mail.gmail.com>
Message-ID: <CAGb2v65QHkuM2GmT4MC+tp+HqN2ecqeZt8bB5OvZm2br1AJJ-w@mail.gmail.com>
Subject: Re: [PATCH v4 10/10] ARM: sunxi: smp: Add initialization of CNTVOFF
To: =?UTF-8?Q?Myl=C3=A8ne_Josserand?= <mylene.josserand@bootlin.com>
Cc: Marc Zyngier <marc.zyngier@arm.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Russell King <linux@armlinux.org.uk>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree <devicetree@vger.kernel.org>, quentin.schulz@bootlin.com,
        linux-kernel <linux-kernel@vger.kernel.org>,
        LABBE Corentin <clabbe.montjoie@gmail.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 19, 2018 at 3:07 AM, Mylène Josserand
<mylene.josserand@bootlin.com> wrote:
> Hello Mark,
>
> Please, excuse me for this late answer and thank you for the review!
>
> On Wed, 7 Mar 2018 12:18:33 +0000
> Marc Zyngier <marc.zyngier@arm.com> wrote:
>
>> On 23/02/18 13:37, Mylène Josserand wrote:
>> > On Cortex-A7, the CNTVOFF register from arch timer is uninitialized.
>>
>> Only on A7? Is that specific to your platform?
>
> I do not really know other Allwinner's platforms about this subject. At
> least, the sun9i-a80 which is a Cortex-a15/a7 does not need that but it
> is necessary for sun8i-a83t which is a cortex-a7. Maybe, Chen-Yu or
> Maxime could help us on it.

AFAIK all Allwinner CPUs need it if there isn't a firmware (PSCI) layer
beneath the kernel that will do the setup. We just have
"arm,cpu-registers-not-fw-configured" set for all the other SoCs that
have in-kernel SMP support, which includes the A31, A23, A33 and A80.

ChenYu
