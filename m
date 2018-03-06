Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753224AbeCFDMI (ORCPT <rfc822;w@1wt.eu>);
        Mon, 5 Mar 2018 22:12:08 -0500
Received: from mail-pl0-f67.google.com ([209.85.160.67]:34963 "EHLO
        mail-pl0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753164AbeCFDMH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Mar 2018 22:12:07 -0500
X-Google-Smtp-Source: AG47ELsb+EZi+Qfh7bHQMpKteAby7R+ohtrhrdFzJRoi3FV/tQ93Rfl10YuHYSvvMgpgANjmPRxp2Q==
Subject: Re: [PATCH v5 3/3] of: add early boot allocation of
 of_find_node_by_phandle() cache
To: Rob Herring <robh+dt@kernel.org>
Cc: Chintan Pandya <cpandya@codeaurora.org>, devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <1520208889-3908-1-git-send-email-frowand.list@gmail.com>
 <1520208889-3908-4-git-send-email-frowand.list@gmail.com>
 <CAL_Jsq+sD=Hj+3cYy0injRSZ5Dj2M6c+KbiFrrwsO_9pqq8wKg@mail.gmail.com>
From: Frank Rowand <frowand.list@gmail.com>
Message-ID: <c5393057-b0e0-7e9d-041a-96996cf047b2@gmail.com>
Date: Mon, 5 Mar 2018 19:12:05 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <CAL_Jsq+sD=Hj+3cYy0injRSZ5Dj2M6c+KbiFrrwsO_9pqq8wKg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/05/18 12:26, Rob Herring wrote:
> On Sun, Mar 4, 2018 at 6:14 PM,  <frowand.list@gmail.com> wrote:
>> From: Frank Rowand <frank.rowand@sony.com>
>>
>> The initial implementation of the of_find_node_by_phandle() cache
>> allocates the cache using kcalloc().  Add an early boot allocation
>> of the cache so it will be usable during early boot.  Switch over
>> to the kcalloc() based cache once normal memory allocation
>> becomes available.
> 
> Do we get a lot of lookups early? It makes sense to me to do early,
> but freeing and repopulating seems to add needless complexity.

Hey, that was my argument.  :-)

I would be quite happy leaving off patch 3/3.  And without 3/3,
2/3 becomes not necessary here, but still could go in separately
for completeness.  Though it could go in via Andrew.

-Frank
