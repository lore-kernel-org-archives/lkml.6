Return-Path: <SRS0=BpFy=NK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D390FC6786F
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 23:50:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7D85320664
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 23:50:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7D85320664
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728688AbeJaIqW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Oct 2018 04:46:22 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:51004 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726366AbeJaIqW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Oct 2018 04:46:22 -0400
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w9UNohP9114532
        for <linux-kernel@vger.kernel.org>; Tue, 30 Oct 2018 19:50:43 -0400
Received: from e16.ny.us.ibm.com (e16.ny.us.ibm.com [129.33.205.206])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2nf1b20064-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Tue, 30 Oct 2018 19:50:43 -0400
Received: from localhost
        by e16.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Tue, 30 Oct 2018 19:50:42 -0400
Received: from b01cxnp23034.gho.pok.ibm.com (9.57.198.29)
        by e16.ny.us.ibm.com (146.89.104.203) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Tue, 30 Oct 2018 19:50:40 -0400
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp23034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w9UNodED21889084
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 30 Oct 2018 23:50:39 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7E50BB2064;
        Tue, 30 Oct 2018 23:50:39 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 60C51B205F;
        Tue, 30 Oct 2018 23:50:39 +0000 (GMT)
Received: from paulmck-ThinkPad-W541 (unknown [9.70.82.141])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Tue, 30 Oct 2018 23:50:39 +0000 (GMT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id 6E90B16C0292; Tue, 30 Oct 2018 16:50:39 -0700 (PDT)
Date:   Tue, 30 Oct 2018 16:50:39 -0700
From:   "Paul E. McKenney" <paulmck@linux.ibm.com>
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [RFC] rcu: doc: update example about stale data
Reply-To: paulmck@linux.ibm.com
References: <20181028021653.155513-1-joel@joelfernandes.org>
 <20181028172142.GN4170@linux.ibm.com>
 <20181029011631.GA261737@joelaf.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181029011631.GA261737@joelaf.mtv.corp.google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 18103023-0072-0000-0000-000003BEC855
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009956; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000268; SDB=6.01110355; UDB=6.00575329; IPR=6.00890447;
 MB=3.00023971; MTD=3.00000008; XFM=3.00000015; UTC=2018-10-30 23:50:41
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18103023-0073-0000-0000-000049F088AB
Message-Id: <20181030235039.GX4170@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-10-30_14:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1810300198
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 28, 2018 at 06:16:31PM -0700, Joel Fernandes wrote:
> On Sun, Oct 28, 2018 at 10:21:42AM -0700, Paul E. McKenney wrote:
> > On Sat, Oct 27, 2018 at 07:16:53PM -0700, Joel Fernandes (Google) wrote:
> > > The RCU example for 'rejecting stale data' on system-call auditting
> > > stops iterating through the rules if a deleted one is found. It makes
> > > more sense to continue looking at other rules once a deleted one is
> > > rejected. Although the original example is fine, this makes it more
> > > meaningful.
> > > 
> > > Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> > 
> > Does the actual audit code that this was copied from now include the
> > continue statement?  If so, please update the commit log to state that
> > and then I will take the resulting patch.  (This example was inspired
> > by a long-ago version of the actual audit code.)
> 
> The document talks of a situation that could be but is not really in the
> implementation. It says "If the system-call audit module were to ever need to
> reject stale data". So its not really something implemented. I was just
> correcting the example you had there since it made more sense to me to
> continue looking for other rules in the list once a rule was shown to be
> stale. It just makes the example more correct.
> 
> But I'm Ok if you want to leave that alone ;-) Hence, the RFC tag to this
> patch ;-)

Well, I do agree that there are situations where you need to keep
going.  But in the common case where only one instance of a given key
is allowed, and where the list is either (1) sorted and/or (2) added
to at the beginning, if you find a deleted element with a given key,
you are guaranteed that you won't find another with that key even if
you continue scanning the list.  After all, if you did find a deleted
element, the duplicate either is not on the list in the sorted case
or is behind you in the add-at-front case.

And in the more complex cases where persistent searching is required,
you usually have to restart the search instead of continuing it.  Besides,
things like the Issaquah Challenge don't seem to belong in introductory
documentation on RCU.  ;-)

							Thanx, Paul

