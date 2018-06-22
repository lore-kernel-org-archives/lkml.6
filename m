Return-Path: <SRS0=QLNC=JI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,UNPARSEABLE_RELAY,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC988C43142
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 10:57:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 637D9240C8
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 10:57:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="uroCoDJx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 637D9240C8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754259AbeFVK5n (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Jun 2018 06:57:43 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:53994 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751242AbeFVK5m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jun 2018 06:57:42 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w5MAsT45008376;
        Fri, 22 Jun 2018 10:57:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2017-10-26;
 bh=5VskYgfhloRNK9xf/GqJlKZo0jNfDcbt9FTV5IcnVHE=;
 b=uroCoDJxI7rnQTOykJv2W/6m1A9e+CsidS0RTdYDHPTqp/a0y2qmh+gygzA8vbKe8o2v
 /m2R6sukKwgFdADnSPXB7+K5FitKmEC9UJQLsZLdYwHEsnUVB9f5yfKB3OhecEzknzLN
 CxUq4NUNlV6SrQ+1CRAHNwYbhpHis5guiNqrgfHiyHPfFIy3f8duxjcWUW19/QdkQ9/J
 ebm0wflcLGvy+v65QbHL/cAkF60lOMfnVBJOPfJoMDCEm+tqSA31LTn86c2Lh1XamB/y
 IOgLR/5g/pyFrzNsT+vlKEDWPLQSBaT5hpjIRbIMpeaJRe13WtPgVZdkA6KHAnbCc7hp 3A== 
Received: from userv0021.oracle.com (userv0021.oracle.com [156.151.31.71])
        by userp2120.oracle.com with ESMTP id 2jrp8hsg9s-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 22 Jun 2018 10:57:35 +0000
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userv0021.oracle.com (8.14.4/8.14.4) with ESMTP id w5MAvYFD028436
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 22 Jun 2018 10:57:34 GMT
Received: from abhmp0009.oracle.com (abhmp0009.oracle.com [141.146.116.15])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id w5MAvX09016794;
        Fri, 22 Jun 2018 10:57:33 GMT
Received: from mwanda (/41.202.241.28)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 22 Jun 2018 03:57:32 -0700
Date:   Fri, 22 Jun 2018 13:57:19 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Joe Perches <joe@perches.com>
Cc:     Michael Straube <michael.straube@posteo.de>,
        gregkh@linuxfoundation.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: rtl8723bs: do not use assignment in if condition
Message-ID: <20180622105719.pt3lh6fqi2nziqsz@mwanda>
References: <20180621182230.27823-1-michael.straube@posteo.de>
 <20180622104007.ob5nt2rip2fu436h@mwanda>
 <d6f21cd91d4e6482b5c5d125607ed75c25e9c7a0.camel@perches.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d6f21cd91d4e6482b5c5d125607ed75c25e9c7a0.camel@perches.com>
User-Agent: NeoMutt/20170609 (1.8.3)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8931 signatures=668703
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=723
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1806210000 definitions=main-1806220125
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 22, 2018 at 03:54:22AM -0700, Joe Perches wrote:
> On Fri, 2018-06-22 at 13:40 +0300, Dan Carpenter wrote:
> > On Thu, Jun 21, 2018 at 08:22:30PM +0200, Michael Straube wrote:
> > > Fix checkpatch error 'do not use assignment in if condition'.
> []
> > > diff --git a/drivers/staging/rtl8723bs/core/rtw_ieee80211.c b/drivers/staging/rtl8723bs/core/rtw_ieee80211.c
> > > index e55895632921..87a4ced41028 100644
> > > --- a/drivers/staging/rtl8723bs/core/rtw_ieee80211.c
> > > +++ b/ 
> > > @@ -1181,9 +1181,8 @@ void rtw_macaddr_cfg(struct device *dev, u8 *mac_addr)
> > >  	     (mac[3] == 0xff) && (mac[4] == 0xff) && (mac[5] == 0xff)) ||
> > >  	    ((mac[0] == 0x00) && (mac[1] == 0x00) && (mac[2] == 0x00) &&
> > >  	     (mac[3] == 0x00) && (mac[4] == 0x00) && (mac[5] == 0x00))) {
> 
> Should also use is_broadcast_ether_addr and is_zero_ether_addr
> 
> > > -		if (np &&
> > > -		    (addr = of_get_property(np, "local-mac-address", &len)) &&
> > > -		    len == ETH_ALEN) {
> > > +		addr = of_get_property(np, "local-mac-address", &len);
> > > +		if (np && addr && len == ETH_ALEN) {
> > 
> > You can remove the "np" check.
> > 
> > 		if (addr && len == ETH_ALEN) {
> 
> It looks more like the rewrite is incorrect
> as np is tested before of_get_property
> 

That's what I was worried about too, but if "np" is NULL then
of_get_property() just returns NULL so it's fine.

regards,
dan carpenter

regards,
dan carpenter
