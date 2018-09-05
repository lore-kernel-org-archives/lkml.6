Return-Path: <SRS0=wmYC=LT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,UNPARSEABLE_RELAY,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0323C43334
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 12:10:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 899D720658
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 12:10:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Nl633i27"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 899D720658
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728272AbeIEQkP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Sep 2018 12:40:15 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:52836 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727669AbeIEQkP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Sep 2018 12:40:15 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w85C4B2g083909;
        Wed, 5 Sep 2018 12:10:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2018-07-02;
 bh=ijt90EmucDpZQXM8hG1M54fIdhmaQ0YbAZh8eBVqfxM=;
 b=Nl633i27h5MVCFRp2kPZwqGRVwSV+odlt1eiFcjbMULCMGlxayHu28nWlvdfYvwlqqj+
 rWGDtzmIttquB9QW1UYNcWYF+3UNlgLAurPnM2nXHZT9v0AS1CK1aci/XvYVm3o19dlv
 fKtiTiTEi+uuPiBgwMjRASWF0JTPRIOq8qVjdtp6liVo46I7xossm1kgJQ5TpZNhngYQ
 mECxOqN1WYYI/YnIBBf11XVCfbshRZN5vNbwzsHg77MgazjNB++923GsEmmIhWQIFr85
 XIdLWacwpFF9Zv/+vEmUmtVKGlvWmu9maIOKdzwhEK0STYOns+8N/HP6F8TBImmMbnth Gg== 
Received: from userv0021.oracle.com (userv0021.oracle.com [156.151.31.71])
        by userp2120.oracle.com with ESMTP id 2m7kdqkd7u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 05 Sep 2018 12:10:14 +0000
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userv0021.oracle.com (8.14.4/8.14.4) with ESMTP id w85CADja007423
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 5 Sep 2018 12:10:13 GMT
Received: from abhmp0006.oracle.com (abhmp0006.oracle.com [141.146.116.12])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id w85CADV6027350;
        Wed, 5 Sep 2018 12:10:13 GMT
Received: from mwanda (/197.232.248.111)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 05 Sep 2018 05:10:12 -0700
Date:   Wed, 5 Sep 2018 15:10:06 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Michael Straube <straube.linux@gmail.com>
Cc:     gregkh@linuxfoundation.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] staging: rtl8188eu: remove empty if statement in
 rtw_led.c
Message-ID: <20180905121005.jamftmnxr3s2qgt6@mwanda>
References: <20180904111616.18508-1-straube.linux@gmail.com>
 <20180905081315.bdbotkyfpdkdj537@mwanda>
 <14e81d5c-cafd-4d6d-13a7-87f7d97a5ae3@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <14e81d5c-cafd-4d6d-13a7-87f7d97a5ae3@gmail.com>
User-Agent: NeoMutt/20170609 (1.8.3)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9006 signatures=668708
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=746
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1807170000 definitions=main-1809050129
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 05, 2018 at 01:44:43PM +0200, Michael Straube wrote:
> On 9/5/18 10:13 AM, Dan Carpenter wrote:
> > On Tue, Sep 04, 2018 at 01:16:15PM +0200, Michael Straube wrote:
> > > 
> > >   	case LED_CTL_SITE_SURVEY:
> > > -		if ((pmlmepriv->LinkDetectInfo.bBusyTraffic) && (check_fwstate(pmlmepriv, _FW_LINKED))) {
> > > -			;
> > > -		} else if (!pLed->bLedScanBlinkInProgress) {
> > > +		if (!pLed->bLedScanBlinkInProgress) {
> > 
> > I think you have introduced a bug...
> 
> Ah yes I see now, thanks.
> Would it be ok to merge the conditions in a single if?
> 
> if ((!pmlmepriv->LinkDetectInfo.bBusyTraffic ||
>     !check_fwstate(pmlmepriv, _FW_LINKED)) &&
      ^
Put an extra space here because it's inside the inner parens.

>     !pLed->bLedScanBlinkInProgress) {

So it would be aligned like so:

	if ((!pmlmepriv->LinkDetectInfo.bBusyTraffic ||
	     !check_fwstate(pmlmepriv, _FW_LINKED)) &&
	    !pLed->bLedScanBlinkInProgress) {

regards,
dan capenter


