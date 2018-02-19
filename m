Return-Path: <andy.shevchenko@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1519043144; cv=none;
        d=google.com; s=arc-20160816;
        b=bk93PH2f+IsOKKFrjR89LulwBH8LT87HKXqakqhUKpU3faxD3iZCvQ8jH0vQT0rvjY
         bgb6OIBo9TWjIyrFck4BcjI0oo2cwc90G2yGVnzTUgLIJlf/2jdbAUyIv1xZ4+AaeFYR
         4uur8wjFyiQsnfhMJ6OsYpsl9pllg0UMoFfS9Tk47BJ+Din0M36QdO21a79juyvjhdxf
         F0y3zq0dBkqyup36+bgp/zJ23H2mZPWvD/JcTrq/cwnDuCKRyqd8BSfo4LOOPoHKfAQa
         Nr5zQmB0ZNMFbqdETjtrNajMP/4XuPF+J1F98P75UA+i/lb7jYJgjXqwoFW7saMNDeiv
         iG5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:dkim-signature:arc-authentication-results;
        bh=kb7+quyTmrICuy4Gdk1uVzdDyf8EFoAMUx+fAEjXiUQ=;
        b=fy0R93yY8M41I2ZkFnTg1vv7w3gI22REhPVHz2n+P1F5OxYYcheilenuTb0xHIsJOq
         pqGxNX1MWIpq+nvJp91VHSDSzmzHUj0vD8rqRE6gEzVINQZByN6ct4xh7t0IzjTpxO4U
         wZT2Fo4EqbrWGuazY3u08BtuiQk1/ZPOk0Xx4D5Y0/ELswofoTY7zHbOuzeH02f0zvWu
         /PifAANG5I17Z+dgCCpapEQ4WUMeCZMlGMu8ely/ctsxrWsfkinIVwtr3OqJb9hBdBEX
         mpntUSPvUX5L9OiCV719lcBe1fO7dQu6NL0ysd6j3WR14HvEvZWXIcEmbhGKPa1v7xgC
         teuA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=Id6scxzg;
       spf=pass (google.com: domain of andy.shevchenko@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=andy.shevchenko@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=Id6scxzg;
       spf=pass (google.com: domain of andy.shevchenko@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=andy.shevchenko@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
X-Google-Smtp-Source: AH8x225UQb4TFHMAYiaWFcpPILlov8O1z77vXBldnP5VU5KigM7lTVNJL1DchoID06cYVNA/sGPIvszRGmjuAlr+WaY=
MIME-Version: 1.0
In-Reply-To: <8eacaf1d-1df8-edc6-36f6-d02748b50baa@ursulin.net>
References: <20180215033356.6978-1-khandual@linux.vnet.ibm.com>
 <201802180359.yuetSevh%fengguang.wu@intel.com> <c407c32f-a7b6-06c5-4a03-109445e27427@linux.vnet.ibm.com>
 <8eacaf1d-1df8-edc6-36f6-d02748b50baa@ursulin.net>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Mon, 19 Feb 2018 14:25:44 +0200
Message-ID: <CAHp75VfRQ-J0PDDuaziX+O2pjZqqtfag8V7FDQkwvBwtfmx24w@mail.gmail.com>
Subject: Re: [PATCH V2] lib/scatterlist: Add SG_CHAIN and SG_END macros for
 LSB encodings
To: Tvrtko Ursulin <tursulin@ursulin.net>
Cc: Anshuman Khandual <khandual@linux.vnet.ibm.com>, kbuild test robot <lkp@intel.com>, kbuild-all@01.org,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Bart Van Assche <bart.vanassche@wdc.com>,
	Johannes Thumshirn <jthumshirn@suse.de>, Jens Axboe <axboe@kernel.dk>,
	Chris Wilson <chris@chris-wilson.co.uk>, Tvrtko Ursulin <tvrtko.ursulin@intel.com>
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1592436393983047782?=
X-GMAIL-MSGID: =?utf-8?q?1592832184588821354?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Mon, Feb 19, 2018 at 12:10 PM, Tvrtko Ursulin <tursulin@ursulin.net> wrote:
> On 19/02/18 04:12, Anshuman Khandual wrote:
>> On 02/18/2018 12:58 AM, kbuild test robot wrote:


>>>      #define SG_END   0x02
>>>          In file included from include/linux/blkdev.h:28:0,
>>>                      from drivers/staging/rts5208/rtsx.c:23:
>>>     include/linux/scatterlist.h:69:0: note: this is the location of the
>>> previous definition
>>>      #define SG_END  0x02UL
>>>
>>> vim +/SG_END +343 drivers/staging/rts5208/rtsx_chip.h
>>
>>
>> SG_END is already defined in a driver.

In some driver which is by the way staging one.

> Hence shall we change back
>> 'SG_END' definition as 'SG_EMARK' or any other suggestions ?
>
>
> Maybe SG_LAST? Going by existence of sg_is_chain and sg_is_last.

The mentioned driver should be cleaned up as well (and perhaps to start with).
It allows us to rectify constants in global namespace.

So, from my point of view the driver code is ugly in a sense it
doesn't have its own namespace for constants.

After we fix the driver, the rest would be whatever we get agreed on.

> And also would probably be good to add something like:
>
> #define SG_PAGE_BITS (SG_CHAIN | SG_LAST)
> #define SG_PAGE_MASK (~SG_PAGE_BITS)
>
> ?

Good suggestion,

-- 
With Best Regards,
Andy Shevchenko
