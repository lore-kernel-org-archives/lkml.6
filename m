Return-Path: <SRS0=A7nN=N3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDC6FC43441
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 12:00:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A62E620869
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 12:00:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=mena-vt-edu.20150623.gappssmtp.com header.i=@mena-vt-edu.20150623.gappssmtp.com header.b="xzRRjtnG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A62E620869
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=mena.vt.edu
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389598AbeKPWMh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 16 Nov 2018 17:12:37 -0500
Received: from mail-vk1-f172.google.com ([209.85.221.172]:39265 "EHLO
        mail-vk1-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727814AbeKPWMh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Nov 2018 17:12:37 -0500
Received: by mail-vk1-f172.google.com with SMTP id q80so5192193vka.6
        for <linux-kernel@vger.kernel.org>; Fri, 16 Nov 2018 04:00:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mena-vt-edu.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/Gzak1tGqGRi0tsfnGBj/tmhJ2enmKxdm7kA9W/Ztsw=;
        b=xzRRjtnGKKCMCkUcQGACoQfHRmsOYexzXxROuBBXE8NaTHb2ARC46JuhCPVNgw7kpn
         glRkWhQQycolGC1FM3bouJ+D2TkFdqM9rkMgEva189eJ5OhK7/1Sf0wH5uVNV7+FY1Er
         V7+i4c54CN5FXXNO8s1c5hOaRNpwMoqWeNw9mU+Fx0mwRiZE2k5V3mh5jWYATTur570u
         9mHoiY+lmW5ruxnfPxNGQ7p1NFEwl8zb7i+qlWJR6m8EtsJLOOGXIZ+NPRp6ZRKz4y3Y
         wUDETYvVG9gSUOEde328kDXAmi8PedC3yU3WuAgs7PyYUwESnbi9fjzEtZ496EmfQWd2
         oObg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/Gzak1tGqGRi0tsfnGBj/tmhJ2enmKxdm7kA9W/Ztsw=;
        b=ik0pMwxF/SNwdkxvWTOiSXxb1o8dJ14VARWp+P/1Gfz4NlNJzFEq5tJKDA8XZzkHSJ
         NYkQovBxbnEtz4DPu3VYgKsoeoPNLxofLOaMVFkmqa3ojdGYLwOjWWkPujVZh6Qk5mLH
         PvEZM/+7uOoYsHFVJiewuS8GFwEIlhuQ3+9+l2OSH7ltYmm1LhDLDXLzmVKxlv2jTLEt
         0NzALhLVuShFIuDrEuSsLSOr/Pz4DBPaKvMI5o76RA7uliVBtQjaPEMwwUZ4jRXo6a9F
         qd6wS/LJDX2ZQ5ig0/zRintS5R47361vO+K62scZvJnmIiUA9QoadKtdO5QQdhaGtv3D
         ImgQ==
X-Gm-Message-State: AGRZ1gLfpviGHhUOTK34Ix4GZxGONHodnTJMuEPNwOqZYapTHSDfq8NX
        eBOD1mhR0E7EcU5aatAGG9QA5sdUP9zg+5iIMN7PRQ==
X-Google-Smtp-Source: AJdET5fN/JyaAmIH+pKSYqI7P9MiZZNZOQMNIO2XTGJiqz/z8jT5L/SrYPWOmDZlvSD3q8JrVBPbGIEOME7/a2A+Y8Q=
X-Received: by 2002:a1f:1053:: with SMTP id g80mr4234019vki.90.1542369632826;
 Fri, 16 Nov 2018 04:00:32 -0800 (PST)
MIME-Version: 1.0
References: <CANBxJ=EQOt1t=PkLsMvtfB2SbiLMPeGvFxB7SJXf7m3OkcionQ@mail.gmail.com>
 <20181114180807.6crs7awhvo26ldbr@hawk.localdomain> <CADYN=9Jh10guVNFfhS8XH+RwZAouLJQu7Svg4+Tz3rQDexzDkg@mail.gmail.com>
 <CANBxJ=G4xdF8ZOR4zyoX1edNa=jYxk1xrzoi+7Xgcqt9qDoM2w@mail.gmail.com>
 <CANBxJ=EB8izWM8iLd49Uvd1z1O-gLvkGmiKNHjfHifFohj2xbg@mail.gmail.com>
 <20181115090203.5z25gwa2yznj6mmu@kamzik.brq.redhat.com> <CANBxJ=EHkuxKFoQw=K21o=9_FMhi_=on=Poq+ZF37eieoKV4zg@mail.gmail.com>
 <20181115145028.qijg7hjswcuabrt2@kamzik.brq.redhat.com> <CANBxJ=EGR=7RrO8ZtJFUwpNZRy_adjCObNtWtcMA=y4rLgeWaQ@mail.gmail.com>
 <87efbmqore.fsf@vitty.brq.redhat.com>
In-Reply-To: <87efbmqore.fsf@vitty.brq.redhat.com>
From:   Ahmed Soliman <ahmedsoliman@mena.vt.edu>
Date:   Fri, 16 Nov 2018 14:00:08 +0200
Message-ID: <CANBxJ=FDOpySC7w1fVbWCOy+ASO=A7WcsFiDJEcGtzWbYM6NqQ@mail.gmail.com>
Subject: Re: KVM selftests are failing
To:     Vitaly Kuznetsov <vkuznets@redhat.com>
Cc:     Anders Roxell <anders.roxell@linaro.org>,
        Shuah Khan <shuah@kernel.org>, linux-kselftest@vger.kernel.org,
        Paolo Bonzini <pbonzini@redhat.com>,
        Peter Xu <peterx@redhat.com>, linux-kernel@vger.kernel.org,
        Andrew Jones <drjones@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello once again,

I noticed that there is still more problems with kvmself test (at
least on my machine)

Any test that would successfully reach the guest's code immediately
VMexit by a shutdown.

$ ./vmx_tsc_adjust_test
==== Test Assertion Failure ====
 x86_64/vmx_tsc_adjust_test.c:156: run->exit_reason == KVM_EXIT_IO
 pid=8499 tid=8499 - Success
    1  0x00005604f07bd36c: ?? ??:0
    2  0x00007f5c0dc53ae6: ?? ??:0
    3  0x00005604f07bd4b9: ?? ??:0
 Got exit_reason other than KVM_EXIT_IO: 8 (SHUTDOWN)

Also I have got a question I noticed 2 kvm test suites, kvm selftests
in tools/testing/selftests/kvm/
and this kvm unit test at [1] I am curious if I should put my tests in
the kvm unit test intead of kvm selftest


-- links --
[1] https://git.kernel.org/pub/scm/virt/kvm/kvm-unit-tests.git

Thanks
Ahmed,
