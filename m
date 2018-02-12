Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935032AbeBLQKI (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Feb 2018 11:10:08 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:35378 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934825AbeBLQKG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Feb 2018 11:10:06 -0500
Date: Mon, 12 Feb 2018 11:09:51 -0500
From: Sowmini Varadhan <sowmini.varadhan@oracle.com>
To: syzbot <syzbot+da36cb8a23beedb61503@syzkaller.appspotmail.com>
Cc: davem@davemloft.net, linux-kernel@vger.kernel.org,
        linux-rdma@vger.kernel.org, netdev@vger.kernel.org,
        rds-devel@oss.oracle.com, santosh.shilimkar@oracle.com,
        syzkaller-bugs@googlegroups.com
Subject: Re: WARNING: suspicious RCU usage in rds_loop_conn_alloc
Message-ID: <20180212160951.GA21125@oracle.com>
References: <001a1143e744e1cb89056505f466@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <001a1143e744e1cb89056505f466@google.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8803 signatures=668668
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=483
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1802120207
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> rcu_scheduler_active = 2, debug_locks = 1
> 1 lock held by syzkaller563791/4086:
>  #0:  (rcu_read_lock){....}, at: [<00000000bf5db0e6>]
> __rds_conn_create+0xe46/0x1b50 net/rds/connection.c:218
> 

the rcu_read_lock() was added by ebeeb1ad9b. After we add that,
everything in the rcu read critical section needs to use GFP_ATOMIC
to avoid sleeping. I'll look into this fix.

--Sowmini
