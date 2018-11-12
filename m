Return-Path: <SRS0=E8pv=NX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B0C2C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 16:01:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F326A22419
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 16:01:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F326A22419
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729987AbeKMBzp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 20:55:45 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:4141 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727976AbeKMBzo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 20:55:44 -0500
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id wACG0xNJ139769
        for <linux-kernel@vger.kernel.org>; Mon, 12 Nov 2018 11:01:52 -0500
Received: from e16.ny.us.ibm.com (e16.ny.us.ibm.com [129.33.205.206])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2nqb4651q7-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Mon, 12 Nov 2018 11:01:49 -0500
Received: from localhost
        by e16.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Mon, 12 Nov 2018 16:01:45 -0000
Received: from b01cxnp23034.gho.pok.ibm.com (9.57.198.29)
        by e16.ny.us.ibm.com (146.89.104.203) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Mon, 12 Nov 2018 16:01:40 -0000
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp23034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id wACG1dKP28049432
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 12 Nov 2018 16:01:39 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 4F4F8B2071;
        Mon, 12 Nov 2018 16:01:38 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 30C73B206B;
        Mon, 12 Nov 2018 16:01:37 +0000 (GMT)
Received: from paulmck-ThinkPad-W541 (unknown [9.85.198.12])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Mon, 12 Nov 2018 16:01:37 +0000 (GMT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id 891E516C5DA0; Mon, 12 Nov 2018 08:01:37 -0800 (PST)
Date:   Mon, 12 Nov 2018 08:01:37 -0800
From:   "Paul E. McKenney" <paulmck@linux.ibm.com>
To:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        dipankar <dipankar@in.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        rostedt <rostedt@goodmis.org>,
        David Howells <dhowells@redhat.com>,
        Eric Dumazet <edumazet@google.com>,
        fweisbec <fweisbec@gmail.com>, Oleg Nesterov <oleg@redhat.com>,
        "Joel Fernandes, Google" <joel@joelfernandes.org>,
        kernel-team <kernel-team@android.com>, sashal@kernel.org
Subject: Re: [PATCH tip/core/rcu 0/41] More RCU flavor consolidation cleanup
 for v4.21/v5.0
Reply-To: paulmck@linux.ibm.com
References: <20181111194104.GA4787@linux.ibm.com>
 <2113574714.3779.1542031670315.JavaMail.zimbra@efficios.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2113574714.3779.1542031670315.JavaMail.zimbra@efficios.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 18111216-0072-0000-0000-000003C77530
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00010035; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000270; SDB=6.01116417; UDB=6.00577118; IPR=6.00896525;
 MB=3.00024128; MTD=3.00000008; XFM=3.00000015; UTC=2018-11-12 16:01:43
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18111216-0073-0000-0000-00004A158C54
Message-Id: <20181112160137.GI4170@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-11-12_11:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1811120139
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 12, 2018 at 09:07:50AM -0500, Mathieu Desnoyers wrote:
> ----- On Nov 11, 2018, at 2:41 PM, paulmck paulmck@linux.ibm.com wrote:
> 
> > Hello!
> > 
> > This series does additional cleanup for the RCU flavor consolidation,
> > focusing primarily on uses of old API members, for example, so that
> > call_rcu_bh() becomes call_rcu().  There are also a few straggling
> > internal-to-RCU cleanups.
> > 
> > 1.	Remove unused rcu_state externs, courtesy of Joel Fernandes.
> > 
> > 2.	Fix rcu_{node,data} comments about gp_seq_needed, courtesy of
> >	Joel Fernandes.
> > 
> > 3.	Eliminate synchronize_rcu_mult() and its sole caller.
> > 
> > 4.	Consolidate the RCU update functions invoked by sync.c.
> > 
> > 5-41.	Replace old flavorful RCU API calls with the corresponding
> >	vanilla calls.
> 
> Hi Paul,
> 
> Just a heads up: we might want to spell out warnings in very big letters
> for anyone trying to backport code using RCU from post-4.21 kernels
> back to older kernels. I fear that newer code will build just fine
> on older kernels, but will spectacularly fail in hard-to-debug ways at
> runtime.
> 
> Renaming synchronize_rcu() and call_rcu() to something that did not
> exist in prior kernels would prevent that. It may not be as pretty
> though.

From v4.20 rather than v4.21, but yes.  Would it make sense to have Sasha
automatically flag -stable candidates going back past that boundary that
contain call_rcu(), synchronize_rcu(), etc.?  Adding Sasha on CC, and
I might be able to touch base with him this week.

							Thanx, Paul

