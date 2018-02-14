Return-Path: <tcminyard@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1518644795; cv=none;
        d=google.com; s=arc-20160816;
        b=sNQgOJAwG+UzW2FYtTI9YEwSRNPyiAFlrDr8Wt+hsBHfcWxYqH7ENh39xoeERzmg5T
         38rHD518h902ZwlBQuXPjn5Su1O6YCfHvGPAxV/bfOWtRvOHbatrjjuAIFnJZ5LD5gB4
         NiyyCB2rfm32JD9WnaFaKBESq2k3ohSMTh0kp4WEo1M9IRg6L9O1axaH1kbf3TeecciE
         c0MkmqXSr2v8XL+O+VRJEtTrCab4icSPEW7eqbsb9KZRdwgmlCQ1QnTERUmCOT8NuKXv
         n4m8pJkymb/C70zZOMsJB94W+SwlWz3Ex6/E4V0Pc4Ih7jMOFb7YeukRKDIYV9Tv38Hq
         TsyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-language:content-transfer-encoding:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject:reply-to
         :sender:dkim-signature:arc-authentication-results;
        bh=QvWA/VGBkrJmg7IkLhHS0FF7KXKbsoiWPJvgnWz2x6M=;
        b=q7uwvJk3yUl8gYo9kiJG+5525TrTsanwxrDVcLGPVDQwGBAi3ca7SH2W8fXfObkppe
         ModiOMtcVfzUwXW15e13A2Zda7gnx4H7+UdiDyjaexc1n+dDkwXfRZ6j9v2sNhJihMMc
         Wuf9WXTiPCgkSw7o51vnDvAS52P7OLav2gmnK2XNx1f0EutIltVFCMdDoOL1BHsmg4Ja
         fZlpkA2G4DXVys1ukcwDbBaZArcMRd7ILgg3eAuOi9Q0XA5/sy0lYJk8nAIf8sj3cPZM
         FwyF2PeaAPHkG1ScVL5wrdBmyoQJdWyI+IChio8K5Vj+PYVnMLonOa5sQS+vVdvbf/9L
         m/ug==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=lMYFbIF3;
       spf=pass (google.com: domain of tcminyard@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=tcminyard@gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=lMYFbIF3;
       spf=pass (google.com: domain of tcminyard@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=tcminyard@gmail.com
X-Google-Smtp-Source: AH8x227GuIdUSMibP0KDX0jp31lu3ytHZphaqOQ+nQTR3WNv2igi/9/Ldky2JdXtr6f30rSeqmXm4A==
Sender: Corey Minyard <tcminyard@gmail.com>
Reply-To: minyard@acm.org
Subject: Re: [PATCH] ipmi: kcs_bmc: mark expected switch fall-through in
 kcs_bmc_handle_data
To: "Gustavo A. R. Silva" <garsilva@embeddedor.com>,
 Arnd Bergmann <arnd@arndb.de>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: openipmi-developer@lists.sourceforge.net, linux-kernel@vger.kernel.org,
 Haiyue Wang <haiyue.wang@linux.intel.com>
References: <20180214173029.GA15661@embeddedor.com>
From: Corey Minyard <minyard@acm.org>
Message-ID: <9098c6c8-83e5-5e1f-519b-68e14738c24a@acm.org>
Date: Wed, 14 Feb 2018 15:46:31 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180214173029.GA15661@embeddedor.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-GB
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1592398376863502226?=
X-GMAIL-MSGID: =?utf-8?q?1592414485279513230?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 02/14/2018 11:30 AM, Gustavo A. R. Silva wrote:
> In preparation to enabling -Wimplicit-fallthrough, mark switch cases
> where we are expecting to fall through.

Thanks, queued for next release.

-corey

> Addresses-Coverity-ID: 1465255 ("Missing break in switch")
> Signed-off-by: Gustavo A. R. Silva <garsilva@embeddedor.com>
> ---
> This code was compiled with GCC 7.3.0
>
>   drivers/char/ipmi/kcs_bmc.c | 1 +
>   1 file changed, 1 insertion(+)
>
> diff --git a/drivers/char/ipmi/kcs_bmc.c b/drivers/char/ipmi/kcs_bmc.c
> index 3a3498a..6476bfb 100644
> --- a/drivers/char/ipmi/kcs_bmc.c
> +++ b/drivers/char/ipmi/kcs_bmc.c
> @@ -95,6 +95,7 @@ static void kcs_bmc_handle_data(struct kcs_bmc *kcs_bmc)
>   	switch (kcs_bmc->phase) {
>   	case KCS_PHASE_WRITE_START:
>   		kcs_bmc->phase = KCS_PHASE_WRITE_DATA;
> +		/* fall through */
>   
>   	case KCS_PHASE_WRITE_DATA:
>   		if (kcs_bmc->data_in_idx < KCS_MSG_BUFSIZ) {
