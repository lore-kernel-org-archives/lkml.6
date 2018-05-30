Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932246AbeE3UGr (ORCPT <rfc822;w@1wt.eu>);
        Wed, 30 May 2018 16:06:47 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:47544 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753718AbeE3UGo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 May 2018 16:06:44 -0400
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 11.3 \(3445.6.18\))
Subject: Re: [PATCH] IB/mad: Use ID allocator routines to allocate agent
 number
From: =?utf-8?Q?H=C3=A5kon_Bugge?= <haakon.bugge@oracle.com>
In-Reply-To: <20180530151023.GB30754@ziepe.ca>
Date: Wed, 30 May 2018 22:07:16 +0200
Cc: Hans Westgaard Ry <hans.westgaard.ry@oracle.com>,
        jackm <jackm@dev.mellanox.co.il>, Doug Ledford <dledford@redhat.com>,
        Daniel Jurgens <danielj@mellanox.com>,
        Parav Pandit <parav@mellanox.com>,
        Pravin Shedge <pravin.shedge4linux@gmail.com>,
        OFED mailing list <linux-rdma@vger.kernel.org>,
        linux-kernel@vger.kernel.org, Leon Romanovsky <leon@kernel.org>
Message-Id: <E67F0098-C2BC-49F6-AC55-3F9195712D4B@oracle.com>
References: <20180529073808.27735-1-hans.westgaard.ry@oracle.com>
 <20180529154922.GA18457@ziepe.ca>
 <A470D739-D0CD-42EE-9196-8E7610B6DAF4@oracle.com>
 <20180529164032.GB18457@ziepe.ca>
 <20180530110216.00000913@dev.mellanox.co.il>
 <d8b75416-6a01-aa64-cd60-0cb4f2b6d0d5@oracle.com>
 <20180530151023.GB30754@ziepe.ca>
To: Jason Gunthorpe <jgg@ziepe.ca>
X-Mailer: Apple Mail (2.3445.6.18)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8909 signatures=668702
X-Proofpoint-Spam-Details: rule=notspam policy=default score=3 suspectscore=2 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=3 mlxscore=3 mlxlogscore=158
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1805220000 definitions=main-1805300214
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w4UK6sRh013934



> On 30 May 2018, at 17:10, Jason Gunthorpe <jgg@ziepe.ca> wrote:
> 
> On Wed, May 30, 2018 at 02:22:56PM +0200, Hans Westgaard Ry wrote:
> 
>> We came up with this code snippet which we think handles both preventing
>> immediate re-use and too big/wrapping...
> 
> Isn't this basically the same as idr_alloc_cyclic ?

I draw my statement back. The idr_alloc_cyclic() is the family of idr's that associates a pointer with the bit. Hence, each bit is a bit + 64b.

That's why we ended up with Hans' pseudo code.


Thxs, Håkon


> 
> Jason
> --
> To unsubscribe from this list: send the line "unsubscribe linux-rdma" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
