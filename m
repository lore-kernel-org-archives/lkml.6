Return-Path: <SRS0=Grn6=OM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D286C04EB9
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 16:15:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 50A7620834
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 16:15:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="MBAUGQOr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 50A7620834
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726735AbeLCQQA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Dec 2018 11:16:00 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:37732 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726622AbeLCQQA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Dec 2018 11:16:00 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id wB3GEPCY089493;
        Mon, 3 Dec 2018 16:15:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2018-07-02;
 bh=BkbNFQBfgnstOIx3KboiaWEFiJZRrzPEFLbZyiKK9Hw=;
 b=MBAUGQOrCv/i8DLHcJOgJuwmDhajzX2qNBFqI2UghzCWfckum2Y96xaZrnTO6hD2zXSh
 HIDrrwO0q+AUQG7NKaMja7KRxpsxK3LkBBA2HD6tpxTvZ5UjCn4CuY2ffsAXe3rLNRxi
 BEjgA8Aj50z3KKAYfVZBqXe5Bk3Cdr8zTbHRNVTmLRJiCDe3kWKnX+UIRUu/lb/sa/KP
 FeYh5/lvmm/NLsaCeUGPwO34BCL9rXMokwCKn+GfzX+F2oNFJcSmQ+lqfBWXjyc4HJ4l
 uOtJojS+ZeJE5S1XD769iTKCoZM50kC2Pou+5fyFydS6usoMtB2qw+Ew3G3Tkqm8ydOa TA== 
Received: from aserv0022.oracle.com (aserv0022.oracle.com [141.146.126.234])
        by aserp2120.oracle.com with ESMTP id 2p3j8q7bby-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 03 Dec 2018 16:15:36 +0000
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserv0022.oracle.com (8.14.4/8.14.4) with ESMTP id wB3GFUPa013923
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 3 Dec 2018 16:15:31 GMT
Received: from abhmp0003.oracle.com (abhmp0003.oracle.com [141.146.116.9])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id wB3GFRF8010280;
        Mon, 3 Dec 2018 16:15:27 GMT
Received: from ca-dmjordan1.us.oracle.com (/10.211.9.48)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 03 Dec 2018 08:15:26 -0800
Date:   Mon, 3 Dec 2018 08:15:38 -0800
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
Subject: Re: [PATCH -V7 RESEND 08/21] swap: Support to read a huge swap
 cluster for swapin a THP
Message-ID: <20181203161538.gxleg2ugdj2woadr@ca-dmjordan1.us.oracle.com>
References: <20181120085449.5542-1-ying.huang@intel.com>
 <20181120085449.5542-9-ying.huang@intel.com>
 <20181130233201.6yuzbhymtjddvf3u@ca-dmjordan1.us.oracle.com>
 <8736rirsox.fsf@yhuang-dev.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8736rirsox.fsf@yhuang-dev.intel.com>
User-Agent: NeoMutt/20180323-268-5a959c
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9096 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1812030153
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 01, 2018 at 08:34:06AM +0800, Huang, Ying wrote:
> Daniel Jordan <daniel.m.jordan@oracle.com> writes:
> > What do you think?
> 
> I think that swapoff() which is the main user of try_to_unuse() isn't a
> common operation in practical.  So it's not necessary to make it more
> complex for this.

Ok, probably not worth the surgery on try_to_unuse, even if swapoff can be
expensive when it does happen.

> In alloc_hugepage_direct_gfpmask(), the only information provided by vma
> is: vma->flags & VM_HUGEPAGE.  Because we have no vma available, I think
> it is OK to just assume that the flag is cleared.  That is, rely on
> system-wide THP settings only.
> 
> What do you think about this proposal?

Sounds like a good compromise.

So alloc_hugepage_direct_gfpmask will learn to make 'vma' optional?  Slightly
concerned that future callers that should be passing vma's might not and open a
way to ignore vma huge page hints, but probably not a big deal in practice.  
