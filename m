Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id hiMXGGTWGltRNAAAmS7hNA
	; Fri, 08 Jun 2018 19:17:58 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 11D14607DC; Fri,  8 Jun 2018 19:17:58 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="pRTgyBcg"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,T_DKIMWL_WL_HIGH,
	UNPARSEABLE_RELAY autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 605286074D;
	Fri,  8 Jun 2018 19:17:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 605286074D
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753000AbeFHTRz (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Fri, 8 Jun 2018 15:17:55 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:55238 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752754AbeFHTRw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jun 2018 15:17:52 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w58JGW0d127709;
        Fri, 8 Jun 2018 19:17:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2017-10-26;
 bh=86ebbocUIvzJZFx5GFmIn9Zt+iT3ynyHuDl0fDMxce4=;
 b=pRTgyBcgbhtmRyuN7VpkVIa/xbKjPxdf1xbtOMspAG1a3zNZZkM6I4x+olLxtuKbJe2k
 S7QDP6+dilOEP8P8GkNIYkYwXQlud+dee0QBAAycKCDC26lCI+AXn8zFz7XB9SAf2jPq
 uxkNvhcqtxGkxxFyANU/kcSmi4unPAMOfgcIrwSUn0wzoTNBMQ16lxeM5lVkOOF6APnX
 yvvXMUjsvo+LMarAN22SrLMKDsdFWeNWMJZ9Z7vJcAAseKGnVx6U0zB+UBI7VfhTAN9l
 IZTfMJfK2QejchzM9Qwtp7GppRgS5Lu5EIE5Xqu0v0CAf+gFy/atSBXxac1PoYF31a4z KA==
Received: from aserv0022.oracle.com (aserv0022.oracle.com [141.146.126.234])
        by userp2120.oracle.com with ESMTP id 2jbvypxm3s-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 08 Jun 2018 19:17:35 +0000
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserv0022.oracle.com (8.14.4/8.14.4) with ESMTP id w58JHXrs004218
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 8 Jun 2018 19:17:34 GMT
Received: from abhmp0015.oracle.com (abhmp0015.oracle.com [141.146.116.21])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id w58JHWmo023284;
        Fri, 8 Jun 2018 19:17:32 GMT
Received: from dhcp-burlington7-2nd-B-east-10-152-55-162.usdhcp.oraclecorp.com (/10.152.32.65)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 08 Jun 2018 12:17:32 -0700
Subject: Re: [Xen-devel] [PATCH v2 5/9] xen/gntdev: Allow mappings for DMA
 buffers
To: Stefano Stabellini <sstabellini@kernel.org>,
        Oleksandr Andrushchenko <andr2000@gmail.com>
Cc: xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-media@vger.kernel.org,
        jgross@suse.com, konrad.wilk@oracle.com, daniel.vetter@intel.com,
        matthew.d.roper@intel.com, dongwon.kim@intel.com,
        Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>,
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
From: Boris Ostrovsky <boris.ostrovsky@oracle.com>
Openpgp: preference=signencrypt
Autocrypt: addr=boris.ostrovsky@oracle.com; prefer-encrypt=mutual; keydata=
 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
 Jg6OxFYd01z+a+oL
Message-ID: <c6e1820a-fb57-b213-aa2f-05787dae06ad@oracle.com>
Date: Fri, 8 Jun 2018 15:21:24 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.10.1806081025030.14699@sstabellini-ThinkPad-X260>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8918 signatures=668702
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1805220000 definitions=main-1806080211
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/08/2018 01:59 PM, Stefano Stabellini wrote:
>
>>>>>>>>     @@ -325,6 +401,14 @@ static int map_grant_pages(struct
>>>>>>>> grant_map
>>>>>>>> *map)
>>>>>>>>             map->unmap_ops[i].handle = map->map_ops[i].handle;
>>>>>>>>             if (use_ptemod)
>>>>>>>>                 map->kunmap_ops[i].handle =
>>>>>>>> map->kmap_ops[i].handle;
>>>>>>>> +#ifdef CONFIG_XEN_GRANT_DMA_ALLOC
>>>>>>>> +        else if (map->dma_vaddr) {
>>>>>>>> +            unsigned long mfn;
>>>>>>>> +
>>>>>>>> +            mfn = __pfn_to_mfn(page_to_pfn(map->pages[i]));
>>>>>>> Not pfn_to_mfn()?
>>>>>> I'd love to, but pfn_to_mfn is only defined for x86, not ARM: [1]
>>>>>> and [2]
>>>>>> Thus,
>>>>>>
>>>>>> drivers/xen/gntdev.c:408:10: error: implicit declaration of function
>>>>>> ‘pfn_to_mfn’ [-Werror=implicit-function-declaration]
>>>>>>       mfn = pfn_to_mfn(page_to_pfn(map->pages[i]));
>>>>>>
>>>>>> So, I'll keep __pfn_to_mfn
>>>>> How will this work on non-PV x86?
>>>> So, you mean I need:
>>>> #ifdef CONFIG_X86
>>>> mfn = pfn_to_mfn(page_to_pfn(map->pages[i]));
>>>> #else
>>>> mfn = __pfn_to_mfn(page_to_pfn(map->pages[i]));
>>>> #endif
>>>>
>>> I'd rather fix it in ARM code. Stefano, why does ARM uses the
>>> underscored version?
>> Do you want me to add one more patch for ARM to wrap __pfn_to_mfn
>> with static inline for ARM? e.g.
>> static inline ...pfn_to_mfn(...)
>> {
>>     __pfn_to_mfn();
>> }
>
> A Xen on ARM guest doesn't actually know the mfns behind its own
> pseudo-physical pages. This is why we stopped using pfn_to_mfn and
> started using pfn_to_bfn instead, which will generally return "pfn",
> unless the page is a foreign grant. See include/xen/arm/page.h.
> pfn_to_bfn was also introduced on x86. For example, see the usage of
> pfn_to_bfn in drivers/xen/swiotlb-xen.c. Otherwise, if you don't care
> about other mapped grants, you can just use pfn_to_gfn, that always
> returns pfn.


I think then this code needs to use pfn_to_bfn().



>
> Also, for your information, we support different page granularities in
> Linux as a Xen guest, see the comment at include/xen/arm/page.h:
>
>   /*
>    * The pseudo-physical frame (pfn) used in all the helpers is always based
>    * on Xen page granularity (i.e 4KB).
>    *
>    * A Linux page may be split across multiple non-contiguous Xen page so we
>    * have to keep track with frame based on 4KB page granularity.
>    *
>    * PV drivers should never make a direct usage of those helpers (particularly
>    * pfn_to_gfn and gfn_to_pfn).
>    */
>
> A Linux page could be 64K, but a Xen page is always 4K. A granted page
> is also 4K. We have helpers to take into account the offsets to map
> multiple Xen grants in a single Linux page, see for example
> drivers/xen/grant-table.c:gnttab_foreach_grant. Most PV drivers have
> been converted to be able to work with 64K pages correctly, but if I
> remember correctly gntdev.c is the only remaining driver that doesn't
> support 64K pages yet, so you don't have to deal with it if you don't
> want to.


I believe somewhere in this series there is a test for PAGE_SIZE vs.
XEN_PAGE_SIZE. Right, Oleksandr?

Thanks for the explanation.

-boris
