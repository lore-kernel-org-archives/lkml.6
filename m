Return-Path: <mhiramat@kernel.org>
X-Google-Smtp-Source: AG47ELvQMeeSitCjGJRB/RKL4HTYaep1VFO4f3JMgR3s6lQ12Ne3LuOX0SUMyp9m0bsW96Uv2zuV
ARC-Seal: i=1; a=rsa-sha256; t=1521210427; cv=none;
        d=google.com; s=arc-20160816;
        b=dN3RzETd/wKCDQWfE1CxjRy3Nxd8jxDNGm2kYlAuxFwf1KWKFCyojYrk2OqT2ydnKF
         /kWLvoswOlwbHi+tAWnd3n2a5kX/Fx7VqyeQ1zPfu9HmhaHH/q35iaTkPpWsvwph+Q/8
         gTz7vmtv2zLPZJGk20fl+PIbJI/9cdsYN10mA0x0n3IIWquQFFNsmi7iZCBVt1lcJdYl
         eQEOzvGSgYF5c4h1hyD1eOxpMV/E/byDX6CWaKzcsaPXbscNs6KI2zIllp90Xk62E5K+
         9s6inmXgvs1sKaSAoynY0fGQLpOlli2tYFOr5P3Pw31Zesk4oAuoMuL7TLYbNCfPmSul
         OhxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:dmarc-filter
         :arc-authentication-results;
        bh=qUfwf43KyWP6B/DOc3Te6IF2qBNABbJ5DiTN238lK34=;
        b=khaIzhuBw/2dJhwzJYtA4PT/e5GYh+vfUptrCL29u0uAY+aN6QeTRwxDLk5HGcCE/K
         I6Rz+AJCjyLK2IY9IKDTAu2ie5LSWbWHh31n+s+J32xJgGixCXyAMSMWbHQgf1npl8gT
         4cqnE1kgyXX1ihJS4wY30ppwX/rxMet4vAaf1VFf1tPKD+Wdagu6cEg/ctINUksJNEjh
         W0sohj7E1mmTOuhWdWvJpTFjObYQ5k2E8rEjvCloCrgaiLh8QIPp/zDWqxOUK4DrZcZq
         vPW6myJnlBEWkaX1npoyCe/OlFJ2g0GyZygSlzEqssS/hUQYoj8lYa9f16pZrBv5S+at
         yvgg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of mhiramat@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=mhiramat@kernel.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of mhiramat@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=mhiramat@kernel.org
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 61153217D2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=mhiramat@kernel.org
Date: Fri, 16 Mar 2018 23:26:59 +0900
From: Masami Hiramatsu <mhiramat@kernel.org>
To: Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>
Cc: oleg@redhat.com, peterz@infradead.org, srikar@linux.vnet.ibm.com,
 acme@kernel.org, ananth@linux.vnet.ibm.com, akpm@linux-foundation.org,
 alexander.shishkin@linux.intel.com, alexis.berlemont@gmail.com,
 corbet@lwn.net, dan.j.williams@intel.com, gregkh@linuxfoundation.org,
 huawei.libin@huawei.com, hughd@google.com, jack@suse.cz,
 jglisse@redhat.com, jolsa@redhat.com, kan.liang@intel.com,
 kirill.shutemov@linux.intel.com, kjlx@templeofstupid.com,
 kstewart@linuxfoundation.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org, mhocko@suse.com,
 milian.wolff@kdab.com, mingo@redhat.com, namhyung@kernel.org,
 naveen.n.rao@linux.vnet.ibm.com, pc@us.ibm.com, pombredanne@nexb.com,
 rostedt@goodmis.org, tglx@linutronix.de, tmricht@linux.vnet.ibm.com,
 willy@infradead.org, yao.jin@linux.intel.com, fengguang.wu@intel.com
Subject: Re: [PATCH 8/8] trace_uprobe/sdt: Document about reference counter
Message-Id: <20180316232659.4a9a31eac46c6b30105d2bce@kernel.org>
In-Reply-To: <e991f9e2-6488-7739-548d-6ca28c57826d@linux.vnet.ibm.com>
References: <20180313125603.19819-1-ravi.bangoria@linux.vnet.ibm.com>
	<20180313125603.19819-9-ravi.bangoria@linux.vnet.ibm.com>
	<20180314225021.64109239de8b14b0aec1e1c5@kernel.org>
	<ec9c4ef7-0117-7c7c-64bc-f6bf4261721d@linux.vnet.ibm.com>
	<20180315214750.fc1d53d01045d8e6c1e8e491@kernel.org>
	<e991f9e2-6488-7739-548d-6ca28c57826d@linux.vnet.ibm.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594827212550255650?=
X-GMAIL-MSGID: =?utf-8?q?1595104745052879225?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Fri, 16 Mar 2018 15:12:38 +0530
Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com> wrote:

> On 03/15/2018 06:17 PM, Masami Hiramatsu wrote:
> > Hi Ravi,
> >
> > On Wed, 14 Mar 2018 20:52:59 +0530
> > Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com> wrote:
> >
> >> On 03/14/2018 07:20 PM, Masami Hiramatsu wrote:
> >>> On Tue, 13 Mar 2018 18:26:03 +0530
> >>> Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com> wrote:
> >>>
> >>>> No functionality changes.
> >>> Please consider to describe what is this change and why, here.
> >> Will add in next version.
> > Thanks, and could you also move this before perf-probe patch?
> > Also Could you make perf-probe check the tracing/README whether
> > the kernel supports reference counter syntax or not?
> >
> > perf-tool can be used on older (or stable) kernel.
> 
> Sure, Will do that.

Please see scan_ftrace_readme@util/probe-file.c :)
It is easy to expand the pattern table.

Thank you,

-- 
Masami Hiramatsu <mhiramat@kernel.org>
