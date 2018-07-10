Return-Path: <SRS0=n7Wc=J2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59DB7C3279B
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 22:49:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F17B020862
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 22:49:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="44R+uOQU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F17B020862
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732313AbeGJWvI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Jul 2018 18:51:08 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:54708 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732263AbeGJWvI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jul 2018 18:51:08 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w6AMnMNn054759;
        Tue, 10 Jul 2018 22:49:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2018-07-02;
 bh=yuXR3m7SX4tm0inN8nSSthuLXHSyt+saiZH6ZTjtZ9E=;
 b=44R+uOQUFei2z6ykQJ8j7nm6Tc/I0yeHs79gkBAxtDojX2GQBPmySFXg3KGKrC8tVooo
 fjQPllrglg2bvdBf6Oh5hMoMSzKCWUM29U2DtCf5wZrGoaEDwKM3OnB0w2D6BokEoeNg
 gmv8pzucYLLAaztXAxTxvkgWjZ8qn2ebWmzR9XRAIjEtuFswOHx4CackMhQJSnM03OAg
 Nc2xfMS5bU5WnCEmFwd+EHwwu74DcDwBUGc7ZUa13rRKpTRycR/ch3AS09X+vxhl8Ksd
 43YoyVkwNMuaHsMQ8zfIRmcGBjdGhGYYkr8dMg7xHGmHQVAFdVQDCnlo1shjf5l84KoY TQ== 
Received: from aserv0022.oracle.com (aserv0022.oracle.com [141.146.126.234])
        by userp2130.oracle.com with ESMTP id 2k2p763x2c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 10 Jul 2018 22:49:22 +0000
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserv0022.oracle.com (8.14.4/8.14.4) with ESMTP id w6AMnLUM001183
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 10 Jul 2018 22:49:21 GMT
Received: from abhmp0016.oracle.com (abhmp0016.oracle.com [141.146.116.22])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id w6AMnJwm020445;
        Tue, 10 Jul 2018 22:49:19 GMT
Received: from ca-dmjordan1.us.oracle.com (/10.211.9.48)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 10 Jul 2018 15:49:19 -0700
Date:   Tue, 10 Jul 2018 15:49:23 -0700
From:   Daniel Jordan <daniel.m.jordan@oracle.com>
To:     "Huang, Ying" <ying.huang@intel.com>
Cc:     Daniel Jordan <daniel.m.jordan@oracle.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Michal Hocko <mhocko@suse.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Shaohua Li <shli@kernel.org>, Hugh Dickins <hughd@google.com>,
        Minchan Kim <minchan@kernel.org>,
        Rik van Riel <riel@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>,
        Zi Yan <zi.yan@cs.rutgers.edu>
Subject: Re: [PATCH -mm -v4 14/21] mm, cgroup, THP, swap: Support to move
 swap account for PMD swap mapping
Message-ID: <20180710224923.lm5n7d2jot6pggw2@ca-dmjordan1.us.oracle.com>
References: <20180622035151.6676-1-ying.huang@intel.com>
 <20180622035151.6676-15-ying.huang@intel.com>
 <20180709172037.254zyuadep2hj5po@ca-dmjordan1.us.oracle.com>
 <87tvp7h6mx.fsf@yhuang-dev.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87tvp7h6mx.fsf@yhuang-dev.intel.com>
User-Agent: NeoMutt/20180323-268-5a959c
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8950 signatures=668706
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1806210000 definitions=main-1807100243
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 10, 2018 at 03:49:58PM +0800, Huang, Ying wrote:
> Daniel Jordan <daniel.m.jordan@oracle.com> writes:
> 
> > On Fri, Jun 22, 2018 at 11:51:44AM +0800, Huang, Ying wrote:
> >> Because there is no way to prevent a huge swap cluster from being
> >> split except when it has SWAP_HAS_CACHE flag set.
> >
> > What about making get_mctgt_type_thp take the cluster lock?  That function
> > would be the first lock_cluster user outside of swapfile.c, but it would
> > serialize with split_swap_cluster.
> >
> >> It is possible for
> >> the huge swap cluster to be split and the charge for the swap slots
> >> inside to be changed, after we check the PMD swap mapping and the huge
> >> swap cluster before we commit the charge moving.  But the race window
> >> is so small, that we will just ignore the race.
> >
> > Moving the charges is a slow path, so can't we just be correct here and not
> > leak?
> 
> Check the code and thought about this again, found the race may not
> exist.  Because the PMD is locked when get_mctgt_type_thp() is called
> until charge is completed for the PMD.  So the charge of the huge swap
> cluster cannot be changed at the same time even if the huge swap cluster
> is split by other processes.

That's true, the PMD lock does prevent the swap charge from going stale between
the time mem_cgroup_move_charge_pte_range identifies a huge swap entry in
get_mctgt_type_thp and the time it moves the charge in mem_cgroup_move_account,
at least for some events like swapping in pages.

> Right?

I'm not sure the PMD lock covers everything, but after looking a while longer
at this, the charge moving seems to be a best-effort feature in other respects,
so the accounting doesn't need to be completely accurate.
