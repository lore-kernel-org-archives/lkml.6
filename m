Return-Path: <SRS0=v2je=OV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49D31C67839
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 18:17:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1234720811
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 18:17:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="LzKatPFt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1234720811
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728206AbeLLSRa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Dec 2018 13:17:30 -0500
Received: from aserp2130.oracle.com ([141.146.126.79]:52536 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727748AbeLLSR3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Dec 2018 13:17:29 -0500
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.22/8.16.0.22) with SMTP id wBCIEVEr134346;
        Wed, 12 Dec 2018 18:17:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2018-07-02;
 bh=edJjeV8E60PnVWtjSU9hRUhhPYNpQVG2WzozzHfbuQI=;
 b=LzKatPFtTsEQM9bc5PEG/w6A32pc1KYoAgXC+1EGVXjOql/aKTADue7BB/DZsIUf/tvB
 G1tX1pldaQM5VjBR8bkuMRonbMlgdlHZ88gUyv1gY5as/1aPrlNaFZ+wEUUKGIlGcoyk
 VcldhxNJtmndW76HxxVKSjr36SMPbgt5PlgX1fph5my9GxgpmaqqXw0u2FgNxZ30pjQm
 AEHVNSwnpW0SR1Rl/1Cupicr/zbOjsQX1y0tpMQCnFTbltNuKNtToBLjddFUiHSxfdOx
 dtZO3aOocdsbRVJHRIanVcr+mHyiYgiOMmojkXr5n9eDsaKlP/jNSEiVg5zSXCt63nvE XQ== 
Received: from userv0021.oracle.com (userv0021.oracle.com [156.151.31.71])
        by aserp2130.oracle.com with ESMTP id 2pawwp3dqx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 12 Dec 2018 18:17:07 +0000
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userv0021.oracle.com (8.14.4/8.14.4) with ESMTP id wBCIH1c7011465
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 12 Dec 2018 18:17:01 GMT
Received: from abhmp0008.oracle.com (abhmp0008.oracle.com [141.146.116.14])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id wBCIH0tm010134;
        Wed, 12 Dec 2018 18:17:00 GMT
Received: from localhost (/10.159.153.103)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 12 Dec 2018 10:17:00 -0800
Date:   Wed, 12 Dec 2018 10:16:58 -0800
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>, david@fromorbit.com,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        linux-xfs@vger.kernel.org, Eric Sandeen <sandeen@sandeen.net>
Subject: Re: [GIT PULL] xfs: fixes for v4.20-rc6
Message-ID: <20181212181658.GA24487@magnolia>
References: <20181208163639.GR24487@magnolia>
 <CAHk-=who9EqvvGaazise-dh7_DH6rLOULWXzysinyAPnHS4B0A@mail.gmail.com>
 <20181211135818.GA29626@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181211135818.GA29626@infradead.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9105 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=744
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1812120156
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 11, 2018 at 05:58:18AM -0800, Christoph Hellwig wrote:
> On Sat, Dec 08, 2018 at 11:24:48AM -0800, Linus Torvalds wrote:
> > Honestly, I really wish you simply wouldn't send me "xfs" fixes that
> > aren't really xfs-specific at all.
> > 
> > All the splice patches (and honestly, I feel some of the iomap ones
> > too) that have come in through the xfs tree should have been handled
> > separately as actual VFS patches. Or at least had acks from Al or
> > something.
> 
> iomap came in through the XFS tree originally, and has been very much
> maintained in combo, even though we now have another user with gfs.
> 
> Maybe we just need to make that official in MAINTAINERS?

Yes, though who should be the official maintainer?  You wrote most of
the iomap code; do you want to maintain it yourself?  Or have people
funnel them wherever XFS patches go? :)

--D
