Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751558AbeBXXex (ORCPT <rfc822;w@1wt.eu>);
        Sat, 24 Feb 2018 18:34:53 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:55118 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751461AbeBXXev (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Feb 2018 18:34:51 -0500
Date: Sun, 25 Feb 2018 02:34:36 +0300
From: Dan Carpenter <dan.carpenter@oracle.com>
To: "Luis R. Rodriguez" <mcgrof@kernel.org>
Cc: linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        cocci@systeme.lip6.fr
Subject: Re: [PATCH] lib/test_kmod: Fix an integer overflow test
Message-ID: <20180224233436.6sj4vgn7l4rnfti5@mwanda>
References: <20180122102754.GD23912@mwanda>
 <20180224025941.GB14069@wotan.suse.de>
 <20180224084516.pex3ogxzipzj2o5y@mwanda>
 <20180224220601.GG14069@wotan.suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180224220601.GG14069@wotan.suse.de>
User-Agent: NeoMutt/20170609 (1.8.3)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8814 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=778
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1802240314
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 24, 2018 at 10:06:01PM +0000, Luis R. Rodriguez wrote:
> On Sat, Feb 24, 2018 at 11:45:16AM +0300, Dan Carpenter wrote:
> > On Sat, Feb 24, 2018 at 02:59:41AM +0000, Luis R. Rodriguez wrote:
> > > On Mon, Jan 22, 2018 at 01:27:54PM +0300, Dan Carpenter wrote:
> > > > The main problem is that the parentheses are in the wrong place and the
> > > > unlikely() call returns either 0 or 1 so it's never less than zero.
> > > 
> > > Doh, thanks, yes. Seems worth considering a grammar rule for it.
> > > 
> > > > The other problem is that signed integer overflows like "INT_MAX + 1" are
> > > > undefined behavior.
> > > 
> > > Likewise.
> > > 
> > > This seems like another possible generic typo issue. But I would not resolve it
> > > the way you did, in this particular case below num_test_devs represents the
> > > number of already registered devs, before we increment. So the way to resolve
> > > this would be:
> > > 
> > > 	if (num_test_devs + 1 == INT_MAX)
> > > 
> > > I'll get this upstream, thanks!
> > 
> > There is no issue if num_test_devs is INT_MAX.  But capping it at
> > INT_MAX - 1 is also fine.
> 
> If num_test_devs is INT_MAX, then doing num_test_devs + 1 overflows
> and as you noted that is undefined?

If it's INT_MAX we never do "num_test_devs + 1", we return a NULL.

regards,
dan carpenter
