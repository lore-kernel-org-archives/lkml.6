Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S968195AbeEYUVK (ORCPT <rfc822;w@1wt.eu>);
        Fri, 25 May 2018 16:21:10 -0400
Received: from sandeen.net ([63.231.237.45]:54838 "EHLO sandeen.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S967879AbeEYUVJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 May 2018 16:21:09 -0400
Subject: Re: [PATCH] xfs: mark sb_fname as nonstring
To: Arnd Bergmann <arnd@arndb.de>, Eric Sandeen <sandeen@redhat.com>
Cc: "Darrick J. Wong" <darrick.wong@oracle.com>,
        linux-xfs <linux-xfs@vger.kernel.org>, Martin Sebor <msebor@gmail.com>,
        Brian Foster <bfoster@redhat.com>, Dave Chinner <dchinner@redhat.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Ross Zwisler <ross.zwisler@linux.intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20180525151421.2317292-1-arnd@arndb.de>
 <d6a4b528-4336-48d4-1e0a-7b135c92f97e@redhat.com>
 <CAK8P3a1n3ME0f_mVTcph8aQ3x7rFriypd0kzxz9Up+sZJdLb=g@mail.gmail.com>
From: Eric Sandeen <sandeen@sandeen.net>
Message-ID: <f9b82ff6-49c6-b3e9-361f-1459d884c273@sandeen.net>
Date: Fri, 25 May 2018 15:21:08 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.11; rv:52.0)
 Gecko/20100101 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <CAK8P3a1n3ME0f_mVTcph8aQ3x7rFriypd0kzxz9Up+sZJdLb=g@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/25/18 3:16 PM, Arnd Bergmann wrote:

> On Fri, May 25, 2018 at 6:53 PM, Eric Sandeen <sandeen@redhat.com> wrote:
>> On 5/25/18 10:14 AM, Arnd Bergmann wrote:
...

>>> @@ -1860,7 +1860,7 @@ xfs_ioc_setlabel(
>>>          spin_lock(&mp->m_sb_lock);
>>>          memset(sbp->sb_fname, 0, sizeof(sbp->sb_fname));
>>> -       strncpy(sbp->sb_fname, label, sizeof(sbp->sb_fname));
>>> +       memcpy(sbp->sb_fname, label, len);
>>
>>
>> Hm but len = strnlen(label, XFSLABEL_MAX + 1);
>> which could be one longer than sbp->sb_fname, no?
> 
> We have an explicit check for that, so I think it's ok:
> 
>          if (len > sizeof(sbp->sb_fname))
>                  return -EINVAL;

Ah so we do; I wrote this at least 2 weeks ago, you're asking a lot for
me to remember it.  (or to even read it, apparently).   ;)

Thanks,
-Eric
