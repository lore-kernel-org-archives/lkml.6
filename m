Return-Path: <linux-arch-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-460432-1526284998-2-946867396136454057
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-charsets: plain='us-ascii'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: linux@kroah.com
X-Delivered-to: linux@kroah.com
X-Mail-from: linux-arch-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1526284998; b=jDRy8Vtm1DE1clo2nM9M0SQ6+LnDemRwlq11e0H1w+vZKDEFGd
    wTuiUsbWXvuP+Viu+piGWvipYM43O38bXJ+k5+TYyfN+m6kmVKHGomfHQMxH/NOz
    WLoG5yQcQrPkOeYQoFVjsAEomnJzUGc7zra6Ago9Pg9jfAqKch/UP0p/zOcnlFxZ
    YdJJefSMSDmnT+Yb8/xt+XsBIKV2tX+KfteZmVRJfd/6j1VgUaVsOsL5/xZXriOt
    38TzTot5PCTWYO5/kjikR7kiBumbi4SShzlCGZfzOQTCifT0DV7L1VkrErJpXfSe
    P9EuP42tvFvaLV29yj2kiAVg7aPHbrs+cA2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=fm2; t=1526284998; bh=v0/F56yMF/2fs2FKNBEkVxtk+mGsfW
    11wxwbZaGPses=; b=TR48JIlfdA+QbnT8w2xgPgXycxRR03bbLC7qodOzlxPIAD
    XmDboacskqhuCIdA0/ca35O1AoMAHjjLpJ5Zel7uW1/2iEI5waUuPQNSVC2Ofy0T
    T4SAp0TBRCR+zgA+3P+AYk6YxElfCbexLyPguW2IxBMA4KPhgiMevRiqMIqprn1d
    xYqJR50U85FFSvQDqvzL/7l8oYV6utGbu0+ka068CZT5ldE8jcvvq01tG8kDzCZc
    NpJqO6Q0BxJy8QrHDeL73N+Z6KS+ENhFYqT5CrDt46yaXkhbmUPcUmse5WdBl9dz
    Q5tS1Ud6L2aBKkIoRd2repe9ojMmDv6+HcXOlkJw==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256)
    header.d=gmail.com header.i=@gmail.com header.b=XmkYXdzl x-bits=2048
    x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-arch-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=orgdomain_pass (Domain org match);
    x-cm=none score=0;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key)
    header.d=1e100.net header.i=@1e100.net header.b=RjkHkQme;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=kernel.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256)
      header.d=gmail.com header.i=@gmail.com header.b=XmkYXdzl x-bits=2048
      x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-arch-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=orgdomain_pass (Domain org match);
    x-cm=none score=0;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key)
      header.d=1e100.net header.i=@1e100.net header.b=RjkHkQme;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=kernel.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfCaH3HI1Z2j10JBIrX87hhFTiARUJEx3vz3DNn21VJD15AwmbV0G02/oa+z3LaBaUE/7zWAKSxBnTdpAU0lnFOlWw9nX2DB5HDZPxbL1/oB8vSIUIHpI
    ElSoEsx/s8fsGbnFzJMguSeEmPCEz8xXasvLJZ9OCkmqdATj3VHyYgn1sG+vYF9SF/vBSjX8KMfqX1ndsDTJ4scvdVdkOJiBPd4KxiFpzvGZBFn7YGLrw0j1
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=kj9zAlcOel0A:10 a=VUJBJC2UJ8kA:10
    a=K9VAyNEq3_vycPRa338A:9 a=CjuIK1q_8ugA:10
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751664AbeENIDN (ORCPT <rfc822;linux@kroah.com>);
        Mon, 14 May 2018 04:03:13 -0400
Received: from mail-wr0-f196.google.com ([209.85.128.196]:35669 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752153AbeENIDK (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 14 May 2018 04:03:10 -0400
X-Google-Smtp-Source: AB8JxZqxw5gMG/3bBObJHcrevTkUzmixnVNzJW9bjMwvXAkLra3Kxy+8fhcVMAbRzp1aCUFhbwyZ1w==
Date: Mon, 14 May 2018 10:03:05 +0200
From: Ingo Molnar <mingo@kernel.org>
To: Jiri Slaby <jslaby@suse.cz>
Cc: mingo@redhat.com, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>, hpa@zytor.com,
        jpoimboe@redhat.com, Juergen Gross <jgross@suse.com>,
        Len Brown <len.brown@intel.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-pm@vger.kernel.org, Pavel Machek <pavel@ucw.cz>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        xen-devel@lists.xenproject.org, x86@kernel.org
Subject: Re: [PATCH -resend 01/27] linkage: new macros for assembler symbols
Message-ID: <20180514080305.GA6607@gmail.com>
References: <20180510080644.19752-1-jslaby@suse.cz>
 <20180510080644.19752-2-jslaby@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180510080644.19752-2-jslaby@suse.cz>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-arch-owner@vger.kernel.org
X-Mailing-List: linux-arch@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>


* Jiri Slaby <jslaby@suse.cz> wrote:

>  Documentation/asm-annotations.rst | 218 ++++++++++++++++++++++++++++++++
>  arch/x86/include/asm/linkage.h    |  10 +-
>  include/linux/linkage.h           | 257 ++++++++++++++++++++++++++++++++++++--
>  3 files changed, 475 insertions(+), 10 deletions(-)
>  create mode 100644 Documentation/asm-annotations.rst

Could you please split the documentation patch from the header file changes?

Thanks,

	Ingo
