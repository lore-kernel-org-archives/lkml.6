Return-Path: <pasha.tatashin@oracle.com>
X-Google-Smtp-Source: AB8JxZr/x1uMJpWbfrZzCOaaANdovtiOIYbqwAr7VMUd+C8A5ByBBS3hDC5vvznDVf6tmyBcaewS
ARC-Seal: i=1; a=rsa-sha256; t=1526349198; cv=none;
        d=google.com; s=arc-20160816;
        b=QUOYxBoOWdri3DcIx4RN/5jt2vFTLVLhY5AyLF70HrqiMJ1bTqPGA4eFfw6yJ3LSjY
         O91exng9sGfIAclv4MJftJyVPcM0ozbhaekouxRvkMtLfd1MsJzWjYW90w7fta+TELsl
         hp7Bt3y9AWBFPRhH9Vm3cTUADS51P8qSudRu2Pc9k+AgpCei2dwyZbZaiSS5G6RYXnxS
         jo/eg6N1vFfAygFpN9+JBYuF7aDIycYkyRUjmn/6+Yz2yBcqtwDzTw7+0gdR3aGKOMln
         CaVxUs6zjoygpawqC1t6+jFzqJkqKiVdXI80Z0xM/hJl81mbz2lz8z4UxvU3ycx/c/+s
         SKNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :dkim-signature:arc-authentication-results;
        bh=fiT2gC8mOXb1gHFNa8Hhtq58TMgikU9O7j0E5H1sJIc=;
        b=AbEHVmVHT3j2emdFT99/ESmBrij3nk9STSMmPVyNtoRUMrc2vwyS4kckIzMxDknCRu
         V+U/1c+p6CyYNmB3gLxZBz7HLXHGsOFiSeTV788aC5Fz2NiwY9oaf7OwAdHKuzaGysPr
         4vMYOdpGSQqiFIfvFsDs9LeVZOCgguS5DGtgMTyy9siLlNYn6ZRAb8MsdzHr25iti3jm
         HAkPxgvY+e5isloLnIAuC4kjkl26jnI8kRmidXBizCDe+ipq8az0Ct+jc6er0S9jER5z
         VslbQ3cBqp0vujfhS6YwT9Qv+lRqFDC9lA6L5xBkKZF02swwQMGFsHud9TzFNmGxnHLv
         lpig==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@oracle.com header.s=corp-2017-10-26 header.b=gIFe+hJS;
       spf=pass (google.com: domain of pasha.tatashin@oracle.com designates 141.146.126.78 as permitted sender) smtp.mailfrom=pasha.tatashin@oracle.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=oracle.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@oracle.com header.s=corp-2017-10-26 header.b=gIFe+hJS;
       spf=pass (google.com: domain of pasha.tatashin@oracle.com designates 141.146.126.78 as permitted sender) smtp.mailfrom=pasha.tatashin@oracle.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=oracle.com
Subject: Re: [PATCH v4 1/1] drivers core: multi-threading device shutdown
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Steven Sistare <steven.sistare@oracle.com>,
        Daniel Jordan <daniel.m.jordan@oracle.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Kirsher, Jeffrey T" <jeffrey.t.kirsher@intel.com>,
        intel-wired-lan@lists.osuosl.org, netdev <netdev@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        alexander.duyck@gmail.com, tobin@apporbit.com
References: <20180514194254.14748-1-pasha.tatashin@oracle.com>
 <20180514194254.14748-2-pasha.tatashin@oracle.com>
 <CAHp75VeopFMFHq=rJCUcAw02kznJ5+0vLWr5500DsGtERiX6cw@mail.gmail.com>
From: Pavel Tatashin <pasha.tatashin@oracle.com>
Message-ID: <2d3c80ee-f990-0619-8107-7a0cb4c76f04@oracle.com>
Date: Mon, 14 May 2018 21:53:02 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <CAHp75VeopFMFHq=rJCUcAw02kznJ5+0vLWr5500DsGtERiX6cw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8893 signatures=668698
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1805150016
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1600469847842803826?=
X-GMAIL-MSGID: =?utf-8?q?1600493137270002954?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi Andy,

Thank you for your comments. I will send an updated patch soon. My replies are below:

On 05/14/2018 04:04 PM, Andy Shevchenko wrote:

> Can we still preserve an order here? (Yes, even if the entire list is
> not fully ordered)
> In the context I see it would go before netdevice.h.

Sure, I will move kthread.h.

>> +static struct device *
>> +device_get_child_by_index(struct device *parent, int index)
>> +{
>> +       struct klist_iter i;
>> +       struct device *dev = NULL, *d;
>> +       int child_index = 0;
>> +
>> +       if (!parent->p || index < 0)
>> +               return NULL;
>> +
>> +       klist_iter_init(&parent->p->klist_children, &i);
>> +       while ((d = next_device(&i))) {
>> +               if (child_index == index) {
>> +                       dev = d;
>> +                       break;
>> +               }
>> +               child_index++;
>> +       }
>> +       klist_iter_exit(&i);
>> +
>> +       return dev;
>> +}
> 
> This can be implemented as a subfunction to device_find_child(), can't it be?

Yes, but that would make it very inefficient to search for an index in a list via function pointer call.

> 
>> +/**
> 
> Hmm... Why it's marked as kernel doc while it's just a plain comment?
> Same applies to the rest of similar comments.

Fixed this, thanks!

> 
>> +               for (i = 0; i < children_count; i++) {
>> +                       if (device_shutdown_serial) {
>> +                               device_shutdown_child_task(&tdata);
>> +                       } else {
>> +                               kthread_run(device_shutdown_child_task,
>> +                                           &tdata, "device_shutdown.%s",
>> +                                           dev_name(dev));
>> +                       }
>> +               }
> 
> Can't we just use device_for_each_child() instead?

No, at least without doing some memory allocation. Notice in this loop we are not traversing through children, instead we are starting number of children threads, and each thread finds a child to work on. Otherwise we would have to pass child pointer via argument, and we would need to keep that argument in some memory.

Pavel
