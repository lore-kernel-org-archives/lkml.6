Return-Path: <andy.shevchenko@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1520337471; cv=none;
        d=google.com; s=arc-20160816;
        b=GyT/gjnbps3Q2tWhnTEQqEF4r3HnRNzNybbUPR6PCRaGsDuqbY1J3JJWUk8zQi3fk/
         r8c2f6GIFzTcVerb7m6uiHuOHbYyfxU5hjeuGGE/0jGKKzUztBhfze6y/5yIa4H08Hwk
         I0zZfQBVFoPJGe5wai30oMwIXhVsyeNQEdQ6CpORmdigl0LDl/vuPMvug6tpzXpqIE8t
         Uxkpj76JzDPdIt8AjdrfFAdpO2ItEwxiX3xHCHyzaxDCgJxBEtoGk2uigF/G9pd+CVcj
         NtNtzhsx5uHh693ZM+ZT1IxJwx0iAWQpjMvwpT7hZHvU9yo4/8dxowPdX4kRFMSwia+B
         /c5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:dkim-signature:arc-authentication-results;
        bh=sUEpY+6/gl/Aqct0k57DjRVYvKUS5/61MriH4gBqdVY=;
        b=YIG9h+P9lckBH749gTpjUpGQxheuaqmq8hENh+OKfbdx/Pedr6G0ESq81o4k98hZmf
         K9rJQmQ3ZwAkhMbPNVj4i7VF5CH0HJs68/W5bSxwIetITqzE3YuWG5koHJ0qNQTWGAKV
         C69trE6onf7w8AJJeQ9hw/bKs0JGeD+Nr5qc7XhHIQmjLtmZk5TBpLkO8+MCiZrDYKWx
         y1rg1vCXBA8QtO64JcH6dz4jdE/itI+Gl5sZd3102lokhVr02eN+uNnReTs8ZpGcR0k2
         ZEnfC1befi93Lgub6Ect4hL7ZMGheYJE5PgO6ER9twsAe+3rNAmN5HcU76qtf7A2gKIF
         g4tA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=EK1ftroT;
       spf=pass (google.com: domain of andy.shevchenko@gmail.com designates 209.85.220.41 as permitted sender) smtp.mailfrom=andy.shevchenko@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=EK1ftroT;
       spf=pass (google.com: domain of andy.shevchenko@gmail.com designates 209.85.220.41 as permitted sender) smtp.mailfrom=andy.shevchenko@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
X-Google-Smtp-Source: AG47ELv/orANvm4PQQsd3mEggJqklwDbjDuDuX22gAoIFa19hO8qqw+I360otXBPUWMknYRuDx7tVvKZoixQ5awgGPU=
MIME-Version: 1.0
In-Reply-To: <20180306114632.GB16784@kroah.com>
References: <20180305190824.847-1-logang@deltatee.com> <20180305190824.847-8-logang@deltatee.com>
 <CAHp75Vc41MwtDr24-z3po2nx3Hr7_=tFUD0odcrbnVTP4SnJ1g@mail.gmail.com> <20180306114632.GB16784@kroah.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Tue, 6 Mar 2018 13:57:50 +0200
Message-ID: <CAHp75Vf6sYss8q5FjgLYaQXYN761M4awmLVjZ48Cdd8+NrrhxQ@mail.gmail.com>
Subject: Re: [PATCH v11 7/7] ntb: ntb_hw_switchtec: Cleanup 64bit IO defines
 to use the common header
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Logan Gunthorpe <logang@deltatee.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux-Arch <linux-arch@vger.kernel.org>,
	linux-ntb@googlegroups.com, linux-crypto <linux-crypto@vger.kernel.org>,
	Arnd Bergmann <arnd@arndb.de>, =?UTF-8?Q?Horia_Geant=C4=83?= <horia.geanta@nxp.com>,
	Jon Mason <jdmason@kudzu.us>
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594125898084128153?=
X-GMAIL-MSGID: =?utf-8?q?1594189384734879043?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, Mar 6, 2018 at 1:46 PM, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
> On Tue, Mar 06, 2018 at 12:48:29PM +0200, Andy Shevchenko wrote:
>> On Mon, Mar 5, 2018 at 9:08 PM, Logan Gunthorpe <logang@deltatee.com> wrote:
>> > Clean up the ifdefs which conditionally defined the io{read|write}64
>> > functions in favour of the new common io-64-nonatomic-lo-hi header.
>>
>> >  #include <linux/kthread.h>
>> >  #include <linux/interrupt.h>
>> >  #include <linux/ntb.h>
>> > +#include <linux/io-64-nonatomic-lo-hi.h>
>>
>> A nit, can we preserve alphabetical ordering?
>
> Ugh, why, it doesn't matter at all :)

I'm fine with either way, but ordering is a good thing to have in long
term prospective.
Easy to find what headers are in there, easy to understand if you need
another one or not, easy to maintain the list w/o duplications.

I saw already few examples where long list of headers contained
duplications b/c it was in messy order.

-- 
With Best Regards,
Andy Shevchenko
