Return-Path: <kernel-hardening-return-11901-gregkh=linuxfoundation.org@lists.openwall.com>
X-Google-Smtp-Source: AH8x225KxfJu4bxTnIsAZ5SBd/oNfghxjh06u0/YDZO9y6YhudD8JQMzBXobo83QfZSgkN+eGxx+
ARC-Seal: i=1; a=rsa-sha256; t=1519328362; cv=none;
        d=google.com; s=arc-20160816;
        b=x7rc+Sr85HCLkjIyLslKBZkOv9G/ezwkK0kr9UQTC1THNGx99eSI+bN+9DjYP848fY
         T9CPSl0VdXc0l2EQZCF9exaSx1rQ83A+/aFChw6yvFVfK/fOu73bSTWic9omHDtnPL6S
         TGeTFMVUWOGVVL8q+L47VuSXUU2hzwX7ivd2hpu3l7/FyvdvgEiv9N1G89QN8FPtO7yt
         0WdGCx7VmW5CuDgNVJ403RMwGM+GmmIYQvY05xnOBzI+uY/RJQCEAUzqvNAa5Fk9zpd9
         jXDisfMATI+dKCRCxiR0mbCuSlUVS9JdxLD+/FU4GX5o880HSx+TrIC2PM2DucZ3btaz
         +BFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :delivered-to:list-id:list-subscribe:list-unsubscribe:list-help
         :list-post:precedence:mailing-list:arc-authentication-results;
        bh=HRhhWauvCZTaQnYVaRdacVqWy84eBsuPet5466dPEjA=;
        b=M6PcbdM3wNak8WSBUdfie7qcgXF+wIw6XZ7R/joEhsW+M1kABFKpvGW5cdpWR+6qdA
         9EmHvTB21+7CJRSXOoTIl9EUyn0Ik80jIxFVPbUr301SjCqc9IpPny/u18HtDMq0WY/6
         E5MqzQZvHlZWAurvATxxtq84uL63iKR4cWKfXQD5aJLWWT6/2azPVhMmB/3hQoSEuJRR
         7pAN60WtwcM0/Eoa2U+TdvzI+ledAhbrE+BoJH2OXIKxdSTnbvg3BeVur3lBRdRRMaOT
         h7I5Q+2E82Aeigug/45Y5d6QmjopIJwMjMFkWuck0UGg2XacQvN7X9pr7Q88sag8kVjv
         X4jA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of kernel-hardening-return-11901-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-11901-gregkh=linuxfoundation.org@lists.openwall.com;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=redhat.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of kernel-hardening-return-11901-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-11901-gregkh=linuxfoundation.org@lists.openwall.com;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=redhat.com
Mailing-List: contact kernel-hardening-help@lists.openwall.com; run by ezmlm
List-Post: <mailto:kernel-hardening@lists.openwall.com>
List-Help: <mailto:kernel-hardening-help@lists.openwall.com>
List-Unsubscribe: <mailto:kernel-hardening-unsubscribe@lists.openwall.com>
List-Subscribe: <mailto:kernel-hardening-subscribe@lists.openwall.com>
Subject: Re: [PATCH 1/2] stackleak: Update for arm64
To: Will Deacon <will.deacon@arm.com>
Cc: Alexander Popov <alex.popov@linux.com>, Kees Cook
 <keescook@chromium.org>, Mark Rutland <mark.rutland@arm.com>,
 Ard Biesheuvel <ard.biesheuvel@linaro.org>, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, kernel-hardening@lists.openwall.com,
 richard.sandiford@arm.com
References: <20180221011303.20392-1-labbott@redhat.com>
 <20180221011303.20392-2-labbott@redhat.com> <20180222165834.GC18421@arm.com>
From: Laura Abbott <labbott@redhat.com>
Message-ID: <fdd74037-5b47-b4e1-e692-54534d518e88@redhat.com>
Date: Thu, 22 Feb 2018 11:38:48 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.2
MIME-Version: 1.0
In-Reply-To: <20180222165834.GC18421@arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1592971096374608879?=
X-GMAIL-MSGID: =?utf-8?q?1593131257230754085?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 02/22/2018 08:58 AM, Will Deacon wrote:
> Hi Laura,
> 
> On Tue, Feb 20, 2018 at 05:13:02PM -0800, Laura Abbott wrote:
>>
>> arm64 has another layer of indirection in the RTL.
>> Account for this in the plugin.
>>
>> Signed-off-by: Laura Abbott <labbott@redhat.com>
>> ---
>>   scripts/gcc-plugins/stackleak_plugin.c | 5 +++++
>>   1 file changed, 5 insertions(+)
>>
>> diff --git a/scripts/gcc-plugins/stackleak_plugin.c b/scripts/gcc-plugins/stackleak_plugin.c
>> index 6fc991c98d8b..7dfaa027423f 100644
>> --- a/scripts/gcc-plugins/stackleak_plugin.c
>> +++ b/scripts/gcc-plugins/stackleak_plugin.c
>> @@ -244,6 +244,11 @@ static unsigned int stackleak_final_execute(void)
>>   		 * that insn.
>>   		 */
>>   		body = PATTERN(insn);
>> +		/* arm64 is different */
>> +		if (GET_CODE(body) == PARALLEL) {
>> +			body = XEXP(body, 0);
>> +			body = XEXP(body, 0);
>> +		}
> 
> Like most kernel developers, I don't know the first thing about GCC internals
> so I asked our GCC team and Richard (CC'd) reckons this should be:
> 
> 	if (GET_CODE(body) == PARALLEL)
> 		body = XVECEXP(body, 0, 0);
> 
> instead of the hunk above. Can you give that a go instead, please?
> 
> Cheers,
> 
> Will
> 

Yep, seems to work fine and makes sense from my understanding of
gcc internals. I'll fix it up for the next version. Thanks for the
review!

Laura
