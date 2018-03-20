Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751522AbeCTVNG (ORCPT <rfc822;w@1wt.eu>);
        Tue, 20 Mar 2018 17:13:06 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:47330 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751004AbeCTVNB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Mar 2018 17:13:01 -0400
Message-ID: <5AB17953.5000609@ORACLE.COM>
Date: Tue, 20 Mar 2018 23:12:51 +0200
From: Liran Alon <LIRAN.ALON@ORACLE.COM>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:24.0) Gecko/20100101 Thunderbird/24.5.0
MIME-Version: 1.0
To: valdis.kletnieks@vt.edu
CC: David Miller <davem@davemloft.net>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, idan.brown@ORACLE.COM,
        yuval.shaia@ORACLE.COM
Subject: Re: [PATCH] net: dev_forward_skb(): Scrub packet's per-netns info
 only when crossing netns
References: <5AB12A0E.2060704@ORACLE.COM> <20180320.120036.1999626754164343704.davem@davemloft.net> <5AB132C5.5010806@ORACLE.COM> <20180320.123401.2138083793709750726.davem@davemloft.net> <5AB13953.3000606@ORACLE.COM> <55538.1521571867@turing-police.cc.vt.edu>
In-Reply-To: <55538.1521571867@turing-police.cc.vt.edu>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8838 signatures=668695
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=1 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=745
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1803200127
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 20/03/18 20:51, valdis.kletnieks@vt.edu wrote:
> On Tue, 20 Mar 2018 18:39:47 +0200, Liran Alon said:
>> What is your opinion in regards if it's OK to put the flag enabling this
>> "fix" in /proc/sys/net/core? Do you think it's sufficient?
>
> Umm.. *which* /proc/sys/net/core?  These could differ for things that
> are in different namespaces.  Or are you proposing one systemwide
> global value (which also gets "interesting" if it's writable inside a
> container and changes the behavior a different container sees...)
>

I'm indeed proposing an opt-in system-wide global value.
I think it is the simplest approach to fix the issue at
hand here while maintaining backwards-compatibility.

I'm open to suggestions to where that system-wide
global value should be.

It must be a system-wide global value if we are not going
with the per-netdev flag approach as this system-wide global flag
should control how a skb is travelled between different netns.
So it doesn't belong to any one single netns.
