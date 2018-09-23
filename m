Return-Path: <SRS0=ZOiK=MF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E800ECE560
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Sep 2018 00:41:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2538B2146E
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Sep 2018 00:41:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2538B2146E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725971AbeIWGgv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 23 Sep 2018 02:36:51 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:57404 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725769AbeIWGgv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Sep 2018 02:36:51 -0400
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w8N0clUo089077
        for <linux-kernel@vger.kernel.org>; Sat, 22 Sep 2018 20:41:19 -0400
Received: from e15.ny.us.ibm.com (e15.ny.us.ibm.com [129.33.205.205])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2mnkxmbbyu-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Sat, 22 Sep 2018 20:41:19 -0400
Received: from localhost
        by e15.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Sat, 22 Sep 2018 20:41:19 -0400
Received: from b01cxnp22034.gho.pok.ibm.com (9.57.198.24)
        by e15.ny.us.ibm.com (146.89.104.202) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Sat, 22 Sep 2018 20:41:14 -0400
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp22034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w8N0fDfP59179192
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Sun, 23 Sep 2018 00:41:13 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 26D99B206A;
        Sat, 22 Sep 2018 20:39:38 -0400 (EDT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 06A4AB2066;
        Sat, 22 Sep 2018 20:39:38 -0400 (EDT)
Received: from paulmck-ThinkPad-W541 (unknown [9.85.180.236])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Sat, 22 Sep 2018 20:39:37 -0400 (EDT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id 2EF8116C197D; Sat, 22 Sep 2018 17:41:13 -0700 (PDT)
Date:   Sat, 22 Sep 2018 17:41:13 -0700
From:   "Paul E. McKenney" <paulmck@linux.ibm.com>
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Josh Triplett <josh@joshtriplett.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        linux-doc@vger.kernel.org,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH RFC] Documentation: RCU: Clarify comment about fanout
Reply-To: paulmck@linux.ibm.com
References: <20180921223153.114728-1-joel@joelfernandes.org>
 <20180922011428.GU4222@linux.ibm.com>
 <CAEXW_YTgSFr5r3Qkr0+0_wxKGQV1KKP_8X8uQKAnHmhvem8XtA@mail.gmail.com>
 <20180922134616.GX4222@linux.ibm.com>
 <CAEXW_YRaLjRWH9BYV_r8e4pCuBEGCzMSRdS6x7Qozc8HKoej=w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEXW_YRaLjRWH9BYV_r8e4pCuBEGCzMSRdS6x7Qozc8HKoej=w@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 18092300-0068-0000-0000-000003409FC4
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009754; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000266; SDB=6.01092247; UDB=6.00564422; IPR=6.00872271;
 MB=3.00023459; MTD=3.00000008; XFM=3.00000015; UTC=2018-09-23 00:41:17
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18092300-0069-0000-0000-000045D38DFB
Message-Id: <20180923004113.GL4222@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-09-22_16:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1809230006
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 22, 2018 at 07:38:05PM -0400, Joel Fernandes wrote:
> On Sat, Sep 22, 2018 at 9:46 AM Paul E. McKenney <paulmck@linux.ibm.com> wrote:
> [...]
> > > I have a few more as well, I'll send them out soon.
> >
> > I do have on my list to update this document based on the changes in
> > -rcu, which among other things eliminate the rcu_dynticks structure
> > and  make it so there is only one rcu_state structure in a given
> > running system.
> >
> > If you are crazy enough to want to make the corresponding changes,
> > I would welcome the patches (and would be happy to help with editing,
> > grammar, and soforth.  The potential advantage to you is familiarlzation
> > with the new version of the code.
> >
> > This is not a small amount of work, so please give it some thought
> > before saying "yes".  (In contrast, I would of course understand and
> > respect an immediate "no".)
> 
> I thought about this and I'd be happy to do it as long as you don't
> mind me asking questions about parts I don't understand (which
> shouldn't be a problem from my past experience ;-)). I am spending
> time understanding the code anyway so I'd rather update the main
> documentation than my own notes for the benefit of everyone ;-) As you
> said, it'll help familiarization of the code. Btw I got rid of those
> extra rcu_state externs too, I'll send that patch out today and
> continue working on things next week...

If you continue to find and fix issues like your three most recent
patches, I really cannot complain about a few questions, now can I?  ;-)

So please keep both the patches and questions coming!

							Thanx, Paul

