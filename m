Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753035AbeDDCvW (ORCPT <rfc822;w@1wt.eu>);
        Tue, 3 Apr 2018 22:51:22 -0400
Received: from mail-ot0-f171.google.com ([74.125.82.171]:35713 "EHLO
        mail-ot0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750758AbeDDCvU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Apr 2018 22:51:20 -0400
X-Google-Smtp-Source: AIpwx4+x2Ugf2SAqoPIU+fCUgyqi/IGFGToTXZpTe5XB6a/aYa/riU/07eN4mp1GD5Py68cZlakmsw==
Subject: Re: RTL8723BE performance regression
To: =?UTF-8?Q?Jo=c3=a3o_Paulo_Rechi_Vita?= <jprvita@gmail.com>
Cc: Yan-Hsuan Chuang <yhchuang@realtek.com>,
        Ping-Ke Shih <pkshih@realtek.com>, Birming Chiu <birming@realtek.com>,
        Shaofu <shaofu@realtek.com>, Steven Ting <steventing@realtek.com>,
        Chaoming Li <chaoming_li@realsil.com.cn>,
        Kalle Valo <kvalo@codeaurora.org>,
        linux-wireless <linux-wireless@vger.kernel.org>,
        Network Development <netdev@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, Daniel Drake <drake@endlessm.com>,
        =?UTF-8?Q?Jo=c3=a3o_Paulo_Rechi_Vita?= <jprvita@endlessm.com>,
        linux@endlessm.com
References: <CA+A7VXX+z8FrDhzW2BQ6AGMJ=_j_53wkUL_YNgkreEbWSh+jCw@mail.gmail.com>
 <afdf0498-c0a9-936c-0c9b-1b6da6eb5957@lwfinger.net>
 <CA+A7VXWjWaSSUiX3h_rpFXrSwtUkynKR9tpvnsSe=DZrC+mF-Q@mail.gmail.com>
From: Larry Finger <Larry.Finger@lwfinger.net>
Message-ID: <059b40f0-b8e2-b55f-92d5-a859ba4204a4@lwfinger.net>
Date: Tue, 3 Apr 2018 21:51:18 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <CA+A7VXWjWaSSUiX3h_rpFXrSwtUkynKR9tpvnsSe=DZrC+mF-Q@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/03/2018 09:37 PM, João Paulo Rechi Vita wrote:
> On Tue, Apr 3, 2018 at 7:28 PM, Larry Finger <Larry.Finger@lwfinger.net> wrote:
> 
> (...)
> 
>> As the antenna selection code changes affected your first bisection, do you
>> have one of those HP laptops with only one antenna and the incorrect coding
>> in the FUSE?
> 
> Yes, that is why I've been passing ant_sel=1 during my tests -- this
> was needed to achieve a good performance in the past, before this
> regression. I've also opened the laptop chassis and confirmed the
> antenna cable is plugged to the connector labeled with "1" on the
> card.
> 
>> If so, please make sure that you still have the same signal
>> strength for good and bad cases. I have tried to keep the driver and the
>> btcoex code in sync, but there may be some combinations of antenna
>> configuration and FUSE contents that cause the code to fail.
>>
> 
> What is the recommended way to monitor the signal strength?

The btcoex code is developed for multiple platforms by a different group than 
the Linux driver. I think they made a change that caused ant_sel to switch from 
1 to 2. At least numerous comments at github.com/lwfinger/rtlwifi_new claimed 
they needed to make that change.

Mhy recommended method is to verify the wifi device name with "iw dev". Then 
using that device

sudo iw dev <dev_name> scan | egrep "SSID|signal"

Larry
