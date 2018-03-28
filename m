Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2629663-1522252242-2-16187593854431145553
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='utf-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1522252241; b=WDuNQzPDn1QE+5MuUeHcr6vcoI49UbvyJb/DYQb8V8Me9/9
    cXz0tzLo2IDYuO1poT/NXCqc4v9KJqS8VRmd8w7A3gfuSVbeS/jZkhJOppp1eu8V
    9mWssdIUY7wAcPlQbyebXLFR3DTjEIuSyXvklI0gRs90iv62BfULHNgzgYN0a+mB
    ZtnQMDFDfuCIElJNkjbuftlWFdOJMJQs5zYAxIOKZi9zBLkoHz1f3w7s+MutYKmn
    YKd/W2Xm7/YS7EJXSVc1gK+Lm5thjv9we5pk++OLv8d/hmM0Be5Ov78HoyyRHikJ
    KwFG+GyE0PbGf/xVcvGW4WG0lIQDIo204lf37hw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:content-transfer-encoding
    :in-reply-to:sender:list-id; s=arctest; t=1522252241; bh=7PCrhYT
    v9J8hVPbEfJXL7T0dED21JH3Mzw5Fvj/UyRA=; b=GzYrXCWzlzF6ujuARy3aR3I
    OHCsE01fhEXEBCrtS/++DwUfwznn6ukYcpPSlZRPk+Mi3XitjbkX1aFZj1MHRhgX
    OtAOhz2ap2y3MXPP2ouSytofmiDKk3++H7atrCz+Z4nhSK1RpDdByPycTkfx+lYo
    b1X9wKtEiIqzGQoT9s8Y/LxYr3jNDsnQ1o1aULL1+kvqJXknCY859opGvE3MgEoo
    8luRLHNQrLTX0a40d/CHBb1iXzWXTqyCUpvV8B/XUkseDzQOupctBShyGovuXm+R
    iXHzFM+L++31faN/Es96QEkM4JyB9uEzVu8lRnWlcAe1sDfK96jVw59aR/x4UkA=
    =
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=linaro.org header.i=@linaro.org header.b=jskXFpYU x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=google;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=linaro.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=dCcpoj5G;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linaro.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=linaro.org header.i=@linaro.org header.b=jskXFpYU x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=google;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=linaro.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=dCcpoj5G;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linaro.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfGwftWeslFhSEzTEbd0Fhw0GFvopmUrTecxAn83y0SB5/LbV7zUQO6XyAGuo1oIZsSiB6JhMqfWGNG/rj3NOy9HZ5dEXkZ5iebNQim0tGtKlSAmQ4sdn
    Cgh3mya/r42s3ey8nyYxy02QXbw/mdtAWumLci3oODAiwiWhEw8jsXZkJR10C6ilO/cwQSQG/H6LlYkHuULOgx+zJYlJZ1l6IYGobEXmTrCzmV6z7xvFUU+K
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=ONKqiAgnDjwA:10
    a=v2DPQv5-lfwA:10 a=BIzjpDPXgonyXe0_39EA:9 a=QEXdDO2ut3YA:10
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754036AbeC1Pui (ORCPT <rfc822;greg@kroah.com>);
        Wed, 28 Mar 2018 11:50:38 -0400
Received: from mail-it0-f51.google.com ([209.85.214.51]:55810 "EHLO
        mail-it0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753924AbeC1Puh (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 28 Mar 2018 11:50:37 -0400
X-Google-Smtp-Source: AIpwx49laehGCcprPHmbHywDXgFAueaks1E5N2iBIquHqCOpCeT8D8/oc+ukWNbak7c5Mamhjxacsg==
Date: Wed, 28 Mar 2018 10:50:35 -0500
From: Dan Rue <dan.rue@linaro.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net,
        shuahkh@osg.samsung.com, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
Subject: Re: [PATCH 4.9 00/67] 4.9.91-stable review
Message-ID: <20180328155035.i2grmx6imfha6pdw@xps>
Mail-Followup-To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net,
        shuahkh@osg.samsung.com, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
References: <20180327162726.702411083@linuxfoundation.org>
 <20180328013501.vdeqlxn525m4cex6@xps>
 <20180328082145.GB14201@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180328082145.GB14201@kroah.com>
User-Agent: NeoMutt/20180223
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, Mar 28, 2018 at 10:21:45AM +0200, Greg Kroah-Hartman wrote:
> On Tue, Mar 27, 2018 at 08:35:01PM -0500, Dan Rue wrote:
> > qemu_x86_64
> > * boot - pass: 21
> > * kselftest - skip: 28, pass: 52
> 
> Do you have a list of what you are skipping anywhere?  There was some
> x86 changes that I had to backport that I was worried about getting
> right here, are you running the x86 kselftests?

Yes we run the x86 selftests. Here's the full list of what ran and what was
skipped. Remember (I know you know, but for anyone else observing), we
run kselftest from 4.15.

 breakpoint_test — SKIP
 efivarfs.sh — SKIP
 fsgsbase_64 — SKIP
 ftracetest — SKIP
 fw_fallback.sh — SKIP
 fw_filesystem.sh — SKIP
 gpio-mockup.sh — SKIP
 ldt_gdt_64 — SKIP
 main.sh — SKIP
 mem-on-off-test.sh — SKIP
 pstore_tests — SKIP
 reuseport_bpf — SKIP
 run.sh — SKIP
 run_vmtests — SKIP
 seccomp_bpf — SKIP
 sigreturn_64 — SKIP
 step_after_suspend_test — SKIP
 sync_test — SKIP
 sysctl.sh — SKIP
 test_align — SKIP
 test_dev_cgroup — SKIP
 test_kmod.sh — SKIP
 test_lpm_map — SKIP
 test_lru_map — SKIP
 test_maps — SKIP
 test_progs — SKIP
 test_tag — SKIP
 test_verifier — SKIP
 5lvl_64 — PASS
 bitmap.sh — PASS
 check_initial_reg_state_64 — PASS
 cpu-on-off-test.sh — PASS
 default_file_splice_read.sh — PASS
 execveat — PASS
 get_size — PASS
 inconsistency-check — PASS
 ioperm_64 — PASS
 iopl_64 — PASS
 kcmp_test — PASS
 membarrier_test — PASS
 mpx-mini-test_64 — PASS
 mqueue-lat — PASS
 msgque — PASS
 nanosleep — PASS
 netdevice.sh — PASS
 nsleep-lat — PASS
 owner — PASS
 peeksiginfo — PASS
 pidns — PASS
 posix_timers — PASS
 printf.sh — PASS
 protection_keys_64 — PASS
 pstore_post_reboot_tests — PASS
 ptrace_syscall_64 — PASS
 raw_skew — PASS
 reuseaddr_conflict — PASS
 reuseport_dualstack — PASS
 rtctest — PASS
 rtnetlink.sh — PASS
 run_afpackettests — PASS
 run_netsocktests — PASS
 run_tests.sh — PASS
 sas — PASS
 seccomp_benchmark — PASS
 set-timer-lat — PASS
 single_step_syscall_64 — PASS
 syscall_nt_64 — PASS
 sysret_rip_64 — PASS
 sysret_ss_attrs_64 — PASS
 test_bpf.sh — PASS
 test_execve — PASS
 test_mremap_vdso_64 — PASS
 test_static_keys.sh — PASS
 test_user_copy.sh — PASS
 test_vdso_64 — PASS
 test_vsyscall_64 — PASS
 test_xdp_meta.sh — PASS
 test_xdp_redirect.sh — PASS
 threadtest — PASS
 zram.sh — PASS

 Dan
