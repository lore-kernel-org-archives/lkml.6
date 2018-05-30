Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753002AbeE3MON (ORCPT <rfc822;w@1wt.eu>);
        Wed, 30 May 2018 08:14:13 -0400
Received: from mail-oi0-f66.google.com ([209.85.218.66]:42360 "EHLO
        mail-oi0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752773AbeE3MOL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 May 2018 08:14:11 -0400
X-Google-Smtp-Source: ADUXVKKtZBGQoZSIR+8qpGvuyUr7lykfA0IB4tRnTuiUnBKq9CVZtjWfv2NlHS2OT4hfeBmgxDF/w51mIN35yLILLLE=
MIME-Version: 1.0
In-Reply-To: <20180530120133.GC17450@bombadil.infradead.org>
References: <59623b15001e5a20ac32b1a393db88722be2e718.1527679621.git.baolin.wang@linaro.org>
 <20180530120133.GC17450@bombadil.infradead.org>
From: Baolin Wang <baolin.wang@linaro.org>
Date: Wed, 30 May 2018 20:14:09 +0800
Message-ID: <CAMz4ku+fBt2uY6MbiMX1X-6jtjdpqp=DWNMrefOG4SsUHWN4kQ@mail.gmail.com>
Subject: Re: [PATCH] mm: dmapool: Check the dma pool name
To: Matthew Wilcox <willy@infradead.org>
Cc: linux-mm@kvack.org, LKML <linux-kernel@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, Mark Brown <broonie@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 30 May 2018 at 20:01, Matthew Wilcox <willy@infradead.org> wrote:
> On Wed, May 30, 2018 at 07:28:43PM +0800, Baolin Wang wrote:
>> It will be crash if we pass one NULL name when creating one dma pool,
>> so we should check the passing name when copy it to dma pool.
>
> NAK.  Crashing is the appropriate thing to do.  Fix the caller to not
> pass NULL.
>
> If you permit NULL to be passed then you're inviting crashes or just
> bad reporting later when pool->name is printed.

I think it just prints one NULL pool name. Sometimes the device
doesn't care the dma pool names, so I think we can make code more
solid to valid the passing parameters like other code does.
Or can we add check to return NULL when the passing name is NULL
instead of crashing the kernel? Thanks.

-- 
Baolin.wang
Best Regards
