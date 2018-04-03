Return-Path: <linux-efi-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1905978-1522772812-2-625609335972731625
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: linux@kroah.com
X-Delivered-to: linux@kroah.com
X-Mail-from: linux-efi-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1522772812; b=CfR2LwPD/9nLmuj+l0ybZZ+ha9CN+0klj5YGA1Buo9wgyXKvpk
    tvG7HhIZFlMjAojRh/1iUVPZveGHy/cOjbwlVjEjitUkMixsc2N5J+kxQGvokJkP
    sVjdPhB8UgmqSRgmc4MXfzC9B5XDuJl4s/WmnFdEPj8Cdf1YKeLZ3B1d3JEB7I0h
    Es5rN6/pl2q3Dy2JI6b3gB+OBoQ26wdAvwuVdF7bSOfJAwxdauR+nUUHcQOG3af0
    5FBTcSxI4k/Mj+5CZjhuXT8ojsOraub4OwjT/SDrQEvsfm3zLH6MFllUqI+Pg9lo
    n1Dr45NHwSKtPqrxwmKCJVFwsZ9MhTEs7vCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=mime-version:in-reply-to:references:from
    :date:message-id:subject:to:cc:content-type:sender:list-id; s=
    fm2; t=1522772812; bh=bkeTj3bUkScbo+xX4c+iHplaDxsBo52mJMblMxdC0/
    o=; b=SRK/xOlS4Q9F6qX1z4K0jv/7YJihwFXnRlSTelHCyyqdSPccOkfXVlx9Yw
    dajM7rxJgHeqd4oAVtH6NExwDGEHa+5OPtgDXW71oFJe1PXnKUfyat2VfOoNcWU2
    yRABivFE7e8Ej5TchTwiv7RGRUXuMgb/5Swq5sxs2KZOeavRtcF2/y7qAlVs/XOz
    HQMALIq9PbJjHILzTYP2I6E3hph22QG0eoDJu6BXEDc1rlNXri7X8EpNbhbSJVrC
    C5ORnFP70I9BMphBvb352QSxWXeUKPeNVmxlXaCA3V8e7OfTcuhC7bSiBfRrTKuL
    E2G05s/SbrO3RrsSMBocy2uEZDWg==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-efi-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=orgdomain_pass (Domain org match);
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=kernel.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-efi-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=orgdomain_pass (Domain org match);
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=kernel.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfFYL+084byyc402rAew7iMudM7RxfMwN8qRFYmwnSf/mj6xJmyTzaHOBQM+UHE7euPkq7FDp48e4X9ihPEez6FQEokjoKc2zafvzrRuI+37kaCPYmOTB
    SBUyC/Br/gUbw6nUbhCxC3q7FNIMAFc7ZcB/TjNHGZ9J3yMFsyiWacVHLkOCCjIYOOeepqg7xpy1OdnqpW/ypK+mE+nkPiQbaTCNer0i8bBcLNj6GW9XusY6
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=pGLkceISAAAA:8 a=VwQbUJbxAAAA:8 a=BkHumz7Idt46OS9E1LIA:9 a=QEXdDO2ut3YA:10
    a=x8gzFH9gYPwA:10 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751469AbeDCQ0t (ORCPT <rfc822;linux@kroah.com>);
        Tue, 3 Apr 2018 12:26:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:48628 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751461AbeDCQ0r (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Tue, 3 Apr 2018 12:26:47 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 46B3E2183E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=luto@kernel.org
X-Google-Smtp-Source: AIpwx48FZM038FZSaccMttD0eyaOLhHpsjlAhL5HCqzz82Omov3qvgZO/nV+GoEoXOEP9XBQeK63CgeoH4eB6W3KDRQ=
MIME-Version: 1.0
In-Reply-To: <20180403154156.f37wrzjhuvijzi2i@ast-mbp.dhcp.thefacebook.com>
References: <4136.1522452584@warthog.procyon.org.uk> <alpine.LRH.2.21.1803311145180.7769@namei.org>
 <186aeb7e-1225-4bb8-3ff5-863a1cde86de@kernel.org> <30459.1522739219@warthog.procyon.org.uk>
 <CALCETrUFOdrH5ShCCd8yguGjC2NtG8fJY7AW26HH467-02UVGA@mail.gmail.com> <20180403154156.f37wrzjhuvijzi2i@ast-mbp.dhcp.thefacebook.com>
From: Andy Lutomirski <luto@kernel.org>
Date: Tue, 3 Apr 2018 09:26:26 -0700
X-Gmail-Original-Message-ID: <CALCETrX3D3jrr=Vq70H+ttdCKSevU-cC-cvZrfaoahEQoO7wzA@mail.gmail.com>
Message-ID: <CALCETrX3D3jrr=Vq70H+ttdCKSevU-cC-cvZrfaoahEQoO7wzA@mail.gmail.com>
Subject: Re: [GIT PULL] Kernel lockdown for secure boot
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Andy Lutomirski <luto@kernel.org>,
        David Howells <dhowells@redhat.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        James Morris <jmorris@namei.org>,
        One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Matthew Garrett <mjg59@google.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Justin Forbes <jforbes@redhat.com>,
        linux-man <linux-man@vger.kernel.org>, joeyli <jlee@suse.com>,
        LSM List <linux-security-module@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        Kees Cook <keescook@chromium.org>,
        linux-efi <linux-efi@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-efi-owner@vger.kernel.org
X-Mailing-List: linux-efi@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, Apr 3, 2018 at 8:41 AM, Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
> On Tue, Apr 03, 2018 at 08:11:07AM -0700, Andy Lutomirski wrote:
>> >
>> >> "bpf: Restrict kernel image access functions when the kernel is locked down":
>> >> This patch just sucks in general.
>> >
>> > Yes - but that's what Alexei Starovoitov specified.  bpf kind of sucks since
>> > it gives you unrestricted access to the kernel.
>>
>> bpf, in certain contexts, gives you unrestricted access to *reading*
>> kernel memory.  bpf should, under no circumstances, let you write to
>> the kernel unless you're using fault injection or similar.
>>
>> I'm surprised that Alexei acked this patch.  If something like XDP or
>> bpfilter starts becoming widely used, this patch will require a lot of
>> reworking to avoid breaking standard distros.
>
> my understanding was that this lockdown set attemps to disallow _reads_
> of kernel memory from anything, so first version of patch was adding
> run-time checks for bpf_probe_read() which is no-go
> and without this helper the bpf for tracing is losing a lot of its power,
> so the easiest is to disable it all.

Fair enough.

> I think lockdown suppose to disable xdp, bpfilter, nflog, raw sockets + pcap too
> otherwise even cap_net_admin can see traffic coming into host.
> Similarly kprobe, perf_event, ftrace should be off as well?
>

I'm reasonably sure that lockdown is not intended to be this far
reaching.  cap_net_admin can see traffic coming into the host, and I
don't think lockdown is intended to change that.

David, I think this is exactly why you need to define what "lockdown"
means.  As it stands, the best argument I've seen involves
"blacklisting", but that's a political thing and almost no one
involved has any ability to evaluate it.  Right now there's a series
of patches that check for "lockdown" and seem to disable things that
make someone uncomfortable.  That's not a good way to design a
security feature.
