Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751148AbeDMFoH (ORCPT <rfc822;w@1wt.eu>);
        Fri, 13 Apr 2018 01:44:07 -0400
Received: from mail-ot0-f170.google.com ([74.125.82.170]:41611 "EHLO
        mail-ot0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750849AbeDMFoF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Apr 2018 01:44:05 -0400
X-Google-Smtp-Source: AIpwx482w3g+wPckNDUXahZ5cjKrnQfWJ+fsN/cT2wfELHNIwZpuJ5zr5LglmphKq/Jtowoo0ts/aP4lbg9PhFvtQ2w=
MIME-Version: 1.0
In-Reply-To: <20180413033917.GH6014@localhost>
References: <abdda9da96185f764d58bbf61db9010d0f72d1b3.1523346135.git.baolin.wang@linaro.org>
 <0c2b76aba6a49e583f920ae582d6815fa9cc4361.1523346135.git.baolin.wang@linaro.org>
 <20180411093634.GC6014@localhost> <CAMz4kuJyKNNuR9WGP8F1NKAET6ZTtN4LtXTTtdnR3Zyxa+OjNw@mail.gmail.com>
 <20180412093735.GF6014@localhost> <CAMz4ku+i+zA0_5U65vc3h3tO-hzWvtCOFDeFU94h3Rm6sJUuKQ@mail.gmail.com>
 <20180413033917.GH6014@localhost>
From: Baolin Wang <baolin.wang@linaro.org>
Date: Fri, 13 Apr 2018 13:44:04 +0800
Message-ID: <CAMz4kuKE1oybhy7s+L9CLs0Hx2PNG9rDeUrtn3hAMQE-0Jm+nA@mail.gmail.com>
Subject: Re: [PATCH 4/5] dmaengine: sprd: Add Spreadtrum DMA configuration
To: Vinod Koul <vinod.koul@intel.com>
Cc: Dan Williams <dan.j.williams@intel.com>,
        Eric Long <eric.long@spreadtrum.com>, Mark Brown <broonie@kernel.org>,
        dmaengine@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13 April 2018 at 11:39, Vinod Koul <vinod.koul@intel.com> wrote:
> On Thu, Apr 12, 2018 at 07:30:01PM +0800, Baolin Wang wrote:
>
>> >> > what does block and transaction len refer to here
>> >>
>> >>  Our DMA has 3 transfer mode: transaction transfer, block transfer and
>> >> fragment transfer. One transaction transfer can contain several blocks
>> >> transfer, and each block can be set proper block step. One block can
>> >> contain several fragments transfer with proper fragment step. It can
>> >> generate interrupts when one transaction transfer or block transfer or
>> >> fragment transfer is completed if user set the interrupt type. So here
>> >> we should set the length for transaction transfer, block transfer and
>> >> fragment transfer.
>> >
>> > what are the max size these types support?
>>
>> These types max size definition:
>>
>> #define SPRD_DMA_FRG_LEN_MASK GENMASK(16, 0)
>>
>> #define SPRD_DMA_BLK_LEN_MASK GENMASK(16, 0)
>>
>> #define SPRD_DMA_TRSC_LEN_MASK GENMASK(27, 0)
>
> They are register defines. How many items or bytes do each type of txn
> support?

These macros are the max size definitions, for example one fragment
length can support to 0x1ffff bytes, one transaction transfer can
support to 0xfffffff.

-- 
Baolin.wang
Best Regards
