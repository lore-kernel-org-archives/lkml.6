Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753508AbeDMGlv (ORCPT <rfc822;w@1wt.eu>);
        Fri, 13 Apr 2018 02:41:51 -0400
Received: from mail-ot0-f169.google.com ([74.125.82.169]:36955 "EHLO
        mail-ot0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752594AbeDMGlt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Apr 2018 02:41:49 -0400
X-Google-Smtp-Source: AIpwx4/oC1xv2vqG//TCbF9Or18tDlZ9KZeUsaIJxktycTsK3KxGoeS8wA29/TJkJRGLgUZDSo8QIbnwxgxpjRBIbdI=
MIME-Version: 1.0
In-Reply-To: <20180413063641.GL6014@localhost>
References: <abdda9da96185f764d58bbf61db9010d0f72d1b3.1523346135.git.baolin.wang@linaro.org>
 <0c2b76aba6a49e583f920ae582d6815fa9cc4361.1523346135.git.baolin.wang@linaro.org>
 <20180411093634.GC6014@localhost> <CAMz4kuJyKNNuR9WGP8F1NKAET6ZTtN4LtXTTtdnR3Zyxa+OjNw@mail.gmail.com>
 <20180412093735.GF6014@localhost> <CAMz4ku+i+zA0_5U65vc3h3tO-hzWvtCOFDeFU94h3Rm6sJUuKQ@mail.gmail.com>
 <CAMz4ku+EUtk2phRGkxkW6YwUvBLb-O7tmMoucvVEQZbL9EY8Zg@mail.gmail.com>
 <20180413034332.GI6014@localhost> <CAMz4kuL_i7u5OCXrtJy92=OisOzgbWk_e-S9dSuBRPenX=ScPA@mail.gmail.com>
 <20180413063641.GL6014@localhost>
From: Baolin Wang <baolin.wang@linaro.org>
Date: Fri, 13 Apr 2018 14:41:48 +0800
Message-ID: <CAMz4ku+dLk2Gi_20ATW5o-MPvpy-2iF_YJCwyStaH8xPNXSE7Q@mail.gmail.com>
Subject: Re: [PATCH 4/5] dmaengine: sprd: Add Spreadtrum DMA configuration
To: Vinod Koul <vinod.koul@intel.com>
Cc: Dan Williams <dan.j.williams@intel.com>,
        Eric Long <eric.long@spreadtrum.com>, Mark Brown <broonie@kernel.org>,
        dmaengine@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13 April 2018 at 14:36, Vinod Koul <vinod.koul@intel.com> wrote:
> On Fri, Apr 13, 2018 at 02:17:34PM +0800, Baolin Wang wrote:
>
>> > Agreed, users only care about grabbing a channel, setting a descriptor and
>> > submitting that.
>> >
>> > I think you need to go back and think about this a bit, please do go thru
>> > dmaengine documentation and see other driver examples.
>> >
>> > We don't typically expose these to users, they give us a transfer and we set
>> > that up in hardware for efficient. Its DMA so people expect us to use fastest
>> > mechanism available.
>>
>> But there are some configuration are really special for Spreadtrum
>> DMA, and must need user to specify how to configure, especially some
>> scenarios of audio. So I wander if we can add one pointer for
>> 'dma_slave_config' to expand some special DMA configuration
>> requirements, like:
>>
>> struct dma_slave_config {
>>     ......
>>     unsigned int slave_id;
>>     void *platform_data;
>> };
>>
>> So if some DMA has some special configuration (such as Spreadtrum
>> DMA), they can user this platform_data pointer. Like xilinx DMA, they
>> also have some special configuration.
>
> Well we all think our HW is special and needs some additional stuff, most of
> the cases turns out not to be the case.
>
> Can you explain how audio in this case additional configuration...
>

Beside the general configuration, our audio driver will configure the
fragment length, block length, maybe transaction length, and they must
specify the request type and interrupt type, these are what we want to
export for users.

-- 
Baolin.wang
Best Regards
