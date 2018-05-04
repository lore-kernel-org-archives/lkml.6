Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751892AbeEDOaa (ORCPT <rfc822;w@1wt.eu>);
        Fri, 4 May 2018 10:30:30 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:48614 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751729AbeEDOa1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 May 2018 10:30:27 -0400
Date: Fri, 4 May 2018 16:30:21 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: Ravi Bangoria <ravi.bangoria@linux.ibm.com>
Cc: mhiramat@kernel.org, Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>,
        peterz@infradead.org, srikar@linux.vnet.ibm.com, rostedt@goodmis.org,
        acme@kernel.org, ananth@linux.vnet.ibm.com, akpm@linux-foundation.org,
        alexander.shishkin@linux.intel.com, alexis.berlemont@gmail.com,
        corbet@lwn.net, dan.j.williams@intel.com, jolsa@redhat.com,
        kan.liang@intel.com, kjlx@templeofstupid.com,
        kstewart@linuxfoundation.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        milian.wolff@kdab.com, mingo@redhat.com, namhyung@kernel.org,
        naveen.n.rao@linux.vnet.ibm.com, pc@us.ibm.com, tglx@linutronix.de,
        yao.jin@linux.intel.com, fengguang.wu@intel.com, jglisse@redhat.com
Subject: Re: [PATCH v3 0/9] trace_uprobe: Support SDT markers having
 reference count (semaphore)
Message-ID: <20180504143021.GB26151@redhat.com>
References: <20180417043244.7501-1-ravi.bangoria@linux.vnet.ibm.com>
 <f77789c0-9277-23bf-9abb-92f3f36c4baa@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f77789c0-9277-23bf-9abb-92f3f36c4baa@linux.ibm.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sorry Ravi, I saved the new version for review and forgot about it... I'll
try to do this on weekend.

On 05/03, Ravi Bangoria wrote:
> 
> On 04/17/2018 10:02 AM, Ravi Bangoria wrote:
> > Userspace Statically Defined Tracepoints[1] are dtrace style markers
> > inside userspace applications. Applications like PostgreSQL, MySQL,
> > Pthread, Perl, Python, Java, Ruby, Node.js, libvirt, QEMU, glib etc
> > have these markers embedded in them. These markers are added by developer
> > at important places in the code. Each marker source expands to a single
> > nop instruction in the compiled code but there may be additional
> > overhead for computing the marker arguments which expands to couple of
> > instructions. In case the overhead is more, execution of it can be
> > omitted by runtime if() condition when no one is tracing on the marker:
> >
> >     if (reference_counter > 0) {
> >         Execute marker instructions;
> >     }   
> >
> > Default value of reference counter is 0. Tracer has to increment the 
> > reference counter before tracing on a marker and decrement it when
> > done with the tracing.
> 
> Hi Oleg, Masami,
> 
> Can you please review this :) ?
> 
> Thanks.
> 
