Return-Path: <mhiramat@kernel.org>
X-Google-Smtp-Source: AG47ELtNiz7MMPmi11WudVfx9sSn8AyD1AcJEid59XOdv0/pMnUaG2TmuhsbuL7GKzfC3FIdC//k
ARC-Seal: i=1; a=rsa-sha256; t=1521118078; cv=none;
        d=google.com; s=arc-20160816;
        b=bkzjhDv5fKmXSyJQ3u7szEiw6Tp+UDhOYtYjqi7grwwqoex4SP+D8oNvpL/DpDB/zU
         AwpZeJfjie62xpuhvrXXMVNkTpZ1LtjfnzQrA1Q1ZKdW26WFd5b0eklb7rvBWejBQMvX
         5AQSo5xdTgAp2juP5nyamEDTNmRdJ5bk8L1buzP/2nXlu78AAVoza+NDKQGotwICtBe3
         i+JWQatmxdxSLnw0tsE/Z5onPetLoVtFaqsUjLKOXSBvNXcHUNNH3kq/IdQmbSTwa1nU
         D/RwaP9s8uaCOQRckVsSPmQp3sVKVJ/QI/iL6iIHMWvdgQkeVDQRBioIgAeRL0mQSKQu
         OE8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:dmarc-filter
         :arc-authentication-results;
        bh=hwbgj2of/xTJUEVQGePsRvnrLuz+qj5M9S9qXKMulIE=;
        b=O6s36VI3oBi+0ZOA6D2xXsywTEJgrnopY2w95NwNXYYoBAw6/yDT3DI5Hgj8/FZGxd
         37u8CHJSezLsKMA86A4OEM9pMAoUXAMyMwOTdN0EI63coqjSs+OqRmSuhOJQO9+baIfo
         /cBsLo/hforZ/NVLKzXo/pYxX2li13uMColxyi8LurOo1pNQU716emyHZXc4aRPOSYu+
         7PzpOl4XExbYVOk1hAPO9n+uVP3LbRyJBcY8breaI32H1BLe7R7ZQ9YGG1A9+w0Bfyyu
         DT6oQTET3eJ5bcRZGIRHgtTPejNT+IBdD2aSNiMcCS+oyMyAxBumEhPoxxstlCK+VQIJ
         aEdA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of mhiramat@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=mhiramat@kernel.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of mhiramat@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=mhiramat@kernel.org
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EF29E20685
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=mhiramat@kernel.org
Date: Thu, 15 Mar 2018 21:47:50 +0900
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
Message-Id: <20180315214750.fc1d53d01045d8e6c1e8e491@kernel.org>
In-Reply-To: <ec9c4ef7-0117-7c7c-64bc-f6bf4261721d@linux.vnet.ibm.com>
References: <20180313125603.19819-1-ravi.bangoria@linux.vnet.ibm.com>
	<20180313125603.19819-9-ravi.bangoria@linux.vnet.ibm.com>
	<20180314225021.64109239de8b14b0aec1e1c5@kernel.org>
	<ec9c4ef7-0117-7c7c-64bc-f6bf4261721d@linux.vnet.ibm.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594827212550255650?=
X-GMAIL-MSGID: =?utf-8?q?1595007910595166902?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi Ravi,

On Wed, 14 Mar 2018 20:52:59 +0530
Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com> wrote:

> On 03/14/2018 07:20 PM, Masami Hiramatsu wrote:
> > On Tue, 13 Mar 2018 18:26:03 +0530
> > Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com> wrote:
> >
> >> No functionality changes.
> > Please consider to describe what is this change and why, here.
> 
> Will add in next version.

Thanks, and could you also move this before perf-probe patch?
Also Could you make perf-probe check the tracing/README whether
the kernel supports reference counter syntax or not?

perf-tool can be used on older (or stable) kernel.

Thank you,

> 
> >> Signed-off-by: Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>
> >> ---
> >>  Documentation/trace/uprobetracer.txt | 16 +++++++++++++---
> >>  kernel/trace/trace.c                 |  2 +-
> >>  2 files changed, 14 insertions(+), 4 deletions(-)
> >>
> >> diff --git a/Documentation/trace/uprobetracer.txt b/Documentation/trace/uprobetracer.txt
> >> index bf526a7c..8fb13b0 100644
> >> --- a/Documentation/trace/uprobetracer.txt
> >> +++ b/Documentation/trace/uprobetracer.txt
> >> @@ -19,15 +19,25 @@ user to calculate the offset of the probepoint in the object.
> >>  
> >>  Synopsis of uprobe_tracer
> >>  -------------------------
> >> -  p[:[GRP/]EVENT] PATH:OFFSET [FETCHARGS] : Set a uprobe
> >> -  r[:[GRP/]EVENT] PATH:OFFSET [FETCHARGS] : Set a return uprobe (uretprobe)
> >> -  -:[GRP/]EVENT                           : Clear uprobe or uretprobe event
> >> +  p[:[GRP/]EVENT] PATH:OFFSET[(REF_CTR_OFFSET)] [FETCHARGS]
> >> +  r[:[GRP/]EVENT] PATH:OFFSET[(REF_CTR_OFFSET)] [FETCHARGS]
> > Ah, OK in this context, [] means optional syntax :)
> 
> Correct.
> 
> Thanks,
> Ravi
> 


-- 
Masami Hiramatsu <mhiramat@kernel.org>
