Return-Path: <jpoimboe@redhat.com>
X-Google-Smtp-Source: AB8JxZppZ0nTh281gp0k2nSBOGUvL3BKrEZ5LR2koaBUc1Yk+esHsAdlDAsQaM0YCgFfACorNkdy
ARC-Seal: i=1; a=rsa-sha256; t=1525789964; cv=none;
        d=google.com; s=arc-20160816;
        b=P+5FsfURPWBd6IIdTnOd7hlgu8+EkzPLhOsb8p4lth4/BE9SQvw7N7Z2RzVx5DNFd2
         rKndiGsJ/QgX/98KkPLobx6YrAkyFJ9rhcz9WRtIP39QgkuxEq9R7TxHf44ZqLZA5T/W
         cmnVJM7lhMo3Oey838a/2G7SrBwXt9rGyqH6HogEZ0kZUIKPtvAW0eNweAPjeS/kYUhY
         DMC4xDAY1uHDXqoxggblYH9H+EPlalb9Sgke4Rj3U8MduxTpNwaGwnhxSFQ3i5JQmCnL
         2ORbG7uwQnmvUbuEr/uuzRzAnuObTcfKdnUmUAV9s3NbcIfVZRFWqphv/1idbUXWR97K
         w5zw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:arc-authentication-results;
        bh=U+CM46/Ow6t31F3ir6ECYPkVUlmtfk9m0lqEK2qoDII=;
        b=wVTD9Y8ESzK0l1/KC3Fiq7ZJQM3/EekvaduwqI1O/qJcRbyiAvGLvaYa+5D7CT55Om
         akWNtMF+ttUoJY3ICWPJNvf7cydQCIE0W/cno3N+x9PhSrP/9TJt0xSs/Utrg5DNcwPX
         VucOPA31TtYcc2gtUC1RzEQrY4mLQdB1UANnamS/Y2mjvYhp4ZzBiaWlVFmcxrcj6sis
         5Zw9WJCpQCTh8qT7LQaZsgOXApD5yWr4pJgnLKRNX7grR9i0+5Cfdpd+fT6iJpb4Rho+
         bvM+DONcex3+qUbE3cpxc4B1E9Dc5tW3RF7AQWlg389XAYxZYhpoWmrn4szxZUnppq7E
         ztUw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of jpoimboe@redhat.com designates 66.187.233.73 as permitted sender) smtp.mailfrom=jpoimboe@redhat.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=redhat.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of jpoimboe@redhat.com designates 66.187.233.73 as permitted sender) smtp.mailfrom=jpoimboe@redhat.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=redhat.com
Date: Tue, 8 May 2018 09:32:41 -0500
From: Josh Poimboeuf <jpoimboe@redhat.com>
To: Greg KH <gregkh@linuxfoundation.org>
Cc: damian <damian.tometzki@icloud.com>, peterz@infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: Kernel build with gcc 8 a lot of warnings
Message-ID: <20180508143241.5kz4poxcdhajjorl@treble>
References: <20180505192112.GA18728@zrhn9910b>
 <20180507045453.leou4zypnlcck4vr@treble>
 <20180508055126.GA18724@kroah.com>
 <20180508133226.uwjbx44fwlxgyzu5@treble>
 <20180508142515.GA16111@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180508142515.GA16111@kroah.com>
User-Agent: NeoMutt/20180323
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcSW1wb3J0YW50Ig==?=
X-GMAIL-THRID: =?utf-8?q?1599903094060891144?=
X-GMAIL-MSGID: =?utf-8?q?1599906737569140237?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, May 08, 2018 at 04:25:15PM +0200, Greg KH wrote:
> On Tue, May 08, 2018 at 08:34:47AM -0500, Josh Poimboeuf wrote:
> > On Tue, May 08, 2018 at 07:51:26AM +0200, Greg KH wrote:
> > > On Sun, May 06, 2018 at 11:54:53PM -0500, Josh Poimboeuf wrote:
> > > > On Sat, May 05, 2018 at 09:21:12PM +0200, damian wrote:
> > > > > Helllo together,
> > > > > 
> > > > > Hello everybody,
> > > > > 
> > > > > is something special to note when kernel build with gcc 8? I receive various warnings from the objtool:
> > > > > With GCC 7 works all fine.
> > > > > 
> > > > > kernel/cgroup/cgroup.o: warning: objtool: parse_cgroup_root_flags()+0x40: sibling call from callable instruction with modified stack frame
> > > > > kernel/cgroup/cgroup.o: warning: objtool: cgroup_addrm_files()+0x2a3: sibling call from callable instruction with modified stack frame
> > > > > kernel/cgroup/cgroup.o: warning: objtool: cgroup_apply_control_enable()+0x20b: sibling call from callable instruction with modified stack frame
> > > > > kernel/cgroup/cgroup.o: warning: objtool: rebind_subsystems()+0x296: sibling call from callable instruction with modified stack frame
> > > > > kernel/cgroup/cgroup.o: warning: objtool: cgroup_sk_alloc_disable()+0x10: sibling call from callable instruction with modified stack frame
> > > > > kernel/cgroup/cgroup.o: warning: objtool: parse_cgroup_root_flags.cold.45()+0xa: call without frame pointer save/setup
> > > > > kernel/cgroup/cgroup.o: warning: objtool: cgroup_addrm_files.cold.46()+0x17: call without frame pointer save/setup
> > > > > kernel/cgroup/cgroup.o: warning: objtool: cgroup_apply_control_enable.cold.47()+0x24: call without frame pointer save/setup
> > > > > kernel/cgroup/cgroup.o: warning: objtool: rebind_subsystems.cold.48()+0x10: call without frame pointer save/setup
> > > > > kernel/cgroup/cgroup.o: warning: objtool: cgroup_sk_alloc_disable.cold.49()+0x7: call without frame pointer save/setup
> > > > >   CC      kernel/cgroup/stat.o
> > > > >   CC [M]  arch/x86/kvm/../../../virt/kvm/kvm_main.o
> > > > > arch/x86/kernel/acpi/boot.o: warning: objtool: acpi_register_lapic()+0x10: sibling call from callable instruction with modified stack frame
> > > > > arch/x86/kernel/acpi/boot.o: warning: objtool: acpi_map_cpu()+0x2c: sibling call from callable instruction with modified stack frame
> > > > > arch/x86/kernel/acpi/boot.o: warning: objtool: acpi_register_lapic.cold.6()+0x7: call without frame pointer save/setup
> > > > > arch/x86/kernel/acpi/boot.o: warning: objtool: acpi_map_cpu.cold.7()+0x7: call without frame pointer save/setup
> > > > 
> > > > Thanks, this is a known issue with GCC 8 that I haven't gotten a chance
> > > > to fix yet.  They're related to the fact that GCC 8 is splitting out
> > > > 'unlikely' code into 'cold' subfunctions in .text.unlikely.
> > > > 
> > > > I've got some old patches that fix it.  Now that GCC 8 is out, I'll need
> > > > get the patches dusted off and cleaned up for merging.
> > > 
> > > Any pointers to these patches?  Archi linux just changed their default
> > > compiler to gcc 8 and now I'm seeing this in my local builds :(
> > 
> > I'm still dusting the code off, but this fixes most of the warnings.
> > The rest of the code should hopefully be ready soon.
> > 
> > From: Josh Poimboeuf <jpoimboe@redhat.com>
> > Subject: [PATCH] objtool: Detect GCC 8 cold subfunctions
> > 
> > GCC 8 moves a lot of unlikely code out of line to "cold" subfunctions in
> > .text.unlikely.  Properly detect the new subfunctions and treat them as
> > extensions of the original functions.
> > 
> > This fixes a bunch of warnings like:
> > 
> >   kernel/cgroup/cgroup.o: warning: objtool: parse_cgroup_root_flags()+0x33: sibling call from callable instruction with modified stack frame
> >   kernel/cgroup/cgroup.o: warning: objtool: cgroup_addrm_files()+0x290: sibling call from callable instruction with modified stack frame
> >   kernel/cgroup/cgroup.o: warning: objtool: cgroup_apply_control_enable()+0x25b: sibling call from callable instruction with modified stack frame
> >   kernel/cgroup/cgroup.o: warning: objtool: rebind_subsystems()+0x325: sibling call from callable instruction with modified stack frame
> > 
> > Reported-by: Arnd Bergmann <arnd@arndb.de>
> > Signed-off-by: Josh Poimboeuf <jpoimboe@redhat.com>
> > ---
> >  tools/objtool/check.c | 7 ++++---
> >  tools/objtool/elf.c   | 3 +++
> >  tools/objtool/elf.h   | 1 +
> >  3 files changed, 8 insertions(+), 3 deletions(-)
> 
> <snip>
> 
> Much nicer, thanks for the patch, seems to build things "quieter" now.
> For the other warnings, they are "safe" to ignore, right?  It's just
> objtool checking to see if all is ok, but the result should be fine no
> matter what, right?

Yeah, from what I can tell, there's nothing catastrophic in the rest of
the warnings.  Worst case, the ORC unwinder might get confused in a few
places.

-- 
Josh
