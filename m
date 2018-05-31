Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932654AbeEaCer (ORCPT <rfc822;w@1wt.eu>);
        Wed, 30 May 2018 22:34:47 -0400
Received: from mail-oi0-f66.google.com ([209.85.218.66]:44275 "EHLO
        mail-oi0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932602AbeEaCep (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 May 2018 22:34:45 -0400
X-Google-Smtp-Source: ADUXVKJoHXEHjprmSx/hTPqGcsf4DqoIe9ECG0+w7f1RGD9T0SQfU3zAJofpqB0nu3Sgh7k+iafbndIJ4dM4xSr3Ez8=
MIME-Version: 1.0
In-Reply-To: <20180530154110.GA22184@bombadil.infradead.org>
References: <59623b15001e5a20ac32b1a393db88722be2e718.1527679621.git.baolin.wang@linaro.org>
 <20180530120133.GC17450@bombadil.infradead.org> <CAMz4ku+fBt2uY6MbiMX1X-6jtjdpqp=DWNMrefOG4SsUHWN4kQ@mail.gmail.com>
 <20180530151327.GA13951@bombadil.infradead.org> <20180530154110.GA22184@bombadil.infradead.org>
From: Baolin Wang <baolin.wang@linaro.org>
Date: Thu, 31 May 2018 10:34:44 +0800
Message-ID: <CAMz4kuLG7c9E98q_SwYT+wcKRjH3RHL9p85D1Ku+FAAvLL1T-Q@mail.gmail.com>
Subject: Re: [PATCH] mm: dmapool: Check the dma pool name
To: Matthew Wilcox <willy@infradead.org>
Cc: linux-mm@kvack.org, LKML <linux-kernel@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, Mark Brown <broonie@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 30 May 2018 at 23:41, Matthew Wilcox <willy@infradead.org> wrote:
> On Wed, May 30, 2018 at 08:13:27AM -0700, Matthew Wilcox wrote:
>> On Wed, May 30, 2018 at 08:14:09PM +0800, Baolin Wang wrote:
>> > On 30 May 2018 at 20:01, Matthew Wilcox <willy@infradead.org> wrote:
>> > > On Wed, May 30, 2018 at 07:28:43PM +0800, Baolin Wang wrote:
>> > >> It will be crash if we pass one NULL name when creating one dma pool,
>> > >> so we should check the passing name when copy it to dma pool.
>> > >
>> > > NAK.  Crashing is the appropriate thing to do.  Fix the caller to not
>> > > pass NULL.
>> > >
>> > > If you permit NULL to be passed then you're inviting crashes or just
>> > > bad reporting later when pool->name is printed.
>> >
>> > I think it just prints one NULL pool name. Sometimes the device
>> > doesn't care the dma pool names, so I think we can make code more
>> > solid to valid the passing parameters like other code does.
>> > Or can we add check to return NULL when the passing name is NULL
>> > instead of crashing the kernel? Thanks.
>>
>> No.  Fix your driver.
>
> Let me elaborate on this.  Kernel code is supposed to be "reasonable".
> That means we don't check every argument to every function for sanity,
> unless it's going to cause trouble later.  Crashing immediately with
> a bogus argument is fine; you can see the problem and fix it immediately.
> Returning NULL with a bad argument is actually worse; you won't know why
> the function returned NULL (maybe we're out of memory?) and you'll have
> a more complex debugging experience.
>
> Sometimes it makes sense to accept a NULL pointer and do something
> reasonable, like kfree().  In this case, we can eliminate checks in all
> the callers.  But we don't, in general, put sanity checks on arguments
> without a good reason.
>
> Your reasons aren't good.  "The driver doesn't care" -- well, just pass
> the driver's name, then.

Thanks for your explanation. OK, force the driver to pass a pool name.
Sorry for noises.

-- 
Baolin.wang
Best Regards
