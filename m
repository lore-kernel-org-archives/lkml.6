Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752387AbeDRFk5 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 18 Apr 2018 01:40:57 -0400
Received: from mail-ot0-f193.google.com ([74.125.82.193]:46198 "EHLO
        mail-ot0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751431AbeDRFkz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Apr 2018 01:40:55 -0400
X-Google-Smtp-Source: AIpwx48Ty5Q6ir91McJmAqHg7Fe6DLSA9XeYTq0azOYKl4fp4gGGZNhThGUP604s588cRG3p1AF4LLuyf2bv51ycXO0=
MIME-Version: 1.0
In-Reply-To: <5c951129-b167-3ed6-48f4-0a42cd2df28e@metafoo.de>
References: <abdda9da96185f764d58bbf61db9010d0f72d1b3.1523346135.git.baolin.wang@linaro.org>
 <0a9fa618bd74e74c135ebee2e40b30d361c1d905.1523346135.git.baolin.wang@linaro.org>
 <5c951129-b167-3ed6-48f4-0a42cd2df28e@metafoo.de>
From: Baolin Wang <baolin.wang@linaro.org>
Date: Wed, 18 Apr 2018 13:40:54 +0800
Message-ID: <CAMz4ku+zPiucHyLF5HBtH9LhcTDUUec-kTLQG2YQ3hBK=9HHDw@mail.gmail.com>
Subject: Re: [PATCH 5/5] dmaengine: sprd: Add 'device_config' and
 'device_prep_slave_sg' interfaces
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: Dan Williams <dan.j.williams@intel.com>,
        Vinod Koul <vinod.koul@intel.com>,
        Eric Long <eric.long@spreadtrum.com>, Mark Brown <broonie@kernel.org>,
        dmaengine@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17 April 2018 at 18:45, Lars-Peter Clausen <lars@metafoo.de> wrote:
> On 04/10/2018 09:46 AM, Baolin Wang wrote:
> [...]
>> +static int sprd_dma_slave_config(struct dma_chan *chan,
>> +                              struct dma_slave_config *config)
>> +{
>> +     struct sprd_dma_chn *schan = to_sprd_dma_chan(chan);
>> +     struct sprd_dma_config *slave_cfg =
>> +             container_of(config, struct sprd_dma_config, config);
>> +
>
> Please do not overload standard API with custom semantics. This makes the
> driver incompatible to the API and negates the whole idea of having a common
> API. E.g. this will crash when somebody passes a normal dma_slave_config
> struct to this function.
>

Yes, we have discussed with Vinod how to use 'dma_slave_config' to
reach our requirements. Thanks for your comments.

-- 
Baolin.wang
Best Regards
