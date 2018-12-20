Return-Path: <SRS0=2vky=O5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FROM,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E91EC43387
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 15:49:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3D842218C3
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 15:49:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oL/abNJS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731825AbeLTPtn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Dec 2018 10:49:43 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:39747 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731177AbeLTPtn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Dec 2018 10:49:43 -0500
Received: by mail-lj1-f194.google.com with SMTP id t9-v6so1996621ljh.6
        for <linux-kernel@vger.kernel.org>; Thu, 20 Dec 2018 07:49:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=fSfwxhUlbMhmCrA9iqmBULHSX153UKoySX4ZxCwKZo8=;
        b=oL/abNJS3yzcWkPTWa0Feeu76+ZZvzTSMXxUp7OMBgM5nuXBXVIWf1CYjHaT9bfhjb
         pWrh1tRlBAawhRgwj6B3QPU7jKBokDUHKQ+J3mZ5Hfkjyut1WrMTwh9zlSnBJmQ+cOY0
         F6yx+cDBOK8d3K9WG9m7BcGe14TdnhSvMsP2wWMkuy0ItI8hj8l4I4gAgzlgPDYI26rT
         GjuOavlNO+XY4/L7SGO375My230On+MHsVSeYaRgTD7+CCR1geMFSpFWJ/1zCsKeRGa/
         LuxQ9GUYyVy19N6Miickxf2gwHWk42BSKR0UPd/M+Mh/rKE9RGUqmv8E+emEdYi6MUzW
         nnYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=fSfwxhUlbMhmCrA9iqmBULHSX153UKoySX4ZxCwKZo8=;
        b=Oz1S5VQRqOp4mCdVdHNnS0FO5ok26OuklLHCROwzMvaQ1Dyy3CGIHsUx/UrAw9iyN7
         y6kQhI2XbKnebkjhzPrNo+X9f/G8cHsImi4luUGOBccSaURXYoS7cmEP7Q0trPIFSp0B
         2OIhMncpYHen0sqPnWyKqDSV+JjQ/OkMjRHvnIBMVKjKQr7EjFcGTpSaUZ3az7/suPmk
         wJXCxQxpFGeJkCZe/v6JQnFc9k1EQQyAxCLCdleWAubXkJhAOebaFsSiRFPW1lLE01wH
         7o3nXZl9F5bj0vo8SThblejFJn1iuVA5K9rCMhM/GjHc3AIwjIlKYdQXQ5O6oPf5rBVc
         4M6Q==
X-Gm-Message-State: AA+aEWaUo60jQMjOfp1GptKwWX/1a87oZiA6AkwGFI5R2/Gy1ctAWpk5
        5DBtwWupXn6Y7rVIx6xHph0=
X-Google-Smtp-Source: AFSGD/XPTImU5qi3xP1i8p0TYOhxN2+9Lbb+tMNcLfo5UbXMz23eNsWkslF4SyWh5PyKTORoYxft9g==
X-Received: by 2002:a2e:9ad0:: with SMTP id p16-v6mr17032454ljj.102.1545320981146;
        Thu, 20 Dec 2018 07:49:41 -0800 (PST)
Received: from [10.17.182.20] (ll-22.209.223.85.sovam.net.ua. [85.223.209.22])
        by smtp.gmail.com with ESMTPSA id f16-v6sm4236956lji.88.2018.12.20.07.49.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 20 Dec 2018 07:49:40 -0800 (PST)
Subject: Re: [PATCH] drm/xen-front: Make shmem backed display buffer coherent
To:     Christoph Hellwig <hch@infradead.org>,
        =?UTF-8?Q?Noralf_Tr=c3=b8nnes?= <noralf@tronnes.org>
Cc:     xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, daniel.vetter@intel.com,
        jgross@suse.com, boris.ostrovsky@oracle.com,
        Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>
References: <20181127103252.20994-1-andr2000@gmail.com>
 <17640791-5306-f7e4-8588-dd39c14e975b@tronnes.org>
 <20181220153646.GA22997@infradead.org>
From:   Oleksandr Andrushchenko <andr2000@gmail.com>
Message-ID: <f2cfadc7-2e0b-b63d-d094-d5339b0c85fe@gmail.com>
Date:   Thu, 20 Dec 2018 17:49:39 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181220153646.GA22997@infradead.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/20/18 5:36 PM, Christoph Hellwig wrote:
> On Tue, Dec 18, 2018 at 08:20:22PM +0100, Noralf Trønnes wrote:
>>> +	if (!dma_map_sg(dev->dev, xen_obj->sgt->sgl, xen_obj->sgt->nents,
>>> +			DMA_BIDIRECTIONAL)) {
>>
>> Are you using the DMA streaming API as a way to flush the caches?
> This looks rather broken.  Please send the whole patch series to
> the iommu list for proper review.
This is the only patch [1], no series. And at the moment I think
there is nothing to review as I am not sure how to deal with those
shmem pages: this patch is rather to start a discussion on how shmem
pages can be flushed on ARM (the only workaround I have so far is
in this patch which uses DMA API). This is where I am looking for
some advice, so I can implement the patch the right way.
>> Does this mean that GFP_USER isn't making the buffer coherent?
> How could GFP_USER make memory coherent in any way?
I am no way an expert here, but other DRM drivers allocate buffers
from shmem and then use DMA API [2], for example [3]

[1] https://patchwork.kernel.org/patch/10700089/
[2] https://elixir.bootlin.com/linux/v4.20-rc7/ident/drm_gem_get_pages
[3] 
https://elixir.bootlin.com/linux/v4.20-rc7/source/drivers/gpu/drm/omapdrm/omap_gem.c#L248
