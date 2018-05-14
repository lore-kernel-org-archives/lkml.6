Return-Path: <agraf@suse.de>
X-Google-Smtp-Source: AB8JxZqQ1QTgKD8+Pc/Tzkh35Gw6zySMQSrOA7Ohkhw8msz+GkO72BAtEGq7+00rh1kSC+oRMEmh
ARC-Seal: i=1; a=rsa-sha256; t=1526283439; cv=none;
        d=google.com; s=arc-20160816;
        b=QxvcaFrIA2a4cJVzpRrTb9KKPzmG4tVWwfcZGcrg2CTDsidXHVsJVQR9h1tpnw/Xnm
         xpVADeL+6uqGiR3fUrwyCzJBh/6oc7MnhJqsAlMtO83F8RhYSVEWBIxwLuRdBrmWmsEb
         vMDI9niFP7fGcdXM+t5CiHNlNne2pGsnmWmLXlnyIe8K+kFDNZisHxSojbTmMD51kTjF
         zgsgwHtsXpIg421AbSYEFF+ZeEo5nIibMzC7RAX/6bmekbQ4IPsZOill579cGgG29zxN
         PvFivYkxDvV3J+Sx3TwRSd5QYSGDwh/ehkY8ndR/wU1+ZTufW/Armn7aEznpnTO4TJbu
         Ta2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-language:content-transfer-encoding:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :arc-authentication-results;
        bh=J5ZThO9dste2k/uRd8POaOv5bGDRWTXmTiB/fOwywQ4=;
        b=SynkhWJ5RwkEk/YhN6xgIYKqfVAlzIqPIfcTbthirZlSkkbufoBi0XOL7N4fNtDzTX
         0G8tRkh8S6xFhrTSWPv8IlIbSm5MpQt/Vfwh8xg+sLh+B+27WC8sH5qvG0Mfh2yxhfrJ
         1w4IHBXn5zzUG1xDpdrhh0C6NWRQabXLTcqQ4HRV9zKwtWgGjNKv/f2SPTkDLGXSAQwY
         X2CrX/dWowDHKiMwAfxzbgng4HKhtRaWGeeFeyjijnzWI50sxtF/MEiYWXaffhRThTMF
         2bTbbtULESIfyPaTTFhIQ9wrjTsCZjkzZOstlDJfPdAwpRM+QmLQx4MjgfX3NLrXk3td
         k6tw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of agraf@suse.de designates 195.135.220.15 as permitted sender) smtp.mailfrom=agraf@suse.de
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of agraf@suse.de designates 195.135.220.15 as permitted sender) smtp.mailfrom=agraf@suse.de
Subject: Re: [RFC PATCH] driver core: make deferring probe forever optional
To: Linus Walleij <linus.walleij@linaro.org>,
 =?UTF-8?Q?S=c3=b6ren_Brinkmann?= <soren.brinkmann@xilinx.com>
Cc: Bjorn Andersson <bjorn.andersson@linaro.org>,
 Rob Herring <robh@kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
 <devicetree@vger.kernel.org>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, Grant Likely <grant.likely@arm.com>,
 Mark Brown <broonie@kernel.org>, Stephen Boyd <sboyd@kernel.org>,
 boot-architecture@lists.linaro.org,
 Linux ARM <linux-arm-kernel@lists.infradead.org>,
 Michal Simek <michal.simek@xilinx.com>, Jan Kiszka <jan.kiszka@siemens.com>
References: <20180501213114.20183-1-robh@kernel.org>
 <20180507183106.GF2259@tuxbook-pro>
 <91dad272-e07d-2ab6-2afa-538294e9cefa@suse.de>
 <CACRpkdaYN-wKErERP_65T2NH6L-+8O_ugSgg7pXfkaLkn1A2KQ@mail.gmail.com>
From: Alexander Graf <agraf@suse.de>
Message-ID: <c6655f84-747f-c08b-7b9c-f76ff8857567@suse.de>
Date: Mon, 14 May 2018 09:37:15 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <CACRpkdaYN-wKErERP_65T2NH6L-+8O_ugSgg7pXfkaLkn1A2KQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1599298891509345819?=
X-GMAIL-MSGID: =?utf-8?q?1600424184068044937?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 05/14/2018 12:01 AM, Linus Walleij wrote:
> On Wed, May 9, 2018 at 11:44 AM, Alexander Graf <agraf@suse.de> wrote:
>> On 05/07/2018 08:31 PM, Bjorn Andersson wrote:
>>> Can you please name platform that has enough support for Alexander to
>>> care about backwards and forwards compatibility but lacks a pinctrl
>>> driver.
>> ZynqMP is one example that immediately comes to my mind. I'm sure there are
>> others too.
> Why isn't that using drivers/pinctrl/pinctrl-zynq.c?
>
> How is it so very different from (old) Zynq as it is already using
> the same GPIO driver?

That one is very simple: ZynqMP is usually an AMP system where Linux 
doesn't have full knowledge of the overall system. IIUC they have a tiny 
microblaze (PMU) that does the actual full system configuration for 
peripherals that may interfere with each other. This architecture also 
allows for safety critical code to run alongside a (less safe) Linux system.

I think we'll see architectures like this pop up more over time. TI 
Sitara has similar issues. I know that Jailhouse ran into exactly that 
problem before. I also know that during Linaro Connect Budapest even the 
OP-TEE people realized the current model is bad, because Linux may 
control pins/clocks/etc of devices that the secure world wants to use.

So I actually believe we will see more SoCs in the future that may even 
start with Linux controllable pinctrl or no pinctrl driver but then will 
move to firmware controlled drivers once it starts being necessary.


Alex
