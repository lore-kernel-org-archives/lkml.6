Return-Path: <SRS0=izC1=MS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FFDCC677E8
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Oct 2018 16:49:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 02DD42084D
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Oct 2018 16:49:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 02DD42084D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727846AbeJFXxp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 6 Oct 2018 19:53:45 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:36024 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725266AbeJFXxp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Oct 2018 19:53:45 -0400
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w96GmvMa047225
        for <linux-kernel@vger.kernel.org>; Sat, 6 Oct 2018 12:49:40 -0400
Received: from e11.ny.us.ibm.com (e11.ny.us.ibm.com [129.33.205.201])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2mxs88wg38-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Sat, 06 Oct 2018 12:49:40 -0400
Received: from localhost
        by e11.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Sat, 6 Oct 2018 12:49:39 -0400
Received: from b01cxnp22036.gho.pok.ibm.com (9.57.198.26)
        by e11.ny.us.ibm.com (146.89.104.198) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Sat, 6 Oct 2018 12:49:34 -0400
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp22036.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w96GnXNZ38142184
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Sat, 6 Oct 2018 16:49:33 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 89FEFB2067;
        Sat,  6 Oct 2018 12:47:40 -0400 (EDT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6801FB2064;
        Sat,  6 Oct 2018 12:47:40 -0400 (EDT)
Received: from paulmck-ThinkPad-W541 (unknown [9.85.150.28])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Sat,  6 Oct 2018 12:47:40 -0400 (EDT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id C059C16C12C1; Sat,  6 Oct 2018 09:49:33 -0700 (PDT)
Date:   Sat, 6 Oct 2018 09:49:33 -0700
From:   "Paul E. McKenney" <paulmck@linux.ibm.com>
To:     "Theodore Y. Ts'o" <tytso@mit.edu>,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        Josh Triplett <josh@joshtriplett.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        linux-doc@vger.kernel.org,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Steven Rostedt <rostedt@goodmis.org>, pantin@google.com
Subject: Re: [PATCH RFC 0/5] rcu doc updates for whatisRCU and checklist
Reply-To: paulmck@linux.ibm.com
References: <20181005231815.170433-1-joel@joelfernandes.org>
 <20181005234628.GB2548@thunk.org>
 <20181006034540.GM2674@linux.ibm.com>
 <20181006053446.GA2529@thunk.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181006053446.GA2529@thunk.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 18100616-2213-0000-0000-000002FE6019
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009831; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000267; SDB=6.01098786; UDB=6.00568357; IPR=6.00878826;
 MB=3.00023641; MTD=3.00000008; XFM=3.00000015; UTC=2018-10-06 16:49:37
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18100616-2214-0000-0000-00005BCD4874
Message-Id: <20181006164933.GP2674@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-10-06_08:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1810060171
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 06, 2018 at 01:34:46AM -0400, Theodore Y. Ts'o wrote:
> On Fri, Oct 05, 2018 at 08:45:40PM -0700, Paul E. McKenney wrote:
> > 
> > Shouldn't the synchronize_rcu() precede the loop doing the kfree()
> > calls?  Or am I missing something subtle?
> 
> No, that was a cut and paste error on my part.  I was removing the
> rcu_read_unlock() before the kfree loop, and accidentally removed the
> synchronize_rcu().  Then when I put it back, I put it back in the
> right place.

Been there, done that!  ;-)

> The longer version:
> 
> I originally used rcu_read_lock() and rcu_read_unlock() around setting
> up to_free[] --- since whatisRCU.txt didn't talk about
> rcu_derefence_proctected(), just rcu_dereference() in Section 2: "What
> is RCU's Core API?"   
> 
> Then when I looked at the example in Section 3, I was surprised when I
> didn't see the rcu_read_[un]lock() on the updater side, and spent some
> time trying to figure out how to use rcu_dereference_protected().
> 
> Then when I did the transumation from
> rcu_read_lock/rcu_dereference_protected/rcu_read_unlock to
> rcu_dereference_protected, I bobbled the location of
> synchronize_rcu().
> 
> 						- Ted
> 
> P.S.  Pedagogically, it might make sense to show an example that only
> uses the RCU core API --- I assume using rcu_read_[un]lock() and
> rcu_dereference() does work; it's just non-optimal, right?  --- and
> then introduce the use of rcu_dereference_protected() afterwards.

Yes, you can use rcu_dereference() on the update side and dispense
with rcu_dereference_protected(), but that will require you to add an
otherwise useless rcu_read_lock()/rcu_read_unlock() pair when accessing
the pointer on the update side.

Furthermore, if you are OK leaking memory rather than freeing it (which
is admittedly quite rare, but does sometimes happen), then yes, you
don't need call_rcu(), synchronize_rcu(), and friends.

So it is as you say, functional but non-optimal.

							Thanx, Paul

