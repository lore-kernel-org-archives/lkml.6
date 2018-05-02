Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751682AbeEBN4P (ORCPT <rfc822;w@1wt.eu>);
        Wed, 2 May 2018 09:56:15 -0400
Received: from mail-it0-f65.google.com ([209.85.214.65]:38365 "EHLO
        mail-it0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751637AbeEBN4H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 May 2018 09:56:07 -0400
X-Google-Smtp-Source: AB8JxZqG4rH0UPkwrXJBoWJkiEw4/0Tj1liP4H33UmHOC/Ty7qoDGN7pK20FwmqQx4dccoLhHFCOpCD0evxc3ZokrTM=
MIME-Version: 1.0
In-Reply-To: <60652f48-2a98-414b-5cff-25890a6da37f@xilinx.com>
References: <6ee982f8eb6e07f9ecbb0cc5093152f4a16b9c31.1523454899.git.michal.simek@xilinx.com>
 <CACRpkdbOa+AvhQT1RCWA_zQuTpp4qfNjZBFDOKLdaFqMGAe+cw@mail.gmail.com>
 <f9dd4f64-4026-f495-5810-32affb5b0944@xilinx.com> <CACRpkdaxwRc0zoDKogVGisXTPJ0EwLbOQjHzz1pSEjvWCsSCTQ@mail.gmail.com>
 <cc8d864a-e8e6-d30d-ae54-91819e5d0b8d@xilinx.com> <CACRpkdYgw+HaC5bUCZKiD7j+2ZLYbCTG+DdPdAEkRDq0xF5b3w@mail.gmail.com>
 <60652f48-2a98-414b-5cff-25890a6da37f@xilinx.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Wed, 2 May 2018 15:56:05 +0200
Message-ID: <CACRpkdaNJzW+LO97oxavzYJwfkj0xu7wxTNRaGiaKm98ON5JMA@mail.gmail.com>
Subject: Re: [PATCH] gpio: zynq: Setup chip->base based on alias ID
To: Michal Simek <michal.simek@xilinx.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Michal Simek <monstr@monstr.eu>,
        Steffen Trumtrar <s.trumtrar@pengutronix.de>,
        Peter Crosthwaite <peter.crosthwaite@xilinx.com>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Rob Herring <robherring2@gmail.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 2, 2018 at 3:41 PM, Michal Simek <michal.simek@xilinx.com> wrote:

> If you don't want this patch I understand that and it will become just
> another soc vendor patch out of mainline.

I don't really know what to do, so that is why I'm discussing.

It's one of those gray areas.

>From one point of view there is the purist stance that we should
only support what the mainline tree does, and be strict and
consistent so we don't accumulate to many nasty hacks.

On the other hand, it is completely possible that all users of this
particular driver actually must have this patch, and then I just
push them to use a deviant vendor tree for no good reason.

Would it be possible that I apply the patch, and somehow also
establish some understanding with all users of the Xilinx
platform that whatever legacy applications are out there
must start to migrate towards using the character device so
this reliance on the numberspace doesn't stick around forever?

For example can we make a patch to some systems like
arch/arm/boot/dts/zynq-*.dts
adding proper GPIO line names to these device trees, such
as was made in e.g. commit f6b1674d570aa1
"arm64: dts: qcom: sbc: Name GPIO lines"

After all that is what I strive for as maintainer, as the IETF
motto says:
"rough consensus and running code"

Yours,
Linus Walleij
