Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2321993-1517572928-2-1821458994830357187
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
    t=1517572928; b=Jb47SSTp0CfI0HXzfj2qb/C2Ss2swAldcJpSHTi0jtifzD2
    cFGbkSKgFj61xb2R0OUz4HiTCpMwVmTDpNfXUd19b65y+6pvn1KYqU761Wa1bpXj
    eJP/QuliP+sa1BLr8/lOMGZnDvPJU3KPL1a0bimS8lUvbX+gqHrYNBPuzXdt2Fa9
    lQ6nRfc5UVkXPimwsgIKcGooExweZ43ibwx4a72VTGu+vD0BmLhDGcZhBTFfqyuk
    l3aXhALaSmXid+E8SgmqyoNeBoxwfCBkJCpSCSMkI42Ly/pllcPZKUKk4h70nYoE
    uy4nwsYpMCR6t5+frNUk7H8Puwu4F8HIIruk+oA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=mime-version:in-reply-to:references:from
    :date:message-id:subject:to:cc:content-type:sender:list-id; s=
    arctest; t=1517572928; bh=AB7wLZvTh6kjES9Jw0Xi9QpFnGhjIAiEUEv0W9
    2q49I=; b=N5YpOVf9MaojP21FrQ7nKMupTybP7ACBNo5WAwFT1G3kO7e7sSNU4u
    rUZo0LwapQzOxV3TUNT3IhzZpAqbAxTXWygz28SOLrwO/UcpGxKgGKE5YUdGZeTp
    pCRP/umN/OLGoG8byHyoqSlaf7/IgkP2Ss321X4PeFnoLwApOe/Kz/2egU36Jt6X
    kaF6T5zirzybvNY/8NPloY2s+8pDiq6u7sAKvbVlTi9JQWOIuQAeVXgDsc8KTCGf
    bihUfxAKOV8mKio7iauUcuuxmC/wm5ymyJ65Ucl9/XkX3QRueCogiJQ0Rgxvn3EB
    RVIBdsBbOpQ15Q9Yif7F3lLtwEKAGzkQ==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=Nehsv046 x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=orgdomain_pass;
    x-google-dkim=fail (message has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=MI/adTRE;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=kernel.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=Nehsv046 x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=orgdomain_pass;
    x-google-dkim=fail (message has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=MI/adTRE;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=kernel.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751508AbeBBMCG (ORCPT <rfc822;greg@kroah.com>);
        Fri, 2 Feb 2018 07:02:06 -0500
Received: from mail-ot0-f195.google.com ([74.125.82.195]:34971 "EHLO
        mail-ot0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751416AbeBBMCF (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 2 Feb 2018 07:02:05 -0500
X-Google-Smtp-Source: AH8x224QiZxBU22cWHemrdrfxGvI2d2N0j/WHmjjAF6o+Y1IEq2wCwd0/16+TPNNFRrm6ebwoTzVR+PctTkrlS927w0=
MIME-Version: 1.0
In-Reply-To: <CAHp75Ved4nO7ktQ=1O5oRx4mNyWcA6YN9fATgMGW1OR0UxCd4g@mail.gmail.com>
References: <20180125143639.9969-1-jgross@suse.com> <20180125143639.9969-2-jgross@suse.com>
 <CAHp75VdgdQXH-d9+Fo1DwGdfV1pB0jADMmwAK1BU7oN6dgQs8Q@mail.gmail.com>
 <a33e605a-73d7-83b7-4472-14f66b6738be@suse.com> <CAHp75VdUO2Rq7geYD9xxY3nnzGAhO46+w+rQx44=MgJ6obRcEA@mail.gmail.com>
 <CAJZ5v0gr7Jd-1dOD_DTRQDCX7ON68O1KJ9ioAJAnwBYm2cEdZg@mail.gmail.com>
 <CAHp75Vf7SRNGeU_To9WNmzECxaKjDbYeFspnJiwCGAhAwOTRyA@mail.gmail.com>
 <CAJZ5v0g3Ti4W8Z-ePVCO0RFs3qviJxhrh1___i6oiZKRsYzBng@mail.gmail.com> <CAHp75Ved4nO7ktQ=1O5oRx4mNyWcA6YN9fATgMGW1OR0UxCd4g@mail.gmail.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Fri, 2 Feb 2018 13:02:04 +0100
X-Google-Sender-Auth: lTi9OAIgY1rVKh2WYgk98pVeePo
Message-ID: <CAJZ5v0jSUK7adqNuHRp4VYR2Nb2+Av0dqs-kL1AsEgWk3062eg@mail.gmail.com>
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

On Thu, Feb 1, 2018 at 4:45 PM, Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
> On Thu, Feb 1, 2018 at 9:57 AM, Rafael J. Wysocki <rafael@kernel.org> wrote:
>> On Wed, Jan 31, 2018 at 4:43 PM, Andy Shevchenko
>> <andy.shevchenko@gmail.com> wrote:
>>> On Mon, Jan 29, 2018 at 5:02 AM, Rafael J. Wysocki <rafael@kernel.org> wrote:
>>>> On Sun, Jan 28, 2018 at 4:04 PM, Andy Shevchenko
>>>> <andy.shevchenko@gmail.com> wrote:
>
>>> Instead of declaring function as __weak, establish a new struct for
>>> ACPI related stubs and incorporate it into x86_init.
>>>
>>> That is my proposal. I think I would go this way in my case where I
>>> need to treat differently ACPI HW reduced initialization of legacy
>>> devices.
>>
>> IOW you'd like to have a set of ACPI init callbacks that could be
>> defined by an arch, right?
>
> Correct!

OK
