Return-Path: <SRS0=t4yP=K2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA1C8C46464
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Aug 2018 01:32:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7264E22429
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Aug 2018 01:32:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7264E22429
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xmission.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726747AbeHKEEp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 11 Aug 2018 00:04:45 -0400
Received: from out01.mta.xmission.com ([166.70.13.231]:59717 "EHLO
        out01.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725199AbeHKEEp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Aug 2018 00:04:45 -0400
Received: from in01.mta.xmission.com ([166.70.13.51])
        by out01.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1foIlS-0004RL-5c; Fri, 10 Aug 2018 19:32:22 -0600
Received: from [97.119.167.31] (helo=x220.xmission.com)
        by in01.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1foIlQ-00025T-Mm; Fri, 10 Aug 2018 19:32:21 -0600
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     "Darrick J. Wong" <darrick.wong@oracle.com>
Cc:     "Theodore Y. Ts'o" <tytso@mit.edu>,
        Andy Lutomirski <luto@kernel.org>,
        David Howells <dhowells@redhat.com>,
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
        "open list\:CONTROL GROUP \(CGROUP\)" <cgroups@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Miklos Szeredi <miklos@szeredi.hu>
References: <20180810153902.GH21087@thunk.org> <87d0uqpba5.fsf@xmission.com>
        <153313703562.13253.5766498657900728120.stgit@warthog.procyon.org.uk>
        <22361.1533913891@warthog.procyon.org.uk>
        <28045.1533916438@warthog.procyon.org.uk>
        <20180810161400.GA627@thunk.org>
        <CALCETrXC8Z-q+PzzqMC-McA7UdmFubVcs2dVsT0Dt+GbSqjF5A@mail.gmail.com>
        <20180810204639.GI627@thunk.org> <20180810221234.GC4211@magnolia>
        <20180810235447.GK627@thunk.org> <20180811003852.GA10463@magnolia>
Date:   Fri, 10 Aug 2018 20:32:04 -0500
In-Reply-To: <20180811003852.GA10463@magnolia> (Darrick J. Wong's message of
        "Fri, 10 Aug 2018 17:38:52 -0700")
Message-ID: <87zhxtg02z.fsf@xmission.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1foIlQ-00025T-Mm;;;mid=<87zhxtg02z.fsf@xmission.com>;;;hst=in01.mta.xmission.com;;;ip=97.119.167.31;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX19wpjpXAcK0hVjLBP3Ytr6c51gH4N7KUKo=
X-SA-Exim-Connect-IP: 97.119.167.31
X-SA-Exim-Mail-From: ebiederm@xmission.com
Subject: Re: BUG: Mount ignores mount options
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

"Darrick J. Wong" <darrick.wong@oracle.com> writes:

> On Fri, Aug 10, 2018 at 07:54:47PM -0400, Theodore Y. Ts'o wrote:

>> The reason why I bring this up here is that in container land, there
>> are those who believe that "container root" should be able to mount
>> file systems, and if the "container root" isn't trusted, the fact that
>> the "container root" can crash the host kernel, or worse, corrupt the
>> host kernel and break out of the container as a result, that would be
>> sad.
>> 
>> I was pretty sure most file system developers are on the same page
>> that allowing untrusted "container roots" the ability to mount
>> arbitrary block device file systems is insanity.
>
> Agreed.

For me I am happy with fuse.  That is sufficient to cover any container
use cases people have.   If anyone comes bugging you for more I will be
happy to push back.

The only thing that containers have to do with this is I wind up
touching a lot of the kernel/user boundary so I get to see a lot of it
and sometimes see weird things.

Eric
