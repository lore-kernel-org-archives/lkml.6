Return-Path: <SRS0=G4S6=JN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,UNPARSEABLE_RELAY,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42118C43144
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 13:12:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EC886260C1
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 13:12:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="NoQgArkS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EC886260C1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965043AbeF0NMa (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Jun 2018 09:12:30 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:54460 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754321AbeF0NM1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jun 2018 09:12:27 -0400
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w5RD8qiu083562;
        Wed, 27 Jun 2018 13:12:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2017-10-26;
 bh=WcJMQd0FXoEXDziViKqaqHYDXf6zuCu06Gx2fKZp4vk=;
 b=NoQgArkSqSvf2g9Lyh+9w8nEUn1VINuPGSEsV0FmFLp4S2xNI4erLCxhEUCxLnfCLUhd
 s5BHqTecT3G55AztYdmidTu+ciCNCNbUb5YZJeiNtqcfyel8M0mH62TahcCtyIYDF6XV
 T2tG6dfNlO9Gl2yI9kJQBQ3dwkK1zZlo60NVWcnvpkLleEbNr5qk0GKN9LaSUKz+deJE
 fVJ1UsJRbu0WiQH4hONDrMI1idJb7BbiSDUVUyNb3/9Z5Lo3X4rlgPQw3RKzajUYMj+g
 WIHgM+vKikgqiSOneOEJw6YmFr14LHl9aOTdgE0a2jzuPh6QfI3gKKrh66q+1OTC8b6p 4g== 
Received: from userv0021.oracle.com (userv0021.oracle.com [156.151.31.71])
        by aserp2130.oracle.com with ESMTP id 2jukmtvug3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 27 Jun 2018 13:12:18 +0000
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userv0021.oracle.com (8.14.4/8.14.4) with ESMTP id w5RDCHbR026988
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 27 Jun 2018 13:12:17 GMT
Received: from abhmp0009.oracle.com (abhmp0009.oracle.com [141.146.116.15])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id w5RDCGKH022000;
        Wed, 27 Jun 2018 13:12:16 GMT
Received: from mwanda (/197.157.0.49)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 27 Jun 2018 06:12:15 -0700
Date:   Wed, 27 Jun 2018 16:11:58 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Michael Straube <straube.linux@gmail.com>
Cc:     Joe Perches <joe@perches.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        devel@driverdev.osuosl.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 3/4] staging: rtl8723bs: use ether_addr_copy() in
 rtw_macaddr_cfg()
Message-ID: <20180627131158.xttl27awxie2w6ia@mwanda>
References: <20180626081409.9518-1-straube.linux@gmail.com>
 <20180626081409.9518-3-straube.linux@gmail.com>
 <CAHp75Vc3gEyP+h_XtJV7zKZV0J++Nyr04au7Rtu3h5y0JJASXg@mail.gmail.com>
 <37cca7e4-3c1f-b1ab-14b3-fd3dbbae8b01@gmail.com>
 <96782a8bbc8d5a8a911447beda78ca4eed6b9f04.camel@perches.com>
 <2a49e8e7-15ef-af4f-1039-b15ae60df11b@gmail.com>
 <20180627083306.rk3niwazi332rqs5@mwanda>
 <6221958a-f817-e01b-7e0f-adbbba9acde4@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6221958a-f817-e01b-7e0f-adbbba9acde4@gmail.com>
User-Agent: NeoMutt/20170609 (1.8.3)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8936 signatures=668703
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=675
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1806210000 definitions=main-1806270144
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 27, 2018 at 02:56:00PM +0200, Michael Straube wrote:
> Should I add a thanks line to the commit message:
> 
>     Thanks to Dan Carpenter, Joe Perches and Andy Shevchenko.
> 
> Or would that be considered as too much?

You can write whatever the heck you want...  :P  No one cares.

When it comes to credit, I do appreciate Reported-by tags because LWN
and employers do count those sometimes.  I also think there should be a
tag for when you find a bug in a patch before the patch gets merged.
You wouldn't get the tag for complaining about white space and style
issue because that's easier and less important and, in a way,
complaining about style is its own reward.  But so far we haven't
invented a tag for that.

regards,
dan carpenter

