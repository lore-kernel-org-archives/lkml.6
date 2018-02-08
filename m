Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752364AbeBHN4z (ORCPT <rfc822;w@1wt.eu>);
        Thu, 8 Feb 2018 08:56:55 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:48664 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752215AbeBHNy3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Feb 2018 08:54:29 -0500
Date: Thu, 8 Feb 2018 16:53:50 +0300
From: Dan Carpenter <dan.carpenter@oracle.com>
To: Julia Lawall <Julia.Lawall@lip6.fr>
Cc: Masahiro Yamada <yamada.masahiro@socionext.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        kernel-janitors@vger.kernel.org, Gilles Muller <Gilles.Muller@lip6.fr>,
        Nicolas Palix <nicolas.palix@imag.fr>,
        Michal Marek <michal.lkml@markovi.net>, cocci@systeme.lip6.fr,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] scripts/coccinelle/misc/shift.cocci: detect < or > that
 should be a shift
Message-ID: <20180208135350.e4yljburdpq7f5ny@mwanda>
References: <1518094434-12852-1-git-send-email-Julia.Lawall@lip6.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1518094434-12852-1-git-send-email-Julia.Lawall@lip6.fr>
User-Agent: NeoMutt/20170609 (1.8.3)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8798 signatures=668663
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1802080162
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 08, 2018 at 01:53:54PM +0100, Julia Lawall wrote:
> This checks for a comparison using < or > between two constants,
> considering both explicit constants (1, 2, etc) and macros defined
> with #define.  False positives are possible in the latter case, when
> a macro may have multiple possible definitions and it is indeed
> necessary to check the value.  There are currently two such false
> positives, in drivers/net/ethernet/chelsio/cxgb3/sge.c:
> 
>        q->fl[0].use_pages = FL0_PG_CHUNK_SIZE > 0;
>        q->fl[1].use_pages = FL1_PG_CHUNK_SIZE > 0;
> 

We could eliminate both these false postives by ignoring >> vs >.  Did
searching for > actually find any bugs?  I think you were right that
right shifting a constant is way less common than left shifting and I
have some smatch scripts where I ignore right shifting bugs.

On the other hand, two false positives are not a big deal.

regards,
dan carpenter
