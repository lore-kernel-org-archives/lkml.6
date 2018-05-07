Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-1044495-1525700283-2-15575509807155758620
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_MED -2.3, SPF_PASS -0.001, LANGUAGES enda,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.138', Host='smtp1.osuosl.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: cc='UTF-8', plain='us-ascii'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1525700282; b=E68kpSUEln3/MJry2Ttr90+ptmhAzvmpd6Gv+vnc1GyIP9EW5w
    auDY2BZvQyjWIv3PfEzjGGnrkRkHliOS3Adr6xFCaQTNygUkB73zIpBfC62N+EkL
    wxjtbrlehzuLgmzD1sDaa/VfanlBh2FbzG2oAd37NdJ4rckT+do5ECsgKKS0rzhY
    ZHxDblBctzXUHhaN8EEmMqJk+MAs20qEBeSQy/Ei7gPpd4JQOwGTdhHWpnUuPjJ9
    4GFKm5JwlRyAOv6krS837K3HexMbJPw4Li7N6DeRCfgR9TtVfNdo2JMorwrgUwdu
    jHvGlA7CKS0McKlaJ6t0l9YDqu3Ikv4fHxvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=subject:to:references:from:message-id
    :date:mime-version:in-reply-to:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:cc
    :content-transfer-encoding:content-type:sender; s=fm2; t=
    1525700282; bh=XxyhlQn1G9nWYcdwv6H3kN+j9tBAVvzsyEPEoaJYUKM=; b=a
    06e3dAhArZLAbmd7GC/YHo8Sx4/730k2sdzqhXvEgkJPgGT4RSeuAnoDQ116unAm
    00/WrEuToLA8RbuhFc4VCeEQaNlDG90TJEK7/veUg0sZHA07YCJTeEYfNZd2L1f9
    kBOVETmBvVRY3wWCZgPcaPlx4QuaMn4gD1TctuJz14Z46ovg7Kfe4Mbkukx3zRWH
    uE3lO7ElUmZDF4pAdtxk5NdJka8gV56kZCZWy5GxN8v+K9iaWBT0oH22RhZx06Yr
    XM2Y8JNdLyUdPEqfVNpxrLLkvR0AiwiiWw5OY+CiD+/EApydT6D4KCMdzgCyTT88
    bPw4K3VE4xiVrqXSlQzrA==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=redhat.com;
    iprev=pass policy.iprev=140.211.166.138 (smtp1.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org
    smtp.helo=whitealder.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key)
    header.d=1e100.net header.i=@1e100.net header.b=mHrEv139;
    x-ptr=fail x-ptr-helo=whitealder.osuosl.org
    x-ptr-lookup=smtp1.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass
    smtp_is_org_domain=yes header.domain=redhat.com header.result=pass
    header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256
    bits=128/128;
    x-vs=clean score=-100 state=0
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=redhat.com;
    iprev=pass policy.iprev=140.211.166.138 (smtp1.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org
      smtp.helo=whitealder.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key)
      header.d=1e100.net header.i=@1e100.net header.b=mHrEv139;
    x-ptr=fail x-ptr-helo=whitealder.osuosl.org
      x-ptr-lookup=smtp1.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass
      smtp_is_org_domain=yes header.domain=redhat.com header.result=pass
      header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256
      bits=128/128;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfN2mB8fdw3hy/SiTnAKDy8eflNpDQUYuocLvEcvFtudovmv8tP6z8nzXcr7OeSdBzq34pAP6bshmoEJPti7ttw/GX1wub7hoDs9tOn0JHZyTI0uJu//5
    uCQqoAemvUUuJkcLuNJNElzzBCBCNMltQlPU46s57yV7CseTRKlid0UypSfitmm3uEicW4b6NgR9kUsFWHevmkhd6QtLZEskVRjSIive3pAfOX7Zz/C8mGJo
    Cr74PKeYdJ3gEKC+IJvO8w==
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=28bQ1EhdAjTzU1YDPmtEKw==:117
    a=28bQ1EhdAjTzU1YDPmtEKw==:17 a=kj9zAlcOel0A:10 a=xqWC_Br6kY4A:10
    a=4_-BN3WEXhEA:10 a=VUJBJC2UJ8kA:10 a=-uNXE31MpBQA:10 a=jJxKW8Ag-pUA:10
    a=pGLkceISAAAA:8 a=DDOyTI_5AAAA:8 a=TRWpO32UhXafe42D_Z0A:9 a=CjuIK1q_8ugA:10
    a=_BcfOz0m4U4ohdxiHPKc:22 cc=dsc
X-ME-CMScore: 0
X-ME-CMCategory: discussion
X-Remote-Delivered-To: driverdev-devel@osuosl.org
X-Google-Smtp-Source: AB8JxZrZrWaXnju2VSxWJNEqggLEolTxG7ZQGltVeW9ww0WzhXxOfAIDNpPVOz4t6KSxZ5QMicXZIg==
Subject: Re: [PATCH 1/2] staging: android: ion: Fix license identifier comment
 format
To: Nathan Chancellor <natechancellor@gmail.com>, devel@driverdev.osuosl.org,
 dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Joe Perches <joe@perches.com>
References: <20180507011854.12627-1-natechancellor@gmail.com>
From: Laura Abbott <labbott@redhat.com>
Message-ID: <d157b475-7893-3ab6-87a8-b6ce5aa13b4f@redhat.com>
Date: Mon, 7 May 2018 06:37:52 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180507011854.12627-1-natechancellor@gmail.com>
Content-Language: en-US
X-BeenThere: driverdev-devel@linuxdriverproject.org
X-Mailman-Version: 2.1.24
 <driverdev-devel.linuxdriverproject.org>
List-Unsubscribe: <http://driverdev.linuxdriverproject.org/mailman/options/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=unsubscribe>
List-Archive: <http://driverdev.linuxdriverproject.org/pipermail/driverdev-devel/>
List-Post: <mailto:driverdev-devel@linuxdriverproject.org>
List-Help: <mailto:driverdev-devel-request@linuxdriverproject.org?subject=help>
List-Subscribe: <http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=subscribe>
Cc: Todd Kjos <tkjos@android.com>,
 =?UTF-8?Q?Arve_Hj=c3=b8nnev=c3=a5g?= <arve@android.com>,
 Martijn Coenen <maco@android.com>, Sumit Semwal <sumit.semwal@linaro.org>,
 linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 05/06/2018 06:18 PM, Nathan Chancellor wrote:
> checkpatch.pl complains these are invalid because the rules in
> Documentation/process/license-rules.rst state that C headers should
> have "/* */" style comments.
> 

The SPDX markings are special, but I don't see anything from a
quick read of the SPDX specification that says they have to use //.
I think this is going to generate a lot of possible noise so it
might be worth adjusting checkpatch.

Thanks,
Laura

> Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
> ---
>   drivers/staging/android/ion/ion.h  | 2 +-
>   drivers/staging/android/uapi/ion.h | 2 +-
>   2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/staging/android/ion/ion.h b/drivers/staging/android/ion/ion.h
> index ea0897812780..16cbd38a7160 100644
> --- a/drivers/staging/android/ion/ion.h
> +++ b/drivers/staging/android/ion/ion.h
> @@ -1,4 +1,4 @@
> -// SPDX-License-Identifier: GPL-2.0
> +/* SPDX-License-Identifier: GPL-2.0 */
>   /*
>    * drivers/staging/android/ion/ion.h
>    *
> diff --git a/drivers/staging/android/uapi/ion.h b/drivers/staging/android/uapi/ion.h
> index 825d3e95ccd3..5d7009884c13 100644
> --- a/drivers/staging/android/uapi/ion.h
> +++ b/drivers/staging/android/uapi/ion.h
> @@ -1,4 +1,4 @@
> -// SPDX-License-Identifier: GPL-2.0
> +/* SPDX-License-Identifier: GPL-2.0 */
>   /*
>    * drivers/staging/android/uapi/ion.h
>    *
> 

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
