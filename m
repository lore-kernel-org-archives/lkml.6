Return-Path: <SRS0=hTZH=KI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6AC2ECDFB8
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 18:57:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6F06A20874
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 18:57:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="cOmbLKDq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6F06A20874
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388603AbeGXUFc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Jul 2018 16:05:32 -0400
Received: from sonic302-28.consmr.mail.gq1.yahoo.com ([98.137.68.154]:34218
        "EHLO sonic302-28.consmr.mail.gq1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2388569AbeGXUFc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jul 2018 16:05:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1532458661; bh=QFJ92J2UnGWhBJhmadRU9Wfu82q73HR/dQb1Nd2fLxc=; h=Subject:To:Cc:References:From:Date:In-Reply-To:From:Subject; b=cOmbLKDqdXtwuSmDQFh22q85OGMCQfN7TlAvDHvo8ViFmM5BV9PEwCe4US9hM2Y3qEx0X+9Rmi/3eP6s9ii/A3Jcr7rMxihtp8Qbl5rVho/SCkEKlZX3O7uwPOveO0b+FszZWEctxngOTcMikr4osZh3S/PbG8OZzBv7uGLLq+k95XT1l4HAJMAH9obq1LO2zIAihegpmmOLgyzf1qSkxy+OoJhzJWurl9o5XkbPmWijWqfBcVGAg8HTVWP6CNfjD3Hs3DgNWigksZqedrleH8mSEwMBgSFydexIdvqgVmdCzMKouOAyBHgP6e1wAi6gtvBO3edLAG4FRR/XE/izoA==
X-YMail-OSG: cYs..AMVM1kNzqasQZAdknOncgmyE2xMhJ8YYgY4v92FPH7W.O.9daRxwdSi2RA
 PyJRtJ3XStxI8xZPu7bIlpSnhDj3B5pVqScH5_wucWEI929gPK8ts6iGlumcgpis.1TnTFQ308Hx
 voXszpD6I8dN8coOPxef2GR1gia3FBpT.EsW4JQDYVSI50N5Nv2bV1HgXYDNNMr5aNWAD9nhe9Bm
 uMrCW3RbL18T_Lj57DhVQ9_PU130agkccjjeTXxhC1.e2lRMjMxaWun679ChlSvp99lmkualcN_8
 ZYHuCE.ZHZjneEJNyB5En2180DkRlj36ZCvzvhK0I6qguX5310mbyDEe46UqFI18eEEC0M_zHXG.
 xfhfZZi28SDBgUbz5cpdeyYQ_bJK.z6ZCNt0KW1g_1Yg8q5oH4KDOPg3PD15.hcFOHRO8DayoX1l
 vE8dUhPs0CVZKPk7Hxp9bPZ1..gDXWaFGZ.Wu3DnOZyzEjb06nENuouTYHTprg6Yd7g4RCaKk099
 uM1ywqYMBZJ4B1EDi7sD5YhYz.qjlobq._o.SP_c8PoVmap5oUOO6v8opP1ZJe.TiYeSglHKT4IG
 FD3cVyvSP6SeIreqN1iVfD7.Xxi.1pO64U_uW8HgHiod4gOOx6sXnYyD5lD6Xunr3kEjTxEHRPi3
 pHsian0wdL0SaeIcgZL_KzAjtJ5g8V7j6OWrrJftQM2YCBnnMn0Vi3o8dntC9loKFnfI7FKtgYZV
 cYuBTJ2kI5G_cyz5hESNqM7J8Oncr35FpnQXNNx5VHQI4CYx8XtfFtYi2nZVp1KrNv3VG3T3P85W
 0TgoZgQ0b1CFZJ4Crttua674dx7MBaT30OWAERXjS58uKrBYP6WEvCWyFZlLdL9vUDNLFM5HvXuw
 QX72PjppCTKo9dde2dy1boVLF9P_Yd.vZ2xE0TT.FtR__hDqMtCt3ZKohUhtwCsdLRZPUUj.no2b
 3Z6_awvHVjopvMzajsQsr2dMolJt0Geh6exPxCvYSS9TBd0T3fPodTYnuiJXv1Rk_QfLm0k6M3z4
 .PeAuM7cYEe8tXYcEHG6KnQ--
Received: from sonic.gate.mail.ne1.yahoo.com by sonic302.consmr.mail.gq1.yahoo.com with HTTP; Tue, 24 Jul 2018 18:57:41 +0000
Received: from c-67-169-65-224.hsd1.ca.comcast.net (EHLO [192.168.0.104]) ([67.169.65.224])
          by smtp404.mail.gq1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID f042f9dc81f94b427b06f5e74930c0d7;
          Tue, 24 Jul 2018 18:57:38 +0000 (UTC)
Subject: Re: [RFC][PATCH 0/5] Mount, Filesystem and Keyrings notifications
To:     David Howells <dhowells@redhat.com>
Cc:     viro@zeniv.linux.org.uk, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, raven@themaw.net,
        keyrings@vger.kernel.org, linux-security-module@vger.kernel.org
References: <675e5c24-36ef-4cc5-846c-1414c1195d85@schaufler-ca.com>
 <153235954191.32640.5792167066538704794.stgit@warthog.procyon.org.uk>
 <23894.1532448035@warthog.procyon.org.uk>
From:   Casey Schaufler <casey@schaufler-ca.com>
Message-ID: <04b05dbd-0aa4-7789-1314-52108246291a@schaufler-ca.com>
Date:   Tue, 24 Jul 2018 11:57:37 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <23894.1532448035@warthog.procyon.org.uk>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/24/2018 9:00 AM, David Howells wrote:
> Casey Schaufler <casey@schaufler-ca.com> wrote:
>
>>>  (1) Mount topology and reconfiguration change events.
>> With the possibility of unprivileged mounting you're going to have to
>> address access control on events.  If root in a user namespace mounts a
>> filesystem you may have a case where the "real" user wouldn't want the
>> listener to receive a notification.
> Can you clarify who the listener is in this case?

That would be anyone with a watchpoint set.

> Note that mount topology events don't leak outside of the mount namespace
> they're generated in.
>
> That said, if you, a random user, put a watchpoint on "/" you can see the
> mount events triggered by another random user in the same mount namespace.  I
> don't see a way to control this except by resorting to the LSM since UNIX
> doesn't have 'notify' permission bits.

I would call that a write operation from the process that triggered
the watchpoint to the one watching it. Like a signal. Signals have a
rudimentary DAC policy (write only to the same UID) that could be
your model.

> But for each event, I can associate an object label, derived from the source,
> and use f_cred on the notification queue to provide a subject label.

... or UID or groups.

>
>>>  (2) Superblocks EIO, ENOSPC and EDQUOT events (not complete yet).
>> Here, too. If SELinux (for example) policy says you can't see
>> anything on a filesystem you shouldn't get notifications about
>> things that happen to that filesystem.
> Yep.  Sounds like I need to refer that to the LSM as above.
>
> It's a bit easier for specifically nominated sb sources since you might only
> need to do the check once at sb_notify() time.  If there's a general queue
> that all sbs contribute to, however, then things become more complicated as
> the checks have to be done at do-we-write-into-this-queue? time.
>
>>>  (3) Key/keyring changes events
>> And again, I should only get notifications about keys and
>> keyrings I have access to.
> Currently, you can only watch keys that grant you View permission, which might
> suffice.

That seems appropriate.

>> I expect that you intentionally left off
>>
>>    (4) User injected events
>>
>> at this point, but it's an obvious extension. That is going
>> to require access controls (remember kdbus) so I think you'd
>> do well to design them in now rather than have some security
>> module hack like me come along later and "fix" it. 
> Yeah - the thought had occurred to me, but there needs to be some way to
> define a 'source' and a way to connect them.  Also, would you want a general
> source that anyone can contribute through, specific sources where you have to
> directly connect or namespace-restricted sources?

My guess is that the consensus would be "Yes" to all the above.

>
> David
>

