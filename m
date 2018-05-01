Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756087AbeEAP0c (ORCPT <rfc822;w@1wt.eu>);
        Tue, 1 May 2018 11:26:32 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:56408 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1755600AbeEAP0a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 May 2018 11:26:30 -0400
Date: Tue, 1 May 2018 08:27:43 -0700
From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Joel Fernandes <joelaf@google.com>, linux-kernel@vger.kernel.org,
        Peter Zilstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Tom Zanussi <tom.zanussi@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Thomas Glexiner <tglx@linutronix.de>,
        Boqun Feng <boqun.feng@gmail.com>,
        Frederic Weisbecker <fweisbec@gmail.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Fenguang Wu <fengguang.wu@intel.com>,
        Baohong Liu <baohong.liu@intel.com>,
        Vedang Patel <vedang.patel@intel.com>, kernel-team@android.com
Subject: Re: [PATCH RFC v5 3/6] srcu: Add notrace variant of srcu_dereference
Reply-To: paulmck@linux.vnet.ibm.com
References: <20180501014204.67548-1-joelaf@google.com>
 <20180501014204.67548-4-joelaf@google.com>
 <20180501141817.GE26088@linux.vnet.ibm.com>
 <20180501110403.0b661039@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180501110403.0b661039@gandalf.local.home>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 18050115-0052-0000-0000-000002E72B48
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00008957; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000257; SDB=6.01025984; UDB=6.00523967; IPR=6.00805215;
 MB=3.00020883; MTD=3.00000008; XFM=3.00000015; UTC=2018-05-01 15:26:27
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18050115-0053-0000-0000-00005C871E7C
Message-Id: <20180501152743.GK26088@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-05-01_07:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1805010152
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 01, 2018 at 11:04:03AM -0400, Steven Rostedt wrote:
> On Tue, 1 May 2018 07:18:17 -0700
> "Paul E. McKenney" <paulmck@linux.vnet.ibm.com> wrote:
> 
> 
> > > diff --git a/include/linux/srcu.h b/include/linux/srcu.h
> > > index 2ec618979b20..a1c4947be877 100644
> > > --- a/include/linux/srcu.h
> > > +++ b/include/linux/srcu.h
> > > @@ -135,6 +135,11 @@ static inline int srcu_read_lock_held(const struct srcu_struct *sp)
> > >   */
> > >  #define srcu_dereference(p, sp) srcu_dereference_check((p), (sp), 0)
> > > 
> > > +/**
> > > + * srcu_dereference_notrace - no tracing and no lockdep calls from here
> > > + */
> > > +#define srcu_dereference_notrace(p, sp) srcu_dereference_check((p), (sp), 1)  
> > 
> > Given that this is a one-liner, why not just use srcu_dereference_check()
> > directly, with 1 as you do above to disable lockdep?
> 
> I prefer what Joel did. It documents why we are doing this. Open coding
> the call directly will just confuse others that touch tracepoint code.

I suppose...

Reviewed-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
