Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id YmoYL9dpGlvFUAAAmS7hNA
	; Fri, 08 Jun 2018 11:34:47 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 9A15A608B8; Fri,  8 Jun 2018 11:34:47 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Zrblun/i"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FROM,MAILING_LIST_MULTI autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 1449C607DC;
	Fri,  8 Jun 2018 11:34:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 1449C607DC
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752898AbeFHLeo (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Fri, 8 Jun 2018 07:34:44 -0400
Received: from mail-lf0-f65.google.com ([209.85.215.65]:44799 "EHLO
        mail-lf0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752650AbeFHLem (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jun 2018 07:34:42 -0400
Received: by mail-lf0-f65.google.com with SMTP id 36-v6so19538480lfr.11;
        Fri, 08 Jun 2018 04:34:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=9sA7oRCH1r5JNp+7y2Zmxqp3kX7+dtEdhA8/B7jnz48=;
        b=Zrblun/i1qmWE3Ez/n4WFoRk/PquieOgftJDYbTsQnsUeNEBod71Fgyxzcq9qQjs+1
         wTA6CwRpjX7aEnUtROWJ9aVSRLvnvvX1uHuoVTeHLWYEypxlVFyQ/PC0Sp8wnVPczMSd
         tNTWo5xL7ybIcDXknC9WiMWsfBdMiAINpMqGzpTaoxrPOFk0XKS21dzyEZX6ArkoQgv7
         e7gLZ5yXc2KKOyu8dY1kzQrD1bPOOYHpLvO6QixrR3iQ85wF3VA6CTJQlKMRytdRFmbd
         FKf/WAxmzBaDccLZl/is43KGZ+poa2ZyJlp/NqPojPnfclHpfIeTAFRomT4ewZTKzVZn
         hOKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=9sA7oRCH1r5JNp+7y2Zmxqp3kX7+dtEdhA8/B7jnz48=;
        b=K6CzpEtjgnzihPwV06XM+B68fuhQdBQieDP/ScesU+Fa4Smg8lX1pKs3vCUsZ40WLL
         bjxmt+OO8bM6Zc76hsmBBsZM18FWcDaKFivPr2z24QWtmaVK81q6hotdLUY40zqbJ3NJ
         mBwzkCeryirGApe8T0DTMFraY4RbGJIkpi/saSIFHsIPLblKLu9cBTnXWHw+H1hRVND/
         LyT2GL+HQk6oUBtYYwwokrjp0QkB08ZMlzMyqH16InEURI2+PwPhLzglP4eMOFeGEBUx
         C+Ku4v/Wn8vnnjRelAU1NuTb1NAzdEnXFH57KVrcD/bMr8QquRN7GoNw9Ap08/7REl2y
         fTlg==
X-Gm-Message-State: APt69E0491baaq5DDZr6sJF3g1aQQATt2TP1PqtLB8Hywkua1lBmrOd4
        kCaH+MNJPU0Ivd10Ypq0Dfs=
X-Google-Smtp-Source: ADUXVKIlbWs3dhiysCj4pXwKmw9XpomJmRXVnqj0U4eGRS4Y0u9IqQixNh/aCMjddV0uI/A2E+CbTg==
X-Received: by 2002:a19:d1d4:: with SMTP id i203-v6mr3636202lfg.93.1528457681224;
        Fri, 08 Jun 2018 04:34:41 -0700 (PDT)
Received: from [10.17.182.9] (ll-74.141.223.85.sovam.net.ua. [85.223.141.74])
        by smtp.gmail.com with ESMTPSA id p18-v6sm12180747lfd.91.2018.06.08.04.34.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 08 Jun 2018 04:34:40 -0700 (PDT)
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
 <d83a356c-f7a5-bce1-cafd-a52e736570fb@gmail.com>
 <b7f27688-f627-3fd9-9298-e02e6f35ca1e@oracle.com>
From: Oleksandr Andrushchenko <andr2000@gmail.com>
Message-ID: <0c820b7d-d9e5-8a60-b9fc-86eb3ca81df8@gmail.com>
Date: Fri, 8 Jun 2018 14:34:39 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <b7f27688-f627-3fd9-9298-e02e6f35ca1e@oracle.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/08/2018 01:30 AM, Boris Ostrovsky wrote:
> On 06/07/2018 04:44 AM, Oleksandr Andrushchenko wrote:
>> On 06/07/2018 12:48 AM, Boris Ostrovsky wrote:
>>> On 06/06/2018 08:10 AM, Oleksandr Andrushchenko wrote:
>>>> On 06/05/2018 01:07 AM, Boris Ostrovsky wrote:
>>>>> On 06/01/2018 07:41 AM, Oleksandr Andrushchenko wrote:
>>>>> +
>>>>> +static struct sg_table *
>>>>> +dmabuf_exp_ops_map_dma_buf(struct dma_buf_attachment *attach,
>>>>> +               enum dma_data_direction dir)
>>>>> +{
>>>>> +    struct gntdev_dmabuf_attachment *gntdev_dmabuf_attach =
>>>>> attach->priv;
>>>>> +    struct gntdev_dmabuf *gntdev_dmabuf = attach->dmabuf->priv;
>>>>> +    struct sg_table *sgt;
>>>>> +
>>>>> +    pr_debug("Mapping %d pages for dev %p\n",
>>>>> gntdev_dmabuf->nr_pages,
>>>>> +         attach->dev);
>>>>> +
>>>>> +    if (WARN_ON(dir == DMA_NONE || !gntdev_dmabuf_attach))
>>>>>
>>>>> WARN_ON_ONCE. Here and elsewhere.
>>>> Why? The UAPI may be used by different applications, thus we might
>>>> lose warnings for some of them. Having WARN_ON will show problems
>>>> for multiple users, not for the first one.
>>>> Does this make sense to still use WARN_ON?
>>> Just as with pr_err call somewhere else the concern here is that
>>> userland (which I think is where this is eventually called from?) may
>>> intentionally trigger the error, flooding the log.
>>>
>>> And even this is not directly called from userland there is still a
>>> possibility of triggering this error multiple times.
>> Ok, will use WARN_ON_ONCE
>
> In fact, is there a reason to use WARN at all? Does this condition
> indicate some sort of internal inconsistency/error?
Well, the corresponding errors are anyways handled, so I will remove WARN
> -boris
>
>
>
