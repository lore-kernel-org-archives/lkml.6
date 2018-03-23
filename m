Return-Path: <fengguang.wu@intel.com>
X-Google-Smtp-Source: AG47ELu2wfvaQyhUb97wDxV+qFTmC8AqzZ1FEdXwWGjdLWRTGk3KnzJQ85EW2arxknUZ+rs2zOj9
ARC-Seal: i=1; a=rsa-sha256; t=1521795978; cv=none;
        d=google.com; s=arc-20160816;
        b=E2xUD14x1XIuaPV9Re0pBw31+VGnEOUIE9CNyBastHuMmXqOUZ8GKBfV1JeWKf6Myq
         tlz5Sbnd//uSAG90jZOzYvp6jGIzUX5psJu363wW4zT6J+hxeNB2PCGn1yA7jZph3GOx
         M1F+XTDc3Bi86XFG76q7uvlgmQnxn+6TmAa8ywQarYNF6sDNaV73UOxVs94cLK8mdlr1
         1qaX0B72vVOtEXBYiu9nYkKu9aO77utN20+SyoPkcc4kRbR24F6c3fA8rE+cQpyIUxkP
         nzTZk1EGxBkZ3iTqxtEPFo/EYWaohkfHy4B1KqICk9Kpo1/sKVnlmH4h4BzsPXrKd5zA
         ggxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:arc-authentication-results;
        bh=HTA0ShQeRJE6WWc9njAT+4gq34CEJ2HlAmEi/VSHTwU=;
        b=NefmzpBZ8HeLehPeeXW3Nd/XhrvnduWpWRd/IVD4cFoilJ5kPiGIt9ZCNM3POf7QPD
         BLc/Kw+vRqCu//yIq2PgkKlFwihrkNgnIwfB23h2jEXx53cQj1VG2TeDszN67qOhrS2n
         oD278CAEtJE1PoRAvDP21XDzDWhQ+WmJFeBj6xUBG1ah1uU0yin3Pd0HOXqFf9eSB+5D
         BhWH1flMP/ke24n4p93F2DjhHqWbVFyA8lcb6WsZRdl1oNg3sBnIcJWx33VBWN6qC195
         UM45q9ts2T9+qk/5pwp3zT/F4LkytlRGFaEp/qcNHukNRyQa1nuBHcqxPrR49LYNblKT
         7k6w==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of fengguang.wu@intel.com designates 134.134.136.65 as permitted sender) smtp.mailfrom=fengguang.wu@intel.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of fengguang.wu@intel.com designates 134.134.136.65 as permitted sender) smtp.mailfrom=fengguang.wu@intel.com
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.48,349,1517904000";
   d="scan'208";a="214185274"
Date: Fri, 23 Mar 2018 17:06:07 +0800
From: kbuild test robot <lkp@intel.com>
To: Kirill Tkhai <ktkhai@virtuozzo.com>
Cc: kbuild-all@01.org, viro@zeniv.linux.org.uk, hannes@cmpxchg.org,
	mhocko@kernel.org, vdavydov.dev@gmail.com, ktkhai@virtuozzo.com,
	akpm@linux-foundation.org, tglx@linutronix.de, pombredanne@nexb.com,
	stummala@codeaurora.org, gregkh@linuxfoundation.org,
	sfr@canb.auug.org.au, guro@fb.com, mka@chromium.org,
	penguin-kernel@I-love.SAKURA.ne.jp, chris@chris-wilson.co.uk,
	longman@redhat.com, minchan@kernel.org, hillf.zj@alibaba-inc.com,
	ying.huang@intel.com, mgorman@techsingularity.net,
	shakeelb@google.com, jbacik@fb.com, linux@roeck-us.net,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	willy@infradead.org
Subject: Re: [PATCH 03/10] mm: Assign memcg-aware shrinkers bitmap to memcg
Message-ID: <201803231640.37BGHC6o%fengguang.wu@intel.com>
References: <152163850081.21546.6969747084834474733.stgit@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <152163850081.21546.6969747084834474733.stgit@localhost.localdomain>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: fengguang.wu@intel.com
X-SA-Exim-Scanned: No (on bee); SAEximRunCond expanded to false
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1595553622756842955?=
X-GMAIL-MSGID: =?utf-8?q?1595718740704705460?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi Kirill,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on mmotm/master]
[also build test WARNING on v4.16-rc6 next-20180322]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Kirill-Tkhai/Improve-shrink_slab-scalability-old-complexity-was-O-n-2-new-is-O-n/20180323-052754
base:   git://git.cmpxchg.org/linux-mmotm.git master
reproduce:
        # apt-get install sparse
        make ARCH=x86_64 allmodconfig
        make C=1 CF=-D__CHECK_ENDIAN__


sparse warnings: (new ones prefixed by >>)

   include/trace/events/vmscan.h:79:1: sparse: cast from restricted gfp_t
   include/trace/events/vmscan.h:79:1: sparse: cast from restricted gfp_t
   include/trace/events/vmscan.h:79:1: sparse: cast from restricted gfp_t
   include/trace/events/vmscan.h:79:1: sparse: cast from restricted gfp_t
   include/trace/events/vmscan.h:79:1: sparse: cast from restricted gfp_t
   include/trace/events/vmscan.h:79:1: sparse: cast from restricted gfp_t
   include/trace/events/vmscan.h:79:1: sparse: cast from restricted gfp_t
   include/trace/events/vmscan.h:79:1: sparse: cast from restricted gfp_t
   include/trace/events/vmscan.h:79:1: sparse: cast from restricted gfp_t
   include/trace/events/vmscan.h:79:1: sparse: cast from restricted gfp_t
   include/trace/events/vmscan.h:79:1: sparse: cast from restricted gfp_t
   include/trace/events/vmscan.h:79:1: sparse: cast from restricted gfp_t
   include/trace/events/vmscan.h:79:1: sparse: cast from restricted gfp_t
   include/trace/events/vmscan.h:79:1: sparse: cast from restricted gfp_t
   include/trace/events/vmscan.h:79:1: sparse: cast from restricted gfp_t
   include/trace/events/vmscan.h:79:1: sparse: cast from restricted gfp_t
   include/trace/events/vmscan.h:79:1: sparse: cast from restricted gfp_t
   include/trace/events/vmscan.h:79:1: sparse: cast from restricted gfp_t
   include/trace/events/vmscan.h:79:1: sparse: cast from restricted gfp_t
   include/trace/events/vmscan.h:79:1: sparse: cast from restricted gfp_t
   include/trace/events/vmscan.h:79:1: sparse: cast from restricted gfp_t
   include/trace/events/vmscan.h:79:1: sparse: cast from restricted gfp_t
   include/trace/events/vmscan.h:79:1: sparse: cast from restricted gfp_t
   include/trace/events/vmscan.h:79:1: sparse: cast from restricted gfp_t
   include/trace/events/vmscan.h:79:1: sparse: cast from restricted gfp_t
   include/trace/events/vmscan.h:79:1: sparse: cast from restricted gfp_t
   include/trace/events/vmscan.h:79:1: sparse: cast from restricted gfp_t
   include/trace/events/vmscan.h:79:1: sparse: cast from restricted gfp_t
   include/trace/events/vmscan.h:79:1: sparse: cast from restricted gfp_t
   include/trace/events/vmscan.h:79:1: sparse: cast from restricted gfp_t
   include/trace/events/vmscan.h:79:1: sparse: cast from restricted gfp_t
   include/trace/events/vmscan.h:79:1: sparse: incorrect type in argument 3 (different base types) @@    expected unsigned long [unsigned] flags @@    got resunsigned long [unsigned] flags @@
   include/trace/events/vmscan.h:79:1:    expected unsigned long [unsigned] flags
   include/trace/events/vmscan.h:79:1:    got restricted gfp_t [usertype] gfp_flags
   include/trace/events/vmscan.h:106:1: sparse: cast from restricted gfp_t
   include/trace/events/vmscan.h:106:1: sparse: cast from restricted gfp_t
   include/trace/events/vmscan.h:106:1: sparse: cast from restricted gfp_t
   include/trace/events/vmscan.h:106:1: sparse: cast from restricted gfp_t
   include/trace/events/vmscan.h:106:1: sparse: cast from restricted gfp_t
   include/trace/events/vmscan.h:106:1: sparse: cast from restricted gfp_t
   include/trace/events/vmscan.h:106:1: sparse: cast from restricted gfp_t
   include/trace/events/vmscan.h:106:1: sparse: cast from restricted gfp_t
   include/trace/events/vmscan.h:106:1: sparse: cast from restricted gfp_t
   include/trace/events/vmscan.h:106:1: sparse: cast from restricted gfp_t
   include/trace/events/vmscan.h:106:1: sparse: cast from restricted gfp_t
   include/trace/events/vmscan.h:106:1: sparse: cast from restricted gfp_t
   include/trace/events/vmscan.h:106:1: sparse: cast from restricted gfp_t
   include/trace/events/vmscan.h:106:1: sparse: cast from restricted gfp_t
   include/trace/events/vmscan.h:106:1: sparse: cast from restricted gfp_t
   include/trace/events/vmscan.h:106:1: sparse: cast from restricted gfp_t
   include/trace/events/vmscan.h:106:1: sparse: cast from restricted gfp_t
   include/trace/events/vmscan.h:106:1: sparse: cast from restricted gfp_t
   include/trace/events/vmscan.h:106:1: sparse: cast from restricted gfp_t
   include/trace/events/vmscan.h:106:1: sparse: cast from restricted gfp_t
   include/trace/events/vmscan.h:106:1: sparse: cast from restricted gfp_t
   include/trace/events/vmscan.h:106:1: sparse: cast from restricted gfp_t
   include/trace/events/vmscan.h:106:1: sparse: cast from restricted gfp_t
   include/trace/events/vmscan.h:106:1: sparse: cast from restricted gfp_t
   include/trace/events/vmscan.h:106:1: sparse: cast from restricted gfp_t
   include/trace/events/vmscan.h:106:1: sparse: cast from restricted gfp_t
   include/trace/events/vmscan.h:106:1: sparse: cast from restricted gfp_t
   include/trace/events/vmscan.h:106:1: sparse: cast from restricted gfp_t
   include/trace/events/vmscan.h:106:1: sparse: cast from restricted gfp_t
   include/trace/events/vmscan.h:106:1: sparse: cast from restricted gfp_t
   include/trace/events/vmscan.h:106:1: sparse: cast from restricted gfp_t
   include/trace/events/vmscan.h:106:1: sparse: cast from restricted gfp_t
   include/trace/events/vmscan.h:106:1: sparse: cast from restricted gfp_t
   include/trace/events/vmscan.h:106:1: sparse: cast from restricted gfp_t
   include/trace/events/vmscan.h:106:1: sparse: cast from restricted gfp_t
   include/trace/events/vmscan.h:106:1: sparse: incorrect type in argument 3 (different base types) @@    expected unsigned long [unsigned] flags @@    got resunsigned long [unsigned] flags @@
   include/trace/events/vmscan.h:106:1:    expected unsigned long [unsigned] flags
   include/trace/events/vmscan.h:106:1:    got restricted gfp_t [usertype] gfp_flags
   include/trace/events/vmscan.h:196:1: sparse: cast from restricted gfp_t
   include/trace/events/vmscan.h:196:1: sparse: cast from restricted gfp_t
   include/trace/events/vmscan.h:196:1: sparse: cast from restricted gfp_t
   include/trace/events/vmscan.h:196:1: sparse: cast from restricted gfp_t
   include/trace/events/vmscan.h:196:1: sparse: cast from restricted gfp_t
   include/trace/events/vmscan.h:196:1: sparse: cast from restricted gfp_t
   include/trace/events/vmscan.h:196:1: sparse: cast from restricted gfp_t
   include/trace/events/vmscan.h:196:1: sparse: cast from restricted gfp_t
   include/trace/events/vmscan.h:196:1: sparse: cast from restricted gfp_t
   include/trace/events/vmscan.h:196:1: sparse: cast from restricted gfp_t
   include/trace/events/vmscan.h:196:1: sparse: cast from restricted gfp_t
   include/trace/events/vmscan.h:196:1: sparse: cast from restricted gfp_t
   include/trace/events/vmscan.h:196:1: sparse: cast from restricted gfp_t
   include/trace/events/vmscan.h:196:1: sparse: cast from restricted gfp_t
   include/trace/events/vmscan.h:196:1: sparse: cast from restricted gfp_t
   include/trace/events/vmscan.h:196:1: sparse: cast from restricted gfp_t
   include/trace/events/vmscan.h:196:1: sparse: cast from restricted gfp_t
   include/trace/events/vmscan.h:196:1: sparse: cast from restricted gfp_t
   include/trace/events/vmscan.h:196:1: sparse: cast from restricted gfp_t
   include/trace/events/vmscan.h:196:1: sparse: cast from restricted gfp_t
   include/trace/events/vmscan.h:196:1: sparse: cast from restricted gfp_t
   include/trace/events/vmscan.h:196:1: sparse: cast from restricted gfp_t
   include/trace/events/vmscan.h:196:1: sparse: cast from restricted gfp_t
   include/trace/events/vmscan.h:196:1: sparse: cast from restricted gfp_t
   include/trace/events/vmscan.h:196:1: sparse: cast from restricted gfp_t
   include/trace/events/vmscan.h:196:1: sparse: cast from restricted gfp_t
   include/trace/events/vmscan.h:196:1: sparse: cast from restricted gfp_t
   include/trace/events/vmscan.h:196:1: sparse: too many warnings
>> mm/vmscan.c:231:15: sparse: incompatible types in conditional expression (different address spaces)
>> mm/vmscan.c:231:15: sparse: cast from unknown type
>> mm/vmscan.c:231:15: sparse: incompatible types in conditional expression (different address spaces)
>> mm/vmscan.c:231:15: sparse: incompatible types in conditional expression (different address spaces)
>> mm/vmscan.c:231:15: sparse: cast from unknown type

vim +231 mm/vmscan.c

   205	
   206	static int memcg_expand_maps(struct mem_cgroup *memcg, int size, int old_size)
   207	{
   208		struct shrinkers_map *new, *old;
   209		int i;
   210	
   211		new = kvmalloc(sizeof(*new) + nr_node_ids * sizeof(new->map[0]),
   212				GFP_KERNEL);
   213		if (!new)
   214			return -ENOMEM;
   215	
   216		for (i = 0; i < nr_node_ids; i++) {
   217			new->map[i] = kvmalloc_node(size, GFP_KERNEL, i);
   218			if (!new->map[i]) {
   219				while (--i >= 0)
   220					kvfree(new->map[i]);
   221				kvfree(new);
   222				return -ENOMEM;
   223			}
   224	
   225			/* Set all old bits, clear all new bits */
   226			memset(new->map[i], (int)0xff, old_size);
   227			memset((void *)new->map[i] + old_size, 0, size - old_size);
   228		}
   229	
   230		lockdep_assert_held(&bitmap_rwsem);
 > 231		old = rcu_dereference_protected(SHRINKERS_MAP(memcg), true);
   232	
   233		/*
   234		 * We don't want to use rcu_read_lock() in shrink_slab().
   235		 * Since expansion happens rare, we may just take the lock
   236		 * here.
   237		 */
   238		if (old)
   239			down_write(&shrinker_rwsem);
   240	
   241		if (memcg)
   242			rcu_assign_pointer(memcg->shrinkers_map, new);
   243		else
   244			rcu_assign_pointer(root_shrinkers_map, new);
   245	
   246		if (old) {
   247			up_write(&shrinker_rwsem);
   248			call_rcu(&old->rcu, kvfree_map_rcu);
   249		}
   250	
   251		return 0;
   252	}
   253	

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
