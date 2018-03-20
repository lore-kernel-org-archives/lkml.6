Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751826AbeCTQkA (ORCPT <rfc822;w@1wt.eu>);
        Tue, 20 Mar 2018 12:40:00 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:59184 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751317AbeCTQjz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Mar 2018 12:39:55 -0400
Message-ID: <5AB13953.3000606@ORACLE.COM>
Date: Tue, 20 Mar 2018 18:39:47 +0200
From: Liran Alon <LIRAN.ALON@ORACLE.COM>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:24.0) Gecko/20100101 Thunderbird/24.5.0
MIME-Version: 1.0
To: David Miller <davem@davemloft.net>
CC: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        idan.brown@ORACLE.COM, yuval.shaia@ORACLE.COM
Subject: Re: [PATCH] net: dev_forward_skb(): Scrub packet's per-netns info
 only when crossing netns
References: <5AB12A0E.2060704@ORACLE.COM>       <20180320.120036.1999626754164343704.davem@davemloft.net>       <5AB132C5.5010806@ORACLE.COM> <20180320.123401.2138083793709750726.davem@davemloft.net>
In-Reply-To: <20180320.123401.2138083793709750726.davem@davemloft.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8838 signatures=668695
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1803200127
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 20/03/18 18:34, David Miller wrote:
> From: Liran Alon <LIRAN.ALON@ORACLE.COM>
> Date: Tue, 20 Mar 2018 18:11:49 +0200
>
>> 1. Do we want to make a flag for every bug that is user-space visible?
>> I think there is place for consideration on a per-case basis. I still
>> don't see how a user can utilize this behaviour. He is basically
>> loosing information (skb->mark) without this patch.
>
> And maybe people trying to work in this situation have added code to
> get the mark set some other way, or to validate that it is in fact
> zero after passing through, which we would break with this change.
>
> If it's set to zero now, it's reasonable to expect it to be zero.
>
> By changing it to non-zero, different rules and routes will match
> and this for sure has potential to break things.
>

OK.

What is your opinion in regards if it's OK to put the flag enabling this 
"fix" in /proc/sys/net/core? Do you think it's sufficient?
