Return-Path: <SRS0=drEb=P7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F71DC282C0
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 17:41:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3FD8F21019
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 17:41:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="tRvESJVn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726849AbfAWRlu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Jan 2019 12:41:50 -0500
Received: from aserp2130.oracle.com ([141.146.126.79]:54480 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726038AbfAWRlt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Jan 2019 12:41:49 -0500
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.22/8.16.0.22) with SMTP id x0NHcf5V043881;
        Wed, 23 Jan 2019 17:41:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2018-07-02;
 bh=nwmrmVOztEACK777VxrEoO+sf1iUM1uzCh4D9/ju1rk=;
 b=tRvESJVnuCeuRfdVP88SGC6xPFVyLW2dKCCICnLtn0ytdKIFFLakKkDkt1z5AikwfSoU
 GRXEmotAzECfRYFdladZltF9jgWeze0brSLqGe4bqA5IjPG5MD8NZ6UeeQB7mGZrOjE2
 lNDpgBBOJcakD5C2MGoIlUUI60c65DTlCyTkX5O78zzrkPMJtw3PxottOB8N1K+RsfAt
 P9nlF0yk9gl8w2LEINxFXNPLPWhFC5WAgH9hSXCCj9UdhNELhUZOatS9vVA+n3z/SEgY
 nU3D98wkSwU/28pM38LybJal/n24OkkqDyVwHx9UDcFBO/ie20zyDXtGc+cp5YCgPBbj og== 
Received: from aserv0022.oracle.com (aserv0022.oracle.com [141.146.126.234])
        by aserp2130.oracle.com with ESMTP id 2q3sdekjch-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 23 Jan 2019 17:41:44 +0000
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserv0022.oracle.com (8.14.4/8.14.4) with ESMTP id x0NHfijh004204
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 23 Jan 2019 17:41:44 GMT
Received: from abhmp0016.oracle.com (abhmp0016.oracle.com [141.146.116.22])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x0NHfh4W019028;
        Wed, 23 Jan 2019 17:41:43 GMT
Received: from Konrads-MacBook-Pro.local (/75.104.64.133)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 23 Jan 2019 09:41:43 -0800
Date:   Wed, 23 Jan 2019 12:41:18 -0500
From:   Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
To:     KarimAllah Ahmed <karahmed@amazon.de>
Cc:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        pbonzini@redhat.com, rkrcmar@redhat.com
Subject: Re: [PATCH v5 04/13] KVM: Introduce a new guest mapping API
Message-ID: <20190123174047.GI19289@Konrads-MacBook-Pro.local>
References: <1547026933-31226-1-git-send-email-karahmed@amazon.de>
 <1547026933-31226-5-git-send-email-karahmed@amazon.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1547026933-31226-5-git-send-email-karahmed@amazon.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9145 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1901230130
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 09, 2019 at 10:42:04AM +0100, KarimAllah Ahmed wrote:
> In KVM, specially for nested guests, there is a dominant pattern of:
> 
> 	=> map guest memory -> do_something -> unmap guest memory
> 
> In addition to all this unnecessarily noise in the code due to boiler plate
> code, most of the time the mapping function does not properly handle memory
> that is not backed by "struct page". This new guest mapping API encapsulate
> most of this boiler plate code and also handles guest memory that is not
> backed by "struct page".
> 
> The current implementation of this API is using memremap for memory that is
> not backed by a "struct page" which would lead to a huge slow-down if it
> was used for high-frequency mapping operations. The API does not have any
> effect on current setups where guest memory is backed by a "struct page".
> Further patches are going to also introduce a pfn-cache which would
> significantly improve the performance of the memremap case.
> 
> Signed-off-by: KarimAllah Ahmed <karahmed@amazon.de>
> ---
> v3 -> v4:
> - Update the commit message.
> v1 -> v2:
> - Drop the caching optimization (pbonzini)
> - Use 'hva' instead of 'kaddr' (pbonzini)
> - Return 0/-EINVAL/-EFAULT instead of true/false. -EFAULT will be used for
>   AMD patch (pbonzini)
> - Introduce __kvm_map_gfn which accepts a memory slot and use it (pbonzini)
> - Only clear map->hva instead of memsetting the whole structure.
> - Drop kvm_vcpu_map_valid since it is no longer used.
> - Fix EXPORT_MODULE naming.
> ---
>  include/linux/kvm_host.h |  9 ++++++++
>  virt/kvm/kvm_main.c      | 53 ++++++++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 62 insertions(+)
> 
> diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
> index c38cc5e..8a2f5fa 100644
> --- a/include/linux/kvm_host.h
> +++ b/include/linux/kvm_host.h
> @@ -205,6 +205,13 @@ enum {
>  	READING_SHADOW_PAGE_TABLES,
>  };
>  
> +struct kvm_host_map {
> +	struct page *page;
> +	void *hva;
> +	kvm_pfn_t pfn;
> +	kvm_pfn_t gfn;
> +};
> +
>  /*
>   * Sometimes a large or cross-page mmio needs to be broken up into separate
>   * exits for userspace servicing.
> @@ -710,7 +717,9 @@ struct kvm_memslots *kvm_vcpu_memslots(struct kvm_vcpu *vcpu);
>  struct kvm_memory_slot *kvm_vcpu_gfn_to_memslot(struct kvm_vcpu *vcpu, gfn_t gfn);
>  kvm_pfn_t kvm_vcpu_gfn_to_pfn_atomic(struct kvm_vcpu *vcpu, gfn_t gfn);
>  kvm_pfn_t kvm_vcpu_gfn_to_pfn(struct kvm_vcpu *vcpu, gfn_t gfn);
> +int kvm_vcpu_map(struct kvm_vcpu *vcpu, gpa_t gpa, struct kvm_host_map *map);
>  struct page *kvm_vcpu_gfn_to_page(struct kvm_vcpu *vcpu, gfn_t gfn);
> +void kvm_vcpu_unmap(struct kvm_host_map *map, bool dirty);
>  unsigned long kvm_vcpu_gfn_to_hva(struct kvm_vcpu *vcpu, gfn_t gfn);
>  unsigned long kvm_vcpu_gfn_to_hva_prot(struct kvm_vcpu *vcpu, gfn_t gfn, bool *writable);
>  int kvm_vcpu_read_guest_page(struct kvm_vcpu *vcpu, gfn_t gfn, void *data, int offset,
> diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
> index 1f888a1..4d8f2e3 100644
> --- a/virt/kvm/kvm_main.c
> +++ b/virt/kvm/kvm_main.c
> @@ -1733,6 +1733,59 @@ struct page *gfn_to_page(struct kvm *kvm, gfn_t gfn)
>  }
>  EXPORT_SYMBOL_GPL(gfn_to_page);
>  
> +static int __kvm_map_gfn(struct kvm_memory_slot *slot, gfn_t gfn,
> +			 struct kvm_host_map *map)
> +{
> +	kvm_pfn_t pfn;
> +	void *hva = NULL;
> +	struct page *page = NULL;
> +

Would it make sense to check if 'map' is NULL first? Ditto on the unmap?

Either way:

Reviewed-by: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
