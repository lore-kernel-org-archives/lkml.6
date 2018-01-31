Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752974AbeAaDuL (ORCPT <rfc822;w@1wt.eu>);
        Tue, 30 Jan 2018 22:50:11 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:45524 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751598AbeAaDuJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jan 2018 22:50:09 -0500
Subject: Re: BUG: spinlock bad magic (2)
To: Eric Biggers <ebiggers3@gmail.com>, Dmitry Vyukov <dvyukov@google.com>
Cc: syzbot
        <bot+d3f5d339869eb8cd834d2c9f0a88bf4f05c29781@syzkaller.appspotmail.com>,
        David Miller <davem@davemloft.net>,
        LKML <linux-kernel@vger.kernel.org>, linux-rdma@vger.kernel.org,
        netdev <netdev@vger.kernel.org>, rds-devel@oss.oracle.com,
        syzkaller-bugs@googlegroups.com
References: <001a113fae28c2fd6605609c97a2@google.com>
 <6dbd4f85-f3f2-97f3-5b82-451276fbf877@oracle.com>
 <CACT4Y+Zoat=3j7B--D=pLK=SU0zhNA2yw0O0cEwj_p6vSBfM7g@mail.gmail.com>
 <20180130222811.yxfiqnlx3la3vyyw@gmail.com>
From: "santosh.shilimkar@oracle.com" <santosh.shilimkar@oracle.com>
Organization: Oracle Corporation
Message-ID: <24ea899d-d541-0274-c5bf-8a6e35473ca5@oracle.com>
Date: Tue, 30 Jan 2018 19:49:51 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.13; rv:52.0)
 Gecko/20100101 Thunderbird/52.5.2
MIME-Version: 1.0
In-Reply-To: <20180130222811.yxfiqnlx3la3vyyw@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8790 signatures=668657
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=356
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1801310047
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 1/30/18 2:28 PM, Eric Biggers wrote:
> On Mon, Dec 18, 2017 at 06:01:30PM +0100, 'Dmitry Vyukov' via syzkaller-bugs wrote:
>> On Mon, Dec 18, 2017 at 5:46 PM, Santosh Shilimkar
>> <santosh.shilimkar@oracle.com> wrote:
>>> On 12/18/2017 4:36 AM, syzbot wrote:
>>>>
>>>> Hello,
>>>>
>>>> syzkaller hit the following crash on
>>>> 6084b576dca2e898f5c101baef151f7bfdbb606d
>>>> git://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/master
>>>> compiler: gcc (GCC) 7.1.1 20170620
>>>> .config is attached
>>>> Raw console output is attached.
>>>>
>>>> Unfortunately, I don't have any reproducer for this bug yet.
>>>>
>>> [...]
>>>
>>>> BUG: unable to handle kernel NULL pointer dereference at 0000000000000028
>>>> IP: rds_send_xmit+0x80/0x930 net/rds/send.c:186
>>>
>>>
>>> This one seems to be same bug as reported as below.
>>>
>>> BUG: unable to handle kernel NULL pointer dereference in rds_send_xmit
>>
>> Hi Santosh,
>>
>> The proper syntax to tell syzbot about dups is this (from email footer):
>>
>>> See https://goo.gl/tpsmEJ for details.
>>> Please credit me with: Reported-by: syzbot <syzkaller@googlegroups.com>
>>> syzbot will keep track of this bug report.
>>> To mark this as a duplicate of another syzbot report, please reply with:
>>> #syz dup: exact-subject-of-another-report
>>> Note: all commands must start from beginning of the line in the email body.
> 
> #syz dup: BUG: unable to handle kernel NULL pointer dereference in rds_send_xmit

Ok. Noted.
