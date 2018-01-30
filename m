Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753191AbeA3W2k (ORCPT <rfc822;w@1wt.eu>);
        Tue, 30 Jan 2018 17:28:40 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:38974 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752894AbeA3W2i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jan 2018 17:28:38 -0500
Date: Tue, 30 Jan 2018 17:28:16 -0500
From: Sowmini Varadhan <sowmini.varadhan@oracle.com>
To: Eric Biggers <ebiggers3@gmail.com>
Cc: David Miller <davem@davemloft.net>, santosh.shilimkar@oracle.com,
        rds-devel@oss.oracle.com,
        bot+aaf54a8c644d559d34dedcf3126aac68a20c9e63@syzkaller.appspotmail.com,
        linux-rdma@vger.kernel.org, netdev@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, linux-kernel@vger.kernel.org
Subject: Re: [rds-devel] BUG: unable to handle kernel NULL pointer
 dereference in rds_send_xmit
Message-ID: <20180130222816.GU22848@oracle.com>
References: <001a1145ac5480242305609956b3@google.com>
 <5ba83a68-0103-d514-1b22-900f755f5aa4@oracle.com>
 <20171218.121213.289437104214632276.davem@davemloft.net>
 <20171218172251.GD26203@oracle.com>
 <20180130222228.q23csjr5l666v3o5@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180130222228.q23csjr5l666v3o5@gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8790 signatures=668657
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=957
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1801300274
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (01/30/18 14:22), Eric Biggers wrote:
>
> I assume you weren't able to reproduce this?  This crash hasn't been
> seen again,
   :
> I am invalidating the bug for syzbot so it will report the same crash
> signature
> again if it occurs, but if you think there is a real bug feel free to keep
> looking into it.

correct I was not able to reproduce this.  However based on code
inspecion, I came up with

    commit 3db6e0d172c94bd9953a1347c55ffb64b1d2e74f
    rds: use RCU to synchronize work-enqueue with connection teardown

Marking  it invalid sounds good to me.

--Sowmini
