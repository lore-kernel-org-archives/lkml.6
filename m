Return-Path: <alexei.starovoitov@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1525832733; cv=none;
        d=google.com; s=arc-20160816;
        b=VnTlghhM+6jn1VGYShV27Z/yP8M4LI+sd0Cm9iJksMRIgoxhfl4IRmilmPuW/nh5pU
         yhAapxQKXySg/64ld/ilsOEDHrFqylRHrQrVOw8H0ZLODWXw+QV3FBt8+vgIagwHyBJ1
         ghal9bpZKSq31Mzq84fIapMah5GowH7dDozNRSfzq2la5EDyZZT2Gs4Rg6Rqf2wypAkw
         wx/sGCq2miUHNGYxdIclKpekIXWP7Rh715dIaN5XMaOfcC7p1RvsSxUZ1z16N+ijtu6x
         Lqrbo/cDrYRExLcdwwx53lTb2y/1Si74NlTjbKBumV1jrdjiQ55ZxYcSbPI0gzWoDC0n
         Aw0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:dkim-signature
         :arc-authentication-results;
        bh=ig51Vxl5gNbPaacdhxrwaNpBfMHnt0WKLu5JF2ZEGfE=;
        b=IQqV4nEA3ngSkrI1EYBdL3yAo4Vkqf7WG98Iz2ZOI9ggMj2zp5LodIcKAR8Esg0yYO
         KoBrNKlj+DbJ4cVk/h1k2v9Hn+GGKlWjE+BFkh2DFv/C30cVj/5DFRShup5zRPLvUFAn
         F4WAXOA413vFzlG0RBoH3TLN1Y3uBkqe/nx+kuD/Fm09qJekbe8mjsvDnxAm/dkedgW9
         GNsHVMBBIJB5GQ1mYuevjMB+Iq1M6fnaD6xBKmbnsSJP7lecAfuiQY4knUwN0VuVYmxS
         jM8DhDEfXgX+i+bBO0PqLmsIDGo9R3J/+iqriN8mNpWFgIgHtgRLFmU/Pwl17in3Lnke
         GEAA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=he4SnP4U;
       spf=pass (google.com: domain of alexei.starovoitov@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=alexei.starovoitov@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=he4SnP4U;
       spf=pass (google.com: domain of alexei.starovoitov@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=alexei.starovoitov@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
X-Google-Smtp-Source: AB8JxZpZWHQFkKEWvrMUGZ3JIyz/9Q79M8j/SlfhuJnwq6fFhV2nhYzmQAhZQQqcojorPE3/zHsNNg==
Date: Tue, 8 May 2018 19:25:28 -0700
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: "Luis R. Rodriguez" <mcgrof@kernel.org>
Cc: Eric Paris <eparis@redhat.com>, Matthew Auld <matthew.auld@intel.com>,
	Josh Triplett <josh@joshtriplett.org>,
	"Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
	Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
	Chris Wilson <chris@chris-wilson.co.uk>,
	Stephen Smalley <sds@tycho.nsa.gov>,
	"Eric W. Biederman" <ebiederm@xmission.com>,
	Mimi Zohar <zohar@linux.vnet.ibm.com>,
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
	Rodrigo Vivi <rodrigo.vivi@intel.com>,
	David Airlie <airlied@linux.ie>,
	"Rafael J. Wysocki" <rjw@rjwysocki.net>,
	Linux FS Devel <linux-fsdevel@vger.kernel.org>, pjones@redhat.com,
	mjg59@google.com,
	linux-security-module <linux-security-module@vger.kernel.org>,
	linux-integrity@vger.kernel.org
Subject: Re: [PATCH v2 net-next 1/4] umh: introduce fork_usermode_blob()
 helper
Message-ID: <20180509022526.hertzfpvy7apz6ny@ast-mbp>
References: <20180503043604.1604587-1-ast@kernel.org>
 <20180503043604.1604587-2-ast@kernel.org>
 <20180504195642.GB12838@wotan.suse.de>
 <20180505013710.2fb2k6e5uotd22kr@ast-mbp>
 <20180507183931.GV27853@wotan.suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180507183931.GV27853@wotan.suse.de>
User-Agent: NeoMutt/20180223
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1599416216881891368?=
X-GMAIL-MSGID: =?utf-8?q?1599951583654698494?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Mon, May 07, 2018 at 06:39:31PM +0000, Luis R. Rodriguez wrote:
> 
> > Are you saying make 'static struct vfsmount *shm_mnt;'
> > global and use it here? so no init_tmpfs() necessary?
> > I think that can work, but feels that having two
> > tmpfs mounts (one for shmem and one for umh) is cleaner.
> 
> No, but now that you mention it... if a shared vfsmount is not used the
> /sys/kernel/mm/transparent_hugepage/shmem_enabled knob for using huge pages
> would not be followed for umh modules. For the i915 driver this was *why*
> they ended up adding shmem_file_setup_with_mnt(), they wanted huge pages to
> support huge-gtt-pages. What is the rationale behind umh.c using it for
> umh modules?
> 
> Users of shmem_kernel_file_setup() spawned later out of the desire to
> *avoid* LSMs since it didn't make sense in their case as their inodes
> are never exposed to userspace. Such is the case for ipc/shm.c and
> security/keys/big_key.c. Refer to commit c7277090927a5 ("security: shmem:
> implement kernel private shmem inodes") and then commit e1832f2923ec9
> ("ipc: use private shmem or hugetlbfs inodes for shm segments").
> 
> In this new umh usermode modules case we are:
> 
>   a) actually mapping data already extracted by the kernel somehow from
>      a file somehow, presumably from /lib/modules/ path somewhere, but
>      again this is not visible to umc.c, as it just gets called with:
> 
> 	fork_usermode_blob(void *data, size_t len, struct umh_info *info)
> 
>   b) Creating the respective tmpfs file with shmem_file_setup_with_mnt()
>      with our on our own shared struct vfsmount *umh_fs.
> 
>   c) Populating the file created and stuffing it with our data passed
> 
>   d) Calling do_execve_file() on it.
> 
> Its not clear to me why you used shmem_file_setup_with_mnt() in this case. What
> are the gains? It would make sense to use shmem_kernel_file_setup() to avoid an
> LSM check on step b) *but* only if we already had a proper LSM check on step
> a).
> 
> I checked how you use fork_usermode_blob() in a) and in this case the kernel
> module bpfilter would be loaded first, and for that we already have an LSM
> check / hook for that module. From my review then, the magic done on your
> second patch to stuff the userspace application into the module should be
> irrelevant to us from an LSM perspective.
> 
> So, I can see a reason to use shmem_kernel_file_setup() but not I cannot
> see a reason to be using      shmem_file_setup_with_mnt() at the moment.

That's a good idea. I will switch to using shmem_kernel_file_setup().
I guess I can use kernel_write() as well instead of populate_file().
I wonder why i915 had to use pagecache_write_begin() and the loop
instead of kernel_write()...
The only reason to copy into tmpfs file is to make that memory swappable.
All standard shmem knobs should apply.

> > > > +{
> > > > +	size_t offset = 0;
> > > > +	int err;
> > > > +
> > > > +	do {
> > > > +		unsigned int len = min_t(typeof(size), size, PAGE_SIZE);
> > > > +		struct page *page;
> > > > +		void *pgdata, *vaddr;
> > > > +
> > > > +		err = pagecache_write_begin(file, file->f_mapping, offset, len,
> > > > +					    0, &page, &pgdata);
> > > > +		if (err < 0)
> > > > +			goto fail;
> > > > +
> > > > +		vaddr = kmap(page);
> > > > +		memcpy(vaddr, data, len);
> > > > +		kunmap(page);
> > > > +
> > > > +		err = pagecache_write_end(file, file->f_mapping, offset, len,
> > > > +					  len, page, pgdata);
> > > > +		if (err < 0)
> > > > +			goto fail;
> > > > +
> > > > +		size -= len;
> > > > +		data += len;
> > > > +		offset += len;
> > > > +	} while (size);
> > > 
> > > Character for character, this looks like a wonderful copy and paste from
> > > i915_gem_object_create_from_data()'s own loop which does the same exact
> > > thing. Perhaps its time for a helper on mm/filemap.c with an export so
> > > if a bug is fixed in one place its fixed in both places.
> > 
> > yes, of course, but not right now.
> > Once it all lands that will be the time to create common helper.
> > It's not a good idea to mess with i915 in one patch set.
> 
> Either way works with me, so long as its done.

Will be gone due to switch to kernel_write().

> 
> > > > +int fork_usermode_blob(void *data, size_t len, struct umh_info *info)
> > > 
> > > Please use umh_fork_blob()
> > 
> > sorry, no. fork_usermode_blob() is much more descriptive name.
> 
> Prefixing new umh.c symbols with umh_*() makes it very clear this came from
> kernel/umh.c functionality. I've been dealing with other places in the kernel
> that have conflated their own use of kernel/umh.c functionality what they
> expose in both code and documentation, and correcting this has taken a long
> time. Best avoid future confusion and be consistent with new exported symbols
> for umc.c functionality.

There is no confusion today. The most known umh api is a family of
call_usermodehelper*()
In this case it's not a 'call', it's a 'fork', since part of kernel module
being forked as user mode process.
I considered naming this function fork_usermodehelper(),
but it's also not quite correct, since 'user mode helper' has predefined
meaning of something that has the path whereas here it's a blob of bytes.
Hence fork_usermode_blob() is more accurate and semantically correct name,
whereas umh_fork_blob() is not.

Notice I no longer call these new kernel modules as 'umh modules',
since that's the wrong name for the same reasons.
They are good ol' kernel modules.
The new functionality allowed by this patch is:
forking part of kernel module data as user mode process.
A lot of umh logic is reused, but 'user mode helpers' and
'user mode blobs' are distinct kernel features.

> I don't even want to test USB, I am just interesting in the *very* *very*
> basic aspects of it. A simple lib/test_umh_module.c would do with a respective
> check that its loaded, given this is a requirement from the API. It also helps
> folks understand the core basic knobs without having to look at bfilter code.

I agree that lib/test_usermode_blob.c must be available eventually.
Right now we cannot add it to the tree, since we need to figure how interface
between kernel and usermode_blob will work based on real world use case
of bpfilter. Once it gets further along that would be the time to say:
"look, here is the test for fork_usermode_blob() and here how others (usb drivers)
can and should use it".
Today is not the right time to fix the api. Such lib/test_usermode_blob.c
would have to be constantly adjusted as we tweak bpfilter side becoming
unnecessary burden of us bpfilter developers.
Everyone really need to think of these patches as work in progress
and internal details and api of fork_usermode_blob() will change.
