Return-Path: <SRS0=Xm/m=NJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5F2AC0044C
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 20:27:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 549DD2084A
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 20:27:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="lvqRDg+4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 549DD2084A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sifive.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729686AbeJ3FSO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Oct 2018 01:18:14 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:35102 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728958AbeJ3FSN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Oct 2018 01:18:13 -0400
Received: by mail-pf1-f194.google.com with SMTP id z2-v6so2017032pfe.2
        for <linux-kernel@vger.kernel.org>; Mon, 29 Oct 2018 13:27:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=LY6lAqNcxExcV8lgaM2ag9Fc+YtefJStleIDC6qqA4E=;
        b=lvqRDg+4iSlL4MZl8ndBGJP+QSX5XmYJq5VakzPcAbooaiEnekl/rfkZSYbgiQH9KL
         fM6TDGu5qwBUyD+VCbwbPosFZYQySGZmkN6gRyukuEbCm6zRvLbQvbhyaVPIpN6H7n6w
         ixwhKDoW/3X3C5a7bI18UmMqjneNdrvAVLCR1NEDeoZ8KXZjVP1Y5ZD6RBpumSXaHRy8
         czLu5lyFuBeMgqMHTu1MN2FDGIFz0hN7O3F1xI6eyVB7jE7SsIp5feX8llCEdnWwskrw
         aco8ZmLcR2XrzhJ8QLYYXyRdcU5Th0+a/MjtQ8R37SpmNh/QMFgmR8xl71O6G6c0YoCv
         ZUYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=LY6lAqNcxExcV8lgaM2ag9Fc+YtefJStleIDC6qqA4E=;
        b=HQiyOuo/8MOpxAISmTdexPaxItliiji+t/dPE665YbMG1J7Agm8l/+BDLaT0wZUJpz
         oBVmJ0MbB0asH4WJ97sYAgvBawOU/2IzoFcfDvSIcJR4eHJJgPtjiifDaxqnhTOrjZtG
         MTc0AgkYh9gGAucMbfXpfPGv/3eIcH4skubxB12hxXKXv9ey5HJPsbHaLUTivPXwQ8fF
         VHwgdhYYflCjoTlBW2n//Z5UbUzGCPo2F6dCdGpEkvwNH6TCLsE7iwwqMTuHBvag7Z6g
         IvgHUDKaxQEe+2zy/JIOZ/azzgmR5Si1/UlurpU6jwp5xfU3oVk3m9o1JQIzuOUtItwa
         SEOQ==
X-Gm-Message-State: AGRZ1gIxzDuTVk2TGnYTidA5NOiIMaxsJlBBZDz+eNA3jFivzfhJ0g30
        y40Ht+94ZkYR/KoeGVTHsjZDSg==
X-Google-Smtp-Source: AJdET5fs5W4DvrTb2ce1Wspf37l962LiK9MI87zj08O7FgqxeY1EvFPp/YiF1Fi0Z18HtYJPdgCZFQ==
X-Received: by 2002:a65:594b:: with SMTP id g11-v6mr13109817pgu.229.1540844876300;
        Mon, 29 Oct 2018 13:27:56 -0700 (PDT)
Received: from localhost ([12.206.222.5])
        by smtp.gmail.com with ESMTPSA id k86-v6sm37831175pfb.167.2018.10.29.13.27.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 29 Oct 2018 13:27:55 -0700 (PDT)
Date:   Mon, 29 Oct 2018 13:27:55 -0700 (PDT)
X-Google-Original-Date: Mon, 29 Oct 2018 13:12:12 PDT (-0700)
Subject:     Re: [PATCH 2/2] RISC-V: Add support for SECCOMP
In-Reply-To: <CAEn-LTonSqSG8GtgVmwt7ToJ2NZKsGEaWndmA0Q7Lzm316CFbA@mail.gmail.com>
CC:     paul@paul-moore.com, linux-riscv@lists.infradead.org,
        aou@eecs.berkeley.edu, eparis@redhat.com, keescook@chromium.org,
        luto@amacapital.net, wad@chromium.org,
        Wesley Terpstra <wesley@sifive.com>, dhowells@redhat.com,
        tglx@linutronix.de, pombredanne@nexb.com,
        Greg KH <gregkh@linuxfoundation.org>,
        kstewart@linuxfoundation.org, linux-kernel@vger.kernel.org,
        linux-audit@redhat.com
From:   Palmer Dabbelt <palmer@sifive.com>
To:     david.abdurachmanov@gmail.com
Message-ID: <mhng-71c7a4db-432a-4f97-86cd-1fe16091a6c8@palmer-si-x1c4>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 28 Oct 2018 04:07:55 PDT (-0700), david.abdurachmanov@gmail.com wrote:
> On Thu, Oct 25, 2018 at 10:36 PM Paul Moore <paul@paul-moore.com> wrote:
>>
>> On Thu, Oct 25, 2018 at 2:31 PM David Abdurachmanov
>> <david.abdurachmanov@gmail.com> wrote:
>> > On Wed, Oct 24, 2018 at 10:40 PM Palmer Dabbelt <palmer@sifive.com> wrote:
>> > > From: "Wesley W. Terpstra" <wesley@sifive.com>
>>
>> ...
>>
>> > Palmer,
>> >
>> > Half of the patch seems to touch audit parts. I started working on audit
>> > support this morning, and I can boot Fedora with audit traces.
>> >
>> > [root@fedora-riscv ~]# dmesg | grep audit
>> > [    0.312000] audit: initializing netlink subsys (disabled)
>> > [    0.316000] audit: type=2000 audit(0.316:1): state=initialized
>> > audit_enabled=0 res=1
>> > [    7.288000] audit: type=1130 audit(1529665913.772:2): pid=1 uid=0
>> > auid=4294967295 ses=4294967295 msg='unit=systemd-remount-fs
>> > comm="systemd" exe="/usr/lib/systemd/systemd" hostname=? addr=?
>> > terminal=? res=success'
>> > [    7.684000] audit: type=1130 audit(1529665914.176:3): pid=1 uid=0
>> > auid=4294967295 ses=4294967295 msg='unit=systemd-sysctl comm="systemd"
>> > exe="/usr/lib/systemd/systemd" hostname=? addr=? terminal=?
>> > res=success'
>> > [..]
>> >
>> > I am still working on audit user-space support for better testing.
>> >
>> > I suggest we first implement audit and then seccomp.
>>
>> FYI, while small and far from comprehensive, we do have a test suite
>> we use for basic validation of the audit kernel bits which may be
>> helpful while you're working on the audit enablement:
>>
>> * https://github.com/linux-audit/audit-testsuite
>
> Currently I checked the following to work:
> - /proc/self/loginuid (required by DNF [package manager])
> - auditctl (checked several different example rules from internet)
> - aulast
> - aulastlog
> - ausearch
> - ausyscall
> - aureport
> - autrace (compared some syscalls to strace: order and
>   return value/input arguments seems to be correct)
>
> I checked audit-testsuite yesterday and it seems to be only for
> x86-64 / x86-32. After adjusting it (MODE, syscalls) I am at:
>
> Failed 4/14 test programs. 19/88 subtests failed.
>
> I don't plan to look further in the failure, e.g.:
> - syscall_socketcall: that's an old stuff and not relevant to
>   new arches
> - syscall_module: Fedora kernel currently is not compiled
>   with kernel loadable module support
> - filter_exclude: two tests fail because id -Z doesn't print
>   any categories, but "semanage login -l" output is identical
>   between x86_64 and riscv64
> - netfilter_pkt: don't have CONFIG_IP_NF_MANGLE enabled
>
> Fedora kernel currently has minimal CONFIG_* options
> and is built without loadable module support.
>
> I will send the patches for review soon.

Thanks!
