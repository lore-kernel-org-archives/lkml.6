Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753905AbeCUVx0 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 21 Mar 2018 17:53:26 -0400
Received: from mail-wr0-f196.google.com ([209.85.128.196]:43599 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753881AbeCUVxS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Mar 2018 17:53:18 -0400
X-Google-Smtp-Source: AG47ELv1lW4AZrDwyUJlJL66EbVn7275oapVqkc1uIO7ea7Xv/pasP+Ld3AQ/wP16TmvZ8ycS6HyfMR1bzd2eR3YUtw=
MIME-Version: 1.0
In-Reply-To: <c2ce63d1213b5145f77bf70f57c3360d@codeaurora.org>
References: <1521658572-26354-1-git-send-email-okaya@codeaurora.org>
 <1521658572-26354-6-git-send-email-okaya@codeaurora.org> <1521668888.12746.32.camel@intel.com>
 <c2ce63d1213b5145f77bf70f57c3360d@codeaurora.org>
From: Alexander Duyck <alexander.duyck@gmail.com>
Date: Wed, 21 Mar 2018 14:53:16 -0700
Message-ID: <CAKgT0UcvtszFWLUWS_4KYaBn7QnKNtgiwgPzqV24Bb-jOncrfw@mail.gmail.com>
Subject: Re: [Intel-wired-lan] [PATCH REPOST v4 5/7] ixgbevf: keep writel()
 closer to wmb()
To: Sinan Kaya <okaya@codeaurora.org>
Cc: Jeff Kirsher <jeffrey.t.kirsher@intel.com>, sulrich@codeaurora.org,
        Netdev <netdev@vger.kernel.org>, Timur Tabi <timur@codeaurora.org>,
        LKML <linux-kernel@vger.kernel.org>,
        intel-wired-lan <intel-wired-lan@lists.osuosl.org>,
        linux-arm-msm@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 21, 2018 at 2:51 PM,  <okaya@codeaurora.org> wrote:
> On 2018-03-21 17:48, Jeff Kirsher wrote:
>>
>> On Wed, 2018-03-21 at 14:56 -0400, Sinan Kaya wrote:
>>>
>>> Remove ixgbevf_write_tail() in favor of moving writel() close to
>>> wmb().
>>>
>>> Signed-off-by: Sinan Kaya <okaya@codeaurora.org>
>>> Reviewed-by: Alexander Duyck <alexander.h.duyck@intel.com>
>>> ---
>>>  drivers/net/ethernet/intel/ixgbevf/ixgbevf.h      | 5 -----
>>>  drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c | 4 ++--
>>>  2 files changed, 2 insertions(+), 7 deletions(-)
>>
>>
>> This patch fails to compile because there is a call to
>> ixgbevf_write_tail() which you missed cleaning up.
>
>
> Hah, I did a compile test but maybe I missed something. I will get v6 of
> this patch only and leave the rest of the series as it is.

Actually you might want to just pull Jeff's tree and rebase before you
submit your patches. I suspect the difference is the ixgbevf XDP code
that is present in Jeff's tree and not in Dave's. The alternative is
to wait for Jeff to push the ixgbevf code and then once Dave has
pulled it you could rebase your patches.

Thanks.

- Alex
