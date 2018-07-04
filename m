Return-Path: <SRS0=cgxA=JU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AF16C3279B
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 15:21:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E19272145D
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 15:21:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E19272145D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752846AbeGDPVE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Jul 2018 11:21:04 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:34498 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752260AbeGDPVD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jul 2018 11:21:03 -0400
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w64FJ3Fi091886
        for <linux-kernel@vger.kernel.org>; Wed, 4 Jul 2018 11:21:02 -0400
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2k0v9skwy5-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Wed, 04 Jul 2018 11:21:02 -0400
Received: from localhost
        by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <rppt@linux.vnet.ibm.com>;
        Wed, 4 Jul 2018 16:21:00 +0100
Received: from b06cxnps4076.portsmouth.uk.ibm.com (9.149.109.198)
        by e06smtp01.uk.ibm.com (192.168.101.131) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 4 Jul 2018 16:20:57 +0100
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w64FKuDn32112772
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 4 Jul 2018 15:20:56 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7EAE5A405B;
        Wed,  4 Jul 2018 18:21:21 +0100 (BST)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id CFF51A4051;
        Wed,  4 Jul 2018 18:21:20 +0100 (BST)
Received: from rapoport-lnx (unknown [9.148.8.160])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Wed,  4 Jul 2018 18:21:20 +0100 (BST)
Date:   Wed, 4 Jul 2018 18:20:54 +0300
From:   Mike Rapoport <rppt@linux.vnet.ibm.com>
To:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Cc:     Joe Perches <joe@perches.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-mm <linux-mm@kvack.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Michal Hocko <mhocko@kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH] mm/memblock: replace u64 with phys_addr_t where
 appropriate
References: <1530637506-1256-1-git-send-email-rppt@linux.vnet.ibm.com>
 <20180703125722.6fd0f02b27c01f5684877354@linux-foundation.org>
 <063c785caa11b8e1c421c656b2a030d45d6eb68f.camel@perches.com>
 <20180704070305.GB4352@rapoport-lnx>
 <20180704072308.GA458@jagdpanzerIV>
 <8dc61092669356f5417bc275e3b7c69ce637e63e.camel@perches.com>
 <20180704092042.GC458@jagdpanzerIV>
 <20180704094344.GD458@jagdpanzerIV>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180704094344.GD458@jagdpanzerIV>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-TM-AS-GCONF: 00
x-cbid: 18070415-4275-0000-0000-00000295251A
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18070415-4276-0000-0000-0000379CAA57
Message-Id: <20180704152053.GJ4352@rapoport-lnx>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-07-04_05:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1806210000 definitions=main-1807040177
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 04, 2018 at 06:43:44PM +0900, Sergey Senozhatsky wrote:
> On (07/04/18 18:20), Sergey Senozhatsky wrote:
> > > There's this saying about habits made to be broken.
> > > This is one of those habits.
> > > 
> > > I'd expect more people probably get the %pS or %ps wrong
> > > than use %pF.
> > > 
> > > And most people probably look for examples in code and
> > > copy instead of thinking what's correct, so removing old
> > > and deprecated uses from existing code is a good thing.
> > 
> > Well, I don't NACK the patch, I just want to keep pf/pF in vsprintf(),
> > that's it. Yes, checkpatch warns about pf/pF uses, becuase we don't want
> > any new pf/pF in the code - it's rather confusing to have both pf/pF and
> > ps/pS -- but I don't necessarily see why would we want to mess up with
> > parisc/hppa/ia64 people using pf/pF for debugging purposes, etc. I'm not
> > married to pf/pF, if you guys insist on complete removal of pf/pF then so
> > be it.
> 
> And just for the record - I think the reason why I didn't feel like
> doing a tree wide pf->ps conversion was that some of those pf->ps
> printk-s could end up in -stable backports [sure, no one backports
> print out changes, but a print out can be part of a fix which gets
> backported, etc]. So I just decided to stay away from this. IIRC.

Well, this is true for any printk that uses %p[sS]. There were plenty of
those even when %pf and %ps were different... 
 
> 	-ss
> 

-- 
Sincerely yours,
Mike.

