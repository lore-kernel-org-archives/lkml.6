Return-Path: <kim.phillips@arm.com>
X-Google-Smtp-Source: AB8JxZraPa80foVjyT5qbgaQavIW4gMbSA7ZWhjrf2KdoBnEMZsh6CIngazHq8igd4bZSWmeH4MA
ARC-Seal: i=1; a=rsa-sha256; t=1527105118; cv=none;
        d=google.com; s=arc-20160816;
        b=EjvdbcRXnaIaISkD3oVLC7e92MgI1AvPO+9jHnrHe3BcjZN1qR/y8ZHgeKlFsH1ULv
         giLcsK7YIeqLhf90X9FBXNcldjSP8hw2dNbqMOKXBTAvRekFoDgWToheP1fHszn/ZqJF
         sxNKqh+yr5+7NzJwf19W5A+Hi1G4bu4SGq8EpJ830HvDTi5GcrcnNt+4i+Hu4MD+svm8
         Fp6692bYZfpKofUPXP8OUX2ear27rLvkl+p4+LHx5NXGdfKWZ/77FOt39NG0zrGRvU4Z
         C6WWWul7oAnaJXVD7pyEkS42UCSQo0pQN9EnRayFt5sO62lAsQwrNqFwuVDxKhLlFIMN
         18Eg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:mime-version:organization:references
         :in-reply-to:message-id:subject:cc:to:from:date
         :arc-authentication-results;
        bh=VmjZs550vxfhb35gynnQ7gPvB5RSAlCTMxHRPdLADEw=;
        b=jGIW65Qs/gVx5D2AeGaOMknTW/uoAjKTLkWGcOSY2QBONpgmFQC7MpHSTrr3F+BeZ8
         w/xQRNlPujaC0blSK3aA+zUmLLjZxS1rEA2Kx8L5NGV3O0vfEi3sSAHA9UXbhiGj2q9u
         +0w9iadYLHaFkG7VHKeGNRDjlm1Eh4DHUW1YtWX0tlIDRcx4NYOSTdLis84ZKYrT5Weu
         dJlAeR8tDrkUbj8QX8pNjvrmh5PhZ6KX8n0YOU9TWfSqxZcMGPydCrxGq6/2apzh4S1X
         kBxp/Oa4Ex5+aJaJbnY4QL3g8Sm/oLRRhdYLAnsLIS6BjF+PR2hmF8R0Ds4q0c2UcgSc
         M5Nw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of kim.phillips@arm.com designates 217.140.101.70 as permitted sender) smtp.mailfrom=kim.phillips@arm.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of kim.phillips@arm.com designates 217.140.101.70 as permitted sender) smtp.mailfrom=kim.phillips@arm.com
Date: Wed, 23 May 2018 14:51:55 -0500
From: Kim Phillips <kim.phillips@arm.com>
To: Mathieu Poirier <mathieu.poirier@linaro.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Alexander Shishkin
 <alexander.shishkin@linux.intel.com>, Alex Williamson
 <alex.williamson@redhat.com>, Andrew Morton <akpm@linux-foundation.org>,
 David Howells <dhowells@redhat.com>, Eric Auger <eric.auger@redhat.com>,
 Eric Biederman <ebiederm@xmission.com>, Gargi Sharma <gs051095@gmail.com>,
 Geert Uytterhoeven <geert+renesas@glider.be>, Kefeng Wang
 <wangkefeng.wang@huawei.com>, Kirill Tkhai <ktkhai@virtuozzo.com>, Mike
 Rapoport <rppt@linux.vnet.ibm.com>, Oleg Nesterov <oleg@redhat.com>, Pavel
 Tatashin <pasha.tatashin@oracle.com>, Rik van Riel <riel@redhat.com>, Robin
 Murphy <robin.murphy@arm.com>, Russell King <linux@armlinux.org.uk>,
 Thierry Reding <treding@nvidia.com>, Todd Kjos <tkjos@google.com>, Randy
 Dunlap <rdunlap@infradead.org>, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/6] coresight: remove CORESIGHT_LINKS_AND_SINKS
 dependencies and selections
Message-Id: <20180523145155.5929dd09c78a056ef19329be@arm.com>
In-Reply-To: <20180522173140.GA25658@xps15>
References: <20180517070643.GC13919@kroah.com>
	<20180518012024.22645-1-kim.phillips@arm.com>
	<20180522173140.GA25658@xps15>
Organization: Arm
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1600762901299441866?=
X-GMAIL-MSGID: =?utf-8?q?1601285777181131837?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, 22 May 2018 11:31:40 -0600
Mathieu Poirier <mathieu.poirier@linaro.org> wrote:

> On Thu, May 17, 2018 at 08:20:19PM -0500, Kim Phillips wrote:
> > A coresight topology doesn't need to include links, i.e., a source can
> > be directly connected to a sink.  As such, selecting and/or depending on
> > LINKS_AND_SINKS is no longer needed.
> 
> I'm good with this patch but now the help text for CORESIGHT_LINKS_AND_SINKS no
> longer match what the config does.  I see two ways to fix this:

This patch doesn't change what the config does, it just changes what
other config options depend on it.

> 1) Rework the help text.

I don't see how, given the above.  Here's the text:

config CORESIGHT_LINKS_AND_SINKS
        bool "CoreSight Link and Sink drivers"
        help
          This enables support for CoreSight link and sink drivers that are
          responsible for transporting and collecting the trace data
          respectively.  Link and sinks are dynamically aggregated with a trace
          entity at run time to form a complete trace path.

What part of that becomes invalid with this patch?

> 2) Rework CORESIGHT_LINKS_AND_SINKS to be CORESIGHT_FUNNEL and move
> coresight-replicator.o under CORESIGHT_DYNAMIC_REPLICATOR in the Makefile. I
> really liked your idea of making the replicator driver intelligent enough to
> deal with both DT and platform declaration, which merges two driver into one.
> 
> I'm obviously favouring the second option but recognise it doesn't have to be
> part of this patchet.  So for this set please rework the help text for
> CORESIGHT_LINKS_AND_SINKS.  Once we've dealt with this topic we can refactor the
> replicator driver.

I'd really like to just focus on getting CoreSight to load as modules,
something for which this patch isn't technically required...

Thanks,

Kim
