Return-Path: <SRS0=aVpA=KZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94F97C46464
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Aug 2018 15:56:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4D0A922420
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Aug 2018 15:56:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="oUQLM2Q8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4D0A922420
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728915AbeHJS00 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Aug 2018 14:26:26 -0400
Received: from sonic311-28.consmr.mail.gq1.yahoo.com ([98.137.65.209]:36509
        "EHLO sonic311-28.consmr.mail.gq1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727977AbeHJS0Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Aug 2018 14:26:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1533916559; bh=6xM3FAqqTxxxO9zKNcb0GybRGm70o963Qu6SmhyAoNE=; h=Subject:To:References:Cc:From:Date:In-Reply-To:From:Subject; b=oUQLM2Q8SF2vf8A/2LmSX++5PmSKDn7d58UBni1PB8hSxW4sojQe/G2nSYrwnBv74dXGcSebVQV61G0AZZIbvYKWfMRecA4Al9de4pTjFZhFBB45pZ0Qto7iAHrhdUrzL2C2TTfcKY3cGTZnviEbBYHE9uYi9klo3L9VNPKHBZtMgmcIbBdJt6PKT37ztF1rwFwyMdkmKWwA61zoCiamku+l9SuJTVdNeqVrT5YEj8APJZjaytVvds7MOMQIxJVLUa0MAX8aDlXpxdAT0kmpKRYF3Svs0E4aqHzmJMeBBTz03JGJVoMj0TMchF/iUDOPEYHt3kV4iWJuZLknA5+qQg==
X-YMail-OSG: HNeRMDsVM1k4AxC1mcpBSDyyxFloOy02s_Y6KMJ6p8txZ9Q9t0NtzNvKBCibBEm
 MZC6MWP031vO8g8HEyR.WyH9vmwmZRRwmHjlVQ6C53s5dIv9OCV9jJOeCenRDDOLPCuKQhmERZz3
 iig_BZNQ6DXFKXYHPzAnoTXHaBKKDgZhxKaY.QHzVmjH_3MWA9CcaxzFOrwN7FAmZGiTv9jwGp.u
 4Ruz0IjDK_LUpEWE219eP1kdg.BDNnS5zvwHsuukrazflUramwI6r1GcVIza.Ri_5WUgqRFzr2xc
 jx.BuWYi.nz7doNbYK3GoTWnTJw8zoSVP8x6uqCf.L_rt14w27RdbzYY_BdYgPEDXNotSAEGPTd6
 GOEDqnJCJoYVzOCTCzW2N4341LbtTRrG69fAlI9o2J1vZ_rDLxAVG6cLnEY56YT8GqQPe3Viv2Nh
 0I22i8ETGpg.9LJJIWLTzTgPINwc47oPZvcqoLa8PDAYejYtzn8xuxYlOnSKmgIWj6.t_1yMPi10
 P2SE.Djq8C6xUP_DG1fKrddhBW3UUuvGWGo9h7IUVRkmCWQPuxo6sS.GG7PMFr6ntLRzy9UIIfj9
 a2X2yshuoTCQk_D9fL01riLswFHCpc56ijTL5X4GQin0gGYaQRuNjwxN7BN9QpxtQFzKgFEbhkCy
 sa7rZGev1vQxzcG2EtuSvXEIsh.kU.4dCk3MpQ0rzOQJL0F7ttwc_wt4RYuaw.do.6Aah8XH7Zmn
 ejsags0D4XrSWtuEiZyl3AsnLpq6J6EsaSyNJ5vKXeaJBnE1fhvbyeiUes5GCNzJdKBcx67y41S_
 rMLDrRssH1UFs6.6dJl2fZqlpg9TfsmuaRDnneDH5YwwjzBc630Z6FQifuO8lAvJ7NlpVIwyiTM0
 HM114kLdFiwPK7YdqC4WAhduXDk2dVxrqcNoUyT_EYkB1jFi_2dXvG9_s0ePG01hATe7BJ1c5uBU
 R_w3SXq4711bBrwYEHjR0t2gRdpX6.3WmbIwTTEwehu.VQwZV87H4xbHUueQ-
Received: from sonic.gate.mail.ne1.yahoo.com by sonic311.consmr.mail.gq1.yahoo.com with HTTP; Fri, 10 Aug 2018 15:55:59 +0000
Received: from c-67-169-65-224.hsd1.ca.comcast.net (EHLO [192.168.0.104]) ([67.169.65.224])
          by smtp416.mail.gq1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID d690264daa8e0bd5771bf0627c70844a;
          Fri, 10 Aug 2018 15:55:54 +0000 (UTC)
Subject: Re: BUG: Mount ignores mount options
To:     "Theodore Y. Ts'o" <tytso@mit.edu>,
        David Howells <dhowells@redhat.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        viro@zeniv.linux.org.uk,
        John Johansen <john.johansen@canonical.com>,
        Tejun Heo <tj@kernel.org>, selinux@tycho.nsa.gov,
        Paul Moore <paul@paul-moore.com>,
        Li Zefan <lizefan@huawei.com>, linux-api@vger.kernel.org,
        apparmor@lists.ubuntu.com, fenghua.yu@intel.com,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Eric Biggers <ebiggers@google.com>,
        linux-security-module@vger.kernel.org,
        Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Stephen Smalley <sds@tycho.nsa.gov>,
        tomoyo-dev-en@lists.sourceforge.jp, cgroups@vger.kernel.org,
        torvalds@linux-foundation.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, Miklos Szeredi <miklos@szeredi.hu>
References: <87d0uqpba5.fsf@xmission.com>
 <153313703562.13253.5766498657900728120.stgit@warthog.procyon.org.uk>
 <22361.1533913891@warthog.procyon.org.uk> <20180810153902.GH21087@thunk.org>
Cc:     Casey Schaufler <casey@schaufler-ca.com>
From:   Casey Schaufler <casey@schaufler-ca.com>
Message-ID: <f199f22e-f064-b089-25bd-6e37ed1a73bd@schaufler-ca.com>
Date:   Fri, 10 Aug 2018 08:55:51 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180810153902.GH21087@thunk.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/10/2018 8:39 AM, Theodore Y. Ts'o wrote:
> On Fri, Aug 10, 2018 at 04:11:31PM +0100, David Howells wrote:
>> Yes.  Since you *absolutely* *insist* on this being fixed *right* *now* *or*
>> *else*, I'm working up a set of additional patches to give userspace the
>> option of whether they want no sharing; sharing, but only with exactly the
>> same parameters; or to ignore the parameter differences and just accept
>> sharing of what's already already mounted (ie. the current behaviour).
> But there's no way to support "no sharing", at least not in the
> general case.  A file system can only be mounted once, and without
> file system support, there's no way for a file system to be mounted
> with the bsddf or minixdf mount simultaneously.
>
> Even *with* file system support, there's no way today for the VFS to
> keep track of whether a pathname resolution came through one
> mountpoint or another, so I can't do something like this:
>
> 	mount /dev/sdXX -o casefold /android-data
> 	mount /dev/sdXX -o nocasefold /android-data-2
>
> Which is a pity, since if we could we could much more easily get rid
> of the horror which is Android's wrapfs...
>
> So if the file system has been mounted with one set of mount options,
> and you want to try to mount it with a conflicting set of mount
> options and you don't want it to silently ignore the mount options,
> the *only* thing we can today is to refuse the mount and return an
> error.  
>
> I'm not sure Eric would really consider that an improvement for the
> container use case....
>
> 						- Ted
>
> P.S.  And as Al has pointed out, this would require special, per-file
> system support to determine whether the mount options are conflicting
> or not....

This extends to LSMs that support mount options (SELinux and Smack)
as well. 

