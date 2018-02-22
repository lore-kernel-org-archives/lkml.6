Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752006AbeBVXmf (ORCPT <rfc822;w@1wt.eu>);
        Thu, 22 Feb 2018 18:42:35 -0500
Received: from mail-vk0-f68.google.com ([209.85.213.68]:37143 "EHLO
        mail-vk0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751794AbeBVXma (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Feb 2018 18:42:30 -0500
X-Google-Smtp-Source: AH8x225iWXjbMZHp7yXUem1UC7jO8kcQeo7oMrQDDu0I+FiXc/7nVBse2k5JwoplzENzp0idkMUgdvkbHlt7fEHdJKA=
MIME-Version: 1.0
In-Reply-To: <20180222230052.GA14632@bhelgaas-glaptop.roam.corp.google.com>
References: <0180206191126.GB98765@bhelgaas-glaptop.roam.corp.google.com>
 <20180206221106.16620-1-ulfalizer@gmail.com> <20180222230052.GA14632@bhelgaas-glaptop.roam.corp.google.com>
From: Ulf Magnusson <ulfalizer@gmail.com>
Date: Fri, 23 Feb 2018 00:42:28 +0100
Message-ID: <CAFkk2KScFZE0sjZovi1vq2xBQ_-wx2XoSbWG6_qL2W0rR5B7YQ@mail.gmail.com>
Subject: Re: [PATCH v2 20/20] x86/PCI: VMD: Fix malformed Kconfig default
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Tomasz Figa <tfiga@chromium.org>, Paul Burton <paul.burton@mips.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Hans-Christian Noren Egtvedt <egtvedt@samfundet.no>,
        Linus Walleij <linus.walleij@linaro.org>,
        Vineet Gupta <vgupta@synopsys.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Christoph Hellwig <hch@lst.de>, Michal Nazarewicz <mina86@mina86.com>,
        Rob Herring <robh@kernel.org>, Stephen Boyd <sboyd@codeaurora.org>,
        Paul Mackerras <paulus@ozlabs.org>, Will Deacon <will.deacon@arm.com>,
        Tony Lindgren <tony@atomide.com>, Nicholas Piggin <npiggin@gmail.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 23, 2018 at 12:00 AM, Bjorn Helgaas <helgaas@kernel.org> wrote:
> On Tue, Feb 06, 2018 at 11:11:06PM +0100, Ulf Magnusson wrote:
>> 'default N' should be 'default n', though they happen to have the same
>> effect here, due to undefined symbols (N in this case) evaluating to n
>> in a tristate sense.
>>
>> Remove the default instead of changing it. bool and tristate symbols
>> implicitly default to n.
>
> s/bool/Bool/

Not a great excuse, but I was thinking syntactically -- 'bool' and
'tristate' symbols... :)

>
>> Discovered with the
>> https://github.com/ulfalizer/Kconfiglib/blob/master/examples/list_undefined.py
>> script.
>>
>> Signed-off-by: Ulf Magnusson <ulfalizer@gmail.com>
>
> Acked-by: Bjorn Helgaas <bhelgaas@google.com>
>
> Since only this patch was posted to linux-pci, I assume it will be merged
> via some other tree.

I didn't have a particular tree in mind for this patchset. I imagined
people would pick up patches into the trees where they make the most
sense, and only created the patchset to keep track of the patches more
easily. Might have created some confusion in retrospect.

I just did a --cc-cmd="scripts/get_maintainer.pl -i" for the
individual patches by the way.

Cheers,
Ulf
