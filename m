Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752730AbeEGOWJ (ORCPT <rfc822;w@1wt.eu>);
        Mon, 7 May 2018 10:22:09 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:52286 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1752182AbeEGOWC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 May 2018 10:22:02 -0400
Date: Mon, 7 May 2018 07:23:22 -0700
From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
To: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Cc: Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Mauro Carvalho Chehab <mchehab@infradead.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        Josh Triplett <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>
Subject: Re: [PATCH 10/18] rcu: rcupdate.h: get rid of Sphinx warnings at
 rcu_pointer_handoff()
Reply-To: paulmck@linux.vnet.ibm.com
References: <cover.1525684985.git.mchehab+samsung@kernel.org>
 <a87d742e81124ddfeaa5b83daf10c91758c1b025.1525684985.git.mchehab+samsung@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a87d742e81124ddfeaa5b83daf10c91758c1b025.1525684985.git.mchehab+samsung@kernel.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 18050714-0040-0000-0000-00000427CAEE
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00008986; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000258; SDB=6.01028842; UDB=6.00525668; IPR=6.00807975;
 MB=3.00020971; MTD=3.00000008; XFM=3.00000015; UTC=2018-05-07 14:22:00
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18050714-0041-0000-0000-0000082DD707
Message-Id: <20180507142322.GW26088@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-05-07_06:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1805070147
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 07, 2018 at 06:35:46AM -0300, Mauro Carvalho Chehab wrote:
> The code example at rcupdate.h currently produce lots of warnings:
> 
> 	./include/linux/rcupdate.h:572: WARNING: Unexpected indentation.
> 	./include/linux/rcupdate.h:576: WARNING: Unexpected indentation.
> 	./include/linux/rcupdate.h:580: WARNING: Block quote ends without a blank line; unexpected unindent.
> 	./include/linux/rcupdate.h:582: WARNING: Block quote ends without a blank line; unexpected unindent.
> 	./include/linux/rcupdate.h:582: WARNING: Inline literal start-string without end-string.
> 
> Change it to a code-block.
> 
> Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>

Acked-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>

If you don't tell me otherwise, I will assume that you are pushing this.
If you would rather that I take it, please let me know!

							Thanx, Paul

> ---
>  include/linux/rcupdate.h | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/include/linux/rcupdate.h b/include/linux/rcupdate.h
> index 36360d07f25b..c890d10978fa 100644
> --- a/include/linux/rcupdate.h
> +++ b/include/linux/rcupdate.h
> @@ -568,8 +568,8 @@ static inline void rcu_preempt_sleep_check(void) { }
>   * This is simply an identity function, but it documents where a pointer
>   * is handed off from RCU to some other synchronization mechanism, for
>   * example, reference counting or locking.  In C11, it would map to
> - * kill_dependency().  It could be used as follows:
> - * ``
> + * kill_dependency().  It could be used as follows::
> + *
>   *	rcu_read_lock();
>   *	p = rcu_dereference(gp);
>   *	long_lived = is_long_lived(p);
> @@ -580,7 +580,6 @@ static inline void rcu_preempt_sleep_check(void) { }
>   *			p = rcu_pointer_handoff(p);
>   *	}
>   *	rcu_read_unlock();
> - *``
>   */
>  #define rcu_pointer_handoff(p) (p)
> 
> -- 
> 2.17.0
> 
