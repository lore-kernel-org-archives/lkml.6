Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754049AbeDTIWF (ORCPT <rfc822;w@1wt.eu>);
        Fri, 20 Apr 2018 04:22:05 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:58970 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753905AbeDTIWC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Apr 2018 04:22:02 -0400
Date: Fri, 20 Apr 2018 11:21:50 +0300
From: Dan Carpenter <dan.carpenter@oracle.com>
To: Lee Jones <lee.jones@linaro.org>
Cc: Jorge Eduardo Candelaria <jedu@slimlogic.co.uk>,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] mfd: tps65911-comparator: Fix an off by one bug
Message-ID: <20180420082150.u2oovqr4b4fd6vrq@mwanda>
References: <20180419134634.GA19793@mwanda>
 <20180420080943.jdbf7vtnkc33vbvd@dell>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180420080943.jdbf7vtnkc33vbvd@dell>
User-Agent: NeoMutt/20170609 (1.8.3)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8868 signatures=668698
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=591
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1804200084
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 20, 2018 at 09:09:43AM +0100, Lee Jones wrote:
> On Thu, 19 Apr 2018, Dan Carpenter wrote:
> 
> > The tps_comparators[] array is used in two places.  We only access the
> > COMP1 (1) and COMP2 (2) elements.  Unfortunately, we're accessing the
> > wrong elements and also one element beyond the end of the array.  There
> > was supposed to be a zero element at the start of the array which is
> > isn't accessed but makes the math work out nicely.
> 
> I normally just apply patches from you, but this is a hack, right?
> 

I liked it, I thought it was nice.  It uses 32 bytes but any fix was
going to use *some* memory.  I don't have strong feelings about it
though, if you want to write a different patch I can do that instead.

regards,
dan carpenter
