Return-Path: <SRS0=v0ik=NZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B64BCC43441
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 19:24:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8183A22360
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 19:24:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=mena-vt-edu.20150623.gappssmtp.com header.i=@mena-vt-edu.20150623.gappssmtp.com header.b="yGD54PGp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8183A22360
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=mena.vt.edu
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728872AbeKOF2c (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Nov 2018 00:28:32 -0500
Received: from mail-vk1-f176.google.com ([209.85.221.176]:37383 "EHLO
        mail-vk1-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727264AbeKOF2b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Nov 2018 00:28:31 -0500
Received: by mail-vk1-f176.google.com with SMTP id 197so3909485vkf.4
        for <linux-kernel@vger.kernel.org>; Wed, 14 Nov 2018 11:24:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mena-vt-edu.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=X8WlNkiA1Csr43Gr4rrvpTKkHaPLpKLBTw3XqDDomEo=;
        b=yGD54PGp4bfLP+IVazWds9FsWCMl8MWrl7MOSxcjciz/4VSwKSSLcO6OPbkyWzhz89
         S3rYN4yeL7YdndXp+vK08+5AR5ZmBNgWyJhAkBdHAxySmNwjL4RrSRrtz/YXLtxXjAaA
         58RDowkoNpylzN7qXGJ+JKOrRhjn508vno3c32pykQp6OubTNwKuwIZ8hLyJ8DKORMp0
         oqbsqOOnIC9zsv02l7mvzmqn4exFqa+E1+GH8koza1o66RvU/U3xNUazLoOgEVGUE32N
         S7fzcH+Z+AQgZIQjAQgsY+9Q7aYP2o+xQZNfAhrf0b1s6n+lrwzLhPhR6Rnak8vgRHWB
         nLUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=X8WlNkiA1Csr43Gr4rrvpTKkHaPLpKLBTw3XqDDomEo=;
        b=qTZ1Lz3Nk8yN2GrMsGDJBIKZ8vYtD9GgR2MJ3d8kr63C3UM4nQ2ZWF4eL3ENYY7len
         m7KIFhvrjgjDkfcdh7qOTdwyCwikvb/Q4+xj17dy5X2vlE8MrYu9fwvgRvlMMtvBFyaN
         RnFrbItABG5hqyK6qzivIfJo/88KCe9i8CFoiqaQmY3lhtaxUEWlBOs81qlJl8stVtrR
         RfwuRyGn/lwQNHMl6Lr0vIoEgLEKGAtvhIrl/lwegKyEICgSFQDHDsuV3KaxA1u3+Nb5
         bkXeszoh+0pB11YbSQ1HpOaD3gXSSXvsQdDjFSFK/67q0PfQ1XlExFHjUYD7GUhD/OZG
         pn+A==
X-Gm-Message-State: AGRZ1gLxqd6vZxYN3gGZcTabyyFdMwrhM/FWME82rx77XgGkFPf6CSvP
        hK002uQrRqaK/fPxY0LxUtrE/LZeYM667RNWBEkIQQ==
X-Google-Smtp-Source: AJdET5dCxbooZy+cexUiDh/DlVJLfx0nqJgb50zDtY3Vw9XD/jFeFkWVqm62IhhAlWyNDn2kJt+eUsUps45Sk5JaERE=
X-Received: by 2002:a1f:9042:: with SMTP id s63mr1362688vkd.17.1542223441804;
 Wed, 14 Nov 2018 11:24:01 -0800 (PST)
MIME-Version: 1.0
References: <CANBxJ=EQOt1t=PkLsMvtfB2SbiLMPeGvFxB7SJXf7m3OkcionQ@mail.gmail.com>
 <20181114180807.6crs7awhvo26ldbr@hawk.localdomain> <CADYN=9Jh10guVNFfhS8XH+RwZAouLJQu7Svg4+Tz3rQDexzDkg@mail.gmail.com>
In-Reply-To: <CADYN=9Jh10guVNFfhS8XH+RwZAouLJQu7Svg4+Tz3rQDexzDkg@mail.gmail.com>
From:   Ahmed Soliman <ahmedsoliman@mena.vt.edu>
Date:   Wed, 14 Nov 2018 21:23:41 +0200
Message-ID: <CANBxJ=G4xdF8ZOR4zyoX1edNa=jYxk1xrzoi+7Xgcqt9qDoM2w@mail.gmail.com>
Subject: Re: KVM selftests are failing
To:     Anders Roxell <anders.roxell@linaro.org>
Cc:     Andrew Jones <drjones@redhat.com>, Shuah Khan <shuah@kernel.org>,
        linux-kselftest@vger.kernel.org,
        Paolo Bonzini <pbonzini@redhat.com>,
        Peter Xu <peterx@redhat.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

> > I couldn't reproduce this on a Westmere. Are you sure you're testing
> > a clean compilation? Can you bisect the kernel?
I don't do a make clean normally, but I will do it this time when
bisecting, also I only use shallow
 clones so it will also take some time pulling. Also to note, The arch
I am using is Haswell, I am not
sure if that should make any difference though.
> What would be the difference in CONFIG_* fragments that you both have enabled?

Here is my config file:
https://pastebin.com/fCNV2z8c

Thanks,
-- 
Ahmed,
Junior Researcher, IoT and Cyber Security lab, SmartCI, Alexandria
University, & CIS @  VMI
