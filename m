Return-Path: <SRS0=G4S6=JN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,UNPARSEABLE_RELAY,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DD51C43144
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 08:33:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B4AE823EB9
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 08:33:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="EqHA+5k4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B4AE823EB9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753309AbeF0Id2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Jun 2018 04:33:28 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:46334 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751239AbeF0Id0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jun 2018 04:33:26 -0400
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w5R8ShGE068141;
        Wed, 27 Jun 2018 08:33:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2017-10-26;
 bh=In0+B2VxLIfeEmK+b+AFvxCEQOMp7BxyrlsCmjxust0=;
 b=EqHA+5k4WGh9ldIkQqxeyst8IH9Act+g64nJwuFRhGfoK8WjKzzPl9JW7L2BSQISAptT
 L0gnH7M8gxqkMMgjO56RB1imi1JKDvFpb4UaA7tW35FB4wzXtUlxLWDUEyBi6g+jHqBs
 eh9UjjJ371PhJwKvCYkkZ+gAB6vKZ5eaJySn1yLtzEG/obKxeRoFwZGI6JBRetTt3dM4
 GjC7eFQoD/OlonFeMv307oIv4DxHuT4eqXr5TBR45rgSWznGBeC6SZbGTn2Z2EfmvfTj
 q5JwxaL30/jKkP51qFWHpiQtZJuteC3qVO8IeBGgBlNtH961YrsYZYjwf1NEStbp+a7b dw== 
Received: from userv0021.oracle.com (userv0021.oracle.com [156.151.31.71])
        by aserp2130.oracle.com with ESMTP id 2jukmtuubd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 27 Jun 2018 08:33:19 +0000
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userv0021.oracle.com (8.14.4/8.14.4) with ESMTP id w5R8XId9030382
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 27 Jun 2018 08:33:18 GMT
Received: from abhmp0004.oracle.com (abhmp0004.oracle.com [141.146.116.10])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id w5R8XGUv019386;
        Wed, 27 Jun 2018 08:33:16 GMT
Received: from mwanda (/197.157.0.49)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 27 Jun 2018 01:33:15 -0700
Date:   Wed, 27 Jun 2018 11:33:07 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Michael Straube <straube.linux@gmail.com>
Cc:     Joe Perches <joe@perches.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        devel@driverdev.osuosl.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 3/4] staging: rtl8723bs: use ether_addr_copy() in
 rtw_macaddr_cfg()
Message-ID: <20180627083306.rk3niwazi332rqs5@mwanda>
References: <20180626081409.9518-1-straube.linux@gmail.com>
 <20180626081409.9518-3-straube.linux@gmail.com>
 <CAHp75Vc3gEyP+h_XtJV7zKZV0J++Nyr04au7Rtu3h5y0JJASXg@mail.gmail.com>
 <37cca7e4-3c1f-b1ab-14b3-fd3dbbae8b01@gmail.com>
 <96782a8bbc8d5a8a911447beda78ca4eed6b9f04.camel@perches.com>
 <2a49e8e7-15ef-af4f-1039-b15ae60df11b@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2a49e8e7-15ef-af4f-1039-b15ae60df11b@gmail.com>
User-Agent: NeoMutt/20170609 (1.8.3)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8936 signatures=668703
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=586
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1806210000 definitions=main-1806270100
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 26, 2018 at 10:32:09PM +0200, Michael Straube wrote:
> 
> On 06/26/18 22:17, Joe Perches wrote:
> > On Tue, 2018-06-26 at 21:44 +0200, Michael Straube wrote:
> > > On 06/26/18 19:32, Andy Shevchenko wrote:
> > > > On Tue, Jun 26, 2018 at 11:14 AM, Michael Straube
> > > > <straube.linux@gmail.com> wrote:
> > > > > Use ether_addr_copy() instead of memcpy() to copy the mac address.
> > > > > 
> > > > 
> > > > Suggested-by ?
> > > > 
> > > 
> > > I'll add it. Sorry, I was not aware of the Suggested-by tag.
> > > 
> > > > Btw, ensure that the source and destination buffers are aligned to u16
> > > > as required by API.
> > > 
> > > To be honest I'm not sure how to do that excactly.
> > > 
> > > Use __align(2) in the array declarations? e.g.:
> > > 
> > >           u8 mac[ETH_ALEN] __align(2);
> > 
> > All initial function automatics are naturally aligned.
> > > 
> So there is nothing to change? Now I'm confused.

Do not add the __align(2), as Joe says, it's not required.  You just
need to C alignment rules (it's expected/required for this sort of
patch).

Like if you have a struct:

struct foo {
	char a;
	int b;
};

There is going to be a 3 byte gap between a and b because ints are
normally __align(4).  The exception is when the struct is __packed.  So
sizeof(struct foo) in this case is going to be 8.  kmalloc() returns
pointers which are 8 at least byte aligned normally.  See
ARCH_KMALLOC_MINALIGN.  There is one arch where it's 4 byte aligned?

So when you would get things which aren't __align(2) is when you have:

struct bar {
	char a[3];
	u8 mac[ETH_ALEN];
};

Here the struct member before the mac[] is an odd number of char.  Or
when the struct is packed.

regards,
dan carpenter
