Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752698AbeDRFx3 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 18 Apr 2018 01:53:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:50120 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750861AbeDRFx2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Apr 2018 01:53:28 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E48A421727
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=mhiramat@kernel.org
Date: Wed, 18 Apr 2018 14:53:22 +0900
From: Masami Hiramatsu <mhiramat@kernel.org>
To: Jiri Olsa <jolsa@redhat.com>
Cc: Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>,
        Masami Hiramatsu <mhiramat@kernel.org>, acme@redhat.com,
        kstewart@linuxfoundation.org, tglx@linutronix.de, pombredanne@nexb.com,
        linux-kernel@vger.kernel.org, peterz@infradead.org, mingo@redhat.com,
        alexander.shishkin@linux.intel.com, namhyung@kernel.org,
        uneedsihyeon@gmail.com, kjlx@templeofstupid.com,
        ravi Bangoria <ravi.bangoria@linux.ibm.com>
Subject: Re: [PATCH 3/3] perf/buildid-cache: Support --purge-all option
Message-Id: <20180418145322.74caf3b39ff7587ab7ae2234@kernel.org>
In-Reply-To: <20180416103017.GB23274@krava>
References: <20180409110633.20767-1-ravi.bangoria@linux.vnet.ibm.com>
        <20180409110633.20767-4-ravi.bangoria@linux.vnet.ibm.com>
        <20180416182735.4399e94b3c7e6d190ec7dc3e@kernel.org>
        <f921f16f-578a-955c-4301-e596adbdcd4b@linux.vnet.ibm.com>
        <20180416103017.GB23274@krava>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 16 Apr 2018 12:30:17 +0200
Jiri Olsa <jolsa@redhat.com> wrote:

> On Mon, Apr 16, 2018 at 03:10:40PM +0530, Ravi Bangoria wrote:
> > Hi Masami,
> > 
> > On 04/16/2018 02:57 PM, Masami Hiramatsu wrote:
> > > On Mon,  9 Apr 2018 16:36:33 +0530
> > > Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com> wrote:
> > >
> > >> User can remove files from cache using --remove/--purge options
> > >> but both needs list of files as an argument. It's not convenient
> > >> when you want to flush out entire cache. Add an option to purge
> > >> all files from cache.
> > >>
> > >> Ex,
> > >>   # perf buildid-cache -l
> > >>     /tmp/a.out (8a86ef73e44067bca52cc3f6cd3e5446c783391c)
> > >>     /tmp/a.out.1 (ebe71fdcf4b366518cc154d570a33cd461a51c36)
> > >>   # perf buildid-cache -P -v
> > >>     Removing /tmp/a.out (8a86ef73e44067bca52cc3f6cd3e5446c783391c): Ok
> > >>     Removing /tmp/a.out.1 (ebe71fdcf4b366518cc154d570a33cd461a51c36): Ok
> > >>     Purged all: Ok
> > > Hmm, for purging all caches will be done by
> > >
> > > $ rm -rf ~/.debug
> > >
> > > Are there any difference?
> > 
> > No logical difference if you know it's ~/.debug where it goes. :)
> > I also used to do rm -rf earlier.
> > 
> > This option is for a perf users. But I'm fine if it's not really needed.
> > Will drop it.
> 
> I'd keep it.. as you said it could be configured at some other dir

Sounds reasonable. :)

Thanks,

> 
> jirka


-- 
Masami Hiramatsu <mhiramat@kernel.org>
