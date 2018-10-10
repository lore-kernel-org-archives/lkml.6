Return-Path: <SRS0=PZ5q=MW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0E41C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 03:09:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5F929213A2
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 03:09:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5F929213A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727031AbeJJK3O (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Oct 2018 06:29:14 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:56718 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726827AbeJJK3O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Oct 2018 06:29:14 -0400
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w9A34EqX177789
        for <linux-kernel@vger.kernel.org>; Tue, 9 Oct 2018 23:09:12 -0400
Received: from e14.ny.us.ibm.com (e14.ny.us.ibm.com [129.33.205.204])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2n17jqua9e-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Tue, 09 Oct 2018 23:09:12 -0400
Received: from localhost
        by e14.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Tue, 9 Oct 2018 23:09:11 -0400
Received: from b01cxnp22034.gho.pok.ibm.com (9.57.198.24)
        by e14.ny.us.ibm.com (146.89.104.201) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Tue, 9 Oct 2018 23:09:08 -0400
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp22034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w9A397wP58916954
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 10 Oct 2018 03:09:07 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1FD7EB2066;
        Tue,  9 Oct 2018 23:07:10 -0400 (EDT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id EBB93B2064;
        Tue,  9 Oct 2018 23:07:09 -0400 (EDT)
Received: from paulmck-ThinkPad-W541 (unknown [9.85.167.121])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Tue,  9 Oct 2018 23:07:09 -0400 (EDT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id 0575A16C4285; Tue,  9 Oct 2018 20:09:07 -0700 (PDT)
Date:   Tue, 9 Oct 2018 20:09:06 -0700
From:   "Paul E. McKenney" <paulmck@linux.ibm.com>
To:     "Joel Fernandes (Google)" <joel@joelfernandes.org>
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
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181009013341.60111-1-joel@joelfernandes.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 18101003-0052-0000-0000-000003406320
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009851; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000268; SDB=6.01100424; UDB=6.00569344; IPR=6.00880473;
 MB=3.00023688; MTD=3.00000008; XFM=3.00000015; UTC=2018-10-10 03:09:11
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18101003-0053-0000-0000-00005E5BAD40
Message-Id: <20181010030906.GB2674@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-10-09_14:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1810100029
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 08, 2018 at 06:33:41PM -0700, Joel Fernandes (Google) wrote:
> whatisRCU says rcu_dereference cannot be used outside of rcu read lock
> protected sections. Its better to mention rcu_dereference_protected when
> it says that, so that the new reader is aware of this API and is not led
> to believing that all RCU dereferences in all situations have to be
> protected by a rcu_read_lock() and rcu_read_unlock().
> 
> Cc: tytso@mit.edu
> Suggested-by: tytso@mit.edu
> Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>

Good stuff!  I queued and pushed this with some wordsmithing.  Could
you please check for my having messed something up?

							Thanx, Paul

> ---
>  Documentation/RCU/whatisRCU.txt | 20 +++++++++++++++++++-
>  1 file changed, 19 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/RCU/whatisRCU.txt b/Documentation/RCU/whatisRCU.txt
> index 7c33445fd0e5..da820fc9b307 100644
> --- a/Documentation/RCU/whatisRCU.txt
> +++ b/Documentation/RCU/whatisRCU.txt
> @@ -266,7 +266,7 @@ rcu_dereference()
>  	unnecessary overhead on Alpha CPUs.
>  
>  	Note that the value returned by rcu_dereference() is valid
> -	only within the enclosing RCU read-side critical section.
> +	only within the enclosing RCU read-side critical section [1].
>  	For example, the following is -not- legal:
>  
>  		rcu_read_lock();
> @@ -292,6 +292,24 @@ rcu_dereference()
>  	typically used indirectly, via the _rcu list-manipulation
>  	primitives, such as list_for_each_entry_rcu().
>  
> +	[1] The variant rcu_dereference_protected() can be used outside
> +	of an RCU read-side critical section as long as the usage is
> +	protected by update-side locks. These update-side locks are
> +	obviously acquired by the update-side code, but may also be used
> +	to protect other code sequences outside of the reader and the
> +	updater. If such sequences need to make an rcu_dereference() call,
> +	they can instead simply call rcu_dereference_protected() without
> +	needing extra calls to rcu_read_lock() and rcu_read_unlock().
> +	Another advantage of using rcu_dereference_protected() is it does
> +	not prevent compiler optimizations unlike rcu_dereference() which
> +	could result in optimized and the result is assured to be
> +	functionaly correct due to the update-side locks.
> +	rcu_dereference_protected() takes a lockdep expression to
> +	indicate what is providing the protection. If the indicated
> +	protection is not provided, a lockdep splat is emitted.
> +	See RCU/Design/Requirements.html and the API's code comments
> +	for more details and example usage.
> +
>  The following diagram shows how each API communicates among the
>  reader, updater, and reclaimer.
>  
> -- 
> 2.19.0.605.g01d371f741-goog
> 

