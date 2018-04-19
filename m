Date: Thu, 19 Apr 2018 10:17:35 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: DaeRyong Jeong <threeearcat@gmail.com>
Cc: Byoungyoung Lee <byoungyoung@purdue.edu>,
	Kyungtae Kim <kt0755@gmail.com>,
	LKML <linux-kernel@vger.kernel.org>
Subject: Re: KASAN: slab-out-of-bounds Write in
 tty_insert_flip_string_fixed_flag
Message-ID: <20180419081735.GA28287@kroah.com>
References: <CACsK=jfSRSLYvPJKzFrRQgNa10DsF8xLLKGYfqqE_hF9ucX-yw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACsK=jfSRSLYvPJKzFrRQgNa10DsF8xLLKGYfqqE_hF9ucX-yw@mail.gmail.com>
User-Agent: Mutt/1.9.5 (2018-04-13)
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Thu, Apr 19, 2018 at 05:09:16PM +0900, DaeRyong Jeong wrote:
> We report the crash:
> KASAN: slab-out-of-bounds Write in tty_insert_flip_string_fixed_flag
> 
> This crash has been found in v4.16 using RaceFuzzer (a modified
> version of Syzkaller), which we describe more at the end of this
> report. Our analysis shows that the race occurs when invoking two
> syscalls concurrently, ioctl$TCXONC(r0, 0x540a, 0x2) and
> ioctl$TCXONC(r0, 0x540a, 0x1).

Nice!

Do you have a kernel patch to resolve this issue?

thanks,

greg k-h
