Return-Path: <SRS0=LZPJ=LZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEC8CC04ABB
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 18:45:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 54D7120839
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 18:45:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="eATSZihm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 54D7120839
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727835AbeIKXq3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Sep 2018 19:46:29 -0400
Received: from mail-io0-f196.google.com ([209.85.223.196]:45033 "EHLO
        mail-io0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726622AbeIKXq3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Sep 2018 19:46:29 -0400
Received: by mail-io0-f196.google.com with SMTP id 75-v6so4404031iou.11
        for <linux-kernel@vger.kernel.org>; Tue, 11 Sep 2018 11:45:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8jiikg2yuZ2OegYN366yM5t048r/tzoSKMtRT7Fwkgc=;
        b=eATSZihmD8OTKLlgYtRXOTGhoNn1LPXQ6rquSHkzgtcUgQeYf8xb6sAc2SmQXZZ0H/
         BH40hkVD4ylWLKIrCG+H5LY5oj2jGZPjSgwH5ktWfm8x2lZ3yMdfbu/fkTkpPZV/TBZB
         2rM6LvX8Mcu8jYQoDo5lhPeh65jSMAfv5e6Ms=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8jiikg2yuZ2OegYN366yM5t048r/tzoSKMtRT7Fwkgc=;
        b=fxwhJQSKIXnR7VHQgEcHjPuz17zO/Pa2B5O3gyXNoPpTCiL+F8IAK471XiHzrGNMpz
         BqB/QEQaDUkeOoOVH44VxifR5J1KMTYqUTyAvb8YUBKwalYhqgyOnNzVLruEeqU5u8TV
         G/uE+NGXQnMkevOzmzfW978I58v8VDWRVbJwu0WwfRk79J7O7ywFXVE866UTLAlTACZh
         Xzv2OevKKiDTu2df2vDsFTzNt3rEPm1i1BmctCPZfs04HmuRtKsoc+ZHw7nkjP0zvJgd
         9qQSJz1BljBzdPdllLbnl1XD4XMpdyoTVzqDJns2iL3tYX2Wpxw5fEYI57FvSZSZdoWs
         vaFA==
X-Gm-Message-State: APzg51API2Jx2c5KWfi8d2sE35KE4zmJ42zx1EEOk4RBa4hOI+SV9HgC
        YuyDlrsBw1n5fj5DplOKqC7/ID2C7FtvPgIkswUI3A==
X-Google-Smtp-Source: ANB0Vda9Lf9TVkDfs0nNbIXGkxZE+YH6IL4gfhdO6ZrwwNNcF5GPOPdTRMEXu8Wx4CZP72+s7jPuosMJYZ72LzqmfdQ=
X-Received: by 2002:a6b:f815:: with SMTP id o21-v6mr24106933ioh.203.1536691551979;
 Tue, 11 Sep 2018 11:45:51 -0700 (PDT)
MIME-Version: 1.0
References: <20180907154516.GG12788@arm.com> <CA+55aFw97E=pUTRejXDAVYbK90cgF=1R3MPxE3t9fDoKctOGNA@mail.gmail.com>
 <20180910174547.GD19027@arm.com>
In-Reply-To: <20180910174547.GD19027@arm.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 11 Sep 2018 08:45:40 -1000
Message-ID: <CA+55aFwk5mX2T_6cXF5LtKS3BfrKTKVPdy4hB0Vud3hqWmUbXQ@mail.gmail.com>
Subject: Re: [GIT PULL] arm64: fix for -rc3
To:     Will Deacon <will.deacon@arm.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Catalin Marinas <catalin.marinas@arm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 10, 2018 at 7:45 AM Will Deacon <will.deacon@arm.com> wrote:
>
> Happy to send as a proper patch if you think this is the right sort of
> idea.

Looks sane to me,

            Linus
