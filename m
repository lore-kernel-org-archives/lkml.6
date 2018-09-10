Return-Path: <SRS0=FvrY=LY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EB84C4321E
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 21:21:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CF5062086A
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 21:21:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CF5062086A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727127AbeIKCRU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Sep 2018 22:17:20 -0400
Received: from mga03.intel.com ([134.134.136.65]:36025 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726217AbeIKCRU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Sep 2018 22:17:20 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 10 Sep 2018 14:21:21 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.53,357,1531810800"; 
   d="gz'50?scan'50,208,50";a="73159480"
Received: from bee.sh.intel.com (HELO lkp-server01) ([10.239.97.14])
  by orsmga006.jf.intel.com with ESMTP; 10 Sep 2018 14:21:19 -0700
Received: from kbuild by lkp-server01 with local (Exim 4.89)
        (envelope-from <lkp@intel.com>)
        id 1fzTcU-0006Ac-M5; Tue, 11 Sep 2018 05:21:18 +0800
Date:   Tue, 11 Sep 2018 05:20:35 +0800
From:   kbuild test robot <lkp@intel.com>
To:     zhong jiang <zhongjiang@huawei.com>
Cc:     kbuild-all@01.org, davem@davemloft.net, edumazet@google.com,
        kuznet@ms2.inr.ac.ru, yoshfuji@linux-ipv6.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net: ipv4: Use BUG_ON directly instead of a if condition
 followed by BUG
Message-ID: <201809110506.zWkpQIRv%fengguang.wu@intel.com>
References: <1536590282-23899-1-git-send-email-zhongjiang@huawei.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="huq684BweRXVnRxX"
Content-Disposition: inline
In-Reply-To: <1536590282-23899-1-git-send-email-zhongjiang@huawei.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--huq684BweRXVnRxX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi zhong,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on net/master]
[also build test ERROR on v4.19-rc3 next-20180910]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/zhong-jiang/net-ipv4-Use-BUG_ON-directly-instead-of-a-if-condition-followed-by-BUG/20180911-034152
config: mips-rt305x_defconfig (attached as .config)
compiler: mipsel-linux-gnu-gcc (Debian 7.2.0-11) 7.2.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        GCC_VERSION=7.2.0 make.cross ARCH=mips 

All errors (new ones prefixed by >>):

   net/ipv4/tcp_input.c: In function 'tcp_collapse':
>> net/ipv4/tcp_input.c:4924:5: error: too many arguments to function 'BUG'
        BUG(skb_copy_bits(skb, offset,
        ^~~
   In file included from include/linux/bug.h:5:0,
                    from include/linux/mmdebug.h:5,
                    from include/linux/mm.h:9,
                    from net/ipv4/tcp_input.c:67:
   arch/mips/include/asm/bug.h:12:31: note: declared here
    static inline void __noreturn BUG(void)
                                  ^~~
   net/ipv4/tcp_input.c: In function 'tcp_urg':
   net/ipv4/tcp_input.c:5318:4: error: too many arguments to function 'BUG'
       BUG(skb_copy_bits(skb, ptr, &tmp, 1));
       ^~~
   In file included from include/linux/bug.h:5:0,
                    from include/linux/mmdebug.h:5,
                    from include/linux/mm.h:9,
                    from net/ipv4/tcp_input.c:67:
   arch/mips/include/asm/bug.h:12:31: note: declared here
    static inline void __noreturn BUG(void)
                                  ^~~

vim +/BUG +4924 net/ipv4/tcp_input.c

  4838	
  4839	/* Collapse contiguous sequence of skbs head..tail with
  4840	 * sequence numbers start..end.
  4841	 *
  4842	 * If tail is NULL, this means until the end of the queue.
  4843	 *
  4844	 * Segments with FIN/SYN are not collapsed (only because this
  4845	 * simplifies code)
  4846	 */
  4847	static void
  4848	tcp_collapse(struct sock *sk, struct sk_buff_head *list, struct rb_root *root,
  4849		     struct sk_buff *head, struct sk_buff *tail, u32 start, u32 end)
  4850	{
  4851		struct sk_buff *skb = head, *n;
  4852		struct sk_buff_head tmp;
  4853		bool end_of_skbs;
  4854	
  4855		/* First, check that queue is collapsible and find
  4856		 * the point where collapsing can be useful.
  4857		 */
  4858	restart:
  4859		for (end_of_skbs = true; skb != NULL && skb != tail; skb = n) {
  4860			n = tcp_skb_next(skb, list);
  4861	
  4862			/* No new bits? It is possible on ofo queue. */
  4863			if (!before(start, TCP_SKB_CB(skb)->end_seq)) {
  4864				skb = tcp_collapse_one(sk, skb, list, root);
  4865				if (!skb)
  4866					break;
  4867				goto restart;
  4868			}
  4869	
  4870			/* The first skb to collapse is:
  4871			 * - not SYN/FIN and
  4872			 * - bloated or contains data before "start" or
  4873			 *   overlaps to the next one.
  4874			 */
  4875			if (!(TCP_SKB_CB(skb)->tcp_flags & (TCPHDR_SYN | TCPHDR_FIN)) &&
  4876			    (tcp_win_from_space(sk, skb->truesize) > skb->len ||
  4877			     before(TCP_SKB_CB(skb)->seq, start))) {
  4878				end_of_skbs = false;
  4879				break;
  4880			}
  4881	
  4882			if (n && n != tail &&
  4883			    TCP_SKB_CB(skb)->end_seq != TCP_SKB_CB(n)->seq) {
  4884				end_of_skbs = false;
  4885				break;
  4886			}
  4887	
  4888			/* Decided to skip this, advance start seq. */
  4889			start = TCP_SKB_CB(skb)->end_seq;
  4890		}
  4891		if (end_of_skbs ||
  4892		    (TCP_SKB_CB(skb)->tcp_flags & (TCPHDR_SYN | TCPHDR_FIN)))
  4893			return;
  4894	
  4895		__skb_queue_head_init(&tmp);
  4896	
  4897		while (before(start, end)) {
  4898			int copy = min_t(int, SKB_MAX_ORDER(0, 0), end - start);
  4899			struct sk_buff *nskb;
  4900	
  4901			nskb = alloc_skb(copy, GFP_ATOMIC);
  4902			if (!nskb)
  4903				break;
  4904	
  4905			memcpy(nskb->cb, skb->cb, sizeof(skb->cb));
  4906	#ifdef CONFIG_TLS_DEVICE
  4907			nskb->decrypted = skb->decrypted;
  4908	#endif
  4909			TCP_SKB_CB(nskb)->seq = TCP_SKB_CB(nskb)->end_seq = start;
  4910			if (list)
  4911				__skb_queue_before(list, skb, nskb);
  4912			else
  4913				__skb_queue_tail(&tmp, nskb); /* defer rbtree insertion */
  4914			skb_set_owner_r(nskb, sk);
  4915	
  4916			/* Copy data, releasing collapsed skbs. */
  4917			while (copy > 0) {
  4918				int offset = start - TCP_SKB_CB(skb)->seq;
  4919				int size = TCP_SKB_CB(skb)->end_seq - start;
  4920	
  4921				BUG_ON(offset < 0);
  4922				if (size > 0) {
  4923					size = min(copy, size);
> 4924					BUG(skb_copy_bits(skb, offset,
  4925							  skb_put(nskb, size), size));
  4926					TCP_SKB_CB(nskb)->end_seq += size;
  4927					copy -= size;
  4928					start += size;
  4929				}
  4930				if (!before(start, TCP_SKB_CB(skb)->end_seq)) {
  4931					skb = tcp_collapse_one(sk, skb, list, root);
  4932					if (!skb ||
  4933					    skb == tail ||
  4934					    (TCP_SKB_CB(skb)->tcp_flags & (TCPHDR_SYN | TCPHDR_FIN)))
  4935						goto end;
  4936	#ifdef CONFIG_TLS_DEVICE
  4937					if (skb->decrypted != nskb->decrypted)
  4938						goto end;
  4939	#endif
  4940				}
  4941			}
  4942		}
  4943	end:
  4944		skb_queue_walk_safe(&tmp, skb, n)
  4945			tcp_rbtree_insert(root, skb);
  4946	}
  4947	

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation

--huq684BweRXVnRxX
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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

--huq684BweRXVnRxX--
