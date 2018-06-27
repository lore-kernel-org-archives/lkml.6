Return-Path: <SRS0=G4S6=JN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,UNPARSEABLE_RELAY,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0D7AC43142
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 18:36:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6000E25F06
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 18:36:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="PKDr1OQG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6000E25F06
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935053AbeF0SgM (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Jun 2018 14:36:12 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:49538 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933925AbeF0SgL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jun 2018 14:36:11 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w5RIY3TP106362;
        Wed, 27 Jun 2018 18:36:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2017-10-26;
 bh=jJ00nZXa2EG2aFOgjjGWw1nLUOPJqj00AUbbrORyeRg=;
 b=PKDr1OQG0sJmmP60T6Fohd8Gw1AReljXbBV5J9GZMZghOmMFYDnQqVaZd9g7itXG1mTX
 FI+5dYy0eteJ+QFSKmlrOovYcaUEp/SjLAgowurVHlXZW/GLApafTaxMadnLYwEXT7J5
 7TH/R3kMRaP6HGguHgAgNSMca0Rse7WFkXxPc71b5+utlU92mWLHTnkN31wTXSjf/uC7
 O4Y42LmXPIdB1mhDWw7dyycGEfSuup6INHNeTrUzfmwgqnq1U8wY6S0Jvauzpi+vB8lp
 c1h6y7YvLTMbbRzFGtqoo8QtQCkWgGQkQD2PMFlcjtCqbOlMNSwNiZxBjFgwSD6BZ5ea Ww== 
Received: from userv0021.oracle.com (userv0021.oracle.com [156.151.31.71])
        by userp2130.oracle.com with ESMTP id 2jum57x0dx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 27 Jun 2018 18:36:03 +0000
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userv0021.oracle.com (8.14.4/8.14.4) with ESMTP id w5RIa2P3016658
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 27 Jun 2018 18:36:02 GMT
Received: from abhmp0003.oracle.com (abhmp0003.oracle.com [141.146.116.9])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id w5RIa20L026803;
        Wed, 27 Jun 2018 18:36:02 GMT
Received: from mwanda (/197.157.0.49)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 27 Jun 2018 11:36:01 -0700
Date:   Wed, 27 Jun 2018 21:35:54 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Joe Perches <joe@perches.com>
Cc:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Michael Straube <straube.linux@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        devel@driverdev.osuosl.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 3/4] staging: rtl8723bs: use ether_addr_copy() in
 rtw_macaddr_cfg()
Message-ID: <20180627183554.g4iovrrv3d73bshf@mwanda>
References: <20180626081409.9518-3-straube.linux@gmail.com>
 <CAHp75Vc3gEyP+h_XtJV7zKZV0J++Nyr04au7Rtu3h5y0JJASXg@mail.gmail.com>
 <37cca7e4-3c1f-b1ab-14b3-fd3dbbae8b01@gmail.com>
 <96782a8bbc8d5a8a911447beda78ca4eed6b9f04.camel@perches.com>
 <2a49e8e7-15ef-af4f-1039-b15ae60df11b@gmail.com>
 <20180627083306.rk3niwazi332rqs5@mwanda>
 <6221958a-f817-e01b-7e0f-adbbba9acde4@gmail.com>
 <20180627131158.xttl27awxie2w6ia@mwanda>
 <CAHp75VeEUFEn5zih+2hntU7GCxx7U5rW60DMjRBRNo2EXhSdpw@mail.gmail.com>
 <38f16dbee8612fc9c8115177079adeb8981276a6.camel@perches.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <38f16dbee8612fc9c8115177079adeb8981276a6.camel@perches.com>
User-Agent: NeoMutt/20170609 (1.8.3)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8937 signatures=668703
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=745
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1806210000 definitions=main-1806270199
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 27, 2018 at 09:42:47AM -0700, Joe Perches wrote:
> On Wed, 2018-06-27 at 19:14 +0300, Andy Shevchenko wrote:
> > On Wed, Jun 27, 2018 at 4:11 PM, Dan Carpenter <dan.carpenter@oracle.com> wrote:
> > > On Wed, Jun 27, 2018 at 02:56:00PM +0200, Michael Straube wrote:
> > > > Should I add a thanks line to the commit message:
> > > > 
> > > >     Thanks to Dan Carpenter, Joe Perches and Andy Shevchenko.
> > > > 
> > > > Or would that be considered as too much?
> > > 
> > > You can write whatever the heck you want...  :P  No one cares.
> 
> I hope that's true.
> 
> > > When it comes to credit, I do appreciate Reported-by tags because LWN
> > > and employers do count those sometimes.
> 
> Which is likely as useful as judging engineer
> productivity by LOC counts.
> 

What are you talking about??  Reported-by count absolutely means you're
a Rock Star.

regards,
dan carpenter

