Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1033054AbeBNQx7 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Feb 2018 11:53:59 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:34048 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1033026AbeBNQxz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Feb 2018 11:53:55 -0500
Subject: Re: KASAN: use-after-free Read in rds_find_bound
To: Dmitry Vyukov <dvyukov@google.com>
Cc: syzbot <syzbot+93a5839deb355537440f@syzkaller.appspotmail.com>,
        linux-rdma@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        David Miller <davem@davemloft.net>,
        LKML <linux-kernel@vger.kernel.org>, netdev <netdev@vger.kernel.org>,
        rds-devel@oss.oracle.com
References: <089e08231920353a4805618b365c@google.com>
 <d91da249-5a0f-7a1f-cfd5-68f10f0a2fc1@oracle.com>
 <CACT4Y+bd6Tyq672JC3GNSHPX2CEHacVKkcbKOAgpi8o-=T8DRg@mail.gmail.com>
From: Santosh Shilimkar <santosh.shilimkar@oracle.com>
Organization: Oracle Corporation
Message-ID: <491a26b8-7abb-0d36-0a2e-e1c7bfcde79d@oracle.com>
Date: Wed, 14 Feb 2018 08:53:47 -0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <CACT4Y+bd6Tyq672JC3GNSHPX2CEHacVKkcbKOAgpi8o-=T8DRg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8804 signatures=668670
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=906
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1802140200
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/13/2018 12:12 PM, Dmitry Vyukov wrote:
> On Sat, Dec 30, 2017 at 8:41 PM, santosh.shilimkar@oracle.com
> <santosh.shilimkar@oracle.com> wrote:
>> On 12/30/17 1:17 AM, syzbot wrote:
>>>
>>> Hello,
>>>
>>> syzkaller hit the following crash on
>>> fba961ab29e5ffb055592442808bb0f7962e05da
>>> git://git.kernel.org/pub/scm/linux/kernel/git/davem/net-next.git/master
>>> compiler: gcc (GCC) 7.1.1 20170620
>>> .config is attached
>>> Raw console output is attached.
>>> Unfortunately, I don't have any reproducer for this bug yet.
>>>
>>>
>>> IMPORTANT: if you fix the bug, please add the following tag to the commit:
>>> Reported-by: syzbot+93a5839deb355537440f@syzkaller.appspotmail.com
>>
>>
>> Posted a fix[1] for above issue. Didn't test it but looks straight
>> forward.
> 
> 
> Hi Santosh,
> 
> What is that fix? You forgot to provide any link/reference. I also
> don't see any patches from you at around that date...
> 
Fix [1] was later not added since there was a still a race. Wanted to
see if the issue re-appears after recent netns fix [2].

Regards,
Santosh


[1] https://patchwork.kernel.org/patch/10137901/
[2] https://patchwork.ozlabs.org/patch/868902/
