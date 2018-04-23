Return-Path: <Matt.Redfearn@mips.com>
X-Google-Smtp-Source: AIpwx48KKYUse6M2aZuYzB038L1mTTni3M6wXFZADazO51iOkyJftmtTwhifksjfLNsYzdrT3DKM
ARC-Seal: i=1; a=rsa-sha256; t=1524489401; cv=none;
        d=google.com; s=arc-20160816;
        b=BZcZalHivyezun9IaPj35ouA7W024e2nc0CcibXfHYJr/fAIgJeHL0zA4D6QKQ4rBE
         K2UXewzAFSHGJv9+Tooi0djZtM7TXjSZVIwdGvjKrLWUwxg0fie+Yy0lGOGj8R2f/bdA
         c9RhQ3+MTn9Wjvqs2Io+ZjS1xQqsI/8qv8rgqEhHOuId6LFxfc6o0VTrKGvYZ/xLBf51
         bbpDKgKfKzKG1kgsuk4N3xpQ7839B8gVIveOn81cROUPydtL+QjVWXGWd8Ehv6ATsvbV
         toPjPRcOjtk5LYqQpc69ic4X5dy162Jz1Pkdr+9fkS9RQ1Srqipi2y+S3VNGCN2vFFfn
         wEJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :arc-authentication-results;
        bh=WnEDsm4y+mM4lDCve5gz0cLBZfUc9PaEEfp7WnuvHF8=;
        b=KCqZ1jlC9aHSHzCJ1agtTo4t1x1O6nF8U5FvkbiVso43QfUprNir7dR6JYQ0mhb7Lr
         zb2O7UxcLrlpa3ooe4B/+7k+G0o1KmtLc1B5A2PIg5R5+ohRCojDJfhtLC9/3cbYZTs9
         3CB4wqW0lMDqnQBcDaTK5/V7nW3rHBgtyQL8MeIIGHXtioCovJx+QkeuFDgUTiVnoJnx
         xlptF0jTNC/zi2p8SBwdDbR9OTrF7kHTD25NmlL5xxsg1oku3ekmYH9KFPTBeELCXJzT
         evnvTeAGgLt0kcJCplK09gr6hGSBtt0i92WK8k6dxHTLmgG6nwpaB5R6HHJ9jh2Hh/Yo
         xinA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of matt.redfearn@mips.com designates 64.235.154.210 as permitted sender) smtp.mailfrom=Matt.Redfearn@mips.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of matt.redfearn@mips.com designates 64.235.154.210 as permitted sender) smtp.mailfrom=Matt.Redfearn@mips.com
Subject: Re: [RFC. PATCH] earlycon: Remove hardcoded port->uartclk
 initialization in of_setup_earlycon
To: Michal Simek <michal.simek@xilinx.com>, <linux-kernel@vger.kernel.org>,
	<monstr@monstr.eu>, <devicetree@vger.kernel.org>, Rob Herring
	<robherring2@gmail.com>
CC: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	<linux-serial@vger.kernel.org>, Jiri Slaby <jslaby@suse.com>
References: <b05e4d329c556357bf7393075c6c1602509eb9c2.1524475668.git.michal.simek@xilinx.com>
From: Matt Redfearn <matt.redfearn@mips.com>
Message-ID: <6626f66e-e1a6-9e54-0011-95ab4949bd3b@mips.com>
Date: Mon, 23 Apr 2018 14:16:50 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <b05e4d329c556357bf7393075c6c1602509eb9c2.1524475668.git.michal.simek@xilinx.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [192.168.155.41]
X-ClientProxiedBy: mipsdag02.mipstec.com (10.20.40.47) To
 mipsdag02.mipstec.com (10.20.40.47)
X-BESS-ID: 1524489393-382908-3434-265010-1
X-BESS-VER: 2018.5-r1804181636
X-BESS-Apparent-Source-IP: 12.201.5.32
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.192287
	Rule breakdown below
	 pts rule name              description
	---- ---------------------- --------------------------------
	0.00 BSF_BESS_OUTBOUND      META: BESS Outbound
X-BESS-Outbound-Spam-Status: SCORE=0.00 using account:ESS59374 scores of KILL_LEVEL=7.0 tests=BSF_BESS_OUTBOUND
X-BESS-BRTS-Status: 1
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598528601821651253?=
X-GMAIL-MSGID: =?utf-8?q?1598542998436931236?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>



On 23/04/18 10:27, Michal Simek wrote:
> There is no reason to initialize uartclk to BASE_BAUD * 16 for DT based
> systems.
> 
> Signed-off-by: Michal Simek <michal.simek@xilinx.com>
> ---
> 
> It looks like from history that portclk = BASE_BAUD * 16 was setup to
> get on calculation on x86 (divisor = 1) but it shouldn't be needed on DT based
> system. That's why I think that there is no DT based system which really
> requires this line.

Hi Michal,

This is fine for the MIPS generic platform (tested on Boston board) 
which was broken by some earlycon changes a few versions ago. Also 
tested on a MIPS pistachio board. As long as the bootloader has 
configured the uart divisor, earlycon should work as long as my patch 
"serial: 8250_early: Only set divisor if valid clk & baud" is applied to 
avoid a bad divisor getting calculated.

Tested-by: Matt Redfearn <matt.redfearn@mips.com>

Thanks,
Matt

> ---
>   drivers/tty/serial/earlycon.c | 1 -
>   1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/tty/serial/earlycon.c b/drivers/tty/serial/earlycon.c
> index a24278380fec..c12b1edcdd8e 100644
> --- a/drivers/tty/serial/earlycon.c
> +++ b/drivers/tty/serial/earlycon.c
> @@ -244,7 +244,6 @@ int __init of_setup_earlycon(const struct earlycon_id *match,
>   		return -ENXIO;
>   	}
>   	port->mapbase = addr;
> -	port->uartclk = BASE_BAUD * 16;
>   
>   	val = of_get_flat_dt_prop(node, "reg-offset", NULL);
>   	if (val)
> 
