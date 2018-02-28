Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934837AbeB1Uyq (ORCPT <rfc822;w@1wt.eu>);
        Wed, 28 Feb 2018 15:54:46 -0500
Received: from mail.kernel.org ([198.145.29.99]:39566 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S934739AbeB1Uyo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Feb 2018 15:54:44 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 191B021771
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=robh+dt@kernel.org
X-Google-Smtp-Source: AG47ELu/hygGZQmuc0sEGpn/sdc0ooldDmPkA6lJqSIPmHshLmKKxNMY7BVMbE3f9AFETlB4O/h7zEX9aFc555M5g+M=
MIME-Version: 1.0
In-Reply-To: <CAHp75Vc4jbJqM0=Yy-1SY6E2WhzHOAAcrn1+KE-jT7MWPtWPpA@mail.gmail.com>
References: <1519844656-16443-1-git-send-email-frowand.list@gmail.com>
 <1519844656-16443-2-git-send-email-frowand.list@gmail.com>
 <CAHp75VfD6Hi0NScdZrYozp9dAqmUUYjcLuPPyRwM31ezxNO2fw@mail.gmail.com>
 <c5d81c10-8b92-0a5d-93c2-8b8377b1396f@gmail.com> <CAHp75Vc4jbJqM0=Yy-1SY6E2WhzHOAAcrn1+KE-jT7MWPtWPpA@mail.gmail.com>
From: Rob Herring <robh+dt@kernel.org>
Date: Wed, 28 Feb 2018 14:54:22 -0600
X-Gmail-Original-Message-ID: <CAL_Jsq+i-3eHF3jkCzr=w7phOhCXN5K3MjrM3SuGS7aYTTEiAQ@mail.gmail.com>
Message-ID: <CAL_Jsq+i-3eHF3jkCzr=w7phOhCXN5K3MjrM3SuGS7aYTTEiAQ@mail.gmail.com>
Subject: Re: [PATCH v4 1/2] of: cache phandle nodes to reduce cost of of_find_node_by_phandle()
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Frank Rowand <frowand.list@gmail.com>,
        Chintan Pandya <cpandya@codeaurora.org>,
        devicetree <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 28, 2018 at 2:19 PM, Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
> On Wed, Feb 28, 2018 at 9:44 PM, Frank Rowand <frowand.list@gmail.com> wrote:
>> On 02/28/18 11:31, Andy Shevchenko wrote:
>>> On Wed, Feb 28, 2018 at 9:04 PM,  <frowand.list@gmail.com> wrote:
>
>>> The question is why O(1) is so important? O(log(n)) wouldn't work?
>>
>> O(1) is not critical.  It was just a nice side result.
>>
>>
>>> Using radix_tree() I suppose allows to dynamically extend or shrink
>>> the cache which would work with DT overlays.
>>
>> The memory usage of the phandle cache in this patch is fairly small.
>> The memory overhead of a radix_tree() would not be justified.
>
> OTOH the advantage I mentioned isn't a good argument?

Yes, but still one that ignores memory usage. I'll take whatever
solution doesn't undo this[1].

Rob

[1] https://lwn.net/Articles/735839/
