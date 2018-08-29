Return-Path: <SRS0=I82Q=LM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FDA7C433F4
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 07:20:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 022EB20844
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 07:20:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 022EB20844
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727711AbeH2LQA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Aug 2018 07:16:00 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:53746 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726858AbeH2LP7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Aug 2018 07:15:59 -0400
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w7T7J733117551
        for <linux-kernel@vger.kernel.org>; Wed, 29 Aug 2018 03:20:29 -0400
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2m5n8rkpv2-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Wed, 29 Aug 2018 03:20:29 -0400
Received: from localhost
        by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <rppt@linux.vnet.ibm.com>;
        Wed, 29 Aug 2018 08:20:27 +0100
Received: from b06cxnps3075.portsmouth.uk.ibm.com (9.149.109.195)
        by e06smtp04.uk.ibm.com (192.168.101.134) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 29 Aug 2018 08:20:23 +0100
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w7T7KMAH34406534
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 29 Aug 2018 07:20:22 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E6C05A4040;
        Wed, 29 Aug 2018 10:20:18 +0100 (BST)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 15A2AA405B;
        Wed, 29 Aug 2018 10:20:18 +0100 (BST)
Received: from rapoport-lnx (unknown [9.148.8.172])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Wed, 29 Aug 2018 10:20:17 +0100 (BST)
Date:   Wed, 29 Aug 2018 10:20:19 +0300
From:   Mike Rapoport <rppt@linux.vnet.ibm.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Richard Kuo <rkuo@codeaurora.org>, Ley Foon Tan <lftan@altera.com>,
        Richard Weinberger <richard@nod.at>,
        Guan Xuetao <gxt@pku.edu.cn>, Michal Hocko <mhocko@kernel.org>,
        linux-hexagon@vger.kernel.org, nios2-dev@lists.rocketboards.org,
        linux-um@lists.infradead.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH RESEND 0/7] switch several architectures NO_BOOTMEM
References: <1533326330-31677-1-git-send-email-rppt@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1533326330-31677-1-git-send-email-rppt@linux.vnet.ibm.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-TM-AS-GCONF: 00
x-cbid: 18082907-0016-0000-0000-000001FD3714
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18082907-0017-0000-0000-00003253ABA8
Message-Id: <20180829072019.GA13173@rapoport-lnx>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-08-29_02:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=791 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1808290081
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Any updates on this?

On Fri, Aug 03, 2018 at 10:58:43PM +0300, Mike Rapoport wrote:
> 
> Hi,
> 
> These patches perform conversion to NO_BOOTMEM of hexagon, nios2, uml and
> unicore32. The architecture maintainers have acked the patches, but, since
> I've got no confirmation the patches are going through the arch tree I'd
> appreciate if the set would be applied to the -mm tree.
> 
> Mike Rapoport (7):
>   hexagon: switch to NO_BOOTMEM
>   of: ignore sub-page memory regions
>   nios2: use generic early_init_dt_add_memory_arch
>   nios2: switch to NO_BOOTMEM
>   um: setup_physmem: stop using global variables
>   um: switch to NO_BOOTMEM
>   unicore32: switch to NO_BOOTMEM
> 
>  arch/hexagon/Kconfig      |  3 +++
>  arch/hexagon/mm/init.c    | 20 +++++++-----------
>  arch/nios2/Kconfig        |  3 +++
>  arch/nios2/kernel/prom.c  | 17 ---------------
>  arch/nios2/kernel/setup.c | 39 ++++++----------------------------
>  arch/um/Kconfig.common    |  2 ++
>  arch/um/kernel/physmem.c  | 22 +++++++++----------
>  arch/unicore32/Kconfig    |  1 +
>  arch/unicore32/mm/init.c  | 54 +----------------------------------------------
>  drivers/of/fdt.c          | 11 +++++-----
>  10 files changed, 41 insertions(+), 131 deletions(-)
> 
> -- 
> 2.7.4
> 

-- 
Sincerely yours,
Mike.

