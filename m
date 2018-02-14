Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1031235AbeBNPVd (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Feb 2018 10:21:33 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:50304 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1031168AbeBNPVa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Feb 2018 10:21:30 -0500
Date: Wed, 14 Feb 2018 10:21:09 -0500
From: Sowmini Varadhan <sowmini.varadhan@oracle.com>
To: Dmitry Vyukov <dvyukov@google.com>
Cc: syzbot <syzbot+bbd8e9a06452cc48059b@syzkaller.appspotmail.com>,
        David Miller <davem@davemloft.net>,
        LKML <linux-kernel@vger.kernel.org>, linux-rdma@vger.kernel.org,
        netdev <netdev@vger.kernel.org>, rds-devel@oss.oracle.com,
        Santosh Shilimkar <santosh.shilimkar@oracle.com>,
        syzkaller-bugs@googlegroups.com
Subject: Re: KASAN: use-after-free Read in rds_tcp_tune
Message-ID: <20180214152109.GF11528@oracle.com>
References: <001a1141a524c513ca05628d8ad4@google.com>
 <20180112183046.GA26098@oracle.com>
 <CACT4Y+aB0dZShujVMJFV6grb_7AYOMca13a1J2AkWsT7R0cgrQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACT4Y+aB0dZShujVMJFV6grb_7AYOMca13a1J2AkWsT7R0cgrQ@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8804 signatures=668670
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=444
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1802140180
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (02/14/18 16:11), Dmitry Vyukov wrote:
> 
> Hi Sowmini,
> 
> Was this ever fixed? What's the fix? This still hangs as open. Please
> provide "syz fix" tag.

Are you still seeing this problem?

I had expected that the changes around rds_destroy_pending - see commit
ebeeb1ad9b8a - would have taken care of this (note that ebeeb1ad9b8a
refactors/updates 3db6e0d172c9) but those fixes were done by inspection
only. In other words, I was never able to reproduce this, so we may
still have missed some race condition.

--Sowmini
