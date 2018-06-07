Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id IFuwKd7vGFtxCgAAmS7hNA
	; Thu, 07 Jun 2018 08:44:14 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 10273607F7; Thu,  7 Jun 2018 08:44:14 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T2sfmcBi"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FROM,MAILING_LIST_MULTI autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 70803602FC;
	Thu,  7 Jun 2018 08:44:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 70803602FC
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932768AbeFGIoL (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Thu, 7 Jun 2018 04:44:11 -0400
Received: from mail-lf0-f66.google.com ([209.85.215.66]:35111 "EHLO
        mail-lf0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932660AbeFGIoH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jun 2018 04:44:07 -0400
Received: by mail-lf0-f66.google.com with SMTP id i15-v6so3068536lfc.2;
        Thu, 07 Jun 2018 01:44:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=Q3u67MiaaDQK4Fi0u7hoQgCOZQqFph9VS1L4NMxdXhw=;
        b=T2sfmcBiNKZT+Ga/AwyWX+CcVMJGjt2JiPvAgAYlBUNwvo7J8TuFWgI/cNImxuLs8Q
         0kL7kO8a+LdeNfSEl5YwxGVlOiAggm4xyI65gzOFOhpO4niE1/7DsELTIuCAzgT7mx6M
         3a07PsoW7z1kYsuV0kexMvRJZqjwBstWm4B1RtnCZNt0OdcqYShiKY5EXstWfndHcZdc
         Bo1bhuVRdTQLxp6+StQS/Av+V/3wbGkY562o3XLLX03ImcpQ/2ouSTX0vrS5hPqVccyI
         MULiXnog5WvZME9HkEeLBBj+73QCsaBVbX9th9b1oCmcKt0PmlRwPBZ2ta+7VvoJi6sX
         ndyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=Q3u67MiaaDQK4Fi0u7hoQgCOZQqFph9VS1L4NMxdXhw=;
        b=PR7R/aitG14NVDVco44LfxuKEoP2Hc+fTuCT3J61oW8CunMElUSabzxBGpvaJz9rHF
         AMUTEtWfR1LdD60ycb99MdJjM/iuLxqpj6ZLvm7H1bibk4g6pjqdb/Lpll8IAzXBgxBA
         VFxm+zgL8Moz4CjQFToUUKjsMCoLj6vuIh6FT1Kit3dS4dVbljGqW+qdbWOAG8MM44Wh
         yKxBwhLcQrn/n9GNcffMZOGv8qeGL5I1PZNZ9jzwzDlCk33ec4gfGQpl9ucV4DESrDvK
         KSJJncb7AyMFmX1OH6ysKKQtME08+lMYhci3hEHCy6jAqTHRMsNWNzn1HhjxGTIFeMMx
         NlOw==
X-Gm-Message-State: APt69E3k6Q3SKh/msi/he8XpcTLbM6ZVoR+o2WSu7Nm+dtu7IjQH8sa/
        7girCurx4FZ3Sk/2An5FChk=
X-Google-Smtp-Source: ADUXVKKAsA2/2arfbioPO2QimKh5qzjCgDUWKLiQQZoSl1Vqv/4wJqy29BOZWbXet9ZCcyKnFoX2Nw==
X-Received: by 2002:a2e:428e:: with SMTP id h14-v6mr858943ljf.136.1528361045999;
        Thu, 07 Jun 2018 01:44:05 -0700 (PDT)
Received: from [10.17.182.9] (ll-59.209.223.85.sovam.net.ua. [85.223.209.59])
        by smtp.gmail.com with ESMTPSA id o68-v6sm4999574lfc.85.2018.06.07.01.44.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 07 Jun 2018 01:44:05 -0700 (PDT)
Subject: Re: [PATCH v2 7/9] xen/gntdev: Implement dma-buf export functionality
To: Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-media@vger.kernel.org,
        jgross@suse.com, konrad.wilk@oracle.com
Cc: daniel.vetter@intel.com, dongwon.kim@intel.com,
        matthew.d.roper@intel.com,
        Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>
References: <20180601114132.22596-1-andr2000@gmail.com>
 <20180601114132.22596-8-andr2000@gmail.com>
 <96dd30f5-6ac6-498f-06e7-352e46994576@oracle.com>
 <117e05b3-69f6-b879-50d9-0cddd8e4c313@gmail.com>
 <4b37bbe1-6c5c-1941-bac0-2c7ba88af3e3@oracle.com>
From: Oleksandr Andrushchenko <andr2000@gmail.com>
Message-ID: <d83a356c-f7a5-bce1-cafd-a52e736570fb@gmail.com>
Date: Thu, 7 Jun 2018 11:44:03 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <4b37bbe1-6c5c-1941-bac0-2c7ba88af3e3@oracle.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/07/2018 12:48 AM, Boris Ostrovsky wrote:
> On 06/06/2018 08:10 AM, Oleksandr Andrushchenko wrote:
>> On 06/05/2018 01:07 AM, Boris Ostrovsky wrote:
>>> On 06/01/2018 07:41 AM, Oleksandr Andrushchenko wrote:
>
>>> +
>>> +static struct sg_table *
>>> +dmabuf_exp_ops_map_dma_buf(struct dma_buf_attachment *attach,
>>> +               enum dma_data_direction dir)
>>> +{
>>> +    struct gntdev_dmabuf_attachment *gntdev_dmabuf_attach =
>>> attach->priv;
>>> +    struct gntdev_dmabuf *gntdev_dmabuf = attach->dmabuf->priv;
>>> +    struct sg_table *sgt;
>>> +
>>> +    pr_debug("Mapping %d pages for dev %p\n", gntdev_dmabuf->nr_pages,
>>> +         attach->dev);
>>> +
>>> +    if (WARN_ON(dir == DMA_NONE || !gntdev_dmabuf_attach))
>>>
>>> WARN_ON_ONCE. Here and elsewhere.
>> Why? The UAPI may be used by different applications, thus we might
>> lose warnings for some of them. Having WARN_ON will show problems
>> for multiple users, not for the first one.
>> Does this make sense to still use WARN_ON?
>
> Just as with pr_err call somewhere else the concern here is that
> userland (which I think is where this is eventually called from?) may
> intentionally trigger the error, flooding the log.
>
> And even this is not directly called from userland there is still a
> possibility of triggering this error multiple times.
Ok, will use WARN_ON_ONCE
>
>>>> +
>>>> +    if (use_ptemod) {
>>>> +        pr_err("Cannot provide dma-buf: use_ptemode %d\n",
>>>> +               use_ptemod);
>>> No pr_err here please. This can potentially become a DoS vector as it
>>> comes directly from ioctl.
>>>
>>> I would, in fact, revisit other uses of pr_err in this file.
>> Sure, all of pr_err can actually be pr_debug...
> I'd check even further and see if any prink is needed. I think I saw a
> couple that were not especially useful.
All those were useful while debugging the code and use-cases,
so I would prefer to have them all still available, but as pr_debug
instead of pr_err
If hyper_dmabuf will use this Xen dma-buf solution then I believe
those will help as well
>
>>>> +        return -EINVAL;
>>>> +    }
>>>> +
>>>> +    map = dmabuf_exp_alloc_backing_storage(priv, flags, count);
>>> @count comes from userspace. dmabuf_exp_alloc_backing_storage only
>>> checks for it to be >0. Should it be checked for some sane max value?
>> This is not easy as it is hard to tell what could be that
>> max value. For DMA buffers if count is too big then allocation
>> will fail, so need to check for max here  (dma_alloc_{xxx} will
>> filter out too big allocations).
> OK, that may be sufficient. BTW, I believe there were other loops with
> @count being the control variable. Please see if a user can pass a bogus
> value.
Will check for op.count in IOCTLs
>> For Xen balloon allocations I cannot tell what could be that
>> max value neither. Tough question how to limit.
> I think in balloon there is also a guarantee (of sorts) that something
> prior to a loop will fail.
>
>
> -boris
Thank you,
Oleksandr
