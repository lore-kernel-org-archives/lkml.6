Return-Path: <SRS0=n7Wc=J2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA553C3279B
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 16:46:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9236F208E3
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 16:46:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="2oK/UoJL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9236F208E3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934645AbeGJQqA (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Jul 2018 12:46:00 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:35510 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933331AbeGJQp7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jul 2018 12:45:59 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w6AGjMFT185565;
        Tue, 10 Jul 2018 16:45:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2018-07-02;
 bh=6441l9eT0qpH28DLB7+8gN4DCkFikfOT4u0Ej5rwcjQ=;
 b=2oK/UoJLItEK3+I2KMVX1/TZK55QHmCyi1IT6bfjJRhm3cH17TPAZ0/hVkopDo5JP+Xf
 ucleOx7AWVRn+3Pt2GWqPkD8O7xjCb+wwwnG6sAE9W6fDXkoQ/4C9XhI3x9GW8Yg2T7X
 iZIscINf+q9W0A1xAcoZgv0pQ/CvywM1lNVz9eoR0OLVcr7+31F/8E5y/ymmbNSJmWa4
 r9685W21vclAj3AtXp88jmcZTebtNj8rX8rFKPKYQrVXeFQB1rKhHLZJiV4xSE6qt9WN
 u437vrKIPMyoccvt6hr9m7hErVV2277zsXtZ0Jwlk4wCDxdzv9nOxweiL3MKtKSPNA1/ +w== 
Received: from aserv0021.oracle.com (aserv0021.oracle.com [141.146.126.233])
        by userp2130.oracle.com with ESMTP id 2k2p762tpw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 10 Jul 2018 16:45:52 +0000
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserv0021.oracle.com (8.14.4/8.14.4) with ESMTP id w6AGjp2q002831
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 10 Jul 2018 16:45:51 GMT
Received: from abhmp0001.oracle.com (abhmp0001.oracle.com [141.146.116.7])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id w6AGjobB027931;
        Tue, 10 Jul 2018 16:45:51 GMT
Received: from mwanda (/197.157.34.168)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 10 Jul 2018 09:45:50 -0700
Date:   Tue, 10 Jul 2018 19:45:42 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Ioana Ciocoi Radulescu <ruxandra.radulescu@nxp.com>
Cc:     "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "devel@driverdev.osuosl.org" <devel@driverdev.osuosl.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Ioana Ciornei <ioana.ciornei@nxp.com>
Subject: Re: [PATCH 5/5] staging: fsl-dpaa2/eth: Remove Rx frame size check
Message-ID: <20180710164541.ywfwlw5b7ecufuqa@mwanda>
References: <20180709150111.8875-1-ruxandra.radulescu@nxp.com>
 <20180709150111.8875-6-ruxandra.radulescu@nxp.com>
 <20180709192809.msmwmtmgj4yxrhme@mwanda>
 <AM3PR04MB338B88A42C1B4802D832DCE945B0@AM3PR04MB338.eurprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <AM3PR04MB338B88A42C1B4802D832DCE945B0@AM3PR04MB338.eurprd04.prod.outlook.com>
User-Agent: NeoMutt/20170609 (1.8.3)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8950 signatures=668706
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1806210000 definitions=main-1807100178
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 10, 2018 at 03:55:32PM +0000, Ioana Ciocoi Radulescu wrote:
> > -----Original Message-----
> > From: Dan Carpenter [mailto:dan.carpenter@oracle.com]
> > Sent: Monday, July 9, 2018 10:28 PM
> > To: Ioana Ciocoi Radulescu <ruxandra.radulescu@nxp.com>
> > Cc: gregkh@linuxfoundation.org; devel@driverdev.osuosl.org; linux-
> > kernel@vger.kernel.org; Ioana Ciornei <ioana.ciornei@nxp.com>
> > Subject: Re: [PATCH 5/5] staging: fsl-dpaa2/eth: Remove Rx frame size check
> > 
> > On Mon, Jul 09, 2018 at 10:01:11AM -0500, Ioana Radulescu wrote:
> > > @@ -2385,6 +2365,12 @@ static int netdev_init(struct net_device
> > *net_dev)
> > >
> > >  	/* Set MTU upper limit; lower limit is 68B (default value) */
> > >  	net_dev->max_mtu = DPAA2_ETH_MAX_MTU;
> > > +	err = dpni_set_max_frame_length(priv->mc_io, 0, priv->mc_token,
> > > +					(u16)DPAA2_ETH_MFL);
> > 
> > The cast was there in the original code so this is not a comment on this
> > particular patch (which seems fine) but there is no need to cast.
> > 
> > Generally it's best to avoid unnecessary casts.  As a human reader, I
> > find the cast confusing.  It indicates that DPAA2_ETH_MFL somehow
> > requires special handling.  Perhaps it's negative or we are trying to
> > truncate away the high bits.  But neither of those things really make
> > sense.
> > 
> > From a static analysis perspective if DPAA2_ETH_MFL doesn't fit nicely
> > then we would want to generate a warning.  But the cast explicitly
> > disables the check.
> 
> I really don't remember why the cast was there in the first place.
> It doesn't look like it's needed anymore, DPAA2_ETH_MFL has a
> positive value (around 10K) that fits just fine inside a u16.
> 
> I see Greg already applied the patch, so I'll send a separate one to
> remove the cast.

Yeah.  I wasn't saying redo the patch.  That was there in the original
and it's not like it's a bug or anything.

regards,
dan carpenter

