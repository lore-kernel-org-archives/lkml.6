Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933327AbeDIBFL (ORCPT <rfc822;w@1wt.eu>);
        Sun, 8 Apr 2018 21:05:11 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:45180 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933135AbeDIBFI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Apr 2018 21:05:08 -0400
Date: Sun, 8 Apr 2018 21:04:31 -0400
From: Sowmini Varadhan <sowmini.varadhan@oracle.com>
To: Eric Biggers <ebiggers3@gmail.com>
Cc: linux-rdma@vger.kernel.org, rds-devel@oss.oracle.com,
        Santosh Shilimkar <santosh.shilimkar@oracle.com>,
        syzbot
        <bot+db99bd25cd19d3347dbf8c05d7dd3ca9bab2d7ad@syzkaller.appspotmail.com>,
        davem@davemloft.net, kuznet@ms2.inr.ac.ru,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, yoshfuji@linux-ipv6.org
Subject: Re: KASAN: use-after-free Read in inet_create
Message-ID: <20180409010431.GA32646@oracle.com>
References: <001a1144d1c8e819f6055fee7118@google.com>
 <20180408231756.GI685@sol.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180408231756.GI685@sol.localdomain>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8857 signatures=668698
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=2 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=597
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1804090011
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


#syz dup: KASAN: use-after-free Read in rds_cong_queue_updates

There  are a number of manifestations of this bug, basically
all suggest that the connect/reconnect etc workqs are somehow
being scheduled after the netns is deleted, despite the
code refactoring in Commit  3db6e0d172c (and looks like
the WARN_ONs in that commit are not even being triggered).
We've not been able to reproduce this issues, and without
a crash dump (or some hint of other threads that were running
at the time of the problem) are working on figuring out
the root-cause by code-inspection.

--Sowmini
