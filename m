Return-Path: <rdunlap@infradead.org>
X-Google-Smtp-Source: AB8JxZoX9lJU37BypH717sboiLX+2/2S0RZYuOU+jTA5k29IK6OrtURJOy8jpusXJcT8KU5/rDHI
ARC-Seal: i=1; a=rsa-sha256; t=1525845693; cv=none;
        d=google.com; s=arc-20160816;
        b=jlwTC2W11z2ONQvCrnyXF2N7popOtA7CpzWxbrf/QX1vNBGHHIjl9BgZQ5jSgvgpir
         ArlM9aNRAqtRRV/Lh4W8aeseT4NcrCZPKFLeygWLtqILPZphKvT/TBXobdus+RmQuvpT
         S+R0nktW0k7WsYNZgssJ9rufIbNrgTl6x+eCbaC4JEL4E977MPDCxZ36PR4xijAB6wfD
         M9RCqGNgizE9PL5x3y6CAY8G3VR/kXpzIbzxEAD5vrMbkG10jkOlJoAeNKbi4fYBaU01
         lPhAW4IFqaxylC6V3Oz3J40/zEwC5mY5vYr3rzgSBEbzRvGY2oZXNlDsOhxPaFw5jDDA
         hyfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :dkim-signature:arc-authentication-results;
        bh=xQfrHx/LJuvzu6tLQhcHZd/KXGnDJVgvc7PGJZVwkI4=;
        b=XoeFffZG3YqW+6CULMEZyPhuLVVlHYt8TmtaYC0O5QLHP0dI83why2kuk2UKSGllu6
         9EBbXiMiWSQBFevdc61m3UlOB6+/IDFX6y8NgfMNt0J9jhMyr4r6ueYmG5aP/WvdsAqc
         LTxdtZBDE6krx+J7n98YHOlHbKNODarhVndv1lz4R7BkZUOto0f4FbmnY4E6YZ9FD3Il
         N8ygFcyy3e8yoVZXZFxj8oCtT/ajCreR4kdtfxloxMUrthRsduGiaEFOjGvgJSDld2m8
         605o5Cw6B3gpkhNGfW2c7fxdX+D4bhT2wjf1iLcnVEbX6MdJVpAzw7QosVv+/lxHstKt
         Joxw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@infradead.org header.s=bombadil.20170209 header.b=XvZoSpMA;
       spf=pass (google.com: best guess record for domain of rdunlap@infradead.org designates 2607:7c80:54:e::133 as permitted sender) smtp.mailfrom=rdunlap@infradead.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@infradead.org header.s=bombadil.20170209 header.b=XvZoSpMA;
       spf=pass (google.com: best guess record for domain of rdunlap@infradead.org designates 2607:7c80:54:e::133 as permitted sender) smtp.mailfrom=rdunlap@infradead.org
Subject: Re: [PATCH 3/4] coresight: allow to build as modules
To: Kim Phillips <kim.phillips@arm.com>
Cc: Mathieu Poirier <mathieu.poirier@linaro.org>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 David Howells <dhowells@redhat.com>, Eric Auger <eric.auger@redhat.com>,
 Eric Biederman <ebiederm@xmission.com>, Gargi Sharma <gs051095@gmail.com>,
 Geert Uytterhoeven <geert+renesas@glider.be>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Kefeng Wang <wangkefeng.wang@huawei.com>, Kirill Tkhai
 <ktkhai@virtuozzo.com>, Mike Rapoport <rppt@linux.vnet.ibm.com>,
 Oleg Nesterov <oleg@redhat.com>, Pavel Tatashin <pasha.tatashin@oracle.com>,
 Rik van Riel <riel@redhat.com>, Robin Murphy <robin.murphy@arm.com>,
 Russell King <linux@armlinux.org.uk>, Thierry Reding <treding@nvidia.com>,
 Todd Kjos <tkjos@google.com>, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org
References: <20180508140650.c070e6aa0eb1a6690e6d9607@arm.com>
 <f299d0be-f1a6-46ca-3d8a-13d7d89a007d@infradead.org>
 <20180508153756.09f6fa8066bc23a0d11ec670@arm.com>
From: Randy Dunlap <rdunlap@infradead.org>
Message-ID: <3826d737-c180-7b9e-8013-be54f6d7302d@infradead.org>
Date: Tue, 8 May 2018 23:01:12 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180508153756.09f6fa8066bc23a0d11ec670@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1599923984942793999?=
X-GMAIL-MSGID: =?utf-8?q?1599965173851231232?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 05/08/2018 01:37 PM, Kim Phillips wrote:
> On Tue, 8 May 2018 12:31:08 -0700
> Randy Dunlap <rdunlap@infradead.org> wrote:
> 
>> Hi,
> 
> Hi,

>>> diff --git a/drivers/hwtracing/coresight/coresight-etm-perf.h b/drivers/hwtracing/coresight/coresight-etm-perf.h
>>> index 3ffc9feb2d64..8c49c7b82d84 100644
>>> --- a/drivers/hwtracing/coresight/coresight-etm-perf.h
>>> +++ b/drivers/hwtracing/coresight/coresight-etm-perf.h
>>> @@ -54,7 +54,7 @@ struct etm_filters {
>>>  };
>>>  
>>>  
>>> -#ifdef CONFIG_CORESIGHT
>>> +#if IS_ENABLED(CONFIG_CORESIGHT)
>>
>> Have you found (observed) that this change (above) is necessary (and others
>> like it below)?  I thought that they would be equivalent.
>>
>> From include/linux/kconfig.h:
>> /*
>>  * IS_ENABLED(CONFIG_FOO) evaluates to 1 if CONFIG_FOO is set to 'y' or 'm',
>>  * 0 otherwise.
>>  */
>> #define IS_ENABLED(option) __or(IS_BUILTIN(option), IS_MODULE(option))
>>
>>
>>
>>> diff --git a/drivers/hwtracing/coresight/coresight-priv.h b/drivers/hwtracing/coresight/coresight-priv.h
>>> index f1d0e21d8cab..335bca44b42d 100644
>>> --- a/drivers/hwtracing/coresight/coresight-priv.h
>>> +++ b/drivers/hwtracing/coresight/coresight-priv.h
>>
>>> @@ -143,7 +149,7 @@ struct list_head *coresight_build_path(struct coresight_device *csdev,
>>>  				       struct coresight_device *sink);
>>>  void coresight_release_path(struct list_head *path);
>>>  
>>> -#ifdef CONFIG_CORESIGHT_SOURCE_ETM3X
>>> +#if IS_ENABLED(CONFIG_CORESIGHT_SOURCE_ETM3X)
>>
>> ditto.
>>
>>>  extern int etm_readl_cp14(u32 off, unsigned int *val);
>>>  extern int etm_writel_cp14(u32 off, u32 val);
>>>  #else
>>
>>> diff --git a/include/linux/coresight.h b/include/linux/coresight.h
>>> index d950dad5056a..5863eb1a7335 100644
>>> --- a/include/linux/coresight.h
>>> +++ b/include/linux/coresight.h
>>> @@ -243,7 +243,7 @@ struct coresight_ops {
>>>  	const struct coresight_ops_source *source_ops;
>>>  };
>>>  
>>> -#ifdef CONFIG_CORESIGHT
>>> +#if IS_ENABLED(CONFIG_CORESIGHT)
>>
>> ditto.
> 
> If I revert all three IS_ENABLED back to plain #ifdefs, and rebuild with
> CONFIG_CORESIGHT*=m, I get:
> 

[build errors deleted]

> 
> Building CORESIGHT=y builds ok, so, building it as a module causes the
> latter stubs to be compiled:
> 
> #ifdef CONFIG_CORESIGHT
> extern struct coresight_device *
> coresight_register(struct coresight_desc *desc);
> extern void coresight_unregister(struct coresight_device *csdev);
> extern int coresight_enable(struct coresight_device *csdev);
> extern void coresight_disable(struct coresight_device *csdev);
> extern int coresight_timeout(void __iomem *addr, u32 offset,
>                              int position, int value);
> #else
> static inline struct coresight_device *
> coresight_register(struct coresight_desc *desc) { return NULL; }
> static inline void coresight_unregister(struct coresight_device *csdev) {}
> static inline int
> coresight_enable(struct coresight_device *csdev) { return -ENOSYS; }
> static inline void coresight_disable(struct coresight_device *csdev) {}
> static inline int coresight_timeout(void __iomem *addr, u32 offset,
>                                      int position, int value) { return 1; }
> #endif
> 
> Adding kconfig.h to coresight.h's #include list doesn't help.  So we
> need the IS_ENABLED for its __or(..., IS_MODULE()) case.

<linux/kconfig.h> is automatically #included by the top-level Makefile,
so adding it again would not help any. ;)

> That being said, I don't know of any outside kernel-build dependencies
> coresight.h might have.

OK, using
#if IS_ENABLED(CONFIG_CORESIGHT)
is fine.  This is just the current/modern way of saying:
#if defined(CONFIG_CORESIGHT) || defined(CONFIG_CORESIGHT_MODULE)

There are several hundred instances of that latter form in the kernel tree.

thanks,
-- 
~Randy
