Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1425968AbeCBJup (ORCPT <rfc822;w@1wt.eu>);
        Fri, 2 Mar 2018 04:50:45 -0500
Received: from mga18.intel.com ([134.134.136.126]:52412 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1424456AbeCBJuk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Mar 2018 04:50:40 -0500
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.47,411,1515484800";
   d="scan'208";a="35379315"
Date: Fri, 2 Mar 2018 17:41:40 +0800
From: "Du, Changbin" <changbin.du@intel.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: "Du, Changbin" <changbin.du@intel.com>,
        Rafael Wysocki <rafael.j.wysocki@intel.com>,
        Linux PM <linux-pm@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>, Ingo Molnar <mingo@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] tracing/power: Polish the tracepoints cpu_idle and
 cpu_frequency
Message-ID: <20180302094140.ncypewkdg6g6rs2g@intel.com>
References: <1519809638-24248-1-git-send-email-changbin.du@intel.com>
 <CAJZ5v0jqG0pcqOuvAVoP7sNKoOe+3ByMk4X5AZASp84OPcrgPg@mail.gmail.com>
 <20180301022719.xyfcu5tpmadjxbut@intel.com>
 <CAJZ5v0j8GsaK7kJ4hyvyQYOpa6QmoP2Pc69egg0hb=tb2EwpuA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJZ5v0j8GsaK7kJ4hyvyQYOpa6QmoP2Pc69egg0hb=tb2EwpuA@mail.gmail.com>
User-Agent: NeoMutt/20171027-42-ad8712
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> >> That rather isn't the case if negative values are ever passed to the
> >> tracepoint, right?
> >>
> > yes.
> >> Which seems to be the reason why you want to make this change, isn't it?
> >>
> > yes, to improve readability.
> >
> >> So maybe fix the code using the tracepoint(s) to avoid passing
> >> negative values to it(them)?
> > For cpu_idle event, [0, CPUIDLE_STATE_MAX) are used to index the idle state arrary,
> > so I think a appropriate value for PWR_EVENT_EXIT is -1 (defined in include/trace/events/power.h).
> > Or do you have a better idea? Thanks!
> 
> Sorry, I'm not sure what you mean.
> 
> I'm saying that the code using the CPU PM tracepoints is not expected
> to pass -1 as the CPU number to them.  IOW, neither -1 nor its UL
> representation should ever appear in the output of these tracepoints.
> If that happens, it is a problem with the code using the tracepoints
> which needs to be fixed.  Users should not see any of these values.

This patch only changed 'state' field but cpuid. For cpu_idle event, 'state' is
singned value, but for cpu_frequency it is unsinged.
The cpuid is always unsinged value. So no one passes -1 as CPU number.

-- 
Thanks,
Changbin Du
