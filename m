Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753060AbeFAOqd (ORCPT <rfc822;w@1wt.eu>);
        Fri, 1 Jun 2018 10:46:33 -0400
Received: from gateway20.websitewelcome.com ([192.185.4.169]:47085 "EHLO
        gateway20.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1753032AbeFAOq3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jun 2018 10:46:29 -0400
X-Authority-Reason: nr=8
Subject: Re: [PATCH] qtnfmac: fix NULL pointer dereference
To: Igor Mitsyanko <imitsyanko@quantenna.com>,
        Avinash Patil <avinashp@quantenna.com>,
        Sergey Matyukevich <smatyukevich@quantenna.com>,
        Kalle Valo <kvalo@codeaurora.org>,
        "David S. Miller" <davem@davemloft.net>,
        linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
References: <20180601132408.GA2572@embeddedor.com>
 <20180601140848.czb4ws5nixuk4tjb@bars>
From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Message-ID: <14b57d7b-15cf-dfd8-d64c-2200d435d2f6@embeddedor.com>
Date: Fri, 1 Jun 2018 09:22:28 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180601140848.czb4ws5nixuk4tjb@bars>
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
X-Exim-ID: 1fOkxH-001eBw-Kt
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: ([192.168.1.70]) [187.192.46.223]:50550
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 8
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sergey,

On 06/01/2018 09:08 AM, Sergey Matyukevich wrote:
> Hello Gustavo,
> 
>> diff --git a/drivers/net/wireless/quantenna/qtnfmac/cfg80211.c b/drivers/net/wireless/quantenna/qtnfmac/cfg80211.c
>> index 220e2b7..ae0ca80 100644
>> --- a/drivers/net/wireless/quantenna/qtnfmac/cfg80211.c
>> +++ b/drivers/net/wireless/quantenna/qtnfmac/cfg80211.c
>> @@ -654,8 +654,7 @@ qtnf_disconnect(struct wiphy *wiphy, struct net_device *dev,
>>          vif = qtnf_mac_get_base_vif(mac);
>>          if (!vif) {
>>                  pr_err("MAC%u: primary VIF is not configured\n", mac->macid);
>> -               ret = -EFAULT;
>> -               goto out;
>> +               return -EFAULT;
>>          }
>>
>>          if (vif->wdev.iftype != NL80211_IFTYPE_STATION) {
> 
> That was my fault. Thanks for the fix!
> 

Glad to help. :)

> Reviewed-by: Sergey Matyukevich <sergey.matyukevich.os@quanenna.com>
> 

Thanks
--
Gustavo
