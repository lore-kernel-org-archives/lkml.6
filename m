Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-2365247-1517957414-2-72846398838624626
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, RCVD_IN_DNSWL_MED -2.3,
  SPF_PASS -0.001, LANGUAGES ensv, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.138', Host='smtp1.osuosl.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1517957413; b=HKzHM7RmVSz3n4iau1KMZsnIvwIgnhBMtPPwISZLGZsVAKr
    33BqQvElH9TSN9+VabASQA4tjKcb+iZ2ATF6gMjLY4LZDOaL3egY9odgzE8qYObg
    xjx9vaeJXNJfSLlcumUL/BcVsMCFXBvA3Cp7tf9oT4hjlrxzuhjp0FmGpfG7nDwi
    7GKsmyDhFtDEhNNOBRtx0QJd9lrENeFkDD0JyflKOVannZNsvTya6PWZzSdy0hgh
    QXqJutOrkdhHqwHGGa9M+UJJCBKaMEVUOiQLYVvhXU5zzK7iYcutki+UVXBBMKM7
    tMH9ueAofvA4KbBGYCXm1ZxeA0xnLzgKO0Mdraw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=subject:to:references:from:message-id
    :date:mime-version:in-reply-to:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:cc
    :content-transfer-encoding:content-type:sender; s=arctest; t=
    1517957413; bh=aaWEeT7lES5OWhwR1c0V1F0pusDTMQLkHEcZUtUj1FY=; b=p
    89QDlshNZmg5kC8kJNHPqc00YOroeqtQ3qlpXXgvwpBmALtdsH4+JuDavWboL7Ac
    4LtmZtvnEF2bxDzdxt0SJq+MyKrBUOP+PK/k0lSAqdXupcC1UaYXPH6c0xry+DBG
    cPFHSXnIIhJ9pqkPQekpiR70GYyBlttVqSnRbebYp9KV0iZ0yvBDMWJdmaVket3T
    MLax0UBUazvPkMrLT3v0n4UPwA5oAdy9aB95E3/78mVshwGVKIWw9KfMCG3jXXcA
    4QiKWekZIlmEF7aGJfyJ4tNmj8XszdQsfAIz1EksgV2vbq6GG++sSTSpS6nTxph7
    FTja+2ajjonqZHupsIa9w==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=redhat.com;
    iprev=pass policy.iprev=140.211.166.138 (smtp1.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=whitealder.osuosl.org;
    x-aligned-from=fail;
    x-google-dkim=fail (message has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=DNJ6IlwZ;
    x-ptr=fail x-ptr-helo=whitealder.osuosl.org x-ptr-lookup=smtp1.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=redhat.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=redhat.com;
    iprev=pass policy.iprev=140.211.166.138 (smtp1.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=whitealder.osuosl.org;
    x-aligned-from=fail;
    x-google-dkim=fail (message has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=DNJ6IlwZ;
    x-ptr=fail x-ptr-helo=whitealder.osuosl.org x-ptr-lookup=smtp1.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=redhat.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
X-Remote-Delivered-To: driverdev-devel@osuosl.org
X-Google-Smtp-Source: AH8x224HPJQoHooJuklrCY503YAY/VFnt0VCWchjUQcZzwH+gVz81jG7qKOWo7a8qjSVCtjOq1dU6A==
Subject: Re: [PATCH] staging: android: ion: Remove unused declaration
 ion_buffer_fault_user_mappings
To: Yisheng Xie <xieyisheng1@huawei.com>, gregkh@linuxfoundation.org
References: <1517371291-37515-1-git-send-email-xieyisheng1@huawei.com>
From: Laura Abbott <labbott@redhat.com>
Message-ID: <6f216cf2-ae84-0721-b68b-bb1837e1c687@redhat.com>
Date: Tue, 6 Feb 2018 14:49:58 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.2
MIME-Version: 1.0
In-Reply-To: <1517371291-37515-1-git-send-email-xieyisheng1@huawei.com>
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

On 01/30/2018 08:01 PM, Yisheng Xie wrote:
> ion_buffer_fault_user_mappings's definition has been removed and not be
> used anymore, just remove its useless declaration.
> 

Acked-by: Laura Abbott <labbott@redhat.com>

> Signed-off-by: Yisheng Xie <xieyisheng1@huawei.com>
> ---
>   drivers/staging/android/ion/ion.h | 9 ---------
>   1 file changed, 9 deletions(-)
> 
> diff --git a/drivers/staging/android/ion/ion.h b/drivers/staging/android/ion/ion.h
> index f5f9cd6..2160c35 100644
> --- a/drivers/staging/android/ion/ion.h
> +++ b/drivers/staging/android/ion/ion.h
> @@ -201,15 +201,6 @@ struct ion_heap {
>   bool ion_buffer_cached(struct ion_buffer *buffer);
>   
>   /**
> - * ion_buffer_fault_user_mappings - fault in user mappings of this buffer
> - * @buffer:		buffer
> - *
> - * indicates whether userspace mappings of this buffer will be faulted
> - * in, this can affect how buffers are allocated from the heap.
> - */
> -bool ion_buffer_fault_user_mappings(struct ion_buffer *buffer);
> -
> -/**
>    * ion_device_add_heap - adds a heap to the ion device
>    * @heap:		the heap to add
>    */
> 

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
