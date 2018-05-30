Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752022AbeE3MG6 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 30 May 2018 08:06:58 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:50702 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751352AbeE3MGz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 May 2018 08:06:55 -0400
Date: Wed, 30 May 2018 15:06:38 +0300
From: Dan Carpenter <dan.carpenter@oracle.com>
To: Ivan Bornyakov <brnkv.i1@gmail.com>
Cc: lustre-devel@lists.lustre.org, devel@driverdev.osuosl.org,
        gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        oleg.drokin@intel.com, andreas.dilger@intel.com
Subject: Re: [PATCH] staging: lustre: libcfs: add parens around macros args
Message-ID: <20180530120638.lap3libc5nxmzb4o@mwanda>
References: <20180522133439.12338-1-brnkv.i1@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180522133439.12338-1-brnkv.i1@gmail.com>
User-Agent: NeoMutt/20170609 (1.8.3)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8908 signatures=668702
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=463
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1805220000 definitions=main-1805300140
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 22, 2018 at 04:34:39PM +0300, Ivan Bornyakov wrote:
> One may call 'CFS_FAIL_TIMEOUT(id, secs + 5);' and get unexpected result
> after macro substitution, viz., 'secs + 5' will turn into
> 'secs + 5 * 1000'
> 

We actually do that in ptl_send_rpc() as well so this is a real bug.

It's sort of an interesting coincidence that the code in ptl_send_rpc()
looks almost exactly like your theoretical code:

	OBD_FAIL_TIMEOUT(OBD_FAIL_PTLRPC_DELAY_SEND, request->rq_timeout + 5);

regards,
dan carpenter
