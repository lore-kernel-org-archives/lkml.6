Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1833902-1521565948-2-6274851433306753227
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='utf-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-usb-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521565948; b=qZo+Q0N70Sg3/innLel65+t/N7bt96pZMVsY6JOe3IUwzU6
    3v83Q2lx8Km/0e2sn82oLMEPRbgMVzg/Hrw4YHbCvyLszbHO1zs8AC2QufxAQ+TJ
    3hDYOalb7qvhzGpww64rY5H4fTmrK4TdY0aM8juk977qKDFqNuaRPmSNAfyfDE3L
    8vrxQMHOtyuPqSocWOL8VU7G4Or9aySiA4a5iVOmYFg+auc0d6xfoDqXgYUaklv6
    2xtH6ZvbUyt4DVaWcL6pt633VxC4SdZRxANPlraqRLrPW/mR65NJnYDU2Rnia8uJ
    ihBTemUjXnlNtfvJVGGneYgR7Hn3ltdYhDSp3Ew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:subject:in-reply-to:cc:from:to
    :message-id:mime-version:content-type:content-transfer-encoding
    :sender:list-id; s=arctest; t=1521565948; bh=WW3NCoTG2bGp1KFMwLl
    nU6KuO9ElqDDd3XOch6frh9M=; b=rEb6+l1yZnpI15KuVxaqgjCR6HR/bqakwJh
    OuNrgpdATioqldus3Nns35aTzxZ2PYL43FXYXV2QVc71ZKjyMUg0ntTtlVtzLURC
    f3vkPktI0Vd1GFWQQfXN6E4AdVQ1lmR4Z0FZR8sVcIRSg2txwRYZg+XOBaNdcH9c
    42dwGnnl3l2aKpX2rgocVTWeKIGMmBTtLDhfu/6zMSjZZ9RXojD57uGi28/WmopM
    GLDpQUon3AyhQwz88ZfToHl+s6USR4ncAFJuZnBdimjbJK22uNFAFFtLX8GAgqOh
    5wmnfUA8FoAlLkmme+DQUupmFx7OQMwP4mBlraN/SGP4n62jtiw==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered, 2048-bit rsa key sha256) header.d=sifive.com header.i=@sifive.com header.b=ZCgikdYv x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=google;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=sifive.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-google-dkim=fail (body has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=ufS4IWNR;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=sifive.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (body has been altered, 2048-bit rsa key sha256) header.d=sifive.com header.i=@sifive.com header.b=ZCgikdYv x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=google;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=sifive.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-google-dkim=fail (body has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=ufS4IWNR;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=sifive.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751531AbeCTRMJ (ORCPT <rfc822;greg@kroah.com>);
        Tue, 20 Mar 2018 13:12:09 -0400
Received: from mail-pf0-f193.google.com ([209.85.192.193]:39891 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751502AbeCTRLs (ORCPT
        <rfc822;linux-usb@vger.kernel.org>); Tue, 20 Mar 2018 13:11:48 -0400
X-Google-Smtp-Source: AG47ELuMxOFzugm09+HMnP33/rXnHfvMfaq2EX6Yrhp+puW00QaTiWKcDwXN28nuFmRqjJRTfmSNEg==
Date: Tue, 20 Mar 2018 10:11:47 -0700 (PDT)
X-Google-Original-Date: Tue, 20 Mar 2018 10:01:23 PDT (-0700)
Subject: Re: [PATCH 00/16] remove eight obsolete architectures
In-Reply-To: <CAK8P3a01pfvsdM1mR8raU9dA7p4H-jRJz2Y8-+KEY76W_Mukpg@mail.gmail.com>
CC: hare@suse.de, dhowells@redhat.com, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-block@vger.kernel.org, linux-ide@vger.kernel.org,
        linux-input@vger.kernel.org, netdev@vger.kernel.org,
        linux-wireless@vger.kernel.org, linux-pwm@vger.kernel.org,
        linux-rtc@vger.kernel.org, linux-spi@vger.kernel.org,
        linux-usb@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-fbdev@vger.kernel.org, linux-watchdog@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
From: Palmer Dabbelt <palmer@sifive.com>
To: Arnd Bergmann <arnd@arndb.de>
Message-ID: <mhng-f6731cb9-8394-419d-b14b-c6fcd6c0930d@palmer-si-x1c4>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-usb-owner@vger.kernel.org
X-Mailing-List: linux-usb@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Thu, 15 Mar 2018 03:42:25 PDT (-0700), Arnd Bergmann wrote:
> On Thu, Mar 15, 2018 at 10:59 AM, Hannes Reinecke <hare@suse.de> wrote:
>> On 03/15/2018 10:42 AM, David Howells wrote:
>>> Do we have anything left that still implements NOMMU?
>>>
>> RISC-V ?
>> (evil grin :-)
>
> Is anyone producing a chip that includes enough of the Privileged ISA spec
> to have things like system calls, but not the MMU parts?
>
> I thought at least initially the kernel only supports hardware that has a rather
> complete feature set.

We currently do not have a NOMMU port.  As far as I know, everyone who's
currently producing RISC-V hardware with enough memory to run Linux has S mode
with paging support.  The ISA allows for S mode without paging but there's no
hardware for that -- if you're going to put a DRAM controller on there then
paging seems pretty cheap.  You could run a NOMMU port on a system with S-mode
and paging, but With all the superpage stuff I don't think you'll get an
appreciable performance win for any workload running without an MMU so there's
nothing to justify the work (and incompatibility) of a NOMMU port there.

While I think you could implement a NOMMU port on a machine with only M and U
modes (and therefor no address translation at all), I don't know of any MU-only
machines that have enough memory to run Linux (ours have less than 32KiB).  A
SBI-free Linux would be a prerequisite for this, but there's some interest in
that outside of a NOMMU port so it might materialize anyway.

Of course, QEMU could probably be tricked into emulating one of these machines
with little to no effort :)...  That said, I doubt we'll see a NOMMU port
materialize without some real hardware as it's a lot of work for a QEMU-only
target.
