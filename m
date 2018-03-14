Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1132802-1521013270-2-6886308368072200760
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521013269; b=lAWe9CNK5NiGpfPuPCGMWYB/Q5u8miWbO6AK0FQ5Ig+cH+I
    73y3s0xlePAU+ORG/Qpm/VNoSC4+T7ASftZa0ZAKqH50f6xrA3k+xiu7nc/S/E8Q
    fXqfaQUgq35iexmmCYI8uXYC8NzFPSpB4FWel/65uNwU+nn4iPUsexe5s53qNIgb
    xQLpxbyGiZG1pHTS4b8uTpYzAIguhlPRa8h1dSwIXIafXaJ4l/x93yapYjuzcvY+
    pEiP2tJJHvK2Gc8L409nY8yMeVk4aKewwgvPFEFPfyVs7mwaHPDN1PomIcT2Ckmw
    nf4OQ7U+rj5bbICEchKbPUdFH6P9avRXydgz/AQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=mime-version:in-reply-to:references:from
    :date:message-id:subject:to:cc:content-type:sender:list-id; s=
    arctest; t=1521013269; bh=thVjpyHwENopPcXsGzkt8kfFtggudLN65yj2Ek
    mWmpQ=; b=Oa+5PXWOyeMt4hG2L/Bvn1DLyXmNdrnaqbdIKyxjxPaj85TJVr22s4
    bMcJz08V0bTYIwIYPoEVeKVglAu01UY5B+A0NFpFvCa3oIVyDDjSfWnJ/eqGrfVy
    3AiRYuGV/OzZKcgkQioj1zlu+YyPO/+lm60Olse96QURVnjBp65SowGC0wVimrzN
    8RJL8Xd7mT2wIWkLhIC+GSOW0o0dlCEEHCE9VVICxRdlgs39eYOgT2IyjmdwHE28
    SrbSjI0NP9ixSbjYXSz42PxtGFwjNUjsSA+nlSCk1F2b3yiiDPO+LYZ4mGFjuZa7
    OUydQGxmxisIge3lGgbjsVFe6JSL6Gkw==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=redhat.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=Gh+s581w;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=redhat.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=redhat.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=Gh+s581w;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=redhat.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753270AbeCNHlG (ORCPT <rfc822;greg@kroah.com>);
        Wed, 14 Mar 2018 03:41:06 -0400
Received: from mail-lf0-f49.google.com ([209.85.215.49]:41391 "EHLO
        mail-lf0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751470AbeCNHlF (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 14 Mar 2018 03:41:05 -0400
X-Google-Smtp-Source: AG47ELuqS9IVvAW8hQGCsMCzn6KIJgKQTFmrCVkAy9pQTe1w9iqiRKJAMysNn6Ur1tokAJRodIT/9mWZW3QmifJt0Ho=
MIME-Version: 1.0
In-Reply-To: <E63288C3-BE4F-4D41-A074-1CB86C74414E@vmware.com>
References: <20180312191917.21381-1-namit@vmware.com> <20180312192848.22104-1-namit@vmware.com>
 <E63288C3-BE4F-4D41-A074-1CB86C74414E@vmware.com>
From: Oleksandr Natalenko <oleksandr@redhat.com>
Date: Wed, 14 Mar 2018 08:41:03 +0100
Message-ID: <CAHcwAbT64et5yroyb-62wHX=gQebU=sgGwQSF5aBSPJgb3bQfg@mail.gmail.com>
Subject: Re: [PATCH v2] vmw_balloon: fixing double free when batching mode is off
To: Nadav Amit <namit@vmware.com>
Cc: Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Xavier Deguillard <xdeguillard@vmware.com>,
        pv-drivers <pv-drivers@vmware.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Gil Kupfer <gilkup@gmail.com>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hello.

On Wed, Mar 14, 2018 at 5:02 AM, Nadav Amit <namit@vmware.com> wrote:
> Oleksandr, if you can confirm that it fixes the bug you encountered, it
> would be great.

Sure, I'm checking this possibility with a couple of customers, and
will reply back once I have some inputs on it.

> Greg, Arnd, on your free time, please let me know if there is any issue
> with the patch, and whether you can incorporate it, preferably in 4.16,
> since it is a bug-fix that was encountered by Red-Hat customers.

-- 
Best regards,
  Oleksandr Natalenko (post-factum)
  Software Maintenance Engineer
