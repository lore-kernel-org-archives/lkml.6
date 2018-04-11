Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2323979-1523447941-2-17167785984627768589
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='US-ASCII'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523447941; b=Hvpz77WoK9I4j56G+RL9NecBo7bNpEtnNsBZtOiTvcYD4uRmbF
    6NinlTN3WX6915te8146k5xKUCcmpUUf/iBhMX9BuLZtCWfG6Rd4ORO81h1oVVSx
    nl7ibc9Pkap/aFy75uM9hmu8GLsNOBD3P75S0hOhxUCWNBJFpkLJv+tuYmANPT8s
    Y+zrKeik+J+SFAthTnJJtgIkj/1e1LIK6RWmvBdmyc66/xsbniSHnTq8KjQdPNs2
    z+Goms15pBNO9e7yKmAZ6RIzjmhWPyqpG5qp8zUQdhl28BZH8ILueTsOnnfUfoQ+
    wIzjYI+osuOqUp34gG7sCgSxdoj/pR0hYkQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=message-id:date:from:to:cc:subject
    :references:in-reply-to:mime-version:content-type
    :content-transfer-encoding:sender:list-id; s=fm2; t=1523447941;
    bh=AnZJsyc67Rz+ktMqoibtD1ZK86iA3aGDCd+8dw8ZQZ0=; b=AE/apHXTDKI8
    HmMzGIyL9f6E6IRLGlMd8Nuaf2Zs7Z6t1ILA0KkZUq+qYVVlhBo/Vub7hF0SJtO0
    87AGnuXN0s5ZOvKWhUkVOtPdVKY71br58yK+a8RL1asCGZ8Ft3ZZXOoSW/bGhfnC
    gl6A21HXp45Uw3QoeKPIEIaHTXM1PiAfCbWa79569zUqc9UtK1obRiC0wTbKO7mv
    g7ahEu1NDj61RuNCxFd7QOx8lgzYV19bOnKDVDB3tB7QNAbVQwAymz/8eWrPihYi
    u1mjP4Wbm2bKHbXfXrZ8tGt77x8aTROmETH4mgOjM5QpmvLev7+CdxvZ4Hnn338m
    LU8sW4I0aQ==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=suse.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=suse.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-90 state=0
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=suse.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=suse.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-90 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfPLgIN2ZNfOOoO2m5QjvnpXKLt0FmOHMQK0dOTc1p4Om3eQiKvptYPVt+PheAQp5Op/GlKa3AtZZ/EETR6ps75wd+gYBra1ND3yWm0DfUsYecPcJZDu5
    2ycz7pyFAwpyFg8Cexy22IzHoGw2rvxKhGqlxKm5BO+YLaEeAOlvH8lxvvxn+NdSLbpRTRr9puDGUJply3g3IEkA6ZHjsl6f/aK9BzBbU9F2q/arsarX1t+F
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=kj9zAlcOel0A:10 a=Kd1tUaAdevIA:10
    a=VwQbUJbxAAAA:8 a=iox4zFpeAAAA:8 a=Yw8HchP22gJTV7pj8TsA:9 a=CjuIK1q_8ugA:10
    a=AjGcO6oz07-iQ99wixmX:22 a=WzC6qhA0u3u7Ye7llzcV:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751970AbeDKL67 convert rfc822-to-8bit (ORCPT
        <rfc822;greg@kroah.com>); Wed, 11 Apr 2018 07:58:59 -0400
Received: from prv1-mh.provo.novell.com ([137.65.248.33]:50818 "EHLO
        prv1-mh.provo.novell.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751699AbeDKL67 (ORCPT
        <rfc822;groupwise-stable@vger.kernel.org:7:2>);
        Wed, 11 Apr 2018 07:58:59 -0400
Message-Id: <5ACE149E02000078001BA424@prv1-mh.provo.novell.com>
X-Mailer: Novell GroupWise Internet Agent 18.0.0 
Date: Wed, 11 Apr 2018 05:58:54 -0600
From: "Jan Beulich" <JBeulich@suse.com>
To: "Ingo Molnar" <mingo@kernel.org>
Cc: <x86@kernel.org>, <tglx@linutronix.de>,
        <xen-devel@lists.xenproject.org>, <boris.ostrovsky@oracle.com>,
        <mingo@redhat.com>, "Juergen Gross" <jgross@suse.com>,
        <linux-kernel@vger.kernel.org>, <stable@vger.kernel.org>,
        <hpa@zytor.com>
Subject: Re: [Xen-devel] [PATCH] x86/xen: zero MSR_IA32_SPEC_CTRL
 before suspend
References: <20180226140818.4849-1-jgross@suse.com>
 <5AA8F00302000078001B15EE@suse.com>
 <6b59ac31-7e90-1c18-2467-d7d294da6e5b@suse.com>
 <5ACDEE5B02000078001BA2DE@prv1-mh.provo.novell.com>
 <20180411115350.lvx5yaevoq6arwg3@gmail.com>
In-Reply-To: <20180411115350.lvx5yaevoq6arwg3@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

>>> On 11.04.18 at 13:53, <mingo@kernel.org> wrote:
> * Jan Beulich <JBeulich@suse.com> wrote:
> 
>> Additionally, x86 maintainers: is there a particular reason this (or
>> any functionally equivalent patch) isn't upstream yet? As indicated
>> before, I had not been able to find any discussion, and hence I
>> see no reason why this is a patch we effectively carry privately in
>> our distro branches (and likely other distros do so too).
> 
> The patch was merged 6 weeks ago and is now upstream:
> 
>   71c208dd54ab: x86/xen: Zero MSR_IA32_SPEC_CTRL before suspend

I'm sorry, but no, this isn't the patch I was inquiring about.
Instead I'm wondering of the disposition of the patch disabling
IBRS around a CPU going idle.

Jan
