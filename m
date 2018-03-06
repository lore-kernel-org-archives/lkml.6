Return-Path: <logang@deltatee.com>
X-Google-Smtp-Source: AG47ELs/rlipHquI/wQD9Yd/lG5mFjjLmvCXmQXf3BD/669eeypjheYBIfokPt3kB8zcrtdHPk6p
ARC-Seal: i=1; a=rsa-sha256; t=1520355844; cv=none;
        d=google.com; s=arc-20160816;
        b=KZi4f2On81IY7nHhHnWIUteOhNbwJSwRwdbiOwtz826WDR6KcVliE4q5AT3MTyuCfJ
         LQUU6T0ZgJfgyu773ZXY6tjrHlsqNpaQBdr0gU14yjNqei/+2TeSv++nFayogb2XHwxQ
         +FyiEd27IMAeIqpglHOcUmcrdOQmvn6AQKLNpJHDFpJZO0SbY0+DuSoV4yycnK6h9zVp
         /Av9NwQxxRuA8CXhju/sCpWhJYPiyPVyajBu/1PKrhmyZPmxt3jAgI9kUiJ1LHNxy6eF
         MQ7erOdRskzMKv++4B5vw6W879vowBQHU9TacqQiVmYgsB3GiG1yrhuM+XL4Chlv2HI8
         4Ylw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=subject:content-transfer-encoding:content-language:in-reply-to
         :mime-version:user-agent:date:message-id:from:references:cc:to
         :arc-authentication-results;
        bh=vEJNQPED50tr2hE7qJPtY3+p02dqbILIC/Lo43BU7WY=;
        b=alocyk7IwBaH3p8XpH7/sSolJqWT3eUfoTgd+ZVTFg/Ep8j1iRpDaEPuF3PLVi+B2x
         ig3OPg5VrRsV/vzKk36MHN0y7RiSIJb+TtXcgXiNaIgsjh7VfGSWhP6s5IsatWBf3HSI
         mhMtR61k60MIcLy7+bOfbiH1WnJg/5ZVVbXrzwgSACmW41oGZQs2r9os7AGb0FYgjgO7
         FlEGSFtNY8qNa1XFCf4c2/blrvvduiLuihP1fEftyGtl75pZfv1u6z/ewwsCup7O5nCC
         ob7RxxOsbs49kXDSrKvwHkUQLNvOeYhy6HbWcqoeF2aLOmTcbDI3D3hOS1s44BhbWXw1
         lTgw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of logang@deltatee.com designates 207.54.116.67 as permitted sender) smtp.mailfrom=logang@deltatee.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of logang@deltatee.com designates 207.54.116.67 as permitted sender) smtp.mailfrom=logang@deltatee.com
To: Andy Shevchenko <andy.shevchenko@gmail.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Linux-Arch <linux-arch@vger.kernel.org>, linux-ntb@googlegroups.com,
 linux-crypto <linux-crypto@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>,
 =?UTF-8?Q?Horia_Geant=c4=83?= <horia.geanta@nxp.com>,
 Jon Mason <jdmason@kudzu.us>
References: <20180305190824.847-1-logang@deltatee.com>
 <20180305190824.847-8-logang@deltatee.com>
 <CAHp75Vc41MwtDr24-z3po2nx3Hr7_=tFUD0odcrbnVTP4SnJ1g@mail.gmail.com>
 <20180306114632.GB16784@kroah.com>
 <CAHp75Vf6sYss8q5FjgLYaQXYN761M4awmLVjZ48Cdd8+NrrhxQ@mail.gmail.com>
From: Logan Gunthorpe <logang@deltatee.com>
Message-ID: <18e6f79d-04db-463a-8916-09d7d859d273@deltatee.com>
Date: Tue, 6 Mar 2018 10:03:55 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <CAHp75Vf6sYss8q5FjgLYaQXYN761M4awmLVjZ48Cdd8+NrrhxQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 172.16.1.162
X-SA-Exim-Rcpt-To: jdmason@kudzu.us, horia.geanta@nxp.com, arnd@arndb.de, linux-crypto@vger.kernel.org, linux-ntb@googlegroups.com, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, gregkh@linuxfoundation.org, andy.shevchenko@gmail.com
X-SA-Exim-Mail-From: logang@deltatee.com
Subject: Re: [PATCH v11 7/7] ntb: ntb_hw_switchtec: Cleanup 64bit IO defines
 to use the common header
X-SA-Exim-Version: 4.2.1 (built Tue, 02 Aug 2016 21:08:31 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594125898084128153?=
X-GMAIL-MSGID: =?utf-8?q?1594208650446609134?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>



On 06/03/18 04:57 AM, Andy Shevchenko wrote:
> On Tue, Mar 6, 2018 at 1:46 PM, Greg Kroah-Hartman
> <gregkh@linuxfoundation.org> wrote:
>> On Tue, Mar 06, 2018 at 12:48:29PM +0200, Andy Shevchenko wrote:
>>> On Mon, Mar 5, 2018 at 9:08 PM, Logan Gunthorpe <logang@deltatee.com> wrote:
>>>> Clean up the ifdefs which conditionally defined the io{read|write}64
>>>> functions in favour of the new common io-64-nonatomic-lo-hi header.
>>>
>>>>   #include <linux/kthread.h>
>>>>   #include <linux/interrupt.h>
>>>>   #include <linux/ntb.h>
>>>> +#include <linux/io-64-nonatomic-lo-hi.h>
>>>
>>> A nit, can we preserve alphabetical ordering?
>>
>> Ugh, why, it doesn't matter at all :)
> 
> I'm fine with either way, but ordering is a good thing to have in long
> term prospective.
> Easy to find what headers are in there, easy to understand if you need
> another one or not, easy to maintain the list w/o duplications.
> 
> I saw already few examples where long list of headers contained
> duplications b/c it was in messy order.
> 

I agree with Greg here. This is a bit silly. The list isn't even 
alphabetical to begin with so it can't be preserved. However, if I do a 
v12 I'll make it alphabetical.

Logan
