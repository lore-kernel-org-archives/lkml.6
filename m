Date: Mon, 14 May 2018 11:26:56 +0200
From: Greg KH <greg@kroah.com>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: Linux-Next Mailing List <linux-next@vger.kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Abdun Nihaal <abdun.nihaal@gmail.com>
Subject: Re: linux-next: build warnings after merge of the staging tree
Message-ID: <20180514092656.GB11384@kroah.com>
References: <20180514143404.28f0f4da@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180514143404.28f0f4da@canb.auug.org.au>
User-Agent: Mutt/1.9.5 (2018-04-13)
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Mon, May 14, 2018 at 02:34:04PM +1000, Stephen Rothwell wrote:
> Hi Greg,
> 
> After merging the staging tree, today's linux-next build (x86_64
> allmodconfig) produced this warning:
> 
> drivers/staging/most/video/video.c: In function 'vidioc_enum_fmt_vid_cap':
> drivers/staging/most/video/video.c:265:25: warning: unused variable 'mdev' [-Wunused-variable]
>   struct most_video_dev *mdev = fh->mdev;
>                          ^~~~
> drivers/staging/most/video/video.c: In function 'vidioc_g_fmt_vid_cap':
> drivers/staging/most/video/video.c:282:25: warning: unused variable 'mdev' [-Wunused-variable]
>   struct most_video_dev *mdev = fh->mdev;
>                          ^~~~
> drivers/staging/most/video/video.c: In function 'vidioc_g_std':
> drivers/staging/most/video/video.c:309:25: warning: unused variable 'mdev' [-Wunused-variable]
>   struct most_video_dev *mdev = fh->mdev;
>                          ^~~~
> 
> Introduced by commit
> 
>   7d7cdb4fa552 ("staging: most: video: remove debugging code")

Sorry about this.  This warning, and the other one in the staging tree,
were not noticed by me due to my system updating to gcc-8 and the huge
numbers of warnings it produced.  Then 0-day went on a bender and didn't
spit out anything for a few days...

I'll go fix this up now, thanks for the report.

greg k-h
