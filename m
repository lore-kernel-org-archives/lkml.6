Return-Path: <okaya@codeaurora.org>
X-Google-Smtp-Source: AIpwx4/Zt8NGTGQF5C9+mXB5Tlc5Ih1d8+Cmq2h/58uvRnSX5pSGHusNokvyBA9w+Z4mthUZdElq
ARC-Seal: i=1; a=rsa-sha256; t=1523938303; cv=none;
        d=google.com; s=arc-20160816;
        b=ZHuHIJO69L2ZRnt2Ek91ZqrSDl6nF2o04mE3tWfDl6wf2ICq/+OCp3qPCjMGFqbNhZ
         ewPxoPberIISnaIPBiOWHNxtlDk0VMhEDz/G+Qj1nxhTQE2Q+hoQAkXWu/AF1OUMxu2b
         7j92Hf+CBapXncfyG2AAn704zR3BLGTH9kaJGDm4JXvYpMBEUbh2wPzIN5WfunuhbiVT
         sZ865+AyDAv2NgPyhv0FwTlspjA0Yvy4JAynegtG0Bh2MPDJ9bXzN+VUj4MDvzP9a1sx
         H+4TNMNVJ2zpSGyM5bb9hsuqhiUJ2pmycFDUnmQyro5P/mnMAG4LT8wraDYGlSoB15J/
         71hg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :dmarc-filter:dkim-signature:dkim-signature
         :arc-authentication-results;
        bh=mnj9JH4cC79d9zk6XhJplsUr/IknAKenob47F+Lbd4I=;
        b=osJUIG/RjKUcHFW16LtNbTiXloIDIwBrh2wUtLcE8A51aBH2LhdL99AGsf/3rH5hZI
         gqZBIqksTePayOSOjSqB4q1YG4MLjg9HPx/ZdLd60LNR5Z6W3zWvD3CWe+ygTkFo14Qm
         d7TxjauPTH167kEn9PcnAJdnvZ87mAHAFfnYwtG8VoMPzjm5I5W9UYQ7CwZogQpRm61+
         MfwzkwbMZYIawtcAvZ4D26ZWDxHpHeynGbN0x9QKYzfjh/X82yW/X3oWMWgLUfNRrgzG
         dOHKOa6xLBOcc2jBSwX/DInf/OHeVUVoerhB83cH4cUPNr/VV8AJsN0GJ0MxkH6d7eUL
         sWQw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=O5IhJAmk;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=O5IhJAmk;
       spf=pass (google.com: domain of okaya@codeaurora.org designates 198.145.29.96 as permitted sender) smtp.mailfrom=okaya@codeaurora.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=O5IhJAmk;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=O5IhJAmk;
       spf=pass (google.com: domain of okaya@codeaurora.org designates 198.145.29.96 as permitted sender) smtp.mailfrom=okaya@codeaurora.org
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 9E537602B8
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=okaya@codeaurora.org
Subject: Re: [PATCH 1/2] parisc: use the asm-generic version for writeX()
To: John David Anglin <dave.anglin@bell.net>, arnd@arndb.de,
 timur@codeaurora.org, sulrich@codeaurora.org
Cc: linux-arm-msm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 "James E.J. Bottomley" <jejb@parisc-linux.org>, Helge Deller
 <deller@gmx.de>, Thomas Gleixner <tglx@linutronix.de>,
 Philippe Ombredanne <pombredanne@nexb.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 linux-parisc@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1523916078-23049-1-git-send-email-okaya@codeaurora.org>
 <a727e74f-610c-4722-76e9-c1aca2f9e9bd@bell.net>
 <a7b59f43-cea5-0ead-f528-61899570e353@codeaurora.org>
 <7a9d139e-978b-750d-1bac-8b27e934f781@bell.net>
 <1152a7d4-a8f4-ae68-2737-067fa05409cd@codeaurora.org>
 <4eea352e-07f0-3a99-c9bd-57e117288778@codeaurora.org>
From: Sinan Kaya <okaya@codeaurora.org>
Message-ID: <3a3b6fe1-c338-488e-3983-0dddf26cc14b@codeaurora.org>
Date: Tue, 17 Apr 2018 00:11:39 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <4eea352e-07f0-3a99-c9bd-57e117288778@codeaurora.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1597941834039295294?=
X-GMAIL-MSGID: =?utf-8?q?1597965130368167968?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 4/16/2018 7:48 PM, Sinan Kaya wrote:
> On 4/16/2018 7:44 PM, Sinan Kaya wrote:
>>> John David Anglin  dave.anglin@bell.net
>>>
>>>
>>> io.log
>>>
>>>
>>>   CC      arch/parisc/kernel/asm-offsets.s
>>> In file included from ./arch/parisc/include/asm/io.h:262:0,
>>>                  from ./include/linux/io.h:25,
>>>                  from ./include/linux/irq.h:25,
>>>                  from ./arch/parisc/include/asm/hardirq.h:13,
>>>                  from ./include/linux/hardirq.h:9,
>>>                  from arch/parisc/kernel/asm-offsets.c:34:
>>> ./include/asm-generic/io.h:37:21: error: redefinition of '__raw_readb'
>>>  #define __raw_readb __raw_readb
>>>                      ^
>> This one is easy to fix:
>>
>> https://elixir.bootlin.com/linux/latest/source/arch/parisc/include/asm/io.h#L146
>>
>> Remove 146..179.
> 
> I'll try to get a hold of a cross compiler and re-test. The above is a hack.
> I need to do a better job on this.
> 
> Thanks for the help. I'll post V2 when it is ready.
> 

Converting this to asm-generic turned out to be a much bigger task. I placed
compiler barriers instead to existing version and posted as follows:

[PATCH v2 1/2] parisc: define stronger ordering for the default writeX()
[PATCH v2 2/2] parisc: define stronger ordering for the default readX()

-- 
Sinan Kaya
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project.
