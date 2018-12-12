Return-Path: <SRS0=v2je=OV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC379C65BAF
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 18:14:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8269E2086D
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 18:14:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="31vOI2NV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8269E2086D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728153AbeLLSOK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Dec 2018 13:14:10 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:47854 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727799AbeLLSOF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Dec 2018 13:14:05 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id wBCI442v130898;
        Wed, 12 Dec 2018 18:14:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2018-07-02;
 bh=h896+vARVlQp2TY+864O9p84q0YHY1t8pMKrWR85f2E=;
 b=31vOI2NVIBea2zQqGxC+qM45TQsu7a88BxlvljgKG3RQkGpgwK4ntEY3zgoUiZtGKT1s
 8LeOH8h9rDQJ1q3+MqNZGNePYE2KK/SD7KpM4o/NsRx41rI0dsftQflwTEwDmVGJw2g9
 0kfaFFTCWBRd1awVDZxoqq8m8hqHzK963ZtsmoBmbhpipr1N9aA+m2CsdyJ+OK/MeFhn
 JpKVotErGBvm2PfGvlfZcvorElHAYo2izDF6dJW7tc2Wzccge5IvqIRMvnk354S/1BaT
 ZKFCZbG5fhMMgeyBNgxIJtTN43QY7woVK9hJGDm9irK2/XFRL+C6OUTASEn02rhR0iOn qw== 
Received: from userv0021.oracle.com (userv0021.oracle.com [156.151.31.71])
        by userp2120.oracle.com with ESMTP id 2p86kr3gct-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 12 Dec 2018 18:14:00 +0000
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userv0021.oracle.com (8.14.4/8.14.4) with ESMTP id wBCIDxRG001035
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 12 Dec 2018 18:14:00 GMT
Received: from abhmp0014.oracle.com (abhmp0014.oracle.com [141.146.116.20])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id wBCIDxi7003236;
        Wed, 12 Dec 2018 18:13:59 GMT
Received: from localhost (/10.159.153.103)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 12 Dec 2018 10:13:59 -0800
Date:   Wed, 12 Dec 2018 10:13:57 -0800
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Al Viro <viro@zeniv.linux.org.uk>, david@fromorbit.com,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        linux-xfs@vger.kernel.org, Eric Sandeen <sandeen@sandeen.net>
Subject: Re: [GIT PULL] xfs: fixes for v4.20-rc6
Message-ID: <20181212181357.GZ24487@magnolia>
References: <20181208163639.GR24487@magnolia>
 <CAHk-=who9EqvvGaazise-dh7_DH6rLOULWXzysinyAPnHS4B0A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=who9EqvvGaazise-dh7_DH6rLOULWXzysinyAPnHS4B0A@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9105 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1812120155
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 08, 2018 at 11:24:48AM -0800, Linus Torvalds wrote:
> On Sat, Dec 8, 2018 at 8:36 AM Darrick J. Wong <darrick.wong@oracle.com> wrote:
> >
> > Finally, the most important fix is to the pipe splicing code (aka the
> > generic copy_file_range fallback) to avoid pointless short directio
> > reads by only asking the filesystem for as much data as there are
> > available pages in the pipe buffer.  Our previous fix (simulated short
> > directio reads because the number of pages didn't match the length of
> > the read requested) caused subtle problems on overlayfs, so that part is
> > reverted.
> 
> Honestly, I really wish you simply wouldn't send me "xfs" fixes that
> aren't really xfs-specific at all.
> 
> All the splice patches (and honestly, I feel some of the iomap ones
> too) that have come in through the xfs tree should have been handled
> separately as actual VFS patches. Or at least had acks from Al or
> something.
> 
> I'm looking at that splice patch, and my initial reaction was "Hmm.
> but that breaks 0 vs -EAGAIN". But then I realized that that's why
> you're validating pipe->nrbufs, because the special temporary
> per-thread pipe is always supposed to be empty on entry, so a zero
> length can't happen.
> 
> But just the fact that I felt like I had to go and look at one of
> these commits makes me go "this is not an XFS fix at all, it shouldn't
> have been treated as an XFS patch, and the original commit that
> *caused* the problem shouldn't have been treated as one either".
> 
> So please. I want to feel like when I get a XFS pull from the XFS
> maintainer, I don't need to worry about it, and I can just do the git
> pull without having to check details.
> 
> But that means that when you do changes outside of XFS code, those
> changes need to be handled _differently_. And they shouldn't be
> bypassing Al etc. And even if you can't get an Ack from Al, send them
> separately, so that I can check them without there being any XFS
> issues that are mixed up with the pull.

Ok, I'll put xfs and vfs changesets in separate pull requests in the
future.  Thanks for the feedback.

--D

> So the patch looks good, and I'm merging this, but I really really
> don't have to feel like I need to look at xfs pulls this way.
> 
>                  Linus
