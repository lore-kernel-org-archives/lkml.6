Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2636737-1522254072-2-16852652708535894244
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='utf-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1522254071; b=shev6b5nzEOSZ0frdcm79P0vUWfK+lBz/2FW+rUhuZVVgXE
    3kE5cM1FDXyF1AwqOAP7ZDzCdrUV/IBYtPAkUpnKdOuwvbxkJWR2tOUgnfPekr4k
    gHVgr8d3qD0mYCmFTMOwSwWmPkX+pOMPrGrVQhlOyvoxMY6DT7dZNUrvsUPnqEts
    VTfhLmcCRi+NO6Abz7URkXJONCE8ye6mGpBkeJGJMlaXvTBolEvBzI7BShtYVjxc
    hDbTpznovMuVP0xYrRpC9va9/T4IQMcKHLa7Ekxx+3LtY1ZNHuGbx/hSc2g/Jk5c
    ifOK4WYwzw0A2YeK0/rGbEJK3YX4IJhbQ6iSq/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:subject:message-id
    :references:mime-version:content-type:content-transfer-encoding
    :in-reply-to:sender:list-id; s=arctest; t=1522254071; bh=bljGeGg
    dWkkt9PDjui62sad6a13NhvpzQIbkuqEIZD4=; b=u6XAlnwrOFm1434CJfGB/B8
    oNnjJV80jHMZQt/qUUmpNAET8qjb6WItLCv/ATq/n3x/p2qlcfWCl6sG2RnLuoNH
    SsWBS7h09whK7UUAuF7yrcFWhiAiQ8zmVfp+S8vaATb68AjPmEIN5j8ESGOabZPJ
    FvLUXBKJCncLiIPdOF/Zmj7mksM7no1oSv6umzFn1kqSrOrFGMZ0GeuyaJtRLkCp
    Up/4WLCLzBznCFVrcFviZC/Ohe1F3yFQqLvzfYwxIXSqxbdthwUhn1rcmbPBaK2h
    c7lo6nDj5xvdhgkTw27W4T3/lA+38QBhfbfTNKibMU7+1PrXCkMGb1Jv+gtQlaA=
    =
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=0 state=0
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=0 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfIJ6f9E+yfM21ABy+8Qk2DV+uGovmiDQs2mPjSXG7ixVrEcfg/P6Vk3j05/zax87V2rpKmffPkWIuTp/ZRMmizze68cB73CFYYesTU3i2fohwog1MmlX
    yypzmaWeYXo9c/ZVHV6lnjtKqAv6+NY0ka7+0rWbP94zSzzEizLHX8X57NjckNcZuJFRlZ71rd6C2cVA4HUp4v4Do1nUtMm5sDtkxG/OFT8ElUQ97n/o6u8h
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=ONKqiAgnDjwA:10
    a=v2DPQv5-lfwA:10 a=MA8sFzkSdeMp4f0XEOcA:9 a=QEXdDO2ut3YA:10
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752727AbeC1QVI (ORCPT <rfc822;greg@kroah.com>);
        Wed, 28 Mar 2018 12:21:08 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:51580 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752694AbeC1QVI (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 28 Mar 2018 12:21:08 -0400
Date: Wed, 28 Mar 2018 18:21:04 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net,
        shuahkh@osg.samsung.com, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
Subject: Re: [PATCH 4.9 00/67] 4.9.91-stable review
Message-ID: <20180328162104.GC9211@kroah.com>
References: <20180327162726.702411083@linuxfoundation.org>
 <20180328013501.vdeqlxn525m4cex6@xps>
 <20180328082145.GB14201@kroah.com>
 <20180328155035.i2grmx6imfha6pdw@xps>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180328155035.i2grmx6imfha6pdw@xps>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, Mar 28, 2018 at 10:50:35AM -0500, Dan Rue wrote:
> On Wed, Mar 28, 2018 at 10:21:45AM +0200, Greg Kroah-Hartman wrote:
> > On Tue, Mar 27, 2018 at 08:35:01PM -0500, Dan Rue wrote:
> > > qemu_x86_64
> > > * boot - pass: 21
> > > * kselftest - skip: 28, pass: 52
> > 
> > Do you have a list of what you are skipping anywhere?  There was some
> > x86 changes that I had to backport that I was worried about getting
> > right here, are you running the x86 kselftests?
> 
> Yes we run the x86 selftests. Here's the full list of what ran and what was
> skipped. Remember (I know you know, but for anyone else observing), we
> run kselftest from 4.15.

That's good, as kselftest from 4.9 was a bit broken for x86, which is
why I backported a bunch of patches for it for this release :)

>  breakpoint_test — SKIP
>  efivarfs.sh — SKIP
>  fsgsbase_64 — SKIP
>  ftracetest — SKIP
>  fw_fallback.sh — SKIP
>  fw_filesystem.sh — SKIP
>  gpio-mockup.sh — SKIP
>  ldt_gdt_64 — SKIP
>  main.sh — SKIP
>  mem-on-off-test.sh — SKIP
>  pstore_tests — SKIP
>  reuseport_bpf — SKIP
>  run.sh — SKIP
>  run_vmtests — SKIP
>  seccomp_bpf — SKIP
>  sigreturn_64 — SKIP
>  step_after_suspend_test — SKIP
>  sync_test — SKIP
>  sysctl.sh — SKIP
>  test_align — SKIP
>  test_dev_cgroup — SKIP
>  test_kmod.sh — SKIP
>  test_lpm_map — SKIP
>  test_lru_map — SKIP
>  test_maps — SKIP
>  test_progs — SKIP
>  test_tag — SKIP
>  test_verifier — SKIP

Figuring out of any of these are from the tools/testing/selftests/x86/
directory is a pain, that is the tests I was referring to here...

That being said, why are you skipping so many?  ldt_gdt_64 should be
run, what fails with it?  Same for sigreturn_64, which I think means
that only 2 tests from the x86 directory are being skipped, right?

Have you gone back and looked at any of those other tests to see why
they are being skipped?

thanks,

greg k-h
