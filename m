Return-Path: <SRS0=+AQW=M2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27D04C71122
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Oct 2018 23:17:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 92F9420835
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Oct 2018 23:17:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 92F9420835
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726424AbeJOHAN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Oct 2018 03:00:13 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:47412 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726098AbeJOHAN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Oct 2018 03:00:13 -0400
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w9ENAoCV071183
        for <linux-kernel@vger.kernel.org>; Sun, 14 Oct 2018 19:17:35 -0400
Received: from e12.ny.us.ibm.com (e12.ny.us.ibm.com [129.33.205.202])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2n3wnx9594-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Sun, 14 Oct 2018 19:17:35 -0400
Received: from localhost
        by e12.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Sun, 14 Oct 2018 19:17:34 -0400
Received: from b01cxnp22033.gho.pok.ibm.com (9.57.198.23)
        by e12.ny.us.ibm.com (146.89.104.199) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Sun, 14 Oct 2018 19:17:29 -0400
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp22033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w9ENHSIC29884584
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Sun, 14 Oct 2018 23:17:28 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C3D74B2064;
        Sun, 14 Oct 2018 19:15:24 -0400 (EDT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8EF4CB205F;
        Sun, 14 Oct 2018 19:15:24 -0400 (EDT)
Received: from paulmck-ThinkPad-W541 (unknown [9.85.131.128])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Sun, 14 Oct 2018 19:15:24 -0400 (EDT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id 939D216C1FB9; Sun, 14 Oct 2018 16:17:31 -0700 (PDT)
Date:   Sun, 14 Oct 2018 16:17:31 -0700
From:   "Paul E. McKenney" <paulmck@linux.ibm.com>
To:     "Joel Fernandes (Google)" <joel@joelfernandes.org>
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
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181014212955.95267-1-joel@joelfernandes.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 18101423-0060-0000-0000-000002C095D0
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009879; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000268; SDB=6.01102741; UDB=6.00570737; IPR=6.00882792;
 MB=3.00023757; MTD=3.00000008; XFM=3.00000015; UTC=2018-10-14 23:17:32
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18101423-0061-0000-0000-000046D8FB30
Message-Id: <20181014231731.GN2674@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-10-14_18:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1810140221
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 14, 2018 at 02:29:55PM -0700, Joel Fernandes (Google) wrote:
> The Requirements.html document says "Disabling Preemption Does Not Block
> Grace Periods". However this is no longer true with the RCU
> consolidation. Lets remove the obsolete (non-)requirement entirely.
> 
> Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>

Good catch, queued, thank you!

							Thanx, Paul

> ---
>  .../RCU/Design/Requirements/Requirements.html | 50 -------------------
>  1 file changed, 50 deletions(-)
> 
> diff --git a/Documentation/RCU/Design/Requirements/Requirements.html b/Documentation/RCU/Design/Requirements/Requirements.html
> index 7efc1c1da7af..4fae55056c1d 100644
> --- a/Documentation/RCU/Design/Requirements/Requirements.html
> +++ b/Documentation/RCU/Design/Requirements/Requirements.html
> @@ -900,8 +900,6 @@ Except where otherwise noted, these non-guarantees were premeditated.
>  	Grace Periods Don't Partition Read-Side Critical Sections</a>
>  <li>	<a href="#Read-Side Critical Sections Don't Partition Grace Periods">
>  	Read-Side Critical Sections Don't Partition Grace Periods</a>
> -<li>	<a href="#Disabling Preemption Does Not Block Grace Periods">
> -	Disabling Preemption Does Not Block Grace Periods</a>
>  </ol>
>  
>  <h3><a name="Readers Impose Minimal Ordering">Readers Impose Minimal Ordering</a></h3>
> @@ -1259,54 +1257,6 @@ of RCU grace periods.
>  <tr><td>&nbsp;</td></tr>
>  </table>
>  
> -<h3><a name="Disabling Preemption Does Not Block Grace Periods">
> -Disabling Preemption Does Not Block Grace Periods</a></h3>
> -
> -<p>
> -There was a time when disabling preemption on any given CPU would block
> -subsequent grace periods.
> -However, this was an accident of implementation and is not a requirement.
> -And in the current Linux-kernel implementation, disabling preemption
> -on a given CPU in fact does not block grace periods, as Oleg Nesterov
> -<a href="https://lkml.kernel.org/g/20150614193825.GA19582@redhat.com">demonstrated</a>.
> -
> -<p>
> -If you need a preempt-disable region to block grace periods, you need to add
> -<tt>rcu_read_lock()</tt> and <tt>rcu_read_unlock()</tt>, for example
> -as follows:
> -
> -<blockquote>
> -<pre>
> - 1 preempt_disable();
> - 2 rcu_read_lock();
> - 3 do_something();
> - 4 rcu_read_unlock();
> - 5 preempt_enable();
> - 6
> - 7 /* Spinlocks implicitly disable preemption. */
> - 8 spin_lock(&amp;mylock);
> - 9 rcu_read_lock();
> -10 do_something();
> -11 rcu_read_unlock();
> -12 spin_unlock(&amp;mylock);
> -</pre>
> -</blockquote>
> -
> -<p>
> -In theory, you could enter the RCU read-side critical section first,
> -but it is more efficient to keep the entire RCU read-side critical
> -section contained in the preempt-disable region as shown above.
> -Of course, RCU read-side critical sections that extend outside of
> -preempt-disable regions will work correctly, but such critical sections
> -can be preempted, which forces <tt>rcu_read_unlock()</tt> to do
> -more work.
> -And no, this is <i>not</i> an invitation to enclose all of your RCU
> -read-side critical sections within preempt-disable regions, because
> -doing so would degrade real-time response.
> -
> -<p>
> -This non-requirement appeared with preemptible RCU.
> -
>  <h2><a name="Parallelism Facts of Life">Parallelism Facts of Life</a></h2>
>  
>  <p>
> -- 
> 2.19.0.605.g01d371f741-goog
> 

