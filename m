Return-Path: <SRS0=FvrY=LY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2F3BC4321E
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 18:35:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 064882086A
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 18:35:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 064882086A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728353AbeIJXbC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Sep 2018 19:31:02 -0400
Received: from mga07.intel.com ([134.134.136.100]:35204 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727784AbeIJXbC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Sep 2018 19:31:02 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 10 Sep 2018 11:35:37 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.53,356,1531810800"; 
   d="gz'50?scan'50,208,50";a="82374653"
Received: from bee.sh.intel.com (HELO lkp-server01) ([10.239.97.14])
  by orsmga003.jf.intel.com with ESMTP; 10 Sep 2018 11:31:30 -0700
Received: from kbuild by lkp-server01 with local (Exim 4.89)
        (envelope-from <lkp@intel.com>)
        id 1fzQy9-000AZ9-Sw; Tue, 11 Sep 2018 02:31:29 +0800
Date:   Tue, 11 Sep 2018 02:31:24 +0800
From:   kbuild test robot <lkp@intel.com>
To:     jglisse@redhat.com
Cc:     kbuild-all@01.org, linux-kernel@vger.kernel.org,
        Nicolai =?iso-8859-1?Q?H=E4hnle?= <nicolai.haehnle@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Felix Kuehling <Felix.Kuehling@amd.com>,
        dri-devel@lists.freedesktop.org,
        =?iso-8859-1?B?Suly9G1l?= Glisse <jglisse@redhat.com>,
        amd-gfx@lists.freedesktop.org,
        Alex Deucher <alexander.deucher@amd.com>,
        Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>
Subject: Re: [PATCH 2/2] gpu/radeon: use HMM mirror for userptr buffer object.
Message-ID: <201809110221.9Qqqwzns%fengguang.wu@intel.com>
References: <20180910005753.5860-3-jglisse@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="UugvWAfsgieZRqgk"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180910005753.5860-3-jglisse@redhat.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--UugvWAfsgieZRqgk
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

Hi Jérôme,

I love your patch! Yet something to improve:

[auto build test ERROR on linus/master]
[also build test ERROR on v4.19-rc3 next-20180910]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/jglisse-redhat-com/Getting-rid-of-GUP-and-use-HMM-for-user-ptr-features/20180911-020741
config: x86_64-randconfig-x017-201836 (attached as .config)
compiler: gcc-7 (Debian 7.3.0-1) 7.3.0
reproduce:
        # save the attached .config to linux build tree
        make ARCH=x86_64 

All errors (new ones prefixed by >>):

   drivers/gpu/drm/radeon/radeon_mn.c:43:20: error: field 'mirror' has incomplete type
     struct hmm_mirror mirror;
                       ^~~~~~
   drivers/gpu/drm/radeon/radeon_mn.c: In function 'radeon_mn_destroy':
   drivers/gpu/drm/radeon/radeon_mn.c:90:2: error: implicit declaration of function 'hmm_mirror_unregister'; did you mean 'drm_dp_aux_unregister'? [-Werror=implicit-function-declaration]
     hmm_mirror_unregister(&rmn->mirror);
     ^~~~~~~~~~~~~~~~~~~~~
     drm_dp_aux_unregister
   In file included from include/linux/firmware.h:6:0,
                    from drivers/gpu/drm/radeon/radeon_mn.c:31:
   drivers/gpu/drm/radeon/radeon_mn.c: In function 'radeon_mirror_release':
   include/linux/kernel.h:997:32: error: dereferencing pointer to incomplete type 'struct hmm_mirror'
     BUILD_BUG_ON_MSG(!__same_type(*(ptr), ((type *)0)->member) && \
                                   ^~~~~~
   include/linux/compiler.h:335:18: note: in definition of macro '__compiletime_assert'
      int __cond = !(condition);    \
                     ^~~~~~~~~
   include/linux/compiler.h:358:2: note: in expansion of macro '_compiletime_assert'
     _compiletime_assert(condition, msg, __compiletime_assert_, __LINE__)
     ^~~~~~~~~~~~~~~~~~~
   include/linux/build_bug.h:45:37: note: in expansion of macro 'compiletime_assert'
    #define BUILD_BUG_ON_MSG(cond, msg) compiletime_assert(!(cond), msg)
                                        ^~~~~~~~~~~~~~~~~~
   include/linux/kernel.h:997:2: note: in expansion of macro 'BUILD_BUG_ON_MSG'
     BUILD_BUG_ON_MSG(!__same_type(*(ptr), ((type *)0)->member) && \
     ^~~~~~~~~~~~~~~~
   include/linux/kernel.h:997:20: note: in expansion of macro '__same_type'
     BUILD_BUG_ON_MSG(!__same_type(*(ptr), ((type *)0)->member) && \
                       ^~~~~~~~~~~
   drivers/gpu/drm/radeon/radeon_mn.c:103:26: note: in expansion of macro 'container_of'
     struct radeon_mn *rmn = container_of(mirror, struct radeon_mn, mirror);
                             ^~~~~~~~~~~~
   drivers/gpu/drm/radeon/radeon_mn.c: At top level:
   drivers/gpu/drm/radeon/radeon_mn.c:119:24: warning: 'struct hmm_update' declared inside parameter list will not be visible outside of this definition or declaration
              const struct hmm_update *update)
                           ^~~~~~~~~~
   drivers/gpu/drm/radeon/radeon_mn.c: In function 'radeon_sync_cpu_device_pagetables':
   drivers/gpu/drm/radeon/radeon_mn.c:128:14: error: dereferencing pointer to incomplete type 'const struct hmm_update'
     end = update->end - 1;
                 ^~
   drivers/gpu/drm/radeon/radeon_mn.c: At top level:
   drivers/gpu/drm/radeon/radeon_mn.c:183:21: error: variable 'radeon_mirror_ops' has initializer but incomplete type
    static const struct hmm_mirror_ops radeon_mirror_ops = {
                        ^~~~~~~~~~~~~~
   drivers/gpu/drm/radeon/radeon_mn.c:184:3: error: 'const struct hmm_mirror_ops' has no member named 'sync_cpu_device_pagetables'
     .sync_cpu_device_pagetables = &radeon_sync_cpu_device_pagetables,
      ^~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/gpu/drm/radeon/radeon_mn.c:184:32: warning: excess elements in struct initializer
     .sync_cpu_device_pagetables = &radeon_sync_cpu_device_pagetables,
                                   ^
   drivers/gpu/drm/radeon/radeon_mn.c:184:32: note: (near initialization for 'radeon_mirror_ops')
   drivers/gpu/drm/radeon/radeon_mn.c:185:3: error: 'const struct hmm_mirror_ops' has no member named 'release'
     .release = &radeon_mirror_release,
      ^~~~~~~
   drivers/gpu/drm/radeon/radeon_mn.c:185:13: warning: excess elements in struct initializer
     .release = &radeon_mirror_release,
                ^
   drivers/gpu/drm/radeon/radeon_mn.c:185:13: note: (near initialization for 'radeon_mirror_ops')
   drivers/gpu/drm/radeon/radeon_mn.c: In function 'radeon_mn_get':
   drivers/gpu/drm/radeon/radeon_mn.c:224:6: error: implicit declaration of function 'hmm_mirror_register'; did you mean 'drm_dp_aux_register'? [-Werror=implicit-function-declaration]
     r = hmm_mirror_register(&new->mirror, mm);
         ^~~~~~~~~~~~~~~~~~~
         drm_dp_aux_register
   drivers/gpu/drm/radeon/radeon_mn.c: In function 'radeon_mn_bo_map':
>> drivers/gpu/drm/radeon/radeon_mn.c:373:43: error: 'HMM_PFN_FLAG_MAX' undeclared (first use in this function); did you mean 'TTM_PL_FLAG_VRAM'?
     static const uint64_t radeon_range_flags[HMM_PFN_FLAG_MAX] = {
                                              ^~~~~~~~~~~~~~~~
                                              TTM_PL_FLAG_VRAM
   drivers/gpu/drm/radeon/radeon_mn.c:373:43: note: each undeclared identifier is reported only once for each function it appears in
>> drivers/gpu/drm/radeon/radeon_mn.c:378:44: error: 'HMM_PFN_VALUE_MAX' undeclared (first use in this function); did you mean 'HMM_PFN_FLAG_MAX'?
     static const uint64_t radeon_range_values[HMM_PFN_VALUE_MAX] = {
                                               ^~~~~~~~~~~~~~~~~
                                               HMM_PFN_FLAG_MAX
>> drivers/gpu/drm/radeon/radeon_mn.c:389:19: error: storage size of 'range' isn't known
     struct hmm_range range;
                      ^~~~~
>> drivers/gpu/drm/radeon/radeon_mn.c:421:31: error: 'HMM_PFN_VALID' undeclared (first use in this function); did you mean 'HMM_PFN_VALUE_MAX'?
      range.pfns[i] = range.flags[HMM_PFN_VALID];
                                  ^~~~~~~~~~~~~
                                  HMM_PFN_VALUE_MAX
>> drivers/gpu/drm/radeon/radeon_mn.c:422:40: error: 'HMM_PFN_WRITE' undeclared (first use in this function); did you mean 'HMM_PFN_VALID'?
      range.pfns[i] |= write ? range.flags[HMM_PFN_WRITE] : 0;
                                           ^~~~~~~~~~~~~
                                           HMM_PFN_VALID
>> drivers/gpu/drm/radeon/radeon_mn.c:425:8: error: implicit declaration of function 'hmm_vma_fault'; did you mean 'filemap_fault'? [-Werror=implicit-function-declaration]
     ret = hmm_vma_fault(&range, true);
           ^~~~~~~~~~~~~
           filemap_fault
>> drivers/gpu/drm/radeon/radeon_mn.c:430:23: error: implicit declaration of function 'hmm_pfn_to_page'; did you mean '__pfn_to_page'? [-Werror=implicit-function-declaration]
      struct page *page = hmm_pfn_to_page(&range, range.pfns[i]);
                          ^~~~~~~~~~~~~~~
                          __pfn_to_page
>> drivers/gpu/drm/radeon/radeon_mn.c:446:4: error: implicit declaration of function 'hmm_vma_range_done'; did you mean 'drm_vma_node_size'? [-Werror=implicit-function-declaration]
       hmm_vma_range_done(&range);
       ^~~~~~~~~~~~~~~~~~
       drm_vma_node_size
   drivers/gpu/drm/radeon/radeon_mn.c:389:19: warning: unused variable 'range' [-Wunused-variable]
     struct hmm_range range;
                      ^~~~~
   drivers/gpu/drm/radeon/radeon_mn.c:378:24: warning: unused variable 'radeon_range_values' [-Wunused-variable]
     static const uint64_t radeon_range_values[HMM_PFN_VALUE_MAX] = {
                           ^~~~~~~~~~~~~~~~~~~
   drivers/gpu/drm/radeon/radeon_mn.c:373:24: warning: unused variable 'radeon_range_flags' [-Wunused-variable]
     static const uint64_t radeon_range_flags[HMM_PFN_FLAG_MAX] = {
                           ^~~~~~~~~~~~~~~~~~
   drivers/gpu/drm/radeon/radeon_mn.c: At top level:
   drivers/gpu/drm/radeon/radeon_mn.c:183:36: error: storage size of 'radeon_mirror_ops' isn't known
    static const struct hmm_mirror_ops radeon_mirror_ops = {
                                       ^~~~~~~~~~~~~~~~~
   cc1: some warnings being treated as errors

vim +373 drivers/gpu/drm/radeon/radeon_mn.c

   182	
   183	static const struct hmm_mirror_ops radeon_mirror_ops = {
   184		.sync_cpu_device_pagetables = &radeon_sync_cpu_device_pagetables,
 > 185		.release = &radeon_mirror_release,
   186	};
   187	
   188	/**
   189	 * radeon_mn_get - create notifier context
   190	 *
   191	 * @rdev: radeon device pointer
   192	 *
   193	 * Creates a notifier context for current->mm.
   194	 */
   195	static struct radeon_mn *radeon_mn_get(struct radeon_device *rdev)
   196	{
   197		struct mm_struct *mm = current->mm;
   198		struct radeon_mn *rmn, *new;
   199		int r;
   200	
   201		mutex_lock(&rdev->mn_lock);
   202		hash_for_each_possible(rdev->mn_hash, rmn, node, (unsigned long)mm) {
   203			if (rmn->mm == mm) {
   204				mutex_unlock(&rdev->mn_lock);
   205				return rmn;
   206			}
   207		}
   208		mutex_unlock(&rdev->mn_lock);
   209	
   210		new = kzalloc(sizeof(*rmn), GFP_KERNEL);
   211		if (!new) {
   212			return ERR_PTR(-ENOMEM);
   213		}
   214		new->mm = mm;
   215		new->rdev = rdev;
   216		mutex_init(&new->lock);
   217		new->objects = RB_ROOT_CACHED;
   218		new->mirror.ops = &radeon_mirror_ops;
   219	
   220		if (down_write_killable(&mm->mmap_sem)) {
   221			kfree(new);
   222			return ERR_PTR(-EINTR);
   223		}
   224		r = hmm_mirror_register(&new->mirror, mm);
   225		up_write(&mm->mmap_sem);
   226		if (r) {
   227			kfree(new);
   228			return ERR_PTR(r);
   229		}
   230	
   231		mutex_lock(&rdev->mn_lock);
   232		/* Check again in case some other thread raced with us ... */
   233		hash_for_each_possible(rdev->mn_hash, rmn, node, (unsigned long)mm) {
   234			if (rmn->mm == mm) {
   235				mutex_unlock(&rdev->mn_lock);
   236				hmm_mirror_unregister(&new->mirror);
   237				kfree(new);
   238				return rmn;
   239			}
   240		}
   241		hash_add(rdev->mn_hash, &new->node, (unsigned long)mm);
   242		mutex_unlock(&rdev->mn_lock);
   243	
   244		return new;
   245	}
   246	
   247	/**
   248	 * radeon_mn_register - register a BO for notifier updates
   249	 *
   250	 * @bo: radeon buffer object
   251	 * @addr: userptr addr we should monitor
   252	 *
   253	 * Registers an MMU notifier for the given BO at the specified address.
   254	 * Returns 0 on success, -ERRNO if anything goes wrong.
   255	 */
   256	int radeon_mn_register(struct radeon_bo *bo, unsigned long addr)
   257	{
   258		unsigned long end = addr + radeon_bo_size(bo) - 1;
   259		struct radeon_device *rdev = bo->rdev;
   260		struct radeon_mn *rmn;
   261		struct radeon_mn_node *node = NULL;
   262		struct list_head bos;
   263		struct interval_tree_node *it;
   264	
   265		bo->userptr = addr;
   266		bo->pfns = kvmalloc_array(bo->tbo.num_pages, sizeof(uint64_t),
   267					  GFP_KERNEL | __GFP_ZERO);
   268		if (bo->pfns == NULL)
   269			return -ENOMEM;
   270	
   271		rmn = radeon_mn_get(rdev);
   272		if (IS_ERR(rmn)) {
   273			kvfree(bo->pfns);
   274			bo->pfns = NULL;
   275			return PTR_ERR(rmn);
   276		}
   277	
   278		INIT_LIST_HEAD(&bos);
   279	
   280		mutex_lock(&rmn->lock);
   281	
   282		while ((it = interval_tree_iter_first(&rmn->objects, addr, end))) {
   283			kfree(node);
   284			node = container_of(it, struct radeon_mn_node, it);
   285			interval_tree_remove(&node->it, &rmn->objects);
   286			addr = min(it->start, addr);
   287			end = max(it->last, end);
   288			list_splice(&node->bos, &bos);
   289		}
   290	
   291		if (!node) {
   292			node = kmalloc(sizeof(struct radeon_mn_node), GFP_KERNEL);
   293			if (!node) {
   294				mutex_unlock(&rmn->lock);
   295				kvfree(bo->pfns);
   296				bo->pfns = NULL;
   297				return -ENOMEM;
   298			}
   299		}
   300	
   301		bo->mn = rmn;
   302	
   303		node->it.start = addr;
   304		node->it.last = end;
   305		INIT_LIST_HEAD(&node->bos);
   306		list_splice(&bos, &node->bos);
   307		list_add(&bo->mn_list, &node->bos);
   308	
   309		interval_tree_insert(&node->it, &rmn->objects);
   310	
   311		mutex_unlock(&rmn->lock);
   312	
   313		return 0;
   314	}
   315	
   316	/**
   317	 * radeon_mn_unregister - unregister a BO for notifier updates
   318	 *
   319	 * @bo: radeon buffer object
   320	 *
   321	 * Remove any registration of MMU notifier updates from the buffer object.
   322	 */
   323	void radeon_mn_unregister(struct radeon_bo *bo)
   324	{
   325		struct radeon_device *rdev = bo->rdev;
   326		struct radeon_mn *rmn;
   327		struct list_head *head;
   328	
   329		mutex_lock(&rdev->mn_lock);
   330		rmn = bo->mn;
   331		if (rmn == NULL) {
   332			mutex_unlock(&rdev->mn_lock);
   333			return;
   334		}
   335	
   336		mutex_lock(&rmn->lock);
   337		/* save the next list entry for later */
   338		head = bo->mn_list.next;
   339	
   340		bo->mn = NULL;
   341		list_del(&bo->mn_list);
   342	
   343		if (list_empty(head)) {
   344			struct radeon_mn_node *node;
   345			node = container_of(head, struct radeon_mn_node, bos);
   346			interval_tree_remove(&node->it, &rmn->objects);
   347			kfree(node);
   348		}
   349	
   350		mutex_unlock(&rmn->lock);
   351		mutex_unlock(&rdev->mn_lock);
   352	
   353		kvfree(bo->pfns);
   354		bo->pfns = NULL;
   355	}
   356	
   357	/**
   358	 * radeon_mn_bo_map - map range of virtual address as buffer object
   359	 *
   360	 * @bo: radeon buffer object
   361	 * @ttm: ttm_tt object in which holds mirroring result
   362	 * @write: can GPU write to the range ?
   363	 * Returns: 0 on success, error code otherwise
   364	 *
   365	 * Use HMM to mirror a range of virtual address as a buffer object mapped into
   366	 * GPU address space (thus allowing transparent GPU access to this range). It
   367	 * does not pin pages for range but rely on HMM and underlying synchronizations
   368	 * to make sure that both CPU and GPU points to same physical memory for the
   369	 * range.
   370	 */
   371	int radeon_mn_bo_map(struct radeon_bo *bo, struct ttm_dma_tt *dma, bool write)
   372	{
 > 373		static const uint64_t radeon_range_flags[HMM_PFN_FLAG_MAX] = {
   374			(1 << 0), /* HMM_PFN_VALID */
   375			(1 << 1), /* HMM_PFN_WRITE */
   376			0 /* HMM_PFN_DEVICE_PRIVATE */
   377		};
 > 378		static const uint64_t radeon_range_values[HMM_PFN_VALUE_MAX] = {
   379			0xfffffffffffffffeUL, /* HMM_PFN_ERROR */
   380			0, /* HMM_PFN_NONE */
   381			0xfffffffffffffffcUL /* HMM_PFN_SPECIAL */
   382		};
   383	
   384		unsigned long i, npages = bo->tbo.num_pages;
   385		enum dma_data_direction direction = write ?
   386			DMA_BIDIRECTIONAL : DMA_TO_DEVICE;
   387		struct radeon_device *rdev = bo->rdev;
   388		struct ttm_tt *ttm = &dma->ttm;
 > 389		struct hmm_range range;
   390		struct radeon_mn *rmn;
   391		int ret;
   392	
   393		/*
   394		 * FIXME This whole protection shouldn't be needed as we should only
   395		 * reach that code with a valid reserved bo that can not under go a
   396		 * concurrent radeon_mn_unregister().
   397		 */
   398		mutex_lock(&rdev->mn_lock);
   399		if (bo->mn == NULL) {
   400			mutex_unlock(&rdev->mn_lock);
   401			return -EINVAL;
   402		}
   403		rmn = bo->mn;
   404		mutex_unlock(&rdev->mn_lock);
   405	
   406		range.pfn_shift = 12;
   407		range.pfns = bo->pfns;
   408		range.start = bo->userptr;
   409		range.flags = radeon_range_flags;
   410		range.values = radeon_range_values;
   411		range.end = bo->userptr + radeon_bo_size(bo);
   412	
   413		range.vma = find_vma(rmn->mm, bo->userptr);
   414		if (!range.vma || range.vma->vm_file || range.vma->vm_end < range.end)
   415			return -EPERM;
   416	
   417		memset(ttm->pages, 0, sizeof(void*) * npages);
   418	
   419	again:
   420		for (i = 0; i < npages; ++i) {
 > 421			range.pfns[i] = range.flags[HMM_PFN_VALID];
 > 422			range.pfns[i] |= write ? range.flags[HMM_PFN_WRITE] : 0;
   423		}
   424	
 > 425		ret = hmm_vma_fault(&range, true);
   426		if (ret)
   427			goto err_unmap;
   428	
   429		for (i = 0; i < npages; ++i) {
 > 430			struct page *page = hmm_pfn_to_page(&range, range.pfns[i]);
   431	
   432			if (page == NULL)
   433				goto again;
   434	
   435			if (ttm->pages[i] == page)
   436				continue;
   437	
   438			if (ttm->pages[i])
   439				dma_unmap_page(rdev->dev, dma->dma_address[i],
   440					       PAGE_SIZE, direction);
   441			ttm->pages[i] = page;
   442	
   443			dma->dma_address[i] = dma_map_page(rdev->dev, page, 0,
   444							   PAGE_SIZE, direction);
   445			if (dma_mapping_error(rdev->dev, dma->dma_address[i])) {
 > 446				hmm_vma_range_done(&range);
   447				ttm->pages[i] = NULL;
   448				ret = -ENOMEM;
   449				goto err_unmap;
   450			}
   451		}
   452	
   453		/*
   454		 * Taking rmn->lock is not necessary here as we are protected from any
   455		 * concurrent invalidation through ttm object reservation. Involved
   456		 * functions: radeon_sync_cpu_device_pagetables()
   457		 *            radeon_bo_list_validate()
   458		 *            radeon_gem_userptr_ioctl()
   459		 */
   460		if (!hmm_vma_range_done(&range))
   461			goto again;
   462	
   463		return 0;
   464	
   465	err_unmap:
   466		radeon_mn_bo_unmap(bo, dma, write);
   467		return ret;
   468	}
   469	

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation

--UugvWAfsgieZRqgk
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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

--UugvWAfsgieZRqgk--
