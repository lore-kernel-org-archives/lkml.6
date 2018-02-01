Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3106191-1517471875-2-17260963860302661249
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1517471874; b=AT4MrTjzOAK6Msl3l1joaT+QlwM4ufBxuuoES3sf+8cIMjb
    GWAg8vH5zm5zD1kXOKCmCo29poBSPwA865IcvKqzLUQmPFpe/+BQGzPz4VwudMTi
    HHBTh0ZSgE9xv7FfaAgrqP0vMCC59wF2DkRILNlQzwWNwiydWedOH19isTVhyaV2
    dDul9ksTkZAx8MMcYbVmPjzB3ehn/BPMLZ9RvzaWlc5AHf9sjNlgovsreLw0Tcja
    FkxtE9BntPT4Ut50apazlkhFYelKsU5YXEHGfQ9bk8xLFNgScaiY22PgOVSBodhu
    rncR7bBuw+idPL0fJg8vG0VawwVBfW5fNBobVRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=mime-version:in-reply-to:references:from
    :date:message-id:subject:to:cc:content-type:sender:list-id; s=
    arctest; t=1517471874; bh=kYsa6sNRPBXCPQdlowZYimTw7t10xLWGoAnzXx
    B+xUY=; b=hgT8C/sTGQOuFkFacNB9MEK6OzGzkkdbMPZxs0Ehm5TKgHxLtb6y9p
    4yeuioI2/fzWDIOKma+AhPvSIYwGYpmRIBZ93ptsJq3LXSlOrJ8h8ztKduFyO6i7
    jhQ5qE7Nayx8zF9MXHRVHKk9LrIisC4JB4loZzAIjN8LXDZKJsIzaHq5yV+jmtLb
    LkOrk7ApYHuV5vYurHJ2WnxfceSxSXaASqxn27kTRKYBfJvxfDL6M4wWnCqki3BP
    1TwSKaEBo43OSkzLeA96ZnPjFlxOCXQhTpjNTQyFiDLVZW4SQ9M8A1Fw2L8KgNzs
    0pgLiqldrslwX0J5Do2eU8xu+3epYsEQ==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=kAIvPE1z x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=orgdomain_pass;
    x-google-dkim=fail (message has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=SrKO6bGz;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=kernel.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=kAIvPE1z x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=orgdomain_pass;
    x-google-dkim=fail (message has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=SrKO6bGz;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=kernel.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751765AbeBAH5v (ORCPT <rfc822;greg@kroah.com>);
        Thu, 1 Feb 2018 02:57:51 -0500
Received: from mail-ot0-f193.google.com ([74.125.82.193]:40964 "EHLO
        mail-ot0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751272AbeBAH5u (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 1 Feb 2018 02:57:50 -0500
X-Google-Smtp-Source: AH8x227v3WeKqdS4bh0WS6xbJhV3tBtuUc20yihH/5zQGdzducxo+XIAQXAUE53/bfbONb2QGT3i8zjRRajp629C3hs=
MIME-Version: 1.0
In-Reply-To: <CAHp75Vf7SRNGeU_To9WNmzECxaKjDbYeFspnJiwCGAhAwOTRyA@mail.gmail.com>
References: <20180125143639.9969-1-jgross@suse.com> <20180125143639.9969-2-jgross@suse.com>
 <CAHp75VdgdQXH-d9+Fo1DwGdfV1pB0jADMmwAK1BU7oN6dgQs8Q@mail.gmail.com>
 <a33e605a-73d7-83b7-4472-14f66b6738be@suse.com> <CAHp75VdUO2Rq7geYD9xxY3nnzGAhO46+w+rQx44=MgJ6obRcEA@mail.gmail.com>
 <CAJZ5v0gr7Jd-1dOD_DTRQDCX7ON68O1KJ9ioAJAnwBYm2cEdZg@mail.gmail.com> <CAHp75Vf7SRNGeU_To9WNmzECxaKjDbYeFspnJiwCGAhAwOTRyA@mail.gmail.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Thu, 1 Feb 2018 08:57:49 +0100
X-Google-Sender-Auth: QX4fo36z2OEyLy_v3IG8Thr3dp4
Message-ID: <CAJZ5v0g3Ti4W8Z-ePVCO0RFs3qviJxhrh1___i6oiZKRsYzBng@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] x86/acpi: add retrieval function for rsdp address
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
        Juergen Gross <jgross@suse.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        xen-devel@lists.xenproject.org, Len Brown <lenb@kernel.org>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Ingo Molnar <mingo@redhat.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Stable <stable@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, Jan 31, 2018 at 4:43 PM, Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
> On Mon, Jan 29, 2018 at 5:02 AM, Rafael J. Wysocki <rafael@kernel.org> wrote:
>> On Sun, Jan 28, 2018 at 4:04 PM, Andy Shevchenko
>> <andy.shevchenko@gmail.com> wrote:
>>> On Fri, Jan 26, 2018 at 8:21 PM, Juergen Gross <jgross@suse.com> wrote:
>>>> On 26/01/18 19:08, Andy Shevchenko wrote:
>>>>> On Thu, Jan 25, 2018 at 4:36 PM, Juergen Gross <jgross@suse.com> wrote:
>
>>>>> The problem with weak functions that we can't have more than one
>>>>> implementation per kernel while we would like to built several code
>>>>> paths.
>>>>>
>>>>> I have stumbled on the similar stuff and realize that.
>>>>>
>>>>> Perhaps, one of the solution is to have an additional struct under
>>>>> x86_init to alternate ACPI related stuff.
>>>>
>>>> I think we can go that route when another user of that interface is
>>>> appearing.
>>>
>>> Why not to establish the struct? At least this route I would like to
>>> go with [1].
>>>
>>> [1]: https://lkml.org/lkml/2018/1/17/834
>>
>> Maybe I'm a bit slow today, but care to explain what exactly you mean?
>
> Instead of declaring function as __weak, establish a new struct for
> ACPI related stubs and incorporate it into x86_init.
>
> That is my proposal. I think I would go this way in my case where I
> need to treat differently ACPI HW reduced initialization of legacy
> devices.

IOW you'd like to have a set of ACPI init callbacks that could be
defined by an arch, right?
