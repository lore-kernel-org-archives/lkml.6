Return-Path: <kernel-hardening-return-12390-gregkh=linuxfoundation.org@lists.openwall.com>
X-Google-Smtp-Source: AG47ELsaaZ0S10wdehGw4nSDX1A8ork9cHUmktkDk6Td1wjvWJn04kYoS4LxZ89o6mfRpALNpF3c
ARC-Seal: i=1; a=rsa-sha256; t=1520724428; cv=none;
        d=google.com; s=arc-20160816;
        b=XqrEKS98od8NM+uH+wWG6RREfjRmgIAlFkLl12PkbN9aNopEb7cEpSMWKgtI0vXRrP
         KubRPCtc8j2ZWY97EjoIvX1BSDUNQpN35paS1HXQsvHH1XQuSm/J7QP/qXr00E4L8sOk
         jTvweXgk9zC5HnMRAl29F5F24hemjqMcKqQAI/UFZ6k6HmEltg3i8fN9/wOj0iIzQdSq
         u166N8ZKRgKZXM+HATSS6Cd02ggOp8A47rPMUpBy3m9VsYyfmEp7Jm8b9OGGgdvCJiFi
         66S/1xvlsQ3JAGlSMmlc4iOT0pLJbxSgIzwW9Ys2riUJXpVDXFnpnNB+WcaIdO5U+ttq
         w8sQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :delivered-to:list-id:list-subscribe:list-unsubscribe:list-help
         :list-post:precedence:mailing-list:arc-authentication-results;
        bh=e48vBYAmygDVZLqlBKKezhwM/q9i0W3KI0sQr7IL9B0=;
        b=hsxFwWQqso6g1jjmpDAm/ikS2lNnPA02GmHg/vjqBquOEClZ6JVp7OijobGUJefHzs
         CDbQxpJATQyKHBb1hCPQ7mbnEXW2enXUUY/4zf/JWTVrX3HY3JsuUGXNggUOpo6H2Hc/
         fvjpUpBzwb2+Wos5QLorcj3+CEl0dPpCsnTD21uCVS2ZHTpcxhH+UHsnkNo1tidVplpo
         hPg19Of5/+4cNtgwamYFFxbiQMV5ZY9fd+B/g9fgNlp6mDeNpJSeDG9DxqVV5YIrKK5M
         NOefxElN20yP4LRF9B+n84ndBZZgurJjjneYEEvcI7FHYQ34ssmlRCik4w9cz5lC9YVK
         wFuA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of kernel-hardening-return-12390-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12390-gregkh=linuxfoundation.org@lists.openwall.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of kernel-hardening-return-12390-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12390-gregkh=linuxfoundation.org@lists.openwall.com
Mailing-List: contact kernel-hardening-help@lists.openwall.com; run by ezmlm
List-Post: <mailto:kernel-hardening@lists.openwall.com>
List-Help: <mailto:kernel-hardening-help@lists.openwall.com>
List-Unsubscribe: <mailto:kernel-hardening-unsubscribe@lists.openwall.com>
List-Subscribe: <mailto:kernel-hardening-subscribe@lists.openwall.com>
Subject: Re: [PATCH] drivers: net: wireless: ath: ath9: dfs: remove VLA usage
To: Kees Cook <keescook@chromium.org>,
 Arend van Spriel <arend.vanspriel@broadcom.com>
Cc: Andreas Christoforou <andreaschristofo@gmail.com>,
 Kernel Hardening <kernel-hardening@lists.openwall.com>,
 QCA ath9k Development <ath9k-devel@qca.qualcomm.com>,
 Kalle Valo <kvalo@codeaurora.org>,
 linux-wireless <linux-wireless@vger.kernel.org>,
 Network Development <netdev@vger.kernel.org>,
 LKML <linux-kernel@vger.kernel.org>
References: <1520598613-3641-1-git-send-email-andreaschristofo@gmail.com>
 <5AA464DE.90100@broadcom.com>
 <CAGXu5jKDA=L5E6Cu_oRe-M=ouuhrccCZHyM+z6_UMAUqe9xnRQ@mail.gmail.com>
From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Message-ID: <0475443a-5026-e897-bd52-9198f854919f@embeddedor.com>
Date: Sat, 10 Mar 2018 17:26:46 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <CAGXu5jKDA=L5E6Cu_oRe-M=ouuhrccCZHyM+z6_UMAUqe9xnRQ@mail.gmail.com>
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
X-Exim-ID: 1eunt1-002iV5-MV
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: ([192.168.1.66]) [189.175.117.58]:44090
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 4
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594463764603415966?=
X-GMAIL-MSGID: =?utf-8?q?1594595138562832011?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>



On 03/10/2018 05:12 PM, Kees Cook wrote:
> On Sat, Mar 10, 2018 at 3:06 PM, Arend van Spriel
> <arend.vanspriel@broadcom.com> wrote:
>> On 3/9/2018 1:30 PM, Andreas Christoforou wrote:
>>>
>>> The kernel would like to have all stack VLA usage removed.
>>
>>
>> I think there was a remark made earlier to give more explanation here. It
>> should explain why we want "VLA on stack" removed.
>>
>>> Signed-off-by: Andreas Christoforou <andreaschristofo@gmail.com>
>>> ---
>>>    drivers/net/wireless/ath/ath9k/dfs.c | 3 +--
>>>    1 file changed, 1 insertion(+), 2 deletions(-)
>>>
>>> diff --git a/drivers/net/wireless/ath/ath9k/dfs.c
>>> b/drivers/net/wireless/ath/ath9k/dfs.c
>>> index 6fee9a4..cfb0f84 100644
>>> --- a/drivers/net/wireless/ath/ath9k/dfs.c
>>> +++ b/drivers/net/wireless/ath/ath9k/dfs.c
>>> @@ -41,7 +41,6 @@ static const int BIN_DELTA_MAX                = 10;
>>>
>>>    /* we need at least 3 deltas / 4 samples for a reliable chirp detection
>>> */
>>>    #define NUM_DIFFS 3
>>> -static const int FFT_NUM_SAMPLES       = (NUM_DIFFS + 1);
>>>

What about this instead?

#define FFT_NUM_SAMPLES	(NUM_DIFFS + 1)

>>>    /* Threshold for difference of delta peaks */
>>>    static const int MAX_DIFF             = 2;
>>> @@ -101,7 +100,7 @@ static bool ath9k_check_chirping(struct ath_softc *sc,
>>> u8 *data,
>>>                                   int datalen, bool is_ctl, bool is_ext)
>>>    {
>>>          int i;
>>> -       int max_bin[FFT_NUM_SAMPLES];
>>> +       int max_bin[NUM_DIFFS + 1];
>>
>>
>> Just wondering. Is this actually a VLA. FFT_NUM_SAMPLES was static const so
>> not really going to show a lot of variation. This array will always have the
>> same size on the stack.
> 
> The problem is that it's not a "constant expression", so the compiler
> frontend still yells about it under -Wvla. I would characterize this
> mainly as a fix for "accidental VLA" or "misdetected VLA" or something
> like that. AIUI, there really isn't a functional change here.
> 
> -Kees
> 

--
Gustavo
