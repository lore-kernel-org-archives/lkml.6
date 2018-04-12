Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752896AbeDLOdP (ORCPT <rfc822;w@1wt.eu>);
        Thu, 12 Apr 2018 10:33:15 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:40152 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752303AbeDLOdN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Apr 2018 10:33:13 -0400
Subject: Re: [PATCH 04/10] KVM: Introduce a new guest mapping API
To: KarimAllah Ahmed <karahmed@amazon.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc: hpa@zytor.com, jmattson@google.com, mingo@redhat.com,
        rkrcmar@redhat.com, tglx@linutronix.de
References: <1519235241-6500-1-git-send-email-karahmed@amazon.de>
 <1519235241-6500-5-git-send-email-karahmed@amazon.de>
From: Paolo Bonzini <pbonzini@redhat.com>
Openpgp: preference=signencrypt
Autocrypt: addr=pbonzini@redhat.com; prefer-encrypt=mutual; keydata=
 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
Message-ID: <b47f982b-e6fc-905d-ae3b-5a80c12848f2@redhat.com>
Date: Thu, 12 Apr 2018 16:33:08 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <1519235241-6500-5-git-send-email-karahmed@amazon.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Coming back to this (nice) series.

On 21/02/2018 18:47, KarimAllah Ahmed wrote:
> +bool kvm_vcpu_map(struct kvm_vcpu *vcpu, gfn_t gfn, struct kvm_host_map *map)
> +{
> +	kvm_pfn_t pfn;
> +	void *kaddr = NULL;

Can we s/kaddr/hva/ since that's the standard nomenclature?

> +	struct page *page = NULL;
> +
> +	if (map->kaddr && map->gfn == gfn)
> +		/* If the mapping is valid and guest memory is already mapped */
> +		return true;

Please return 0/-EINVAL instead.  More important, this optimization is
problematic because:

1) the underlying memslots array could have changed.  You'd also need to
store the generation count (see kvm_read_guest_cached for an example)

2) worse, the memslots array could have switched between the SMM and
non-SMM address spaces.  This is by the way the reason why there is no
kvm_vcpu_read_guest_cached API.

However, all the places you're changing in patches 4-10 are doing
already kvm_vcpu_gpa_to_page, so I suggest just dropping this optimization.

> +	else if (map->kaddr)
> +		/* If the mapping is valid but trying to map a different guest pfn */
> +		kvm_vcpu_unmap(map);
> +
> +	pfn = kvm_vcpu_gfn_to_pfn(vcpu, gfn);

Please change the API to:

static int __kvm_map_gfn(struct kvm_memslot *memslots, gfn_t gfn,
		         struct kvm_host_map *map)

	calling gfn_to_pfn_memslot(memslots, gfn)

int kvm_vcpu_map_gfn(struct kvm_vcpu *vcpu gfn_t gfn,
		     struct kvm_host_map *map)

	calling kvm_vcpu_gfn_to_memslot + __kvm_map

void kvm_unmap_gfn(struct kvm_host_map *map)


> +	if (is_error_pfn(pfn))
> +		return false;

Should this be is_error_noslot_pfn?

> +	if (pfn_valid(pfn)) {
> +		page = pfn_to_page(pfn);
> +		kaddr = vmap(&page, 1, VM_MAP, PAGE_KERNEL);
> +	} else {
> +		kaddr = memremap(pfn_to_hpa(pfn), PAGE_SIZE, MEMREMAP_WB);
> +	}
> +
> +	if (!kaddr)
> +		return false;
> +
> +	map->page = page;
> +	map->kaddr = kaddr;
> +	map->pfn = pfn;
> +	map->gfn = gfn;
> +
> +	return true;
> +}

> 
> +void kvm_vcpu_unmap(struct kvm_host_map *map)
> +{
> +	if (!map->kaddr)
> +		return;
> +
> +	if (map->page)
> +		kunmap(map->page);
> +	else
> +		memunmap(map->kaddr);
> +
> +	kvm_release_pfn_dirty(map->pfn);
> +	memset(map, 0, sizeof(*map));

This can clear just map->kaddr (map->hva after the above review).

Thanks,

Paolo

> +}
> +
