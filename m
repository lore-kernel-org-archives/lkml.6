Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755312AbeCSGhk (ORCPT <rfc822;w@1wt.eu>);
        Mon, 19 Mar 2018 02:37:40 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:44234 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755169AbeCSGhh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Mar 2018 02:37:37 -0400
Date: Mon, 19 Mar 2018 02:37:08 -0400
From: Sowmini Varadhan <sowmini.varadhan@oracle.com>
To: Dmitry Vyukov <dvyukov@google.com>
Cc: syzbot <syzbot+80c06fb3aabfa386bc06@syzkaller.appspotmail.com>,
        David Miller <davem@davemloft.net>,
        LKML <linux-kernel@vger.kernel.org>, linux-rdma@vger.kernel.org,
        netdev <netdev@vger.kernel.org>, rds-devel@oss.oracle.com,
        Santosh Shilimkar <santosh.shilimkar@oracle.com>,
        syzkaller-bugs@googlegroups.com
Subject: Re: KASAN: slab-out-of-bounds Read in rds_cong_queue_updates
Message-ID: <20180319063708.GB20345@oracle.com>
References: <001a114aacf82781120565c9f4fe@google.com>
 <CACT4Y+Y_K_GQq0ZgwMNEWuHx6k3BWQZKCoNT8BOWsB-mxL2Szw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACT4Y+Y_K_GQq0ZgwMNEWuHx6k3BWQZKCoNT8BOWsB-mxL2Szw@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8836 signatures=668693
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=2 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=599
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1803190007
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (03/19/18 09:29), Dmitry Vyukov wrote:
> 
> This looks the same as:
> 
> #syz dup: KASAN: use-after-free Read in rds_cong_queue_updates

correct, seems like the rds_destroy_pending() fixes did not seal
this race condition. I need to look at this more carefully to see
what race I missed.. no easy answer here, I am afraid.

--Sowmini
