Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751548AbeCTHAH (ORCPT <rfc822;w@1wt.eu>);
        Tue, 20 Mar 2018 03:00:07 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:51240 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751394AbeCTHAD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Mar 2018 03:00:03 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org C423060314
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=mgautam@codeaurora.org
Subject: Re: [PATCH 4/6] phy: qcom-qmp: Add QMP V3 USB3 UNI PHY support for
 sdm845
To: Evan Green <evgreen@chromium.org>
Cc: kishon@ti.com, linux-arm-msm@vger.kernel.org,
        vivek.gautam@codeaurora.org, varada@codeaurora.org,
        weiyongjun1@huawei.com, fengguang.wu@intel.com,
        linux-kernel@vger.kernel.org
References: <1521193500-4696-1-git-send-email-mgautam@codeaurora.org>
 <1521193500-4696-5-git-send-email-mgautam@codeaurora.org>
 <CAE=gft6yM58dru2DnjASbi+YG_KanDbBhO2nCLBerZw4NjT-=g@mail.gmail.com>
From: Manu Gautam <mgautam@codeaurora.org>
Message-ID: <5db561b9-0c39-14d3-f924-9e5db75f6600@codeaurora.org>
Date: Tue, 20 Mar 2018 12:29:52 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <CAE=gft6yM58dru2DnjASbi+YG_KanDbBhO2nCLBerZw4NjT-=g@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,


On 3/19/2018 11:21 PM, Evan Green wrote:
> Hi Manu,
>
> On Fri, Mar 16, 2018 at 2:46 AM Manu Gautam <mgautam@codeaurora.org> wrote:
[snip]
>> index d1c6905..5d78d43 100644
>> --- a/drivers/phy/qualcomm/phy-qcom-qmp.h
>> +++ b/drivers/phy/qualcomm/phy-qcom-qmp.h
>> @@ -214,6 +214,8 @@
>>   #define QSERDES_V3_RX_UCDR_FASTLOCK_FO_GAIN            0x030
>>   #define QSERDES_V3_RX_UCDR_SO_SATURATION_AND_ENABLE    0x034
>>   #define QSERDES_V3_RX_RX_TERM_BW                       0x07c
>> +#define QSERDES_V3_RX_VGA_CAL_CNTRL1                   0x0bc
> I noticed you add this definition, but never use it. Are you missing a
> QMP_PHY_INIT_CFG line for this register in qmp_v3_usb3_uniphy_rx_tbl[], or
> is that register "don't care"? It looks important, and while its default
> value out of reset might be valid, you never know what nutty value boot
> firmware might set it to.
>

Yes POR value of this register is valid for this soc.
QMP driver resets (asserts and de-asserts reset_control) in probe. So, that should
ensure that PHY registers are indeed set to POR value. Left the definition there
if different setting needed to be done for a different variant of h/w in future.

-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
