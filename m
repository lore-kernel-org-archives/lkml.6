Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-2329085-1517958642-2-9259027934525045778
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, RCVD_IN_DNSWL_MED -2.3,
  SPF_PASS -0.001, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.136', Host='smtp3.osuosl.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1517958641; b=JL+3l9oPY0B4JfoFmHKsSJJAdnrty/lUvgPC624qOzM7VVs
    wEBI3cBTKfsaG63S9wf3EDz+kXgbw39LDXA7Sn0mFeD9mFFIAsXJ7SXrs4QZp5Y6
    HNzwbLnGqPlm3T0SULRKjEg1JY5MKqddF+bD3tAfOfIjuo03uwfvP80YI7e74TW+
    uALR7tE1WzWSEaZgE48AaFD1RAfDFCfCXIplPP57SKk7L26AzkGxrt0yJRFzlYg3
    nhTHYkhTmTQB9qtpbKyhnfrdkROq/c60LNH+zdJtQk9sDzRoIbfLhIvuBsl3Ytus
    6HUA3Mdc7eFBBH+UTVkrTM8nMf7XOwzMM4je2LQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=subject:to:references:from:message-id
    :date:mime-version:in-reply-to:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:cc
    :content-transfer-encoding:content-type:sender; s=arctest; t=
    1517958641; bh=0IgNUubPBLlOquRDCK1sedAx+EFqIw/wWnUl+WA8k7Y=; b=K
    l8evV1TUWrK7duUXYNlyaPKiY9x9Cavc0dJbwWJ5+SzGze2XuA5SaJ3ymFzOnAzZ
    dp8pdAofd0I9TloNEwQC6ssA84rn0Z1zKbCMPojr31r64/ZE54UpQHawITIntNd7
    NnNK6z8gTDSptfNAjD/MjX/9WXe9d+hAiif10jzpz7/fv1KSjM8M0KhI6skk+OSh
    8T7qj+0GqDOsLwiOuAIQDeLV53nO8BEkdiGYcfmuSMVGYCsf//K8KnhfGnITzBRq
    E5VXmX4xv1dpOXY8y4N8BXCQor5MdwFiS148V66nte8TXDVJhfHvi8xZCMYKAeZX
    cFDReo5hC2Yq4qPLoltgA==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=redhat.com;
    iprev=pass policy.iprev=140.211.166.136 (smtp3.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=silver.osuosl.org;
    x-aligned-from=fail;
    x-google-dkim=fail (body has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=J7PNblkV;
    x-ptr=fail x-ptr-helo=silver.osuosl.org x-ptr-lookup=smtp3.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=redhat.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=redhat.com;
    iprev=pass policy.iprev=140.211.166.136 (smtp3.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=silver.osuosl.org;
    x-aligned-from=fail;
    x-google-dkim=fail (body has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=J7PNblkV;
    x-ptr=fail x-ptr-helo=silver.osuosl.org x-ptr-lookup=smtp3.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=redhat.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
X-Remote-Delivered-To: driverdev-devel@osuosl.org
X-Google-Smtp-Source: AH8x227HZUI9thS48g/k/Yz2pOFyOtvI1F1Fq3rUZ4OpRyypQfBj8JDbCWRVW3Xc2U1gCWsJhlPcoQ==
Subject: Re: [PATCH 1/2] staging: android: ion: Remove dead code in
 ion_page_pool_free
To: Yisheng Xie <xieyisheng1@huawei.com>, gregkh@linuxfoundation.org
References: <1517801177-37021-1-git-send-email-xieyisheng1@huawei.com>
From: Laura Abbott <labbott@redhat.com>
Message-ID: <6286ae0a-f439-3477-91bb-8df0e454b98e@redhat.com>
Date: Tue, 6 Feb 2018 15:10:30 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.2
MIME-Version: 1.0
In-Reply-To: <1517801177-37021-1-git-send-email-xieyisheng1@huawei.com>
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
Cc: devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 02/04/2018 07:26 PM, Yisheng Xie wrote:
> ion_page_pool_add will always return 0, however ion_page_pool_free will
> call ion_page_pool_free_pages when ion_page_pool_add's return value is
> not 0, so it is a dead code which can be removed.
> 

Can you clean up ion_page_pool_add to be a void return as well?
No sense in having it just always return 0.

> Signed-off-by: Yisheng Xie <xieyisheng1@huawei.com>
> ---
>   drivers/staging/android/ion/ion_page_pool.c | 6 +-----
>   1 file changed, 1 insertion(+), 5 deletions(-)
> 
> diff --git a/drivers/staging/android/ion/ion_page_pool.c b/drivers/staging/android/ion/ion_page_pool.c
> index 4452e28..150626f 100644
> --- a/drivers/staging/android/ion/ion_page_pool.c
> +++ b/drivers/staging/android/ion/ion_page_pool.c
> @@ -79,13 +79,9 @@ struct page *ion_page_pool_alloc(struct ion_page_pool *pool)
>   
>   void ion_page_pool_free(struct ion_page_pool *pool, struct page *page)
>   {
> -	int ret;
> -
>   	BUG_ON(pool->order != compound_order(page));
>   
> -	ret = ion_page_pool_add(pool, page);
> -	if (ret)
> -		ion_page_pool_free_pages(pool, page);
> +	ion_page_pool_add(pool, page);
>   }
>   
>   static int ion_page_pool_total(struct ion_page_pool *pool, bool high)
> 

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
