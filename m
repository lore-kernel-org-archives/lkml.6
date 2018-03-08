Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Google-Smtp-Source: AG47ELtRDkMAiKM0vw4vRPKAdkQ9czO4jKHWhNho3DIWlYoIXZB2RQQ5pWN6BjkuYY21c+2cH2T3
ARC-Seal: i=1; a=rsa-sha256; t=1520531965; cv=none;
        d=google.com; s=arc-20160816;
        b=sSfntnwgCkHfyviKVWSvwTqDytbTcLcoAqvsYC1nhuOU8+xxlck19oj032/+JY7lhf
         FmRiaT3K2xDWtvocTY5TOXUks12529Zmy6xIyRwg2f2KiFwI62d/bVGhuMSAdGBoj5vI
         16pnizLesJEQWipMVGpdekyLXx8zOal1jb7dkxOnB7u0GajGmkNIZTlLwMIE28BRy4Yy
         gp6Oo75Pn1IVtN15cwhhlqgaHU5+Uim9REoMrrc437jE3ycBuFAFoR/chRRI6oAK9nXN
         w3tgRxRyhtEvWgAIjIHezXB1eh0ZMUWksdF+VTPn7TIJcPScktRDGQQkxjS4kswSkaGr
         kWGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=list-id:precedence:sender:content-transfer-encoding
         :content-language:in-reply-to:mime-version:user-agent:date
         :message-id:from:references:cc:to:subject:dkim-signature
         :arc-authentication-results;
        bh=FHERudumM546dYb+OJNFVamO9mpqrRBODzuigJ0lE5o=;
        b=hyVNKd8zbXXTMHN1946yHGd0BHd3VUmSAg+WgyMJeFINVJcOoj72a1tHhfsNEEorhb
         RIrbgMlKVL03GHOlEu13LjJ0n+iR4Tx3Do+VC13L3ukn3X8jdQdrKyppzvKDCnHhrKj/
         6I0kdad/aHjDDwnGINFk5Fh1EIo3Ib4Vl591hHFk9RFN+/NVmXazWkY0a71CFksqoiXZ
         0S2YQ+E/gc/HlQtM1Xuhwrqp20SuWz5HQcFAJk7Fyo/Szayih92JKLhyq68uYfWPHQz5
         EwfQrNpQLSej/MhBj7GK0E8vaChlyRB8BPupuj974gFYUhgjtjoOolIC9U6WvveKMAhH
         T32A==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=neutral (body hash did not verify) header.i=@gmail.com header.s=20161025 header.b=sUemHYkg;
       spf=pass (google.com: best guess record for domain of linux-kselftest-owner@vger.kernel.org designates 209.132.180.67 as permitted sender) smtp.mailfrom=linux-kselftest-owner@vger.kernel.org;
       dmarc=fail (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Authentication-Results: mx.google.com;
       dkim=neutral (body hash did not verify) header.i=@gmail.com header.s=20161025 header.b=sUemHYkg;
       spf=pass (google.com: best guess record for domain of linux-kselftest-owner@vger.kernel.org designates 209.132.180.67 as permitted sender) smtp.mailfrom=linux-kselftest-owner@vger.kernel.org;
       dmarc=fail (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936057AbeCHR7Y (ORCPT <rfc822;gregkh@linuxfoundation.org>);
        Thu, 8 Mar 2018 12:59:24 -0500
Received: from mail-pf0-f195.google.com ([209.85.192.195]:37199 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S936036AbeCHR7X (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 8 Mar 2018 12:59:23 -0500
Subject: Re: [PATCH] selftests/net: enable fragments for fib-onlink-tests
To: Anders Roxell <anders.roxell@linaro.org>, davem@davemloft.net,
        shuah@kernel.org
Cc: netdev@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20180308101723.19721-1-anders.roxell@linaro.org>
From: David Ahern <dsahern@gmail.com>
Message-ID: <4ee15d22-86d6-7e9e-4820-536cb38c9027@gmail.com>
Date: Thu, 8 Mar 2018 10:59:21 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.13; rv:52.0)
 Gecko/20100101 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180308101723.19721-1-anders.roxell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kselftest-owner@vger.kernel.org
X-Mailing-List: linux-kselftest@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594364269879247386?=
X-GMAIL-MSGID: =?utf-8?q?1594393326039925171?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 3/8/18 3:17 AM, Anders Roxell wrote:
> We miss CONFIG_* fragments so test fib-onlink-tests.sh can do:
> ip li add lisa type vrf table 1101
> ip li add veth1 type veth peer name veth2
> 
> And the follow message occurs if it isn't enabled:
> Configuring interfaces
> RTNETLINK answers: Operation not supported
> 
> This enables for NET_NRF (and friends) and VETH so we can create a vrf
> table and veth.
> 
> Fixes: 153e1b84f477 ("selftests: Add FIB onlink tests")
> Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
> ---
>  tools/testing/selftests/net/config | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/tools/testing/selftests/net/config b/tools/testing/selftests/net/config
> index 7177bea1fdfa..6a75a3ea44ad 100644
> --- a/tools/testing/selftests/net/config
> +++ b/tools/testing/selftests/net/config
> @@ -2,3 +2,8 @@ CONFIG_USER_NS=y
>  CONFIG_BPF_SYSCALL=y
>  CONFIG_TEST_BPF=m
>  CONFIG_NUMA=y
> +CONFIG_NET_VRF=y
> +CONFIG_NET_L3_MASTER_DEV=y
> +CONFIG_IPV6=y
> +CONFIG_IPV6_MULTIPLE_TABLES=y
> +CONFIG_VETH=y
> 

Thanks for updating the config.

The recent pmtu test needs quite a bit of additional configs as well.
