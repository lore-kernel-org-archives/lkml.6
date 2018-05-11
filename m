Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751982AbeEKBUf (ORCPT <rfc822;w@1wt.eu>);
        Thu, 10 May 2018 21:20:35 -0400
Received: from mga18.intel.com ([134.134.136.126]:52883 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750806AbeEKBU2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 May 2018 21:20:28 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,387,1520924400";
   d="gz'50?scan'50,208,50";a="45022462"
Date: Fri, 11 May 2018 09:19:44 +0800
From: kbuild test robot <lkp@intel.com>
To: Mark Rutland <mark.rutland@arm.com>
Cc: kbuild-all@01.org, linux-kernel@vger.kernel.org,
        Mark Rutland <mark.rutland@arm.com>, Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Will Deacon <will.deacon@arm.com>
Subject: Re: [PATCH] perf/ring_buffer: ensure atomicity and order of updates
Message-ID: <201805110700.0mgGxEvX%fengguang.wu@intel.com>
References: <20180510130632.34497-1-mark.rutland@arm.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="mYCpIKhGyMATD0i+"
Content-Disposition: inline
In-Reply-To: <20180510130632.34497-1-mark.rutland@arm.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: fengguang.wu@intel.com
X-SA-Exim-Scanned: No (on bee); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--mYCpIKhGyMATD0i+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Mark,

I love your patch! Perhaps something to improve:

[auto build test WARNING on tip/perf/core]
[also build test WARNING on v4.17-rc4 next-20180510]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Mark-Rutland/perf-ring_buffer-ensure-atomicity-and-order-of-updates/20180511-070205
config: i386-randconfig-s1-201818 (attached as .config)
compiler: gcc-6 (Debian 6.4.0-9) 6.4.0 20171026
reproduce:
        # save the attached .config to linux build tree
        make ARCH=i386 

All warnings (new ones prefixed by >>):

   In file included from include/uapi/linux/swab.h:6:0,
                    from include/linux/swab.h:5,
                    from include/uapi/linux/byteorder/little_endian.h:13,
                    from include/linux/byteorder/little_endian.h:5,
                    from arch/x86/include/uapi/asm/byteorder.h:5,
                    from include/uapi/linux/perf_event.h:20,
                    from include/linux/perf_event.h:17,
                    from kernel//events/ring_buffer.c:12:
   kernel//events/ring_buffer.c: In function 'perf_output_put_handle':
   include/linux/compiler.h:339:38: error: call to '__compiletime_assert_86' declared with attribute error: Need native word sized stores/loads for atomicity.
     _compiletime_assert(condition, msg, __compiletime_assert_, __LINE__)
                                         ^
   include/linux/compiler.h:319:4: note: in definition of macro '__compiletime_assert'
       prefix ## suffix();    \
       ^~~~~~
   include/linux/compiler.h:339:2: note: in expansion of macro '_compiletime_assert'
     _compiletime_assert(condition, msg, __compiletime_assert_, __LINE__)
     ^~~~~~~~~~~~~~~~~~~
>> include/linux/compiler.h:342:2: note: in expansion of macro 'compiletime_assert'
     compiletime_assert(__native_word(t),    \
     ^~~~~~~~~~~~~~~~~~
>> include/asm-generic/barrier.h:181:2: note: in expansion of macro 'compiletime_assert_atomic_type'
     compiletime_assert_atomic_type(*p);    \
     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>> kernel//events/ring_buffer.c:86:2: note: in expansion of macro 'smp_store_release'
     smp_store_release(&rb->user_page->data_head, head); /* B, matches C */
     ^~~~~~~~~~~~~~~~~
   kernel//events/ring_buffer.c: In function 'perf_aux_output_skip':
   include/linux/compiler.h:339:38: error: call to '__compiletime_assert_498' declared with attribute error: Need native word sized stores/loads for atomicity.
     _compiletime_assert(condition, msg, __compiletime_assert_, __LINE__)
                                         ^
   include/linux/compiler.h:319:4: note: in definition of macro '__compiletime_assert'
       prefix ## suffix();    \
       ^~~~~~
   include/linux/compiler.h:339:2: note: in expansion of macro '_compiletime_assert'
     _compiletime_assert(condition, msg, __compiletime_assert_, __LINE__)
     ^~~~~~~~~~~~~~~~~~~
>> include/linux/compiler.h:342:2: note: in expansion of macro 'compiletime_assert'
     compiletime_assert(__native_word(t),    \
     ^~~~~~~~~~~~~~~~~~
>> include/asm-generic/barrier.h:181:2: note: in expansion of macro 'compiletime_assert_atomic_type'
     compiletime_assert_atomic_type(*p);    \
     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   kernel//events/ring_buffer.c:498:2: note: in expansion of macro 'smp_store_release'
     smp_store_release(&rb->user_page->aux_head, rb->aux_head);
     ^~~~~~~~~~~~~~~~~
   kernel//events/ring_buffer.c: In function 'perf_aux_output_end':
   include/linux/compiler.h:339:38: error: call to '__compiletime_assert_466' declared with attribute error: Need native word sized stores/loads for atomicity.
     _compiletime_assert(condition, msg, __compiletime_assert_, __LINE__)
                                         ^
   include/linux/compiler.h:319:4: note: in definition of macro '__compiletime_assert'
       prefix ## suffix();    \
       ^~~~~~
   include/linux/compiler.h:339:2: note: in expansion of macro '_compiletime_assert'
     _compiletime_assert(condition, msg, __compiletime_assert_, __LINE__)
     ^~~~~~~~~~~~~~~~~~~
>> include/linux/compiler.h:342:2: note: in expansion of macro 'compiletime_assert'
     compiletime_assert(__native_word(t),    \
     ^~~~~~~~~~~~~~~~~~
>> include/asm-generic/barrier.h:181:2: note: in expansion of macro 'compiletime_assert_atomic_type'
     compiletime_assert_atomic_type(*p);    \
     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   kernel//events/ring_buffer.c:466:2: note: in expansion of macro 'smp_store_release'
     smp_store_release(&rb->user_page->aux_head, rb->aux_head);
     ^~~~~~~~~~~~~~~~~
--
   In file included from include/uapi/linux/swab.h:6:0,
                    from include/linux/swab.h:5,
                    from include/uapi/linux/byteorder/little_endian.h:13,
                    from include/linux/byteorder/little_endian.h:5,
                    from arch/x86/include/uapi/asm/byteorder.h:5,
                    from include/uapi/linux/perf_event.h:20,
                    from include/linux/perf_event.h:17,
                    from kernel/events/ring_buffer.c:12:
   kernel/events/ring_buffer.c: In function 'perf_output_put_handle':
   include/linux/compiler.h:339:38: error: call to '__compiletime_assert_86' declared with attribute error: Need native word sized stores/loads for atomicity.
     _compiletime_assert(condition, msg, __compiletime_assert_, __LINE__)
                                         ^
   include/linux/compiler.h:319:4: note: in definition of macro '__compiletime_assert'
       prefix ## suffix();    \
       ^~~~~~
   include/linux/compiler.h:339:2: note: in expansion of macro '_compiletime_assert'
     _compiletime_assert(condition, msg, __compiletime_assert_, __LINE__)
     ^~~~~~~~~~~~~~~~~~~
>> include/linux/compiler.h:342:2: note: in expansion of macro 'compiletime_assert'
     compiletime_assert(__native_word(t),    \
     ^~~~~~~~~~~~~~~~~~
>> include/asm-generic/barrier.h:181:2: note: in expansion of macro 'compiletime_assert_atomic_type'
     compiletime_assert_atomic_type(*p);    \
     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   kernel/events/ring_buffer.c:86:2: note: in expansion of macro 'smp_store_release'
     smp_store_release(&rb->user_page->data_head, head); /* B, matches C */
     ^~~~~~~~~~~~~~~~~
   kernel/events/ring_buffer.c: In function 'perf_aux_output_skip':
   include/linux/compiler.h:339:38: error: call to '__compiletime_assert_498' declared with attribute error: Need native word sized stores/loads for atomicity.
     _compiletime_assert(condition, msg, __compiletime_assert_, __LINE__)
                                         ^
   include/linux/compiler.h:319:4: note: in definition of macro '__compiletime_assert'
       prefix ## suffix();    \
       ^~~~~~
   include/linux/compiler.h:339:2: note: in expansion of macro '_compiletime_assert'
     _compiletime_assert(condition, msg, __compiletime_assert_, __LINE__)
     ^~~~~~~~~~~~~~~~~~~
>> include/linux/compiler.h:342:2: note: in expansion of macro 'compiletime_assert'
     compiletime_assert(__native_word(t),    \
     ^~~~~~~~~~~~~~~~~~
>> include/asm-generic/barrier.h:181:2: note: in expansion of macro 'compiletime_assert_atomic_type'
     compiletime_assert_atomic_type(*p);    \
     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   kernel/events/ring_buffer.c:498:2: note: in expansion of macro 'smp_store_release'
     smp_store_release(&rb->user_page->aux_head, rb->aux_head);
     ^~~~~~~~~~~~~~~~~
   kernel/events/ring_buffer.c: In function 'perf_aux_output_end':
   include/linux/compiler.h:339:38: error: call to '__compiletime_assert_466' declared with attribute error: Need native word sized stores/loads for atomicity.
     _compiletime_assert(condition, msg, __compiletime_assert_, __LINE__)
                                         ^
   include/linux/compiler.h:319:4: note: in definition of macro '__compiletime_assert'
       prefix ## suffix();    \
       ^~~~~~
   include/linux/compiler.h:339:2: note: in expansion of macro '_compiletime_assert'
     _compiletime_assert(condition, msg, __compiletime_assert_, __LINE__)
     ^~~~~~~~~~~~~~~~~~~
>> include/linux/compiler.h:342:2: note: in expansion of macro 'compiletime_assert'
     compiletime_assert(__native_word(t),    \
     ^~~~~~~~~~~~~~~~~~
>> include/asm-generic/barrier.h:181:2: note: in expansion of macro 'compiletime_assert_atomic_type'
     compiletime_assert_atomic_type(*p);    \
     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   kernel/events/ring_buffer.c:466:2: note: in expansion of macro 'smp_store_release'
     smp_store_release(&rb->user_page->aux_head, rb->aux_head);
     ^~~~~~~~~~~~~~~~~

vim +/smp_store_release +86 kernel//events/ring_buffer.c

    44	
    45	static void perf_output_put_handle(struct perf_output_handle *handle)
    46	{
    47		struct ring_buffer *rb = handle->rb;
    48		unsigned long head;
    49	
    50	again:
    51		head = local_read(&rb->head);
    52	
    53		/*
    54		 * IRQ/NMI can happen here, which means we can miss a head update.
    55		 */
    56	
    57		if (!local_dec_and_test(&rb->nest))
    58			goto out;
    59	
    60		/*
    61		 * Since the mmap() consumer (userspace) can run on a different CPU:
    62		 *
    63		 *   kernel				user
    64		 *
    65		 *   if (LOAD ->data_tail) {		LOAD ->data_head
    66		 *				(A) 	smp_rmb()	(C)
    67		 *	STORE $data			LOAD $data
    68		 *					smp_mb()	(D)
    69		 *	RELEASE ->data_head	(B)	STORE ->data_tail
    70		 *   }
    71		 *
    72		 * Where A pairs with D, and B pairs with C.
    73		 *
    74		 * In our case (A) is a control dependency that separates the load of
    75		 * the ->data_tail and the stores of $data. In case ->data_tail
    76		 * indicates there is no room in the buffer to store $data we do not.
    77		 *
    78		 * D needs to be a full barrier since it separates the data READ
    79		 * from the tail WRITE.
    80		 *
    81		 * For B a WMB is sufficient since it separates two WRITEs, and for C
    82		 * an RMB is sufficient since it separates two READs.
    83		 *
    84		 * See perf_output_begin().
    85		 */
  > 86		smp_store_release(&rb->user_page->data_head, head); /* B, matches C */
    87	
    88		/*
    89		 * Now check if we missed an update -- rely on previous implied
    90		 * compiler barriers to force a re-read.
    91		 */
    92		if (unlikely(head != local_read(&rb->head))) {
    93			local_inc(&rb->nest);
    94			goto again;
    95		}
    96	
    97		if (handle->wakeup != local_read(&rb->wakeup))
    98			perf_output_wakeup(handle);
    99	
   100	out:
   101		preempt_enable();
   102	}
   103	

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation

--mYCpIKhGyMATD0i+
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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

--mYCpIKhGyMATD0i+--
