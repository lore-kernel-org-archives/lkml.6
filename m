Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751916AbeCTQMC (ORCPT <rfc822;w@1wt.eu>);
        Tue, 20 Mar 2018 12:12:02 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:56760 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751866AbeCTQMA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Mar 2018 12:12:00 -0400
Message-ID: <5AB132C5.5010806@ORACLE.COM>
Date: Tue, 20 Mar 2018 18:11:49 +0200
From: Liran Alon <LIRAN.ALON@ORACLE.COM>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:24.0) Gecko/20100101 Thunderbird/24.5.0
MIME-Version: 1.0
To: David Miller <davem@davemloft.net>
CC: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        idan.brown@ORACLE.COM, yuval.shaia@ORACLE.COM
Subject: Re: [PATCH] net: dev_forward_skb(): Scrub packet's per-netns info
 only when crossing netns
References: <1520953642-8145-1-git-send-email-liran.alon@oracle.com>    <20180320.104759.796804827689233281.davem@davemloft.net>        <5AB12A0E.2060704@ORACLE.COM> <20180320.120036.1999626754164343704.davem@davemloft.net>
In-Reply-To: <20180320.120036.1999626754164343704.davem@davemloft.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8837 signatures=668693
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1803200127
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 20/03/18 18:00, David Miller wrote:
> From: Liran Alon <LIRAN.ALON@ORACLE.COM>
> Date: Tue, 20 Mar 2018 17:34:38 +0200
>
>> I personally don't understand why we should maintain
>> backwards-comparability to this behaviour.
>
> The reason is because not breaking things is a cornerstone of Linux
> kernel development.
>
>> This feature is not documented to user-mode and I don't see why it
>> is legit for the user to rely on it.
>
> Whether it is documented or not is irrelevant.  A lot of our
> interfaces and behaviors are not documented or poorly documented
> at best.
>
>> In addition, even if we do want to maintain backwards-comparability to
>> this behaviour, I think it is enough to have an opt-in flag in
>> /proc/sys/net/core/ that when set to 1 will activate the fix in
>> dev_forward_skb() provided by this patch. That would also be a very
>> simple change to the patch provided here.
>
> Making it opt-in makes it more palatable, that's for sure.
>

1. Do we want to make a flag for every bug that is user-space visible? I 
think there is place for consideration on a per-case basis. I still 
don't see how a user can utilize this behaviour. He is basically loosing 
information (skb->mark) without this patch.

2. Having said that, I don't mind changing patch to maintain backwards 
compatibility here. However, there was also a discussion here on where 
the flag should sit. I think that a global /proc/sys/net/core/ flag 
should be enough. Do you agree it's sufficient for now?

Thanks,
-Liran
