Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934868AbeB1U6g (ORCPT <rfc822;w@1wt.eu>);
        Wed, 28 Feb 2018 15:58:36 -0500
Received: from mail-pl0-f66.google.com ([209.85.160.66]:46474 "EHLO
        mail-pl0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934825AbeB1U6Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Feb 2018 15:58:24 -0500
X-Google-Smtp-Source: AH8x224tbdVjJ20N+rvlLl2YYAgOVjktnjQV6mOyqDBdNKNhpKZHdvLd3YOJuByIAxHvpbPAeNK2MQ==
Subject: Re: [PATCH v4 1/2] of: cache phandle nodes to reduce cost of
 of_find_node_by_phandle()
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Rob Herring <robh+dt@kernel.org>, cpandya@codeaurora.org,
        devicetree <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <1519844656-16443-1-git-send-email-frowand.list@gmail.com>
 <1519844656-16443-2-git-send-email-frowand.list@gmail.com>
 <CAHp75VfD6Hi0NScdZrYozp9dAqmUUYjcLuPPyRwM31ezxNO2fw@mail.gmail.com>
 <c5d81c10-8b92-0a5d-93c2-8b8377b1396f@gmail.com>
 <CAHp75Vc4jbJqM0=Yy-1SY6E2WhzHOAAcrn1+KE-jT7MWPtWPpA@mail.gmail.com>
From: Frank Rowand <frowand.list@gmail.com>
Message-ID: <9a078531-74ba-55f8-0dd1-961504b306b4@gmail.com>
Date: Wed, 28 Feb 2018 12:58:22 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <CAHp75Vc4jbJqM0=Yy-1SY6E2WhzHOAAcrn1+KE-jT7MWPtWPpA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/28/18 12:19, Andy Shevchenko wrote:
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

No.  Deleting and re-creating the cache to resize it (when applying an
overlay) would be a rare event that would happen as desired by the
overlay application code.  There is no real gain by having extension
or shrinkage occur automatically and if the overlay application code
desires the resizing it is trivial to implement (a single function
call).
