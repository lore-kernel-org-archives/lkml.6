Return-Path: <SRS0=k9B+=NF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9770C46475
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 15:01:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7227020848
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 15:01:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="tdQRpL1T"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7227020848
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727647AbeJYXeQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Oct 2018 19:34:16 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:59322 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727319AbeJYXeQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Oct 2018 19:34:16 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w9PErkNW010456;
        Thu, 25 Oct 2018 15:00:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2018-07-02;
 bh=zmTg2D6xuKkEdcnOn4Vt7RzBdmgpfGo0x7BWSWPDc7s=;
 b=tdQRpL1TWhqWKjGKy9K/b8N1tTzHHseLhfxk7f5pNu9B/+5gqPr/WWp08nCZ5qups7N/
 n60xbVBzb7puPyZm7B51KexTCtfqhGak6WwPQPUsHHOe1mTc5uJcoDhJI9kYGl5XomBF
 Uj+BSgi+o2kx25+9Kv/ZNLAg3t4Dtz8sGs1I5s7fUdhpCmXr/juqynn1PULa5+S8nqg8
 8D8SSs7KqxhaOUe5mS6tK/8IY1AsVsP5CDKPEZ01HEuy2+AveZBxKodvEkDO1KGc63Kw
 cf4jB1zmoL2sM+qOGidYujiFJdw4FdyLZmmAE/hUs0JRqOfGm1ClrgyctAlJi5TXF002 Kg== 
Received: from aserv0021.oracle.com (aserv0021.oracle.com [141.146.126.233])
        by userp2130.oracle.com with ESMTP id 2n7usuj7d1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 25 Oct 2018 15:00:43 +0000
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserv0021.oracle.com (8.14.4/8.14.4) with ESMTP id w9PF0gq4021842
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 25 Oct 2018 15:00:42 GMT
Received: from abhmp0006.oracle.com (abhmp0006.oracle.com [141.146.116.12])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id w9PF0ehY005373;
        Thu, 25 Oct 2018 15:00:40 GMT
Received: from ca-dmjordan1.us.oracle.com (/10.211.9.48)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 25 Oct 2018 08:00:39 -0700
Date:   Thu, 25 Oct 2018 08:00:44 -0700
From:   Daniel Jordan <daniel.m.jordan@oracle.com>
To:     "Huang, Ying" <ying.huang@intel.com>
Cc:     Daniel Jordan <daniel.m.jordan@oracle.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Michal Hocko <mhocko@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Shaohua Li <shli@kernel.org>, Hugh Dickins <hughd@google.com>,
        Minchan Kim <minchan@kernel.org>,
        Rik van Riel <riel@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>,
        Zi Yan <zi.yan@cs.rutgers.edu>
Subject: Re: [PATCH -V6 06/21] swap: Support PMD swap mapping when splitting
 huge PMD
Message-ID: <20181025150044.urvklakbzd6jauyb@ca-dmjordan1.us.oracle.com>
References: <20181010071924.18767-1-ying.huang@intel.com>
 <20181010071924.18767-7-ying.huang@intel.com>
 <20181024172549.xyevip5kclq2ig33@ca-dmjordan1.us.oracle.com>
 <87bm7ivoav.fsf@yhuang-dev.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87bm7ivoav.fsf@yhuang-dev.intel.com>
User-Agent: NeoMutt/20180323-268-5a959c
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9056 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1807170000 definitions=main-1810250127
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 25, 2018 at 08:54:16AM +0800, Huang, Ying wrote:
> Daniel Jordan <daniel.m.jordan@oracle.com> writes:
> 
> > On Wed, Oct 10, 2018 at 03:19:09PM +0800, Huang Ying wrote:
> >> +#ifdef CONFIG_THP_SWAP
> >> +/*
> >> + * The corresponding page table shouldn't be changed under us, that
> >> + * is, the page table lock should be held.
> >> + */
> >> +int split_swap_cluster_map(swp_entry_t entry)
> >> +{
> >> +	struct swap_info_struct *si;
> >> +	struct swap_cluster_info *ci;
> >> +	unsigned long offset = swp_offset(entry);
> >> +
> >> +	VM_BUG_ON(!IS_ALIGNED(offset, SWAPFILE_CLUSTER));
> >> +	si = _swap_info_get(entry);
> >> +	if (!si)
> >> +		return -EBUSY;
> >
> > I think this return value doesn't get used anywhere?
> 
> Yes.  And the error is only possible if page table is corrupted.  So
> maybe add a VM_BUG_ON() in it caller __split_huge_swap_pmd()?

Taking a second look at this, I see we'd get some nice pr_err message in this
case, so VM_BUG_ON doesn't seem necessary.

Still odd there's an unchecked return value, but it could be useful to future
callers.  Just my nitpick, feel free to leave as is.
