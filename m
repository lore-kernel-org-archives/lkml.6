Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id Qv9ZN3B1Hlu6FgAAmS7hNA
	; Mon, 11 Jun 2018 13:13:22 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id CB40D607BB; Mon, 11 Jun 2018 13:13:22 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gwoRZhcg"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FROM,MAILING_LIST_MULTI
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 4904960385;
	Mon, 11 Jun 2018 13:13:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 4904960385
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933202AbeFKNNU (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 20 others); Mon, 11 Jun 2018 09:13:20 -0400
Received: from mail-lf0-f68.google.com ([209.85.215.68]:40585 "EHLO
        mail-lf0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932607AbeFKNNS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jun 2018 09:13:18 -0400
Received: by mail-lf0-f68.google.com with SMTP id q11-v6so30468563lfc.7;
        Mon, 11 Jun 2018 06:13:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=UGl4p6I8/YEn1KudkQOQz8mT6Ax+tKnXFOSar6z5Mgk=;
        b=gwoRZhcgoiFq/PCPSk91jXJdkBg3qeY0ESwcR6439i/xEH0hXPAYx+BlRutl5Uqp/+
         GLGp8aDpK5WC2jlYiVEscfoklE0y5eLnQkdAn93d5BjY6OdLBp145ZfwJLlai2U98n0d
         WynBuY/MkpyOEUKSTtM5dW+unY9pMf0hddTBon6iZXGU/SPWf7D97DJa6k9+9YiGpaU8
         UOytF9hmqBhvnJCJDAlSmc4FxMgWBglKm2OLi8O7PY+nHTTOSGIojC0eN5gB2KDezheG
         ibFQziwVFWY8G1kuEogmKtkxzAlED0QGZ84hbweQ/iVTI2t/gjpk6APwDVMUAUpUo5t5
         oRlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=UGl4p6I8/YEn1KudkQOQz8mT6Ax+tKnXFOSar6z5Mgk=;
        b=SgcKE6spxv4rHsDsM04pBfFu7ek2aKYlPCUu9EUwDxZVIpq0FT69DFOFr1mLrt8552
         Lhvs0WRJmppf/u/uI/wyxXh93tBefy5t1BQyHO303HZGO+19q7HsV/ShwTjkxT3+mRgP
         eOz4GgMwSk6gKe5K0nL6A84H7krJUQQccKvpPCUJOhExkUUdgaZCQKMrZipoOzNAvJxN
         fOSLrObfT7ytTCPVi3jcp1qN/pzDNvWVvdQ7m5srIOaPhVbuv0PfSvD8kT7fQlqlPaU8
         HWzfRhnYNRWYVs2Mgn7YdvN5/2AUiGM5AG/PeuAGBCtjBfVi3NL7bd+0Litk1XqYFj6O
         2swA==
X-Gm-Message-State: APt69E2DIfMa+hhFzC++zIBWC0c4bcBAC2KqtYAfEO96jaldBb0zNN07
        3Y3vjrm+dhdT2pAqBPHTGrA=
X-Google-Smtp-Source: ADUXVKJvHCriZYP5PQkCYJAuXPLfUExJqacwsMqTebD9WcAbOJuoYeDJNGHikH7ZO1EtSDEqryPYRw==
X-Received: by 2002:a19:5113:: with SMTP id f19-v6mr10736235lfb.13.1528722796192;
        Mon, 11 Jun 2018 06:13:16 -0700 (PDT)
Received: from [10.17.182.9] (ll-55.209.223.85.sovam.net.ua. [85.223.209.55])
        by smtp.gmail.com with ESMTPSA id d6-v6sm5794871ljd.52.2018.06.11.06.13.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 11 Jun 2018 06:13:14 -0700 (PDT)
Subject: Re: [Xen-devel] [PATCH v2 5/9] xen/gntdev: Allow mappings for DMA
 buffers
To: Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        "Oleksandr_Andrushchenko@epam.com" <Oleksandr_Andrushchenko@epam.com>
Cc: xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-media@vger.kernel.org,
        jgross@suse.com, konrad.wilk@oracle.com, daniel.vetter@intel.com,
        matthew.d.roper@intel.com, dongwon.kim@intel.com,
        julien.grall@arm.com
References: <20180601114132.22596-1-andr2000@gmail.com>
 <20180601114132.22596-6-andr2000@gmail.com>
 <64facf05-0a51-c3d9-9d3b-780893248628@oracle.com>
 <84217eac-b83b-710f-39ab-c93cad65bf9a@gmail.com>
 <a172746d-7a97-159f-71a7-511b2d239089@oracle.com>
 <30fa03c0-1b75-c0b1-b14f-8b52ea584e20@gmail.com>
 <78dc2fc4-cdac-05b7-2c34-22b69e7e009c@oracle.com>
 <4be24882-185d-01e3-6aa1-751e341433c7@gmail.com>
 <alpine.DEB.2.10.1806081025030.14699@sstabellini-ThinkPad-X260>
 <c6e1820a-fb57-b213-aa2f-05787dae06ad@oracle.com>
From: Oleksandr Andrushchenko <andr2000@gmail.com>
Message-ID: <06eff3fe-3ffc-47f6-6bd6-d8f2f823b382@gmail.com>
Date: Mon, 11 Jun 2018 16:13:13 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <c6e1820a-fb57-b213-aa2f-05787dae06ad@oracle.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/08/2018 10:21 PM, Boris Ostrovsky wrote:
> On 06/08/2018 01:59 PM, Stefano Stabellini wrote:
>>>>>>>>>      @@ -325,6 +401,14 @@ static int map_grant_pages(struct
>>>>>>>>> grant_map
>>>>>>>>> *map)
>>>>>>>>>              map->unmap_ops[i].handle = map->map_ops[i].handle;
>>>>>>>>>              if (use_ptemod)
>>>>>>>>>                  map->kunmap_ops[i].handle =
>>>>>>>>> map->kmap_ops[i].handle;
>>>>>>>>> +#ifdef CONFIG_XEN_GRANT_DMA_ALLOC
>>>>>>>>> +        else if (map->dma_vaddr) {
>>>>>>>>> +            unsigned long mfn;
>>>>>>>>> +
>>>>>>>>> +            mfn = __pfn_to_mfn(page_to_pfn(map->pages[i]));
>>>>>>>> Not pfn_to_mfn()?
>>>>>>> I'd love to, but pfn_to_mfn is only defined for x86, not ARM: [1]
>>>>>>> and [2]
>>>>>>> Thus,
>>>>>>>
>>>>>>> drivers/xen/gntdev.c:408:10: error: implicit declaration of function
>>>>>>> ‘pfn_to_mfn’ [-Werror=implicit-function-declaration]
>>>>>>>        mfn = pfn_to_mfn(page_to_pfn(map->pages[i]));
>>>>>>>
>>>>>>> So, I'll keep __pfn_to_mfn
>>>>>> How will this work on non-PV x86?
>>>>> So, you mean I need:
>>>>> #ifdef CONFIG_X86
>>>>> mfn = pfn_to_mfn(page_to_pfn(map->pages[i]));
>>>>> #else
>>>>> mfn = __pfn_to_mfn(page_to_pfn(map->pages[i]));
>>>>> #endif
>>>>>
>>>> I'd rather fix it in ARM code. Stefano, why does ARM uses the
>>>> underscored version?
>>> Do you want me to add one more patch for ARM to wrap __pfn_to_mfn
>>> with static inline for ARM? e.g.
>>> static inline ...pfn_to_mfn(...)
>>> {
>>>      __pfn_to_mfn();
>>> }
>> A Xen on ARM guest doesn't actually know the mfns behind its own
>> pseudo-physical pages. This is why we stopped using pfn_to_mfn and
>> started using pfn_to_bfn instead, which will generally return "pfn",
>> unless the page is a foreign grant. See include/xen/arm/page.h.
>> pfn_to_bfn was also introduced on x86. For example, see the usage of
>> pfn_to_bfn in drivers/xen/swiotlb-xen.c. Otherwise, if you don't care
>> about other mapped grants, you can just use pfn_to_gfn, that always
>> returns pfn.
>
> I think then this code needs to use pfn_to_bfn().
Ok
>
>
>> Also, for your information, we support different page granularities in
>> Linux as a Xen guest, see the comment at include/xen/arm/page.h:
>>
>>    /*
>>     * The pseudo-physical frame (pfn) used in all the helpers is always based
>>     * on Xen page granularity (i.e 4KB).
>>     *
>>     * A Linux page may be split across multiple non-contiguous Xen page so we
>>     * have to keep track with frame based on 4KB page granularity.
>>     *
>>     * PV drivers should never make a direct usage of those helpers (particularly
>>     * pfn_to_gfn and gfn_to_pfn).
>>     */
>>
>> A Linux page could be 64K, but a Xen page is always 4K. A granted page
>> is also 4K. We have helpers to take into account the offsets to map
>> multiple Xen grants in a single Linux page, see for example
>> drivers/xen/grant-table.c:gnttab_foreach_grant. Most PV drivers have
>> been converted to be able to work with 64K pages correctly, but if I
>> remember correctly gntdev.c is the only remaining driver that doesn't
>> support 64K pages yet, so you don't have to deal with it if you don't
>> want to.
>
> I believe somewhere in this series there is a test for PAGE_SIZE vs.
> XEN_PAGE_SIZE. Right, Oleksandr?
Not in gntdev. You might have seen this in xen-drmfront/xen-sndfront,
but I didn't touch gntdev for that. Do you want me to add yet another patch
in the series to check for that?
> Thanks for the explanation.
>
> -boris
Thank you,
Oleksandr
