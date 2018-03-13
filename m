Return-Path: <kernel-hardening-return-12488-gregkh=linuxfoundation.org@lists.openwall.com>
X-Google-Smtp-Source: AG47ELsbGLD3rkhbNpdSuToZBVdCI6pKdkJ56HceYR5B+P8L//FevB/zi78srp9exz4LACvsGjJ6
ARC-Seal: i=1; a=rsa-sha256; t=1520911352; cv=none;
        d=google.com; s=arc-20160816;
        b=tQm3tYoRTmnnIefljIRJdriBsjb9tFHpNqfnxui2T4kt5ceIiu5/khJeDERwlrZGXa
         d8VKaBE2iFLrC8FQUmGH4nXl2oB2SqofWBvWwyVT0udDsjRdEVw6IhkG0swo5WfuOOR1
         BTGSgVpYUdgzEVWbFNqrb6lgTlPu/398D4ENv7tHH2PHR0U8bTyQ9Ts6J7LX4JtdZ1TJ
         VFe2ELNI7/E7F/V6VbmhUVn8t6eDQUSO4MQExcmh/wJeqr1DFqk1kcgOF2un0aJuWoyR
         zLaHJxNIvrxwuMAaMX25Xwg459cQig24AJORWjvy+8llJG2tZ/tLu2shiVqNLBTUR6h2
         zlrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :delivered-to:list-id:list-subscribe:list-unsubscribe:list-help
         :list-post:precedence:mailing-list:arc-authentication-results;
        bh=w8sh1c7R1CPRrGv5TvhzGKNaknDg6zId58PoUvZRagM=;
        b=ph2RLj4HjQF4SKv90b2DeHFVVgFa2IJXhPgY51H2ixUHZ0r7Hh5Jb3gQJPn5TtPUnv
         qTcRUrRA5NR4pBeIksO3j2QqxyTB4on+q63TBCXzmxRg/cEQHFD1fjmeSgkRKd+yAeuc
         7PXpN7CuGpWOlgXV07/tCRfKn5IUWTaCHjZ6pqxP7DbaKpHy951cHCha/D86+aTUPFT6
         Q1+MWuYYkfs4+N4JDUl3xqahfmTVsD/pC2ykHr7P944SI62u4GpoOU8nyakdadwoebTj
         8mwEMa+v6mGMniEtrfhTfK2HfEDhJCVeiidc3O+j/g0xNEFlwwVmr44r6GNPKt/xwZ22
         ePyg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of kernel-hardening-return-12488-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12488-gregkh=linuxfoundation.org@lists.openwall.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of kernel-hardening-return-12488-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12488-gregkh=linuxfoundation.org@lists.openwall.com
Mailing-List: contact kernel-hardening-help@lists.openwall.com; run by ezmlm
List-Post: <mailto:kernel-hardening@lists.openwall.com>
List-Help: <mailto:kernel-hardening-help@lists.openwall.com>
List-Unsubscribe: <mailto:kernel-hardening-unsubscribe@lists.openwall.com>
List-Subscribe: <mailto:kernel-hardening-subscribe@lists.openwall.com>
Subject: Re: [PATCH 1/2] rtc: s5m: Move enum from rtc.h to rtc-s5m.c
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Sangbeom Kim <sbkim73@samsung.com>,
 Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
 Alessandro Zummo <a.zummo@towertech.it>,
 Alexandre Belloni <alexandre.belloni@bootlin.com>,
 Lee Jones <lee.jones@linaro.org>, linux-samsung-soc@vger.kernel.org,
 linux-rtc@vger.kernel.org, linux-kernel@vger.kernel.org,
 Kernel Hardening <kernel-hardening@lists.openwall.com>,
 Kees Cook <keescook@chromium.org>,
 "Gustavo A. R. Silva" <garsilva@embeddedor.com>
References: <cover.1520660422.git.gustavo@embeddedor.com>
 <44ee5bd5053d579dc6c46b21e2ef8f6acf70e4ce.1520660422.git.gustavo@embeddedor.com>
 <CAJKOXPdTgYRGvj99dYroY_6AvZD0KOV5yj+LUVNHWs7XUw8QsA@mail.gmail.com>
From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Message-ID: <44a4a527-1756-e3de-92e4-c47a8a0c433b@embeddedor.com>
Date: Mon, 12 Mar 2018 22:22:10 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <CAJKOXPdTgYRGvj99dYroY_6AvZD0KOV5yj+LUVNHWs7XUw8QsA@mail.gmail.com>
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
X-Exim-ID: 1evaVv-0036Ij-Pq
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: ([192.168.1.66]) [189.175.117.58]:44128
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 18
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594530993391759902?=
X-GMAIL-MSGID: =?utf-8?q?1594791142903088928?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>



On 03/11/2018 11:39 AM, Krzysztof Kozlowski wrote:
> On Sat, Mar 10, 2018 at 7:27 AM, Gustavo A. R. Silva
> <gustavo@embeddedor.com> wrote:
>> Move this enum to rtc-s5m.c once it is meaningless to others drivers [1].
>>
>> [1] https://marc.info/?l=linux-rtc&m=152060068925948&w=2
> 
> Instead of external link (which might or might not work soon) you can
> just put "Suggested-by: Krzysztof Kozlowski <krzk@kernel.org>".
> 

I got it.
I'll do that next time.

> Anyway:
> Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>
> 

Thanks for reviewing it.
--
Gustavo
