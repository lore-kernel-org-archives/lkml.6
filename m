Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3568581-1517613913-2-11618195771983631039
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-api-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1517613912; b=DNkQal3JdaMcwXyQHGJLAsB+OX0Ola3B/6FVHDZbAkoPFu+
    nGVRI6PhvLeizOFsj+qu60RMhMJ/pFMC9CGKJsy15Qu3sWF1yfZ2IZyjy50iYesC
    UpTLMYRCyUKYaWJSjsfWopGb/Y59BikORzo7mdwG7uETG1scjIJ9K9iBI+0PaMnY
    QrTeke/ecjlPqgBDWCVyhIhCxoVY7bEEM/b8K3dSvGiImXrXy0YfeqqlotNNsP1x
    NN4jDIwYrKlry4Dr4jr+gy4oeVgRQ1+fRe1LcH8vYgjS+FbPomkYSxCtXlU/1thH
    gmkUn/Kx96np4HOyALcMA2XejTvQ0qWRzo4fwCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=mime-version:in-reply-to:references:from
    :date:message-id:subject:to:cc:content-type:sender:list-id; s=
    arctest; t=1517613912; bh=8GkAAc/4rjh14/xPxrBWlJnDv7CNXPF0Q/Gq4J
    ab8Ks=; b=TlxOMF6NP+4L/1DoWA+TEIuhNhmdLNSB7U1Si7qocBamtFh3MuPvFW
    pbliwy9XhEBoZ+UIGcqUfKbcOFYYVO3D6S14bIPjihsdnRbtjz8fKAWnUEeb9LKt
    c/atXFwlHayMsZsTj36pTNNUCO/l1NSCRVOMkZwK2/O2TFONuHgGfUgc6afUn0yO
    Jaj0CG8pe49Rj2eEbUf6PfGTZKhvQjE5Ax2DYirK3K26QUrlbnqaOEnhUyu2lYM+
    cMG/p91McscBGSnZI6svhHei78Q/LLSsdMQ3weafDYbETXCHghtw0zgbiJjMJZtT
    hzbuozr1oifrN/QHEczByiucr1VgXkkg==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered; 2048-bit rsa key sha256) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b=GWPL1a8J x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20150623;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=paul-moore.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-google-dkim=fail (body has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=ciqK5+P1;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=paul-moore.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (body has been altered; 2048-bit rsa key sha256) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b=GWPL1a8J x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20150623;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=paul-moore.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-google-dkim=fail (body has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=ciqK5+P1;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=paul-moore.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752538AbeBBXYw (ORCPT <rfc822;greg@kroah.com>);
        Fri, 2 Feb 2018 18:24:52 -0500
Received: from mail-lf0-f46.google.com ([209.85.215.46]:46519 "EHLO
        mail-lf0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752518AbeBBXYu (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Fri, 2 Feb 2018 18:24:50 -0500
X-Google-Smtp-Source: AH8x225HN9kccgz1HP8qRGn+rmeboEK27FvQeOVsvKghTMTYPLwObmSDsdHYLWMPQk1nrQOG4dUQQ5iLZRv+rasfKXg=
MIME-Version: 1.0
X-Originating-IP: [108.20.156.165]
In-Reply-To: <1517609946.13097.161.camel@redhat.com>
References: <20180109121620.wi7dq2423ugsraqv@madcap2.tricolour.ca>
 <1515514736.3239.10.camel@redhat.com> <20180110070011.l4rcdcwb27witfem@madcap2.tricolour.ca>
 <CAHC9VhQ=hX55e7ftkVQCogTZTcdSm3rm-+YNOgWomabbXV_sKg@mail.gmail.com> <1517609946.13097.161.camel@redhat.com>
From: Paul Moore <paul@paul-moore.com>
Date: Fri, 2 Feb 2018 18:24:47 -0500
Message-ID: <CAHC9VhTg0ocArSek03A-XrbjgR4iGeysxXWaA8HknKBD_5ZRkA@mail.gmail.com>
Subject: Re: RFC(V3): Audit Kernel Container IDs
To: Simo Sorce <simo@redhat.com>
Cc: Richard Guy Briggs <rgb@redhat.com>,
        David Howells <dhowells@redhat.com>, cgroups@vger.kernel.org,
        jlayton@redhat.com, trondmy@primarydata.com,
        "Serge E. Hallyn" <serge@hallyn.com>, mszeredi@redhat.com,
        Al Viro <viro@zeniv.linux.org.uk>,
        Andy Lutomirski <luto@kernel.org>,
        Eric Paris <eparis@parisplace.org>,
        "Carlos O'Donell" <carlos@redhat.com>,
        Linux API <linux-api@vger.kernel.org>,
        Linux Containers <containers@lists.linux-foundation.org>,
        Linux Kernel <linux-kernel@vger.kernel.org>,
        Linux Audit <linux-audit@redhat.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Linux Network Development <netdev@vger.kernel.org>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Fri, Feb 2, 2018 at 5:19 PM, Simo Sorce <simo@redhat.com> wrote:
> On Fri, 2018-02-02 at 16:24 -0500, Paul Moore wrote:
>> On Wed, Jan 10, 2018 at 2:00 AM, Richard Guy Briggs <rgb@redhat.com> wrote:
>> > On 2018-01-09 11:18, Simo Sorce wrote:
>> > > On Tue, 2018-01-09 at 07:16 -0500, Richard Guy Briggs wrote:

...

>> > Paul, can you justify this somewhat larger inconvenience for some
>> > relatively minor convenience on our part?
>>
>> Done in direct response to Simo.
>
> Sorry but your response sounds more like waving away then addressing
> them, the excuse being: we can't please everyone, so we are going to
> please no one.

I obviously disagree with the take on my comments but you're free to
your opinion.

I believe saying we are pleasing no one isn't really fair now is it?
Is there any type of audit container ID now?  How would you go about
associating audit events with containers now? (spoiler alert: it ain't
pretty, and there are gaps I don't believe you can cover)  This
proposal provides a mechanism to do this in a way that isn't tied to
any one particular concept of a container and is manageable inside the
kernel.

If you have a need to track audit events for containers, I find it
extremely hard to believe that you are not at least partially pleased
by the solutions presented here.  It may not be everything on your
wishlist, but when did you ever get *everything* on your wishlist?

>> But to be clear Richard, we've talked about this a few times, it's not
>> a "minor convenience" on our part, it's a pretty big convenience once
>> we starting having to route audit events and make decisions based on
>> the audit container ID information.  Audit performance is less than
>> awesome now, I'm working hard to not make it worse.
>
> Sounds like a security vs performance trade off to me.

Welcome to software development.  It's generally a pretty terrible
hobby and/or occupation, but we make up for it with long hours and
endless frustration.

>> > u64 vs u128 is easy for us to
>> > accomodate in terms of scalar comparisons.  It doubles the information
>> > in every container id field we print in audit records.
>>
>> ... and slows down audit container ID checks.
>
> Are you saying a cmp on a u128 is slower than a comparison on a u64 and
> this is something that will be noticeable ?

Do you have a 128 bit system?  I don't.  I've got a bunch of 64 bit
systems, and a couple of 32 bit systems too.  People that use audit
have a tendency to really hammer on it, to the point that we get
performance complaints on a not infrequent basis.  I don't know the
exact number of times we are going to need to check the audit
container ID, but it's reasonable to think that we'll expose it as a
filter-able field which adds a few checks, we'll use it for record
routing so that's a few more, and if we're running multiple audit
daemons we will probably want to include LSM checks which could result
in a few more audit container ID checks.  If it was one comparison I
wouldn't be too worried about it, but the point I'm trying to make is
that we don't know what the implementation is going to look like yet
and I suspect this ID is going to be leveraged in several places in
the audit subsystem and I would much rather start small to save
headaches later.

We can always expand the ID to a larger integer at a later date, but
we can't make it smaller.

>> > A c36 is a bigger step.
>>
>> Yeah, we're not doing that, no way.
>
> Ok, I can see your point though I do not agree with it.
>
> I can see why you do not want to have arbitrary length strings, but a
> u128 sounded like a reasonable compromise to me as it has enough room
> to be able to have unique cluster-wide IDs which a u64 definitely makes
> a lot harder to provide w/o tight coordination.

I originally wanted it to be a 32-bit integer, but Richard managed to
talk me into 64-bits, that was my compromise :)

As I said earlier, if you are doing container auditing you're going to
need coordination with the orchestrator, regardless of the audit
container ID size.

-- 
paul moore
www.paul-moore.com
