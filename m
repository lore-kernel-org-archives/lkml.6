Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S968124AbeEYSsg (ORCPT <rfc822;w@1wt.eu>);
        Fri, 25 May 2018 14:48:36 -0400
Received: from gateway23.websitewelcome.com ([192.185.50.161]:38071 "EHLO
        gateway23.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S967741AbeEYSsd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 May 2018 14:48:33 -0400
X-Authority-Reason: nr=8
Subject: Re: [PATCH v2] ath6kl: mark expected switch fall-throughs
To: Steve deRosier <derosier@gmail.com>
Cc: Kalle Valo <kvalo@qca.qualcomm.com>, davem@davemloft.net,
        sergei.shtylyov@cogentembedded.com,
        linux-wireless <linux-wireless@vger.kernel.org>,
        Network Development <netdev@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
References: <20180525182311.GA3000@embeddedor.com>
 <CALLGbRLFU5xH7PogXmjNSFkayLyo2Q1w1+8hQWgOSDYxS_GgUQ@mail.gmail.com>
From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Message-ID: <43bdc3fc-e922-07c7-df43-bcf05214f283@embeddedor.com>
Date: Fri, 25 May 2018 13:48:22 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <CALLGbRLFU5xH7PogXmjNSFkayLyo2Q1w1+8hQWgOSDYxS_GgUQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 187.192.46.223
X-Source-L: No
X-Exim-ID: 1fMHlQ-0042SN-EV
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: ([192.168.1.70]) [187.192.46.223]:56366
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 26
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 05/25/2018 01:27 PM, Steve deRosier wrote:
> On Fri, May 25, 2018 at 11:23 AM Gustavo A. R. Silva
> <gustavo@embeddedor.com>
> wrote:
> 
>> In preparation to enabling -Wimplicit-fallthrough, mark switch cases
>> where we are expecting to fall through.
> 
>> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
>> ---
>> Changes in v2:
>>     - Place code comments on a line of their own.
> 
>>     drivers/net/wireless/ath/ath6kl/cfg80211.c | 3 +++
>>     1 file changed, 3 insertions(+)
> 
>> diff --git a/drivers/net/wireless/ath/ath6kl/cfg80211.c
> b/drivers/net/wireless/ath/ath6kl/cfg80211.c
>> index 2ba8cf3..a16ee5d 100644
>> --- a/drivers/net/wireless/ath/ath6kl/cfg80211.c
>> +++ b/drivers/net/wireless/ath/ath6kl/cfg80211.c
>> @@ -3899,16 +3899,19 @@ int ath6kl_cfg80211_init(struct ath6kl *ar)
>>            switch (ar->hw.cap) {
>>            case WMI_11AN_CAP:
>>                    ht = true;
>> +               /* fall through */
>>            case WMI_11A_CAP:
>>                    band_5gig = true;
>>                    break;
>>            case WMI_11GN_CAP:
>>                    ht = true;
>> +               /* fall through */
>>            case WMI_11G_CAP:
>>                    band_2gig = true;
>>                    break;
>>            case WMI_11AGN_CAP:
>>                    ht = true;
>> +               /* fall through */
>>            case WMI_11AG_CAP:
>>                    band_2gig = true;
>>                    band_5gig = true;
>> --
>> 2.7.4
> 
> 
> Gustavo,
> 
> Thanks for the adjustment.  It now looks good to me.
>

Glad to help. :)

> Reviewed-by: Steve deRosier <derosier@cal-sierra.com>
> 
Thanks
--
Gustavo
