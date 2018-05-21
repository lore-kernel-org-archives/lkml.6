Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752918AbeEUMRS (ORCPT <rfc822;w@1wt.eu>);
        Mon, 21 May 2018 08:17:18 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:34645 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752645AbeEUMRM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 May 2018 08:17:12 -0400
X-Google-Smtp-Source: AB8JxZqzz1hcEL7YmRqouJDqh8pI8MZddNR7Uo7+vL35VwtWegV3rDdOQ9UOI8JZQ5wDz+uo5ZpyPg==
Subject: Re: [PATCH v2 07/29] venus: hfi_venus: add halt AXI support for Venus
 4xx
To: Tomasz Figa <tfiga@google.com>,
        Stanimir Varbanov <stanimir.varbanov@linaro.org>
Cc: Mauro Carvalho Chehab <mchehab@kernel.org>,
        Hans Verkuil <hverkuil@xs4all.nl>,
        Linux Media Mailing List <linux-media@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>, vgarodia@codeaurora.org
References: <20180515075859.17217-1-stanimir.varbanov@linaro.org>
 <20180515075859.17217-8-stanimir.varbanov@linaro.org>
 <CAAFQd5Ck1x1voV3=G_3yJEh_0S-4kYkx13P00kyMRbhJ4=sSCA@mail.gmail.com>
From: Stanimir Varbanov <stanimir.varbanov@linaro.org>
Message-ID: <642a4a69-70fb-c72d-5700-1c55755d3073@linaro.org>
Date: Mon, 21 May 2018 15:17:09 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <CAAFQd5Ck1x1voV3=G_3yJEh_0S-4kYkx13P00kyMRbhJ4=sSCA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Tomasz,

On 05/18/2018 05:23 PM, Tomasz Figa wrote:
> On Tue, May 15, 2018 at 5:12 PM Stanimir Varbanov <
> stanimir.varbanov@linaro.org> wrote:
> 
>> Add AXI halt support for version 4xx by using venus wrapper
>> registers.
> 
>> Signed-off-by: Stanimir Varbanov <stanimir.varbanov@linaro.org>
>> ---
>>   drivers/media/platform/qcom/venus/hfi_venus.c | 17 +++++++++++++++++
>>   1 file changed, 17 insertions(+)
> 
>> diff --git a/drivers/media/platform/qcom/venus/hfi_venus.c
> b/drivers/media/platform/qcom/venus/hfi_venus.c
>> index 734ce11b0ed0..53546174aab8 100644
>> --- a/drivers/media/platform/qcom/venus/hfi_venus.c
>> +++ b/drivers/media/platform/qcom/venus/hfi_venus.c
>> @@ -532,6 +532,23 @@ static int venus_halt_axi(struct venus_hfi_device
> *hdev)
>>          u32 val;
>>          int ret;
> 
>> +       if (hdev->core->res->hfi_version == HFI_VERSION_4XX) {
>> +               val = venus_readl(hdev, WRAPPER_CPU_AXI_HALT);
>> +               val |= BIT(16);
> 
> Can we have the bit defined?
> 
>> +               venus_writel(hdev, WRAPPER_CPU_AXI_HALT, val);
>> +
>> +               ret = readl_poll_timeout(base +
> WRAPPER_CPU_AXI_HALT_STATUS,
>> +                                        val, val & BIT(24),
> 
> Ditto.

Sure will add defines.

-- 
regards,
Stan
