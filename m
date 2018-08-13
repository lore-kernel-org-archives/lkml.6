Return-Path: <SRS0=852P=K4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16274C46464
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Aug 2018 19:01:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C2922215A5
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Aug 2018 19:01:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C2922215A5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=namei.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730597AbeHMVpK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Aug 2018 17:45:10 -0400
Received: from namei.org ([65.99.196.166]:43008 "EHLO namei.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729719AbeHMVpK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Aug 2018 17:45:10 -0400
Received: from localhost (localhost [127.0.0.1])
        by namei.org (8.14.4/8.14.4) with ESMTP id w7DJ0fdn023710;
        Mon, 13 Aug 2018 19:00:41 GMT
Date:   Tue, 14 Aug 2018 05:00:41 +1000 (AEST)
From:   James Morris <jmorris@namei.org>
To:     Al Viro <viro@ZenIV.linux.org.uk>
cc:     Andy Lutomirski <luto@kernel.org>,
        Alan Cox <gnomes@lxorguk.ukuu.org.uk>,
        "Theodore Y. Ts'o" <tytso@mit.edu>,
        David Howells <dhowells@redhat.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
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
In-Reply-To: <20180813172947.GS6515@ZenIV.linux.org.uk>
Message-ID: <alpine.LRH.2.21.1808140458040.23296@namei.org>
References: <20180810153902.GH21087@thunk.org> <87d0uqpba5.fsf@xmission.com> <153313703562.13253.5766498657900728120.stgit@warthog.procyon.org.uk> <22361.1533913891@warthog.procyon.org.uk> <28045.1533916438@warthog.procyon.org.uk> <20180810161400.GA627@thunk.org>
 <CALCETrXC8Z-q+PzzqMC-McA7UdmFubVcs2dVsT0Dt+GbSqjF5A@mail.gmail.com> <20180813173502.1a7a1d9c@alans-desktop> <CALCETrXvtSLjwx0swXo5g-vU3PmF-_6J6j1a_2pAba7bhzO9QQ@mail.gmail.com> <20180813172947.GS6515@ZenIV.linux.org.uk>
User-Agent: Alpine 2.21 (LRH 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 13 Aug 2018, Al Viro wrote:

> On Mon, Aug 13, 2018 at 09:48:53AM -0700, Andy Lutomirski wrote:

> > Are there cases I'm missing?  It sounds like the API could be improved
> > to fully model the last case, and everything will work nicely.
> 
> 	You know, that's starting to remind of this little gem of Borges:
> http://www.alamut.com/subj/artiface/language/johnWilkins.html
> Especially the delightful (fake) quote contained in there:
> [...] it is written that the animals are divided into:
> 	(a) belonging to the emperor,
> 	(b) embalmed,
> 	(c) tame,
> 	(d) sucking pigs,
> 	(e) sirens,
> 	(f) fabulous,
> 	(g) stray dogs,
> 	(h) included in the present classification,
> 	(i) frenzied,
> 	(j) innumerable,
> 	(k) drawn with a very fine camelhair brush,
> 	(l) et cetera,
> 	(m) having just broken the water pitcher,
> 	(n) that from a long way off look like flies.


Coincidentally, this was also the model for Linux capabilities.


-- 
James Morris
<jmorris@namei.org>

