Return-Path: <luto@kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3985151-1523501676-2-7192211459335680694
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='198.145.29.99', Host='mail.kernel.org', Country='US', FromHeader='org',
  MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: luto@kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523501675; b=H4TYCZPAgsuWpK/VnsxnHwxm8Iq28L2cBSrk2ZK/AE41u4ueb1
    WG5nNWpJ3CMopZF5ljubrg5MKeX4lXNH1ZZXn9YZrmssoC9q8pxfVYAufB0SX+FW
    6aGavA0JiwMoBzsCInxOFakbcDV2wQudVNr++gr0Mvh9xGwQ6IdWORUl667/KzoX
    5rhL2BzUgbG0yiua8rpLxFtH3dj+UojQ9RyUrOpxg4F0xJil2iqPZjZ0l07/fEgi
    OlNSt8W/4/Q1UFl3iUHidKCB79O0acH8plRwyiY6qI1ybvj0+uw4WjFYvLhfSlsb
    sBnckClfSmWa93DGBZLE2tMyhcC6sf/CqMlA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=mime-version:in-reply-to:references:from
    :date:message-id:subject:to:cc:content-type; s=fm2; t=
    1523501675; bh=keILaNApjCnc9gxDGimcE2fk9TP/mTp8ZzCol2vsYIs=; b=J
    L+CCIppRSTqhmWEcNXj01dNI7Qbxa4yIs5rplwEAX4Ea35r/guGkm/aPFvHgX+CR
    i87v6bq+Z6vhc6f837f6fFZLOZnf9hfiqwZwuOYYwDASc5S7+L+vHEHAAF/Shr85
    2KoxQPCz7557m4dlcbhRheDXOYbJc9FH2Up0Vfm9dLfqf26n2a1Sy+McMleVkDks
    b++vlCoiCf786ey3zsF6SGC6R9/EpqBunhUaiwy879Td2xQLTdrYV4vt0qewMkGd
    m5pt9PUmmw6zSFCSOpLkspSsL1G0gXaBPJ3KI1NfP0oojEUd/rsXwF+wswWEq4x6
    0H8WpvVCym4ZlVzehKmNg==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=198.145.29.99 (mail.kernel.org);
    spf=none smtp.mailfrom=luto@kernel.org smtp.helo=mail.kernel.org;
    x-aligned-from=pass (Address match);
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=mail.kernel.org x-ptr-lookup=mail.kernel.org;
    x-return-mx=pass smtp.domain=kernel.org smtp.result=pass smtp_is_org_domain=yes header.domain=kernel.org header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=-100 state=0
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=198.145.29.99 (mail.kernel.org);
    spf=none smtp.mailfrom=luto@kernel.org smtp.helo=mail.kernel.org;
    x-aligned-from=pass (Address match);
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=mail.kernel.org x-ptr-lookup=mail.kernel.org;
    x-return-mx=pass smtp.domain=kernel.org smtp.result=pass smtp_is_org_domain=yes header.domain=kernel.org header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfB+stbbBEZicZrzASBKfq5QMhEFFwi01p8YUqJxsVW/Ww4jYP048I4PUM4js6IOdW1GJqvUIQM1I/ZKWgbZq8AbcbRwm47xoABJAiUZE1A4f8M2RLJDi
    tBruquDqnl1d9VdHdmTNZ/K4+k37UV21S86hsoheOUAEJdDIs0J9/2+7wpPQhJafN2g6rgQDWYAlfw==
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=czNdAM+YcK12vDHDihaDnQ==:117
    a=czNdAM+YcK12vDHDihaDnQ==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=2C6YHBdLAAAA:8 a=Qgar3t5BIKeim6H2_C4A:9 a=QEXdDO2ut3YA:10
    a=yxGMNg53M24zlVSZdvMH:22
X-ME-CMScore: 0
X-ME-CMCategory: none
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5799A2183C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=luto@kernel.org
X-Google-Smtp-Source: AIpwx49oxT/e6M6vllhYPzr029L25xjwCn4LAVUJC1Ddgxk4AqpE8cTV7IXjgajicP49sNTXgy8VhE/wCapcvr/Shz4=
MIME-Version: 1.0
In-Reply-To: <20180411203308.GA10167@kroah.com>
References: <20180411195436.GA7126@kroah.com> <152346387861.4030.4408662483445703127.stgit@warthog.procyon.org.uk>
 <152346403637.4030.15247096217928429102.stgit@warthog.procyon.org.uk>
 <12769.1523477356@warthog.procyon.org.uk> <20180411203308.GA10167@kroah.com>
From: Andy Lutomirski <luto@kernel.org>
Date: Wed, 11 Apr 2018 19:54:12 -0700
X-Gmail-Original-Message-ID: <CALCETrWynogzZcaKMLWKce1rMvAC_sViReBDyiEWL-rm21HvAg@mail.gmail.com>
Message-ID: <CALCETrWynogzZcaKMLWKce1rMvAC_sViReBDyiEWL-rm21HvAg@mail.gmail.com>
Subject: Re: [PATCH 24/24] debugfs: Restrict debugfs when the kernel is locked down
To: Greg KH <greg@kroah.com>
Cc: David Howells <dhowells@redhat.com>, Linus Torvalds <torvalds@linux-foundation.org>,
	linux-man <linux-man@vger.kernel.org>, Linux API <linux-api@vger.kernel.org>,
	James Morris <jmorris@namei.org>, LKML <linux-kernel@vger.kernel.org>,
	LSM List <linux-security-module@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, Apr 11, 2018 at 1:33 PM, Greg KH <greg@kroah.com> wrote:
> On Wed, Apr 11, 2018 at 09:09:16PM +0100, David Howells wrote:
>> Greg KH <greg@kroah.com> wrote:
>>
>> > Why not just disable debugfs entirely?  This half-hearted way to sorta
>> > lock it down is odd, it is meant to not be there at all, nothing in your
>> > normal system should ever depend on it.
>> >
>> > So again just don't allow it to be mounted at all, much simpler and more
>> > obvious as to what is going on.
>>
>> Yeah, I agree - and then I got complaints because it seems that it's been
>> abused to allow drivers and userspace components to communicate.
>
> With in-kernel code?  Please let me know and I'll go fix it up to not
> allow that, as that is not ok.
>
> I do know of some bad examples of out-of-tree code abusing debugfs to do
> crazy things (battery level monitoring?), but that's their own fault...
>
> debugfs is for DEBUGGING!  For anything you all feel should be "secure",
> then just disable it entirely.
>

Debugfs is very, very useful for, ahem, debugging.  I really think
this is an example of why we should split lockdown into the read and
write varieties and allow mounting and reading debugfs when only write
is locked down.
