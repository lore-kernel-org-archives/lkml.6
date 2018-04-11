Date: Wed, 11 Apr 2018 21:33:53 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Murilo Opsfelder Araujo <muriloo@linux.ibm.com>
Cc: linux-kernel@vger.kernel.org, stable@vger.kernel.org,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Andi Kleen <ak@linux.intel.com>,
	Arnaldo Carvalho de Melo <acme@redhat.com>,
	David Carrillo-Cisneros <davidcc@google.com>,
	He Kuang <hekuang@huawei.com>, Ingo Molnar <mingo@redhat.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Paul Mackerras <paulus@samba.org>, Paul Turner <pjt@google.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Sasha Levin <alexander.levin@microsoft.com>,
	Simon Que <sque@chromium.org>,
	Stephane Eranian <eranian@google.com>,
	Wang Nan <wangnan0@huawei.com>
Subject: Re: [PATCH] perf session: Fix undeclared 'oe'
Message-ID: <20180411193353.GA5656@kroah.com>
References: <20180411184135.27664-1-muriloo@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180411184135.27664-1-muriloo@linux.ibm.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, Apr 11, 2018 at 03:41:35PM -0300, Murilo Opsfelder Araujo wrote:
> Using linux-3.18.y branch, perf build fails with the following:
> 
>     $ make -s -j16 -C tools/perf V=1 WERROR=0 NO_LIBUNWIND=1 HAVE_CPLUS_DEMANGLE=1 NO_GTK2=1 NO_LIBNUMA=1 NO_STRLCPY=1 NO_BIONIC=1 prefix=/usr DESTDIR=/tmp/builddir/build all
>     [...]
>     util/session.c: In function ‘__perf_session__process_pipe_events’:
>     util/session.c:1093:36: error: ‘oe’ undeclared (first use in this function)
>       ordered_events__set_copy_on_queue(oe, true);
>                                         ^
>     util/session.c:1093:36: note: each undeclared identifier is reported only once for each function it appears in
> 
> This patch fixes it for linux-3.18.y branch.

Why is this failing now?  Has it always been broken?  Is there an
upstream patch that fixed this instead?

> Fixes: 95b33b99cdd6 ("perf inject: Copy events when reordering events in pipe mode")

Was this just a bad backport?

thanks,

greg k-h
