Return-Path: <SRS0=AKhD=M3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C663C070C3
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 02:33:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D332F20659
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 02:33:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D332F20659
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726634AbeJOKQm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Oct 2018 06:16:42 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:47602 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726273AbeJOKQl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Oct 2018 06:16:41 -0400
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w9F2SldH140545
        for <linux-kernel@vger.kernel.org>; Sun, 14 Oct 2018 22:33:31 -0400
Received: from e15.ny.us.ibm.com (e15.ny.us.ibm.com [129.33.205.205])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2n4h2v1vqb-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Sun, 14 Oct 2018 22:33:30 -0400
Received: from localhost
        by e15.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Sun, 14 Oct 2018 22:33:29 -0400
Received: from b01cxnp23032.gho.pok.ibm.com (9.57.198.27)
        by e15.ny.us.ibm.com (146.89.104.202) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Sun, 14 Oct 2018 22:33:26 -0400
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp23032.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w9F2XPXU25821222
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 15 Oct 2018 02:33:25 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 711B0B2068;
        Sun, 14 Oct 2018 22:31:21 -0400 (EDT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 50CCAB2064;
        Sun, 14 Oct 2018 22:31:21 -0400 (EDT)
Received: from paulmck-ThinkPad-W541 (unknown [9.85.131.128])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Sun, 14 Oct 2018 22:31:21 -0400 (EDT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id 9DE9416C3403; Sun, 14 Oct 2018 19:33:28 -0700 (PDT)
Date:   Sun, 14 Oct 2018 19:33:28 -0700
From:   "Paul E. McKenney" <paulmck@linux.ibm.com>
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        Josh Triplett <josh@joshtriplett.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        linux-doc@vger.kernel.org,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH RFC] doc: rcu: remove obsolete (non-)requirement about
 disabling preemption
Reply-To: paulmck@linux.ibm.com
References: <20181014212955.95267-1-joel@joelfernandes.org>
 <20181014231731.GN2674@linux.ibm.com>
 <20181015020827.GA217384@joelaf.mtv.corp.google.com>
 <20181015021349.GB217384@joelaf.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181015021349.GB217384@joelaf.mtv.corp.google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 18101502-0068-0000-0000-0000034D202C
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009879; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000268; SDB=6.01102806; UDB=6.00570776; IPR=6.00882858;
 MB=3.00023757; MTD=3.00000008; XFM=3.00000015; UTC=2018-10-15 02:33:28
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18101502-0069-0000-0000-00004612B42B
Message-Id: <20181015023328.GP2674@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-10-15_01:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1810150022
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 14, 2018 at 07:13:49PM -0700, Joel Fernandes wrote:
> On Sun, Oct 14, 2018 at 07:08:27PM -0700, Joel Fernandes wrote:
> > On Sun, Oct 14, 2018 at 04:17:31PM -0700, Paul E. McKenney wrote:
> > > On Sun, Oct 14, 2018 at 02:29:55PM -0700, Joel Fernandes (Google) wrote:
> > > > The Requirements.html document says "Disabling Preemption Does Not Block
> > > > Grace Periods". However this is no longer true with the RCU
> > > > consolidation. Lets remove the obsolete (non-)requirement entirely.
> > > > 
> > > > Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> > > 
> > > Good catch, queued, thank you!
> > 
> > Thanks! By the way after I sent the patch, I also tried Oleg's experiment to
> > confirm that this is indeed obsolete.  :)
> > 
> > One thing interesting came up when I tried synchronize_rcu_expedited()
> > instead of synchronize_rcu() in Oleg's experiment, I still saw a multiple
> > millisecond delay between when the rcu read section completely and the
> > synchronize_rcu_expedited returns:
> > 
> > For example, with synchronize_rcu_expedited, the 'SPIN done' and the 'SYNC
> > done' are about 3 millisecond apart:
> > [   77.599142] SPIN start
> > [   77.601595] SYNC start
> > [   82.604950] SPIN done!
> > [   82.607836] SYNC done!
> >  I saw anywhere from 2-6 milliseconds.
> > 
> > The reason I bring this up is according to Requirements.html: In some cases,
> > the multi-millisecond synchronize_rcu() latencies are unacceptable. In these
> > cases, synchronize_rcu_expedited() may be used instead,.. so either I messed
> > something up in the experiment, or I need to update this part of the document ;-)

In normal testing, 2-6 milliseconds is indeed excessive.  Could you please
point me at Oleg's experiment?  Also, what CONFIG_PREEMPT setting were
you using?  (My guess is CONFIG_PREEMPT=y.)

> So I realized I'm running in Qemu so it could also be a scheduling delay of
> the vcpu thread. So apologies about the noise if the experiment works fine
> for you.

I used rcuperf, which might not be doing the same thing as Oleg's
experiment.

							Thanx, Paul

