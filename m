Return-Path: <SRS0=VxZE=JO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5382DC43141
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 15:19:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 01E3A2087A
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 15:19:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 01E3A2087A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965073AbeF1PTm (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Jun 2018 11:19:42 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:36916 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S935426AbeF1PTl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jun 2018 11:19:41 -0400
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w5SFEACS139364
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jun 2018 11:19:40 -0400
Received: from e11.ny.us.ibm.com (e11.ny.us.ibm.com [129.33.205.201])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2jvyckrsau-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jun 2018 11:19:40 -0400
Received: from localhost
        by e11.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Thu, 28 Jun 2018 11:19:39 -0400
Received: from b01cxnp23032.gho.pok.ibm.com (9.57.198.27)
        by e11.ny.us.ibm.com (146.89.104.198) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Thu, 28 Jun 2018 11:19:34 -0400
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp23032.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w5SFJXgX19595580
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 28 Jun 2018 15:19:34 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C20EDB2065;
        Thu, 28 Jun 2018 11:19:24 -0400 (EDT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9CE7AB2064;
        Thu, 28 Jun 2018 11:19:24 -0400 (EDT)
Received: from paulmck-ThinkPad-W541 (unknown [9.70.82.159])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Thu, 28 Jun 2018 11:19:24 -0400 (EDT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id 7BE0D16C3746; Thu, 28 Jun 2018 08:21:40 -0700 (PDT)
Date:   Thu, 28 Jun 2018 08:21:40 -0700
From:   "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
To:     Andrea Parri <andrea.parri@amarulasolutions.com>
Cc:     Mark Rutland <mark.rutland@arm.com>, linux-kernel@vger.kernel.org,
        akiyks@gmail.com, boqun.feng@gmail.com, dhowells@redhat.com,
        j.alglave@ucl.ac.uk, luc.maranget@inria.fr, npiggin@gmail.com,
        peterz@infradead.org, stern@rowland.harvard.edu,
        will.deacon@arm.com
Subject: Re: [PATCH 0/2] tools/memory-model: remove ACCESS_ONCE()
Reply-To: paulmck@linux.vnet.ibm.com
References: <20180628123347.52963-1-mark.rutland@arm.com>
 <20180628123845.GA14456@andrea>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180628123845.GA14456@andrea>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 18062815-2213-0000-0000-000002C15D01
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009271; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000266; SDB=6.01053592; UDB=6.00540222; IPR=6.00831514;
 MB=3.00021908; MTD=3.00000008; XFM=3.00000015; UTC=2018-06-28 15:19:38
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18062815-2214-0000-0000-00005AA39E6A
Message-Id: <20180628152140.GK3593@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-06-28_07:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1806210000 definitions=main-1806280173
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 28, 2018 at 02:38:45PM +0200, Andrea Parri wrote:
> On Thu, Jun 28, 2018 at 01:33:45PM +0100, Mark Rutland wrote:
> > Since commit:
> >     
> >   b899a850431e2dd0 ("compiler.h: Remove ACCESS_ONCE()")
> >     
> > ... there has been no definition of ACCESS_ONCE() in the kernel tree,
> > and it has been necessary to use READ_ONCE() or WRITE_ONCE() instead.
> > 
> > However, since then the kernel memory model was added to the Linux tree,
> > sporting new instances of ACCESS_ONCE() in examples and in the memory
> > model itself.
> > 
> > These patches remove the new instances of ACCESS_ONCE() for consistency
> > with the contemporary codebase.
> > 
> > Thanks,
> > Mark.
> > 
> > Mark Rutland (2):
> >   tools/memory-model: remove ACCESS_ONCE() from recipes
> >   tools/memory-model: remove ACCESS_ONCE() from model
> 
> For the series:
> 
> Acked-by: Andrea Parri <andrea.parri@amarulasolutions.com>

Applied, thank you both!  These both are ready for the upcoming merge
window.

While I am at it, here is the current scorecard:

e9ff68680cd4 tools/memory-model: Add litmus test for full multicopy atomicity
c21fcc6594f1 tools/memory-model: Fix ISA2+pooncelock+pooncelock+pombonce name
aa838e0b70e1 MAINTAINERS: Add Daniel Lustig as an LKMM reviewer
3cb0d7701c4c locking/memory-barriers.txt/kokr: Update Korean translation to fix broken DMA vs. MMIO ordering example
0bde941f3629 tools/memory-model: Remove ACCESS_ONCE() from recipes
80b7b05c3aa0 tools/memory-model: Remove ACCESS_ONCE() from model

	The above patches are ready for the upcoming merge window because
	each has at least one Acked-by or Reviewed-by.

6098ce88bc4d tools/memory-model: Make scripts executable
5bb22d0126f9 tools/memory-model: Rename litmus tests to comply to norm7
1bc179880fba docs: atomic_ops: Describe atomic_set as a write operation

	The above patches need at least one additional Acked-by
	or Reviewed-by.  If any of you gets a chance, please do
	look them over.

51b0a8985c5a EXP tools/memory-model: Add litmus-test naming scheme

	This patch needs me to get Will Deacon's feedback applied.  :-/

06e99a0d9662 EXP tools/memory-model: Add .cfg and .cat files for s390

	This is a placeholder, and probably won't ever go upstream
	into the Linux kernel.  (Maybe someday into herd where the
	other architecture-specific .cat files live.)

							Thanx, Paul

> Cheers,
>   Andrea
> 
> 
> > 
> >  tools/memory-model/Documentation/recipes.txt | 4 ++--
> >  tools/memory-model/linux-kernel.bell         | 2 +-
> >  2 files changed, 3 insertions(+), 3 deletions(-)
> > 
> > -- 
> > 2.11.0
> > 
> 

