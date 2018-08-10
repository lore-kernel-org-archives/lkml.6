Return-Path: <SRS0=aVpA=KZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C250CC46464
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Aug 2018 23:55:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 62A6C223C7
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Aug 2018 23:55:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=thunk.org header.i=@thunk.org header.b="DUc0CABf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 62A6C223C7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mit.edu
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727229AbeHKC11 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Aug 2018 22:27:27 -0400
Received: from imap.thunk.org ([74.207.234.97]:32946 "EHLO imap.thunk.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726747AbeHKC11 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Aug 2018 22:27:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=thunk.org;
         s=ef5046eb; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=vZlSeZFflTSzguhVUHJRZPvf4xFZPzVEyKyltvJUbDQ=; b=DUc0CABf8M3gFmRcb72ptNhodT
        zWr2duq5R0juV8u8FFnyUzNAajKttShvboElxWwbfY3UE0dLYwuP4b6JnmwLeoiLUjViByHffVZGy
        h2xwpvM+x9I3x6ZX0exsgHkysw2X75Fj+FcDrnhj7XANCD87H/FpYZ9PKEsklfUcIaIc=;
Received: from root (helo=callcc.thunk.org)
        by imap.thunk.org with local-esmtp (Exim 4.89)
        (envelope-from <tytso@thunk.org>)
        id 1foHF2-0005LW-Ll; Fri, 10 Aug 2018 23:54:48 +0000
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id E40A57A5B5B; Fri, 10 Aug 2018 19:54:47 -0400 (EDT)
Date:   Fri, 10 Aug 2018 19:54:47 -0400
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     "Darrick J. Wong" <darrick.wong@oracle.com>
Cc:     Andy Lutomirski <luto@kernel.org>,
        David Howells <dhowells@redhat.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        John Johansen <john.johansen@canonical.com>,
        Tejun Heo <tj@kernel.org>, SELinux-NSA <selinux@tycho.nsa.gov>,
        Paul Moore <paul@paul-moore.com>,
        Li Zefan <lizefan@huawei.com>,
        Linux API <linux-api@vger.kernel.org>,
        apparmor@lists.ubuntu.com,
        Casey Schaufler <casey@schaufler-ca.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Eric Biggers <ebiggers@google.com>,
        LSM List <linux-security-module@vger.kernel.org>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Stephen Smalley <sds@tycho.nsa.gov>,
        tomoyo-dev-en@lists.sourceforge.jp,
        "open list:CONTROL GROUP (CGROUP)" <cgroups@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Miklos Szeredi <miklos@szeredi.hu>
Subject: Re: BUG: Mount ignores mount options
Message-ID: <20180810235447.GK627@thunk.org>
Mail-Followup-To: "Theodore Y. Ts'o" <tytso@mit.edu>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Andy Lutomirski <luto@kernel.org>,
        David Howells <dhowells@redhat.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        John Johansen <john.johansen@canonical.com>,
        Tejun Heo <tj@kernel.org>, SELinux-NSA <selinux@tycho.nsa.gov>,
        Paul Moore <paul@paul-moore.com>, Li Zefan <lizefan@huawei.com>,
        Linux API <linux-api@vger.kernel.org>, apparmor@lists.ubuntu.com,
        Casey Schaufler <casey@schaufler-ca.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Eric Biggers <ebiggers@google.com>,
        LSM List <linux-security-module@vger.kernel.org>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Stephen Smalley <sds@tycho.nsa.gov>,
        tomoyo-dev-en@lists.sourceforge.jp,
        "open list:CONTROL GROUP (CGROUP)" <cgroups@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Miklos Szeredi <miklos@szeredi.hu>
References: <20180810153902.GH21087@thunk.org>
 <87d0uqpba5.fsf@xmission.com>
 <153313703562.13253.5766498657900728120.stgit@warthog.procyon.org.uk>
 <22361.1533913891@warthog.procyon.org.uk>
 <28045.1533916438@warthog.procyon.org.uk>
 <20180810161400.GA627@thunk.org>
 <CALCETrXC8Z-q+PzzqMC-McA7UdmFubVcs2dVsT0Dt+GbSqjF5A@mail.gmail.com>
 <20180810204639.GI627@thunk.org>
 <20180810221234.GC4211@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180810221234.GC4211@magnolia>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on imap.thunk.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 10, 2018 at 03:12:34PM -0700, Darrick J. Wong wrote:
> Hey now, there was a little more nuance to it than that[1][2].  The
> complaint in the first instance had much more to do with breaking
> existing V4 filesystems by adding format requirements that mkfs didn't
> know about when the filesystem was created.  Yes, you can create V4
> filesystems that will hang the system if the log was totally unformatted
> and metadata updates are made, but OTOH it's fairly obvious when that
> happens, you have to be root to mount a disk filesystem, and we try to
> avoid breaking existing users.

I wasn't thinking about syzbot reports; I've largely written them off
as far as file system testing is concerned, but rather Wen Xu at
Georgia Tech, who is much more reasonable than Dmitry, and has helpeyd
me out a lot; and has complained that the XFS folks haven't been
engaging with him.

In either case, both security researchers are fuzzing file system
images, and then fixing the checksums, and discovering that this can
lead to kernel crashes, and in a few cases, buffer overruns that can
lead to potential privilege escalations.  Wen can generate reports
faster than syzbot, but at least he gives me file system images (as
opposed to having to dig them out of syzbot repro C files) and he
actually does some analysis and explains what he thinks is going on.

I don't think anyone was claiming that format requirements should be
added to ext4 or xfs file systems.  But rather, that kernel code
should be made more robust against maliciously corrupted file system
images that have valid checksums.  I've been more willing to work with
Wen; Dave has expressed the opinion that these are not realistic bug
reports, and since only root can mount file systems, it's not high
priority.

The reason why I bring this up here is that in container land, there
are those who believe that "container root" should be able to mount
file systems, and if the "container root" isn't trusted, the fact that
the "container root" can crash the host kernel, or worse, corrupt the
host kernel and break out of the container as a result, that would be
sad.

I was pretty sure most file system developers are on the same page
that allowing untrusted "container roots" the ability to mount
arbitrary block device file systems is insanity.  Whether or not we
try to fix these sorts of bugs submitted by security researchers.  :-)

	  	       	    	       		  - Ted
