Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-744240-1520873118-2-14157336445039770007
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='net', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520873117; b=j3g62QVfq/UPc5N7vIARUBQer4tGp0LLRFhWgZ+TdvpHIER
    q3s9VluFQKDY8Bg/1hl9mw7YN2B8yUm7sZ7b43S2cczpPa0d9B+MMtPoKNaWCooi
    DlD5OAzazwjAZqHu/DPaVNTleJSQ1lguuhxZ/209KUPUkBv2nkmOBZiK4eraFjyj
    27LT3cbMx+Or87d5jfo989Ay/qWIpaXksFTX2/XLkte3ozhu/QkskuAlhunk0x3+
    sRbPTeu5HHZ7UDW0v3F5XIqDIiC+B87fmFQEQO2eDlhNsAvNVaYY0P5YkQxu9k9c
    81NSX3TtP8TnZczzf0AKjFwFj1XRlYq5G+cmyGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=arctest; t=1520873117; bh=1ZzvGP4DICQaTSyKeVphmNJsvu
    UATDAU5V1s5JoRquI=; b=aeb9SrlGXYa4dvAGtLI7+VpfyYz7YRYZ054s4H2YME
    6op+9OrJh4d9kmbz4jy3VWqHsg3Miun9IopOX1+FjZidPPXO/pusaXLVZQUDuyTE
    Lzw+zwVmZO3oUdK15CVB0Q06lSmNGc7bcNRVaNXqjVtjbMtikWvi/xgqAaoWkFSV
    wfIoghhLnnsNlGhCuQzht9Hh5KAAwlH5YuerlZvCjvjkAwv+N1TddJgCjlPneAe5
    3Qs8aXzDE0G0yu+mackgF+pgvz4NX+AZvAzwzlr4tPophl/oKE2oEtjVCQ4ArzyV
    qZuYJsUH/qJ0xuWBIQPaUIAKGm/1EiG/6zfR2/4T2ZQQ==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=IVVplE5b x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=roeck-us.net;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=0 state=0;
    x-google-dkim=fail (message has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=F/UY+GJb;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=roeck-us.net header.result=pass header_is_org_domain=yes
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=IVVplE5b x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=roeck-us.net;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=0 state=0;
    x-google-dkim=fail (message has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=F/UY+GJb;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=roeck-us.net header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751554AbeCLQpQ (ORCPT <rfc822;greg@kroah.com>);
        Mon, 12 Mar 2018 12:45:16 -0400
Received: from mail-ot0-f195.google.com ([74.125.82.195]:41407 "EHLO
        mail-ot0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751458AbeCLQpP (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 12 Mar 2018 12:45:15 -0400
X-Google-Smtp-Source: AG47ELu3/6H+WehXc0T/Af8LMImYUvAA4WjHavIgPgDqQTJuBVLcqkAran+FIXODO4gKx0NfXLGbug==
Date: Mon, 12 Mar 2018 09:45:12 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Ben Hutchings <ben@decadent.org.uk>
Cc: linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        torvalds@linux-foundation.org, akpm@linux-foundation.org
Subject: Re: [PATCH 3.16 00/76] 3.16.56-rc1 review
Message-ID: <20180312164512.GA9933@roeck-us.net>
References: <lsq.1520823971.5976735@decadent.org.uk>
 <20180312150053.GB3917@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180312150053.GB3917@roeck-us.net>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Mon, Mar 12, 2018 at 08:00:53AM -0700, Guenter Roeck wrote:
> On Mon, Mar 12, 2018 at 03:06:11AM +0000, Ben Hutchings wrote:
> > This is the start of the stable review cycle for the 3.16.56 release.
> > There are 76 patches in this series, which will be posted as responses
> > to this one.  If anyone has any issues with these being applied, please
> > let me know.
> > 
> > Responses should be made by Wed Mar 14 12:00:00 UTC 2018.
> > Anything received after that time might be too late.
> > 
> 
> Build results:
> 	total: 136 pass: 136 fail:0
> Qemu test results:
> 	total: 115 pass: 112 fail:3
> Failed tests:
> 	mipsel:24Kf:malta_defconfig:smp:rootfs
> 	mipsel64:malta_defconfig:nosmp:rootfs
> 	mipsel64:malta_defconfig:smp:rootfs
> 
> The failures are due to newly added tests; the init process crashes.
> v3.16 passes those tests, so the problem was introduced later.
> I'll run a bisect later to see if I can find the culprit. If not,
> I'll drop the new tests from this kernel version.
> 
Turns out I did the bisect kalready. Attached. It does suggest that there
may be a real problem.

Guenter

---
# bad: [3e50cd97ed730bb0abfcdbc8c1a18871c2750c33] Linux 3.16.55
# good: [19583ca584d6f574384e17fe7613dfaeadcdc4a6] Linux 3.16
git bisect start 'HEAD' 'v3.16'
# good: [d1afef76e102be87955151c93bd51fd04c1c0c01] arm64: mm: ensure that the zero page is visible to the page table walker
git bisect good d1afef76e102be87955151c93bd51fd04c1c0c01
# good: [b6927bd60d353de044584ab9400aaccd8694fe1e] can: Fix kernel panic at security_sock_rcv_skb
git bisect good b6927bd60d353de044584ab9400aaccd8694fe1e
# good: [aa9a2ec0e82b64db1851d96ab1e9c83f8ea17a39] ARM: kexec: Make .text R/W in machine_kexec
git bisect good aa9a2ec0e82b64db1851d96ab1e9c83f8ea17a39
# good: [bf5ac638a0ffa923ed03ba8cdb8241b812f5fe4f] can: gs_usb: fix busy loop if no more TX context is available
git bisect good bf5ac638a0ffa923ed03ba8cdb8241b812f5fe4f
# good: [957a3d249cb16292a199f73b7138d23ee44ca433] Revert "x86: kvmclock: Disable use from vDSO if KPTI is enabled"
git bisect good 957a3d249cb16292a199f73b7138d23ee44ca433
# bad: [66fe40226beb16fb7809d275aec362f479388935] USB: serial: option: adding support for YUGA CLM920-NC5
git bisect bad 66fe40226beb16fb7809d275aec362f479388935
# good: [0b6433856a149885470f2ab3a138e99347c323a4] arm64: fpsimd: Prevent registers leaking from dead tasks
git bisect good 0b6433856a149885470f2ab3a138e99347c323a4
# good: [d6e7dd39a7f036eb3e48032d68d9e70f2e9781cf] MIPS: Clear [MSA]FPE CSR.Cause after notify_die()
git bisect good d6e7dd39a7f036eb3e48032d68d9e70f2e9781cf
# bad: [d97c5dd698a37a6f4fcce8132853620f7390f797] MIPS: Fix an FCSR access API regression with NT_PRFPREG and MSA
git bisect bad d97c5dd698a37a6f4fcce8132853620f7390f797
# bad: [b18b5d55c0e8b2bccda919f5f227ec3ba1056f2a] MIPS: Fix a preemption issue with thread's FPU defaults
git bisect bad b18b5d55c0e8b2bccda919f5f227ec3ba1056f2a
# good: [0efd2f915bbc608f66065c36b291d37efe0a0b0f] MIPS: Always clear FCSR cause bits after emulation
git bisect good 0efd2f915bbc608f66065c36b291d37efe0a0b0f
# bad: [3127c502272aca5f46b04c0b11afb464ad4fcbaf] MIPS: math-emu: Define IEEE 754-2008 feature control bits
git bisect bad 3127c502272aca5f46b04c0b11afb464ad4fcbaf
# bad: [8605aa2fea28c0485aeb60c114a9d52df1455915] MIPS: Set `si_code' for SIGFPE signals sent from emulation too
git bisect bad 8605aa2fea28c0485aeb60c114a9d52df1455915
# first bad commit: [8605aa2fea28c0485aeb60c114a9d52df1455915] MIPS: Set `si_code' for SIGFPE signals sent from emulation too
