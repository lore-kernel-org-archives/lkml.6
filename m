Return-Path: <SRS0=FObM=LF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,UNPARSEABLE_RELAY,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81D65C4321D
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Aug 2018 11:39:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2D6DB21530
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Aug 2018 11:39:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="0RrCHoUG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2D6DB21530
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728702AbeHVPDk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Aug 2018 11:03:40 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:59142 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728143AbeHVPDk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Aug 2018 11:03:40 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w7MBcU5Y062283;
        Wed, 22 Aug 2018 11:38:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2018-07-02;
 bh=EaNOa0q9JmD0mfD8kCfk+lKNIb88E6ZULNKC2TfdABo=;
 b=0RrCHoUGoyG/RPpSPE87CyBmQXBCmv8mC2RS5p+DJRZDtAh+AbQbDvobaMU605J60DS0
 EJ6uKmAlKFwZ9YmDjbbFR/zj288cQBlQKP6w+6Ir0qKTgcfePqexFZTP40S5RzNajBxb
 YdQZuT0GKnucIJ2nlyyzERjtQcYMN98mI1IxqQUDdBGZj7QReeHfEjIv4n35qNzUAKS3
 uj7NxhBOGl+fMoSRMraKsQ5g+HLzeVM0AH+1caSXSzoiewflKVWDU48ft9dzw6ilPfS3
 Kus/JqIQARkZxW3tFn9s6feR0PLpAYYd6THvYRZYRupnNzAmWIvQDOfZFHry2sYW5XR3 9Q== 
Received: from aserv0022.oracle.com (aserv0022.oracle.com [141.146.126.234])
        by userp2130.oracle.com with ESMTP id 2kxavtsp7v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 22 Aug 2018 11:38:53 +0000
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserv0022.oracle.com (8.14.4/8.14.4) with ESMTP id w7MBcqmp012428
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 22 Aug 2018 11:38:52 GMT
Received: from abhmp0012.oracle.com (abhmp0012.oracle.com [141.146.116.18])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id w7MBcpVF028842;
        Wed, 22 Aug 2018 11:38:52 GMT
Received: from mwanda (/197.232.248.111)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 22 Aug 2018 04:38:51 -0700
Date:   Wed, 22 Aug 2018 14:38:44 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Nishad Kamdar <nishadkamdar@gmail.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        NeilBrown <neil@brown.name>, Joe Perches <joe@perches.com>,
        Christian =?iso-8859-1?Q?L=FCtke-Stetzkamp?= <christian@lkamp.de>,
        John Crispin <blogic@openwrt.org>
Subject: Re: [PATCH v4 1/4] staging: mt7621-mmc: Fix debug macro N_MSG
Message-ID: <20180822113844.h5ramq5muiyfwnju@mwanda>
References: <cover.1534923403.git.nishadkamdar@gmail.com>
 <2313d873f9a940fcdd4f608ffe3c37ec6a5b6e35.1534923403.git.nishadkamdar@gmail.com>
 <20180822090935.eod5oyodo3xchaxw@mwanda>
 <20180822111052.GA2675@nishad>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180822111052.GA2675@nishad>
User-Agent: NeoMutt/20170609 (1.8.3)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8992 signatures=668707
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1807170000 definitions=main-1808220120
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 22, 2018 at 04:40:56PM +0530, Nishad Kamdar wrote:
> On Wed, Aug 22, 2018 at 12:09:36PM +0300, Dan Carpenter wrote:
> > On Wed, Aug 22, 2018 at 02:04:55PM +0530, Nishad Kamdar wrote:
> > > This patch fixes the debug macro N_MSG. Replaces printk with
> > > dev_<level> without __func__ or __LINE__ or current->comm and
> > > current->pid. Removes the do {} while(0) loop for the single
> > > statement macro. Issue found by checkpatch.
> > > 
> > > Signed-off-by: Nishad Kamdar <nishadkamdar@gmail.com>
> > > ---
> > >  drivers/staging/mt7621-mmc/dbg.h | 11 ++++-------
> > >  1 file changed, 4 insertions(+), 7 deletions(-)
> > > 
> > > diff --git a/drivers/staging/mt7621-mmc/dbg.h b/drivers/staging/mt7621-mmc/dbg.h
> > > index 2f2c56b73987..c56fb896617a 100644
> > > --- a/drivers/staging/mt7621-mmc/dbg.h
> > > +++ b/drivers/staging/mt7621-mmc/dbg.h
> > > @@ -104,13 +104,10 @@ do { \
> > >  
> > >  #define N_MSG(evt, fmt, args...)
> > >  /*
> > > -do {    \
> > > -    if ((DBG_EVT_##evt) & sd_debug_zone[host->id]) { \
> > > -        printk(KERN_ERR TAG"%d -> "fmt" <- %s() : L<%d> PID<%s><0x%x>\n", \
> > > -            host->id,  ##args , __FUNCTION__, __LINE__, current->comm, current->pid);	\
> > > -    } \
> > > -} while(0)
> > > -*/
> > > + *if ((DBG_EVT_##evt) & sd_debug_zone[host->id]) { \
> > > + *    dev_err(mmc_dev(host->mmc), "%d -> " fmt "\n", host->id, ##args) \
> > > + *}
> > > + */
> > 
> > I don't understand what you're trying to do here.  You just commented
> > out the macro and turned it into a no-op.  That's not what the patch
> > description says.
> > 
> > To me the original code seems fine.
> > 
> > regards,
> > dan carpenter
> >
> 
> Ok. But the macro definition was already commented.
> I just changed printk to dev_err and gave it a better
> block comment format.
> Should I leave the older version as it is ?

Oh...  Yeah.  You're right.  Sorry about that.

We normally just delete dead code without even thinking hard about it.
It turns out that if we delete all the N_MSG() code, it's actually quite
a bit.  But probably it's the right thing to do, instead of hanging on
to it like a hoarder.

regards,
dan carpenter

