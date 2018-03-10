Return-Path: <kernel-hardening-return-12362-gregkh=linuxfoundation.org@lists.openwall.com>
X-Google-Smtp-Source: AG47ELs297Zb3QrDg43YUnMZ5TeC82xpkrNyNqZkeOXa7LLzXNoafgTrJ8NTGRWoCE2K8HF5VcDP
ARC-Seal: i=1; a=rsa-sha256; t=1520656518; cv=none;
        d=google.com; s=arc-20160816;
        b=1KUsS3TSL5rqXM7RhHFTeNFbRKOzeQ/s8IRhOjh6hFPU6E40jGsU89JYQGtY66P9bl
         zPaXpXK2/3WU9PBm7kUodRQoKEL+Hi29Xmq8F92147NxlOYE6YxN6G08tZUJH9VtALON
         ehd6ikSQCackaPXhQhFBYGZ8kFZosoHBFLgbzt6ajM/ge/2sJ2QV/4d1aA/AQowJc+ZO
         DumbH8e1HLZ/U3DbEunAV51ZDkB9XgiOQds5O0zipJdfNQvVIxOjETFHyRdjQraFdBXY
         BcGBzMqhsJSS6MoT/jEIMR97h6J+QyomLNcOOhYmdFCrOTs4hirdrdH/VwSfSKtsz3Kv
         oMXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :delivered-to:list-id:list-subscribe:list-unsubscribe:list-help
         :list-post:precedence:mailing-list:arc-authentication-results;
        bh=UdNzmENpHvT1r2mQTN6zK+yc//7GsIZFDARKlPydqmY=;
        b=kZD1lzk+eoyVVNdSeFj/DjJ6DWuSMCBnm+Fpg7XEUs92t4M3a4s5yOLRLAJaD1+4AP
         pRCls5UxE1N3mECK/ZYJg1N2Y2gJI8mwmEcWJHQpYvV0qBKtyyaVTJZJn1sVxiYi5XDe
         a9T89jPPpbXpiMS08cYPeZo8rsi9EpqkEgezKRFM4AfCLl+1Z1JlVFF8T0kdv8mnLEXy
         bVCvvK/VTEbXt0W/L6B4JSNFFqSrRH33VeQ2MAIXVXogcL75a4hW8MqFRDtrH3caFP6O
         +eCsBXPdXlhVooBnpa0j3zq87algkVwCv1mIWyxu1bglaG1HagoR1MuUtAfcQGdDDhsv
         4kEA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of kernel-hardening-return-12362-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12362-gregkh=linuxfoundation.org@lists.openwall.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of kernel-hardening-return-12362-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12362-gregkh=linuxfoundation.org@lists.openwall.com
Mailing-List: contact kernel-hardening-help@lists.openwall.com; run by ezmlm
List-Post: <mailto:kernel-hardening@lists.openwall.com>
List-Help: <mailto:kernel-hardening-help@lists.openwall.com>
List-Unsubscribe: <mailto:kernel-hardening-unsubscribe@lists.openwall.com>
List-Subscribe: <mailto:kernel-hardening-subscribe@lists.openwall.com>
Subject: Re: [PATCH] rtc: s5m: Remove VLA usage
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Kees Cook <keescook@chromium.org>,
 "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
 Sangbeom Kim <sbkim73@samsung.com>,
 Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
 Alessandro Zummo <a.zummo@towertech.it>,
 Alexandre Belloni <alexandre.belloni@bootlin.com>,
 LKML <linux-kernel@vger.kernel.org>, linux-samsung-soc@vger.kernel.org,
 linux-rtc@vger.kernel.org,
 Kernel Hardening <kernel-hardening@lists.openwall.com>
References: <20180308172031.GA14541@embeddedgus>
 <CAGXu5jLjKcYOPxQOV6GO1oaLj1M_K=cFu-kHLLEzP=ZOXaAtfA@mail.gmail.com>
 <23757731-bfa5-cb4c-ddc0-04103f9a72e0@embeddedor.com>
 <CAJKOXPf+4tF4oq5ePsgcpUAQS_M2Vi6b1+J-8D9CVemO-6ve5g@mail.gmail.com>
From: "Gustavo A. R. Silva" <garsilva@embeddedor.com>
Message-ID: <4f25592d-e805-b81e-b518-4b60867ef32a@embeddedor.com>
Date: Fri, 9 Mar 2018 22:34:55 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <CAJKOXPf+4tF4oq5ePsgcpUAQS_M2Vi6b1+J-8D9CVemO-6ve5g@mail.gmail.com>
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
X-Exim-ID: 1euWDi-0047V5-1a
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: ([192.168.1.66]) [189.175.117.58]:35318
X-Source-Auth: garsilva@embeddedor.com
X-Email-Count: 10
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594390903982064564?=
X-GMAIL-MSGID: =?utf-8?q?1594523929281388886?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>


Hi Krzysztof,

On 03/09/2018 07:04 AM, Krzysztof Kozlowski wrote:
> On Thu, Mar 8, 2018 at 7:03 PM, Gustavo A. R. Silva
> <garsilva@embeddedor.com> wrote:
>>
>>
>> On 03/08/2018 11:58 AM, Kees Cook wrote:
>>>
>>> On Thu, Mar 8, 2018 at 9:20 AM, Gustavo A. R. Silva
>>> <gustavo@embeddedor.com> wrote:
>>>>
>>>> In preparation to enabling -Wvla, remove VLAs and replace them
>>>> with fixed-length arrays instead.
>>>>
>>>>   From a security viewpoint, the use of Variable Length Arrays can be
>>>> a vector for stack overflow attacks. Also, in general, as the code
>>>> evolves it is easy to lose track of how big a VLA can get. Thus, we
>>>> can end up having segfaults that are hard to debug.
>>>>
>>>> Also, fixed as part of the directive to remove all VLAs from
>>>> the kernel: https://lkml.org/lkml/2018/3/7/621
>>>>
>>>> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
>>>> ---
>>>>    drivers/rtc/rtc-s5m.c | 15 +++++++++------
>>>>    1 file changed, 9 insertions(+), 6 deletions(-)
>>>>
>>>> diff --git a/drivers/rtc/rtc-s5m.c b/drivers/rtc/rtc-s5m.c
>>>> index 6deae10..2b5f4f7 100644
>>>> --- a/drivers/rtc/rtc-s5m.c
>>>> +++ b/drivers/rtc/rtc-s5m.c
>>>> @@ -38,6 +38,9 @@
>>>>     */
>>>>    #define UDR_READ_RETRY_CNT     5
>>>>
>>>> +/* Maximum number of registers for setting time/alarm0/alarm1 */
>>>> +#define MAX_NUM_TIME_REGS      8
>>>
>>>
>>> I would adjust the various const struct s5m_rtc_reg_config's
>>> .regs_count to be represented by this new define, so the stack and the
>>> structures stay in sync. Something like:
>>>
>>> static const struct s5m_rtc_reg_config s2mps13_rtc_regs = {
>>>           .regs_count             = MAX_NUM_TIME_REGS - 1,
>>>
>>> ?
>>>
>>
>> Yep. I thought about that and decided to wait for some feedback first. But
>> yeah, I think is that'd be a good change.
> 
> Define and these assignments should be somehow connected with enum
> defining the offsets for data[] (from
> include/linux/mfd/samsung/rtc.h). Otherwise we define the same in two
> places. The enum could be itself (in separate patch) moved to the
> driver because it is meaningless for others.
>

I got it.

I'll move the enum to rtc-s5m.c and add RTC_MAX_NUM_TIME_REGS at the end 
of it. I'll send a patch series for this.

Thanks for the feedback.
--
Gustavo

> Best regards,
> Krzysztof
> 
