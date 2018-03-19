Return-Path: <logang@deltatee.com>
X-Google-Smtp-Source: AIpwx4+NCfbAjP7CZ7INF8qMgevG7z2hP8z1XTrrlK+40bp1VcQroq6rfESLJNNw5UpnxBZbdGp7
ARC-Seal: i=1; a=rsa-sha256; t=1521491898; cv=none;
        d=google.com; s=arc-20160816;
        b=cLwU/vVj0F11Uzz5YsoVhYvEiq7yDbtqPYCqP0aYaPmNeAfNmX2HVS5eiRTRNQk4Rz
         xKILJ2AzzqlsRn3rD3f1Knx2IRQ7ITHC32MSzcE+qIq4lkbMqQvrBH+l5rXxLaIA80oT
         59w1WPTUPWlQ0ORhz8XPtLqu3J454RB1de5+3NKknL/MQs4ZWcqsUc4QrgfZapk2c0ON
         xxOKLM5iXdziKFoUUws923w9n50MMBiQT+ojZJQiKadZQ1Pa+RMZi/kHf++yda/I6vkP
         SCLD8dpPmCYbUMfzIjuNsROAjqKhCUFx6w5PPhSZqSgsn2Rr+nA6nZP54sWTtIsSKGrN
         Bp+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=subject:content-transfer-encoding:content-language:in-reply-to
         :mime-version:user-agent:date:message-id:from:references:cc:to
         :arc-authentication-results;
        bh=7TQ6w95QjOu8ley9edFrc7vBbNnP6vOrJXlZL5fYsVQ=;
        b=bvUUzW/Tex7bylZrOVez5uocIMW+pC/dOIzRKVFWUaGExyknH+h0cukh+B1QzmzsS6
         FCYOJwz7DgcVQovKq7veF6h4GVbW693UCHO7zlmspkt18bm+nv2gIjGAIg7eOvtcc/IF
         0w7VeXF1Qb5xWtqjUpFxFaf6I+bJjju8JZjtPR+1Q+MjT8tJfez4gTYTe/ZUQtRC46By
         c3GrvE8eQVGOj3dMu3q7nFAjWI6kolUyyI2TamWKJRYAkneZ8BJKhiu0noeLDyNKJEc8
         figwYZCymuJHWqH3gzBDFrhbDvEOqO+PWYKn1yFtqaM2y6jik0qA7+M6N0ZVXrRDPN8j
         rXqQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of logang@deltatee.com designates 207.54.116.67 as permitted sender) smtp.mailfrom=logang@deltatee.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of logang@deltatee.com designates 207.54.116.67 as permitted sender) smtp.mailfrom=logang@deltatee.com
To: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
 linux-ntb@googlegroups.com, linux-crypto@vger.kernel.org,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Arnd Bergmann <arnd@arndb.de>, Andy Shevchenko <andy.shevchenko@gmail.com>,
 =?UTF-8?Q?Horia_Geant=c4=83?= <horia.geanta@nxp.com>,
 Thomas Gleixner <tglx@linutronix.de>,
 Philippe Ombredanne <pombredanne@nexb.com>,
 Kate Stewart <kstewart@linuxfoundation.org>
References: <20180316154852.13206-1-logang@deltatee.com>
 <20180316154852.13206-2-logang@deltatee.com>
 <20180317190311.tdmx2vlcjttsjs5j@ltop.local>
From: Logan Gunthorpe <logang@deltatee.com>
Message-ID: <9a55914e-142c-2a1b-2eef-66d7922a58b8@deltatee.com>
Date: Mon, 19 Mar 2018 14:38:04 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180317190311.tdmx2vlcjttsjs5j@ltop.local>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 68.147.191.165
X-SA-Exim-Rcpt-To: kstewart@linuxfoundation.org, pombredanne@nexb.com, tglx@linutronix.de, horia.geanta@nxp.com, andy.shevchenko@gmail.com, arnd@arndb.de, gregkh@linuxfoundation.org, linux-crypto@vger.kernel.org, linux-ntb@googlegroups.com, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, luc.vanoostenryck@gmail.com
X-SA-Exim-Mail-From: logang@deltatee.com
Subject: Re: [PATCH v12 1/9] iomap: Fix sparse endian check warnings
X-SA-Exim-Version: 4.2.1 (built Tue, 02 Aug 2016 21:08:31 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1595109905747636881?=
X-GMAIL-MSGID: =?utf-8?q?1595399889465258701?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi Luc,

Thanks for the feedback. I'll try to address your points in a v13 shortly.

Logan


On 18/03/18 10:13 AM, Luc Van Oostenryck wrote:
> it looks correct but if you should explain why the warning
> is not a valid one. Once done, you can then explain what problem
> you have fixed instead of saying you suppressed a warning.
> 
>> Also, it looks like the wrong conversion function was used in
> 
> I would suggest to split the patch in two since it does two
> different things which should have their own explanation.
> 
>> diff --git a/lib/iomap.c b/lib/iomap.c
>> index 541d926da95e..a05d9fa21794 100644
>> --- a/lib/iomap.c
>> +++ b/lib/iomap.c
>> @@ -106,8 +106,10 @@ EXPORT_SYMBOL(ioread32be);
>>  #endif
>>  
>>  #ifndef mmio_write16be
>> -#define mmio_write16be(val,port) __raw_writew(be16_to_cpu(val),port)
>> -#define mmio_write32be(val,port) __raw_writel(be32_to_cpu(val),port)
>> +#define mmio_write16be(val, port) \
>> +	__raw_writew((u16 __force)cpu_to_be16(val), port)
>> +#define mmio_write32be(val, port) \
>> +	__raw_writel((u32 __force)cpu_to_be32(val), port)
>>  #endif
> 
> I think that in this sort of replacement, it's better to not split
> the lines (even if larger than 80, that's it).
> 
> -- Luc Van Oostenryck
> 
