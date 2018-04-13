Date: Fri, 13 Apr 2018 22:19:46 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Randy Dunlap <rdunlap@infradead.org>
Cc: Christian Brauner <christian.brauner@ubuntu.com>,
	viro@zeniv.linux.org.uk, tglx@linutronix.de,
	kstewart@linuxfoundation.org, pombredanne@nexb.com,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	serge@hallyn.com
Subject: Re: [PATCH 1/6] fs: use << for MS_* flags
Message-ID: <20180413201946.GA22641@kroah.com>
References: <20180413161126.31313-1-christian.brauner@ubuntu.com>
 <20180413161126.31313-2-christian.brauner@ubuntu.com>
 <f738679f-bc7e-3356-b278-ff881f6f651a@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f738679f-bc7e-3356-b278-ff881f6f651a@infradead.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Fri, Apr 13, 2018 at 09:45:01AM -0700, Randy Dunlap wrote:
> On 04/13/2018 09:11 AM, Christian Brauner wrote:
> > Consistenly use << to define MS_* constants.
> > 
> > Signed-off-by: Christian Brauner <christian.brauner@ubuntu.com>
> > ---
> >  include/uapi/linux/fs.h | 33 +++++++++++++++++----------------
> >  1 file changed, 17 insertions(+), 16 deletions(-)
> > 
> > diff --git a/include/uapi/linux/fs.h b/include/uapi/linux/fs.h
> > index d2a8313fabd7..9662790a657c 100644
> > --- a/include/uapi/linux/fs.h
> > +++ b/include/uapi/linux/fs.h
> > @@ -105,22 +105,23 @@ struct inodes_stat_t {
> >  /*
> >   * These are the fs-independent mount-flags: up to 32 flags are supported
> >   */
> > -#define MS_RDONLY	 1	/* Mount read-only */
> > -#define MS_NOSUID	 2	/* Ignore suid and sgid bits */
> > -#define MS_NODEV	 4	/* Disallow access to device special files */
> > -#define MS_NOEXEC	 8	/* Disallow program execution */
> > -#define MS_SYNCHRONOUS	16	/* Writes are synced at once */
> > -#define MS_REMOUNT	32	/* Alter flags of a mounted FS */
> > -#define MS_MANDLOCK	64	/* Allow mandatory locks on an FS */
> > -#define MS_DIRSYNC	128	/* Directory modifications are synchronous */
> > -#define MS_NOATIME	1024	/* Do not update access times. */
> > -#define MS_NODIRATIME	2048	/* Do not update directory access times */
> > -#define MS_BIND		4096
> > -#define MS_MOVE		8192
> > -#define MS_REC		16384
> > -#define MS_VERBOSE	32768	/* War is peace. Verbosity is silence.
> > -				   MS_VERBOSE is deprecated. */
> > -#define MS_SILENT	32768
> > +#define MS_RDONLY	(1<<0)	/* Mount read-only */
> 
> Why not just use BIT(n) instead?
> 
> #include <linux/bitops.h>
> 
> #define MS_RDONLY	BIT(0)	/* Mount read-only */

BIT() is not exported to uapi files :(
