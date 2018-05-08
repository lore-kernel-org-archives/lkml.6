Return-Path: <linux-arch-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2590916-1525773016-2-10027529460259715410
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-charsets: plain='utf-8'
X-Resolved-to: linux@kroah.com
X-Delivered-to: linux@kroah.com
X-Mail-from: linux-arch-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1525773016; b=mwNywdwReN0LVpATOWERM/6s0ipQE16tO1ouU7F6ch9uw3tjVD
    w8UBRHVWymadYf6ulogZP/+ZgXj+eYK5V1xa03R9Y6OekZE9IroCvuGG8cpaz+iN
    cPK+sQx9sOgZRlUBtM2X1zyQ9gqlt0D+TMUeayJArWSHWCw6839mTOJtMJFhuD4q
    uTty1jmSwq0sTA6FK9H42ueJN/b1eE18J4489930+rjFI75VR4eoQjLnY4xiXc/9
    bw3D4d1RanFBmcQxP7lJom5+H6GwT8C4mRLNA7DEGF89Pdke44wswaKa4bvt0heS
    8asUFQlTlk/IpiOkuq5dEX6vCugjmO54zrtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=subject:to:cc:references:from:message-id
    :date:mime-version:in-reply-to:content-type
    :content-transfer-encoding:sender:list-id; s=fm2; t=1525773016;
    bh=bxpwrFDs2wT3qXUWh83hT2kDe+RJ+JCsaobsPAWSfpw=; b=ej6rPbhvhNsi
    3uWZHYAs4lM6V0feSOg42xiTmVGR0ApuueXeMin95sfanl8fE75VacBZ476N2iOj
    XfU+g95+WAk3SUnBKBRAp1ApjRLqUOxm2xuhVD64UC1Q+3n2iMwuY/ajEj72Q9lz
    8Xe+3KDDyWup/0CzjgRNJBYJD2ATV5hrxcR3K/qx2RNbNNbLay/5Q7DLFVYNsPpI
    UvhRAN+8vm5EjbQeVxShBMXy012ExJZWkBh8a+ifhDYD5o434QukmQ8pOaoPtSOs
    L3Agxc6YYS/CBLP/mKkqdWVBXnrhi4ggJeMyiIPGzUMBelhQkZp6KmjrU6BG2zD1
    vx8jM82pvA==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=arm.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-arch-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=arm.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=arm.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-arch-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=arm.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfHapVZO8n9F3q95ilu6VQvcSQ+7lDgcxuizV9jHO/d8HHCHZkxg/oUT7DEriUuKBtDqJpf8okbKeAs67aQHP/O+Piv2lrX0hk4Yo/AAhEuauNGeehO4C
    Z28JrQ92zrOClvOCKWyeCUdAHlBaZlNnNCR0EOXAxRVwHFfw870oauh+bd5EiZc5+pXxbnjHqUPkt451tcSFzMuR6T+o418gn3AH3XvJcknWuqbXBWpthpl6
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=VUJBJC2UJ8kA:10
    a=7CQSdrXTAAAA:8 a=1vKIvyqXOD9gt3GkSekA:9 a=S-sYJPeHnEmMzYR0:21
    a=HizSdXcWkUOcpaL6:21 a=QEXdDO2ut3YA:10 a=a-qgeE7W1pNrGK8U0ZQC:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754598AbeEHJuM (ORCPT <rfc822;linux@kroah.com>);
        Tue, 8 May 2018 05:50:12 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:55120 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754763AbeEHJuL (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 8 May 2018 05:50:11 -0400
Subject: Re: [PATCH 2/3] dma-debug: simplify counting of preallocated requests
To: Christoph Hellwig <hch@lst.de>, iommu@lists.linux-foundation.org
Cc: linux-arch@vger.kernel.org, linux-xtensa@linux-xtensa.org,
        Michal Simek <monstr@monstr.eu>,
        Vincent Chen <deanbo422@gmail.com>,
        linux-c6x-dev@linux-c6x.org, linux-parisc@vger.kernel.org,
        linux-sh@vger.kernel.org, linux-hexagon@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-m68k@lists.linux-m68k.org,
        openrisc@lists.librecores.org, Greentime Hu <green.hu@gmail.com>,
        linux-alpha@vger.kernel.org, sparclinux@vger.kernel.org,
        nios2-dev@lists.rocketboards.org,
        linux-snps-arc@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org
References: <20180424140235.9125-1-hch@lst.de>
 <20180424140235.9125-3-hch@lst.de>
From: Robin Murphy <robin.murphy@arm.com>
Message-ID: <b50ef15a-8ffb-e8f2-11a7-b38d2ebda1c6@arm.com>
Date: Tue, 8 May 2018 10:50:06 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180424140235.9125-3-hch@lst.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
X-Mailing-List: linux-arch@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 24/04/18 15:02, Christoph Hellwig wrote:
> Just keep a single variable with a descriptive name instead of two
> with confusing names.

Reviewed-by: Robin Murphy <robin.murphy@arm.com>

> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>   lib/dma-debug.c | 20 ++++----------------
>   1 file changed, 4 insertions(+), 16 deletions(-)
> 
> diff --git a/lib/dma-debug.c b/lib/dma-debug.c
> index 712a897174e4..075253cb613b 100644
> --- a/lib/dma-debug.c
> +++ b/lib/dma-debug.c
> @@ -132,7 +132,7 @@ static u32 min_free_entries;
>   static u32 nr_total_entries;
>   
>   /* number of preallocated entries requested by kernel cmdline */
> -static u32 req_entries;
> +static u32 nr_prealloc_entries = PREALLOC_DMA_DEBUG_ENTRIES;
>   
>   /* debugfs dentry's for the stuff above */
>   static struct dentry *dma_debug_dent        __read_mostly;
> @@ -1011,7 +1011,6 @@ void dma_debug_add_bus(struct bus_type *bus)
>   
>   static int dma_debug_init(void)
>   {
> -	u32 num_entries;
>   	int i;
>   
>   	/* Do not use dma_debug_initialized here, since we really want to be
> @@ -1032,12 +1031,7 @@ static int dma_debug_init(void)
>   		return 0;
>   	}
>   
> -	if (req_entries)
> -		num_entries = req_entries;
> -	else
> -		num_entries = PREALLOC_DMA_DEBUG_ENTRIES;
> -
> -	if (prealloc_memory(num_entries) != 0) {
> +	if (prealloc_memory(nr_prealloc_entries) != 0) {
>   		pr_err("DMA-API: debugging out of memory error - disabled\n");
>   		global_disable = true;
>   
> @@ -1068,16 +1062,10 @@ static __init int dma_debug_cmdline(char *str)
>   
>   static __init int dma_debug_entries_cmdline(char *str)
>   {
> -	int res;
> -
>   	if (!str)
>   		return -EINVAL;
> -
> -	res = get_option(&str, &req_entries);
> -
> -	if (!res)
> -		req_entries = 0;
> -
> +	if (!get_option(&str, &nr_prealloc_entries))
> +		nr_prealloc_entries = PREALLOC_DMA_DEBUG_ENTRIES;
>   	return 0;
>   }
>   
> 
