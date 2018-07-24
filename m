Return-Path: <SRS0=hTZH=KI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0153CECDFB8
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 05:47:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B69A520856
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 05:47:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B69A520856
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388264AbeGXGv4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Jul 2018 02:51:56 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:51766 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2388146AbeGXGv4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jul 2018 02:51:56 -0400
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w6O5iQsN039714
        for <linux-kernel@vger.kernel.org>; Tue, 24 Jul 2018 01:47:12 -0400
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2kdwxq0n0p-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Tue, 24 Jul 2018 01:47:12 -0400
Received: from localhost
        by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <rppt@linux.vnet.ibm.com>;
        Tue, 24 Jul 2018 06:47:10 +0100
Received: from b06cxnps3075.portsmouth.uk.ibm.com (9.149.109.195)
        by e06smtp05.uk.ibm.com (192.168.101.135) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Tue, 24 Jul 2018 06:47:07 +0100
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w6O5l6uj40304676
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 24 Jul 2018 05:47:06 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 38961AE051;
        Tue, 24 Jul 2018 08:47:16 +0100 (BST)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B80E2AE04D;
        Tue, 24 Jul 2018 08:47:15 +0100 (BST)
Received: from rapoport-lnx (unknown [9.148.8.56])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Tue, 24 Jul 2018 08:47:15 +0100 (BST)
Date:   Tue, 24 Jul 2018 08:47:04 +0300
From:   Mike Rapoport <rppt@linux.vnet.ibm.com>
To:     Richard Kuo <rkuo@codeaurora.org>
Cc:     Michal Hocko <mhocko@kernel.org>, linux-hexagon@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] hexagon: switch to NO_BOOTMEM
References: <1531726998-10971-1-git-send-email-rppt@linux.vnet.ibm.com>
 <20180723212339.GA12771@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180723212339.GA12771@codeaurora.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-TM-AS-GCONF: 00
x-cbid: 18072405-0020-0000-0000-000002AA431C
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18072405-0021-0000-0000-000020F6D281
Message-Id: <20180724054704.GA16933@rapoport-lnx>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-07-24_02:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=872 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1806210000 definitions=main-1807240060
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 23, 2018 at 04:23:39PM -0500, Richard Kuo wrote:
> 
> On Mon, Jul 16, 2018 at 10:43:18AM +0300, Mike Rapoport wrote:
> > This patch adds registration of the system memory with memblock, eliminates
> > bootmem initialization and converts early memory reservations from bootmem
> > to memblock.
> > 
> > Signed-off-by: Mike Rapoport <rppt@linux.vnet.ibm.com>
> 
> Sorry for the delay, and thanks for this patch.
> 
> I think the first memblock_reserve should use ARCH_PFN_OFFSET instead of
> PHYS_OFFSET.

memblock_reserve gets physical address rather than a pfn.

If I read arch/hexagon/include/asm/mem-layout.h correctly, the PHYS_OFFSET
*is* the physical address of the RAM and ARCH_PFN_OFFSET is the first pfn:

#define PHYS_PFN_OFFSET	(PHYS_OFFSET >> PAGE_SHIFT)
#define ARCH_PFN_OFFSET	PHYS_PFN_OFFSET

Did I miss something?
 
> If you can amend that I'd be happy to take it through my tree or it can go
> through any other.
> 
> 
> Thanks,
> Richard Kuo
> 
> 
> -- 
> Employee of Qualcomm Innovation Center, Inc.
> Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum, 
> a Linux Foundation Collaborative Project
> 

-- 
Sincerely yours,
Mike.

