Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752678AbeCTKDV (ORCPT <rfc822;w@1wt.eu>);
        Tue, 20 Mar 2018 06:03:21 -0400
Received: from mx-rz-2.rrze.uni-erlangen.de ([131.188.11.21]:60725 "EHLO
        mx-rz-2.rrze.uni-erlangen.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751976AbeCTKDS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Mar 2018 06:03:18 -0400
Authentication-Results: mx-rz-2.rrze.uni-erlangen.de; dkim=none
        reason="no signature"; dkim-adsp=none (unprotected policy);
        dkim-atps=neutral
X-RRZE-Flag: Not-Spam
X-RRZE-Submit-IP: 23.129.64.102
Date: Tue, 20 Mar 2018 11:02:53 +0100
From: Jonas Rabenstein <jonas.rabenstein@studium.uni-erlangen.de>
To: Christoph Hellwig <hch@lst.de>
Cc: Jonas Rabenstein <jonas.rabenstein@studium.uni-erlangen.de>,
        Scott Bauer <scott.bauer@intel.com>,
        Jonathan Derrick <jonathan.derrick@intel.com>,
        Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 11/11] block: sed-opal: check size of shadow mbr
Message-ID: <20180320100253.bqokfsd3htqhhljx@studium.uni-erlangen.de>
References: <cover.1520946114.git.jonas.rabenstein@studium.uni-erlangen.de>
 <cover.1521482295.git.jonas.rabenstein@studium.uni-erlangen.de>
 <72e19ec70ffac23fff658c60eaae0db850150ca1.1521482296.git.jonas.rabenstein@studium.uni-erlangen.de>
 <20180319200151.GK3380@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180319200151.GK3380@lst.de>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 19, 2018 at 09:01:51PM +0100, Christoph Hellwig wrote:
> On Mon, Mar 19, 2018 at 07:36:53PM +0100, Jonas Rabenstein wrote:
> > Check whether the shadow mbr does fit in the provided space on the
> > target. Also a proper firmware should handle this case and return an
> > error we may prevent problems or even damage with crappy firmwares.
> > 
> > Signed-off-by: Jonas Rabenstein <jonas.rabenstein@studium.uni-erlangen.de>
> > 
> > diff --git a/block/sed-opal.c b/block/sed-opal.c
> > index 51f8034edbf7..9c73bd24c55f 100644
> > --- a/block/sed-opal.c
> > +++ b/block/sed-opal.c
> > @@ -1545,6 +1545,20 @@ static int write_shadow_mbr(struct opal_dev *dev, void *data)
> >  	u64 len;
> >  	int err = 0;
> >  
> > +	/* do we fit in the available shadow mbr space? */
> > +	err = generic_get_table_info(dev, OPAL_MBR, OPAL_TABLE_ROWS);
> 
> And here it gets used.  So this should be merged with the previous patch.
Thought, as the previous one provides a generic interface which is only
used here for this specific use case, separate patches would be better.
But I will merge them in a v3 with all the other comments on the other
patches.
