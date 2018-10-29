Return-Path: <SRS0=Xm/m=NJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E6F5C0044C
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 12:58:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C37A92084A
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 12:58:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C37A92084A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=auristor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727828AbeJ2VrS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Oct 2018 17:47:18 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:45850 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725915AbeJ2VrS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Oct 2018 17:47:18 -0400
Received: by mail-ed1-f65.google.com with SMTP id t10-v6so7167650eds.12
        for <linux-kernel@vger.kernel.org>; Mon, 29 Oct 2018 05:58:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qy0MRBDkR4Ft4vynh8jZlaw/Gx3bmOahJQzVaMZyTEk=;
        b=lMaM1it6kVp1xSqdWcTXLa82tJZAiAzdY30TF3NktQueEyDNby97giYOxHGwzdYQAR
         EeHsYHp7qOjDonFjX61OYUH/NAVUqlh2nZ6DGfuBrCsewJY+kZazVCDoDtyvu3PsxovN
         wyc24OTwBbXRKZoYiXVNV0PZjBDR0IpzklVoNmWx8R+cJR+L+nQTeT/xrB+Vh3X2CkLZ
         Po1/5jIP43m9TPQRtYJ8a4m+pgleJYMV2F2/0ksrCIdEpHz7etYG12exLsmpV76p4sHA
         9SI1dW1YHDshrRYDONkMXdpKY7Gj8JdrDOlfUb+flRiKQkuCbLSUbjHA9qHzshpOQN2F
         tqPQ==
X-Gm-Message-State: AGRZ1gJqx2dQn+xLsYTlXj+ixmtJ/la3IZkIk2hhpbJoZ1bLiAF2nk0H
        te3I0AmJ4fB5aDo0bARVWq81gqsmamA=
X-Google-Smtp-Source: AJdET5cmqcAqeKYOtMi1pIlG/QpBRhVOuTsW639CZvgSU45LCnRoPHjviy/YgjOohRGq6UuqcYutFw==
X-Received: by 2002:a17:906:4ed9:: with SMTP id i25-v6mr7254038ejv.75.1540817922010;
        Mon, 29 Oct 2018 05:58:42 -0700 (PDT)
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com. [209.85.208.50])
        by smtp.gmail.com with ESMTPSA id o13-v6sm6195907edc.95.2018.10.29.05.58.41
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 29 Oct 2018 05:58:41 -0700 (PDT)
Received: by mail-ed1-f50.google.com with SMTP id e5-v6so7167916eds.6
        for <linux-kernel@vger.kernel.org>; Mon, 29 Oct 2018 05:58:41 -0700 (PDT)
X-Received: by 2002:a50:ba4d:: with SMTP id 13-v6mr13316955eds.239.1540817921197;
 Mon, 29 Oct 2018 05:58:41 -0700 (PDT)
MIME-Version: 1.0
References: <git-mailbomb-linux-master-5c83511bdb9832c86be20fb86b783356e2f58062@kernel.org>
In-Reply-To: <git-mailbomb-linux-master-5c83511bdb9832c86be20fb86b783356e2f58062@kernel.org>
From:   Marc Dionne <marc.dionne@auristor.com>
Date:   Mon, 29 Oct 2018 09:58:28 -0300
X-Gmail-Original-Message-ID: <CAB9dFdtLHkpZqrmNEuMfPdOmZm32q5SXYx1zMexSd94rt3KyDw@mail.gmail.com>
Message-ID: <CAB9dFdtLHkpZqrmNEuMfPdOmZm32q5SXYx1zMexSd94rt3KyDw@mail.gmail.com>
Subject: Re: x86/paravirt: Use a single ops structure
To:     jgross@suse.com
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 23, 2018 at 2:37 PM Linux Kernel Mailing List
<linux-kernel@vger.kernel.org> wrote:
>
> Commit:     5c83511bdb9832c86be20fb86b783356e2f58062
> Parent:     27876f3882fdd4acb3d3614a0133ecdc777fc292
> Refname:    refs/heads/master
> Web:        https://git.kernel.org/torvalds/c/5c83511bdb9832c86be20fb86b783356e2f58062
> Author:     Juergen Gross <jgross@suse.com>
> AuthorDate: Tue Aug 28 09:40:19 2018 +0200
> Committer:  Thomas Gleixner <tglx@linutronix.de>
> CommitDate: Mon Sep 3 16:50:35 2018 +0200
>
>     x86/paravirt: Use a single ops structure
>
>     Instead of using six globally visible paravirt ops structures combine
>     them in a single structure, keeping the original structures as
>     sub-structures.
>
>     This avoids the need to assemble struct paravirt_patch_template at
>     runtime on the stack each time apply_paravirt() is being called (i.e.
>     when loading a module).

The above commit replaces pv_lock_ops, which was EXPORT_SYMBOL, with
something that is part of pv_ops, which is EXPORT_SYMBOL_GPL.    When
CONFIG_PARAVIRT_SPINLOCKS is set, this has the side effect of making
spin_lock() unusable by out of tree modules, which will likely be an
issue for many, if not most of them.

Marc
