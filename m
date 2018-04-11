Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752961AbeDKKuC (ORCPT <rfc822;w@1wt.eu>);
        Wed, 11 Apr 2018 06:50:02 -0400
Received: from mail-oi0-f68.google.com ([209.85.218.68]:45535 "EHLO
        mail-oi0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752297AbeDKKuA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Apr 2018 06:50:00 -0400
X-Google-Smtp-Source: AIpwx4/k2RidDrD5Sg4KKa6Yao7iX8lmcRhtFkeR6jisGt1hidJB3OMJDlJfjOxeI2DiMLSPIAtW1OtzRENuVjXz6Tk=
MIME-Version: 1.0
In-Reply-To: <20180411092402.GB6014@localhost>
References: <abdda9da96185f764d58bbf61db9010d0f72d1b3.1523346135.git.baolin.wang@linaro.org>
 <20180411092402.GB6014@localhost>
From: Baolin Wang <baolin.wang@linaro.org>
Date: Wed, 11 Apr 2018 18:49:59 +0800
Message-ID: <CAMz4kuJQEDfKGV6UfdChAhfOmWvFVpAdzuqmxn6H957KsVjHkg@mail.gmail.com>
Subject: Re: [PATCH 1/5] dmaengine: sprd: Define the DMA transfer step type
To: Vinod Koul <vinod.koul@intel.com>
Cc: Dan Williams <dan.j.williams@intel.com>,
        Eric Long <eric.long@spreadtrum.com>, Mark Brown <broonie@kernel.org>,
        dmaengine@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Vinod,

On 11 April 2018 at 17:24, Vinod Koul <vinod.koul@intel.com> wrote:
> On Tue, Apr 10, 2018 at 03:46:03PM +0800, Baolin Wang wrote:
>> From: Eric Long <eric.long@spreadtrum.com>
>>
>> Define the DMA transfer step type to make code more readable.
>>
>> Signed-off-by: Eric Long <eric.long@spreadtrum.com>
>> Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
>> ---
>>  drivers/dma/sprd-dma.c |   28 ++++++++++++++++++++++------
>>  1 file changed, 22 insertions(+), 6 deletions(-)
>>
>> diff --git a/drivers/dma/sprd-dma.c b/drivers/dma/sprd-dma.c
>> index b106e8a..af9c156 100644
>> --- a/drivers/dma/sprd-dma.c
>> +++ b/drivers/dma/sprd-dma.c
>> @@ -169,6 +169,22 @@ enum sprd_dma_int_type {
>>       SPRD_DMA_CFGERR_INT,
>>  };
>>
>> +/*
>> + * enum sprd_dma_step: define the DMA transfer step type
>> + * @SPRD_DMA_NONE_STEP: transfer do not need step
>> + * @SPRD_DMA_BYTE_STEP: transfer step is one byte
>> + * @SPRD_DMA_SHORT_STEP: transfer step is two bytes
>> + * @SPRD_DMA_WORD_STEP: transfer step is one word
>> + * @SPRD_DMA_DWORD_STEP: transfer step is double word
>> + */
>> +enum sprd_dma_step {
>
> looking at bit defines, does it need to be enum? a #define would just be fine.

Right. It seems more clear if we combined them into one enum
structure, but I can convert to #define if you have strong preference.
Thanks.

-- 
Baolin.wang
Best Regards
