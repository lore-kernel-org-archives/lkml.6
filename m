Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754235AbeDTI7w (ORCPT <rfc822;w@1wt.eu>);
        Fri, 20 Apr 2018 04:59:52 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:56440 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754066AbeDTI7v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Apr 2018 04:59:51 -0400
Date: Fri, 20 Apr 2018 11:59:39 +0300
From: Dan Carpenter <dan.carpenter@oracle.com>
To: Lee Jones <lee.jones@linaro.org>,
        Jorge Eduardo Candelaria <jedu@slimlogic.co.uk>
Cc: linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] mfd: tps65911-comparator: Fix an off by one bug
Message-ID: <20180420085938.ymf2jc46dswylxh4@mwanda>
References: <20180419134634.GA19793@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180419134634.GA19793@mwanda>
User-Agent: NeoMutt/20170609 (1.8.3)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8868 signatures=668698
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=711
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1804200090
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 19, 2018 at 04:46:34PM +0300, Dan Carpenter wrote:
> The tps_comparators[] array is used in two places.  We only access the
> COMP1 (1) and COMP2 (2) elements.  Unfortunately, we're accessing the
> wrong elements and also one element beyond the end of the array.  There
> was supposed to be a zero element at the start of the array which is
> isn't accessed but makes the math work out nicely.
> 
> Fixes: 6851ad3ab346 ("TPS65911: Comparator: Add comparator driver")
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> ---
> I can't actually compile this code...

I assumed that I couldn't compile this code because it was non-x86 or
something but actually it's just really out of date.  We broke it in
2012 when we removed the ->write() function pointer.

commit 3f7e82759c692df473675ed06fb90b20f1f225c3
Author: Rhyland Klein <rklein@nvidia.com>
Date:   Tue May 8 11:42:38 2012 -0700

    mfd: Commonize tps65910 regmap access through header

regards,
dan carpenter
