Return-Path: <SRS0=cgxA=JU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FED2C3279B
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 14:16:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BD52122427
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 14:16:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="k+vySHcr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BD52122427
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752568AbeGDOQS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Jul 2018 10:16:18 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:50732 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752136AbeGDOQR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jul 2018 10:16:17 -0400
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w64EE87N075252;
        Wed, 4 Jul 2018 14:16:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2017-10-26;
 bh=zORkK/cSmicUeFRBAbWBTfRDdEPZ4T6d0PjH6xSKJug=;
 b=k+vySHcro1orJYWw59+LXlg+YOKrGjTJekSKTKv+COi4Vz0Nk0wsgP7IRnPpfSWnvghe
 JGkryILkrFT3sLMWhjWXfnn5MdpPAaRVHurKkaXjJHg6VaXp8LCtwyVg4RimhiVVuHT9
 s3XocYG8IhRbb5mnC4cmRTn5dEPbzS27qd/2We9Ca8Y3ZWOA+GkefY/LK7YcEafhrqJD
 Y55/gVIHIKQC2hwg0YxuAOcr9vBGOHW9lz4rsNuRjTNLHQBIxoX9NUfTAV9zdKbOlnFn
 01OCHOOb6mkV6464ksjqMLH4qg6HF5AjOftJ1rgUXoYLrNblzn5iitPrIXSPQkKYBqnC wg== 
Received: from userv0022.oracle.com (userv0022.oracle.com [156.151.31.74])
        by aserp2130.oracle.com with ESMTP id 2k0dnjaydk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 04 Jul 2018 14:16:10 +0000
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userv0022.oracle.com (8.14.4/8.14.4) with ESMTP id w64EG8u8017768
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 4 Jul 2018 14:16:09 GMT
Received: from abhmp0016.oracle.com (abhmp0016.oracle.com [141.146.116.22])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id w64EG7IT015595;
        Wed, 4 Jul 2018 14:16:08 GMT
Received: from mwanda (/197.157.34.168)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 04 Jul 2018 07:16:07 -0700
Date:   Wed, 4 Jul 2018 17:15:58 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     "Winkler, Tomas" <tomas.winkler@intel.com>
Cc:     Julia Lawall <julia.lawall@lip6.fr>,
        "Usyskin, Alexander" <alexander.usyskin@intel.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>
Subject: Re: [PATCH] mei: bus: type promotion bug in mei_nfc_if_version()
Message-ID: <20180704141558.4645lmns7kerdahg@mwanda>
References: <20180704093449.vryluk7khaudstgp@kili.mountain>
 <alpine.DEB.2.20.1807041358580.4387@hadrien>
 <20180704121600.hrezydpvpe4hyie3@mwanda>
 <5B8DA87D05A7694D9FA63FD143655C1B9D95BC46@hasmsx108.ger.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5B8DA87D05A7694D9FA63FD143655C1B9D95BC46@hasmsx108.ger.corp.intel.com>
User-Agent: NeoMutt/20170609 (1.8.3)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8943 signatures=668704
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1806210000 definitions=main-1807040164
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 04, 2018 at 01:57:44PM +0000, Winkler, Tomas wrote:
> > 
> > On Wed, Jul 04, 2018 at 01:59:14PM +0200, Julia Lawall wrote:
> > >
> > >
> > > On Wed, 4 Jul 2018, Dan Carpenter wrote:
> > >
> > > > We accidentally removed the check for negative returns without
> > > > considering the issue of type promotion.  The "if_version_length"
> > > > variable is type size_t so if __mei_cl_recv() returns a negative
> > > > then "bytes_recv" is type promoted to a high positive value and
> > > > treated as success.
> > > >
> > > > Fixes: 582ab27a063a ("mei: bus: fix received data size check in NFC
> > > > fixup")
> > > > Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> > > >
> > > > diff --git a/drivers/misc/mei/bus-fixup.c
> > > > b/drivers/misc/mei/bus-fixup.c index 0208c4b027c5..fa0236a5e59a
> > > > 100644
> > > > --- a/drivers/misc/mei/bus-fixup.c
> > > > +++ b/drivers/misc/mei/bus-fixup.c
> > > > @@ -267,7 +267,7 @@ static int mei_nfc_if_version(struct mei_cl *cl,
> > > >
> > > >  	ret = 0;
> > > >  	bytes_recv = __mei_cl_recv(cl, (u8 *)reply, if_version_length, 0);
> > > > -	if (bytes_recv < if_version_length) {
> > > > +	if (bytes_recv < 0 || bytes_recv < if_version_length) {
> > >
> > > Is this preferred to adding an int cast?
> > 
> > I don't think it matters.  I kind of like explicitly testing for negative but
> > maybe later people will just remove the check like we did here?  You could
> > do it a bunch of different ways:
> > 
> > 1: if (ret < 0 || ret < ARRAY_SIZE(xxx))
> > 2: if (ret < (int)ARRAY_SIZE(xxx))
> > 3: if (ret != ARRAY_SIZE(xxx))
> > 
> > They're all equivalent.  I guess I don't like casting too much.  My first
> > approach to fixing this was just to declare if_version_length as an int, but
> > then I saw that originally there was a "bytes_recv < 0"
> > check and decided to go that way instead.
> 
> Actually bytes_recv should be probably of ssize_t type,  so could be the if_version_length. 
> 
> How did you find this, I haven't seen it in reported by sparse, smatch and I believe -Wsign-compare is suppressed in compilation warnings.

It's a new thing.  Julia noticed this kind of bug first and I have been
mucking around with it in Smatch as well.  My Smatch check has too many
false positives to publish right now because it thinks a some common
functions like ffs() return negative error codes.

regards,
dan carpenter
