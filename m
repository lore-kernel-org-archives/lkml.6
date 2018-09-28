Return-Path: <SRS0=0/YT=MK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1C9BC43382
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 08:45:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7AA2B2173D
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 08:45:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="p2bIGemU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7AA2B2173D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729342AbeI1PIX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Sep 2018 11:08:23 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:43648 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728672AbeI1PIX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Sep 2018 11:08:23 -0400
Received: by mail-pf1-f193.google.com with SMTP id j26-v6so3832869pfi.10;
        Fri, 28 Sep 2018 01:45:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=xwNgUaYy+QCCgXTgkFjXs0nDNjiCXfkgBMbj7Mi4zHw=;
        b=p2bIGemUi431bAM/itA01zZc9CMmZXJreo19hoVxNCalb8Pszp0TwVejWJrbYZ2ezN
         BLvRvUeIru7iah8mui1wMQoK4gwCCP2/JyRAODmbEif4SBeJS5EsARsrSX/acqsyz1mK
         FO6OQm6LFiG1zurqRtmCv/kTd3w0Wv/5Mj4aKQFxQj+w27aTYTn1cwsZjbqT1gtMAK9R
         n9C0dt60E7zGRQzbqfqfM7tqzs4NDuWI2q5s9Id/g3+2/8YS7MwynQiR79it2IopfHfN
         5tkPYOp5nC56hvh7fF7GY83KGlThxH9K2/oCOPODrLWxAIGZGP89j7k3RREqgOfzh4as
         7vWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=xwNgUaYy+QCCgXTgkFjXs0nDNjiCXfkgBMbj7Mi4zHw=;
        b=XCRuMlPZ7XttR10eqEZ6mlpRvObququklJJABsZK3DeaxB8bcWApw5AUG0IW8C73lE
         NFepySiF0xugmKVm+RFS5TxJayL13sLr6Kw9bsrMc4OuIyLJI8VBhVPfMPEkbFwZHLB/
         8bswJlYKSTqXItnOv7g4vv83FRZamdx+fWF7/xo582Y7lLvNFRCR26/Roj3LcTKOWsTF
         xhJUdWtkblgpWjkxXQkGjoYD9cEVXVUtbbgvGDUuCVA6mUz47My+tbfTqCKFoH3PeUyQ
         xEPvj/IUahSyOj7aBCsssmdMEKCpRNs3esYh7wAjy4BIWDtUaN9rG8kEs97bceEZiDIu
         sKNA==
X-Gm-Message-State: ABuFfogB5NVnfG7NZsUOyjdU8HuQlo0Vv8bZjBYl4BejqYHmM3Ve3pEy
        4eIN2WFf0BhltF/XWSNvvl4=
X-Google-Smtp-Source: ACcGV615mvVRy+cn3v0w+b8u1gVlQA3YIHgwhgxs2GQB6JLwCuAEo+OLSNsfJgoTTTyVxPPBGAPKpA==
X-Received: by 2002:a62:6d02:: with SMTP id i2-v6mr15916833pfc.218.1538124340231;
        Fri, 28 Sep 2018 01:45:40 -0700 (PDT)
Received: from ast-mbp.dhcp.thefacebook.com ([2620:10d:c090:180::1:5ff1])
        by smtp.gmail.com with ESMTPSA id k77-v6sm7291537pfg.1.2018.09.28.01.45.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 28 Sep 2018 01:45:39 -0700 (PDT)
Date:   Fri, 28 Sep 2018 10:45:31 +0200
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     Roman Gushchin <guro@fb.com>
Cc:     netdev@vger.kernel.org, Song Liu <songliubraving@fb.com>,
        linux-kernel@vger.kernel.org, kernel-team@fb.com,
        Daniel Borkmann <daniel@iogearbox.net>,
        Alexei Starovoitov <ast@kernel.org>
Subject: Re: [PATCH v3 bpf-next 03/10] bpf: introduce per-cpu cgroup local
 storage
Message-ID: <20180928084528.i5txkac34pmqvs3p@ast-mbp.dhcp.thefacebook.com>
References: <20180926113326.29069-1-guro@fb.com>
 <20180926113326.29069-4-guro@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180926113326.29069-4-guro@fb.com>
User-Agent: NeoMutt/20180223
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 26, 2018 at 12:33:19PM +0100, Roman Gushchin wrote:
> This commit introduced per-cpu cgroup local storage.
> 
> Per-cpu cgroup local storage is very similar to simple cgroup storage
> (let's call it shared), except all the data is per-cpu.
> 
> The main goal of per-cpu variant is to implement super fast
> counters (e.g. packet counters), which don't require neither
> lookups, neither atomic operations.
> 
> From userspace's point of view, accessing a per-cpu cgroup storage
> is similar to other per-cpu map types (e.g. per-cpu hashmaps and
> arrays).
> 
> Writing to a per-cpu cgroup storage is not atomic, but is performed
> by copying longs, so some minimal atomicity is here, exactly
> as with other per-cpu maps.
> 
> Signed-off-by: Roman Gushchin <guro@fb.com>
> Cc: Daniel Borkmann <daniel@iogearbox.net>
> Cc: Alexei Starovoitov <ast@kernel.org>
> ---
>  include/linux/bpf-cgroup.h |  20 ++++-
>  include/linux/bpf.h        |   1 +
>  include/linux/bpf_types.h  |   1 +
>  include/uapi/linux/bpf.h   |   1 +
>  kernel/bpf/helpers.c       |   8 +-
>  kernel/bpf/local_storage.c | 148 ++++++++++++++++++++++++++++++++-----
>  kernel/bpf/syscall.c       |  11 ++-
>  kernel/bpf/verifier.c      |  15 +++-
>  8 files changed, 177 insertions(+), 28 deletions(-)
> 
> diff --git a/include/linux/bpf-cgroup.h b/include/linux/bpf-cgroup.h
> index 7e0c9a1d48b7..588dd5f0bd85 100644
> --- a/include/linux/bpf-cgroup.h
> +++ b/include/linux/bpf-cgroup.h
> @@ -37,7 +37,10 @@ struct bpf_storage_buffer {
>  };
>  
>  struct bpf_cgroup_storage {
> -	struct bpf_storage_buffer *buf;
> +	union {
> +		struct bpf_storage_buffer *buf;
> +		void __percpu *percpu_buf;
> +	};
>  	struct bpf_cgroup_storage_map *map;
>  	struct bpf_cgroup_storage_key key;
>  	struct list_head list;
> @@ -109,6 +112,9 @@ int __cgroup_bpf_check_dev_permission(short dev_type, u32 major, u32 minor,
>  static inline enum bpf_cgroup_storage_type cgroup_storage_type(
>  	struct bpf_map *map)
>  {
> +	if (map->map_type == BPF_MAP_TYPE_PERCPU_CGROUP_STORAGE)
> +		return BPF_CGROUP_STORAGE_PERCPU;
> +
>  	return BPF_CGROUP_STORAGE_SHARED;
>  }
>  
> @@ -131,6 +137,10 @@ void bpf_cgroup_storage_unlink(struct bpf_cgroup_storage *storage);
>  int bpf_cgroup_storage_assign(struct bpf_prog *prog, struct bpf_map *map);
>  void bpf_cgroup_storage_release(struct bpf_prog *prog, struct bpf_map *map);
>  
> +int bpf_percpu_cgroup_storage_copy(struct bpf_map *map, void *key, void *value);
> +int bpf_percpu_cgroup_storage_update(struct bpf_map *map, void *key,
> +				     void *value, u64 flags);
> +
>  /* Wrappers for __cgroup_bpf_run_filter_skb() guarded by cgroup_bpf_enabled. */
>  #define BPF_CGROUP_RUN_PROG_INET_INGRESS(sk, skb)			      \
>  ({									      \
> @@ -285,6 +295,14 @@ static inline struct bpf_cgroup_storage *bpf_cgroup_storage_alloc(
>  	struct bpf_prog *prog, enum bpf_cgroup_storage_type stype) { return 0; }
>  static inline void bpf_cgroup_storage_free(
>  	struct bpf_cgroup_storage *storage) {}
> +static inline int bpf_percpu_cgroup_storage_copy(struct bpf_map *map, void *key,
> +						 void *value) {
> +	return 0;
> +}
> +static inline int bpf_percpu_cgroup_storage_update(struct bpf_map *map,
> +					void *key, void *value, u64 flags) {
> +	return 0;
> +}
>  
>  #define cgroup_bpf_enabled (0)
>  #define BPF_CGROUP_PRE_CONNECT_ENABLED(sk) (0)
> diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> index b457fbe7b70b..018299a595c8 100644
> --- a/include/linux/bpf.h
> +++ b/include/linux/bpf.h
> @@ -274,6 +274,7 @@ struct bpf_prog_offload {
>  
>  enum bpf_cgroup_storage_type {
>  	BPF_CGROUP_STORAGE_SHARED,
> +	BPF_CGROUP_STORAGE_PERCPU,
>  	__BPF_CGROUP_STORAGE_MAX
>  };
>  
> diff --git a/include/linux/bpf_types.h b/include/linux/bpf_types.h
> index c9bd6fb765b0..5432f4c9f50e 100644
> --- a/include/linux/bpf_types.h
> +++ b/include/linux/bpf_types.h
> @@ -43,6 +43,7 @@ BPF_MAP_TYPE(BPF_MAP_TYPE_CGROUP_ARRAY, cgroup_array_map_ops)
>  #endif
>  #ifdef CONFIG_CGROUP_BPF
>  BPF_MAP_TYPE(BPF_MAP_TYPE_CGROUP_STORAGE, cgroup_storage_map_ops)
> +BPF_MAP_TYPE(BPF_MAP_TYPE_PERCPU_CGROUP_STORAGE, cgroup_storage_map_ops)
>  #endif
>  BPF_MAP_TYPE(BPF_MAP_TYPE_HASH, htab_map_ops)
>  BPF_MAP_TYPE(BPF_MAP_TYPE_PERCPU_HASH, htab_percpu_map_ops)
> diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
> index aa5ccd2385ed..e2070d819e04 100644
> --- a/include/uapi/linux/bpf.h
> +++ b/include/uapi/linux/bpf.h
> @@ -127,6 +127,7 @@ enum bpf_map_type {
>  	BPF_MAP_TYPE_SOCKHASH,
>  	BPF_MAP_TYPE_CGROUP_STORAGE,
>  	BPF_MAP_TYPE_REUSEPORT_SOCKARRAY,
> +	BPF_MAP_TYPE_PERCPU_CGROUP_STORAGE,
>  };
>  
>  enum bpf_prog_type {
> diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
> index e42f8789b7ea..6502115e8f55 100644
> --- a/kernel/bpf/helpers.c
> +++ b/kernel/bpf/helpers.c
> @@ -206,10 +206,16 @@ BPF_CALL_2(bpf_get_local_storage, struct bpf_map *, map, u64, flags)
>  	 */
>  	enum bpf_cgroup_storage_type stype = cgroup_storage_type(map);
>  	struct bpf_cgroup_storage *storage;
> +	void *ptr;
>  
>  	storage = this_cpu_read(bpf_cgroup_storage[stype]);
>  
> -	return (unsigned long)&READ_ONCE(storage->buf)->data[0];
> +	if (stype == BPF_CGROUP_STORAGE_SHARED)
> +		ptr = &READ_ONCE(storage->buf)->data[0];
> +	else
> +		ptr = this_cpu_ptr(storage->percpu_buf);
> +
> +	return (unsigned long)ptr;
>  }
>  
>  const struct bpf_func_proto bpf_get_local_storage_proto = {
> diff --git a/kernel/bpf/local_storage.c b/kernel/bpf/local_storage.c
> index 6742292fb39e..c739f6dcc3c2 100644
> --- a/kernel/bpf/local_storage.c
> +++ b/kernel/bpf/local_storage.c
> @@ -152,6 +152,71 @@ static int cgroup_storage_update_elem(struct bpf_map *map, void *_key,
>  	return 0;
>  }
>  
> +int bpf_percpu_cgroup_storage_copy(struct bpf_map *_map, void *_key,
> +				   void *value)
> +{
> +	struct bpf_cgroup_storage_map *map = map_to_storage(_map);
> +	struct bpf_cgroup_storage_key *key = _key;
> +	struct bpf_cgroup_storage *storage;
> +	int cpu, off = 0;
> +	u32 size;
> +
> +	rcu_read_lock();
> +	storage = cgroup_storage_lookup(map, key, false);
> +	if (!storage) {
> +		rcu_read_unlock();
> +		return -ENOENT;
> +	}
> +
> +	/* per_cpu areas are zero-filled and bpf programs can only
> +	 * access 'value_size' of them, so copying rounded areas
> +	 * will not leak any kernel data
> +	 */
> +	size = round_up(_map->value_size, 8);
> +	for_each_possible_cpu(cpu) {
> +		bpf_long_memcpy(value + off,
> +				per_cpu_ptr(storage->percpu_buf, cpu), size);
> +		off += size;
> +	}
> +	rcu_read_unlock();
> +	return 0;
> +}
> +
> +int bpf_percpu_cgroup_storage_update(struct bpf_map *_map, void *_key,
> +				     void *value, u64 map_flags)
> +{
> +	struct bpf_cgroup_storage_map *map = map_to_storage(_map);
> +	struct bpf_cgroup_storage_key *key = _key;
> +	struct bpf_cgroup_storage *storage;
> +	int cpu, off = 0;
> +	u32 size;
> +
> +	if (unlikely(map_flags & BPF_EXIST))
> +		return -EINVAL;

that should have been BPF_NOEXIST ?

> +
> +	rcu_read_lock();
> +	storage = cgroup_storage_lookup(map, key, false);
> +	if (!storage) {
> +		rcu_read_unlock();
> +		return -ENOENT;
> +	}
> +
> +	/* the user space will provide round_up(value_size, 8) bytes that
> +	 * will be copied into per-cpu area. bpf programs can only access
> +	 * value_size of it. During lookup the same extra bytes will be
> +	 * returned or zeros which were zero-filled by percpu_alloc,
> +	 * so no kernel data leaks possible
> +	 */
> +	size = round_up(_map->value_size, 8);
> +	for_each_possible_cpu(cpu) {
> +		bpf_long_memcpy(per_cpu_ptr(storage->percpu_buf, cpu),
> +				value + off, size);
> +		off += size;
> +	}
> +	rcu_read_unlock();

storage_update and storage_copy look essentially the same
with the only difference that src/dst swap.
Would it be possible to combine them ?
Not sure whether #define template would look better.

> +	return 0;
> +}
> +
>  static int cgroup_storage_get_next_key(struct bpf_map *_map, void *_key,
>  				       void *_next_key)
>  {
> @@ -292,55 +357,98 @@ struct bpf_cgroup_storage *bpf_cgroup_storage_alloc(struct bpf_prog *prog,
>  {
>  	struct bpf_cgroup_storage *storage;
>  	struct bpf_map *map;
> +	gfp_t flags;
> +	size_t size;
>  	u32 pages;
>  
>  	map = prog->aux->cgroup_storage[stype];
>  	if (!map)
>  		return NULL;
>  
> -	pages = round_up(sizeof(struct bpf_cgroup_storage) +
> -			 sizeof(struct bpf_storage_buffer) +
> -			 map->value_size, PAGE_SIZE) >> PAGE_SHIFT;
> +	if (stype == BPF_CGROUP_STORAGE_SHARED) {
> +		size = sizeof(struct bpf_storage_buffer) + map->value_size;
> +		pages = round_up(sizeof(struct bpf_cgroup_storage) + size,
> +				 PAGE_SIZE) >> PAGE_SHIFT;
> +	} else {
> +		size = map->value_size;
> +		pages = round_up(round_up(size, 8) * num_possible_cpus(),
> +				 PAGE_SIZE) >> PAGE_SHIFT;
> +	}
> +
>  	if (bpf_map_charge_memlock(map, pages))
>  		return ERR_PTR(-EPERM);
>  
>  	storage = kmalloc_node(sizeof(struct bpf_cgroup_storage),
>  			       __GFP_ZERO | GFP_USER, map->numa_node);
> -	if (!storage) {
> -		bpf_map_uncharge_memlock(map, pages);
> -		return ERR_PTR(-ENOMEM);
> -	}
> +	if (!storage)
> +		goto enomem;
>  
> -	storage->buf = kmalloc_node(sizeof(struct bpf_storage_buffer) +
> -				    map->value_size, __GFP_ZERO | GFP_USER,
> -				    map->numa_node);
> -	if (!storage->buf) {
> -		bpf_map_uncharge_memlock(map, pages);
> -		kfree(storage);
> -		return ERR_PTR(-ENOMEM);
> +	flags = __GFP_ZERO | GFP_USER;
> +
> +	if (stype == BPF_CGROUP_STORAGE_SHARED) {
> +		storage->buf = kmalloc_node(size, flags, map->numa_node);
> +		if (!storage->buf)
> +			goto enomem;
> +	} else {
> +		storage->percpu_buf = __alloc_percpu_gfp(size, 8, flags);
> +		if (!storage->percpu_buf)
> +			goto enomem;
>  	}
>  
>  	storage->map = (struct bpf_cgroup_storage_map *)map;
>  
>  	return storage;
> +
> +enomem:
> +	bpf_map_uncharge_memlock(map, pages);
> +	kfree(storage);
> +	return ERR_PTR(-ENOMEM);
> +}
> +
> +static void free_shared_cgroup_storage_rcu(struct rcu_head *rcu)
> +{
> +	struct bpf_cgroup_storage *storage =
> +		container_of(rcu, struct bpf_cgroup_storage, rcu);
> +
> +	kfree(storage->buf);
> +	kfree(storage);
> +}
> +
> +static void free_percpu_cgroup_storage_rcu(struct rcu_head *rcu)
> +{
> +	struct bpf_cgroup_storage *storage =
> +		container_of(rcu, struct bpf_cgroup_storage, rcu);
> +
> +	free_percpu(storage->percpu_buf);
> +	kfree(storage);
>  }
>  
>  void bpf_cgroup_storage_free(struct bpf_cgroup_storage *storage)
>  {
> -	u32 pages;
> +	enum bpf_cgroup_storage_type stype;
>  	struct bpf_map *map;
> +	u32 pages;
>  
>  	if (!storage)
>  		return;
>  
>  	map = &storage->map->map;
> -	pages = round_up(sizeof(struct bpf_cgroup_storage) +
> -			 sizeof(struct bpf_storage_buffer) +
> -			 map->value_size, PAGE_SIZE) >> PAGE_SHIFT;
> +	stype = cgroup_storage_type(map);
> +	if (stype == BPF_CGROUP_STORAGE_SHARED)
> +		pages = round_up(sizeof(struct bpf_cgroup_storage) +
> +				 sizeof(struct bpf_storage_buffer) +
> +				 map->value_size, PAGE_SIZE) >> PAGE_SHIFT;
> +	else
> +		pages = round_up(round_up(map->value_size, 8) *
> +				 num_possible_cpus(),
> +				 PAGE_SIZE) >> PAGE_SHIFT;

storage_alloc and storage_free have subttly different math here.
Please combine them into single helper that computes the number of pages.
In the current form it's hard to tell that the math is actually the same.

