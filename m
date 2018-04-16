Return-Path: <okaya@codeaurora.org>
X-Google-Smtp-Source: AIpwx4/10geqFS6qX3Bv1QfTlLqMMOc5z6lMZkdhulNuQgrb9+u7BqnRF1JVLvqo7g/R44R5KYuZ
ARC-Seal: i=1; a=rsa-sha256; t=1523922282; cv=none;
        d=google.com; s=arc-20160816;
        b=Z5EKpoNwuNKnbXyyNLjhBDqUgGw5bcVt1DYkZUAS15IfsWpEswqMkkq8Y3vrHZfUGn
         gCks1Uq7Ff3ZVfzeZmubx0oJLBpyIVhBdwylnqm3YaBJvWOpfXd8J6gtkUjx2ayUUaXL
         VEmPDqxgjEZSMwfm46hIJis+/pjnWMwSXS4g5USEIkeEQwznogxdmN/HyxbEibgE7QWA
         ZK4XL82MHxaL3O8wghdNybFCPuQ29mOy92O4CyrbIveKUJFKQOHHwX6k8Axsr8DbXpe/
         iMM/BNWdv1J2+eAfyCi42bblQcl2Q3w+QXNAzSAbGjuTYWCeU4vQSbx3mrdb53x5CWjB
         Sf4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :dmarc-filter:dkim-signature:dkim-signature
         :arc-authentication-results;
        bh=2wV4JU9TVyQE22J7jnsR9xt+K3eqdv76HEToPWPtnHY=;
        b=CnlP5G4417xiqYTLgdpLssVaXZ95SW14lcpLuOIw8bvrn+CD1WZ2hRGU+hHTMGw3Cp
         pe94gsOpnhBYAOyl5MWrWr8HSWq9BABWg5Gd15ic8ZCfEe+AyeXkMq/6vOuqSnNbzerD
         q10vr9v0EcvS8RLkRAYVcM8EfxUL0OOByHD9ft85633H23D7DTR53q3VdciT87iefasQ
         qjePVRoMK/tIamhz3d/K5rVndWbcJ4Y1Uz9Tct4vQSxbDYFbrT+9syPQMNl9yR3XVF7d
         vY2lssNDMXjc2iSU3J7tvEknbVKkrUcMZUirJFBlF/WTcALvffRMQHL3isttr9WrByl2
         toKQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=JtPpZPwO;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=DeWGZpW+;
       spf=pass (google.com: domain of okaya@codeaurora.org designates 198.145.29.96 as permitted sender) smtp.mailfrom=okaya@codeaurora.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=JtPpZPwO;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=DeWGZpW+;
       spf=pass (google.com: domain of okaya@codeaurora.org designates 198.145.29.96 as permitted sender) smtp.mailfrom=okaya@codeaurora.org
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org DAC0360290
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
From: Sinan Kaya <okaya@codeaurora.org>
Message-ID: <1152a7d4-a8f4-ae68-2737-067fa05409cd@codeaurora.org>
Date: Mon, 16 Apr 2018 19:44:38 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <7a9d139e-978b-750d-1bac-8b27e934f781@bell.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1597941834039295294?=
X-GMAIL-MSGID: =?utf-8?q?1597948331428945645?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 4/16/2018 7:37 PM, John David Anglin wrote:
>>   +#include <asm-generic/io.h>
>>   #include <asm-generic/iomap.h>
> Still lots of problems.
> 
> Dave
> 
> -- 
> John David Anglin  dave.anglin@bell.net
> 
> 
> io.log
> 
> 
>   CC      arch/parisc/kernel/asm-offsets.s
> In file included from ./arch/parisc/include/asm/io.h:262:0,
>                  from ./include/linux/io.h:25,
>                  from ./include/linux/irq.h:25,
>                  from ./arch/parisc/include/asm/hardirq.h:13,
>                  from ./include/linux/hardirq.h:9,
>                  from arch/parisc/kernel/asm-offsets.c:34:
> ./include/asm-generic/io.h:37:21: error: redefinition of '__raw_readb'
>  #define __raw_readb __raw_readb
>                      ^

This one is easy to fix:

https://elixir.bootlin.com/linux/latest/source/arch/parisc/include/asm/io.h#L146

Remove 146..179.

-- 
Sinan Kaya
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project.
