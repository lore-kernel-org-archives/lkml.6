Return-Path: <SRS0=Mdfq=OF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 022D5C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 19:00:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A916C20865
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 19:00:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A916C20865
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726810AbeK0Fzj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Nov 2018 00:55:39 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:23301 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726140AbeK0Fzi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Nov 2018 00:55:38 -0500
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id wAQIwmEG141021
        for <linux-kernel@vger.kernel.org>; Mon, 26 Nov 2018 14:00:36 -0500
Received: from e11.ny.us.ibm.com (e11.ny.us.ibm.com [129.33.205.201])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2p0mpuw13y-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Mon, 26 Nov 2018 14:00:36 -0500
Received: from localhost
        by e11.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Mon, 26 Nov 2018 19:00:32 -0000
Received: from b01cxnp22034.gho.pok.ibm.com (9.57.198.24)
        by e11.ny.us.ibm.com (146.89.104.198) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Mon, 26 Nov 2018 19:00:26 -0000
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp22034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id wAQJ0PU915794188
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 26 Nov 2018 19:00:25 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0E082B2064;
        Mon, 26 Nov 2018 19:00:25 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D0E41B2066;
        Mon, 26 Nov 2018 19:00:24 +0000 (GMT)
Received: from paulmck-ThinkPad-W541 (unknown [9.70.82.38])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Mon, 26 Nov 2018 19:00:24 +0000 (GMT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id 7597316C342C; Mon, 26 Nov 2018 11:00:27 -0800 (PST)
Date:   Mon, 26 Nov 2018 11:00:27 -0800
From:   "Paul E. McKenney" <paulmck@linux.ibm.com>
To:     Ran Rozenstein <ranro@mellanox.com>
Cc:     Joel Fernandes <joel@joelfernandes.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "mingo@kernel.org" <mingo@kernel.org>,
        "jiangshanlai@gmail.com" <jiangshanlai@gmail.com>,
        "dipankar@in.ibm.com" <dipankar@in.ibm.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "mathieu.desnoyers@efficios.com" <mathieu.desnoyers@efficios.com>,
        "josh@joshtriplett.org" <josh@joshtriplett.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "rostedt@goodmis.org" <rostedt@goodmis.org>,
        "dhowells@redhat.com" <dhowells@redhat.com>,
        "edumazet@google.com" <edumazet@google.com>,
        "fweisbec@gmail.com" <fweisbec@gmail.com>,
        "oleg@redhat.com" <oleg@redhat.com>,
        Maor Gottlieb <maorg@mellanox.com>,
        Tariq Toukan <tariqt@mellanox.com>,
        Eran Ben Elisha <eranbe@mellanox.com>,
        Leon Romanovsky <leonro@mellanox.com>
Subject: Re: [PATCH tip/core/rcu 02/19] rcu: Defer reporting RCU-preempt
 quiescent states when disabled
Reply-To: paulmck@linux.ibm.com
References: <20180829222021.GA29944@linux.vnet.ibm.com>
 <20180829222047.319-2-paulmck@linux.vnet.ibm.com>
 <AM4PR0501MB27691ECD1B0ECB0531B16F20C5F30@AM4PR0501MB2769.eurprd05.prod.outlook.com>
 <20181029142735.GZ4170@linux.ibm.com>
 <20181030034452.GA224709@google.com>
 <20181030125800.GE4170@linux.ibm.com>
 <20181030222123.GB44036@joelaf.mtv.corp.google.com>
 <20181031182259.GH4170@linux.ibm.com>
 <20181102194356.GA8378@linux.ibm.com>
 <AM4PR0501MB27690D8721451EEE5082E593C5D70@AM4PR0501MB2769.eurprd05.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <AM4PR0501MB27690D8721451EEE5082E593C5D70@AM4PR0501MB2769.eurprd05.prod.outlook.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 18112619-2213-0000-0000-0000031FA716
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00010125; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000270; SDB=6.01123136; UDB=6.00583023; IPR=6.00903266;
 MB=3.00024340; MTD=3.00000008; XFM=3.00000015; UTC=2018-11-26 19:00:30
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18112619-2214-0000-0000-00005C6466AE
Message-Id: <20181126190027.GH4170@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-11-26_08:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1811260163
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 26, 2018 at 01:55:37PM +0000, Ran Rozenstein wrote:
> > 
> > Hearing no objections, here is the updated patch.
> > 
> > 								Thanx, Paul
> > 
> > ------------------------------------------------------------------------
> > 
> > commit 970cab5d3d206029ed27274a98ea1c3d7e780e53
> > Author: Paul E. McKenney <paulmck@linux.ibm.com>
> > Date:   Mon Oct 29 07:36:50 2018 -0700
> > 
> >     rcu: Avoid signed integer overflow in rcu_preempt_deferred_qs()
> > 
> >     Subtracting INT_MIN can be interpreted as unconditional signed integer
> >     overflow, which according to the C standard is undefined behavior.
> >     Therefore, kernel build arguments notwithstanding, it would be good to
> >     future-proof the code.  This commit therefore substitutes INT_MAX for
> >     INT_MIN in order to avoid undefined behavior.
> > 
> >     While in the neighborhood, this commit also creates some meaningful
> > names
> >     for INT_MAX and friends in order to improve readability, as suggested
> >     by Joel Fernandes.
> > 
> >     Reported-by: Ran Rozenstein <ranro@mellanox.com>
> >     Signed-off-by: Paul E. McKenney <paulmck@linux.ibm.com>
> > 
> >     squash! rcu: Avoid signed integer overflow in rcu_preempt_deferred_qs()
> > 
> >     While in the neighborhood, use macros to give meaningful names.
> > 
> >     Signed-off-by: Paul E. McKenney <paulmck@linux.ibm.com>
> 
> Hi,
> 
> What is the acceptance status of this patch?

It is queued in -rcu.  If no problems arise beforehand, I intend to submit
it as part of a pull request into -tip, which (again if no problems arise)
be pulled into mainline during the next merge window.

Oddly enough, a couple of weeks ago the C++ Standards Committee voted
in a proposal for C++20 removing undefined behavior for signed integer
overflow.  This is C++ rather than C, and C must support additional
hardware that wouldn't much like forcing twos complement for signed
integer overflow.  But still...  ;-)

							Thanx, Paul

