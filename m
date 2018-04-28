Date: Sat, 28 Apr 2018 10:11:22 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Randy Dunlap <rdunlap@infradead.org>
Cc: Teck Choon Giam <giamteckchoon@gmail.com>,
	LKML <linux-kernel@vger.kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>, acme@kernel.org,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@redhat.com>
Subject: Re: kernel-4.9.94 compile error: 'KMOD_DECOMP_LEN' undeclared
Message-ID: <20180428081122.GA27926@kroah.com>
References: <CAEwRVpOFS5UsyVHkHr+w_OR0eSpvT-CZGG6b4Vr6gxkc4rwO6g@mail.gmail.com>
 <84b1d534-9b9d-ff70-ead6-3f8bb70a4d4b@infradead.org>
 <20180428050026.GA29422@kroah.com>
 <5a56f585-d3c1-ee42-20a3-b47921f160c4@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5a56f585-d3c1-ee42-20a3-b47921f160c4@infradead.org>
User-Agent: Mutt/1.9.5 (2018-04-13)
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Fri, Apr 27, 2018 at 11:09:56PM -0700, Randy Dunlap wrote:
> On 04/27/2018 10:00 PM, Greg Kroah-Hartman wrote:
> > On Fri, Apr 27, 2018 at 10:28:27AM -0700, Randy Dunlap wrote:
> >> [adding some Cc:]
> >>
> >> On 04/14/2018 02:41 AM, Teck Choon Giam wrote:
> >>> Hi,
> >>>
> >>> Compile linux-4.9.94 will have error related to KMOD_DECOMP_LEN
> >>> undeclared.  Searching string related to KMOD_DECOMP_LEN in
> >>> linux-4.9.94 and linux-4.15.17 sources as below:
> >>>
> >>> <mock-chroot>sh-4.2# grep -r KMOD_DECOMP_LEN ./linux-4.15.17
> >>> ./linux-4.15.17/tools/perf/tests/code-reading.c: char
> >>> decomp_name[KMOD_DECOMP_LEN];
> >>> ./linux-4.15.17/tools/perf/util/dso.h:#define KMOD_DECOMP_LEN
> >>> sizeof(KMOD_DECOMP_NAME)
> >>> ./linux-4.15.17/tools/perf/util/annotate.c: char tmp[KMOD_DECOMP_LEN];
> >>> ./linux-4.15.17/tools/perf/util/dso.c: char newpath[KMOD_DECOMP_LEN];
> >>> sh-4.2# grep -r KMOD_DECOMP_LEN ./linux-4.9.94
> >>> ./linux-4.9.94/tools/perf/tests/code-reading.c: char
> >>> decomp_name[KMOD_DECOMP_LEN];
> >>> ./linux-4.9.94/tools/perf/util/dso.c: char newpath[KMOD_DECOMP_LEN];
> >>>
> >>> So I guess for linux-4.9.94 has not define KMOD_DECOMP_LEN in
> >>> tools/perf/util/dso.h?
> >>
> >>
> >> 4.9.9[456] lack:
> >> #define KMOD_DECOMP_NAME  "/tmp/perf-kmod-XXXXXX"
> >> #define KMOD_DECOMP_LEN   sizeof(KMOD_DECOMP_NAME)
> >>
> >>
> >> However, the commit that added those macros does not apply cleanly to 4.9.96.
> >>
> >> commit 42b3fa670825983fc8bd0ac7b80cc84ae3abb75b
> >> Author: Namhyung Kim <namhyung@kernel.org>
> >> Date:   Thu Jun 8 16:31:03 2017 +0900
> >>
> >>     perf tools: Introduce dso__decompress_kmodule_{fd,path}
> > 
> > This should now be fixed in the latest 4.9.y -rc release, right?
> > 
> > If not, please let me know as I though I resolved this problem there...
> 
> It still fails in 4.9.96. (not #defined there)

Should be fixed in 4.9.97-r1, I know .96 still had the issue.

thanks,

greg k-h
