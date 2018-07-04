Return-Path: <SRS0=cgxA=JU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D907FC6778C
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 12:57:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A09CE242F0
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 12:57:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A09CE242F0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753357AbeGDM5d (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Jul 2018 08:57:33 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:55904 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1752426AbeGDM5a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jul 2018 08:57:30 -0400
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w64Ct9ul057850
        for <linux-kernel@vger.kernel.org>; Wed, 4 Jul 2018 08:57:30 -0400
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2k0uupfch2-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Wed, 04 Jul 2018 08:57:29 -0400
Received: from localhost
        by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <rppt@linux.vnet.ibm.com>;
        Wed, 4 Jul 2018 13:57:28 +0100
Received: from b06cxnps3074.portsmouth.uk.ibm.com (9.149.109.194)
        by e06smtp04.uk.ibm.com (192.168.101.134) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 4 Jul 2018 13:57:24 +0100
Received: from d06av24.portsmouth.uk.ibm.com (mk.ibm.com [9.149.105.60])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w64CvNNE42467450
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 4 Jul 2018 12:57:23 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9E0104203F;
        Wed,  4 Jul 2018 15:57:48 +0100 (BST)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id EEF3342042;
        Wed,  4 Jul 2018 15:57:47 +0100 (BST)
Received: from rapoport-lnx (unknown [9.148.8.160])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Wed,  4 Jul 2018 15:57:47 +0100 (BST)
Date:   Wed, 4 Jul 2018 15:57:21 +0300
From:   Mike Rapoport <rppt@linux.vnet.ibm.com>
To:     Michal Hocko <mhocko@kernel.org>
Cc:     Vlastimil Babka <vbabka@suse.cz>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Greg Ungerer <gerg@linux-m68k.org>,
        Sam Creasey <sammy@sammy.net>,
        linux-m68k <linux-m68k@lists.linux-m68k.org>,
        Linux MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 3/3] m68k: switch to MEMBLOCK + NO_BOOTMEM
References: <1530685696-14672-1-git-send-email-rppt@linux.vnet.ibm.com>
 <1530685696-14672-4-git-send-email-rppt@linux.vnet.ibm.com>
 <CAMuHMdWEHSz34bN-U3gHW972w13f_Jrx_ObEsP3w8XZ1Gx65OA@mail.gmail.com>
 <20180704075410.GF22503@dhcp22.suse.cz>
 <89f48f7a-6cbf-ac9a-cacc-cd3ca79f8c66@suse.cz>
 <20180704123627.GM22503@dhcp22.suse.cz>
 <20180704124335.GE4352@rapoport-lnx>
 <20180704125121.GO22503@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180704125121.GO22503@dhcp22.suse.cz>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-TM-AS-GCONF: 00
x-cbid: 18070412-0016-0000-0000-000001E34E18
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18070412-0017-0000-0000-00003237B3F2
Message-Id: <20180704125720.GG4352@rapoport-lnx>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-07-04_04:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1806210000 definitions=main-1807040149
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 04, 2018 at 02:51:21PM +0200, Michal Hocko wrote:
> On Wed 04-07-18 15:43:35, Mike Rapoport wrote:
> > On Wed, Jul 04, 2018 at 02:36:27PM +0200, Michal Hocko wrote:
> [...]
> > > diff --git a/mm/memblock.c b/mm/memblock.c
> > > index 03d48d8835ba..2acec4033389 100644
> > > --- a/mm/memblock.c
> > > +++ b/mm/memblock.c
> > > @@ -227,7 +227,8 @@ phys_addr_t __init_memblock memblock_find_in_range_node(phys_addr_t size,
> > >  		 * so we use WARN_ONCE() here to see the stack trace if
> > >  		 * fail happens.
> > >  		 */
> > > -		WARN_ONCE(1, "memblock: bottom-up allocation failed, memory hotunplug may be affected\n");
> > > +		WARN_ONCE(IS_ENABLED(CONFIG_MEMORY_HOTREMOVE),
> > > +					"memblock: bottom-up allocation failed, memory hotremove may be affected\n");
> > 
> > nit: isn't the warning indented too much?
> 
> this is what vim did for me. The string doesn't fit into 80 even if I
> indented it to the first bracket. If you feel strongly I can do that
> though.

Not really. With wrapping if looks better like this :) 
 
> -- 
> Michal Hocko
> SUSE Labs
> 

-- 
Sincerely yours,
Mike.

