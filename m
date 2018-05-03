Return-Path: <steven.sistare@oracle.com>
X-Google-Smtp-Source: AB8JxZq94GOXBPqFDA54azk5fW0Y2q8sRK/Gt1TYOyryaHItRkr5iEiASSgWbBaQAHDDxwXPM8EA
ARC-Seal: i=1; a=rsa-sha256; t=1525356115; cv=none;
        d=google.com; s=arc-20160816;
        b=WNK1hat6aUwhH7EpCdeSHXjWiOPcAhjNDbw38JeFxkPVb5cbadflVj0q/fxcqEkxDZ
         I0MdWmCRchsSEJOZYhACOp9arq6udOpavQpZLlVt+RdiQqvy/xAeS+G4kTcJfG2BDlIi
         VzHTUhTdM9rF9KTMnb9teQJZs1OC4SVzXVnYqXVQY1XdYHPJalqRP9VFOPxY8/kAyt+V
         3TxnmeV9YK4+iyubJPXN6SNnJEhBdNc1xfsbU/5ZhXzim9dLXU1dXAO7ptkjlVysFD7m
         AtluIYQMlsLw0V/8i3H7F+tzsRbyM9jR5gVcyJJtiCY8LFr5Bd1fMCvA2QMhvLqRw+va
         yOHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:organization:from:references:cc:to
         :subject:dkim-signature:arc-authentication-results;
        bh=PohBH8dYcnEmHNk0ec8UQQsaVnPdrEVBdn3RQHZPXyk=;
        b=qaja9nS8WDtMJ3jQ4xbn6WfhwOuxwzbZJiZV1ZTuJip870juzxlnQm9jqRhQh5/qE2
         rXw8atuEX3olq4ZDuSk8K7B8gmeHVvudrcqGR4uIUcoAwNRpzvdXNtxm69xiT4kKFgah
         IDLZQYSU5f8z8A9YHdaJNvpuzi+L+GLyFRG4PEnXFRLhuoRgmy/RVz1GlIVaA7dLUlqS
         2z5pAH9TOS0UhNh61pVXmBJUYK/uYek2GPkpbgalQ5aMxoQbje4avVmvH4qQl/bQn/CW
         mcXOMnvZmSi763wUUaX3PbFdEMWUD+LMaP47O7NA7tZcHVvcDLyj36DpQyF+fFFyT8Wd
         63oQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@oracle.com header.s=corp-2017-10-26 header.b=AUOx9Fk2;
       spf=pass (google.com: domain of steven.sistare@oracle.com designates 141.146.126.79 as permitted sender) smtp.mailfrom=steven.sistare@oracle.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=oracle.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@oracle.com header.s=corp-2017-10-26 header.b=AUOx9Fk2;
       spf=pass (google.com: domain of steven.sistare@oracle.com designates 141.146.126.79 as permitted sender) smtp.mailfrom=steven.sistare@oracle.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=oracle.com
Subject: Re: [PATCH 1/2] ixgbe: release lock for the duration of
 ixgbe_suspend_close()
To: Pavel Tatashin <pasha.tatashin@oracle.com>
Cc: Alexander Duyck <alexander.duyck@gmail.com>,
        Daniel Jordan <daniel.m.jordan@oracle.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Jeff Kirsher <jeffrey.t.kirsher@intel.com>,
        intel-wired-lan <intel-wired-lan@lists.osuosl.org>,
        Netdev <netdev@vger.kernel.org>, Greg KH <gregkh@linuxfoundation.org>
References: <20180503035931.22439-1-pasha.tatashin@oracle.com>
 <20180503035931.22439-2-pasha.tatashin@oracle.com>
 <CAKgT0UdocfEm9oXZ1dkEMari8m3OA4uVTrYg45uj9fk2V41bxQ@mail.gmail.com>
 <CAGM2rea3XXJ7OqGeAdexyOUb1_7W_84t5HAb_hp7Rb=TkTM86Q@mail.gmail.com>
 <CAKgT0UfNBugQywBZuepUJ6deEYsSWmTw3b6VbQBJLn-kKXe7ng@mail.gmail.com>
From: Steven Sistare <steven.sistare@oracle.com>
Organization: Oracle Corporation
Message-ID: <50c9ac34-3971-ac1b-0b5e-1bfa004fd4cf@oracle.com>
Date: Thu, 3 May 2018 10:01:40 -0400
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <CAKgT0UfNBugQywBZuepUJ6deEYsSWmTw3b6VbQBJLn-kKXe7ng@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8881 signatures=668698
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1805030123
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1599413925684033451?=
X-GMAIL-MSGID: =?utf-8?q?1599451814078907707?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 5/3/2018 9:46 AM, Alexander Duyck wrote:
> On Thu, May 3, 2018 at 6:30 AM, Pavel Tatashin
> <pasha.tatashin@oracle.com> wrote:
>> Hi Alex,
> 
> Hi Pavel,
> 
>>> I'm not a fan of dropping the mutex while we go through
>>> ixgbe_close_suspend. I'm concerned it will result in us having a
>>> number of races on shutdown.
>>
>> I would agree, but ixgbe_close_suspend() is already called without this
>> mutex from ixgbe_close(). This path is executed also during machine
>> shutdown but when kexec'ed. So, it is either an existing bug or there are
>> no races. But, because ixgbe_close() is called from the userland, and a
>> little earlier than ixgbe_shutdown() I think this means there are no races.
> 
> All callers of ixgbe_close are supposed to already be holding the RTNL
> mutex. That is the whole reason why we need to hold it here as the
> shutdown path doesn't have the mutex held otherwise. The mutex was
> added here because shutdown was racing with the open/close calls.
> 
>>
>>> If anything, I think we would need to find a replacement for the mutex
>>> that can operate at the per-netdev level if you are wanting to
>>> parallelize this.
>>
>> Yes, if lock is necessary, it can be replaced in this place (and added to
>> ixgbe_close())  with something scalable.
> 
> I wouldn't suggest adding yet another lock for all this. Instead it
> might make more sense for us to start looking at breaking up the
> locking since most of the networking subsystem uses the rtnl_lock call
> it might be time to start looking at doing something like cutting back
> on the use of this in cases where all the resources needed are
> specific to one device and instead have a per device lock that could
> address those kind of cases.

Hi Pavel, you might want to pull lock optimization out of this patch series.
The parallelization by itself is valuable, and optimizations for individual 
devices including locks can come later.

- Steve
