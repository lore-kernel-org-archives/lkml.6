Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752886AbeCWMTt (ORCPT <rfc822;w@1wt.eu>);
        Fri, 23 Mar 2018 08:19:49 -0400
Received: from mx21.baidu.com ([220.181.3.85]:48467 "EHLO baidu.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752440AbeCWMTk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Mar 2018 08:19:40 -0400
From: "Li,Rongqing" <lirongqing@baidu.com>
To: Michal Hocko <mhocko@kernel.org>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "cgroups@vger.kernel.org" <cgroups@vger.kernel.org>,
        "hannes@cmpxchg.org" <hannes@cmpxchg.org>,
        "Andrey Ryabinin" <aryabinin@virtuozzo.com>
Subject: =?utf-8?B?562U5aSNOiDnrZTlpI06IOetlOWkjTogW1BBVENIXSBtbS9tZW1jb250cm9s?=
 =?utf-8?Q?.c:_speed_up_to_force_empty_a_memory_cgroup?=
Thread-Topic: =?utf-8?B?562U5aSNOiDnrZTlpI06IFtQQVRDSF0gbW0vbWVtY29udHJvbC5jOiBzcGVl?=
 =?utf-8?Q?d_up_to_force_empty_a_memory_cgroup?=
Thread-Index: AQHTv1/VbuxxIhYpnkemi1IzBVlLeqPXTxaA//+IvQCAAIne0IAEx0wggADv+oCAAKRkYA==
Date: Fri, 23 Mar 2018 12:04:16 +0000
Message-ID: <2AD939572F25A448A3AE3CAEA61328C2374EC73E@BC-MAIL-M28.internal.baidu.com>
References: <1521448170-19482-1-git-send-email-lirongqing@baidu.com>
 <20180319085355.GQ23100@dhcp22.suse.cz>
 <2AD939572F25A448A3AE3CAEA61328C23745764B@BC-MAIL-M28.internal.baidu.com>
 <20180319103756.GV23100@dhcp22.suse.cz>
 <2AD939572F25A448A3AE3CAEA61328C2374589DC@BC-MAIL-M28.internal.baidu.com>
 <2AD939572F25A448A3AE3CAEA61328C2374832C1@BC-MAIL-M28.internal.baidu.com>
 <20180323100839.GO23100@dhcp22.suse.cz>
In-Reply-To: <20180323100839.GO23100@dhcp22.suse.cz>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.31.62.14]
x-baidu-bdmsfe-datecheck: 1_BC-MAIL-HUB05_2018-03-23 20:04:18:427
x-baidu-bdmsfe-viruscheck: BC-MAIL-HUB05_GRAY_Inside_WithoutAtta_2018-03-23
 20:04:16:618
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from base64 to 8bit by mail.home.local id w2NCJrtG022371



> -----邮件原件-----
> 发件人: Michal Hocko [mailto:mhocko@kernel.org]
> 发送时间: 2018年3月23日 18:09
> 收件人: Li,Rongqing <lirongqing@baidu.com>
> 抄送: linux-kernel@vger.kernel.org; linux-mm@kvack.org;
> cgroups@vger.kernel.org; hannes@cmpxchg.org; Andrey Ryabinin
> <aryabinin@virtuozzo.com>
> 主题: Re: 答复: 答复: [PATCH] mm/memcontrol.c: speed up to force empty
> a memory cgroup
> 
> On Fri 23-03-18 02:58:36, Li,Rongqing wrote:
> >
> >
> > > -----邮件原件-----
> > > 发件人: linux-kernel-owner@vger.kernel.org
> > > [mailto:linux-kernel-owner@vger.kernel.org] 代表 Li,Rongqing
> > > 发送时间: 2018年3月19日 18:52
> > > 收件人: Michal Hocko <mhocko@kernel.org>
> > > 抄送: linux-kernel@vger.kernel.org; linux-mm@kvack.org;
> > > cgroups@vger.kernel.org; hannes@cmpxchg.org; Andrey Ryabinin
> > > <aryabinin@virtuozzo.com>
> > > 主题: 答复: 答复: [PATCH] mm/memcontrol.c: speed up to force
> empty a
> > > memory cgroup
> > >
> > >
> > >
> > > > -----邮件原件-----
> > > > 发件人: Michal Hocko [mailto:mhocko@kernel.org]
> > > > 发送时间: 2018年3月19日 18:38
> > > > 收件人: Li,Rongqing <lirongqing@baidu.com>
> > > > 抄送: linux-kernel@vger.kernel.org; linux-mm@kvack.org;
> > > > cgroups@vger.kernel.org; hannes@cmpxchg.org; Andrey Ryabinin
> > > > <aryabinin@virtuozzo.com>
> > > > 主题: Re: 答复: [PATCH] mm/memcontrol.c: speed up to force empty
> a
> > > memory
> > > > cgroup
> > > >
> > > > On Mon 19-03-18 10:00:41, Li,Rongqing wrote:
> > > > >
> > > > >
> > > > > > -----邮件原件-----
> > > > > > 发件人: Michal Hocko [mailto:mhocko@kernel.org]
> > > > > > 发送时间: 2018年3月19日 16:54
> > > > > > 收件人: Li,Rongqing <lirongqing@baidu.com>
> > > > > > 抄送: linux-kernel@vger.kernel.org; linux-mm@kvack.org;
> > > > > > cgroups@vger.kernel.org; hannes@cmpxchg.org; Andrey Ryabinin
> > > > > > <aryabinin@virtuozzo.com>
> > > > > > 主题: Re: [PATCH] mm/memcontrol.c: speed up to force empty a
> > > > memory
> > > > > > cgroup
> > > > > >
> > > > > > On Mon 19-03-18 16:29:30, Li RongQing wrote:
> > > > > > > mem_cgroup_force_empty() tries to free only 32
> > > > (SWAP_CLUSTER_MAX)
> > > > > > > pages on each iteration, if a memory cgroup has lots of page
> > > > > > > cache, it will take many iterations to empty all page cache,
> > > > > > > so increase the reclaimed number per iteration to speed it
> > > > > > > up. same as in
> > > > > > > mem_cgroup_resize_limit()
> > > > > > >
> > > > > > > a simple test show:
> > > > > > >
> > > > > > >   $dd if=aaa  of=bbb  bs=1k count=3886080
> > > > > > >   $rm -f bbb
> > > > > > >   $time echo
> > > > 100000000 >/cgroup/memory/test/memory.limit_in_bytes
> > > > > > >
> > > > > > > Before: 0m0.252s ===> after: 0m0.178s
> > > > > >
> > > > > > Andrey was proposing something similar [1]. My main objection
> > > > > > was that his approach might lead to over-reclaim. Your
> > > > > > approach is more conservative because it just increases the
> > > > > > batch size. The size is still rather arbitrary. Same as
> > > > > > SWAP_CLUSTER_MAX but that one is a commonly used unit of
> reclaim in the MM code.
> > > > > >
> > > > > > I would be really curious about more detailed explanation why
> > > > > > having a larger batch yields to a better performance because
> > > > > > we are doingg SWAP_CLUSTER_MAX batches at the lower reclaim
> > > > > > level
> > > anyway.
> > > > > >
> > > > >
> > > > > Although SWAP_CLUSTER_MAX is used at the lower level, but the
> > > > > call stack of try_to_free_mem_cgroup_pages is too long, increase
> > > > > the nr_to_reclaim can reduce times of calling
> > > > > function[do_try_to_free_pages, shrink_zones, hrink_node ]
> > > > >
> > > > > mem_cgroup_resize_limit
> > > > > --->try_to_free_mem_cgroup_pages:  .nr_to_reclaim = max(1024,
> > > > > --->SWAP_CLUSTER_MAX),
> > > > >    ---> do_try_to_free_pages
> > > > >      ---> shrink_zones
> > > > >       --->shrink_node
> > > > >        ---> shrink_node_memcg
> > > > >          ---> shrink_list          <-------loop will happen in this
> place
> > > > [times=1024/32]
> > > > >            ---> shrink_page_list
> > > >
> > > > Can you actually measure this to be the culprit. Because we should
> > > > rethink our call path if it is too complicated/deep to perform well.
> > > > Adding arbitrary batch sizes doesn't sound like a good way to go to me.
> > >
> > > Ok, I will try
> > >
> > http://pasted.co/4edbcfff
> >
> > This is result from ftrace graph, it maybe prove that the deep call
> > path leads to low performance.
> 
> Does it? Let's have a look at the condensed output:
>   6)               |    try_to_free_mem_cgroup_pages() {
>   6)               |      mem_cgroup_select_victim_node() {
>   6)   0.320 us    |        mem_cgroup_node_nr_lru_pages();
>   6)   0.151 us    |        mem_cgroup_node_nr_lru_pages();
>   6)   2.190 us    |      }
>   6)               |      do_try_to_free_pages() {
>   6)               |        shrink_node() {
>   6)               |          shrink_node_memcg() {
>   6)               |            shrink_inactive_list() {
>   6) + 23.131 us   |              shrink_page_list();
>   6) + 33.960 us   |            }
>   6) + 39.203 us   |          }
>   6)               |          shrink_slab() {
>   6) + 72.955 us   |          }
>   6) ! 116.529 us  |        }
>   6)               |        shrink_node() {
>   6)   0.050 us    |          mem_cgroup_iter();
>   6)   0.035 us    |          mem_cgroup_low();
>   6)               |          shrink_node_memcg() {
>   6)   3.955 us    |          }
>   6)               |          shrink_slab() {
>   6) + 54.296 us   |          }
>   6) + 61.502 us   |        }
>   6) ! 185.020 us  |      }
>   6) ! 188.165 us  |    }
> 
> try_to_free_mem_cgroup_pages is the full memcg reclaim path taking
> 188,165 us. The pure reclaim path is shrink_node and that took 116+61 =
> 177 us.
> So we have 11us spent on the way. Is this really making such a difference?
> How does the profile look when we do larger batches?
> 
> > And when increase reclaiming page in try_to_free_mem_cgroup_pages, it
> > can reduce calling of shrink_slab, which save times, in my cases, page
> > caches occupy most memory, slab is little, but shrink_slab will be
> > called everytime
> 
> OK, that makes more sense! shrink_slab is clearly visible here. It is more
> expensive than the page reclaim. This is something to look into.
> 

  shrink_slab() {
  6)   0.175 us    |            down_read_trylock();
  6)               |            super_cache_count() {
  6)   0.642 us    |              list_lru_count_one();
  6)   0.587 us    |              list_lru_count_one();
  6)   3.740 us    |            }
  6)               |            super_cache_count() {
  6)   0.625 us    |              list_lru_count_one();
  6)   0.485 us    |              list_lru_count_one();
  6)   2.145 us    |            }
  6)               |            super_cache_count() {
  6)   0.333 us    |              list_lru_count_one();
  6)   0.334 us    |              list_lru_count_one();
  6)   2.109 us    |            }
  6)               |            super_cache_count() {
  6)   0.062 us    |              list_lru_count_one();
  6)   0.188 us    |              list_lru_count_one();
  6)   1.216 us    |            }
  6)               |            super_cache_count() {
  6)   0.217 us    |              list_lru_count_one();
  6)   0.056 us    |              list_lru_count_one();
  6)   1.282 us    |            }
  6)               |            super_cache_count() {
  6)   0.204 us    |              list_lru_count_one();
  6)   0.205 us    |              list_lru_count_one();
  6)   1.237 us    |            }
  6)               |            super_cache_count() {
  6)   0.596 us    |              list_lru_count_one();
  6)   0.493 us    |              list_lru_count_one();
  6)   2.140 us    |            }
  6)               |            super_cache_count() {
  6)   0.130 us    |              list_lru_count_one();
  6)   0.056 us    |              list_lru_count_one();
  6)   1.260 us    |            }
  6)               |            super_cache_count() {
  6)   0.385 us    |              list_lru_count_one();
  6)   0.054 us    |              list_lru_count_one();
  6)   1.186 us    |            }
  6)               |            super_cache_count() {
  6)   0.304 us    |              list_lru_count_one();
  6)   0.286 us    |              list_lru_count_one();
  6)   1.550 us    |            }
  6)               |            super_cache_count() {
  6)   0.230 us    |              list_lru_count_one();
  6)   0.128 us    |              list_lru_count_one();
  6)   1.408 us    |            }
  6)               |            super_cache_count() {
  6)   0.392 us    |              list_lru_count_one();
  6)   0.132 us    |              list_lru_count_one();
  6)   1.694 us    |            }
  6)               |            super_cache_count() {
  6)   0.257 us    |              list_lru_count_one();
  6)   0.258 us    |              list_lru_count_one();
  6)   1.510 us    |            }
  6)               |            super_cache_count() {
  6)   0.132 us    |              list_lru_count_one();
  6)   0.132 us    |              list_lru_count_one();
  6)   1.361 us    |            }
  6)               |            super_cache_count() {
  6)   0.130 us    |              list_lru_count_one();
  6)   0.130 us    |              list_lru_count_one();
  6)   1.246 us    |            }
  6)               |            count_shadow_nodes() {
  6)   0.203 us    |              list_lru_count_one();
  6)   0.042 us    |              mem_cgroup_node_nr_lru_pages();
  6)   1.131 us    |            }
  6)               |            super_cache_count() {
  6)   0.202 us    |              list_lru_count_one();
  6)   0.056 us    |              list_lru_count_one();
  6)   1.115 us    |            }
  6)               |            super_cache_count() {
  6)   0.055 us    |              list_lru_count_one();
  6)   0.107 us    |              list_lru_count_one();
  6)   0.958 us    |            }
  6)               |            super_cache_count() {
  6)   0.147 us    |              list_lru_count_one();
  6)   0.150 us    |              list_lru_count_one();
  6)   1.474 us    |            }
  6)               |            super_cache_count() {
  6)   0.491 us    |              list_lru_count_one();
  6)   0.485 us    |              list_lru_count_one();
  6)   2.569 us    |            }
  6)               |            super_cache_count() {
  6)   0.605 us    |              list_lru_count_one();
  6)   0.590 us    |              list_lru_count_one();
  6)   2.136 us    |            }
  6)               |            super_cache_count() {
  6)   0.572 us    |              list_lru_count_one();
  6)   0.418 us    |              list_lru_count_one();
  6)   1.914 us    |            }
  6)               |            super_cache_count() {
  6)   0.428 us    |              list_lru_count_one();
  6)   0.358 us    |              list_lru_count_one();
  6)   2.073 us    |            } /* super_cache_count */
  6)               |            super_cache_count() {
  6)   0.422 us    |              list_lru_count_one();
  6)   0.433 us    |              list_lru_count_one();
  6)   1.604 us    |            }
  6)               |            super_cache_count() {
  6)   0.532 us    |              list_lru_count_one();
  6)   0.280 us    |              list_lru_count_one();
  6)   1.523 us    |            }
  6)               |            super_cache_count() {
  6)   0.422 us    |              list_lru_count_one();
  6)   0.574 us    |              list_lru_count_one();
  6)   1.554 us    |            }
  6)               |            super_cache_count() {
  6)   0.565 us    |              list_lru_count_one();
  6)   0.587 us    |              list_lru_count_one();
  6)   1.878 us    |            }
  6)               |            super_cache_count() {
  6)   0.563 us    |              list_lru_count_one();
  6)   0.558 us    |              list_lru_count_one();
  6)   1.949 us    |            }
  6)               |            super_cache_count() {
  6)   0.468 us    |              list_lru_count_one();
  6)   0.476 us    |              list_lru_count_one();
  6)   2.149 us    |            }
  6)               |            super_cache_count() {
  6)   0.443 us    |              list_lru_count_one();
  6)   0.483 us    |              list_lru_count_one();
  6)   2.283 us    |            }
  6)               |            super_cache_count() {
  6)   0.332 us    |              list_lru_count_one();
  6)   0.228 us    |              list_lru_count_one();
  6)   1.307 us    |            }
  6)               |            super_cache_count() {
  6)   0.532 us    |              list_lru_count_one();
  6)   0.367 us    |              list_lru_count_one();
  6)   1.956 us    |            }
  6)   0.036 us    |            up_read();
  6)   0.038 us    |            _cond_resched();
  6) + 72.955 us   |          }

shrink_slab does not reclaim any memory, but take lots of time to count lru

maybe we can use the returning of shrink_slab to control if next shrink_slab should be called?


Or define a slight list_lru_empty to check if sb->s_dentry_lru is empty before calling list_lru_shrink_count, like below

diff --git a/fs/super.c b/fs/super.c
index 672538ca9831..954c22338833 100644
--- a/fs/super.c
+++ b/fs/super.c
@@ -130,8 +130,10 @@ static unsigned long super_cache_count(struct shrinker *shrink,
        if (sb->s_op && sb->s_op->nr_cached_objects)
                total_objects = sb->s_op->nr_cached_objects(sb, sc);
 
-       total_objects += list_lru_shrink_count(&sb->s_dentry_lru, sc);
-       total_objects += list_lru_shrink_count(&sb->s_inode_lru, sc);
+       if (!list_lru_empty(sb->s_dentry_lru))
+               total_objects += list_lru_shrink_count(&sb->s_dentry_lru, sc);
+       if (!list_lru_empty(sb->s_inode_lru))
+               total_objects += list_lru_shrink_count(&sb->s_inode_lru, sc);
 
        total_objects = vfs_pressure_ratio(total_objects);
        return total_objects;

-RongQing


> Thanks!
> --
> Michal Hocko
> SUSE Labs
