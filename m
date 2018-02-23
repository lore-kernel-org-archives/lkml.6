Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751818AbeBWK1n (ORCPT <rfc822;w@1wt.eu>);
        Fri, 23 Feb 2018 05:27:43 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:35036 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751699AbeBWK1k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Feb 2018 05:27:40 -0500
Date: Fri, 23 Feb 2018 13:17:15 +0300
From: Dan Carpenter <dan.carpenter@oracle.com>
To: SF Markus Elfring <elfring@users.sourceforge.net>
Cc: target-devel@vger.kernel.org, David Disseldorp <ddiss@suse.de>,
        kernel-janitors@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        linux-scsi@vger.kernel.org
Subject: Re: [0/8] target-iSCSI: Adjustments for several function
 implementations
Message-ID: <20180223101715.xv5dscdaeszqxoyk@mwanda>
References: <6163538d-a406-2f60-11a2-88b4694e9975@users.sourceforge.net>
 <c9a822a4-248e-c479-9118-4b8ffb1033b1@users.sourceforge.net>
 <20180222143624.7c7241a1@suse.de>
 <20180222135600.5vv7vzw7sa5metcb@mwanda>
 <145b88b1-bd1e-a417-8dce-ff19e35a00fc@users.sourceforge.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <145b88b1-bd1e-a417-8dce-ff19e35a00fc@users.sourceforge.net>
User-Agent: NeoMutt/20170609 (1.8.3)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8812 signatures=668677
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=1 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=466
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1802230130
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 23, 2018 at 10:06:16AM +0100, SF Markus Elfring wrote:
> > Calling crypto_free_shash(NULL) is actually fine.
> 
> Really?
> 
> 
> > It doesn't dereference the parameter, it just does pointer math on it in
> > crypto_shash_tfm() and returns if it's NULL in crypto_destroy_tfm().
> 
> Can a passed null pointer really work in this function?
> 
> https://elixir.bootlin.com/linux/v4.16-rc2/source/include/crypto/hash.h#L684
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/include/crypto/hash.h?id=0f9da844d87796ac31b04e81ee95e155e9043132#n751
> 
> static inline struct crypto_tfm *crypto_shash_tfm(struct crypto_shash *tfm)
> {
> 	return &tfm->base;
> }

Yes.  It's not a dereference, it's just doing pointer math to get the
address.

regards,
dan carpenter
