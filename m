Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753120AbeAaOAa (ORCPT <rfc822;w@1wt.eu>);
        Wed, 31 Jan 2018 09:00:30 -0500
Received: from mail.us.es ([193.147.175.20]:39488 "EHLO mail.us.es"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752351AbeAaOA2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jan 2018 09:00:28 -0500
Date: Wed, 31 Jan 2018 15:00:19 +0100
X-SMTPAUTHUS: auth mail.us.es
From: Pablo Neira Ayuso <pablo@netfilter.org>
To: Dmitry Vyukov <dvyukov@google.com>
Cc: kadlec@blackhole.kfki.hu, fw@strlen.de, davem@davemloft.net,
        kuznet@ms2.inr.ac.ru, yoshfuji@linux-ipv6.org, edumazet@google.com,
        willemb@google.com, netfilter-devel@vger.kernel.org,
        coreteam@netfilter.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller@googlegroups.com
Subject: Re: [PATCH] netfilter: fix out-of-bounds accesses in
 clusterip_tg_check()
Message-ID: <20180131140019.tvsoyc3ihs3l44eb@salvia>
References: <20180130142134.131750-1-dvyukov@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180130142134.131750-1-dvyukov@google.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 30, 2018 at 03:21:34PM +0100, Dmitry Vyukov wrote:
> Commit 136e92bbec0a switched local_nodes from an array to a bitmask
> but did not add proper bounds checks. As the result
> clusterip_config_init_nodelist() can both over-read
> ipt_clusterip_tgt_info.local_nodes and over-write
> clusterip_config.local_nodes.
> 
> Add bounds checks for both.

Applied, thanks Dmitry.
