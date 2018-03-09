Return-Path: <kernel-hardening-return-12331-gregkh=linuxfoundation.org@lists.openwall.com>
X-Google-Smtp-Source: AG47ELvaYJ5lAa9bXKeOZo3AnBR4DxJGLeJOuQhxPR2zgp38dK+83EkOgtPVWzPOSK6zXn3MbsL2
ARC-Seal: i=1; a=rsa-sha256; t=1520618226; cv=none;
        d=google.com; s=arc-20160816;
        b=W55W3yDdWcDhrGfkHT6YSlHw02e7Nd4rw6nrJ1Amoq3n78LKuTH+/SAhttaq7HkF6I
         HgLVXBSTRvdgBXYMF7LZgeITB70aFEN/dZGq28J5pZh0nwe6YMtzZefJg8+MaH0z9Tw0
         mcwdLSiLgKKFaDrOg3paHvbNKfJZRPmLhvRviSqAFg+N6a+9l6Ws9r/8BVufWTdgfjsS
         M13g2tKBt4EpFrk7uqYEcu3r2+77joiGhGmDgKtfZBb5RCe5vLe4kpyDtxqIIGTAdYHg
         5rfpj1Kre6f70X51JouaR+9ClSjnEno5lpCaD4pAoTC4wE1/8QFcq6nEH+gya+FpUrxp
         qSKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :delivered-to:delivered-to:list-id:list-subscribe:list-unsubscribe
         :list-help:list-post:precedence:mailing-list
         :arc-authentication-results;
        bh=wlRhZMBqnnTe866YgeRTAOA+ebYAtPko1NoVt4Ea3+c=;
        b=Jid3SF2jwaBVSr8LkZpI+rZISCBjhpwoyW9nkYOFQjqVPEC/RwgCqrs9Z5MExYUcqM
         czlp3rf4JzHlTGY556qZFxTlvQyzH5LXUfxpP/dcThBc6Lc8q1CF/0woVBUcU9qEYvTK
         jJjw1dBkJrJr5hUI4M4e7WNgIvmP+4qu2olQD9sle4DzHXviJOS37h97K+rZWUeUjkXq
         3U/R0LuLI9+37lk8GjOfw4gq15qw9nNzUw+lr1I8vLHOZuEZDVE5mTkqLldB00RqKp3V
         GuqcW7C3yIxwcPhGGahlVZvfIEbsMgFnPmh+0/VYsmImPG81V5pcRHhTcTeK3kXSvCh/
         4Msw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of kernel-hardening-return-12331-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12331-gregkh=linuxfoundation.org@lists.openwall.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of kernel-hardening-return-12331-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12331-gregkh=linuxfoundation.org@lists.openwall.com
Mailing-List: contact kernel-hardening-help@lists.openwall.com; run by ezmlm
List-Post: <mailto:kernel-hardening@lists.openwall.com>
List-Help: <mailto:kernel-hardening-help@lists.openwall.com>
List-Unsubscribe: <mailto:kernel-hardening-unsubscribe@lists.openwall.com>
List-Subscribe: <mailto:kernel-hardening-subscribe@lists.openwall.com>
Subject: Re: [PATCH] power: supply: da9150-fg: remove VLA usage
To: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>,
 "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
 Support Opensource <Support.Opensource@diasemi.com>,
 Sebastian Reichel <sre@kernel.org>
Cc: "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "kernel-hardening@lists.openwall.com" <kernel-hardening@lists.openwall.com>,
 Kees Cook <keescook@chromium.org>
References: <20180309045813.GA11964@embeddedgus>
 <2E89032DDAA8B9408CB92943514A0337014C1D771E@SW-EX-MBX01.diasemi.com>
From: "Gustavo A. R. Silva" <garsilva@embeddedor.com>
Message-ID: <b657eeff-ba9d-c40c-24f3-b971c893b6c3@embeddedor.com>
Date: Fri, 9 Mar 2018 11:55:40 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <2E89032DDAA8B9408CB92943514A0337014C1D771E@SW-EX-MBX01.diasemi.com>
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
X-Exim-ID: 1euMF3-0030Ib-Bu
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: ([192.168.1.66]) [189.175.117.58]:58476
X-Source-Auth: garsilva@embeddedor.com
X-Email-Count: 6
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594434794789187138?=
X-GMAIL-MSGID: =?utf-8?q?1594483777538167869?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>



On 03/09/2018 05:36 AM, Adam Thomson wrote:
> On 09 March 2018 04:58, Gustavo A. R. Silva wrote:
> 
>> In preparation to enabling -Wvla, remove VLA usage and replace it
>> with fixed-length arrays.
>>
>> It seems that the length of array 'buf' will not exceed
>> DA9150_QIF_SHORT_SIZE bytes (2 bytes). But a fixed length
>> of DA9150_QIF_BYTE_SIZE bytes (8 bytes) was chosen in case
>> this change in the future.
>>
>> Fixed as part of the directive to remove all VLAs from
>> the kernel: https://lkml.org/lkml/2018/3/7/621
>>
>> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
>> ---
>>   drivers/power/supply/da9150-fg.c | 4 ++--
>>   1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/power/supply/da9150-fg.c b/drivers/power/supply/da9150-fg.c
>> index 8b8ce97..96893be 100644
>> --- a/drivers/power/supply/da9150-fg.c
>> +++ b/drivers/power/supply/da9150-fg.c
>> @@ -92,7 +92,7 @@ struct da9150_fg {
>>   static u32 da9150_fg_read_attr(struct da9150_fg *fg, u8 code, u8 size)
>>
>>   {
>> -	u8 buf[size];
>> +	u8 buf[DA9150_QIF_BYTE_SIZE];
> 
> You can use DA9150_QIF_LONG_SIZE as that's the biggest size of an attribute
> which can be accessed. This will also save a little space.
> 

I got it. I'll send v2 shortly.

Thanks for the feedback, Adam.
--
Gustavo
