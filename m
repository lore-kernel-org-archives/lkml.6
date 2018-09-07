Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E93F1C4321E
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 09:19:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 96E14204FD
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 09:19:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 96E14204FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728283AbeIGN7j (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 09:59:39 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:52904 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727093AbeIGN7i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 09:59:38 -0400
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w879InFM099396
        for <linux-kernel@vger.kernel.org>; Fri, 7 Sep 2018 05:19:35 -0400
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2mbp219duw-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Fri, 07 Sep 2018 05:19:35 -0400
Received: from localhost
        by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <rppt@linux.vnet.ibm.com>;
        Fri, 7 Sep 2018 10:19:33 +0100
Received: from b06cxnps3074.portsmouth.uk.ibm.com (9.149.109.194)
        by e06smtp04.uk.ibm.com (192.168.101.134) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Fri, 7 Sep 2018 10:19:27 +0100
Received: from d06av24.portsmouth.uk.ibm.com (d06av24.portsmouth.uk.ibm.com [9.149.105.60])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w879JQSK63766580
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 7 Sep 2018 09:19:26 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2176842041;
        Fri,  7 Sep 2018 12:19:20 +0100 (BST)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9B31342045;
        Fri,  7 Sep 2018 12:19:18 +0100 (BST)
Received: from rapoport-lnx (unknown [9.148.207.119])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Fri,  7 Sep 2018 12:19:18 +0100 (BST)
Date:   Fri, 7 Sep 2018 12:19:22 +0300
From:   Mike Rapoport <rppt@linux.vnet.ibm.com>
To:     Michal Hocko <mhocko@kernel.org>
Cc:     Rob Herring <robh@kernel.org>, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>, davem@davemloft.net,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        mingo@redhat.com, Michael Ellerman <mpe@ellerman.id.au>,
        paul.burton@mips.com, Thomas Gleixner <tglx@linutronix.de>,
        tony.luck@intel.com, linux-ia64@vger.kernel.org,
        linux-mips@linux-mips.org, linuxppc-dev@lists.ozlabs.org,
        sparclinux@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH 07/29] memblock: remove _virt from APIs returning
 virtual address
References: <1536163184-26356-8-git-send-email-rppt@linux.vnet.ibm.com>
 <CABGGiswdb1x-=vqrgxZ9i2dnLdsgtXq4+5H9Y1JRd90YVMW69A@mail.gmail.com>
 <20180905172017.GA2203@rapoport-lnx>
 <20180906072800.GN14951@dhcp22.suse.cz>
 <20180906124321.GD27492@rapoport-lnx>
 <20180906130102.GY14951@dhcp22.suse.cz>
 <20180906133958.GM27492@rapoport-lnx>
 <20180906134627.GZ14951@dhcp22.suse.cz>
 <20180907084211.GA19153@rapoport-lnx>
 <20180907084756.GD19621@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180907084756.GD19621@dhcp22.suse.cz>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-TM-AS-GCONF: 00
x-cbid: 18090709-0016-0000-0000-00000201B183
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18090709-0017-0000-0000-000032586100
Message-Id: <20180907091922.GB19153@rapoport-lnx>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-09-07_06:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1809070096
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 07, 2018 at 10:47:56AM +0200, Michal Hocko wrote:
> On Fri 07-09-18 11:42:12, Mike Rapoport wrote:
> > On Thu, Sep 06, 2018 at 03:46:27PM +0200, Michal Hocko wrote:
> > > On Thu 06-09-18 16:39:58, Mike Rapoport wrote:
> > > > On Thu, Sep 06, 2018 at 03:01:02PM +0200, Michal Hocko wrote:
> > > > > On Thu 06-09-18 15:43:21, Mike Rapoport wrote:
> > > > > > On Thu, Sep 06, 2018 at 09:28:00AM +0200, Michal Hocko wrote:
> > > > > > > On Wed 05-09-18 20:20:18, Mike Rapoport wrote:
> > > > > > > > On Wed, Sep 05, 2018 at 12:04:36PM -0500, Rob Herring wrote:
> > > > > > > > > On Wed, Sep 5, 2018 at 11:00 AM Mike Rapoport <rppt@linux.vnet.ibm.com> wrote:
> > > > > > > > > >
> > > > > > > > > > The conversion is done using
> > > > > > > > > >
> > > > > > > > > > sed -i 's@memblock_virt_alloc@memblock_alloc@g' \
> > > > > > > > > >         $(git grep -l memblock_virt_alloc)
> > > > > > > > > 
> > > > > > > > > What's the reason to do this? It seems like a lot of churn even if a
> > > > > > > > > mechanical change.
> > > > > > > > 
> > > > > > > > I felt that memblock_virt_alloc_ is too long for a prefix, e.g:
> > > > > > > > memblock_virt_alloc_node_nopanic, memblock_virt_alloc_low_nopanic.
> > > > > > > > 
> > > > > > > > And for consistency I've changed the memblock_virt_alloc as well.
> > > > > > > 
> > > > > > > I would keep the current API unless the name is terribly misleading or
> > > > > > > it can be improved a lot. Neither seems to be the case here. So I would
> > > > > > > rather stick with the status quo.
> > > > > > 
> > > > > > I'm ok with the memblock_virt_alloc by itself, but having 'virt' in
> > > > > > 'memblock_virt_alloc_try_nid_nopanic' and 'memblock_virt_alloc_low_nopanic'
> > > > > > reduces code readability in my opinion.
> > > > > 
> > > > > Well, is _nopanic really really useful in the name. Do we even need/want
> > > > > implicit panic/nopanic semantic? The code should rather check for the
> > > > > return value and decide depending on the code path. I suspect removing
> > > > > panic/nopanic would make the API slightly lighter.
> > > >  
> > > > I agree that panic/nopanic should be removed. But I prefer to start with
> > > > equivalent replacement to make it as automated as possible and update
> > > > memblock API when the dust settles a bit.
> > > 
> > > Yes, I agree with that approach. But that also doesn't justify the
> > > renaming
> > 
> > Well, the renaming is automated :)
> 
> Yes, it is. It also adds churn to the code so I tend to prefer an
> existing naming unless it is completely misleading or incomprehensible.
> 
> Is this something to lose sleep over. Absolutely not! Does it make sense
> to discuss further? I do not think so. If you strongly believe that the
> renaming is a good thing then just do it.

I won't lose my sleep over it, but I do believe that renaming is a good thing. 
I think that in the end we'll be able to reduce the memblock allocation API
to a handful of memblock_alloc_ variants instead of ~20 we have now.

> -- 
> Michal Hocko
> SUSE Labs
> 

-- 
Sincerely yours,
Mike.

