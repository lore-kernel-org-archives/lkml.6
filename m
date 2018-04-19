Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752841AbeDSNym (ORCPT <rfc822;w@1wt.eu>);
        Thu, 19 Apr 2018 09:54:42 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:58344 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752785AbeDSNyj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Apr 2018 09:54:39 -0400
Date: Thu, 19 Apr 2018 06:55:44 -0700
From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
To: SeongJae Park <sj38.park@gmail.com>
Cc: corbet@lwn.net, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org
Subject: Re: [PATCH 1/2] atomic_ops.rst: Fix wrong example code
Reply-To: paulmck@linux.vnet.ibm.com
References: <20180419084245.17096-1-sj38.park@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180419084245.17096-1-sj38.park@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 18041913-0052-0000-0000-000002DF1508
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00008883; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000257; SDB=6.01020195; UDB=6.00520527; IPR=6.00799433;
 MB=3.00020666; MTD=3.00000008; XFM=3.00000015; UTC=2018-04-19 13:54:37
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18041913-0053-0000-0000-00005C6401B7
Message-Id: <20180419135544.GA26088@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-04-19_05:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1804190124
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 19, 2018 at 05:42:44PM +0900, SeongJae Park wrote:
> Example code snippets for necessary of READ_ONCE() and WRITE_ONCE() has
> an unnecessary line of code and wrong condition.  This commit fixes
> them.
> 
> Signed-off-by: SeongJae Park <sj38.park@gmail.com>

Good catch!!!  I queued and pushed both patches for further review,
thank you!

						Thanx, Paul

> ---
>  Documentation/core-api/atomic_ops.rst | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/Documentation/core-api/atomic_ops.rst b/Documentation/core-api/atomic_ops.rst
> index fce929144ccd..4ea4af71e68a 100644
> --- a/Documentation/core-api/atomic_ops.rst
> +++ b/Documentation/core-api/atomic_ops.rst
> @@ -111,7 +111,6 @@ If the compiler can prove that do_something() does not store to the
>  variable a, then the compiler is within its rights transforming this to
>  the following::
> 
> -	tmp = a;
>  	if (a > 0)
>  		for (;;)
>  			do_something();
> @@ -119,7 +118,7 @@ the following::
>  If you don't want the compiler to do this (and you probably don't), then
>  you should use something like the following::
> 
> -	while (READ_ONCE(a) < 0)
> +	while (READ_ONCE(a) > 0)
>  		do_something();
> 
>  Alternatively, you could place a barrier() call in the loop.
> -- 
> 2.13.0
> 
