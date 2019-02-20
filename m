Return-Path: <SRS0=sczE=Q3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E50EAC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 02:00:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AE39A2183F
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 02:00:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730304AbfBTCAP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Feb 2019 21:00:15 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:34210 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729194AbfBTCAM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Feb 2019 21:00:12 -0500
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x1K1xcQ8138827
        for <linux-kernel@vger.kernel.org>; Tue, 19 Feb 2019 21:00:11 -0500
Received: from e15.ny.us.ibm.com (e15.ny.us.ibm.com [129.33.205.205])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2qrrdhur76-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Tue, 19 Feb 2019 21:00:10 -0500
Received: from localhost
        by e15.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Wed, 20 Feb 2019 02:00:09 -0000
Received: from b01cxnp22034.gho.pok.ibm.com (9.57.198.24)
        by e15.ny.us.ibm.com (146.89.104.202) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 20 Feb 2019 02:00:04 -0000
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp22034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x1K203EI17563728
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 20 Feb 2019 02:00:03 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9D1F2B2064;
        Wed, 20 Feb 2019 02:00:02 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7A07DB206A;
        Wed, 20 Feb 2019 02:00:02 +0000 (GMT)
Received: from paulmck-ThinkPad-W541 (unknown [9.85.140.94])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Wed, 20 Feb 2019 02:00:02 +0000 (GMT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id 1A6C316C63E4; Tue, 19 Feb 2019 18:00:02 -0800 (PST)
Date:   Tue, 19 Feb 2019 18:00:02 -0800
From:   "Paul E. McKenney" <paulmck@linux.ibm.com>
To:     Andrea Parri <andrea.parri@amarulasolutions.com>
Cc:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        Alan Stern <stern@rowland.harvard.edu>,
        Will Deacon <will.deacon@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        David Howells <dhowells@redhat.com>,
        Jade Alglave <j.alglave@ucl.ac.uk>,
        Luc Maranget <luc.maranget@inria.fr>,
        Akira Yokosawa <akiyks@gmail.com>,
        Daniel Lustig <dlustig@nvidia.com>
Subject: Re: [PATCH 1/2] tools/memory-model: Fix comment in
 MP+poonceonces.litmus
Reply-To: paulmck@linux.ibm.com
References: <1550616923-4795-1-git-send-email-andrea.parri@amarulasolutions.com>
 <1550616923-4795-2-git-send-email-andrea.parri@amarulasolutions.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1550616923-4795-2-git-send-email-andrea.parri@amarulasolutions.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 19022002-0068-0000-0000-0000039680DE
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00010629; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000281; SDB=6.01163561; UDB=6.00607550; IPR=6.00944144;
 MB=3.00025662; MTD=3.00000008; XFM=3.00000015; UTC=2019-02-20 02:00:07
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19022002-0069-0000-0000-000047909140
Message-Id: <20190220020002.GC11787@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-02-20_01:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1902200012
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 19, 2019 at 11:55:22PM +0100, Andrea Parri wrote:
> The comment should say "Sometimes" for the result.

I queued both of these, thank you!   Just to be clear "Maybe" is "don't
care", so this patch is changing this litmus test from "LKMM can allow
or forbid, at its option" to "LKMM must allow".  Which should be fine,
given that the test has absolutely no ordering.

							Thanx, Paul

> Signed-off-by: Andrea Parri <andrea.parri@amarulasolutions.com>
> Cc: Alan Stern <stern@rowland.harvard.edu>
> Cc: Will Deacon <will.deacon@arm.com>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Boqun Feng <boqun.feng@gmail.com>
> Cc: Nicholas Piggin <npiggin@gmail.com>
> Cc: David Howells <dhowells@redhat.com>
> Cc: Jade Alglave <j.alglave@ucl.ac.uk>
> Cc: Luc Maranget <luc.maranget@inria.fr>
> Cc: "Paul E. McKenney" <paulmck@linux.ibm.com>
> Cc: Akira Yokosawa <akiyks@gmail.com>
> Cc: Daniel Lustig <dlustig@nvidia.com>
> ---
>  tools/memory-model/litmus-tests/MP+poonceonces.litmus | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/memory-model/litmus-tests/MP+poonceonces.litmus b/tools/memory-model/litmus-tests/MP+poonceonces.litmus
> index b2b60b84fb9dc..172f0145301c5 100644
> --- a/tools/memory-model/litmus-tests/MP+poonceonces.litmus
> +++ b/tools/memory-model/litmus-tests/MP+poonceonces.litmus
> @@ -1,7 +1,7 @@
>  C MP+poonceonces
>  
>  (*
> - * Result: Maybe
> + * Result: Sometimes
>   *
>   * Can the counter-intuitive message-passing outcome be prevented with
>   * no ordering at all?
> -- 
> 2.7.4
> 

