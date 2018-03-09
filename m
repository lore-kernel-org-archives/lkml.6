Return-Path: <kernel-hardening-return-12306-gregkh=linuxfoundation.org@lists.openwall.com>
X-Google-Smtp-Source: AG47ELvkVJYQnjyh6u3pJjRy/FKSBACxyxhDJ31g+M+8rUdQSSZFqZcK+7kHrEbg5I6XJY2Xklvx
ARC-Seal: i=1; a=rsa-sha256; t=1520583745; cv=none;
        d=google.com; s=arc-20160816;
        b=YMymvXX+zs4VMDw0z917i8dYjNzpOUllI8RdT9DIgjQT19QAc5KuxD9o9z6SpsIP8y
         r4OJzT4dtYl47KBuhCzJ4Uj2uj9EAbvbbHYCq5whaGPRa3rBlij/jo7v8ypNH0NWNZdY
         a67Fz3jSSHXLyYBqmWxZqVbbe4nki18z9YYiqruI6vkWE9bVVkvxWVROnRMT9DidzHE1
         gUAJlSSgKShc64s8P4Zr1Fl8Bt/9iIfI5E1jfpr6C5YVtCmhUO3kqwmUAdjozsb+AayI
         BZxgxGIYOHCsv/KwlAgTP/3l6Okd63FDTnbaZ9R/8stV+562z6moFPH8FQ42f928CICW
         L/bg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :delivered-to:list-id:list-subscribe:list-unsubscribe:list-help
         :list-post:precedence:mailing-list:arc-authentication-results;
        bh=anWlGGDX39mLNC4/CJuJXlCwp+yPd/7gcLZQj6vBy3g=;
        b=C+SJHtCyxWH7//pExAJv5HHnjvzy8Py1Nq6HGaRfRSZSt0sZKFqF4rYSqc1Xbw6mrA
         a6jVEyBz9HA7awMlgrDdokkMwQVgo3rjfa8iGdkCPTIfXaj+mc7vmSQ5wHay5m2rDy9H
         U5zc0KrZVetAYP0wnmFkk4hwzVFATLA3namueUynV/UmdoF5t/3Gttfx5V0UddmMA63E
         /ZtVCbUcLa2Iaj/TdUjjfVJ37bja3uroVnMR/qNJ8vXnGNbBXL8LzAzdbSfjriQiQ705
         celtXg28vrAfrI609AROzwzj1ho+0PQ1rGG2CUXFw+k8YcygcJgtiIecDU9a+cZiRtZK
         87TA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of kernel-hardening-return-12306-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12306-gregkh=linuxfoundation.org@lists.openwall.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of kernel-hardening-return-12306-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12306-gregkh=linuxfoundation.org@lists.openwall.com
Mailing-List: contact kernel-hardening-help@lists.openwall.com; run by ezmlm
List-Post: <mailto:kernel-hardening@lists.openwall.com>
List-Help: <mailto:kernel-hardening-help@lists.openwall.com>
List-Unsubscribe: <mailto:kernel-hardening-unsubscribe@lists.openwall.com>
List-Subscribe: <mailto:kernel-hardening-subscribe@lists.openwall.com>
X-IronPort-AV: E=Sophos;i="5.47,444,1515481200";
   d="scan'208";a="12150691"
Subject: Re: [PATCH] crypto/ecc: Remove stack VLA usage
To: Kees Cook <keescook@chromium.org>
CC: Herbert Xu <herbert@gondor.apana.org.au>, LKML
	<linux-kernel@vger.kernel.org>, "David S. Miller" <davem@davemloft.net>,
	linux-crypto <linux-crypto@vger.kernel.org>, Kernel Hardening
	<kernel-hardening@lists.openwall.com>
References: <20180307215615.GA18928@beast>
 <4fbe11f1-c92e-a4d5-616d-01e983f5405f@microchip.com>
 <CAGXu5jKEM8ot_YQ8Jt=npGrVWSwj=ROse4YOyQb9QmpEQkx=sg@mail.gmail.com>
From: Tudor Ambarus <tudor.ambarus@microchip.com>
Message-ID: <7d80acb8-89e7-0afe-6c00-4936145d611d@microchip.com>
Date: Fri, 9 Mar 2018 10:21:59 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <CAGXu5jKEM8ot_YQ8Jt=npGrVWSwj=ROse4YOyQb9QmpEQkx=sg@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594317666211482580?=
X-GMAIL-MSGID: =?utf-8?q?1594447621936449403?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>



On 03/08/2018 11:55 PM, Kees Cook wrote:
>> Looks like there are few intermediate buffers in ecc
>> that should be zeroized as well.
> Can you send a patch for those?

Yeah, I'll take a look.

Best,
ta
