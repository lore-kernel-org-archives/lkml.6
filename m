Return-Path: <SRS0=FvrY=LY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDBF0C433F5
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 19:06:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 61A342086E
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 19:06:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 61A342086E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728375AbeIKAC0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Sep 2018 20:02:26 -0400
Received: from mga01.intel.com ([192.55.52.88]:44019 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726603AbeIKAC0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Sep 2018 20:02:26 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 10 Sep 2018 12:06:55 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.53,356,1531810800"; 
   d="gz'50?scan'50,208,50";a="71859495"
Received: from bee.sh.intel.com (HELO lkp-server01) ([10.239.97.14])
  by orsmga007.jf.intel.com with ESMTP; 10 Sep 2018 12:06:52 -0700
Received: from kbuild by lkp-server01 with local (Exim 4.89)
        (envelope-from <lkp@intel.com>)
        id 1fzRWN-000Hl9-ND; Tue, 11 Sep 2018 03:06:51 +0800
Date:   Tue, 11 Sep 2018 03:05:53 +0800
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
Message-ID: <201809110333.vVnRzBeF%fengguang.wu@intel.com>
References: <20180910005753.5860-3-jglisse@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="M9NhX3UHpAaciwkO"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180910005753.5860-3-jglisse@redhat.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--M9NhX3UHpAaciwkO
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

Hi Jérôme,

I love your patch! Yet something to improve:

[auto build test ERROR on linus/master]
[also build test ERROR on v4.19-rc3 next-20180910]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/jglisse-redhat-com/Getting-rid-of-GUP-and-use-HMM-for-user-ptr-features/20180911-020741
config: x86_64-randconfig-x000-201836 (attached as .config)
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
>> drivers/gpu/drm/radeon/radeon_mn.c:373:43: error: 'HMM_PFN_FLAG_MAX' undeclared (first use in this function); did you mean 'TTM_PL_FLAG_TT'?
     static const uint64_t radeon_range_flags[HMM_PFN_FLAG_MAX] = {
                                              ^~~~~~~~~~~~~~~~
                                              TTM_PL_FLAG_TT
   drivers/gpu/drm/radeon/radeon_mn.c:373:43: note: each undeclared identifier is reported only once for each function it appears in
   drivers/gpu/drm/radeon/radeon_mn.c:378:44: error: 'HMM_PFN_VALUE_MAX' undeclared (first use in this function); did you mean 'HMM_PFN_FLAG_MAX'?
     static const uint64_t radeon_range_values[HMM_PFN_VALUE_MAX] = {
                                               ^~~~~~~~~~~~~~~~~
                                               HMM_PFN_FLAG_MAX
   drivers/gpu/drm/radeon/radeon_mn.c:389:19: error: storage size of 'range' isn't known
     struct hmm_range range;
                      ^~~~~
   drivers/gpu/drm/radeon/radeon_mn.c:421:31: error: 'HMM_PFN_VALID' undeclared (first use in this function); did you mean 'HMM_PFN_VALUE_MAX'?
      range.pfns[i] = range.flags[HMM_PFN_VALID];
                                  ^~~~~~~~~~~~~
                                  HMM_PFN_VALUE_MAX
   drivers/gpu/drm/radeon/radeon_mn.c:422:40: error: 'HMM_PFN_WRITE' undeclared (first use in this function); did you mean 'HMM_PFN_VALID'?
      range.pfns[i] |= write ? range.flags[HMM_PFN_WRITE] : 0;
                                           ^~~~~~~~~~~~~
                                           HMM_PFN_VALID
   drivers/gpu/drm/radeon/radeon_mn.c:425:8: error: implicit declaration of function 'hmm_vma_fault'; did you mean 'filemap_fault'? [-Werror=implicit-function-declaration]
     ret = hmm_vma_fault(&range, true);
           ^~~~~~~~~~~~~
           filemap_fault
   drivers/gpu/drm/radeon/radeon_mn.c:430:23: error: implicit declaration of function 'hmm_pfn_to_page'; did you mean '__pfn_to_page'? [-Werror=implicit-function-declaration]
      struct page *page = hmm_pfn_to_page(&range, range.pfns[i]);
                          ^~~~~~~~~~~~~~~
                          __pfn_to_page
   drivers/gpu/drm/radeon/radeon_mn.c:446:4: error: implicit declaration of function 'hmm_vma_range_done'; did you mean 'drm_vma_node_size'? [-Werror=implicit-function-declaration]
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
   378		static const uint64_t radeon_range_values[HMM_PFN_VALUE_MAX] = {
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
   389		struct hmm_range range;
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
   421			range.pfns[i] = range.flags[HMM_PFN_VALID];
   422			range.pfns[i] |= write ? range.flags[HMM_PFN_WRITE] : 0;
   423		}
   424	
   425		ret = hmm_vma_fault(&range, true);
   426		if (ret)
   427			goto err_unmap;
   428	
   429		for (i = 0; i < npages; ++i) {
   430			struct page *page = hmm_pfn_to_page(&range, range.pfns[i]);
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
   446				hmm_vma_range_done(&range);
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

--M9NhX3UHpAaciwkO
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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
zs//AanuPxPwsgEA

--M9NhX3UHpAaciwkO--
