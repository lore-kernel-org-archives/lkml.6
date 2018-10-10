Return-Path: <SRS0=PZ5q=MW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05635C43610
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 15:44:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A12B82086D
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 15:44:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A12B82086D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726825AbeJJXHH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Oct 2018 19:07:07 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:54128 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726515AbeJJXHH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Oct 2018 19:07:07 -0400
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w9AFcuu9067709
        for <linux-kernel@vger.kernel.org>; Wed, 10 Oct 2018 11:44:22 -0400
Received: from e13.ny.us.ibm.com (e13.ny.us.ibm.com [129.33.205.203])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2n1k1fuv4v-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Wed, 10 Oct 2018 11:44:22 -0400
Received: from localhost
        by e13.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Wed, 10 Oct 2018 11:44:21 -0400
Received: from b01cxnp23032.gho.pok.ibm.com (9.57.198.27)
        by e13.ny.us.ibm.com (146.89.104.200) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 10 Oct 2018 11:44:17 -0400
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp23032.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w9AFiG9w22872080
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 10 Oct 2018 15:44:16 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 16817B206B;
        Wed, 10 Oct 2018 11:42:18 -0400 (EDT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8C2A5B2065;
        Wed, 10 Oct 2018 11:42:17 -0400 (EDT)
Received: from paulmck-ThinkPad-W541 (unknown [9.80.212.127])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Wed, 10 Oct 2018 11:42:17 -0400 (EDT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id E222716C3FD5; Wed, 10 Oct 2018 08:44:14 -0700 (PDT)
Date:   Wed, 10 Oct 2018 08:44:14 -0700
From:   "Paul E. McKenney" <paulmck@linux.ibm.com>
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     linux-kernel@vger.kernel.org, tytso@mit.edu,
        Jonathan Corbet <corbet@lwn.net>,
        Josh Triplett <josh@joshtriplett.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        linux-doc@vger.kernel.org,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH] docs: rcu: Make reader aware of rcu_dereference_protected
Reply-To: paulmck@linux.ibm.com
References: <20181009013341.60111-1-joel@joelfernandes.org>
 <20181010030906.GB2674@linux.ibm.com>
 <20181010040159.GA90259@joelaf.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181010040159.GA90259@joelaf.mtv.corp.google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 18101015-0064-0000-0000-0000035D4AD3
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009854; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000268; SDB=6.01100676; UDB=6.00569495; IPR=6.00880724;
 MB=3.00023697; MTD=3.00000008; XFM=3.00000015; UTC=2018-10-10 15:44:19
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18101015-0065-0000-0000-00003AEF3A22
Message-Id: <20181010154414.GC2674@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-10-10_10:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1810100153
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 09, 2018 at 09:01:59PM -0700, Joel Fernandes wrote:
> On Tue, Oct 09, 2018 at 08:09:06PM -0700, Paul E. McKenney wrote:
> > On Mon, Oct 08, 2018 at 06:33:41PM -0700, Joel Fernandes (Google) wrote:
> > > whatisRCU says rcu_dereference cannot be used outside of rcu read lock
> > > protected sections. Its better to mention rcu_dereference_protected when
> > > it says that, so that the new reader is aware of this API and is not led
> > > to believing that all RCU dereferences in all situations have to be
> > > protected by a rcu_read_lock() and rcu_read_unlock().
> > > 
> > > Cc: tytso@mit.edu
> > > Suggested-by: tytso@mit.edu
> > > Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> > 
> > Good stuff!  I queued and pushed this with some wordsmithing.  Could
> > you please check for my having messed something up?
> 
> One small nit which the below diff should fix, but otherwise looks good to
> me, thanks!

Good catch!  I rolled the into the commit, thank you!

							Thanx, Paul

>  - Joel
> 
> ----8<----
> 
> diff --git a/Documentation/RCU/whatisRCU.txt b/Documentation/RCU/whatisRCU.txt
> index 38044c978e54..093b85ad49eb 100644
> --- a/Documentation/RCU/whatisRCU.txt
> +++ b/Documentation/RCU/whatisRCU.txt
> @@ -297,7 +297,7 @@ rcu_dereference()
>  	protected by locks acquired by the update-side code.  This variant
>  	avoids the lockdep warning that would happen when using (for
>  	example) rcu_dereference() without rcu_read_lock() protection.
> -	Using rcu_dereference_protected() also have the advantage
> +	Using rcu_dereference_protected() also has the advantage
>  	of permitting compiler optimizations that rcu_dereference()
>  	must prohibit.	The rcu_dereference_protected() variant takes
>  	a lockdep expression to indicate which locks must be acquired
> 

