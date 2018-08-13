Return-Path: <SRS0=852P=K4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3141EC46464
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Aug 2018 19:20:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C6380217B4
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Aug 2018 19:20:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="pBbYA3hD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C6380217B4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729923AbeHMWDx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Aug 2018 18:03:53 -0400
Received: from sonic317-26.consmr.mail.gq1.yahoo.com ([98.137.66.152]:36086
        "EHLO sonic317-26.consmr.mail.gq1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728781AbeHMWDw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Aug 2018 18:03:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1534188018; bh=kFRH/+K5tQxnl/iRsE6H8IabvSBDdi6lblclbB0O66o=; h=Subject:To:Cc:References:From:Date:In-Reply-To:From:Subject; b=pBbYA3hDllZ68rKruQaPaMdZYx2eT+GqZau+JDsbdTZT/YMZXL9rvb0UViVkz/zERNEfl9+AhRGO/YBRKg2Uhlf7rWrbJ2Bn4OgmG6ydBX0/8M6t8UBDnG02T5SJP8YhlG2atY61u6j+4NRLLE8HjWpFHChXQBiNoZD2E6iPKbEi8M+Aq/FJBaQJR2opMIel2cBMlzLr5DL7BzZNgDNUjIGKSXAzUwmA8G+/eCDY8o/F+hpOXPbMpvewzefnBsDXSHvxRkFCSigTieIWtSZDsL3fXn3Dupw/UBDgSRyQ6kR8pnsXURo5PC8byejSm+y+Sk8NC27RYePv9+at84AJFQ==
X-YMail-OSG: 7cZWUZoVM1kF3KbUe5gmw4r2mc.1NJZ.C0PSL3poZhccx4ziLzEx8Nqhl1kKgHe
 HqxKk7SZw7YM8lAIixihZRVQp0xfVFpqHztDyqnurShscMFBmwBYqeUi58bA7OIGpyJ6lUer3bRO
 hqkLy4gifxZ8Gt1JOQJEUdIvd7eyb_bvlxXFwt8k4co6BisaBoGtXgqnSRbzOS0R5L9B80SxLfTP
 ya6VaMxKMGAV_xLGLHNHpq8TszzO6j2XvoS4B_P.DOQ1FbIk8ibhXHegmOVpxNcH57ZFsigsxbc3
 uOVIx5IUCq8Ob1OZYhTZCE4lTSWjuU4NhyfGJ4isWuRXmv2O264utJx5a_9r1vWtkuqI5MKs.bhK
 IEs3bS9r0g1cwfXUqLUBDLMcP4Tqzhc_bYG7shaBAatO8iWqx8bqg3akcUNTnIAjw0LcyRFAqC_i
 7bFaqxSEmtKX837UTj6gildBXz9PrGqrgeJCN_d7KLDNkbek03y_4VoVwX3g3h1LiY4aL2lU2o3S
 SdvXF63nc8ItmVTyeL0nMYtFOtvuAqZKPIEBd0KAal1yhrN5idfGjXCdcrlETpU8ogk4TkgtaV_i
 Eroos8hvP60W.08xfNhgWkbnTEAXMD2cdF6auR7_wBYd_J7DD2Ne.mA9cuKYacb3JTpZ8ePsltlr
 0djtGlXpX_Matbiw4cgXNr9e5OkFzdA99Vw_7piDJSeFvmtPuLkQUPREWOsKc3sy9g9X0lMXL0J_
 KKUWuN3kirwzYFKdcaQ3m.MZtfYkDu3Lx_9Hwm8zdEauZ9sNAJ6gmqQ0nCFPitiwLVFytrwbH_2B
 w4UJ11_fNVvSryiF6WVlhxWV4cvqD4VGazzpVdxowYDGkGpejs.jkfmBzAPnqJ3WzWdNj7A53_OV
 K.hvqp4npaUs2epoWhPlKCW9gKKnHJWfDuforJiiLwkcd7WGCvwX1mEuh5SA7jYW9EwnYvcXd0Jw
 Z_BU44IUxBvMnZ4gLimxDkOhpt.WfoW8t4FpgDsHOZn8VrSQMLynLqB3iw0nzB5SBWlWYwv3ZNYb
 QKOMwrkeupxPZHZ_x7R0BM3MIYN4MPfINOVrHsMA6y488IA--
Received: from sonic.gate.mail.ne1.yahoo.com by sonic317.consmr.mail.gq1.yahoo.com with HTTP; Mon, 13 Aug 2018 19:20:18 +0000
Received: from c-67-169-65-224.hsd1.ca.comcast.net (EHLO [192.168.0.102]) ([67.169.65.224])
          by smtp420.mail.gq1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 7bde834e570ab143265c57d9bad1149d;
          Mon, 13 Aug 2018 19:20:17 +0000 (UTC)
Subject: Re: BUG: Mount ignores mount options
To:     James Morris <jmorris@namei.org>, Al Viro <viro@ZenIV.linux.org.uk>
Cc:     Andy Lutomirski <luto@kernel.org>,
        Alan Cox <gnomes@lxorguk.ukuu.org.uk>,
        "Theodore Y. Ts'o" <tytso@mit.edu>,
        David Howells <dhowells@redhat.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        John Johansen <john.johansen@canonical.com>,
        Tejun Heo <tj@kernel.org>, SELinux-NSA <selinux@tycho.nsa.gov>,
        Paul Moore <paul@paul-moore.com>,
        Li Zefan <lizefan@huawei.com>,
        Linux API <linux-api@vger.kernel.org>,
        apparmor@lists.ubuntu.com, Fenghua Yu <fenghua.yu@intel.com>,
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
References: <20180810153902.GH21087@thunk.org> <87d0uqpba5.fsf@xmission.com>
 <153313703562.13253.5766498657900728120.stgit@warthog.procyon.org.uk>
 <22361.1533913891@warthog.procyon.org.uk>
 <28045.1533916438@warthog.procyon.org.uk> <20180810161400.GA627@thunk.org>
 <CALCETrXC8Z-q+PzzqMC-McA7UdmFubVcs2dVsT0Dt+GbSqjF5A@mail.gmail.com>
 <20180813173502.1a7a1d9c@alans-desktop>
 <CALCETrXvtSLjwx0swXo5g-vU3PmF-_6J6j1a_2pAba7bhzO9QQ@mail.gmail.com>
 <20180813172947.GS6515@ZenIV.linux.org.uk>
 <alpine.LRH.2.21.1808140458040.23296@namei.org>
From:   Casey Schaufler <casey@schaufler-ca.com>
Message-ID: <48e443ba-51b5-cf10-3342-cdeabb91b224@schaufler-ca.com>
Date:   Mon, 13 Aug 2018 12:20:14 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <alpine.LRH.2.21.1808140458040.23296@namei.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/13/2018 12:00 PM, James Morris wrote:
> On Mon, 13 Aug 2018, Al Viro wrote:
>
>> On Mon, Aug 13, 2018 at 09:48:53AM -0700, Andy Lutomirski wrote:
>>> Are there cases I'm missing?  It sounds like the API could be improved
>>> to fully model the last case, and everything will work nicely.
>> 	You know, that's starting to remind of this little gem of Borges:
>> http://www.alamut.com/subj/artiface/language/johnWilkins.html
>> Especially the delightful (fake) quote contained in there:
>> [...] it is written that the animals are divided into:
>> 	(a) belonging to the emperor,
>> 	(b) embalmed,
>> 	(c) tame,
>> 	(d) sucking pigs,
>> 	(e) sirens,
>> 	(f) fabulous,
>> 	(g) stray dogs,
>> 	(h) included in the present classification,
>> 	(i) frenzied,
>> 	(j) innumerable,
>> 	(k) drawn with a very fine camelhair brush,
>> 	(l) et cetera,
>> 	(m) having just broken the water pitcher,
>> 	(n) that from a long way off look like flies.
>
> Coincidentally, this was also the model for Linux capabilities.

Linux capabilities are POSIX capabilities which are modeled closely
to accommodate the historical behavior manifest in the P1003.1 specification.
So except for (c), (f) and (k) you can use this characterization. 

On a slightly more serious note, there's a lot of Linux, mount semantics
included, that have grow organically and that aren't quite up to the
usage models they are being applied to. I applaud David's work in part
because it may make it possible to accommodate more of those cases going
forward.

