Return-Path: <SRS0=X6pY=KX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E612AC46470
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 19:22:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7F65C21798
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 19:22:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="1Vl784si"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7F65C21798
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731143AbeHHVno (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Aug 2018 17:43:44 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:45726 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727295AbeHHVnn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Aug 2018 17:43:43 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w78JJcX4157066;
        Wed, 8 Aug 2018 19:22:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2018-07-02;
 bh=MxWNYGyZgdqQx79QHpgQzAeU8YlTRaz0IDY/b/gR+ss=;
 b=1Vl784si/NkqNUs24Y7itEUyNRFsPFW/3ktaO7SjrDxItHPsGmKeEKizPLSt9nrMOAgY
 zdOhY//cMGdPtR4M6Iq2/Y7SVBSlbMAWDs7ppVx+aBwDirKad/C4rvsFkYwflLVc9lUI
 MBS4o6O1D7ysK95NnKSniS5zWaIEw9RgrfXMFhE5fy7rjnQV21MW0pYs1HTAT1SOclfd
 djjJOKY4CaEiehlym+6qs4YPyR6Ur56r3wpaIi4t/Gyfqo8bWpDCUlTcvk9WaqcIi754
 hPiogNNdRwtdC2CFl1PqFm9zEer5PphBuAtl3Z6H9AOyoLhH+G0JCahfLbwqlnwYzvH7 aw== 
Received: from aserv0021.oracle.com (aserv0021.oracle.com [141.146.126.233])
        by userp2120.oracle.com with ESMTP id 2kn4spy50c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 08 Aug 2018 19:22:22 +0000
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserv0021.oracle.com (8.14.4/8.14.4) with ESMTP id w78JML6e005978
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 8 Aug 2018 19:22:22 GMT
Received: from abhmp0019.oracle.com (abhmp0019.oracle.com [141.146.116.25])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id w78JMLTs016879;
        Wed, 8 Aug 2018 19:22:21 GMT
Received: from mwanda (/197.232.248.111)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 08 Aug 2018 12:22:20 -0700
Date:   Wed, 8 Aug 2018 22:22:12 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Larry Finger <Larry.Finger@lwfinger.net>
Cc:     Greg KH <gregkh@linuxfoundation.org>,
        Frank Werner-Krippendorf <mail@kripp.ch>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Staging:rtl8712: Style - Removed inline block comment to
 fix "Statements should start on a tapstop"
Message-ID: <20180808192212.kboucbzcggchru22@mwanda>
References: <1533498066-31466-1-git-send-email-mail@kripp.ch>
 <20180808092257.GA4097@kroah.com>
 <9b6d5aa1-dc6b-8d0a-78a1-b46d888db54f@lwfinger.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9b6d5aa1-dc6b-8d0a-78a1-b46d888db54f@lwfinger.net>
User-Agent: NeoMutt/20170609 (1.8.3)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8979 signatures=668707
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1807170000 definitions=main-1808080195
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 08, 2018 at 10:59:26AM -0500, Larry Finger wrote:
> On 08/08/2018 04:22 AM, Greg KH wrote:
> > On Sun, Aug 05, 2018 at 09:41:06PM +0200, Frank Werner-Krippendorf wrote:
> > > Removed 5 inline comments "/*volatile*/" rtl87x_event.h, to fix
> > > a coding style issue "Statements should start on a tabstop"
> > > detected by checkpatch.pl script.
> > > 
> > > Signed-off-by: Frank Werner-Krippendorf <mail@kripp.ch>
> > > ---
> > >   drivers/staging/rtl8712/rtl871x_event.h | 10 +++++-----
> > >   1 file changed, 5 insertions(+), 5 deletions(-)
> > > 
> > > diff --git a/drivers/staging/rtl8712/rtl871x_event.h b/drivers/staging/rtl8712/rtl871x_event.h
> > > index 5171379..2e59e8e 100644
> > > --- a/drivers/staging/rtl8712/rtl871x_event.h
> > > +++ b/drivers/staging/rtl8712/rtl871x_event.h
> > > @@ -90,13 +90,13 @@ struct event_node {
> > >   	unsigned char *node;
> > >   	unsigned char evt_code;
> > >   	unsigned short evt_sz;
> > > -	/*volatile*/ int *caller_ff_tail;
> > > +	int *caller_ff_tail;
> > >   	int	caller_ff_sz;
> > >   };
> > >   struct c2hevent_queue {
> > > -	/*volatile*/ int	head;
> > > -	/*volatile*/ int	tail;
> > 
> > Those "volatile" seem to imply that something is needed for these
> > variables.  Please check to ensure that these are ok to remove in that
> > there is the proper locking for these types of things.
> 
> Those in-line comments are there as a warning that these variables are
> special.

I assumed the comments meant that the locking was buggy...

I'm 100% serious.  Normally that's what volatile means in a driver
context.  Then I interpreted Greg's comments as meaning that warnings
are useful because they show us where the locking bugs are so we
shouldn't fix the warning until after we review the locking.

regards,
dan carpenter

