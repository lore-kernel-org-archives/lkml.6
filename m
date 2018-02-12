Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-2293173-1518467985-5-15197722230562102744
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, RCVD_IN_DNSWL_MED -2.3,
  SPF_PASS -0.001, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.136', Host='smtp3.osuosl.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: cc='UTF-8', plain='us-ascii'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1518467985; b=t0yhIlzXMSGKes+tZAFAcQ2FET/BuDQj1yJP1R+tj7ulIUw
    TcYo28hX0FFCeCaBSCDElcG0lVMrQmZWhrn4kmyxZPl4ZLfWeR015z00CLf0gN8U
    yn7pqsl6/ujNG9qzIwKJf3gXM4jhT8VZXuIr/JoeHXHZ4zjI0HsBPjWnM//Gp2E0
    Gmr4iTnXBK8f94Kyx5So9QFQuJUEOFkxDVGGBgIjXpOleenBg42Fu7F3RyNnz+4H
    lqU8fsh+zFB0TUe3xfTc5xyD6Retzc69ik6hJYoQco2KdXUEmRTnza5ht5/shaoa
    K3zJjKhFkGJIg0QHpPeUJqB7YTjFj6gl/hZlmTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=subject:to:references:from:message-id
    :date:mime-version:in-reply-to:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:cc
    :content-transfer-encoding:content-type:sender; s=arctest; t=
    1518467985; bh=YAxshu1L0J4DQ83Jes2QhO8jJpm7RQKRbVMom2hdwHI=; b=I
    zW9WgVZpRACBLu1QU47hGJOVssO8ZTs3mYXyb0n3f4c2n9lPRef1+J4EOA62vCGD
    Qgd0cv9buowJ42rJHC0nZQuqelJTfdDh0Gnt/O4oEhmsWq9nJh0re6hDNLyATP0/
    NSC1keHTEP7eKq793s4tNV2DE3K3gvx1/+HxrlcidY70XDxItDX5Ely7q5xetfzT
    33C6fek4OFj8HPqnxFwuqkn3Y3YM3xYJtXCNcUIzA7Z645Uf8vg2RgQ/WnyzK3Oq
    NRE2gaFIqH47TlDFo1VoaJFM6aZ84oFw0Yggm5+UVmvbWlMdxhYEGkVIPRkM6oya
    XElKZDcJNPhNa1lQ+xVMg==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=redhat.com;
    iprev=pass policy.iprev=140.211.166.136 (smtp3.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=silver.osuosl.org;
    x-aligned-from=fail;
    x-google-dkim=fail (message has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=HeNbT75A;
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
    x-google-dkim=fail (message has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=HeNbT75A;
    x-ptr=fail x-ptr-helo=silver.osuosl.org x-ptr-lookup=smtp3.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=redhat.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
X-Remote-Delivered-To: driverdev-devel@osuosl.org
X-Google-Smtp-Source: AH8x226Y2Sf0f7pu6iAQjdLVdqgsqzFWW9NtavcoWBKImK7E7gYExtYzD1/298l9LU8BBWNv7D/8VA==
Subject: Re: [PATCH] staging: android: ion: Restrict cache maintenance to dma
 mapped memory
To: Liam Mark <lmark@codeaurora.org>, Sumit Semwal <sumit.semwal@linaro.org>
References: <alpine.DEB.2.02.1802092217010.2846@lmark-linux.qualcomm.com>
From: Laura Abbott <labbott@redhat.com>
Message-ID: <d66b03aa-bb36-01b2-6b10-fdae3bcd4555@redhat.com>
Date: Mon, 12 Feb 2018 12:39:33 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.2
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.02.1802092217010.2846@lmark-linux.qualcomm.com>
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
Cc: devel@driverdev.osuosl.org, Todd Kjos <tkjos@android.com>,
 linux-kernel@vger.kernel.org, linaro-mm-sig@lists.linaro.org,
 =?UTF-8?Q?Arve_Hj=c3=b8nnev=c3=a5g?= <arve@android.com>,
 Martijn Coenen <maco@android.com>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 02/09/2018 10:21 PM, Liam Mark wrote:
> The ION begin_cpu_access and end_cpu_access functions use the
> dma_sync_sg_for_cpu and dma_sync_sg_for_device APIs to perform cache
> maintenance.
> 
> Currently it is possible to apply cache maintenance, via the
> begin_cpu_access and end_cpu_access APIs, to ION buffers which are not
> dma mapped.
> 
> The dma sync sg APIs should not be called on sg lists which have not been
> dma mapped as this can result in cache maintenance being applied to the
> wrong address. If an sg list has not been dma mapped then its dma_address
> field has not been populated, some dma ops such as the swiotlb_dma_ops ops
> use the dma_address field to calculate the address onto which to apply
> cache maintenance.
> 
> Fix the ION begin_cpu_access and end_cpu_access functions to only apply
> cache maintenance to buffers which have been dma mapped.
> 
I think this looks okay. I was initially concerned about concurrency and
setting the dma_mapped flag but I think that should be handled by the
caller synchronizing map/unmap/cpu_access calls (we might need to re-evaluate
in the future)

I would like to hold on queuing this for just a little bit until I
finish working on the Ion unit test (doing this in the complete opposite
order of course). I'm assuming this passed your internal tests Liam?

Thanks,
Laura

> Fixes: 2a55e7b5e544 ("staging: android: ion: Call dma_map_sg for syncing and mapping")
> Signed-off-by: Liam Mark <lmark@codeaurora.org>
> ---
>   drivers/staging/android/ion/ion.c | 16 ++++++++++++----
>   1 file changed, 12 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/staging/android/ion/ion.c b/drivers/staging/android/ion/ion.c
> index f480885e346b..e5df5272823d 100644
> --- a/drivers/staging/android/ion/ion.c
> +++ b/drivers/staging/android/ion/ion.c
> @@ -214,6 +214,7 @@ struct ion_dma_buf_attachment {
>   	struct device *dev;caller 
>   	struct sg_table *table;
>   	struct list_head list;
> +	bool dma_mapped;
>   };
>   
>   static int ion_dma_buf_attach(struct dma_buf *dmabuf, struct device *dev,
> @@ -235,6 +236,7 @@ static int ion_dma_buf_attach(struct dma_buf *dmabuf, struct device *dev,
>   
>   	a->table = table;
>   	a->dev = dev;
> +	a->dma_mapped = false;
>   	INIT_LIST_HEAD(&a->list);
>   
>   	attachment->priv = a;
> @@ -272,6 +274,7 @@ static struct sg_table *ion_map_dma_buf(struct dma_buf_attachment *attachment,
>   			direction))
>   		return ERR_PTR(-ENOMEM);
>   
> +	a->dma_mapped = true;
>   	return table;
>   }
>   
> @@ -279,7 +282,10 @@ static void ion_unmap_dma_buf(struct dma_buf_attachment *attachment,
>   			      struct sg_table *table,
>   			      enum dma_data_direction direction)
>   {
> +	struct ion_dma_buf_attachment *a = attachment->priv;
> +
>   	dma_unmap_sg(attachment->dev, table->sgl, table->nents, direction);
> +	a->dma_mapped = false;
>   }
>   
>   static int ion_mmap(struct dma_buf *dmabuf, struct vm_area_struct *vma)
> @@ -345,8 +351,9 @@ static int ion_dma_buf_begin_cpu_access(struct dma_buf *dmabuf,
>   
>   	mutex_lock(&buffer->lock);
>   	list_for_each_entry(a, &buffer->attachments, list) {
> -		dma_sync_sg_for_cpu(a->dev, a->table->sgl, a->table->nents,
> -				    direction);
> +		if (a->dma_mapped)
> +			dma_sync_sg_for_cpu(a->dev, a->table->sgl,
> +					    a->table->nents, direction);
>   	}
>   	mutex_unlock(&buffer->lock);
>   
> @@ -367,8 +374,9 @@ static int ion_dma_buf_end_cpu_access(struct dma_buf *dmabuf,
>   
>   	mutex_lock(&buffer->lock);
>   	list_for_each_entry(a, &buffer->attachments, list) {
> -		dma_sync_sg_for_device(a->dev, a->table->sgl, a->table->nents,
> -				       direction);
> +		if (a->dma_mapped)
> +			dma_sync_sg_for_device(a->dev, a->table->sgl,
> +					       a->table->nents, direction);
>   	}
>   	mutex_unlock(&buffer->lock);
>   
> 

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
