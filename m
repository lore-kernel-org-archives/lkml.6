Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753324AbeCFKNF (ORCPT <rfc822;w@1wt.eu>);
        Tue, 6 Mar 2018 05:13:05 -0500
Received: from mail-oi0-f68.google.com ([209.85.218.68]:42588 "EHLO
        mail-oi0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753155AbeCFKND (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Mar 2018 05:13:03 -0500
X-Google-Smtp-Source: AG47ELsN08sQNC0F0bWYq53jN9FqciQBicOrZDUTqMqhh3TKVmWRjD2kNqpezWusu9VP8l1TxNwIZ3edqNWIaj+pHgk=
MIME-Version: 1.0
In-Reply-To: <81f8b489-883b-58c8-851b-c624ca72c28d@arm.com>
References: <20180215175803.6870-1-marc.zyngier@arm.com> <db215c1e-0ce8-32e4-d131-e790bebf353e@redhat.com>
 <86o9k63f7a.wl-marc.zyngier@arm.com> <40c74835-da24-485f-14bb-a0c357c7e79b@redhat.com>
 <CAFEAcA9=YpNngKqeOXiO7QDvL=1ZaQEW8fh3XHjwD+i8qQm9wg@mail.gmail.com>
 <a1579f14-a5fe-11bc-a831-f729cead25ba@redhat.com> <81f8b489-883b-58c8-851b-c624ca72c28d@arm.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 6 Mar 2018 10:12:42 +0000
Message-ID: <CAFEAcA9-gVb-f25D4Ve9xvNUjuvd9iyL59MvNB9gqg8TK14JrA@mail.gmail.com>
Subject: Re: [REPOST PATCH] arm/arm64: KVM: Add PSCI version selection API
To: Marc Zyngier <marc.zyngier@arm.com>
Cc: Auger Eric <eric.auger@redhat.com>,
        lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>,
        arm-mail-list <linux-arm-kernel@lists.infradead.org>,
        kvmarm@lists.cs.columbia.edu
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6 March 2018 at 09:50, Marc Zyngier <marc.zyngier@arm.com> wrote:
> On 05/03/18 20:37, Auger Eric wrote:
>> On 05/03/18 17:31, Peter Maydell wrote:
>>> That also means that we will fail migration from a new kernel where
>>> we've specifically asked for PSCI 0.2 to an old PSCI-0.2-only kernel
>>> (because the KVM_REG_ARM_PSCI_VERSION reg will appear in the migration
>>> stream even if its value is the one value that matches the old kernel
>>> behaviour). I don't know if we care about that.
>>
>> Do you know when are we likely to force PSCI 0.2 on a new kernel? At
>> which layer is the decision supposed to be made and on which criteria?
>
> No decent SW should need this. But if you've written a guest that cannot
> work if it doesn't get "2" as response to PSCI_VERSION, you can override it.

...but if you want to be able to migrate back from a new kernel to
an old one, then you need to ask the new kernel for 0.2 so it
behaves the same way as the old one. As it stands this code wouldn't
let you do that migration even if you did specifically ask for 0.2.
(As I said, I don't know if we care about that.)

thanks
-- PMM
