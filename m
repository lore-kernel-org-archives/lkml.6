Return-Path: <SRS0=sczE=Q3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7698C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 16:42:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A39E22084D
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 16:42:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727500AbfBTQmt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Feb 2019 11:42:49 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:52782 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725798AbfBTQms (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Feb 2019 11:42:48 -0500
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x1KGVL3e145238
        for <linux-kernel@vger.kernel.org>; Wed, 20 Feb 2019 11:42:47 -0500
Received: from e15.ny.us.ibm.com (e15.ny.us.ibm.com [129.33.205.205])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2qs906nuag-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Wed, 20 Feb 2019 11:42:47 -0500
Received: from localhost
        by e15.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Wed, 20 Feb 2019 16:42:46 -0000
Received: from b01cxnp23034.gho.pok.ibm.com (9.57.198.29)
        by e15.ny.us.ibm.com (146.89.104.202) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 20 Feb 2019 16:42:44 -0000
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp23034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x1KGghGF24051932
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 20 Feb 2019 16:42:43 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 424B6B2075;
        Wed, 20 Feb 2019 16:42:43 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1BD6BB2064;
        Wed, 20 Feb 2019 16:42:43 +0000 (GMT)
Received: from paulmck-ThinkPad-W541 (unknown [9.85.138.62])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Wed, 20 Feb 2019 16:42:43 +0000 (GMT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id 052C516C3B20; Wed, 20 Feb 2019 08:42:43 -0800 (PST)
Date:   Wed, 20 Feb 2019 08:42:43 -0800
From:   "Paul E. McKenney" <paulmck@linux.ibm.com>
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     LKML <linux-kernel@vger.kernel.org>, rcu@vger.kernel.org
Subject: Re: [RFC 0/5] RCU fixes for rcu_assign_pointer usage
Reply-To: paulmck@linux.ibm.com
References: <20190220040827.136184-1-joel@joelfernandes.org>
 <CAEXW_YRasK=os37QxCwoAY+DXKVD3bBTvR4qH3jaSJB3rP5a-Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEXW_YRasK=os37QxCwoAY+DXKVD3bBTvR4qH3jaSJB3rP5a-Q@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 19022016-0068-0000-0000-00000396CD03
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00010632; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000281; SDB=6.01163854; UDB=6.00607727; IPR=6.00944438;
 MB=3.00025669; MTD=3.00000008; XFM=3.00000015; UTC=2019-02-20 16:42:46
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19022016-0069-0000-0000-0000479247F2
Message-Id: <20190220164242.GN11787@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-02-20_13:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1902200117
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 19, 2019 at 08:11:36PM -0800, Joel Fernandes wrote:
> On Tue, Feb 19, 2019 at 8:08 PM Joel Fernandes (Google)
> <joel@joelfernandes.org> wrote:
> >
> > These patches fix various RCU API usage issues found due to sparse errors as a
> > result of the recent check to add rcu_check_sparse() to rcu_assign_pointer().
> >
> > This is very early RFC stage, and is only build tested. I am also only sending
> > to the RCU group for initial review before sending to LKML. Thanks for any feedback!
> >
> > There are still more usages that cause errors such as rbtree which I am
> > looking into.
> 
> Looks like it got sent to LKML anyway, ;-) That's Ok since it is
> prefixed as RFC.

As is only right and proper.  ;-)

I don't see an immediate problem with them, but it would be good to get
the relevant developers and maintainers on CC for the next version.  I
cannot claim to know that code very well.

							Thanx, Paul

