Return-Path: <SRS0=S+WB=KJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82CFDC6778F
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 15:48:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2BA17204EC
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 15:48:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="YLJbPG+B"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2BA17204EC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729337AbeGYRBG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Jul 2018 13:01:06 -0400
Received: from sonic302-27.consmr.mail.gq1.yahoo.com ([98.137.68.153]:45456
        "EHLO sonic302-27.consmr.mail.gq1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728568AbeGYRBG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jul 2018 13:01:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1532533730; bh=bfXX8wB2Z29YlLAx+bZb6/qIPNeCd45Zd0c/WQQl8QQ=; h=Subject:To:Cc:References:From:Date:In-Reply-To:From:Subject; b=YLJbPG+BOM0g64Xwi6T8fdVzq9c6iomdKIP6dimQE4+P+MwRkhYi6LlXVJg7uwi/Ckv9owzwRlZjD9/lgw7Xj0FkSjecDN5yqSbmkeaFdBKHqMSkak4zFof82yfI56j5IFXb4gXoFkUwATqb68LQ9efVyLxAP/v+b7w+Gn+RKY4017WJUzlRzyXQNaSAxeAi1VDbPs060bw2lPKctyUKfvw53h7pXQRukU0oYbQlw9/kgk1YA2CCXCflUM+Weo6fqmRrf5meJQbwz1BVlBBs1qN/p/r3RXSXtolCEY9rLW2ubTGFc0MJyA0zqc/klp5TUAj0N8hBRTF/Ym6bcnjo3Q==
X-YMail-OSG: ttJQfJ8VM1kEO2iq2oGRb.RZqK5KlHsdfwS_An0Bx7KWnketl6L5CwOf.uUYUC6
 B7.1.vrtqB4bZNViUjn9.fWqbP6c7.tdRcWet2Jcm.cmazGFp.J9Qb1xaTB__6KkpJxpcLaLqYAi
 a8lmFUedT9yTJYHWJ.OkYXKhORkpy06FaRqI3wDijLm.y_JKxGs7W.k8o8NgV49Y0hEDvUVKRNfI
 jl1DzmNiBn5VU61YMHQHlLXpNb27zbCToMdnB_8PB.A.P1ldRftjmtixY.RmP4cgHO5sFt8aWcxL
 luLGJzOzqgA.uYqcJLnUVptABA7T1_LnYe09gBkg_35bXkyYbr3IjuMBQd6q0K1JvrQi4glPNXqe
 AlAD_qoN_NpJ1XgQKu9yApPmvv._LjRKJIutMW5tjifSI96ivYgq6ru.YdRZGqCGeBLJ6B.d3lc0
 5zQPidLbHffsUyPtq6o_i7aui0K1ZWcp6gEOISIeEqMuZwa065e0SGMqAo7l4neG20.7X9PsRdzx
 Kz_G4XfV.tTzcPNtfSrP39.oL999wKW9I4sBUvnb8Wf04XvfusxkenWXnMe2RSO.8Wm_m0VrWyVk
 P80AKRxVl2pRngchVPlCsgrMBnsk88.a7Npmb0QPSouPJr5kKMxexDkH1EcfKBow9hPRz64rj2H9
 Z9XYwKYjLvaZk1A.I25XwXK8xR7yA2nOgsxU.rumbtZS_xcR93m2orEGurtnUm96XgpxKQBHioFx
 CQaS1vYZVIDYRuqC33MnGrI1GPpjluJ1iA7kctIxbrfxMbF.9MqpZ6yw3BwlLEreF_pgIFKuteJK
 rXWguex1v83FQHAyofXGMgF6_JiE6hKjp2m88e329IYUo5sEoYCmLCCBzpNTXJU3fs.VUknio4sU
 0U6PtOTWzbr.qFwxpFzqsxudrhz3fiOxotdY9oirhNcNkFbFR6u8Tuco4bBJRmvnzi2WeIcTYNa_
 XZfF1iLTlJIY5p2DSy1_lwRu6Kg2LTNgGUiaCzEWRy3rA3JwlTUqVayfxa8mNIRTEwt8ePf6huXS
 BKVUDf5EcaHDWjt1jvG60jkdB9UEhKzG6tZY-
Received: from sonic.gate.mail.ne1.yahoo.com by sonic302.consmr.mail.gq1.yahoo.com with HTTP; Wed, 25 Jul 2018 15:48:50 +0000
Received: from c-67-169-65-224.hsd1.ca.comcast.net (EHLO [192.168.0.104]) ([67.169.65.224])
          by smtp409.mail.gq1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID b845d5c16c44dedfa70ee99771708f2d;
          Wed, 25 Jul 2018 15:48:48 +0000 (UTC)
Subject: Re: [RFC][PATCH 0/5] Mount, Filesystem and Keyrings notifications
To:     Ian Kent <raven@themaw.net>, David Howells <dhowells@redhat.com>
Cc:     viro@zeniv.linux.org.uk, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, keyrings@vger.kernel.org,
        linux-security-module@vger.kernel.org
References: <675e5c24-36ef-4cc5-846c-1414c1195d85@schaufler-ca.com>
 <153235954191.32640.5792167066538704794.stgit@warthog.procyon.org.uk>
 <23894.1532448035@warthog.procyon.org.uk>
 <04b05dbd-0aa4-7789-1314-52108246291a@schaufler-ca.com>
 <1532497196.2688.65.camel@themaw.net>
From:   Casey Schaufler <casey@schaufler-ca.com>
Message-ID: <55bb8ed3-59b4-ca6e-5741-a7d5e4489a7c@schaufler-ca.com>
Date:   Wed, 25 Jul 2018 08:48:46 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <1532497196.2688.65.camel@themaw.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/24/2018 10:39 PM, Ian Kent wrote:
> On Tue, 2018-07-24 at 11:57 -0700, Casey Schaufler wrote:
>> On 7/24/2018 9:00 AM, David Howells wrote:
>>> Casey Schaufler <casey@schaufler-ca.com> wrote:
>>>
>>>>>  (1) Mount topology and reconfiguration change events.
>>>> With the possibility of unprivileged mounting you're going to have to
>>>> address access control on events.  If root in a user namespace mounts a
>>>> filesystem you may have a case where the "real" user wouldn't want the
>>>> listener to receive a notification.
>>> Can you clarify who the listener is in this case?
>> That would be anyone with a watchpoint set.
> And that process would have had the privilege to do so ...

Which isn't the point. The access control isn't on the watchpoint,
it's on delivering the event to the watchpoint. The access control
needs to be based on the process that created the event and the
process receiving the event.

>
>>> Note that mount topology events don't leak outside of the mount namespace
>>> they're generated in.
>>>
>>> That said, if you, a random user, put a watchpoint on "/" you can see the
>>> mount events triggered by another random user in the same mount
>>> namespace.  I
>>> don't see a way to control this except by resorting to the LSM since UNIX
>>> doesn't have 'notify' permission bits.
>> I would call that a write operation from the process that triggered
>> the watchpoint to the one watching it. Like a signal. Signals have a
>> rudimentary DAC policy (write only to the same UID) that could be
>> your model.
> I'm not sure signals are a good comparison.

In both cases you have one process sending information
to another. If you use killpg() instead of kill() you can
send to a number of processes without knowing them individually.
A process can chose what to do with (most) signals, including
ignore them.


> They can affect a process in significant ways whereas triggering
> a notification is less invasive so the security requirements
> should take that into consideration.

I'm looking at this from a security model viewpoint. If process
A sends information to process B that's a write operation with
A as the subject and B as the object. 

> But there is a problem here I think.
>
> How about the case where a user name space is created or entered
> without a newly created mount name space and mounts and umounts
> are done, the user name space necessarily expects the table of
> mounts it sees to be up to date.
>
> But, if the methods here are used by user space, say libmount
> was updated to use it, to gain the efficiency of not constantly
> re-reading the proc mount table then restrictions on notifications
> would mean the mount table seen in the user name space might not
> be updated and would no longer be correct.

Hey, I'm not the one saying that containers don't need/want kernel
manifestation. Of course you may have troubles with access consistency
if you go around changing the access control attributes with namespaces.
One of the problems with signals is that you can't chmod() your process
to allow signals from other specified users. If you don't design an
access control scheme into the watchpoint mechanism you aren't going to
be able to deal with situations like this.

> The converse is more interesting, where the user name space does
> create or enter a new mount name space, then libmount would see ???,
> probably not the updated mount information ... unless it opens a
> new file handle to get mount update information ... a long running
> daemon that uses libmount and dispenses or uses mount information
> would very likely have a problem ...
>
> The current proc file system method or providing the mount table
> forces a new file handle to be opened whenever getting the mount
> table so it always sees only the current mount name space mount
> table.
>
> At the very least I need to think more about this ...
>
>>> But for each event, I can associate an object label, derived from the
>>> source,
>>> and use f_cred on the notification queue to provide a subject label.
>> ... or UID or groups.
>>
>>>>>  (2) Superblocks EIO, ENOSPC and EDQUOT events (not complete yet).
>>>> Here, too. If SELinux (for example) policy says you can't see
>>>> anything on a filesystem you shouldn't get notifications about
>>>> things that happen to that filesystem.
>>> Yep.  Sounds like I need to refer that to the LSM as above.
>>>
>>> It's a bit easier for specifically nominated sb sources since you might only
>>> need to do the check once at sb_notify() time.  If there's a general queue
>>> that all sbs contribute to, however, then things become more complicated as
>>> the checks have to be done at do-we-write-into-this-queue? time.
>>>
>>>>>  (3) Key/keyring changes events
>>>> And again, I should only get notifications about keys and
>>>> keyrings I have access to.
>>> Currently, you can only watch keys that grant you View permission, which
>>> might
>>> suffice.
>> That seems appropriate.
>>
>>>> I expect that you intentionally left off
>>>>
>>>>    (4) User injected events
>>>>
>>>> at this point, but it's an obvious extension. That is going
>>>> to require access controls (remember kdbus) so I think you'd
>>>> do well to design them in now rather than have some security
>>>> module hack like me come along later and "fix" it. 
>>> Yeah - the thought had occurred to me, but there needs to be some way to
>>> define a 'source' and a way to connect them.  Also, would you want a general
>>> source that anyone can contribute through, specific sources where you have
>>> to
>>> directly connect or namespace-restricted sources?
>> My guess is that the consensus would be "Yes" to all the above.
>>
>>> David
>>>
>>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>

