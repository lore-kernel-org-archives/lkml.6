Return-Path: <lurodriguez@suse.de>
X-Google-Smtp-Source: AB8JxZrX554fn9T9i+mMBm09TvIK9VU5jdlATv3a3HX8twgSgne2UPC0R5hQa6SCjnvqv7wvbhya
ARC-Seal: i=1; a=rsa-sha256; t=1525718374; cv=none;
        d=google.com; s=arc-20160816;
        b=CnB74sVQy2ohEgoSIrvPe7EJ7FQGAUDAsjWVJHjYo2URrPNTyEni49DuTUDFK1EClM
         vOjs3hWF5J0fcX7DSkfVm4IyDaczyLmTNeB4Q1BkqXdheF7Ux+UrTngJQV1jHmKUqPO7
         o8j1c9NbskmGpBzYljexfnaGB8yPQlHsYJDMgHWhHOhqaQfzkXPK1lSJ+NPOftqXyJRz
         Yyh2rBFrJ7nmqa/yzPdZ5YZnm7fzkzw7tRAlyfGdIjDKHEnvnlax1zfBhhy2lHwxGGlJ
         WECVHmikH4t48kdwr+Xp7GuSzcEigFsRpaSMk21WrMjKENThLWchTMQfMXlvLao9+sSt
         6NPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:arc-authentication-results;
        bh=iV37zTyzC4oi7bNBTVl9edSevkAs0UTtYOuXrKvDz54=;
        b=bpQ6bawswa+AiS8ZWI0K79ZS1L2qXHmTk4u2rD2UynWDKdKUhpjJXqC6EBfIH8mTrL
         HePe9hYs36DhIe/o6JB9z0lMG1C0UEJfKabFWnDtHelOvqYp2jieAzr/FuiUtxmHQifg
         OxSCl033mciq4WMk0XK3HXzlnode4YXdtrDa7soVf5ZREvyhBFrT5qDyeSqHuO+7/Jto
         L9y0BL7V66LqAYa0Gr0JC7rCJ91QDLrHC7e4yjRyM9nBXRcMK0ebPfWY1cTAct2S64nz
         AocewYfpou0EeE+3UaWqmbaCoPDEDFWLJ1NGwCRbXYKw/7ivfN9/emQjZBeYA9ZnxpoY
         RAmw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of lurodriguez@suse.de designates 195.135.220.15 as permitted sender) smtp.mailfrom=lurodriguez@suse.de;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=kernel.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of lurodriguez@suse.de designates 195.135.220.15 as permitted sender) smtp.mailfrom=lurodriguez@suse.de;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=kernel.org
Date: Mon, 7 May 2018 18:39:31 +0000
From: "Luis R. Rodriguez" <mcgrof@kernel.org>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>,
	Eric Paris <eparis@redhat.com>,
	Matthew Auld <matthew.auld@intel.com>,
	Josh Triplett <josh@joshtriplett.org>,
	"Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
	Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
	Chris Wilson <chris@chris-wilson.co.uk>,
	Stephen Smalley <sds@tycho.nsa.gov>,
	"Eric W. Biederman" <ebiederm@xmission.com>,
	Mimi Zohar <zohar@linux.vnet.ibm.com>
Cc: "Luis R. Rodriguez" <mcgrof@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>, davem@davemloft.net,
	daniel@iogearbox.net, torvalds@linux-foundation.org,
	gregkh@linuxfoundation.org, luto@amacapital.net,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	kernel-team@fb.com, Al Viro <viro@zeniv.linux.org.uk>,
	David Howells <dhowells@redhat.com>,
	Kees Cook <keescook@chromium.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Dominik Brodowski <linux@dominikbrodowski.net>,
	Hugh Dickins <hughd@google.com>, Jann Horn <jannh@google.com>,
	Jani Nikula <jani.nikula@linux.intel.com>,
	Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
	Rodrigo Vivi <rodrigo.vivi@intel.com>,
	David Airlie <airlied@linux.ie>,
	"Rafael J. Wysocki" <rjw@rjwysocki.net>,
	Linux FS Devel <linux-fsdevel@vger.kernel.org>, pjones@redhat.com,
	mjg59@google.com,
	linux-security-module <linux-security-module@vger.kernel.org>,
	linux-integrity@vger.kernel.org
Subject: Re: [PATCH v2 net-next 1/4] umh: introduce fork_usermode_blob()
 helper
Message-ID: <20180507183931.GV27853@wotan.suse.de>
References: <20180503043604.1604587-1-ast@kernel.org>
 <20180503043604.1604587-2-ast@kernel.org>
 <20180504195642.GB12838@wotan.suse.de>
 <20180505013710.2fb2k6e5uotd22kr@ast-mbp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180505013710.2fb2k6e5uotd22kr@ast-mbp>
User-Agent: Mutt/1.6.0 (2016-04-01)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1599416216881891368?=
X-GMAIL-MSGID: =?utf-8?q?1599831670647891546?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Fri, May 04, 2018 at 06:37:11PM -0700, Alexei Starovoitov wrote:
> On Fri, May 04, 2018 at 07:56:43PM +0000, Luis R. Rodriguez wrote:
> > What a mighty short list of reviewers. Adding some more. My review below.
> > I'd appreciate a Cc on future versions of these patches.
> 
> sure.
> 
> > On Wed, May 02, 2018 at 09:36:01PM -0700, Alexei Starovoitov wrote:
> > > Introduce helper:
> > > int fork_usermode_blob(void *data, size_t len, struct umh_info *info);
> > > struct umh_info {
> > >        struct file *pipe_to_umh;
> > >        struct file *pipe_from_umh;
> > >        pid_t pid;
> > > };
> > > 
> > > that GPLed kernel modules (signed or unsigned) can use it to execute part
> > > of its own data as swappable user mode process.
> > > 
> > > The kernel will do:
> > > - mount "tmpfs"
> > 
> > Actually its a *shared* vfsmount tmpfs for all umh blobs.
> 
> yep

OK just note CONFIG_TMPFS can be disabled, and likewise for CONFIG_SHMEM,
in which case tmpfs and shmem are replaced by a simple ramfs code, more
appropriate for systems without swap.

> > > +static struct vfsmount *umh_fs;
> > > +
> > > +static int init_tmpfs(void)
> > 
> > Please use umh_init_tmpfs(). 
> 
> ok
> 
> > Also see init/main.c do_basic_setup() which calls
> > usermodehelper_enable() prior to do_initcalls(). Now, fortunately TMPFS is only
> > bool, saving us from some races and we do call tmpfs's init first shmem_init():
> > 
> > static void __init do_basic_setup(void)
> > {
> > 	cpuset_init_smp();
> > 	shmem_init();
> > 	driver_init();
> > 	init_irq_proc();
> > 	do_ctors();
> > 	usermodehelper_enable();
> > 	do_initcalls();
> > }
> > 
> > But it also means we're enabling your new call call fork_usermode_blob() on
> > early init code even if we're not setup. Since this umh tmpfs vfsmount is
> > shared I'd say just call this init right before usermodehelper_enable()
> > on do_basic_setup().
> 
> Not following.
> Why init_tmpfs() should be called by __init function?

Nope, not at all, I was suggesting:

diff --git a/init/main.c b/init/main.c
index 0697284a28ee..67a48fbd96ca 100644
--- a/init/main.c
+++ b/init/main.c
@@ -973,6 +973,7 @@ static void __init do_basic_setup(void)
 	driver_init();
 	init_irq_proc();
 	do_ctors();
+	umh_init_tmpfs();
 	usermodehelper_enable();
 	do_initcalls();
 }

Mainly to avoid the locking situation Jann Horn noted, and also provide
proper kernel ordering expectations.

> Are you saying make 'static struct vfsmount *shm_mnt;'
> global and use it here? so no init_tmpfs() necessary?
> I think that can work, but feels that having two
> tmpfs mounts (one for shmem and one for umh) is cleaner.

No, but now that you mention it... if a shared vfsmount is not used the
/sys/kernel/mm/transparent_hugepage/shmem_enabled knob for using huge pages
would not be followed for umh modules. For the i915 driver this was *why*
they ended up adding shmem_file_setup_with_mnt(), they wanted huge pages to
support huge-gtt-pages. What is the rationale behind umh.c using it for
umh modules?

Users of shmem_kernel_file_setup() spawned later out of the desire to
*avoid* LSMs since it didn't make sense in their case as their inodes
are never exposed to userspace. Such is the case for ipc/shm.c and
security/keys/big_key.c. Refer to commit c7277090927a5 ("security: shmem:
implement kernel private shmem inodes") and then commit e1832f2923ec9
("ipc: use private shmem or hugetlbfs inodes for shm segments").

In this new umh usermode modules case we are:

  a) actually mapping data already extracted by the kernel somehow from
     a file somehow, presumably from /lib/modules/ path somewhere, but
     again this is not visible to umc.c, as it just gets called with:

	fork_usermode_blob(void *data, size_t len, struct umh_info *info)

  b) Creating the respective tmpfs file with shmem_file_setup_with_mnt()
     with our on our own shared struct vfsmount *umh_fs.

  c) Populating the file created and stuffing it with our data passed

  d) Calling do_execve_file() on it.

Its not clear to me why you used shmem_file_setup_with_mnt() in this case. What
are the gains? It would make sense to use shmem_kernel_file_setup() to avoid an
LSM check on step b) *but* only if we already had a proper LSM check on step
a).

I checked how you use fork_usermode_blob() in a) and in this case the kernel
module bpfilter would be loaded first, and for that we already have an LSM
check / hook for that module. From my review then, the magic done on your
second patch to stuff the userspace application into the module should be
irrelevant to us from an LSM perspective.

So, I can see a reason to use shmem_kernel_file_setup() but not I cannot
see a reason to be using      shmem_file_setup_with_mnt() at the moment.

I Cc'd tmpfs and LSM folks for further feedback.

> > > +{
> > > +	size_t offset = 0;
> > > +	int err;
> > > +
> > > +	do {
> > > +		unsigned int len = min_t(typeof(size), size, PAGE_SIZE);
> > > +		struct page *page;
> > > +		void *pgdata, *vaddr;
> > > +
> > > +		err = pagecache_write_begin(file, file->f_mapping, offset, len,
> > > +					    0, &page, &pgdata);
> > > +		if (err < 0)
> > > +			goto fail;
> > > +
> > > +		vaddr = kmap(page);
> > > +		memcpy(vaddr, data, len);
> > > +		kunmap(page);
> > > +
> > > +		err = pagecache_write_end(file, file->f_mapping, offset, len,
> > > +					  len, page, pgdata);
> > > +		if (err < 0)
> > > +			goto fail;
> > > +
> > > +		size -= len;
> > > +		data += len;
> > > +		offset += len;
> > > +	} while (size);
> > 
> > Character for character, this looks like a wonderful copy and paste from
> > i915_gem_object_create_from_data()'s own loop which does the same exact
> > thing. Perhaps its time for a helper on mm/filemap.c with an export so
> > if a bug is fixed in one place its fixed in both places.
> 
> yes, of course, but not right now.
> Once it all lands that will be the time to create common helper.
> It's not a good idea to mess with i915 in one patch set.

Either way works with me, so long as its done.

> > > +int fork_usermode_blob(void *data, size_t len, struct umh_info *info)
> > 
> > Please use umh_fork_blob()
> 
> sorry, no. fork_usermode_blob() is much more descriptive name.

Prefixing new umh.c symbols with umh_*() makes it very clear this came from
kernel/umh.c functionality. I've been dealing with other places in the kernel
that have conflated their own use of kernel/umh.c functionality what they
expose in both code and documentation, and correcting this has taken a long
time. Best avoid future confusion and be consistent with new exported symbols
for umc.c functionality.

Also, descriptive as fork_usermode_blob() may seem there is a possible future
clash with a more generic call.

> > Also, can you extend lib/test_kmod.c with a test case for this with its own
> > demo and try to blow it up?
> 
> in what sense? bpfilter is the test and the driving component for it.

That's the thing, it shouldn't be.

We are adding *new* functionality here, I don't want to require enabling
bpfitler or its dependencies to test generic umh user module loading
functionality.  For instance, we have lib/test_module.c to help test generic
module loading, regardless of the functionality or requirements for other
modules.

> I'm expecting that folks who want to use this helper to do usb drivers
> in user space may want to extend this helper further, but that's their job.

I don't even want to test USB, I am just interesting in the *very* *very*
basic aspects of it. A simple lib/test_umh_module.c would do with a respective
check that its loaded, given this is a requirement from the API. It also helps
folks understand the core basic knobs without having to look at bfilter code.

If we're going to get this merged I'd be interested in doing ongoing testing
with 0day with  simple UMH module with and without CONFIG_SHMEM for instance
and check that it works in both cases.

Testing this may seem irrelevant to you but keep in mind we're also already
testing just general kernel module loading. As silly as it may seem, adding new
functionality and a respective test case lets us try to avoid regressions, and
provide small unit tests to help reproduce issues and corner case situations
you may not be considering.

  Luis
