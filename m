Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1031531AbeBNPgW (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Feb 2018 10:36:22 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:33484 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1031287AbeBNPgU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Feb 2018 10:36:20 -0500
Date: Wed, 14 Feb 2018 10:35:55 -0500
From: Sowmini Varadhan <sowmini.varadhan@oracle.com>
To: Dmitry Vyukov <dvyukov@google.com>
Cc: syzbot <syzbot+bbd8e9a06452cc48059b@syzkaller.appspotmail.com>,
        David Miller <davem@davemloft.net>,
        LKML <linux-kernel@vger.kernel.org>, linux-rdma@vger.kernel.org,
        netdev <netdev@vger.kernel.org>, rds-devel@oss.oracle.com,
        Santosh Shilimkar <santosh.shilimkar@oracle.com>,
        syzkaller-bugs@googlegroups.com
Subject: Re: KASAN: use-after-free Read in rds_tcp_tune
Message-ID: <20180214153555.GG11528@oracle.com>
References: <001a1141a524c513ca05628d8ad4@google.com>
 <20180112183046.GA26098@oracle.com>
 <CACT4Y+aB0dZShujVMJFV6grb_7AYOMca13a1J2AkWsT7R0cgrQ@mail.gmail.com>
 <20180214152109.GF11528@oracle.com>
 <CACT4Y+bKpi8he1ygwAxgm4F_RJ=BRPBPdMaVAK64SbvCVGt7ww@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACT4Y+bKpi8he1ygwAxgm4F_RJ=BRPBPdMaVAK64SbvCVGt7ww@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8804 signatures=668670
X-Proofpoint-Spam-Details: rule=notspam policy=default score=1 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=1 mlxscore=1 mlxlogscore=227
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1802140182
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (02/14/18 16:28), Dmitry Vyukov wrote:
> syzbot is probably not seeing this problem. However if you don't add
> the Reported-by tag to commit, nor provide syz fix tag, it will
> consider it as "open". One consequence of this is that it is still on
> our radars. Another consequence is that syzbot will never report bugs
> in rds_tcp_tune ever again as it thinks that it's the same known bug,
> so no point in bothering anybody.

understood, I think I saw this in the original syzbot mail as well,
but I was hesitant to actually add the tag because the fix was
based on code-inspection only, and I would have felt more comfortable
about asserting the Reported-by if I'd done a clear-cut before/after
verification.

btw, checkpatch.pl complains about the syzbot*@syzkaller.appspotmail.com
addresses as "Unrecognized email address", we should fix that
error from checkpatch at some point.

--Sowmini 
