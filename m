Return-Path: <christophe.leroy@c-s.fr>
X-Google-Smtp-Source: AH8x226k55kOJ6UP1Whdrmkwq6b+WHC+HLq5lD8sGc29cv+otTleEoj6qa+aL+sey0nflT4qcfxZ
ARC-Seal: i=1; a=rsa-sha256; t=1518434478; cv=none;
        d=google.com; s=arc-20160816;
        b=0SGMK1K1Twtcjtw0uqiR4IpdaBoIkcRLl7j7umXSOvCZBO/Xlwk3HBzgPHFGQElLMg
         Pd0znajaUPH+fArV28poAMK5BzS/idJN2LwRetGHH3y7fu+89JQVkJNhyG0D+bQL0m8q
         SHo8hqB7yD5bjO5pdPmERxgAcWe0AyRSvghdBKYmo172fdNo4ZcOJbvQPJS1M0T277oH
         P+fymksuwf2cBZ7JDseZZB3AEA8ogHzcp0rXzBYj2elIEoVDjEFu7MuUJly9g9sCEP99
         3D3CQrrICEM62IZRfjqQ/AMQWTZY4rhCxkfP+dR+dcrmuwY1l5g7b5a3XeQr9lgHO8xv
         hrkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :arc-authentication-results;
        bh=XNTKzSW/uj7N9MxMT/IMpqAsZOtjbuoE4IWiVFDzCoE=;
        b=VlAXqpDFv5IfE9Y/nIyr116Cy/pMHmhdd7ZGi+VBINbdNBC+OYBD1MgIzTe0D0LxZW
         kly3nQ/MszGxNp4js8JAmJ3lcCm7Jqc0ZUbDj6d7Yy5E02x1unBEDbZzNxiDyyTnaM1E
         5sUKP5aPVP1GLwurGiV4iB6wcR4e2lNt2xTVwMGQfsSA8IiTMya1nqdFIIYIbDjiAsTT
         lQP/GvvOVRjibyoygYdXH3b2Bc/W7e1TRwBpKltVMK7G1SvOz9qEAP7DXnrIWzLsWU29
         fIvoELc0bIzUWXi9/C9FlpheMPUYNz3u2AsrqCodxCorC7P4kr+lvbGJatpSF8lwh5hq
         +lEw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of christophe.leroy@c-s.fr designates 93.17.236.30 as permitted sender) smtp.mailfrom=christophe.leroy@c-s.fr
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of christophe.leroy@c-s.fr designates 93.17.236.30 as permitted sender) smtp.mailfrom=christophe.leroy@c-s.fr
Subject: Re: [PATCH v6] devres: combine function devm_ioremap*
To: Yisheng Xie <xieyisheng1@huawei.com>, gregkh@linuxfoundation.org
Cc: thomas.lendacky@amd.com, linux-kernel@vger.kernel.org
References: <1517226496-32324-1-git-send-email-xieyisheng1@huawei.com>
 <db6ce14b-455f-034b-48a3-199cdc493479@huawei.com>
From: Christophe LEROY <christophe.leroy@c-s.fr>
Message-ID: <f0e40718-98dd-6383-8bfc-c05b0e5b8ad1@c-s.fr>
Date: Mon, 12 Feb 2018 12:21:17 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <db6ce14b-455f-034b-48a3-199cdc493479@huawei.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1590927888769516575?=
X-GMAIL-MSGID: =?utf-8?q?1592193951427067444?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi Yishen,

I don't have any comment.

Reviewed-by: <christophe.leroy@c-s.fr>

Christophe

Le 12/02/2018 à 12:07, Yisheng Xie a écrit :
> Hi Greg, Christophe,
> 
> Any comment about this version?  And sorry to disturb  :)
> 
> Thanks
> Yisheng
> 
> On 2018/1/29 19:48, Yisheng Xie wrote:
>> When I tried to use devm_ioremap function and review related
>> code, I found devm_ioremap_* almost have the similar realize
>> with each other, which can be combined.
>>
>> In the former version, I have tried to kill ioremap_cache to
>> reduce the size of devres, which can not work for ioremap is
>> not the same as ioremap_nocache in some ARCHs likes ia64.
>> Therefore, as the suggestion of Christophe, I introduce a help
>> function __devm_ioremap, let devm_ioremap* inline and call
>> __devm_ioremap with different devm_ioremap_type.
>>
>> After apply the patch, the size of devres.o can be reduce from
>> 8216 Bytes to 8052 Bytes in my compile environment.
>>
>> Suggested-by: Greg KH <gregkh@linuxfoundation.org>
>> Suggested-by: Christophe LEROY <christophe.leroy@c-s.fr>
>> Signed-off-by: Yisheng Xie <xieyisheng1@huawei.com>
>> ---
>> v2:
>>   - use MARCO for ioremap
>> v3:
>>   - kill dev_ioremap_nocache
>> v4:
>>   - combine function devm_ioremap*       - per Christophe
>> v5:
>>   - fix code style.                      - per Christophe
>> v6:
>>   - just put the cleanup in the devres.c - per Greg
>>
>>   lib/devres.c | 78 +++++++++++++++++++++++++++++-------------------------------
>>   1 file changed, 38 insertions(+), 40 deletions(-)
>>
>> diff --git a/lib/devres.c b/lib/devres.c
>> index 5f2aedd..5bec112 100644
>> --- a/lib/devres.c
>> +++ b/lib/devres.c
>> @@ -5,6 +5,12 @@
>>   #include <linux/gfp.h>
>>   #include <linux/export.h>
>>   
>> +enum devm_ioremap_type {
>> +	DEVM_IOREMAP = 0,
>> +	DEVM_IOREMAP_NC,
>> +	DEVM_IOREMAP_WC,
>> +};
>> +
>>   void devm_ioremap_release(struct device *dev, void *res)
>>   {
>>   	iounmap(*(void __iomem **)res);
>> @@ -15,24 +21,28 @@ static int devm_ioremap_match(struct device *dev, void *res, void *match_data)
>>   	return *(void **)res == match_data;
>>   }
>>   
>> -/**
>> - * devm_ioremap - Managed ioremap()
>> - * @dev: Generic device to remap IO address for
>> - * @offset: Resource address to map
>> - * @size: Size of map
>> - *
>> - * Managed ioremap().  Map is automatically unmapped on driver detach.
>> - */
>> -void __iomem *devm_ioremap(struct device *dev, resource_size_t offset,
>> -			   resource_size_t size)
>> +static void __iomem *__devm_ioremap(struct device *dev, resource_size_t offset,
>> +				    resource_size_t size,
>> +				    enum devm_ioremap_type type)
>>   {
>> -	void __iomem **ptr, *addr;
>> +	void __iomem **ptr, *addr = NULL;
>>   
>>   	ptr = devres_alloc(devm_ioremap_release, sizeof(*ptr), GFP_KERNEL);
>>   	if (!ptr)
>>   		return NULL;
>>   
>> -	addr = ioremap(offset, size);
>> +	switch (type) {
>> +	case DEVM_IOREMAP:
>> +		addr = ioremap(offset, size);
>> +		break;
>> +	case DEVM_IOREMAP_NC:
>> +		addr = ioremap_nocache(offset, size);
>> +		break;
>> +	case DEVM_IOREMAP_WC:
>> +		addr = ioremap_wc(offset, size);
>> +		break;
>> +	}
>> +
>>   	if (addr) {
>>   		*ptr = addr;
>>   		devres_add(dev, ptr);
>> @@ -41,6 +51,20 @@ void __iomem *devm_ioremap(struct device *dev, resource_size_t offset,
>>   
>>   	return addr;
>>   }
>> +
>> +/**
>> + * devm_ioremap - Managed ioremap()
>> + * @dev: Generic device to remap IO address for
>> + * @offset: Resource address to map
>> + * @size: Size of map
>> + *
>> + * Managed ioremap().  Map is automatically unmapped on driver detach.
>> + */
>> +void __iomem *devm_ioremap(struct device *dev, resource_size_t offset,
>> +			   resource_size_t size)
>> +{
>> +	return __devm_ioremap(dev, offset, size, DEVM_IOREMAP);
>> +}
>>   EXPORT_SYMBOL(devm_ioremap);
>>   
>>   /**
>> @@ -55,20 +79,7 @@ void __iomem *devm_ioremap(struct device *dev, resource_size_t offset,
>>   void __iomem *devm_ioremap_nocache(struct device *dev, resource_size_t offset,
>>   				   resource_size_t size)
>>   {
>> -	void __iomem **ptr, *addr;
>> -
>> -	ptr = devres_alloc(devm_ioremap_release, sizeof(*ptr), GFP_KERNEL);
>> -	if (!ptr)
>> -		return NULL;
>> -
>> -	addr = ioremap_nocache(offset, size);
>> -	if (addr) {
>> -		*ptr = addr;
>> -		devres_add(dev, ptr);
>> -	} else
>> -		devres_free(ptr);
>> -
>> -	return addr;
>> +	return __devm_ioremap(dev, offset, size, DEVM_IOREMAP_NC);
>>   }
>>   EXPORT_SYMBOL(devm_ioremap_nocache);
>>   
>> @@ -83,20 +94,7 @@ void __iomem *devm_ioremap_nocache(struct device *dev, resource_size_t offset,
>>   void __iomem *devm_ioremap_wc(struct device *dev, resource_size_t offset,
>>   			      resource_size_t size)
>>   {
>> -	void __iomem **ptr, *addr;
>> -
>> -	ptr = devres_alloc(devm_ioremap_release, sizeof(*ptr), GFP_KERNEL);
>> -	if (!ptr)
>> -		return NULL;
>> -
>> -	addr = ioremap_wc(offset, size);
>> -	if (addr) {
>> -		*ptr = addr;
>> -		devres_add(dev, ptr);
>> -	} else
>> -		devres_free(ptr);
>> -
>> -	return addr;
>> +	return __devm_ioremap(dev, offset, size, DEVM_IOREMAP_WC);
>>   }
>>   EXPORT_SYMBOL(devm_ioremap_wc);
>>   
>>
