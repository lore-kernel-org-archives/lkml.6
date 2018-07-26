Return-Path: <SRS0=7Z+k=KK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE82EC28CF6
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 16:09:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 43FA820846
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 16:09:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="gCY1G4oM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 43FA820846
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732008AbeGZR1M (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Jul 2018 13:27:12 -0400
Received: from sonic306-26.consmr.mail.gq1.yahoo.com ([98.137.68.89]:39703
        "EHLO sonic306-26.consmr.mail.gq1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730781AbeGZR1M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jul 2018 13:27:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1532621380; bh=mikvlqS6U5jMOW+V+RzFG8RMhj3mwBuU/T2nCuGf4DQ=; h=Subject:To:Cc:References:From:Date:In-Reply-To:From:Subject; b=gCY1G4oMX6E/0iwDUdL6g+2CfGuWFdEPOh6J0frxFLO04OZtKJsJ/ADVA284B6LozDHOFy2a23Wp5EnoMOVDjZL9TY5ThAaAFcG6uvdlc1/cmUKiE3fyVjZm0iT/6FgoiTI3TRu29ZgEuSrQnOnPJvvyrFsVeVmR8/PrJm0pUJ19WVsLiq4i03IBAMiu4FvmBVIS/Mn2lLcDEkP38K3sbpiaE3Azvrkh4Hp/Alzl/ooMsxAS5sEOy8M3NVmA2LPAwim38zG/UN+AGA20DvKjpoGnIEQbTCzUavFSGBsmMbjO3Oy4ahMmpwux/bO0KiNDpqltKtrXPFXifvKRzCju5A==
X-YMail-OSG: dhrVGs0VM1lm29Obvsv.RVB3iJgt1uycihvstXIGSq31ml9Gunwj_.wPmJkFWzi
 cgMgXDpd5Z0sogVjm2rVzZeN42s5lj6IyGN0iEcEbWLX7ElNHLWaZZF5LpSfzww4.ZEhTxgtkaqE
 v7rR084Ved1xoOup3VHhjcXg6dCDMnlyMys9qOc7tTon4pcr38XTaqgumO1UBeoeWDGEMXfVyi4k
 PR_P21dZDNwCIFJx7MAfHOEQeYElSOZu2gav9T82FZhZgE6MUtCIwGvTGYm.4Fk2L3.4hWdqKeEe
 0wrlse86R1MR1A70EGywtLibfUiCGYDqtq8mfsEymB982pVhj3Ih_eVSpQG2AIy.f5budOLdlyrt
 Ot_wVpGAHO4UY9QZqPkZokWVf1x8PwbrTw0GmLSSa3fA_Rqc_w61IydVsj6AUhJYYrS5ZoIN5L1A
 HcJbeV7y.2Ca66iH_wSf78BemqxT6R9sTkn1gIcyQvo52axaq__qDt.cgqCzVdV6JV3OaVTAdT.N
 lHMoPc0FoF6fjWbTmWqHgjAIz7nQzw4UZLY61IrDI3sDYxIf6wqhIWbqBEeBS4uW4lzQPD3xwugL
 sjhj1wIb_ghqWTeNPTw1Ng9YHtSwUmCUqxAgwHZCqzo4LEi0uRW4Yx6NgBLlvY5OOO8DrSTJYt8O
 .Kp.3kNMLgR0RUDsOoou6KhRFzYi8ZkwoV5jHzebQiKxQ2myWZGWudqBTVmjlaJtrphEMAiUM5lh
 IHu82JPHVe2_y_XDxIKe00dlFcrzzW3aTiXTQ2ztdsSJVB_emww.4tElsFT.V5M.wDYs4wfo6LXJ
 rRBS.UKE7TU8fFm6N2rfRqANIwNC3VzncsKulNI507kgj4s3bKY2wwJTidhyHfndUQE1zGkpt5Bv
 PWdswC.jgB.k1y1q9yDFbXI5ecNNsLqa6ls5k5m0hUlkSOTAs_uncHbI2D6oqM7tkLZ6OdzXfUuU
 J4ox3.UeGsJRN4AqaJFGu6_5QOF1W0NaQJ_uwB_xABhOdR_0R3zI7UOyh8Vd4Llpyx5nSXLbmZNY
 TsLKT2f0Z4eI8PPctqJBHWEFmrJYEiocE4HE-
Received: from sonic.gate.mail.ne1.yahoo.com by sonic306.consmr.mail.gq1.yahoo.com with HTTP; Thu, 26 Jul 2018 16:09:40 +0000
Received: from c-67-169-65-224.hsd1.ca.comcast.net (EHLO [192.168.0.104]) ([67.169.65.224])
          by smtp419.mail.gq1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID e17b38d0a128ab5c48cd2b05283ae4ed;
          Thu, 26 Jul 2018 16:09:39 +0000 (UTC)
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
 <55bb8ed3-59b4-ca6e-5741-a7d5e4489a7c@schaufler-ca.com>
 <1532567914.2939.23.camel@themaw.net>
From:   Casey Schaufler <casey@schaufler-ca.com>
Message-ID: <33d22828-7384-dca4-ed4c-3425ef321499@schaufler-ca.com>
Date:   Thu, 26 Jul 2018 09:09:36 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <1532567914.2939.23.camel@themaw.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/25/2018 6:18 PM, Ian Kent wrote:
> On Wed, 2018-07-25 at 08:48 -0700, Casey Schaufler wrote:
>> On 7/24/2018 10:39 PM, Ian Kent wrote:
>>> On Tue, 2018-07-24 at 11:57 -0700, Casey Schaufler wrote:
>>>> On 7/24/2018 9:00 AM, David Howells wrote:
>>>>> Casey Schaufler <casey@schaufler-ca.com> wrote:
>>>>>
>>>>>>>  (1) Mount topology and reconfiguration change events.
>>>>>> With the possibility of unprivileged mounting you're going to have to
>>>>>> address access control on events.  If root in a user namespace mounts
>>>>>> a
>>>>>> filesystem you may have a case where the "real" user wouldn't want the
>>>>>> listener to receive a notification.
>>>>> Can you clarify who the listener is in this case?
>>>> That would be anyone with a watchpoint set.
>>> And that process would have had the privilege to do so ...
>> Which isn't the point. The access control isn't on the watchpoint,
>> it's on delivering the event to the watchpoint. The access control
>> needs to be based on the process that created the event and the
>> process receiving the event.
>>
>>>>> Note that mount topology events don't leak outside of the mount
>>>>> namespace
>>>>> they're generated in.
>>>>>
>>>>> That said, if you, a random user, put a watchpoint on "/" you can see
>>>>> the
>>>>> mount events triggered by another random user in the same mount
>>>>> namespace.  I
>>>>> don't see a way to control this except by resorting to the LSM since
>>>>> UNIX
>>>>> doesn't have 'notify' permission bits.
>>>> I would call that a write operation from the process that triggered
>>>> the watchpoint to the one watching it. Like a signal. Signals have a
>>>> rudimentary DAC policy (write only to the same UID) that could be
>>>> your model.
>>> I'm not sure signals are a good comparison.
>> In both cases you have one process sending information
>> to another. If you use killpg() instead of kill() you can
>> send to a number of processes without knowing them individually.
>> A process can chose what to do with (most) signals, including
>> ignore them.
> I'm just saying that the analogy isn't quite the same.
>
> In the this case notifications can't be just sent by a process,
> it's entirely controlled by the VFS so the notion of some process
> doing something out-off-band doesn't apply.

If process A does something that sends information to process B
it doesn't matter whether it's explicit (e.g. kill) or implicit
(e.g. exit), you need to have control over the delivery. I can
send Morse code to a listener of mount watchpoints using the
mechanism described. If I'm not supposed to be sending information
to that other user (for whatever reason) that's bad.


>
>>> They can affect a process in significant ways whereas triggering
>>> a notification is less invasive so the security requirements
>>> should take that into consideration.
>> I'm looking at this from a security model viewpoint. If process
>> A sends information to process B that's a write operation with
>> A as the subject and B as the object. 
> Perhaps, but again there's no process A deciding to send something.

It doesn't matter whether it's intentional. It's information flow.

> It's the VFS saying to itself, I see this thing has changed, someone
> that had appropriate privilege asked me to tell it so ...

The VFS doesn't do things on it's own. It isn't a subject. It's a
hunk of code that does what it's told *by processes*.

> I may be wrong but there isn't a similar access control mechanism
> on the proc file system mount table (pseudo) files, only the usual
> access control on opening them and what is seen is based on the
> mount name space of the opening process.

You need access to file entry in /proc. That's my point,
there has to be some mechanism for control. The watchpoint
mechanism proposed offers no way to do chmod 600 on events
that a process can generate.

> This is also not quite as what we have here but it is similar.

The proposed mechanism offers no way for a process to say
"I don't want events about what I do sent to Ian" or for
SELinux to say "Don't send this event to processes marked
unconfined_t. They're all a bunch of squares".

>>> But there is a problem here I think.
>>>
>>> How about the case where a user name space is created or entered
>>> without a newly created mount name space and mounts and umounts
>>> are done, the user name space necessarily expects the table of
>>> mounts it sees to be up to date.
>>>
>>> But, if the methods here are used by user space, say libmount
>>> was updated to use it, to gain the efficiency of not constantly
>>> re-reading the proc mount table then restrictions on notifications
>>> would mean the mount table seen in the user name space might not
>>> be updated and would no longer be correct.
>> Hey, I'm not the one saying that containers don't need/want kernel
>> manifestation. Of course you may have troubles with access consistency
>> if you go around changing the access control attributes with namespaces.
>> One of the problems with signals is that you can't chmod() your process
>> to allow signals from other specified users. If you don't design an
>> access control scheme into the watchpoint mechanism you aren't going to
>> be able to deal with situations like this.
> Don't get me wrong, I'm not criticizing your suggestion that
> some sort of security model is needed.

OK, that's good. :)

> I'm saying it's not straight forward to work out what's actually
> needed and, in thinking about it, I ended up described an additional
> potential problem that's not even (necessarily) security related.

Let me propose a model that shouldn't be too hard to implement
and that is somewhat consistent with existing Linux policies.

When an event is generated the current cred is included in the
message. A filter type is supported that uses the cred information.
The default value for this filter (or if it is absent) is to
deny access to everyone except the owner of the watching process,
just like signals. A process with CAP_DAC_OVERRIDE (or similar),
can change the filter to accept events from other users. The filter
code includes a call

	rc = security_watchpoint_event(struct cred *sender);

so that security modules can decide if the sender is allowed to
write the event to this watcher.

If we want event generators to be in control of who sees what they're
doing it's a bit more complicated. You'll have to add the access
information to the cred so that it gets passed along to the filtering
code. You could pass it in addition to the cred if that's cleaner.
In that case the filter is hard coded and gets the permission from
the sender.

Neither of these should be especially difficult to implement or explain.

>>> The converse is more interesting, where the user name space does
>>> create or enter a new mount name space, then libmount would see ???,
>>> probably not the updated mount information ... unless it opens a
>>> new file handle to get mount update information ... a long running
>>> daemon that uses libmount and dispenses or uses mount information
>>> would very likely have a problem ...
>>>
>>> The current proc file system method or providing the mount table
>>> forces a new file handle to be opened whenever getting the mount
>>> table so it always sees only the current mount name space mount
>>> table.
>>>
>>> At the very least I need to think more about this ...
>>>
>>>>> But for each event, I can associate an object label, derived from the
>>>>> source,
>>>>> and use f_cred on the notification queue to provide a subject label.
>>>> ... or UID or groups.
>>>>
>>>>>>>  (2) Superblocks EIO, ENOSPC and EDQUOT events (not complete yet).
>>>>>> Here, too. If SELinux (for example) policy says you can't see
>>>>>> anything on a filesystem you shouldn't get notifications about
>>>>>> things that happen to that filesystem.
>>>>> Yep.  Sounds like I need to refer that to the LSM as above.
>>>>>
>>>>> It's a bit easier for specifically nominated sb sources since you might
>>>>> only
>>>>> need to do the check once at sb_notify() time.  If there's a general
>>>>> queue
>>>>> that all sbs contribute to, however, then things become more complicated
>>>>> as
>>>>> the checks have to be done at do-we-write-into-this-queue? time.
>>>>>
>>>>>>>  (3) Key/keyring changes events
>>>>>> And again, I should only get notifications about keys and
>>>>>> keyrings I have access to.
>>>>> Currently, you can only watch keys that grant you View permission, which
>>>>> might
>>>>> suffice.
>>>> That seems appropriate.
>>>>
>>>>>> I expect that you intentionally left off
>>>>>>
>>>>>>    (4) User injected events
>>>>>>
>>>>>> at this point, but it's an obvious extension. That is going
>>>>>> to require access controls (remember kdbus) so I think you'd
>>>>>> do well to design them in now rather than have some security
>>>>>> module hack like me come along later and "fix" it. 
>>>>> Yeah - the thought had occurred to me, but there needs to be some way to
>>>>> define a 'source' and a way to connect them.  Also, would you want a
>>>>> general
>>>>> source that anyone can contribute through, specific sources where you
>>>>> have
>>>>> to
>>>>> directly connect or namespace-restricted sources?
>>>> My guess is that the consensus would be "Yes" to all the above.
>>>>
>>>>> David
>>>>>
>>> --
>>> To unsubscribe from this list: send the line "unsubscribe linux-security-
>>> module" in
>>> the body of a message to majordomo@vger.kernel.org
>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>>
>>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>

