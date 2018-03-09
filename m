Return-Path: <kernel-hardening-return-12302-gregkh=linuxfoundation.org@lists.openwall.com>
X-Google-Smtp-Source: AG47ELtrnAqlSUpmlDHbagpsaXtCfrOKt1r7eZeEnu+Y2PptM9BeyVxOC+QNhVb+/SmNJch62392
ARC-Seal: i=1; a=rsa-sha256; t=1520576206; cv=none;
        d=google.com; s=arc-20160816;
        b=GgWSa9w2gu99KdQ5EBuZ6kLLt5893HGnpfrqPWECbAiPuLjqfDMIRUKCjEyIGDi2y/
         F1pp82s3fYBXh5TwvUmRpSqkzPIQv5WRBVaEs34DdDGpKFGA6nxAxjhInkJfPqt+FTpB
         EEnoCJNJcUJPhHzM831LusxzGwrEHZmZxbjE+Jp5aI4Ev4dOIcktR0ZI23Tpfwc2Q/GO
         EUW0vlSwZT0n3nnX9FUJ7CSdwykurQ2m3wYCKjulcWTkj9ox1H09ffOUh/EF2iAPagYe
         xrXYfFjne+mgnuw2M6zyK2Kj2ElDjTMbCK4iOSecPdDz5utYH0shkg/e9RNRgI0Dw9iP
         URMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :delivered-to:list-id:list-subscribe:list-unsubscribe:list-help
         :list-post:precedence:mailing-list:arc-authentication-results;
        bh=SRJodSnoZtH89r7WzBbyimXefkGrwFDOID7LoPYd/E8=;
        b=O+ciYze33ZUPRcNr2cEoXS9KKYylM5S7FPZdOhGIza1GWmJXDIdoMrQLk9PEwA7Amw
         PzX5BRchBWKJBqdaOYJWeynotnSia0kaSb/kTgELEnkRHltE188Ae+jfp6CWu/ljxPWZ
         f2iLgRoNJiIBSOiANmhrSqZcqlWuqIfiDVvNPROzt9Vf8wC5GiweLPXvnVtoG+4z39yM
         igURTZc/e4Uk+wt09db1Y69NpLRLpkT8f6udy/xuuY6FG0bQ0VwsFdOJi8Fxf0MJkmkF
         70I2Tlb8v2VPpIVQaqTsgyHELucUzDY8ePVOZsb2XnKu/anJl5EVFlCNAMQzcheEymIX
         FYJQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of kernel-hardening-return-12302-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12302-gregkh=linuxfoundation.org@lists.openwall.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of kernel-hardening-return-12302-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12302-gregkh=linuxfoundation.org@lists.openwall.com
Mailing-List: contact kernel-hardening-help@lists.openwall.com; run by ezmlm
List-Post: <mailto:kernel-hardening@lists.openwall.com>
List-Help: <mailto:kernel-hardening-help@lists.openwall.com>
List-Unsubscribe: <mailto:kernel-hardening-unsubscribe@lists.openwall.com>
List-Subscribe: <mailto:kernel-hardening-subscribe@lists.openwall.com>
Subject: Re: [PATCH 4/4] video: Remove stack VLA usage
To: Tycho Andersen <tycho@tycho.ws>, Joe Perches <joe@perches.com>
Cc: "Tobin C. Harding" <me@tobin.cc>,
 Florian Tobias Schandinat <FlorianSchandinat@gmx.de>,
 Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
 kernel-hardening@lists.openwall.com, linux-kernel@vger.kernel.org,
 driverdev-devel@linuxdriverproject.org, Kees Cook <keescook@chromium.org>
References: <1520574625-4225-1-git-send-email-me@tobin.cc>
 <1520575267.11634.25.camel@perches.com>
 <20180309061152.r3yumh6agasyhtvo@cisco>
From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Message-ID: <d99bbd46-8fed-b86f-c043-272ebc96e023@embeddedor.com>
Date: Fri, 9 Mar 2018 00:16:21 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180309061152.r3yumh6agasyhtvo@cisco>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - lists.openwall.com
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 189.175.117.58
X-Source-L: No
X-Exim-ID: 1euBKM-001BaM-UF
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: ([192.168.1.66]) [189.175.117.58]:57440
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 6
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594438095221699065?=
X-GMAIL-MSGID: =?utf-8?q?1594439716623048192?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>


I sent a patch for this six hours ago:

https://patchwork.kernel.org/patch/10268591/

--
Gustavo

On 03/09/2018 12:11 AM, Tycho Andersen wrote:
> On Thu, Mar 08, 2018 at 10:01:07PM -0800, Joe Perches wrote:
>> On Fri, 2018-03-09 at 16:50 +1100, Tobin C. Harding wrote:
>>> The kernel would like to have all stack VLA usage removed[1].  The
>>> arrays are fixed here (declared with a const variable) but they appear
>>> like VLAs to the compiler.  We can use a pre-processor define to fix the
>>> warning.
>> []
>>> diff --git a/drivers/video/fbdev/via/via_aux_sii164.c b/drivers/video/fbdev/via/via_aux_sii164.c
>> []
>>> @@ -27,6 +27,9 @@
>>>   
>>>   static const char *name = "SiI 164 PanelLink Transmitter";
>>>   
>>> +/* check vendor id and device id */
>>> +const u8 id[] = {0x01, 0x00, 0x06, 0x00};
>>
>> It seems id is now global in multiple places.
>> Perhaps these should be static.
> 
> Does it even need to be global? Why not just get rid of the indirection and use
> ARRAY_SIZE where we mean it? This seems to work for me,
> 
> diff --git a/drivers/video/fbdev/via/via_aux_sii164.c b/drivers/video/fbdev/via/via_aux_sii164.c
> index ca1b35f033b1..87db6c98d680 100644
> --- a/drivers/video/fbdev/via/via_aux_sii164.c
> +++ b/drivers/video/fbdev/via/via_aux_sii164.c
> @@ -35,10 +35,10 @@ static void probe(struct via_aux_bus *bus, u8 addr)
>                  .addr   =       addr,
>                  .name   =       name};
>          /* check vendor id and device id */
> -       const u8 id[] = {0x01, 0x00, 0x06, 0x00}, len = ARRAY_SIZE(id);
> -       u8 tmp[len];
> +       const u8 id[] = {0x01, 0x00, 0x06, 0x00};
> +       u8 tmp[ARRAY_SIZE(id)];
>   
> -       if (!via_aux_read(&drv, 0x00, tmp, len) || memcmp(id, tmp, len))
> +       if (!via_aux_read(&drv, 0x00, tmp, sizeof(tmp)) || memcmp(id, tmp, sizeof(tmp)))
>                  return;
>   
>          printk(KERN_INFO "viafb: Found %s at address 0x%x\n", name, addr);
> 
> Cheers,
> 
> Tycho
> 
