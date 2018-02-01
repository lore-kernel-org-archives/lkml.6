Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3933199-1517499906-2-3122889650903159483
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, FREEMAIL_FORGED_FROMDOMAIN 0.195, FREEMAIL_FROM 0.001,
  HEADER_FROM_DIFFERENT_DOMAINS 0.001, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1517499905; b=C7JxXs0uvYnKANtVF8tS949NQQ+f+/31XcMkxcdcS0eLgIf
    UALVEyw50jZ/+LDztS60hr5Pir/jVqclSvUQUJ3LpmUtz2Q8Ns56P2yi6a63sJEn
    yPPkVYb8nSnOsxdPz5G5fceRtCq+bOIlBMgEnD93sS/Hni2qFnDTPkd8k/8vUEJI
    Ds1gEj8xE3x/upSkM++xtYdw9VhkfA7SUEGNFljCd5TcJubH36O1QVlmLf6mp7yw
    JSuAL1gZZVm9tYj28O0DIlnHiFjLIzGmLs2A0ucymXb4N3EfexDc3+h4fSUHXj5G
    q9YIzkMeel0mmciwRHeOZgnSDMFzGQoHnwS5+NA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=mime-version:in-reply-to:references:from
    :date:message-id:subject:to:cc:content-type:sender:list-id; s=
    arctest; t=1517499905; bh=u8mUGpjbSl+qq1GMkeQDLaaCYHj3svj9r5A0PR
    We8MI=; b=myExFahQIuaN2T25TdqYyd4C3NHkZdLlTmjSBr6NSolQ6+qU7y3E6E
    OYar3UXrWWUfzHdCTSIXdCXcy+aJy0sJ5We2wQJJfTGqZiWddhUc62W3tpIWdxQF
    +Nwu1CSpzxeNcAEwMLXxHraOHEyGhmTsXlr7nC+MZmNLapVsWochJyXkFQbzrLKH
    sWDvydUorayxWjOlYLYYiXDvGj9AYd+RxTfRE3jxtls3NfCAhFL4JHgR87CDl6Eq
    20YMHfL71vje18ha2rlqqCRokKFarDVnkdBJeu3QIoRrMq4mYCoooyxfoMujhCpz
    I5JSLSmTS4ZkSDPyxnWfPoaAeZWHDpyw==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=qn8Ip7KO x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=Ujhv6yID;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=gmail.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=qn8Ip7KO x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=Ujhv6yID;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=gmail.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751547AbeBAPpE (ORCPT <rfc822;greg@kroah.com>);
        Thu, 1 Feb 2018 10:45:04 -0500
Received: from mail-qk0-f181.google.com ([209.85.220.181]:39798 "EHLO
        mail-qk0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751508AbeBAPpD (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 1 Feb 2018 10:45:03 -0500
X-Google-Smtp-Source: AH8x224swiGwz9vUWbyrpqOrqbKFMQBwQKWSDERmLAVoTAGyj5PNkgPU+VH2MNEP6OdsSBL65w8KrpKS+sUaBw7X4oc=
MIME-Version: 1.0
In-Reply-To: <CAJZ5v0g3Ti4W8Z-ePVCO0RFs3qviJxhrh1___i6oiZKRsYzBng@mail.gmail.com>
References: <20180125143639.9969-1-jgross@suse.com> <20180125143639.9969-2-jgross@suse.com>
 <CAHp75VdgdQXH-d9+Fo1DwGdfV1pB0jADMmwAK1BU7oN6dgQs8Q@mail.gmail.com>
 <a33e605a-73d7-83b7-4472-14f66b6738be@suse.com> <CAHp75VdUO2Rq7geYD9xxY3nnzGAhO46+w+rQx44=MgJ6obRcEA@mail.gmail.com>
 <CAJZ5v0gr7Jd-1dOD_DTRQDCX7ON68O1KJ9ioAJAnwBYm2cEdZg@mail.gmail.com>
 <CAHp75Vf7SRNGeU_To9WNmzECxaKjDbYeFspnJiwCGAhAwOTRyA@mail.gmail.com> <CAJZ5v0g3Ti4W8Z-ePVCO0RFs3qviJxhrh1___i6oiZKRsYzBng@mail.gmail.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Thu, 1 Feb 2018 17:45:02 +0200
Message-ID: <CAHp75Ved4nO7ktQ=1O5oRx4mNyWcA6YN9fATgMGW1OR0UxCd4g@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] x86/acpi: add retrieval function for rsdp address
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Juergen Gross <jgross@suse.com>,
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

On Thu, Feb 1, 2018 at 9:57 AM, Rafael J. Wysocki <rafael@kernel.org> wrote:
> On Wed, Jan 31, 2018 at 4:43 PM, Andy Shevchenko
> <andy.shevchenko@gmail.com> wrote:
>> On Mon, Jan 29, 2018 at 5:02 AM, Rafael J. Wysocki <rafael@kernel.org> wrote:
>>> On Sun, Jan 28, 2018 at 4:04 PM, Andy Shevchenko
>>> <andy.shevchenko@gmail.com> wrote:

>> Instead of declaring function as __weak, establish a new struct for
>> ACPI related stubs and incorporate it into x86_init.
>>
>> That is my proposal. I think I would go this way in my case where I
>> need to treat differently ACPI HW reduced initialization of legacy
>> devices.
>
> IOW you'd like to have a set of ACPI init callbacks that could be
> defined by an arch, right?

Correct!

And since there is another potential user (Xen) for this approach I
consider it a good chance to be chosen.
Though I have no idea if Xen can do things differently.

-- 
With Best Regards,
Andy Shevchenko
