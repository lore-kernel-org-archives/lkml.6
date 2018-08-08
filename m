Return-Path: <SRS0=X6pY=KX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,UNPARSEABLE_RELAY,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B250C4646D
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 19:34:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2645D21A53
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 19:34:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="eNPe3+20"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2645D21A53
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730256AbeHHVzu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Aug 2018 17:55:50 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:36088 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727295AbeHHVzu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Aug 2018 17:55:50 -0400
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w78JSea1190027;
        Wed, 8 Aug 2018 19:34:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2018-07-02;
 bh=9HenAfsxJD43C0dQs5FeFP5P0t/QyBeBAHrSyMeDSJQ=;
 b=eNPe3+20/IY8CMvX9YD3IOl2YGExeGFzypPL5Zccbfsnu+aHH2y++6dK/G1pKS6gOjiL
 sspMJ9BcEy+luHyBmcJtK0ozly4vOSVgOXcMy7NH8NKi0wiSD095jWoAHzWgfhzOi8Pu
 rGxsI9za0UPbIZWpgl5UjvIBJFOrzeTdOoT6/c4ANpU0H5o6uF4oSgNbPaEz+7FW7ZIE
 PwapU2B15s4mmrZ1B1n6FWYN/3RWTJX4+NPSFNuFCxENkITnEyqCDV8PezvLP2T8MJ6c
 9JeEs3xfyOM70ktAnZhBOMPNNaESfelPbjygnrsPVfFhmiOHPgqRZu2VkQWV2pps0O9I NA== 
Received: from aserv0021.oracle.com (aserv0021.oracle.com [141.146.126.233])
        by aserp2130.oracle.com with ESMTP id 2kn1nd7ch3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 08 Aug 2018 19:34:29 +0000
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserv0021.oracle.com (8.14.4/8.14.4) with ESMTP id w78JYSc2022581
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 8 Aug 2018 19:34:29 GMT
Received: from abhmp0006.oracle.com (abhmp0006.oracle.com [141.146.116.12])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id w78JYRUM031488;
        Wed, 8 Aug 2018 19:34:28 GMT
Received: from mwanda (/197.232.248.111)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 08 Aug 2018 12:34:27 -0700
Date:   Wed, 8 Aug 2018 22:34:20 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Frank Werner-Krippendorf <mail@kripp.ch>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Larry.Finger@lwfinger.net
Subject: Re: [PATCH] Staging:rtl8712: Style - Removed inline block comment to
 fix "Statements should start on a tapstop"
Message-ID: <20180808193420.aweos5u3wkqme4ew@mwanda>
References: <1533498066-31466-1-git-send-email-mail@kripp.ch>
 <20180808092257.GA4097@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180808092257.GA4097@kroah.com>
User-Agent: NeoMutt/20170609 (1.8.3)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8979 signatures=668707
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1807170000 definitions=main-1808080197
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 08, 2018 at 11:22:57AM +0200, Greg KH wrote:
> On Sun, Aug 05, 2018 at 09:41:06PM +0200, Frank Werner-Krippendorf wrote:
> > Removed 5 inline comments "/*volatile*/" rtl87x_event.h, to fix
> > a coding style issue "Statements should start on a tabstop"
> > detected by checkpatch.pl script.
> > 
> > Signed-off-by: Frank Werner-Krippendorf <mail@kripp.ch>
> > ---
> >  drivers/staging/rtl8712/rtl871x_event.h | 10 +++++-----
> >  1 file changed, 5 insertions(+), 5 deletions(-)
> > 
> > diff --git a/drivers/staging/rtl8712/rtl871x_event.h b/drivers/staging/rtl8712/rtl871x_event.h
> > index 5171379..2e59e8e 100644
> > --- a/drivers/staging/rtl8712/rtl871x_event.h
> > +++ b/drivers/staging/rtl8712/rtl871x_event.h
> > @@ -90,13 +90,13 @@ struct event_node {
> >  	unsigned char *node;
> >  	unsigned char evt_code;
> >  	unsigned short evt_sz;
> > -	/*volatile*/ int *caller_ff_tail;
> > +	int *caller_ff_tail;
> >  	int	caller_ff_sz;
> >  };
> >  
> >  struct c2hevent_queue {
> > -	/*volatile*/ int	head;
> > -	/*volatile*/ int	tail;
> 
> Those "volatile" seem to imply that something is needed for these
> variables.  Please check to ensure that these are ok to remove in that
> there is the proper locking for these types of things.
> 

Good news, people!  I have done the audit and there is no locking bug.
These structs can be deleted because they aren't ever used.

Frank, please can you resend?  There may be more unused stuff in here
which I didn't see.

regards,
dan carpenter

