Return-Path: <SRS0=pNWC=KQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED82BC28CF6
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 12:41:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A304A2083D
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 12:41:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A304A2083D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389211AbeHAO1b (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Aug 2018 10:27:31 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:33792 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1730355AbeHAO1a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Aug 2018 10:27:30 -0400
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w71CeoJd020439
        for <linux-kernel@vger.kernel.org>; Wed, 1 Aug 2018 08:41:53 -0400
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2kkbhgvgpc-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Wed, 01 Aug 2018 08:41:53 -0400
Received: from localhost
        by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <rppt@linux.vnet.ibm.com>;
        Wed, 1 Aug 2018 13:41:51 +0100
Received: from b06cxnps3075.portsmouth.uk.ibm.com (9.149.109.195)
        by e06smtp07.uk.ibm.com (192.168.101.137) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 1 Aug 2018 13:41:48 +0100
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w71CflkW42270962
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 1 Aug 2018 12:41:47 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 377FCA405D;
        Wed,  1 Aug 2018 15:41:58 +0100 (BST)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A7432A4055;
        Wed,  1 Aug 2018 15:41:57 +0100 (BST)
Received: from rapoport-lnx (unknown [9.148.8.176])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Wed,  1 Aug 2018 15:41:57 +0100 (BST)
Date:   Wed, 1 Aug 2018 15:41:45 +0300
From:   Mike Rapoport <rppt@linux.vnet.ibm.com>
To:     Richard Weinberger <richard@nod.at>
Cc:     Jeff Dike <jdike@addtoit.com>, Michal Hocko <mhocko@kernel.org>,
        linux-um@lists.infradead.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] um: switch to NO_BOOTMEM
References: <1532438594-4530-1-git-send-email-rppt@linux.vnet.ibm.com>
 <20180731133827.GC23494@rapoport-lnx>
 <1574741.Uvo42kyWiX@blindfold>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1574741.Uvo42kyWiX@blindfold>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-TM-AS-GCONF: 00
x-cbid: 18080112-0028-0000-0000-000002E39800
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18080112-0029-0000-0000-0000239BA4C2
Message-Id: <20180801124144.GF24836@rapoport-lnx>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-08-01_05:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=876 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1806210000 definitions=main-1808010133
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Richard,

On Tue, Jul 31, 2018 at 09:03:35PM +0200, Richard Weinberger wrote:
> Am Dienstag, 31. Juli 2018, 15:38:27 CEST schrieb Mike Rapoport:
> > Any comments on this?
> > 
> > On Tue, Jul 24, 2018 at 04:23:12PM +0300, Mike Rapoport wrote:
> > > Hi,
> > > 
> > > These patches convert UML to use NO_BOOTMEM.
> > > Tested on x86-64.
> > > 
> > > Mike Rapoport (2):
> > >   um: setup_physmem: stop using global variables
> > >   um: switch to NO_BOOTMEM
> > > 
> > >  arch/um/Kconfig.common   |  2 ++
> > >  arch/um/kernel/physmem.c | 22 ++++++++++------------
> > >  2 files changed, 12 insertions(+), 12 deletions(-)
> 
> Acked-by: Richard Weinberger <richard@nod.at>

Thanks!

Can you please merge this through the uml tree?
 
> Thanks,
> //richard
> 

-- 
Sincerely yours,
Mike.

