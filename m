Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-1227156-1518435713-2-4691605010982262688
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, RCVD_IN_DNSWL_MED -2.3,
  SPF_PASS -0.001, LANGUAGES enda, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.138', Host='smtp1.osuosl.org', Country='US',
  FromHeader='com', MailFrom='org', XOriginatingCountry='UNK'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1518435713; b=q1579nfroYEY67g1zNxwhXACofZbujhZNFgJ5ulPe/bFZSY
    RoWrIL8G8fHm7v7T7WAhGoYmtDvTlN3r9vlB+0t6BEnVgvZ0lV/WoXG7RYNVw12H
    LXpKAlzYcOiO6QxM6czV5eS/UTxHvSnBOvxEemqFpe1GeEZ8insrMD4hqSU9Xsls
    W4tOzScjo8XtihAZaEm5Q28ExJWJtm008NlWOsumNO25wOoDpB+NHTBmow561mhq
    lxXuDpbD4HnTNRFGhBd3MUKGGsekJnYPOoEOjMDZ8tZzH4xcjhvtfhlRe18vdpUb
    8hG+IPty/9kBY19ihoSCwzOR2e3wzKksNS55Wjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=subject:to:references:from:message-id
    :date:mime-version:in-reply-to:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:cc:content-type
    :content-transfer-encoding:sender; s=arctest; t=1518435713; bh=q
    xKaM4Bo2GoZnst5o53sUNDWhusy7B+8beqVhULUJdg=; b=i0s/bfuPRKP46BJI+
    W45mmWFtcFC6IaTCHdi8h8Y9qUCiIf+ham2U8pH0E5aOEmGiuorxRsuEjFi3QsEs
    q47zSWiS32rL1R0SRfEAIiguVJg8A1RDM/VeFhgTohE1rjwK1w+1qA+6WLo0nqSt
    nDBBwYNTqtCBZORgG2j1Wr77j+cnEfVYEo0ptDebKOXnxuadU+4yzpgS3mPgpUW1
    yQHT+liw75Mpqdps+WQOnW3PSiKa/CxQ8BCJBTs0kcxeuMsd5M8S/zsvn1HBvbfK
    YYhbS5pCcQv7OudS4DXftwcP2JHlgsu1eDyJtzqNIhtMiP16XPdBLA+jM2AVGk21
    3jwgA==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=huawei.com;
    iprev=pass policy.iprev=140.211.166.138 (smtp1.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=whitealder.osuosl.org;
    x-aligned-from=fail;
    x-ptr=fail x-ptr-helo=whitealder.osuosl.org x-ptr-lookup=smtp1.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=huawei.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=huawei.com;
    iprev=pass policy.iprev=140.211.166.138 (smtp1.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=whitealder.osuosl.org;
    x-aligned-from=fail;
    x-ptr=fail x-ptr-helo=whitealder.osuosl.org x-ptr-lookup=smtp1.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=huawei.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
X-Remote-Delivered-To: driverdev-devel@osuosl.org
Subject: Re: [PATCH 1/2] staging: android: ion: Cleanup
 ion_page_pool_alloc_pages
To: <gregkh@linuxfoundation.org>, <labbott@redhat.com>
References: <1517975986-46917-1-git-send-email-xieyisheng1@huawei.com>
From: Yisheng Xie <xieyisheng1@huawei.com>
Message-ID: <11ed8ba5-e6d2-1d36-cf8b-0eb19c6bcdb0@huawei.com>
Date: Mon, 12 Feb 2018 19:41:16 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.1.0
MIME-Version: 1.0
In-Reply-To: <1517975986-46917-1-git-send-email-xieyisheng1@huawei.com>
X-Originating-IP: [10.177.29.40]
X-CFilter-Loop: Reflected
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
Cc: devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi Greg,

JFYI, I have rebase this patchset to v4.15-rc1.[1]

[1] https://lkml.org/lkml/2018/2/12/204

Thanks
Yisheng

On 2018/2/7 11:59, Yisheng Xie wrote:
> ion_page_pool_alloc_pages calls alloc_pages to allocate pages for page
> pools. If alloc_pages return NULL, it will return NULL, or it will
> return the pages allocate from alloc_pages. So we can just return
> alloc_pages without any judgement.
> 
> Signed-off-by: Yisheng Xie <xieyisheng1@huawei.com>
> ---
>  drivers/staging/android/ion/ion_page_pool.c | 8 ++------
>  1 file changed, 2 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/staging/android/ion/ion_page_pool.c b/drivers/staging/android/ion/ion_page_pool.c
> index e3a6e32..6d2caf0 100644
> --- a/drivers/staging/android/ion/ion_page_pool.c
> +++ b/drivers/staging/android/ion/ion_page_pool.c
> @@ -11,13 +11,9 @@
>  
>  #include "ion.h"
>  
> -static void *ion_page_pool_alloc_pages(struct ion_page_pool *pool)
> +static inline struct page *ion_page_pool_alloc_pages(struct ion_page_pool *pool)
>  {
> -	struct page *page = alloc_pages(pool->gfp_mask, pool->order);
> -
> -	if (!page)
> -		return NULL;
> -	return page;
> +	return alloc_pages(pool->gfp_mask, pool->order);
>  }
>  
>  static void ion_page_pool_free_pages(struct ion_page_pool *pool,
> 

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
