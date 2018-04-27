Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932863AbeD0Qov (ORCPT <rfc822;w@1wt.eu>);
        Fri, 27 Apr 2018 12:44:51 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:34410 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1758562AbeD0Qot (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Apr 2018 12:44:49 -0400
Date: Fri, 27 Apr 2018 09:45:54 -0700
From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Joel Fernandes <joelaf@google.com>,
        LKML <linux-kernel@vger.kernel.org>,
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
        Vedang Patel <vedang.patel@intel.com>,
        "Cc: Android Kernel" <kernel-team@android.com>
Subject: Re: [PATCH RFC] tracepoint: Introduce tracepoint callbacks executing
 with preempt on
Reply-To: paulmck@linux.vnet.ibm.com
References: <20180427042656.190746-1-joelaf@google.com>
 <20180427155701.GL26088@linux.vnet.ibm.com>
 <CAJWu+or9GJwkDK9+842YbobG3=xVW-PgqS=uE5P2xFbDhmqxEQ@mail.gmail.com>
 <20180427122201.75abc313@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180427122201.75abc313@gandalf.local.home>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 18042716-0044-0000-0000-0000040C3FD9
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00008932; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000257; SDB=6.01024091; UDB=6.00522853; IPR=6.00803321;
 MB=3.00020809; MTD=3.00000008; XFM=3.00000015; UTC=2018-04-27 16:44:42
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18042716-0045-0000-0000-0000083E4234
Message-Id: <20180427164554.GO26088@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-04-27_05:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1804270161
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 27, 2018 at 12:22:01PM -0400, Steven Rostedt wrote:
> On Fri, 27 Apr 2018 09:14:30 -0700
> Joel Fernandes <joelaf@google.com> wrote:
> 
> > > Hmmm...  Do I need to create a _notrace variant of srcu_read_lock()
> > > and srcu_read_unlock()?  
> > 
> > That shouldn't be needed. For the rcu_read_lock_sched case, there is a
> > preempt_disable which needs to be a notrace, but for the srcu one,
> > since we don't do that, I think it should be fine.
> 
> Actually, I think I may agree here too. Because the _notrace is for
> function tracing, and it shouldn't affect it. If people don't want it
> traced, they could add those functions to the list in the notrace file.

OK, feel free to ignore my notrace srcu_read_lock() patch, then.  ;-)

							Thanx, Paul
