Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3039319-1523470200-2-6987909664372151661
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-api-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523470199; b=FEFLjOTb/h5gzqofcvbE2DW2kn76JGgcgVvVR3pQLYxfQqjLBW
    sI5D6+nJapnipT/IQVJzdFbXfJj9E/XB3vDSPVNkanRuyPM8L0IMO/fGMqm+eyVE
    3h3hLG08bfotEA6vS55Tdu88aGrootD9DoqkI4ymInxrWl8OrMYoZX7aaodBfAP6
    NdtL5dTG3kN2hHUEbmWOWIMTZkzRXMiyjvRCgSc2AVUEPtF4EdI1L3e8BghWVxVt
    L+rlTJp6H0BR73kSvqoAlLCzmZuQKYOHy4TbaOB2QtsQdjIITct+Mlu9/ovSypHb
    tdbJMBMXmt4iLV0RREEBNU8/HorW2zWTJdSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=mime-version:in-reply-to:references:from
    :date:message-id:subject:to:cc:content-type:sender:list-id; s=
    fm2; t=1523470199; bh=iEpGbelevx5soceJsdGnTIn0Vk7BnOCG8hcJXOGB5n
    Q=; b=iMSgEhYBk2tZjYwVj0ow5y/MT6N31inZq5HykCUALlO/l5HWw8N+z7n6Kx
    dQK/CtiZ1lJgstwwYJQBOuT3Ogys6v26ojxJSTpOqxmLUz9tR089VDPsTuV+pJDF
    Cyla0MNpCjBO4mEZOm0NNMpgbI4OTX2ZVIH44Sliwlx93HOn25MD1GOWWDyo7eJp
    MCwBMn00/AJgu0GxUolQf4PW3UN1VxifqbeG8GiCKYJx6qy7bH6mKtjk2r9PS/FX
    oJPZ4ELHL0S+5ariESKTA/Wn/vCp44qJCjG8+xflm3ziFmvgxqq70KkwzVSn7BKH
    2fNAndxO6O98ggWa4TXFAHn5dlaw==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 1024-bit rsa key sha256) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=F89y00NX x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=google;
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=EgrIvhsF x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linux-foundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=oXualAhd;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linux-foundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 1024-bit rsa key sha256) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=F89y00NX x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=google;
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=EgrIvhsF x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linux-foundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=oXualAhd;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linux-foundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfInXUwr9dWfkUT5cHJjUsYOC6OuQLTxQpdUE2ujBj6XaF2z41p+pqLQJ3gdVCMGqiv1u4pu0+LudavY0Q0Mq3Iks7stiiBhwKfino51NoM5wHHMVO8uW
    teWkLPzP0EmajY9sH0O57evGJfGN4l3v3uuwSO08cks5pjW6uppMR4cS6VO2KG5FmYd8CZuLsgJUNRpTi2C4V4iTRyCF5i4NeG6xwWrt1E3etLvLLPta88Yr
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=20KFwNOVAAAA:8 a=VwQbUJbxAAAA:8 a=vJfppkURCeG3RfL7XEcA:9 a=QEXdDO2ut3YA:10
    a=x8gzFH9gYPwA:10 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752334AbeDKSJo (ORCPT <rfc822;greg@kroah.com>);
        Wed, 11 Apr 2018 14:09:44 -0400
Received: from mail-io0-f193.google.com ([209.85.223.193]:42080 "EHLO
        mail-io0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750734AbeDKSJm (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 11 Apr 2018 14:09:42 -0400
X-Google-Smtp-Source: AIpwx49ZCzYVV84WHOkNRINDkEDBZyx1gPElEIlFVKsJ/jodxE8iScg8SJsuLVFe5zlP40ni4yzqS4r/BwzmmbK8Cdg=
MIME-Version: 1.0
In-Reply-To: <152346388583.4030.15146667041427303547.stgit@warthog.procyon.org.uk>
References: <152346387861.4030.4408662483445703127.stgit@warthog.procyon.org.uk>
 <152346388583.4030.15146667041427303547.stgit@warthog.procyon.org.uk>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 11 Apr 2018 11:09:41 -0700
X-Google-Sender-Auth: K98CM_x3d8LblyV5LQ_tq7HfCSo
Message-ID: <CA+55aFzPo-dip8dgyo0U+g5qai9SAJU+D1c+AFJ0zV9_PBAB8Q@mail.gmail.com>
Subject: Re: [PATCH 01/24] Add the ability to lock down access to the running
 kernel image
To: David Howells <dhowells@redhat.com>
Cc: linux-man <linux-man@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        James Morris <jmorris@namei.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        LSM List <linux-security-module@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, Apr 11, 2018 at 9:24 AM, David Howells <dhowells@redhat.com> wrote:
> Provide a single call to allow kernel code to determine whether the system
> should be locked down, thereby disallowing various accesses that might
> allow the running kernel image to be changed, including:
>
>  - /dev/mem and similar
>  - Loading of unauthorised modules
>  - Fiddling with MSR registers
>  - Suspend to disk managed by the kernel
>  - Use of device DMA

So what I stlll absolutely detest about  this series is that I think
many of these things should simply be done as separate config options.

For example, if the distro is sure that it doesn't need /dev/mem, then
why the hell is  this tied to "lockdown" that then may have to be
disabled because *other* changes may not be acceptable (eg people may
need that device DMA, or whatever).

If that /dev/mem access prevention was just instead done as an even
stricter mode of the existing CONFIG_STRICT_DEVMEM, it could just be
enabled unconditionally.

So none of these patches raise my hackles per se. But what continues
to makes me very very uncomfortable is how this is all tied together.

Why is this one magical mode that then - because it has such a big
impact - has to be enabled/disabled as a single magical mode and with
very odd rules?

I think a lot of people would be happier if this wasn't so incestuous
and mixing together independent things under one name, and one flag.

I think a lot of the secure boot problems were exacerbated by that mixup.

So I would seriously ask that the distros that have been using these
patches look at which parts of lockdown they could make unconditional
(because it doesn't break machines), and which ones need that escape
clause.

                 Linus
