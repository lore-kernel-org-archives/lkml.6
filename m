Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67A18C5ACCC
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 21:02:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 287FC2086E
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 21:02:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="v8KFB2FV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 287FC2086E
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726988AbeJQEy2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Oct 2018 00:54:28 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:34875 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725960AbeJQEy2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Oct 2018 00:54:28 -0400
Received: by mail-lj1-f195.google.com with SMTP id o14-v6so22289373ljj.2
        for <linux-kernel@vger.kernel.org>; Tue, 16 Oct 2018 14:02:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/L7vfKT1keO4JMijtJelS+0vXzR6hSBZqz3nUHjBSyc=;
        b=v8KFB2FVDecrSH1EHp8K5gXha48/0SO6HfdgftMmE2ZS/A8gkB4+6hJnZFZDDTQ/rL
         01ZVrPmdwR1lVfwmPvSl6fB/HRJdLS4xJ1++OFFZTLcixM1SMS8Jf4UA8k6L27vFysZo
         iT9PjHrbHx9U+1d2fFHpDltOBavET5x+pgSamfKdyShwjIwzbhyqTt4HzP2sbSlLqBWy
         2zPfulqJwx80AtdJi5UheEIjR1uWHEDC2LfALN2xbNSVlYGCCg0eQy4o/FqFezg99itx
         b3S7XEXhz8qm/QgRNayK2CLFfXSkpR0bo1gN2W7HA4csOplaINnEyJUacHtleVicsfed
         OB0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/L7vfKT1keO4JMijtJelS+0vXzR6hSBZqz3nUHjBSyc=;
        b=szbdJ0a9d7gh9PlO0qEQXZjKeB1v8vDH4SpBXZ5rNMz5IZtF+WY6RbZWOCxIXp3uxZ
         ew9dHnLiwHKVG2TdlwSrfwqKL7XelQ6c/mUmobDneotYT+v2ZxDlYmAvoh2CyzvtQwOi
         JhLv1uVyLg6dXJdl2LoQMbcsjTFJ7/wJSm6K6rSPPKwclGOWSZw1/kItGOqHUtwJwBjg
         j7nt5mg3+CUGFp5qfkGdexcZn2Sd0JPI5+aEyv5qZegl9pPB6er2S+1fisR4KB5WZmR0
         +X4H5ySuTGrUK8wD6H6mwEiNAdLB2uJ05U+mJWnja2Pam7LTP+vJbvFsV95z8NnbPDEu
         7OPw==
X-Gm-Message-State: ABuFfojR48MQowDQ9F9MCca5Q2i11fngT7n+3mgisy85N2eYDOJ9P0Ge
        cLbTcPDSiE/vx/YkJOCv8n5dKSQNurevL1DOErrNFA==
X-Google-Smtp-Source: ACcGV62DvtTBAjFqjfDk9C7AzhnBljyHEQyOjeTU9dtbqrhBu6oawV6YUa89RFsFbh3juok36Iz6vylruWSHWMCSQdU=
X-Received: by 2002:a2e:7017:: with SMTP id l23-v6mr10311025ljc.160.1539723733115;
 Tue, 16 Oct 2018 14:02:13 -0700 (PDT)
MIME-Version: 1.0
References: <20181003171720.169953-1-rkir@google.com> <20181003171720.169953-9-rkir@google.com>
 <20181015183807.GA6905@kroah.com> <CAOGAQeo31ggKCHsJw3D297J6Ya1kq8MptTaDR7q6H7-q99sdGw@mail.gmail.com>
 <20181015190134.GA6700@kroah.com> <CAOGAQepAqCorTosBwqJq-Kez=MUThv35JM=S8jfZEkkk1Xr9jw@mail.gmail.com>
 <20181016062924.GB882@kroah.com>
In-Reply-To: <20181016062924.GB882@kroah.com>
From:   Roman Kiryanov <rkir@google.com>
Date:   Tue, 16 Oct 2018 14:02:01 -0700
Message-ID: <CAOGAQeo-4GF9uMe5WSosX9njOporqhkQyhPvzpG7mmNdq5Gh1w@mail.gmail.com>
Subject: Re: [PATCH v3 09/15] platform: goldfish: pipe: Move goldfish_pipe to goldfish_pipe_v2
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org, Todd Kjos <tkjos@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> > I don't want to mix v1 and v2.
>
> Why?  What is the difference?
> Why do you even need/want 2 different drivers here

In old emulators we implemented the device differently, so we need a
different driver.

>  for something that really should be done with the virtio
> interface instead?

We are already looking into virtio. But we did not find a userspace
API that virtio provides to
replace our pipe. The closest we found is virtqueue, but it is a
kernel thing. So we will
need goldfish_pipe_v3.

> > I don't see how userspace could be affected, unless we refer to
> > __FILE__ inside the driver for some important things. I believe we
> > don't.
>
> How does your userspace know what module to automatically load?  That's
> what usually breaks if you do not have proper platform binding happening
> automatically.

I am not sure if I understand your question.

Userspace opens the device by its name. The device name is hardcoded:

#define DEVICE_NAME "goldfish_pipe"

https://android.googlesource.com/kernel/goldfish/+/android-goldfish-4.14-dev/drivers/platform/goldfish/goldfish_pipe.h#19

I still don't understand how kernel filenames are involved (and
whether should they) into userpspace.
