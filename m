Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753751AbeDPKaW (ORCPT <rfc822;w@1wt.eu>);
        Mon, 16 Apr 2018 06:30:22 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:47426 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752201AbeDPKaV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Apr 2018 06:30:21 -0400
Date: Mon, 16 Apr 2018 12:30:17 +0200
From: Jiri Olsa <jolsa@redhat.com>
To: Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, acme@redhat.com,
        kstewart@linuxfoundation.org, tglx@linutronix.de, pombredanne@nexb.com,
        linux-kernel@vger.kernel.org, peterz@infradead.org, mingo@redhat.com,
        alexander.shishkin@linux.intel.com, namhyung@kernel.org,
        uneedsihyeon@gmail.com, kjlx@templeofstupid.com,
        ravi Bangoria <ravi.bangoria@linux.ibm.com>
Subject: Re: [PATCH 3/3] perf/buildid-cache: Support --purge-all option
Message-ID: <20180416103017.GB23274@krava>
References: <20180409110633.20767-1-ravi.bangoria@linux.vnet.ibm.com>
 <20180409110633.20767-4-ravi.bangoria@linux.vnet.ibm.com>
 <20180416182735.4399e94b3c7e6d190ec7dc3e@kernel.org>
 <f921f16f-578a-955c-4301-e596adbdcd4b@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f921f16f-578a-955c-4301-e596adbdcd4b@linux.vnet.ibm.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 16, 2018 at 03:10:40PM +0530, Ravi Bangoria wrote:
> Hi Masami,
> 
> On 04/16/2018 02:57 PM, Masami Hiramatsu wrote:
> > On Mon,  9 Apr 2018 16:36:33 +0530
> > Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com> wrote:
> >
> >> User can remove files from cache using --remove/--purge options
> >> but both needs list of files as an argument. It's not convenient
> >> when you want to flush out entire cache. Add an option to purge
> >> all files from cache.
> >>
> >> Ex,
> >>   # perf buildid-cache -l
> >>     /tmp/a.out (8a86ef73e44067bca52cc3f6cd3e5446c783391c)
> >>     /tmp/a.out.1 (ebe71fdcf4b366518cc154d570a33cd461a51c36)
> >>   # perf buildid-cache -P -v
> >>     Removing /tmp/a.out (8a86ef73e44067bca52cc3f6cd3e5446c783391c): Ok
> >>     Removing /tmp/a.out.1 (ebe71fdcf4b366518cc154d570a33cd461a51c36): Ok
> >>     Purged all: Ok
> > Hmm, for purging all caches will be done by
> >
> > $ rm -rf ~/.debug
> >
> > Are there any difference?
> 
> No logical difference if you know it's ~/.debug where it goes. :)
> I also used to do rm -rf earlier.
> 
> This option is for a perf users. But I'm fine if it's not really needed.
> Will drop it.

I'd keep it.. as you said it could be configured at some other dir

jirka
