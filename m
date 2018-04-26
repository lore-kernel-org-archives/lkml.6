Date: Thu, 26 Apr 2018 09:02:46 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: LKML <linux-kernel@vger.kernel.org>,
	Philippe Ombredanne <pombredanne@nexb.com>,
	Kate Stewart <kstewart@linuxfoundation.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Hans Verkuil <hans.verkuil@cisco.com>,
	Mauro Carvalho Chehab <mchehab@s-opensource.com>,
	Christoph Hellwig <hch@lst.de>
Subject: Re: [patch V2 7/7] scripts: Add SPDX checker script
Message-ID: <20180426070246.GL14025@kroah.com>
References: <20180425203020.594959448@linutronix.de>
 <20180425203703.650160358@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180425203703.650160358@linutronix.de>
User-Agent: Mutt/1.9.5 (2018-04-13)
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, Apr 25, 2018 at 10:30:27PM +0200, Thomas Gleixner wrote:
> The SPDX-License-Identifiers are growing in the kernel and so grow
> expression failures and license IDs are used which have no corresponding
> license text file in the LICENSES directory.
> 
> Add a script which gathers information from the LICENSES directory,
> i.e. the various tags in the licenses and exception files and then scans
> either input from stdin, which it treats as a single file or if started
> without arguments it scans the full kernel tree.
> 
> It checks whether the license expression syntax is correct and also
> validates whether the license identifiers used in the expressions are
> available in the LICENSES files.
> 
> # scripts/spdxcheck.py -h
> usage: spdxcheck.py [-h] [-m MAXLINES] [-s] [-v]
> 
> SPDX expression checker
> 
> optional arguments:
>   -h, --help            show this help message and exit
>   -m MAXLINES, --maxlines MAXLINES
>                         Maximum number of lines to scan in a file. Default 15
>   -s, --stdin           Read from stdin. If not set scan full git tree.
>   -v, --verbose         Verbose statistics output
> 
> 
> # scripts/spdxcheck.py -s <COPYING
> 
> # scripts/spdxcheck.py -s <include/dt-bindings/reset/amlogic,meson-axg-reset.h
> include/dt-bindings/reset/amlogic,meson-axg-reset.h: 9:41 Invalid License ID: BSD
> 
> # scripts/spdxcheck.py
> arch/arm/mach-s3c24xx/h1940-bluetooth.c: 1:28 Invalid License ID: GPL-1.0
> arch/x86/kernel/jailhouse.c: 1:28 Invalid License ID: GPL2.0
> drivers/pinctrl/sh-pfc/pfc-r8a77965.c: 1:28 Invalid License ID: GPL-2.
> include/dt-bindings/reset/amlogic,meson-axg-reset.h: 9:41 Invalid License ID: BSD
> arch/x86/include/asm/jailhouse_para.h: 1:28 Invalid License ID: GPL2.0
> 
> # time scripts/spdxcheck.py -v
> arch/arm/mach-s3c24xx/h1940-bluetooth.c: 1:28 Invalid License ID: GPL-1.0
> arch/x86/kernel/jailhouse.c: 1:28 Invalid License ID: GPL2.0
> drivers/pinctrl/sh-pfc/pfc-r8a77965.c: 1:28 Invalid License ID: GPL-2.
> include/dt-bindings/reset/amlogic,meson-axg-reset.h: 9:41 Invalid License ID: BSD
> arch/x86/include/asm/jailhouse_para.h: 1:28 Invalid License ID: GPL2.0
> 
> License files:               14
> Exception files:              1
> License IDs                  19
> Exception IDs                 1
> 
> Files checked:            61332
> Lines checked:           669181
> Files with SPDX:          16169
> Files with errors:            5
> 
> real	0m2.642s
> user	0m2.231s
> sys	0m0.467s
> 
> That's a full tree sweep on my laptop. Note, this runs single threaded.
> 
> It scans by default the first 15 lines for a SPDX identifier where the
> current max inside a top comment is at line 10. But that's going to be
> faster once the identifiers are all in the first two lines as documented.
> 
> The python wizards will surely know how to do that smarter and faster, but
> its at least better than no tool at all.
> 
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>

Very nice, thanks for writing this.

Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
