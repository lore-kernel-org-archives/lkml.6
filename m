Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751523AbeCNVki (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Mar 2018 17:40:38 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:59182 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750779AbeCNVkg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Mar 2018 17:40:36 -0400
Date: Wed, 14 Mar 2018 17:33:54 -0400
From: Sowmini Varadhan <sowmini.varadhan@oracle.com>
To: Eric Dumazet <eric.dumazet@gmail.com>
Cc: syzbot <syzbot+c68e51bb5e699d3f8d91@syzkaller.appspotmail.com>,
        davem@davemloft.net, linux-kernel@vger.kernel.org,
        linux-rdma@vger.kernel.org, netdev@vger.kernel.org,
        rds-devel@oss.oracle.com, santosh.shilimkar@oracle.com,
        syzkaller-bugs@googlegroups.com
Subject: Re: WARNING in __local_bh_enable_ip (2)
Message-ID: <20180314213354.GH24557@oracle.com>
References: <001a113de654ad181e056764f936@google.com>
 <1686ceff-9b7e-592e-8607-b3b8add6a6a3@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1686ceff-9b7e-592e-8607-b3b8add6a6a3@gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8832 signatures=668690
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=2 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=450
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1803140232
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (03/14/18 14:28), Eric Dumazet wrote:
> 
> 
> spin_lock_bh(&rds_tcp_conn_lock);/spin_unlock_bh(&rds_tcp_conn_lock); in
> rds_tcp_conn_free()
> 
> is in conflict with the spin_lock_irqsave(&rds_conn_lock, flags);
> in __rds_conn_create()

yes I was going to look into this and fix it later.

> Hard to understand why RDS is messing with hard irqs really.

some of it comes from the rds_rdma history: some parts of
the common rds and rds_rdma module get called in various
driver contexts for infiniband.

--Sowmini
