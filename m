Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 889EFC04EB9
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 10:42:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4ED8320659
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 10:42:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4ED8320659
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727409AbeLEKmR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 05:42:17 -0500
Received: from mx1.redhat.com ([209.132.183.28]:51964 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727335AbeLEKmP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 05:42:15 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 0DC9C3082AFD;
        Wed,  5 Dec 2018 10:42:14 +0000 (UTC)
Received: from [10.36.117.65] (ovpn-117-65.ams2.redhat.com [10.36.117.65])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 35B262B89D;
        Wed,  5 Dec 2018 10:42:12 +0000 (UTC)
Subject: Re: [PATCH] mm, page_alloc: Drop uneeded __meminit and __meminitdata
To:     Oscar Salvador <osalvador@suse.de>, akpm@linux-foundation.org
Cc:     mhocko@suse.com, pavel.tatashin@microsoft.com, vbabka@suse.cz,
        alexander.h.duyck@linux.intel.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <20181204111507.4808-1-osalvador@suse.de>
From:   David Hildenbrand <david@redhat.com>
Openpgp: preference=signencrypt
Autocrypt: addr=david@redhat.com; prefer-encrypt=mutual; keydata=
 xsFNBFXLn5EBEAC+zYvAFJxCBY9Tr1xZgcESmxVNI/0ffzE/ZQOiHJl6mGkmA1R7/uUpiCjJ
 dBrn+lhhOYjjNefFQou6478faXE6o2AhmebqT4KiQoUQFV4R7y1KMEKoSyy8hQaK1umALTdL
 QZLQMzNE74ap+GDK0wnacPQFpcG1AE9RMq3aeErY5tujekBS32jfC/7AnH7I0v1v1TbbK3Gp
 XNeiN4QroO+5qaSr0ID2sz5jtBLRb15RMre27E1ImpaIv2Jw8NJgW0k/D1RyKCwaTsgRdwuK
 Kx/Y91XuSBdz0uOyU/S8kM1+ag0wvsGlpBVxRR/xw/E8M7TEwuCZQArqqTCmkG6HGcXFT0V9
 PXFNNgV5jXMQRwU0O/ztJIQqsE5LsUomE//bLwzj9IVsaQpKDqW6TAPjcdBDPLHvriq7kGjt
 WhVhdl0qEYB8lkBEU7V2Yb+SYhmhpDrti9Fq1EsmhiHSkxJcGREoMK/63r9WLZYI3+4W2rAc
 UucZa4OT27U5ZISjNg3Ev0rxU5UH2/pT4wJCfxwocmqaRr6UYmrtZmND89X0KigoFD/XSeVv
 jwBRNjPAubK9/k5NoRrYqztM9W6sJqrH8+UWZ1Idd/DdmogJh0gNC0+N42Za9yBRURfIdKSb
 B3JfpUqcWwE7vUaYrHG1nw54pLUoPG6sAA7Mehl3nd4pZUALHwARAQABzSREYXZpZCBIaWxk
 ZW5icmFuZCA8ZGF2aWRAcmVkaGF0LmNvbT7CwX4EEwECACgFAljj9eoCGwMFCQlmAYAGCwkI
 BwMCBhUIAgkKCwQWAgMBAh4BAheAAAoJEE3eEPcA/4Na5IIP/3T/FIQMxIfNzZshIq687qgG
 8UbspuE/YSUDdv7r5szYTK6KPTlqN8NAcSfheywbuYD9A4ZeSBWD3/NAVUdrCaRP2IvFyELj
 xoMvfJccbq45BxzgEspg/bVahNbyuBpLBVjVWwRtFCUEXkyazksSv8pdTMAs9IucChvFmmq3
 jJ2vlaz9lYt/lxN246fIVceckPMiUveimngvXZw21VOAhfQ+/sofXF8JCFv2mFcBDoa7eYob
 s0FLpmqFaeNRHAlzMWgSsP80qx5nWWEvRLdKWi533N2vC/EyunN3HcBwVrXH4hxRBMco3jvM
 m8VKLKao9wKj82qSivUnkPIwsAGNPdFoPbgghCQiBjBe6A75Z2xHFrzo7t1jg7nQfIyNC7ez
 MZBJ59sqA9EDMEJPlLNIeJmqslXPjmMFnE7Mby/+335WJYDulsRybN+W5rLT5aMvhC6x6POK
 z55fMNKrMASCzBJum2Fwjf/VnuGRYkhKCqqZ8gJ3OvmR50tInDV2jZ1DQgc3i550T5JDpToh
 dPBxZocIhzg+MBSRDXcJmHOx/7nQm3iQ6iLuwmXsRC6f5FbFefk9EjuTKcLMvBsEx+2DEx0E
 UnmJ4hVg7u1PQ+2Oy+Lh/opK/BDiqlQ8Pz2jiXv5xkECvr/3Sv59hlOCZMOaiLTTjtOIU7Tq
 7ut6OL64oAq+zsFNBFXLn5EBEADn1959INH2cwYJv0tsxf5MUCghCj/CA/lc/LMthqQ773ga
 uB9mN+F1rE9cyyXb6jyOGn+GUjMbnq1o121Vm0+neKHUCBtHyseBfDXHA6m4B3mUTWo13nid
 0e4AM71r0DS8+KYh6zvweLX/LL5kQS9GQeT+QNroXcC1NzWbitts6TZ+IrPOwT1hfB4WNC+X
 2n4AzDqp3+ILiVST2DT4VBc11Gz6jijpC/KI5Al8ZDhRwG47LUiuQmt3yqrmN63V9wzaPhC+
 xbwIsNZlLUvuRnmBPkTJwwrFRZvwu5GPHNndBjVpAfaSTOfppyKBTccu2AXJXWAE1Xjh6GOC
 8mlFjZwLxWFqdPHR1n2aPVgoiTLk34LR/bXO+e0GpzFXT7enwyvFFFyAS0Nk1q/7EChPcbRb
 hJqEBpRNZemxmg55zC3GLvgLKd5A09MOM2BrMea+l0FUR+PuTenh2YmnmLRTro6eZ/qYwWkC
 u8FFIw4pT0OUDMyLgi+GI1aMpVogTZJ70FgV0pUAlpmrzk/bLbRkF3TwgucpyPtcpmQtTkWS
 gDS50QG9DR/1As3LLLcNkwJBZzBG6PWbvcOyrwMQUF1nl4SSPV0LLH63+BrrHasfJzxKXzqg
 rW28CTAE2x8qi7e/6M/+XXhrsMYG+uaViM7n2je3qKe7ofum3s4vq7oFCPsOgwARAQABwsFl
 BBgBAgAPBQJVy5+RAhsMBQkJZgGAAAoJEE3eEPcA/4NagOsP/jPoIBb/iXVbM+fmSHOjEshl
 KMwEl/m5iLj3iHnHPVLBUWrXPdS7iQijJA/VLxjnFknhaS60hkUNWexDMxVVP/6lbOrs4bDZ
 NEWDMktAeqJaFtxackPszlcpRVkAs6Msn9tu8hlvB517pyUgvuD7ZS9gGOMmYwFQDyytpepo
 YApVV00P0u3AaE0Cj/o71STqGJKZxcVhPaZ+LR+UCBZOyKfEyq+ZN311VpOJZ1IvTExf+S/5
 lqnciDtbO3I4Wq0ArLX1gs1q1XlXLaVaA3yVqeC8E7kOchDNinD3hJS4OX0e1gdsx/e6COvy
 qNg5aL5n0Kl4fcVqM0LdIhsubVs4eiNCa5XMSYpXmVi3HAuFyg9dN+x8thSwI836FoMASwOl
 C7tHsTjnSGufB+D7F7ZBT61BffNBBIm1KdMxcxqLUVXpBQHHlGkbwI+3Ye+nE6HmZH7IwLwV
 W+Ajl7oYF+jeKaH4DZFtgLYGLtZ1LDwKPjX7VAsa4Yx7S5+EBAaZGxK510MjIx6SGrZWBrrV
 TEvdV00F2MnQoeXKzD7O4WFbL55hhyGgfWTHwZ457iN9SgYi1JLPqWkZB0JRXIEtjd4JEQcx
 +8Umfre0Xt4713VxMygW0PnQt5aSQdMD58jHFxTk092mU+yIHj5LeYgvwSgZN4airXk5yRXl
 SE+xAvmumFBY
Organization: Red Hat GmbH
Message-ID: <35894e57-0429-77a2-a61b-0beb4a285ccb@redhat.com>
Date:   Wed, 5 Dec 2018 11:42:11 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.1
MIME-Version: 1.0
In-Reply-To: <20181204111507.4808-1-osalvador@suse.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.45]); Wed, 05 Dec 2018 10:42:14 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04.12.18 12:15, Oscar Salvador wrote:
> Since commit 03e85f9d5f1 ("mm/page_alloc: Introduce free_area_init_core_hotplug"),
> some functions changed to only be called during system initialization.
> In concret, free_area_init_node and and the functions that hang from it.
> 
> Also, some variables are no longer used after the system has gone
> through initialization.
> So this could be considered as a late clean-up for that patch.
> 
> This patch changes the functions from __meminit to __init, and
> the variables from __meminitdata to __initdata.
> 
> In return, we get some KBs back:
> 
> Before:
> Freeing unused kernel image memory: 2472K
> 
> After:
> Freeing unused kernel image memory: 2480K
> 
> Signed-off-by: Oscar Salvador <osalvador@suse.de>
> ---
>  mm/page_alloc.c | 28 ++++++++++++++--------------
>  1 file changed, 14 insertions(+), 14 deletions(-)
> 
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index fee5e9bad0dd..94e16eba162c 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -266,18 +266,18 @@ int watermark_boost_factor __read_mostly = 15000;
>  int watermark_scale_factor = 10;
>  int fragment_stall_order __read_mostly = (PAGE_ALLOC_COSTLY_ORDER + 1);
>  
> -static unsigned long nr_kernel_pages __meminitdata;
> -static unsigned long nr_all_pages __meminitdata;
> -static unsigned long dma_reserve __meminitdata;
> +static unsigned long nr_kernel_pages __initdata;
> +static unsigned long nr_all_pages __initdata;
> +static unsigned long dma_reserve __initdata;
>  
>  #ifdef CONFIG_HAVE_MEMBLOCK_NODE_MAP
> -static unsigned long arch_zone_lowest_possible_pfn[MAX_NR_ZONES] __meminitdata;
> -static unsigned long arch_zone_highest_possible_pfn[MAX_NR_ZONES] __meminitdata;
> +static unsigned long arch_zone_lowest_possible_pfn[MAX_NR_ZONES] __initdata;
> +static unsigned long arch_zone_highest_possible_pfn[MAX_NR_ZONES] __initdata;
>  static unsigned long required_kernelcore __initdata;
>  static unsigned long required_kernelcore_percent __initdata;
>  static unsigned long required_movablecore __initdata;
>  static unsigned long required_movablecore_percent __initdata;
> -static unsigned long zone_movable_pfn[MAX_NUMNODES] __meminitdata;
> +static unsigned long zone_movable_pfn[MAX_NUMNODES] __initdata;
>  static bool mirrored_kernelcore __meminitdata;
>  
>  /* movable_zone is the "real" zone pages in ZONE_MOVABLE are taken from */
> @@ -6211,7 +6211,7 @@ void __init sparse_memory_present_with_active_regions(int nid)
>   * with no available memory, a warning is printed and the start and end
>   * PFNs will be 0.
>   */
> -void __meminit get_pfn_range_for_nid(unsigned int nid,
> +void __init get_pfn_range_for_nid(unsigned int nid,
>  			unsigned long *start_pfn, unsigned long *end_pfn)
>  {
>  	unsigned long this_start_pfn, this_end_pfn;
> @@ -6260,7 +6260,7 @@ static void __init find_usable_zone_for_movable(void)
>   * highest usable zone for ZONE_MOVABLE. This preserves the assumption that
>   * zones within a node are in order of monotonic increases memory addresses
>   */
> -static void __meminit adjust_zone_range_for_zone_movable(int nid,
> +static void __init adjust_zone_range_for_zone_movable(int nid,
>  					unsigned long zone_type,
>  					unsigned long node_start_pfn,
>  					unsigned long node_end_pfn,
> @@ -6291,7 +6291,7 @@ static void __meminit adjust_zone_range_for_zone_movable(int nid,
>   * Return the number of pages a zone spans in a node, including holes
>   * present_pages = zone_spanned_pages_in_node() - zone_absent_pages_in_node()
>   */
> -static unsigned long __meminit zone_spanned_pages_in_node(int nid,
> +static unsigned long __init zone_spanned_pages_in_node(int nid,
>  					unsigned long zone_type,
>  					unsigned long node_start_pfn,
>  					unsigned long node_end_pfn,
> @@ -6326,7 +6326,7 @@ static unsigned long __meminit zone_spanned_pages_in_node(int nid,
>   * Return the number of holes in a range on a node. If nid is MAX_NUMNODES,
>   * then all holes in the requested range will be accounted for.
>   */
> -unsigned long __meminit __absent_pages_in_range(int nid,
> +unsigned long __init __absent_pages_in_range(int nid,
>  				unsigned long range_start_pfn,
>  				unsigned long range_end_pfn)
>  {
> @@ -6356,7 +6356,7 @@ unsigned long __init absent_pages_in_range(unsigned long start_pfn,
>  }
>  
>  /* Return the number of page frames in holes in a zone on a node */
> -static unsigned long __meminit zone_absent_pages_in_node(int nid,
> +static unsigned long __init zone_absent_pages_in_node(int nid,
>  					unsigned long zone_type,
>  					unsigned long node_start_pfn,
>  					unsigned long node_end_pfn,
> @@ -6408,7 +6408,7 @@ static unsigned long __meminit zone_absent_pages_in_node(int nid,
>  }
>  
>  #else /* CONFIG_HAVE_MEMBLOCK_NODE_MAP */
> -static inline unsigned long __meminit zone_spanned_pages_in_node(int nid,
> +static inline unsigned long __init zone_spanned_pages_in_node(int nid,
>  					unsigned long zone_type,
>  					unsigned long node_start_pfn,
>  					unsigned long node_end_pfn,
> @@ -6427,7 +6427,7 @@ static inline unsigned long __meminit zone_spanned_pages_in_node(int nid,
>  	return zones_size[zone_type];
>  }
>  
> -static inline unsigned long __meminit zone_absent_pages_in_node(int nid,
> +static inline unsigned long __init zone_absent_pages_in_node(int nid,
>  						unsigned long zone_type,
>  						unsigned long node_start_pfn,
>  						unsigned long node_end_pfn,
> @@ -6441,7 +6441,7 @@ static inline unsigned long __meminit zone_absent_pages_in_node(int nid,
>  
>  #endif /* CONFIG_HAVE_MEMBLOCK_NODE_MAP */
>  
> -static void __meminit calculate_node_totalpages(struct pglist_data *pgdat,
> +static void __init calculate_node_totalpages(struct pglist_data *pgdat,
>  						unsigned long node_start_pfn,
>  						unsigned long node_end_pfn,
>  						unsigned long *zones_size,
> 

I am in general a friend of fixing up parameter alignment.

Apart from that, looks good to me.

-- 

Thanks,

David / dhildenb
