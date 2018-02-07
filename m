Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-2603839-1517965050-2-16694554299065551583
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, RCVD_IN_DNSWL_MED -2.3,
  SPF_PASS -0.001, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.137', Host='smtp4.osuosl.org', Country='US',
  FromHeader='com', MailFrom='org', XOriginatingCountry='UNK'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1517965050; b=mhXh/p/Z+04E2SLeH39psKNI1a3jG2NYWw1slzehvWQdAU4
    cGs0bIgIRsUEj8yaZyVZn7W1hFxUWfrsh85dxccM4r9ZVPF5yDlr+laVduGpDLlK
    gAVXiw8AZISzPWSxoLJpi33XA/FB3A3xkvC/VQ/egLqvhvY9WG3NrdZf3tDB6jRy
    xdq9cdg61VwfsHcK9B5IXCe7uAS1esx3Rlq3JjB2/wJgL7p4QG67akQiKxlfQoXx
    2XwTwdWsJeIsw0eWOh4JDsBAB613TBP9ry1K7zZkn/b28+yN9iOnZCxTQyHPwou/
    Kh75jnq4AvWuXliElrjsphisRIJlJlcOkSetq6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=subject:to:references:from:message-id
    :date:mime-version:in-reply-to:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:cc:content-type
    :content-transfer-encoding:sender; s=arctest; t=1517965050; bh=/
    Y7J+N74qzkW1ik60sE14Pd3c4xPpTT/5HW71/BTMr0=; b=ZJronuBbD1u+g+jw3
    5a9bk6FA0e2c2oQ8RBtGcvJn4XE7tGszXFxytO5tIhEmvAZb5g9Ajj2u8oqHPVfX
    GsoRH/zdwnu/WNoH2G39XjBbUGsb/DOnkOm6J6Q3a3lID4JBT5Q3x5V9aMEqSdV3
    wuG0miScOxwdcb8/kUNfVjVxeIfn9gCyK6YVPtIRclZhbcJYGzeFlkOCqyaHir1t
    8q9bSD3mANe/I+mpKH4r3XUvsqCFK9liziNiN68OA69oCWu+CLI/o23pqqESC2NL
    dtxLfb/5vMfasdvJS33nwcb0uSMJWzK15gtz3GoVxsGxw8kTTl+Pz4NqX0Iv2y0F
    1h/NA==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=huawei.com;
    iprev=pass policy.iprev=140.211.166.137 (smtp4.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=fraxinus.osuosl.org;
    x-aligned-from=fail;
    x-ptr=fail x-ptr-helo=fraxinus.osuosl.org x-ptr-lookup=smtp4.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=huawei.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=huawei.com;
    iprev=pass policy.iprev=140.211.166.137 (smtp4.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=fraxinus.osuosl.org;
    x-aligned-from=fail;
    x-ptr=fail x-ptr-helo=fraxinus.osuosl.org x-ptr-lookup=smtp4.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=huawei.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
X-Remote-Delivered-To: driverdev-devel@osuosl.org
Subject: Re: [PATCH 1/2] staging: android: ion: Remove dead code in
 ion_page_pool_free
To: Laura Abbott <labbott@redhat.com>, <gregkh@linuxfoundation.org>
References: <1517801177-37021-1-git-send-email-xieyisheng1@huawei.com>
 <6286ae0a-f439-3477-91bb-8df0e454b98e@redhat.com>
 <a8c0aec1-5e90-ccbf-01bb-bb6d12281035@redhat.com>
From: Yisheng Xie <xieyisheng1@huawei.com>
Message-ID: <3e68a118-0d6f-2a42-0df1-3b0021ce5ca7@huawei.com>
Date: Wed, 7 Feb 2018 08:57:02 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.1.0
MIME-Version: 1.0
In-Reply-To: <a8c0aec1-5e90-ccbf-01bb-bb6d12281035@redhat.com>
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

Hi Laura,

On 2018/2/7 7:11, Laura Abbott wrote:
> On 02/06/2018 03:10 PM, Laura Abbott wrote:
>> On 02/04/2018 07:26 PM, Yisheng Xie wrote:
>>> ion_page_pool_add will always return 0, however ion_page_pool_free will
>>> call ion_page_pool_free_pages when ion_page_pool_add's return value is
>>> not 0, so it is a dead code which can be removed.
>>>
>>
>> Can you clean up ion_page_pool_add to be a void return as well?
>> No sense in having it just always return 0.
>>
> 
> Nevermind, just saw the follow up patch. Both of them:
> 
> Acked-by: Laura Abbott <labbott@redhat.com>

Thanks.
If you do not mind, I will send out another two cleanup patchs:
cleanup ion_page_pool_alloc_pages() and combine cache/uncache pools into one pools.

Thanks

> 
>>> Signed-off-by: Yisheng Xie <xieyisheng1@huawei.com>
>>> ---
>>>   drivers/staging/android/ion/ion_page_pool.c | 6 +-----
>>>   1 file changed, 1 insertion(+), 5 deletions(-)
>>>
>>> diff --git a/drivers/staging/android/ion/ion_page_pool.c b/drivers/staging/android/ion/ion_page_pool.c
>>> index 4452e28..150626f 100644
>>> --- a/drivers/staging/android/ion/ion_page_pool.c
>>> +++ b/drivers/staging/android/ion/ion_page_pool.c
>>> @@ -79,13 +79,9 @@ struct page *ion_page_pool_alloc(struct ion_page_pool *pool)
>>>   void ion_page_pool_free(struct ion_page_pool *pool, struct page *page)
>>>   {
>>> -    int ret;
>>> -
>>>       BUG_ON(pool->order != compound_order(page));
>>> -    ret = ion_page_pool_add(pool, page);
>>> -    if (ret)
>>> -        ion_page_pool_free_pages(pool, page);
>>> +    ion_page_pool_add(pool, page);
>>>   }
>>>   static int ion_page_pool_total(struct ion_page_pool *pool, bool high)
>>>
>>
> 
> 
> 

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
