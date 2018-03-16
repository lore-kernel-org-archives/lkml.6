Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752964AbeCPAZV (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Mar 2018 20:25:21 -0400
Received: from mail-wr0-f181.google.com ([209.85.128.181]:47086 "EHLO
        mail-wr0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752802AbeCPAZT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Mar 2018 20:25:19 -0400
X-Google-Smtp-Source: AG47ELt5SOqDkBRqaQAdyK7gxdrv9D219RXDgWLCjWYU32plnbDtblcB2TWYbO40HgAPlKc8gAsvGexgz5jbfcvwWuc=
MIME-Version: 1.0
In-Reply-To: <39dc5bb4-02b1-bf7e-fbfc-17fc484e4fb7@codeaurora.org>
References: <1520997629-17361-1-git-send-email-okaya@codeaurora.org>
 <1520997629-17361-6-git-send-email-okaya@codeaurora.org> <CAKgT0UfJwYFy5g_2TE5W4MgdEvyH2CvBAS2imdw9UUiumuUOhQ@mail.gmail.com>
 <39dc5bb4-02b1-bf7e-fbfc-17fc484e4fb7@codeaurora.org>
From: Alexander Duyck <alexander.duyck@gmail.com>
Date: Thu, 15 Mar 2018 17:25:17 -0700
Message-ID: <CAKgT0UcfEwL9Jas149a=h3R4zeu4oA=uywJ9dpYD9kDdnpWQFA@mail.gmail.com>
Subject: Re: [PATCH 6/7] e1000: eliminate duplicate barriers on weakly-ordered archs
To: Sinan Kaya <okaya@codeaurora.org>
Cc: Netdev <netdev@vger.kernel.org>, Timur Tabi <timur@codeaurora.org>,
        sulrich@codeaurora.org, linux-arm-msm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Jeff Kirsher <jeffrey.t.kirsher@intel.com>,
        intel-wired-lan <intel-wired-lan@lists.osuosl.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 15, 2018 at 4:30 PM, Sinan Kaya <okaya@codeaurora.org> wrote:
> On 3/14/2018 9:41 PM, Alexander Duyck wrote:
>>>  }
>>>
>> So you missed the writel in e1000_xmit_frame. You should probably get
>> that one too while you are doing these updates. The wmb() is in
>> e1000_tx_queue().
>>
>
> I brought wmb() outside along with the next descriptor assignment to be
> similar to the rest of the other code.
>
> if wmb() and writel() are not visible in the same function, let's not touch
> the code.

Maybe for e1000 we should just skip the driver entirely. Odds are you
aren't going to have any e1000 parts running on ARM anyway since most
of them are legacy PCI or PCI-X parts that were made over 10 years
ago. Most of your efforts would probably be best spent on igb, igbvf,
ixgbe, ixgbevf, i40e, i40evf, and fm10k.
