Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3793448-1518000122-2-838283494975703442
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='name', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1518000121; b=R8i2JWvvSoWI9qlFjpDUusF95WpZymho3jVxrXgEMYP2hVT
    YSPR4a8CE3AE+Ik4CiSZS2zEGLW0vUlfSvxiDi2x3SCU7JV0+RZjfbd7ioEL6Epd
    sHzWckTnva/8MR2vZzYzWJ99a7AFP0FBhASSWxTNs5KJxJPNhHv92CXvTT9FdAev
    EWd0WIc9SOFyXeRfVTsu47J/uoIzMGerWRh8POVMWJm19vPhQRx+Bki/+HtT6VAJ
    eKJoDI7e/SApVq4pmma9mOpLYJNZ9g3p+flq0bnPDlpiUMdIMhP5i1TedWkO40K3
    9rNq4jWK5R0fpV8QZsumUWcf9jRC3to9e/CrKTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=arctest; t=1518000121; bh=OOerMRzAQ3g037+Ooorb6xfGmM
    V0SweGVnVnyiXR7qA=; b=H1FVmXAp40EUYsCFRhElS3JVHii/IjHyODqhoZWhfm
    tUY2M5u/XZLx5VQseLv0Z2KYWjZWJvHp3mcukq/Su88w2wIiUGe8qjY+1bRYuPi6
    rzO8t54mPmrwgDJ4KpR1MgVMrOaH1jCNkOiPRrfo/BZQFc8au7pZPLEb2mrGNpfT
    J48J9ytv6RsVOoR/+w6I7lxIkFElwZBhgOo0ZYeUUAt79hngCL3iYeQ2phxpmtAP
    kdZdwWdk+ocdSCS2zZfqP0g2mGz5Gga106+oyurfYzxhHwqST7ruFTdmlAqLKZJ7
    hNRbpx4lrk54ZwUQmG5BL9uXhq5hkyDNLcvjq7ldkmMg==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=shutemov-name.20150623.gappssmtp.com header.i=@shutemov-name.20150623.gappssmtp.com header.b=DU9/PXQB x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20150623;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=shutemov.name;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=lKNOZlVF;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=shutemov.name header.result=pass header_is_org_domain=yes
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=shutemov-name.20150623.gappssmtp.com header.i=@shutemov-name.20150623.gappssmtp.com header.b=DU9/PXQB x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20150623;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=shutemov.name;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=lKNOZlVF;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=shutemov.name header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753974AbeBGKlR (ORCPT <rfc822;greg@kroah.com>);
        Wed, 7 Feb 2018 05:41:17 -0500
Received: from mail-wm0-f65.google.com ([74.125.82.65]:50935 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753846AbeBGKlP (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 7 Feb 2018 05:41:15 -0500
X-Google-Smtp-Source: AH8x224Gb8g3Sm02lo7Eh8U2YAIIzhZ6rDdXp/GNP8veMcu0k2WpIkhmZMQTkitFRPf7kDb301jwSQ==
Date: Wed, 7 Feb 2018 13:41:11 +0300
From: "Kirill A. Shutemov" <kirill@shutemov.name>
To: Dou Liyang <douly.fnst@cn.fujitsu.com>
Cc: Mike Galbraith <efault@gmx.de>, Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Baoquan He <bhe@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Dave Young <dyoung@redhat.com>, kexec@lists.infradead.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Andy Lutomirski <luto@amacapital.net>, linux-mm@kvack.org,
        Vivek Goyal <vgoyal@redhat.com>,
        Cyrill Gorcunov <gorcunov@openvz.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@suse.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Subject: Re: [PATCH 4.14 023/159] mm/sparsemem: Allocate mem_section at
 runtime for CONFIG_SPARSEMEM_EXTREME=y
Message-ID: <20180207104111.sljc62bgkggmtio4@node.shutemov.name>
References: <20171222084623.668990192@linuxfoundation.org>
 <20171222084625.007160464@linuxfoundation.org>
 <1515302062.6507.18.camel@gmx.de>
 <20180108160444.2ol4fvgqbxnjmlpg@gmail.com>
 <20180108174653.7muglyihpngxp5tl@black.fi.intel.com>
 <20180109001303.dy73bpixsaegn4ol@node.shutemov.name>
 <1515469448.6766.12.camel@gmx.de>
 <d71ba136-71ba-333a-f99b-b8283e2dc545@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d71ba136-71ba-333a-f99b-b8283e2dc545@cn.fujitsu.com>
User-Agent: NeoMutt/20171215
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, Feb 07, 2018 at 05:25:05PM +0800, Dou Liyang wrote:
> Hi All,
> 
> I met the makedumpfile failed in the upstream kernel which contained
> this patch. Did I missed something else?

None I'm aware of.

Is there a reason to suspect that the issue is related to the bug this patch
fixed?

-- 
 Kirill A. Shutemov
