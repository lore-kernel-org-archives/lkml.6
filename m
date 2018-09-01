Return-Path: <SRS0=kg8+=LP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC426C43334
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Sep 2018 17:10:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 956C02083B
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Sep 2018 17:10:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 956C02083B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727247AbeIAVVk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 1 Sep 2018 17:21:40 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:53822 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726953AbeIAVVk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Sep 2018 17:21:40 -0400
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w81Gx3J5058490
        for <linux-kernel@vger.kernel.org>; Sat, 1 Sep 2018 13:09:01 -0400
Received: from e17.ny.us.ibm.com (e17.ny.us.ibm.com [129.33.205.207])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2m7qaev9qb-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Sat, 01 Sep 2018 13:09:01 -0400
Received: from localhost
        by e17.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Sat, 1 Sep 2018 13:08:59 -0400
Received: from b01cxnp22035.gho.pok.ibm.com (9.57.198.25)
        by e17.ny.us.ibm.com (146.89.104.204) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Sat, 1 Sep 2018 13:08:55 -0400
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp22035.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w81H8sO143188372
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Sat, 1 Sep 2018 17:08:54 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 91DA6B2066;
        Sat,  1 Sep 2018 13:07:46 -0400 (EDT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6CEE5B2064;
        Sat,  1 Sep 2018 13:07:46 -0400 (EDT)
Received: from paulmck-ThinkPad-W541 (unknown [9.80.237.165])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Sat,  1 Sep 2018 13:07:46 -0400 (EDT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id 0400316C0659; Sat,  1 Sep 2018 10:08:54 -0700 (PDT)
Date:   Sat, 1 Sep 2018 10:08:54 -0700
From:   "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
To:     Will Deacon <will.deacon@arm.com>
Cc:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        mingo@kernel.org, stern@rowland.harvard.edu,
        parri.andrea@gmail.com, peterz@infradead.org, boqun.feng@gmail.com,
        npiggin@gmail.com, dhowells@redhat.com, j.alglave@ucl.ac.uk,
        luc.maranget@inria.fr, akiyks@gmail.com
Subject: Re: [PATCH RFC LKMM 7/7] EXP tools/memory-model: Add .cfg and .cat
 files for s390
Reply-To: paulmck@linux.vnet.ibm.com
References: <20180829211018.GA19646@linux.vnet.ibm.com>
 <20180829211053.20531-7-paulmck@linux.vnet.ibm.com>
 <20180831160630.GF30626@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180831160630.GF30626@arm.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 18090117-0040-0000-0000-00000468E05E
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009652; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000266; SDB=6.01082071; UDB=6.00558293; IPR=6.00862058;
 MB=3.00023059; MTD=3.00000008; XFM=3.00000015; UTC=2018-09-01 17:08:59
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18090117-0041-0000-0000-0000086FFE4F
Message-Id: <20180901170854.GM4225@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-09-01_08:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1809010190
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 31, 2018 at 05:06:30PM +0100, Will Deacon wrote:
> Hi Paul,
> 
> On Wed, Aug 29, 2018 at 02:10:53PM -0700, Paul E. McKenney wrote:
> > This commit adds s390.cat and s390.cfg files to allow users to check
> > litmus tests for s390-specific code.  Note that this change only enables
> > herd7 checking of C-language litmus tests.  Larger changes are required
> > to enable the litmus7 and klitmus7 tools to check litmus tests on real
> > hardare.
> > 
> > Suggested-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
> > Suggested-by: Christian Borntraeger <borntraeger@de.ibm.com>
> > Signed-off-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
> > [ paulmck: Add fixes suggested by Alan Stern. ]
> > ---
> >  tools/memory-model/s390.cat | 18 ++++++++++++++++++
> >  tools/memory-model/s390.cfg | 21 +++++++++++++++++++++
> >  2 files changed, 39 insertions(+)
> >  create mode 100644 tools/memory-model/s390.cat
> >  create mode 100644 tools/memory-model/s390.cfg
> 
> As I said before, I'd *much* prefer this to be part of the upstream
> herdtools7 repository. It's not really anything to do with the Linux
> kernel, so I don't think it belongs in the source tree.

Agreed.  As the cover letter says, "Add .cfg and .cat files for s390,
which is a not-for-mainline placeholder."

							Thanx, Paul

