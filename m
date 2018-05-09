Return-Path: <alexei.starovoitov@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1525832974; cv=none;
        d=google.com; s=arc-20160816;
        b=CFe0dtbUTiTn26swdomOUjUxVqRFPrybE5H6faKUkIyqMFmkMT57yzClRphuDosSce
         8YHwzSB+vDX0Ep4vx7U2HG1tgSBFpXSAlcBJZVnPblxNOCZtA6hoghaFpX2k1jCo5AEy
         XM0T9Fj6+NhD+krvAEwBxxPDzBedolhnkNxRF9UeChXBgeo0bSrESIHmn4unJ2QQjqhP
         RPgi8PvTNBINowGFs8SnkiZBgWqmaqM08wNkORqF2Du2EI+LUNpT5D71OVh0wEawG2I9
         /bsaAPw94Xa4NQXsgmpRrXs4Zy0uxllNYoRWipX67oySXqEXujf2lQySpkdGjlgkNLrN
         i9OA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:dkim-signature
         :arc-authentication-results;
        bh=gQqJfRb+BYJB9x/7qkeKR1CLKP7s2iq6mhx2Xa4oI3Q=;
        b=o03HgJgmfsDJBXFo7rDLygPt9sCibWpzeVX1xceaQZeniYLwxvwfPGlkSZ4FQeSGCy
         4Qyx0xVOcf5uBWPSYNlw9iDbLCvO0FK8e0S5PVjMS/kdJGfzNW/TG6sqiwN/ayefR+qu
         65t++aUiWx85jBHYjirJJbWJGHxPp+67KIpnoJylHjOovjvWoN1nvG/KfnftkyDCuv0K
         s0Gp7MEsTY/9D4MkTGgjzWcAx5wGU20t1e2NMUg6FntNnysgnIdg0wxd0InHjuV0k16t
         AML+sU3C1o3JnU4Z/N0iHIbo7H+LoIAI8DnthYlzoB2MAwHW+TekevCpcriFybzMXskm
         pwAg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=FCrk2Ua1;
       spf=pass (google.com: domain of alexei.starovoitov@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=alexei.starovoitov@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=FCrk2Ua1;
       spf=pass (google.com: domain of alexei.starovoitov@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=alexei.starovoitov@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
X-Google-Smtp-Source: AB8JxZqZ8xEsqPh6s0++hpZS/FaiaFF8b87CbgF9FNc77g1MMleF2CdDCwgUd14/Po0sn0dUsZVa+Q==
Date: Tue, 8 May 2018 19:29:29 -0700
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: "Luis R. Rodriguez" <mcgrof@kernel.org>
Cc: Alexei Starovoitov <ast@kernel.org>, davem@davemloft.net,
	daniel@iogearbox.net, torvalds@linux-foundation.org,
	gregkh@linuxfoundation.org, luto@amacapital.net,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	kernel-team@fb.com, Juergen Gross <jgross@suse.com>,
	Eric Paris <eparis@redhat.com>,
	Matthew Auld <matthew.auld@intel.com>,
	Josh Triplett <josh@joshtriplett.org>,
	"Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
	Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
	Chris Wilson <chris@chris-wilson.co.uk>,
	Stephen Smalley <sds@tycho.nsa.gov>,
	"Eric W. Biederman" <ebiederm@xmission.com>,
	Mimi Zohar <zohar@linux.vnet.ibm.com>,
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
	Michael Matz <matz@suse.de>, mjg59@google.com,
	linux-security-module <linux-security-module@vger.kernel.org>,
	linux-integrity@vger.kernel.org
Subject: Re: [PATCH v2 net-next 2/4] net: add skeleton of bpfilter kernel
 module
Message-ID: <20180509022928.elyxj6mohm2jud56@ast-mbp>
References: <20180503043604.1604587-1-ast@kernel.org>
 <20180503043604.1604587-3-ast@kernel.org>
 <20180507185124.GA18195@wotan.suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180507185124.GA18195@wotan.suse.de>
User-Agent: NeoMutt/20180223
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1599416225694736469?=
X-GMAIL-MSGID: =?utf-8?q?1599951836946799869?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Mon, May 07, 2018 at 06:51:24PM +0000, Luis R. Rodriguez wrote:
> > Notice that _binary_net_bpfilter_bpfilter_umh_start - end
> > is placed into .init.rodata section, so it's freed as soon as __init
> > function of bpfilter.ko is finished.
> > As part of __init the bpfilter.ko does first request/reply action
> > via two unix pipe provided by fork_usermode_blob() helper to
> > make sure that umh is healthy. If not it will kill it via pid.
> 
> It does this very fast, right away. On a really slow system how are you sure
> that this won't race and the execution of the check happens early on prior to
> letting the actual setup trigger? After all, we're calling the userpsace
> process in async mode. We could preempt it now.

I don't see an issue.
the kernel synchronously writes into a pipe. User space process reads.
Exactly the same as coredump logic with pipes.

> > +# a bit of elf magic to convert bpfilter_umh binary into a binary blob
> > +# inside bpfilter_umh.o elf file referenced by
> > +# _binary_net_bpfilter_bpfilter_umh_start symbol
> > +# which bpfilter_kern.c passes further into umh blob loader at run-time
> > +quiet_cmd_copy_umh = GEN $@
> > +      cmd_copy_umh = echo ':' > $(obj)/.bpfilter_umh.o.cmd; \
> > +      $(OBJCOPY) -I binary -O $(CONFIG_OUTPUT_FORMAT) \
> > +      -B `$(OBJDUMP) -f $<|grep architecture|cut -d, -f1|cut -d' ' -f2` \
> > +      --rename-section .data=.init.rodata $< $@
> 
> Cool, but so our expectation is that the compiler sets this symbol, how
> are we sure it will always be set?

Compiler doesn't set it. objcopy does.

> > +
> > +	if (__bpfilter_process_sockopt(NULL, 0, 0, 0, 0) != 0) {
> 
> See, here, what if the userspace process gets preemtped and we run this
> check afterwards? Is that possible?

User space is a normal task. It can sleep and can be single stepped with GDB.
