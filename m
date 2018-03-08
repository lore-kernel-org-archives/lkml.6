Return-Path: <kernel-hardening-return-12247-gregkh=linuxfoundation.org@lists.openwall.com>
X-Google-Smtp-Source: AG47ELvk6g349pOgRBaTb3xxiVNjFADquj1yf1ioHR5FiyiD/gLX7/ZEWx+i/1pynKc7/fKMtTjT
ARC-Seal: i=1; a=rsa-sha256; t=1520532919; cv=none;
        d=google.com; s=arc-20160816;
        b=w0Jg6ltYZMXno3TsDAkoThCM2DW3Q1CLuhemO7qwsJRaAtXlWDHCrTAtDUgWJpqauw
         0pORdEsPdEPgSXvf6epCMSiBwQ8Wb1OrjPoq3GUdYs6U2FZyZphgd+JgwF2eGCZr+hrL
         qkd05lNsF4+5dXAFP5kzGryQx8Kwqmn1lM9db4LY7EoW7EYXLYGQWkzgyhCCJzyslwst
         aDp+/mD1KqGjZ2nEwfp7ErfZmBycuEXj+d7WHZoXGu95uTMOUe5bk0bqqEB5ResxYfrw
         vlL/iR/LLM7ogG8uj4ziD8iQd7ybnzWg2SA2v2U7xwslu1NLykuzX7ViBt0ofuYMbWlC
         p3fQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :delivered-to:delivered-to:list-id:list-subscribe:list-unsubscribe
         :list-help:list-post:precedence:mailing-list
         :arc-authentication-results;
        bh=jf7fu/X3+KarsXW7XCwwpa3qEVfgQCALXH8+nDJVNQQ=;
        b=X29stsQBctDXOD5+xaHvK786mw/kWfMaQ75b6XTjzYQyW/p6q+1n3FLpKjx3/OIM0y
         9rQtl/ghB5kiDRLhELkyBBR5D4lpRP/53tuJWgMZHMRcmRiJnKDfIosfWVPO6CQVARLF
         7+2uI6q7liQS+PDLBOC1Fe1quVLc57BIX6j4Hh/IF/v2ZjT92EApyV/jqHy8LobN80jx
         wIVdTyi+zSAZVPabCVvqDr3EEYTtlx4Df8JpkNTm5oX7JimY1emMaszbnK+DpCnkAdwU
         +vQbIFzPp21sCoB26QpSrlYGTbv65Y7DG8GJt8o+7AzR99X2L4YbMmb1z1L5vlQRYp5t
         on0Q==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of kernel-hardening-return-12247-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12247-gregkh=linuxfoundation.org@lists.openwall.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of kernel-hardening-return-12247-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12247-gregkh=linuxfoundation.org@lists.openwall.com
Mailing-List: contact kernel-hardening-help@lists.openwall.com; run by ezmlm
List-Post: <mailto:kernel-hardening@lists.openwall.com>
List-Help: <mailto:kernel-hardening-help@lists.openwall.com>
List-Unsubscribe: <mailto:kernel-hardening-unsubscribe@lists.openwall.com>
List-Subscribe: <mailto:kernel-hardening-subscribe@lists.openwall.com>
Subject: Re: [PATCH] rtc: s5m: Remove VLA usage
To: Kees Cook <keescook@chromium.org>,
 "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc: Sangbeom Kim <sbkim73@samsung.com>, Krzysztof Kozlowski
 <krzk@kernel.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
 Alessandro Zummo <a.zummo@towertech.it>,
 Alexandre Belloni <alexandre.belloni@bootlin.com>,
 LKML <linux-kernel@vger.kernel.org>, linux-samsung-soc@vger.kernel.org,
 linux-rtc@vger.kernel.org,
 Kernel Hardening <kernel-hardening@lists.openwall.com>
References: <20180308172031.GA14541@embeddedgus>
 <CAGXu5jLjKcYOPxQOV6GO1oaLj1M_K=cFu-kHLLEzP=ZOXaAtfA@mail.gmail.com>
From: "Gustavo A. R. Silva" <garsilva@embeddedor.com>
Message-ID: <23757731-bfa5-cb4c-ddc0-04103f9a72e0@embeddedor.com>
Date: Thu, 8 Mar 2018 12:03:29 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <CAGXu5jLjKcYOPxQOV6GO1oaLj1M_K=cFu-kHLLEzP=ZOXaAtfA@mail.gmail.com>
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
X-Exim-ID: 1etzt6-002cm8-3c
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: ([192.168.1.66]) [189.175.117.58]:53716
X-Source-Auth: garsilva@embeddedor.com
X-Email-Count: 10
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594390903982064564?=
X-GMAIL-MSGID: =?utf-8?q?1594394327371844576?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>



On 03/08/2018 11:58 AM, Kees Cook wrote:
> On Thu, Mar 8, 2018 at 9:20 AM, Gustavo A. R. Silva
> <gustavo@embeddedor.com> wrote:
>> In preparation to enabling -Wvla, remove VLAs and replace them
>> with fixed-length arrays instead.
>>
>>  From a security viewpoint, the use of Variable Length Arrays can be
>> a vector for stack overflow attacks. Also, in general, as the code
>> evolves it is easy to lose track of how big a VLA can get. Thus, we
>> can end up having segfaults that are hard to debug.
>>
>> Also, fixed as part of the directive to remove all VLAs from
>> the kernel: https://lkml.org/lkml/2018/3/7/621
>>
>> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
>> ---
>>   drivers/rtc/rtc-s5m.c | 15 +++++++++------
>>   1 file changed, 9 insertions(+), 6 deletions(-)
>>
>> diff --git a/drivers/rtc/rtc-s5m.c b/drivers/rtc/rtc-s5m.c
>> index 6deae10..2b5f4f7 100644
>> --- a/drivers/rtc/rtc-s5m.c
>> +++ b/drivers/rtc/rtc-s5m.c
>> @@ -38,6 +38,9 @@
>>    */
>>   #define UDR_READ_RETRY_CNT     5
>>
>> +/* Maximum number of registers for setting time/alarm0/alarm1 */
>> +#define MAX_NUM_TIME_REGS      8
> 
> I would adjust the various const struct s5m_rtc_reg_config's
> .regs_count to be represented by this new define, so the stack and the
> structures stay in sync. Something like:
> 
> static const struct s5m_rtc_reg_config s2mps13_rtc_regs = {
>          .regs_count             = MAX_NUM_TIME_REGS - 1,
> 
> ?
> 

Yep. I thought about that and decided to wait for some feedback first. 
But yeah, I think is that'd be a good change.

--
Gustavo

> -Kees
> 
>> +
>>   /*
>>    * Registers used by the driver which are different between chipsets.
>>    *
>> @@ -367,7 +370,7 @@ static void s5m8763_tm_to_data(struct rtc_time *tm, u8 *data)
>>   static int s5m_rtc_read_time(struct device *dev, struct rtc_time *tm)
>>   {
>>          struct s5m_rtc_info *info = dev_get_drvdata(dev);
>> -       u8 data[info->regs->regs_count];
>> +       u8 data[MAX_NUM_TIME_REGS];
>>          int ret;
>>
>>          if (info->regs->read_time_udr_mask) {
>> @@ -413,7 +416,7 @@ static int s5m_rtc_read_time(struct device *dev, struct rtc_time *tm)
>>   static int s5m_rtc_set_time(struct device *dev, struct rtc_time *tm)
>>   {
>>          struct s5m_rtc_info *info = dev_get_drvdata(dev);
>> -       u8 data[info->regs->regs_count];
>> +       u8 data[MAX_NUM_TIME_REGS];
>>          int ret = 0;
>>
>>          switch (info->device_type) {
>> @@ -450,7 +453,7 @@ static int s5m_rtc_set_time(struct device *dev, struct rtc_time *tm)
>>   static int s5m_rtc_read_alarm(struct device *dev, struct rtc_wkalrm *alrm)
>>   {
>>          struct s5m_rtc_info *info = dev_get_drvdata(dev);
>> -       u8 data[info->regs->regs_count];
>> +       u8 data[MAX_NUM_TIME_REGS];
>>          unsigned int val;
>>          int ret, i;
>>
>> @@ -500,7 +503,7 @@ static int s5m_rtc_read_alarm(struct device *dev, struct rtc_wkalrm *alrm)
>>
>>   static int s5m_rtc_stop_alarm(struct s5m_rtc_info *info)
>>   {
>> -       u8 data[info->regs->regs_count];
>> +       u8 data[MAX_NUM_TIME_REGS];
>>          int ret, i;
>>          struct rtc_time tm;
>>
>> @@ -545,7 +548,7 @@ static int s5m_rtc_stop_alarm(struct s5m_rtc_info *info)
>>   static int s5m_rtc_start_alarm(struct s5m_rtc_info *info)
>>   {
>>          int ret;
>> -       u8 data[info->regs->regs_count];
>> +       u8 data[MAX_NUM_TIME_REGS];
>>          u8 alarm0_conf;
>>          struct rtc_time tm;
>>
>> @@ -598,7 +601,7 @@ static int s5m_rtc_start_alarm(struct s5m_rtc_info *info)
>>   static int s5m_rtc_set_alarm(struct device *dev, struct rtc_wkalrm *alrm)
>>   {
>>          struct s5m_rtc_info *info = dev_get_drvdata(dev);
>> -       u8 data[info->regs->regs_count];
>> +       u8 data[MAX_NUM_TIME_REGS];
>>          int ret;
>>
>>          switch (info->device_type) {
>> --
>> 2.7.4
>>
> 
> 
> 
