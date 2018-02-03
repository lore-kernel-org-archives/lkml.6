Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1602359-1517684750-2-11920206787661683951
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='utf-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-api-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1517684749; b=AGjWR1lAZ5APO9OEThmlAo3s5c3kS8pw/Mt/Y+9QDB+IQeb
    IKSkLcIt5T659t0XH2Yecf0TE6u0Rzr1tUxPloCiONdE6Wld349abVHQkJwxDL8z
    lXe+ke01WJElSZNztuR27cGj3W6kcIJB9y5EG8o9EvDtQoaMF1swswKn0d65XfNz
    Do1X++FEzTPqbNZBZ+DbQxULneIvdD7AbO+oyv88/TGetuMsLaAL0w4X/psDEh2P
    ifH5BbKiR5QFMpnjsqCvNc2ys6OarjkSN+EvVJ9nu5RwIJ3p4XMSfpli/rJcQWRU
    i6HajXojXy/ygJWYJ/q2EC9RLXzNKZg0jOWTKTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=subject:to:cc:references:from:message-id
    :date:mime-version:in-reply-to:content-type
    :content-transfer-encoding:sender:list-id; s=arctest; t=
    1517684749; bh=etWJMotZOot2jOYhZ5TWvNYVps40GVnJq6mcrOWHufc=; b=U
    3AYmIxujYDpNYIXD4GK6ta7pFQ5OV2NClfEGbUiC2PMsIpdXSS7En3jbC7Zgq8Je
    44wM9Xrf5gQze4jR+B58hdcMRFg8kRXhjbJpirOkeVBMxHZaOB5nG9b6V0DvgB+q
    AdObvH4CbV6QBZ9i9wLMXFlkX0bCl2C98rVGPDHHY84cyxJ2UUoSogSThStcntMH
    N5KyeErB0JzNRrmT0GGxFuONhQdV0BzEVg0ikcul8LNUem97+UtiHdBEaJBTGiJp
    08RCyUubAJIXU9QfNLI6DCi3ZXNYtJfJWtuT56/f0UGReAFXCp3oAX8F4rP2Vc1b
    kUpZTmzxGiZMGpFve1azg==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered; 2048-bit rsa key sha256) header.d=yahoo.com header.i=@yahoo.com header.b=PzoHyIIh x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=s2048;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=schaufler-ca.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=schaufler-ca.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (body has been altered; 2048-bit rsa key sha256) header.d=yahoo.com header.i=@yahoo.com header.b=PzoHyIIh x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=s2048;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=schaufler-ca.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=schaufler-ca.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752894AbeBCTFc (ORCPT <rfc822;greg@kroah.com>);
        Sat, 3 Feb 2018 14:05:32 -0500
Received: from sonic310-20.consmr.mail.bf2.yahoo.com ([74.6.135.194]:38414
        "EHLO sonic310-20.consmr.mail.bf2.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752859AbeBCTF3 (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Sat, 3 Feb 2018 14:05:29 -0500
X-YMail-OSG: F7baoloVM1myCEmdL_WD7WuXjeZG2.XiWJX03AbeYUwZR2GJ.FnhMscFwX94jmL
 mYN8X0Ztj1RMSrL.2.P4SeEQ_qY28k_Xr0AEWCgBjbDABNEMLayDn6X63YFFtgwmRV79l9xK3iK4
 x7GmJxA8a9CkyhPJ8m1kFKdWGDAX49UU3PWVqDmKFDXxzSTe2kESv0VcnBeIsT2BzJ79G3cml7wC
 Vo_prc5IHycmMR9rtWMrJCHYc_Z0cM32gyehTQIh7CeRPoWiSHiEiQS0wx6b71bq6zQFv4p572fc
 IPNXpwMYW0Imks.hrfUKUs8hNon71J_z8LxsNJDLhYKyZcbM3tRkWNslhWXErEy1bjk8sgantDuV
 bTeVeJCVZjRDucn9NSZtxt3yyFjUkZSGkZKdP0brI81vpGKaBhngT36HTwvHmz.OE.zza49ngv.N
 uLt8BLqiOTH679Irx9wut1dyJt7PV1enCmlO4nt9XCMP5xp7aB3wO6k_iF6wryNf0rgAKBY1DZwl
 eg1dN0IhIU7l7nO7ay1E-
Subject: Re: RFC(V3): Audit Kernel Container IDs
To: Paul Moore <paul@paul-moore.com>, Simo Sorce <simo@redhat.com>
Cc: mszeredi@redhat.com, "Eric W. Biederman" <ebiederm@xmission.com>,
        jlayton@redhat.com, Richard Guy Briggs <rgb@redhat.com>,
        Linux API <linux-api@vger.kernel.org>,
        Linux Containers <containers@lists.linux-foundation.org>,
        Linux Kernel <linux-kernel@vger.kernel.org>,
        Eric Paris <eparis@parisplace.org>,
        David Howells <dhowells@redhat.com>,
        Carlos O'Donell <carlos@redhat.com>,
        Linux Audit <linux-audit@redhat.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Andy Lutomirski <luto@kernel.org>, cgroups@vger.kernel.org,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        trondmy@primarydata.com,
        Linux Network Development <netdev@vger.kernel.org>,
        "Serge E. Hallyn" <serge@hallyn.com>
References: <20180109121620.wi7dq2423ugsraqv@madcap2.tricolour.ca>
 <1515514736.3239.10.camel@redhat.com>
 <20180110070011.l4rcdcwb27witfem@madcap2.tricolour.ca>
 <CAHC9VhQ=hX55e7ftkVQCogTZTcdSm3rm-+YNOgWomabbXV_sKg@mail.gmail.com>
 <1517609946.13097.161.camel@redhat.com>
 <CAHC9VhTg0ocArSek03A-XrbjgR4iGeysxXWaA8HknKBD_5ZRkA@mail.gmail.com>
From: Casey Schaufler <casey@schaufler-ca.com>
Message-ID: <c6a1885d-0543-02dd-8760-0ae05f33d809@schaufler-ca.com>
Date: Sat, 3 Feb 2018 11:05:22 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <CAHC9VhTg0ocArSek03A-XrbjgR4iGeysxXWaA8HknKBD_5ZRkA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 2/2/2018 3:24 PM, Paul Moore wrote:
> On Fri, Feb 2, 2018 at 5:19 PM, Simo Sorce <simo@redhat.com> wrote:
>> On Fri, 2018-02-02 at 16:24 -0500, Paul Moore wrote:
>>> On Wed, Jan 10, 2018 at 2:00 AM, Richard Guy Briggs <rgb@redhat.com> wrote:
>>>> On 2018-01-09 11:18, Simo Sorce wrote:
>>>>> On Tue, 2018-01-09 at 07:16 -0500, Richard Guy Briggs wrote:
> ..
>
>>>> Paul, can you justify this somewhat larger inconvenience for some
>>>> relatively minor convenience on our part?
>>> Done in direct response to Simo.
>> Sorry but your response sounds more like waving away then addressing
>> them, the excuse being: we can't please everyone, so we are going to
>> please no one.
> I obviously disagree with the take on my comments but you're free to
> your opinion.
>
> I believe saying we are pleasing no one isn't really fair now is it?
> Is there any type of audit container ID now?  How would you go about
> associating audit events with containers now? (spoiler alert: it ain't
> pretty, and there are gaps I don't believe you can cover)  This
> proposal provides a mechanism to do this in a way that isn't tied to
> any one particular concept of a container and is manageable inside the
> kernel.
>
> If you have a need to track audit events for containers, I find it
> extremely hard to believe that you are not at least partially pleased
> by the solutions presented here.  It may not be everything on your
> wishlist, but when did you ever get *everything* on your wishlist?

I am going to back Paul 100% on this point. The container
community's emphatic position that containers are strictly
a user-space construct makes it impossible for the kernel
to provide any data more sophisticated than an integer, and
any processing based on that data cleverer than a check
for equality.


>>> But to be clear Richard, we've talked about this a few times, it's not
>>> a "minor convenience" on our part, it's a pretty big convenience once
>>> we starting having to route audit events and make decisions based on
>>> the audit container ID information.  Audit performance is less than
>>> awesome now, I'm working hard to not make it worse.
>> Sounds like a security vs performance trade off to me.

Without the kernel having a "container" policy to work with there
is no "security" it can possibly enforce.

> Welcome to software development.  It's generally a pretty terrible
> hobby and/or occupation, but we make up for it with long hours and
> endless frustration.
>
>>>> u64 vs u128 is easy for us to
>>>> accomodate in terms of scalar comparisons.  It doubles the information
>>>> in every container id field we print in audit records.
>>> ... and slows down audit container ID checks.
>> Are you saying a cmp on a u128 is slower than a comparison on a u64 and
>> this is something that will be noticeable ?
> Do you have a 128 bit system?  I don't.  I've got a bunch of 64 bit
> systems, and a couple of 32 bit systems too.  People that use audit
> have a tendency to really hammer on it, to the point that we get
> performance complaints on a not infrequent basis.  I don't know the
> exact number of times we are going to need to check the audit
> container ID, but it's reasonable to think that we'll expose it as a
> filter-able field which adds a few checks, we'll use it for record
> routing so that's a few more, and if we're running multiple audit
> daemons we will probably want to include LSM checks which could result
> in a few more audit container ID checks.  If it was one comparison I
> wouldn't be too worried about it, but the point I'm trying to make is
> that we don't know what the implementation is going to look like yet
> and I suspect this ID is going to be leveraged in several places in
> the audit subsystem and I would much rather start small to save
> headaches later.
>
> We can always expand the ID to a larger integer at a later date, but
> we can't make it smaller.
>
>>>> A c36 is a bigger step.
>>> Yeah, we're not doing that, no way.
>> Ok, I can see your point though I do not agree with it.
>>
>> I can see why you do not want to have arbitrary length strings, but a
>> u128 sounded like a reasonable compromise to me as it has enough room
>> to be able to have unique cluster-wide IDs which a u64 definitely makes
>> a lot harder to provide w/o tight coordination.
> I originally wanted it to be a 32-bit integer, but Richard managed to
> talk me into 64-bits, that was my compromise :)
>
> As I said earlier, if you are doing container auditing you're going to
> need coordination with the orchestrator, regardless of the audit
> container ID size.
>

