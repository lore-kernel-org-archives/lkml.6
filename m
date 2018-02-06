Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-2292549-1517957547-2-4331636224388412608
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, RCVD_IN_DNSWL_MED -2.3,
  SPF_PASS -0.001, LANGUAGES unknown, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.137', Host='smtp4.osuosl.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1517957547; b=kKbiuQPtyZhbB873C+NlgzSxT/WZeielCVFbEAlLHSmX9Ig
    d/jnfWUsmavDQmD7kYXdXnjTDgPnpH4OSvCc9E3CvYXw0eJxRIaVgd6B3HWr+wo3
    NNkeACfFL8qyVSh9BO2dBdmHDktUO8A0SsvbEpCZ0gwM606URytOQ8ETRURZl3yz
    xWL0U0MbuRn7sIvhSGfc5+8HfUo5ZOfguHb6UgQHU/7xs8VMgoUGip/qQnqydvoO
    klHsDy2u/ewgLxF76NhMbLPRsKfHsX1v6Qf4tfISYYW8yKm3tb+jcZnYcbGU1Oz3
    RGFuMqdvwSMz/OagaCBtMofpGMbcY8GpvpVZucw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=subject:to:references:from:message-id
    :date:mime-version:in-reply-to:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:cc
    :content-transfer-encoding:content-type:sender; s=arctest; t=
    1517957547; bh=Z2gRIM5gQti/nmrTXMbKJxBO/nHhgogt+scgkouaz94=; b=m
    MJsosbmVtOn+xNXSvBT34+BwW8AiDWiU2jXWay75TTZAovJaYpW3MvtFUp019Ia0
    9o4gQ9r0JCTxUGQ0vuFPuIpa9qLZMNNqhPcKL3au05DUiGLeGmTfmmNt78CDLpg0
    152SrLA+BklQ9TqFFNVTkQfM1D4FXQc0/PnY3OjFy1sNvxxwFXm6GwHhlSi4pYRn
    9IPTiTNNCGa/U4m3PkOdiewL3PrH62I05RmveEp9QoIdwggbUsoxREu2r3mSnooW
    BnIIuji2sdBgnl0w6DHcSxbDcFGHaSJUIoiAAyUPQCKAcEPe6Hv+KRQn4TY0CCIE
    lJ3KKT+7T6NK2C7pb7MWQ==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=redhat.com;
    iprev=pass policy.iprev=140.211.166.137 (smtp4.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=fraxinus.osuosl.org;
    x-aligned-from=fail;
    x-google-dkim=fail (message has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=bMZkjrNE;
    x-ptr=fail x-ptr-helo=fraxinus.osuosl.org x-ptr-lookup=smtp4.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=redhat.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=redhat.com;
    iprev=pass policy.iprev=140.211.166.137 (smtp4.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=fraxinus.osuosl.org;
    x-aligned-from=fail;
    x-google-dkim=fail (message has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=bMZkjrNE;
    x-ptr=fail x-ptr-helo=fraxinus.osuosl.org x-ptr-lookup=smtp4.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=redhat.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
X-Remote-Delivered-To: driverdev-devel@osuosl.org
X-Google-Smtp-Source: AH8x225D22GT5X1jWoU4qo9PHuIfVSU42x14M+apv056WJP/AmdkoEHSZ9lrZnutaG5HQ3A33lzokQ==
Subject: Re: [PATCH] staging: android: ion: minor cleanup for ion_page_pool
To: Yisheng Xie <xieyisheng1@huawei.com>, gregkh@linuxfoundation.org
References: <1517392252-20964-1-git-send-email-xieyisheng1@huawei.com>
From: Laura Abbott <labbott@redhat.com>
Message-ID: <19448c54-7214-ce7c-1ae0-9e8605e34f2c@redhat.com>
Date: Tue, 6 Feb 2018 14:51:19 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.2
MIME-Version: 1.0
In-Reply-To: <1517392252-20964-1-git-send-email-xieyisheng1@huawei.com>
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
Cc: devel@driverdev.osuosl.org, sumit.semwal@linaro.org,
 linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 01/31/2018 01:50 AM, Yisheng Xie wrote:
> ion_page_pool.c now is used to apply pool APIs for system heap, which do
> not need do any initial at device_initcall.
> 
> Meanwhile, this patch also remove some useless include files.
> 

Acked-by: Laura Abbott <labbott@redhat.com>

> Signed-off-by: Yisheng Xie <xieyisheng1@huawei.com>
> ---
>   drivers/staging/android/ion/ion_page_pool.c | 11 -----------
>   1 file changed, 11 deletions(-)
> 
> diff --git a/drivers/staging/android/ion/ion_page_pool.c b/drivers/staging/android/ion/ion_page_pool.c
> index 817849d..3c1eba5 100644
> --- a/drivers/staging/android/ion/ion_page_pool.c
> +++ b/drivers/staging/android/ion/ion_page_pool.c
> @@ -14,12 +14,7 @@
>    *
>    */
>   
> -#include <linux/debugfs.h>
> -#include <linux/dma-mapping.h>
> -#include <linux/err.h>
> -#include <linux/fs.h>
>   #include <linux/list.h>
> -#include <linux/init.h>
>   #include <linux/slab.h>
>   #include <linux/swap.h>
>   
> @@ -171,9 +166,3 @@ void ion_page_pool_destroy(struct ion_page_pool *pool)
>   {
>   	kfree(pool);
>   }
> -
> -static int __init ion_page_pool_init(void)
> -{
> -	return 0;
> -}
> -device_initcall(ion_page_pool_init);
> 

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
