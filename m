Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932998AbeD0PhR (ORCPT <rfc822;w@1wt.eu>);
        Fri, 27 Apr 2018 11:37:17 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:53222 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S932906AbeD0PhP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Apr 2018 11:37:15 -0400
Date: Fri, 27 Apr 2018 08:38:26 -0700
From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Joel Fernandes <joelaf@google.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
        Tom Zanussi <tom.zanussi@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Boqun Feng <boqun.feng@gmail.com>, fweisbec <fweisbec@gmail.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        kbuild test robot <fengguang.wu@intel.com>,
        baohong liu <baohong.liu@intel.com>,
        vedang patel <vedang.patel@intel.com>, kernel-team@android.com
Subject: Re: [PATCH RFC] tracepoint: Introduce tracepoint callbacks executing
 with preempt on
Reply-To: paulmck@linux.vnet.ibm.com
References: <20180427042656.190746-1-joelaf@google.com>
 <1169911546.5820.1524839189395.JavaMail.zimbra@efficios.com>
 <20180427104747.2d965925@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180427104747.2d965925@gandalf.local.home>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 18042715-2213-0000-0000-0000029A3992
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00008932; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000257; SDB=6.01024069; UDB=6.00522840; IPR=6.00803299;
 MB=3.00020808; MTD=3.00000008; XFM=3.00000015; UTC=2018-04-27 15:37:14
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18042715-2214-0000-0000-000059EA15E5
Message-Id: <20180427153826.GK26088@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-04-27_04:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1804270149
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 27, 2018 at 10:47:47AM -0400, Steven Rostedt wrote:
> On Fri, 27 Apr 2018 10:26:29 -0400 (EDT)
> Mathieu Desnoyers <mathieu.desnoyers@efficios.com> wrote:
> 
> > The general approach and the implementation look fine, except for
> > one small detail: I would be tempted to explicitly disable preemption
> > around the call to the tracepoint callback for the rcuidle variant,
> > unless we plan to audit every tracer right away to remove any assumption
> > that preemption is disabled in the callback implementation.
> 
> I'm thinking that we do that audit. There shouldn't be many instances
> of it. I like the idea that a tracepoint callback gets called with
> preemption enabled.

Are you really sure you want to increase your state space that much?

							Thanx, Paul
