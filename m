Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1131037-1520492221-2-18178130943467857579
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, FREEMAIL_FORGED_FROMDOMAIN 0.249, FREEMAIL_FROM 0.001,
  HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='utf-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520492221; b=U6CJ+kGKAU8Nb1RJN9xR1InVZ9p4kLns+/uiNyfIZZ0p0OP
    fbEM6zhffV0pWNSo3qj2nBgqTch9Pdx7pzi+PS6U5s71cLNd93bw+P7asuZx4LSx
    Mq43mtNfEyJqijAl9yjAhb7bOPtqkO2Q0Dgg8lMAvrLxJJZI30lriqNmHurM9LKc
    Apcs73SEX2LcnnOyTdS2jM2xXnfuv2v5zMfgYFbtcDeXiv9zN5AkeX5zYnL9HRs3
    r4WOYb4KtgdwnIkaTrtZ6CA8x8fVLkA+xCHhSXZCmJ2CN8nt0yIQrHPmz7lALu2n
    V/4DfeBIxt/N1ljZsXFFgqZbN8H2fLh6GuRaBAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=subject:to:cc:references:from:message-id
    :date:mime-version:in-reply-to:content-type
    :content-transfer-encoding:sender:list-id; s=arctest; t=
    1520492221; bh=+Nh3hDF0kqlJhbCWaZgS6jePrPygoFtXv9+CoD2kJAk=; b=J
    zo9rW6DJr89t319DtVkIDMke3fuEqiTurw0/sHWJmhDxNXpIrdquCpD+HMH7a/+/
    eB/wAhIqrjFaic4NtKt3hfeTKuIQOw0OayKv533+OsFBQG0mNRGtLarcOoSWkRee
    vrKnUd1uvo8PMk7eDcbpDPy0bKvpzDz3MyFqRvc28C5WDwGOQmLs2vkSR7YVuzcw
    jyK3W7lV4cdZcSk8nDPZd+X78IC43LW4WBYUVMH+2Q8DZdnuDbTGuqdMcvj44jb4
    xrq2DOn2W5LbY11suEWMJ6dV7J3+/rfDtN8V7ctYbPTqTy0Ke+zzg471u5hRpK70
    FuxieI9DGpwddGQAN7drw==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=frO0iae5 x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=dkjyqtZx;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=gmail.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=frO0iae5 x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=dkjyqtZx;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=gmail.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965123AbeCHG4o (ORCPT <rfc822;greg@kroah.com>);
        Thu, 8 Mar 2018 01:56:44 -0500
Received: from mail-it0-f67.google.com ([209.85.214.67]:55237 "EHLO
        mail-it0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S964960AbeCHG42 (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 8 Mar 2018 01:56:28 -0500
X-Google-Smtp-Source: AG47ELs6yXy9pN2QX2Nh4Q6ZUzxuUZ3q+pKIA4pVcqnCjiuTdBGU3j2qULV7TPdYe82YArB2sUQVbg==
Subject: Re: [PATCH] kbuild: Handle builtin dtb files containing hyphens
To: James Hogan <jhogan@kernel.org>, linux-kbuild@vger.kernel.org,
        devicetree@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Michal Marek <michal.lkml@markovi.net>,
        Ralf Baechle <ralf@linux-mips.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Kevin Cernekee <cernekee@gmail.com>, linux-mips@linux-mips.org,
        stable@vger.kernel.org
References: <20180307140633.26182-1-jhogan@kernel.org>
From: Frank Rowand <frowand.list@gmail.com>
Message-ID: <2bb96235-6b1f-07bb-3dfe-d5dbb8eddb7f@gmail.com>
Date: Wed, 7 Mar 2018 22:56:25 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180307140633.26182-1-jhogan@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 03/07/18 06:06, James Hogan wrote:
> On dtb files which contain hyphens, the dt_S_dtb command to build the
> dtb.S files (which allow DTB files to be built into the kernel) results
> in errors like the following:

< snip >

Hi James,

Sorry for dribbling my comments out in so many emails.  :-)

Please change the subject line to say "dtb filenames" instead
of "dtb files".

Thanks,

Frank
