Return-Path: <SRS0=t4yP=K2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A2CDC46460
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Aug 2018 19:48:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 463C621E5D
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Aug 2018 19:48:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="TqEMiEkC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 463C621E5D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727554AbeHKWX1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 11 Aug 2018 18:23:27 -0400
Received: from sonic311-20.consmr.mail.bf2.yahoo.com ([74.6.131.194]:43331
        "EHLO sonic311-20.consmr.mail.bf2.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727514AbeHKWX0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Aug 2018 18:23:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1534016894; bh=sf4khYezCdxrT+rmqNy8MWwtEJ/vcYtOYusNjA8nknA=; h=Subject:To:Cc:References:From:Date:In-Reply-To:From:Subject; b=TqEMiEkCy5ofOPn4MVtWVxgz2k5WWxAl4NTlDNu/dCl3FUfrHVxTPDErM9GQDvD1nGEfKc0E1NMN58ZczV3slUU4o9vdNCmjrK9/6nQyUHHppI3+RgxGcHyPWAT5m9TDJnVazd0mqL6XzLEDGIMqF7kVZbTL1nuUQNLbxN4UyHB31Ju/E9nSX78SChYBcGOflMCQK3ZMCRcyoDMaNPkJ8inNcQAwLH2sGqPFrQ9O3+LY77bEjzQcs6Ocxgd8cUMVC+ONulbuFF18jBKd3DnyG9h3V5y9T4u/NFNblGc55nWhNR213r/Fp/NcE1HZyGnUUQgGwrm181cdJPFoMef8Kw==
X-YMail-OSG: .kpIcTgVM1ma.JQGyJc9NQ2310qDi_5gy1cZ2GWDibZBkvh5hUlwXOJqDL6edWz
 Rk7XJYmZC8MW_3YTngTECiWqz24npVwPz7dN98iotFB76XvHSjw3VbeiGNN_S3AgMEO7eUTjPJrr
 0A412_dH7LCmBQbUOyXAx_DSHF38TsYhZaut8vlzGwbOfYY5YDs4fjzszboeYJSaBH_4o5llKDZk
 3tWzYUubO6I3sGV.GRrkytEJoDsm5Hk2irtSYBr0oW7aklnEPlYtlUdVGgVkXIyDAAuuhaorQmKe
 YF4Yrpw6qzdjHVDw1CXhZsZTcWuZQGpEdsVlM_UHLv283mI51pKrLLTeY50LuXZ6xDSl0_E1LdYq
 1YOtOcgqrc4i3Rn4PTIxVfgmSFn_fiXP1avXtsC1YiIxKQLIKqat5a272S.9T5KonMPCONMXGwlf
 Cy2DbN1B.u4oKj5IEE6NJbqN.HytdV9XSBiHRH6AoUVEIZxHPJn64lEymOwibMeh_A2.8T7S2ImE
 MSCW9vskHm.KKONJZpLHytg4x0fVESymww2YKKdIik.lCo6nFEVyCqU_tBgpTE85t4wPyMUM4mK.
 UQ_EPxF6HVAjJgz3Y2JkmTamjyu9kOV9rQ4JYOiB8O69chMPL17vEqkC37z7aAyCJbqSIUfah2bu
 snR5TJ8Udu.gsqJ62C3Vk_s9avlk8bo00d.DaFYUwUJ1bUt0TT7wnS3jiPpHVUvbyG20Zzu9SChN
 IrBTey0MS6GAOWC_n_rNSQFAy3.Bp1zn3akgMuYq1wQtnA9BYqxlEmUeEywxE9J57WuAdpllqUGX
 ysysAg4E3bzxsE.0W_Zjq7kIgv69z4.bAuqCV_J7f_z1ssFSgbIlcJ4WIkPQ0Ijd.HCZ57N6Y4gh
 3QxZcQdVPnFv4afRrAvTvJjhELWTu_BY2mVVByysAcYhC3dWSfxGJBOJ.lSRl.3WnubGnr7ptH51
 du9i0Rcs9iLu3tlKB0U9fF2BY133QXj5slF7F8H2rPiLGOLcCLrIArv9EI8TwTenswmI-
Received: from sonic.gate.mail.ne1.yahoo.com by sonic311.consmr.mail.bf2.yahoo.com with HTTP; Sat, 11 Aug 2018 19:48:14 +0000
Received: from c-67-169-65-224.hsd1.ca.comcast.net (EHLO [192.168.0.102]) ([67.169.65.224])
          by smtp420.mail.bf1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 023c21f71d5c09aba96ed487ecc5ad84;
          Sat, 11 Aug 2018 17:48:00 +0000 (UTC)
Subject: Re: BUG: Mount ignores mount options
To:     "Eric W. Biederman" <ebiederm@xmission.com>,
        "Theodore Y. Ts'o" <tytso@mit.edu>
Cc:     Al Viro <viro@ZenIV.linux.org.uk>,
        David Howells <dhowells@redhat.com>,
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
References: <153313703562.13253.5766498657900728120.stgit@warthog.procyon.org.uk>
 <87d0uqpba5.fsf@xmission.com> <20180810151606.GA6515@ZenIV.linux.org.uk>
 <87pnypiufr.fsf@xmission.com> <20180811014619.GA14368@thunk.org>
 <8736vlo6ef.fsf@xmission.com>
From:   Casey Schaufler <casey@schaufler-ca.com>
Message-ID: <001a1608-d0fa-84c1-9c54-ae36df95fd89@schaufler-ca.com>
Date:   Sat, 11 Aug 2018 10:47:50 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <8736vlo6ef.fsf@xmission.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/10/2018 9:48 PM, Eric W. Biederman wrote:
> "Theodore Y. Ts'o" <tytso@mit.edu> writes:
>
>> On Fri, Aug 10, 2018 at 08:05:44PM -0500, Eric W. Biederman wrote:
>>> My complaint is that the current implemented behavior of practically
>>> every filesystem in the kernel, is that it will ignore mount options
>>> when mounted a second time.
>> The file system is ***not*** mounted a second time.
>>
>> The design bug is that we allow bind mounts to be specified via a
>> block device.  A bind mount is not "a second mount" of the file
>> system.  Bind mounts != mounts.
>>
>> I had assumed we had allowed bind mounts to be specified via the block
>> device because of container use cases.  If the container folks don't
>> want it, I would be pushing to simply not allow bind mounts to be
>> specified via block device at all.
> No it is not a container thing.

	Inigo: "Hello. My name is Inigo Montoya. You killed my father. Prepare to die."
	Rugen: "Stop saying that!"

	Eric:  "It is not a container thing."
	Casey: "Stop saying that!"

Yes, Virginia, it *is* a container thing. Your container manager expects all
filesystems to be server-client based. It makes bad assumptions. It is doing
things that we would fire a sysadmin for doing. Don't blame the filesystems
for behaving as documented. Export the filesystem using NFS and mount them
using the NFS mechanism, which is designed to do what you're asking for. The
problem is not in the mount mechanism, it's in the way you want to abuse it.

>> The only reason why we should support it is because we don't want to
>> break scripts; and if the goal is not to break scripts, then we have
>> to keep to the current semantics, however broken you think it is.
> But we don't have to support returning filesystems with mismatched mount
> options in the new fsopen api.   That is my concern.  Confusing
> userspace this way has been shown to be harmful let's not keep doing it.

It's not "userspace" that's confused. Developers of userspace code
implementing system behavior (e.g. systemd, container managers) need to
understand how the system works. The container manager needs to know
that it can't mount filesystems with different options. That's the kind
of thing "managers" do. If it has to go to the mount table and check
on how the device is already mounted before doing a mount, so be it.

Unless, of course, you want the concept of "container" introduced into
the kernel. There's a whole lot of feldercarb that container managers
have to deal with that would be lots easier to deal with down below.
I'm not advocating that, and I understand the arguments against it.
On the other hand, if you want a platform that is optimized for a
container environment ...

> Eric

