Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-3742437-1524805844-3-13726084881179170431
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_MED -2.3, SPF_PASS -0.001, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.137', Host='smtp4.osuosl.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1524805843; b=CfVu3mvOlW4zESGPV2CGLB0jflcd4znHLaQpI33lsnZ2pukrJR
    GtUvaZT7KVLDsugZdx9hrLmcYTE2UYxuK/9dVvQKTKN7hB2npLgbIVVts4IMz7pw
    lrUuJ58kasrggmsPKnwItQZI9aNFBWFg5HscXWGYigp1QM9RtTmxHqHlgh+Eo9vd
    JkU8yf+JepalttVKtlEYAmth76bBhCyGuPpt7J6IlVlcByG2bPkS1KGwF+WHB07v
    xyFnEp0Sw684yMgyB3iu97Mpn2j6Nlk503qysk1Ek+o3IButq7SPC0yPDT2J+Zds
    abKNLNyKSAoyF0RNP3VxCSmqbKKLTLvm5QBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=mime-version:date:from:to:subject
    :in-reply-to:references:message-id:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:cc
    :content-transfer-encoding:content-type:sender; s=fm2; t=
    1524805843; bh=SCugAaMmogbGm//mC1NSD7jMbaVuja7330X5CYoF6u4=; b=K
    frz9tPLV9zZCl6dj68xHMO7FNPJB3INUonk7xUmSjHcXCW0f6HmGhhsJvVNr2uWy
    o3PyOTFdhMoqqawrSVskqSI1AMY2Cw7NNnDDBBCT1uWYqUGo+viFBF86PyzU62bd
    wYSIIRwAMSPcYuREO/uUjJimcKG41y+9faPidn8nlrU65Kdhjtagr5uKOzioXqfT
    ESehmymi1YbmPEFSiqMAeygskvbvtYqDtKBr9Kb+ImArLTvCuNT3mLErguu8khYP
    m0jL/KXfFv/nj7xbHbB71wH02nOEKdXmbqqMjkpT3WJMWqG3XzjDAfsrrlkFEbaG
    WzkW4TzRRAEJX6g3wKYOA==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 1024-bit rsa key sha256) header.d=codeaurora.org header.i=@codeaurora.org header.b=i/4E/bLU x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=default;
    dkim=fail (message has been altered, 1024-bit rsa key sha256) header.d=codeaurora.org header.i=@codeaurora.org header.b=i/4E/bLU x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=default;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=codeaurora.org;
    iprev=pass policy.iprev=140.211.166.137 (smtp4.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=fraxinus.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-ptr=fail x-ptr-helo=fraxinus.osuosl.org x-ptr-lookup=smtp4.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=codeaurora.org header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=-100 state=0
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 1024-bit rsa key sha256) header.d=codeaurora.org header.i=@codeaurora.org header.b=i/4E/bLU x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=default;
    dkim=fail (message has been altered, 1024-bit rsa key sha256) header.d=codeaurora.org header.i=@codeaurora.org header.b=i/4E/bLU x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=default;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=codeaurora.org;
    iprev=pass policy.iprev=140.211.166.137 (smtp4.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=fraxinus.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-ptr=fail x-ptr-helo=fraxinus.osuosl.org x-ptr-lookup=smtp4.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=codeaurora.org header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfODx31U006TUtZaDFZBA6tfW1K63+UClUR8nJTlSf+hwvGcl8BgdHec31ryO8fVvPHUC6h2PnpQOi7Hob9dU2IsgyluY+LS5TaVkyTYb0PQ7tfB492Vc
    DdTLOpYsuArPk9XvmcAUo9k4+DkGKwSAIO4UeySf1zCzMg/Y83mYc3u8/m5tNkacyv3n6wzU5iNk2sbQJsDU+FYKMnN8GeKxfEGaCUPmUfie61VRy/WiB96I
    n6fQmpJj9+kpon7X9TYPeQ==
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=584k1XxxM9pnnVd4MmWcNA==:117
    a=584k1XxxM9pnnVd4MmWcNA==:17 a=kj9zAlcOel0A:10 a=Kd1tUaAdevIA:10
    a=-uNXE31MpBQA:10 a=jJxKW8Ag-pUA:10 a=LpQP-O61AAAA:8 a=D19gQVrFAAAA:8
    a=DDOyTI_5AAAA:8 a=IUtCt1v0X6Zah1lDHaYA:9 a=CjuIK1q_8ugA:10
    a=pioyyrs4ZptJ924tMmac:22 a=W4TVW4IDbPiebHqcZpNg:22 a=_BcfOz0m4U4ohdxiHPKc:22
    cc=dsc
X-ME-CMScore: 0
X-ME-CMCategory: discussion
X-Remote-Delivered-To: driverdev-devel@osuosl.org
MIME-Version: 1.0
Date: Fri, 27 Apr 2018 10:40:36 +0530
From: vjitta@codeaurora.org
To: Laura Abbott <labbott@redhat.com>
Subject: Re: [PATCH] ion: Consider ion pool pages as indirectly reclaimable
In-Reply-To: <8618859b-06f9-39a7-80a9-af36cf9faf9f@redhat.com>
References: <1524627830-17187-1-git-send-email-vjitta@codeaurora.org>
 <8618859b-06f9-39a7-80a9-af36cf9faf9f@redhat.com>
Message-ID: <fb3f0974e9e83b33e7eac267aeecf130@codeaurora.org>
User-Agent: Roundcube Webmail/1.2.5
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
Cc: devel@driverdev.osuosl.org, linux-kernel-owner@vger.kernel.org,
 tkjos@android.com, gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
 arve@android.com, maco@android.com, sumit.semwal@linaro.org
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 2018-04-25 21:17, Laura Abbott wrote:
> On 04/24/2018 08:43 PM, vjitta@codeaurora.org wrote:
>> From: Vijayanand Jitta <vjitta@codeaurora.org>
>> 
>> An issue is observed where mallocs are failing due to overcommit 
>> failure.
>> The failure happens when there is high ION page pool since ION page
>> pool is not considered reclaimable by the overcommit calculation code.
>> This change considers ion pool pages as indirectly reclaimable and 
>> thus
>> accounted as available memory in the overcommit calculation.
>> 
>> Signed-off-by: Vijayanand Jitta <vjitta@codeaurora.org>
>> ---
>>   drivers/staging/android/ion/ion_page_pool.c | 5 +++++
>>   1 file changed, 5 insertions(+)
>> 
>> diff --git a/drivers/staging/android/ion/ion_page_pool.c 
>> b/drivers/staging/android/ion/ion_page_pool.c
>> index db8f614..9bc56eb 100644
>> --- a/drivers/staging/android/ion/ion_page_pool.c
>> +++ b/drivers/staging/android/ion/ion_page_pool.c
>> @@ -32,6 +32,9 @@ static void ion_page_pool_add(struct ion_page_pool 
>> *pool, struct page *page)
>>   		list_add_tail(&page->lru, &pool->low_items);
>>   		pool->low_count++;
>>   	}
>> +
>> +	mod_node_page_state(page_pgdat(page), 
>> NR_INDIRECTLY_RECLAIMABLE_BYTES,
>> +			    (1 << (PAGE_SHIFT + pool->order)));
>>   	mutex_unlock(&pool->mutex);
>>   }
>>   @@ -50,6 +53,8 @@ static struct page *ion_page_pool_remove(struct 
>> ion_page_pool *pool, bool high)
>>   	}
>>     	list_del(&page->lru);
>> +	mod_node_page_state(page_pgdat(page), 
>> NR_INDIRECTLY_RECLAIMABLE_BYTES,
>> +			    -(1 << (PAGE_SHIFT + pool->order)));
>>   	return page;
>>   }
>> 
> 
> I'm sure this fixes the problem but I don't think we want to
> start throwing page adjustments into Ion. Why isn't this
> memory already considered reclaimable by existing calculations?
> 
> Thanks,
> Laura

You can refer to discussion here https://lkml.org/lkml/2018/3/5/361 
introducing
NR_INDIRECTLY_RECLAIMABLE_BYTES for the memory which is not currently 
considered
as reclaimable

Thanks,
Vijay
_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
