Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752054AbeFEPbw (ORCPT <rfc822;w@1wt.eu>);
        Tue, 5 Jun 2018 11:31:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:39534 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751662AbeFEPbt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jun 2018 11:31:49 -0400
Date: Tue, 5 Jun 2018 12:31:45 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org
Subject: Re: [PATCH] perf tools: Fix object code reading for PTI entry
 trampolines
Message-ID: <20180605153145.GI4899@kernel.org>
References: <1528183800-21577-1-git-send-email-adrian.hunter@intel.com>
 <20180605134142.GE4899@kernel.org>
 <00606a96-4e6b-6c98-c560-db722f4cd865@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <00606a96-4e6b-6c98-c560-db722f4cd865@intel.com>
X-Url: http://acmel.wordpress.com
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Tue, Jun 05, 2018 at 05:08:35PM +0300, Adrian Hunter escreveu:
> On 05/06/18 16:41, Arnaldo Carvalho de Melo wrote:
> > And this test fails way less often, but still does, for instance:

> > # while true ; do perf test -v object 2>out.txt ; grep -i fail out.txt && break ; done
> > dso__data_read_offset failed
> > Object code reading: FAILED!
> > #
> > [root@seventh ~]# tail out.txt 
> > File is: /proc/kcore
> > On file address is: 0x7fff892300df
> > kcore map tested already - skipping
> > Reading object code for memory address: 0x4a020f
> > File is: /home/acme/bin/perf (deleted)
> > On file address is: 0xa020f
> > dso__data_read_offset failed
> > test child finished with -1
> > ---- end ----
> > Object code reading: FAILED!
> > [root@seventh ~]#

> > I start that loop and then try running 'make -C tools/perf O=/tmp/build/perf install-bin',
> > to generate some load.

> So is it related to the "deleted" in "File is: /home/acme/bin/perf (deleted)"?

Probably, Jiri? Probably it'll be difficult to sort this out, as the
original for that file probably isn't available anymore and probably we
didn't had the opportunity to have already read its build-id to lookup
it in the ~/.debug/ cache... So probably we should notice that and skip
this, not considering it as an error?

- Arnaldo
