Return-Path: <SRS0=KJEp=QB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B3D3C282C0
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 19:25:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6300D218D0
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 19:25:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729311AbfAYTZQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Jan 2019 14:25:16 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:36998 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727955AbfAYTZP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Jan 2019 14:25:15 -0500
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x0PJNgxj077137
        for <linux-kernel@vger.kernel.org>; Fri, 25 Jan 2019 14:25:14 -0500
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2q85bnhb4m-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Fri, 25 Jan 2019 14:25:13 -0500
Received: from localhost
        by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <rppt@linux.ibm.com>;
        Fri, 25 Jan 2019 19:25:12 -0000
Received: from b06cxnps3075.portsmouth.uk.ibm.com (9.149.109.195)
        by e06smtp03.uk.ibm.com (192.168.101.133) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Fri, 25 Jan 2019 19:25:08 -0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x0PJP7TT57737222
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 25 Jan 2019 19:25:07 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B61DD11C04C;
        Fri, 25 Jan 2019 19:25:07 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8A6C611C04A;
        Fri, 25 Jan 2019 19:25:06 +0000 (GMT)
Received: from rapoport-lnx (unknown [9.148.204.72])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Fri, 25 Jan 2019 19:25:06 +0000 (GMT)
Date:   Fri, 25 Jan 2019 21:25:04 +0200
From:   Mike Rapoport <rppt@linux.ibm.com>
To:     Michal Hocko <mhocko@kernel.org>
Cc:     linux-mm@kvack.org, Pingfan Liu <kernelfans@gmail.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Peter Zijlstra <peterz@infradead.org>, x86@kernel.org,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Tony Luck <tony.luck@intel.com>, linuxppc-dev@lists.ozlabs.org,
        linux-ia64@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH] x86, numa: always initialize all possible nodes
References: <20190114082416.30939-1-mhocko@kernel.org>
 <20190124141727.GN4087@dhcp22.suse.cz>
 <20190124175144.GF13790@rapoport-lnx>
 <20190125104023.GI3560@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190125104023.GI3560@dhcp22.suse.cz>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-TM-AS-GCONF: 00
x-cbid: 19012519-0012-0000-0000-000002ED0C9E
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19012519-0013-0000-0000-0000212445D7
Message-Id: <20190125192504.GG31519@rapoport-lnx>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-01-25_12:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=925 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1901250151
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 25, 2019 at 11:40:23AM +0100, Michal Hocko wrote:
> On Thu 24-01-19 19:51:44, Mike Rapoport wrote:
> > On Thu, Jan 24, 2019 at 03:17:27PM +0100, Michal Hocko wrote:
> > > a friendly ping for this. Does anybody see any problem with this
> > > approach?
> > 
> > FWIW, it looks fine to me.
> > 
> > It'd just be nice to have a few more words in the changelog about *how* the
> > x86 init was reworked ;-)
> 
> Heh, I thought it was there but nope... It probably just existed in my
> head. Sorry about that. What about the following paragraphs added?
> "
> The new code relies on the arch specific initialization to allocate all
> possible NUMA nodes (including memory less) - numa_register_memblks in
> this case. Generic code then initializes both zonelists (__build_all_zonelists)
> and allocator internals (free_area_init_nodes) for all non-null pgdats
> rather than online ones.
> 
> For the x86 specific part also do not make new node online in alloc_node_data
> because this is too early to know that. numa_register_memblks knows that
> a node has some memory so it can make the node online appropriately.
> init_memory_less_node hack can be safely removed altogether now.
> "

LGTM, thanks!
 
> -- 
> Michal Hocko
> SUSE Labs
> 

-- 
Sincerely yours,
Mike.

