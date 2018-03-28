Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2888441-1522261715-2-17977345435171891105
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
    t=1522261714; b=cw3SGDQ/4yS/JZfMpkldKOozInyMxow0BdWXgACRMKJcQ4u
    chFWW6C0nRNz8IyY5cfqGt1rPZdlrdEylMkT4wOTzC3s95KC8SILsJk/XJTyHEoc
    OBkroAri3WUjUZXy40zwBZXbIf+ouI+SjodP4Q5RdMGbA29ALm+6K6FLL+fsX607
    3ImUnt6nwj0Mgi5Z1aSpAJGELpzgU7gaMxu3vgjFLnvo3YzNl3W4CirautKVig8m
    OhcUFlU27CDwhld50XvfQfJPLOBE0qfucB5BljdGyGLytAxnPDtURzxjVPQMPc+7
    Rb49R51F6tItxBMsR9ZtLGjIwak/wdXpkgnIuKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:content-transfer-encoding
    :in-reply-to:sender:list-id; s=arctest; t=1522261714; bh=zNUWfC+
    vy4SeqlWLudSJvXadMeg4gR/AGDIFbQPl3hE=; b=t5sMZzC3IC6vn2MUDwE0/Wd
    FtHQ28WnTw7/+4PrOtIEcir5uNWsPy865Z7kxIfsYfnMqCtBRKFJmHNku593D2Vb
    B9GcriKAY75AjR2E5AM4UCOC9XkqF0lJB75HfJzDYm/fW1Wa/TWe2RE6loqO8W8i
    IVjv1GeLDtOicQG9/zmL4q+euqilUmCBsm7t4bP0QxPWwqcKCPabDJuEc93qwIi9
    yiHTnXePPa1rF+Qk0NzzHHN6g4zQmHzUr9W6z9I742T+ZqGRSmM5qV7Uc5XGKtL8
    PAuScZhKVZMD9YgdtYBMxVTRTXnyHCgHjYg3U8l+peZFvw/jIBQFzPOArxOeUIg=
    =
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=linaro.org header.i=@linaro.org header.b=DoEj1K7x x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=google;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=linaro.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=QtsnicOH;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linaro.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=linaro.org header.i=@linaro.org header.b=DoEj1K7x x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=google;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=linaro.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=QtsnicOH;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linaro.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfMzmJV92K+adUKWHtbqlXiYeruDPz7q83CeRzBINZKGXeV0s1U4dmWOYRot6AvZZ2cJnZiRWaNuh/gpq8vK4o+4JaZrsOsyP+mqRWpoUmkpEKs8KhwJ7
    ofzFvjdcpsNINlW7GtnIEvhiFxkwdOvZkPT0VEl2bd6bhDgyP6vKFffouNVxOu/7xeeTXeYp+iZZbdWwF+fRqOe/nP2SGnX0b9y4m/AxUMHjq/djS0KohxDH
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=ONKqiAgnDjwA:10
    a=v2DPQv5-lfwA:10 a=KKAkSRfTAAAA:8 a=SVDQ7S_DnNdMT4gQiUcA:9 a=QEXdDO2ut3YA:10
    a=cvBusfyB2V15izCimMoJ:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752572AbeC1S2b (ORCPT <rfc822;greg@kroah.com>);
        Wed, 28 Mar 2018 14:28:31 -0400
Received: from mail-it0-f66.google.com ([209.85.214.66]:37558 "EHLO
        mail-it0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752457AbeC1S2a (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 28 Mar 2018 14:28:30 -0400
X-Google-Smtp-Source: AIpwx48bxoSsIOwfQlVZCyYG3+VYA0vlsNNpL1au9FkwMQ98esj/TwHagqagk7tOjs0kBGZ6A5MXNg==
Date: Wed, 28 Mar 2018 13:28:28 -0500
From: Dan Rue <dan.rue@linaro.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net,
        shuahkh@osg.samsung.com, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org, Anders Roxell <anders.roxell@linaro.org>
Subject: Re: [PATCH 4.9 00/67] 4.9.91-stable review
Message-ID: <20180328182828.ffbl6r3gifyvmzio@xps>
Mail-Followup-To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net,
        shuahkh@osg.samsung.com, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org, Anders Roxell <anders.roxell@linaro.org>
References: <20180327162726.702411083@linuxfoundation.org>
 <20180328013501.vdeqlxn525m4cex6@xps>
 <20180328082145.GB14201@kroah.com>
 <20180328155035.i2grmx6imfha6pdw@xps>
 <20180328162104.GC9211@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180328162104.GC9211@kroah.com>
User-Agent: NeoMutt/20180223
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, Mar 28, 2018 at 06:21:04PM +0200, Greg Kroah-Hartman wrote:
> On Wed, Mar 28, 2018 at 10:50:35AM -0500, Dan Rue wrote:
> > On Wed, Mar 28, 2018 at 10:21:45AM +0200, Greg Kroah-Hartman wrote:
> > > On Tue, Mar 27, 2018 at 08:35:01PM -0500, Dan Rue wrote:
> > > > qemu_x86_64
> > > > * boot - pass: 21
> > > > * kselftest - skip: 28, pass: 52
> > > 
> > > Do you have a list of what you are skipping anywhere?  There was some
> > > x86 changes that I had to backport that I was worried about getting
> > > right here, are you running the x86 kselftests?
> > 
> > Yes we run the x86 selftests. Here's the full list of what ran and what was
> > skipped. Remember (I know you know, but for anyone else observing), we
> > run kselftest from 4.15.
> 
> That's good, as kselftest from 4.9 was a bit broken for x86, which is
> why I backported a bunch of patches for it for this release :)

I've noticed these backports. Should we expect to see selftests
supported in LTS kernels going forward? What is the current policy on
taking selftest backports?

> 
> >  breakpoint_test — SKIP
> >  efivarfs.sh — SKIP
> >  fsgsbase_64 — SKIP
> >  ftracetest — SKIP
> >  fw_fallback.sh — SKIP
> >  fw_filesystem.sh — SKIP
> >  gpio-mockup.sh — SKIP
> >  ldt_gdt_64 — SKIP
> >  main.sh — SKIP
> >  mem-on-off-test.sh — SKIP
> >  pstore_tests — SKIP
> >  reuseport_bpf — SKIP
> >  run.sh — SKIP
> >  run_vmtests — SKIP
> >  seccomp_bpf — SKIP
> >  sigreturn_64 — SKIP
> >  step_after_suspend_test — SKIP
> >  sync_test — SKIP
> >  sysctl.sh — SKIP
> >  test_align — SKIP
> >  test_dev_cgroup — SKIP
> >  test_kmod.sh — SKIP
> >  test_lpm_map — SKIP
> >  test_lru_map — SKIP
> >  test_maps — SKIP
> >  test_progs — SKIP
> >  test_tag — SKIP
> >  test_verifier — SKIP
> 
> Figuring out of any of these are from the tools/testing/selftests/x86/
> directory is a pain, that is the tests I was referring to here...

Agree. It would be nice if we preserved the directory name - I had the
same issue when trying to answer your question.

> 
> That being said, why are you skipping so many?  ldt_gdt_64 should be
> run, what fails with it?  Same for sigreturn_64, which I think means
> that only 2 tests from the x86 directory are being skipped, right?
> 
> Have you gone back and looked at any of those other tests to see why
> they are being skipped?

I'll try to keep this short - the tl;dr is that it's historical, and
something we're fixing now.

Originally, we just skipped everything that failed so that we could
focus on regressions. As new things failed, we have investigated them
and reported them upstream or fixed with patches. Over time, many of
these original failures have been resolved but the skipfiles may not
have been updated because...

Our skipfiles are per-branch and per-board, and we used to have one file
for each combination, resulting in dozens of files that ended up with
inconsistencies between them over time. So, we converted it to a
structured data format that is then parsed at runtime to generate a
skipfile for a given board/branch combination.

That work was just completed a couple weeks ago. Now that our kselftest
skipfile is a single structured data file[1], we need to go through it
and resolve all of the inconsistencies, remove the skips that have long
since been resolved, etc. This is work we plan to do in the next couple
weeks.

If you look through that file, you'll see quite a few things that are
wrong. When we're done auditing it, each skip should have a coherent
"reason" for skipping and an accurate branch/board list.

With regard to the specific tests you asked about:
- ldt_gdt_64: As of 4.9.89 this is still failing. I'll test again with
  the new RC.
- sigreturn_64: Passing on x86_64 (real hardware) and getting skipped on
  qemu x86_64. For some reason it fails intermittently on qemu in our
  environment.

Hope that helps,
Dan

[1] https://git.linaro.org/qa/test-definitions.git/tree/automated/linux/kselftest/skipfile-lkft.yaml
