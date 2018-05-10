Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965739AbeEJOVP (ORCPT <rfc822;w@1wt.eu>);
        Thu, 10 May 2018 10:21:15 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:40686 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934609AbeEJOVO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 May 2018 10:21:14 -0400
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 11.3 \(3445.6.18\))
Subject: Re: linux-next: build warning after merge of the nfsd tree
From: Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <20180510104213.31c41377@canb.auug.org.au>
Date: Thu, 10 May 2018 10:21:05 -0400
Cc: Bruce Fields <bfields@fieldses.org>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Message-Id: <4A03C3E8-6DBA-4FDA-A5C3-46D9E678FC02@oracle.com>
References: <20180510104213.31c41377@canb.auug.org.au>
To: Stephen Rothwell <sfr@canb.auug.org.au>
X-Mailer: Apple Mail (2.3445.6.18)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8888 signatures=668698
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=892
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1805100137
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w4AELLmF003437



> On May 9, 2018, at 8:42 PM, Stephen Rothwell <sfr@canb.auug.org.au> wrote:
> 
> Hi all,
> 
> After merging the nfsd tree, today's linux-next build (powerpc
> ppc64_defconfig) produced this warning:
> 
> net/sunrpc/xprtrdma/svc_rdma_transport.c: In function 'rdma_listen_handler':
> net/sunrpc/xprtrdma/svc_rdma_transport.c:299:23: warning: unused variable 'rdma' [-Wunused-variable]
>  struct svcxprt_rdma *rdma = cma_id->context;
>                       ^~~~

Needs to be wrapped with "#if IS_ENABLED(CONFIG_SUNRPC_DEBUG)"
Would you like me to send a patch?


> Introduced by commit
> 
>  d1ab72afe681 ("svcrdma: Trace key RDMA API events")

--
Chuck Lever
