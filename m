Return-Path: <kernel-hardening-return-11900-gregkh=linuxfoundation.org@lists.openwall.com>
X-Google-Smtp-Source: AG47ELuYnwc/ysehTFB83KKXHOUhvxhoRLWTYc+IU850ekKPmxWHoSRfbffnsHuNhN9AKxaXZunH
ARC-Seal: i=1; a=rsa-sha256; t=1519327355; cv=none;
        d=google.com; s=arc-20160816;
        b=uQPkqyRFgVc5PHQdJtW3BtdAFBjj4A/aPp8jIIrJz0AVZsuDUXJ84YNfAVdS+3+9Lw
         im94V3RiE08n/6r59MHUcoC1xT2rqOPCUmY4ReYZ+WxzZC+vo6dBCA9r5+aLTxrZAxvx
         3VIBcuvI9aphnCpcS/lXbOmHmktEtgtwOpLSQfp4ZrzIoMmsVbg6dg+T4Wv/Zz/BGesH
         FADXO249eEmgpb95evA/gIISlfk1SXENUFgtEq+XU0e3/uf2i36gHD3KtBBS5UiQNIB7
         liw6q68T+Kv+hYpF1Y/6EyYKuOSslKJaegGDbL5u+Cy3oUz/7yN+LyEA6eouA1kenIxN
         atAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :delivered-to:list-id:list-subscribe:list-unsubscribe:list-help
         :list-post:precedence:mailing-list:arc-authentication-results;
        bh=E1hqoSpvGH4ANSrwoSllXeCHrLXV3Fz097xijgTcsEg=;
        b=M6mZfabrq3jtwoXh8vQxOyNUSR1Ba7ME5IMOv4xSKqhJW/tDg/d7VCiWFYGU+oeV0v
         1c95qvyBMU8P3ekyBIFrmN9iTO7NQzCfpoZ7/CUe4T9C8m+D8uAwWceRB/EfOszkGLow
         pEzEtUI9xn+4fBE0SZmnihfo5RaH6Ji5DMKBDCeiHlKjUUgnQoQJqQIXbeAg8hxr3dps
         31BJMmDczfGwWhfSI8xyU2aHlYy1eT8XSV7cMoBYzR9QOfRVXPVRsKsFg8aDMlx8Ykms
         r8RgN/k9H2w4zPyKZYlEQa+76gaj3vIxWgASKjNt2vKvkXnfDuI4Ofm/vMTiwPg6+Q+u
         O7FQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of kernel-hardening-return-11900-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-11900-gregkh=linuxfoundation.org@lists.openwall.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of kernel-hardening-return-11900-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-11900-gregkh=linuxfoundation.org@lists.openwall.com
Mailing-List: contact kernel-hardening-help@lists.openwall.com; run by ezmlm
List-Post: <mailto:kernel-hardening@lists.openwall.com>
List-Help: <mailto:kernel-hardening-help@lists.openwall.com>
List-Unsubscribe: <mailto:kernel-hardening-unsubscribe@lists.openwall.com>
List-Subscribe: <mailto:kernel-hardening-subscribe@lists.openwall.com>
Subject: Re: [PATCH 1/2] stackleak: Update for arm64
To: Will Deacon <will.deacon@arm.com>, Laura Abbott <labbott@redhat.com>
Cc: Kees Cook <keescook@chromium.org>, Mark Rutland <mark.rutland@arm.com>,
 Ard Biesheuvel <ard.biesheuvel@linaro.org>, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, kernel-hardening@lists.openwall.com,
 richard.sandiford@arm.com
References: <20180221011303.20392-1-labbott@redhat.com>
 <20180221011303.20392-2-labbott@redhat.com> <20180222165834.GC18421@arm.com>
From: Alexander Popov <alex.popov@linux.com>
Message-ID: <97090ca6-efad-7c03-6084-a97674ae61c7@linux.com>
Date: Thu, 22 Feb 2018 22:22:14 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180222165834.GC18421@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1592971096374608879?=
X-GMAIL-MSGID: =?utf-8?q?1593130201025056848?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hello Will, Richard and GCC folks!

On 22.02.2018 19:58, Will Deacon wrote:
> On Tue, Feb 20, 2018 at 05:13:02PM -0800, Laura Abbott wrote:
>>
>> arm64 has another layer of indirection in the RTL.
>> Account for this in the plugin.
>>
>> Signed-off-by: Laura Abbott <labbott@redhat.com>
>> ---
>>  scripts/gcc-plugins/stackleak_plugin.c | 5 +++++
>>  1 file changed, 5 insertions(+)
>>
>> diff --git a/scripts/gcc-plugins/stackleak_plugin.c b/scripts/gcc-plugins/stackleak_plugin.c
>> index 6fc991c98d8b..7dfaa027423f 100644
>> --- a/scripts/gcc-plugins/stackleak_plugin.c
>> +++ b/scripts/gcc-plugins/stackleak_plugin.c
>> @@ -244,6 +244,11 @@ static unsigned int stackleak_final_execute(void)
>>  		 * that insn.
>>  		 */
>>  		body = PATTERN(insn);
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

Thanks a lot!

Would you be so kind to take a look at the whole STACKLEAK plugin?
http://www.openwall.com/lists/kernel-hardening/2018/02/16/4
https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git/commit/?h=kspp/gcc-plugin/stackleak&id=57a0a6763b12e82dd462593d0f42be610e93cdc9

It's not very big. I documented it in detail. I would be really grateful for the
review!

Best regards,
Alexander
