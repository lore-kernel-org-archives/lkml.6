Return-Path: <SRS0=wmYC=LT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9241CC433F5
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 11:30:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 478FB20861
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 11:30:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=android.com header.i=@android.com header.b="iaLdiUTX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 478FB20861
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=android.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727597AbeIEP7v (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Sep 2018 11:59:51 -0400
Received: from mail-it0-f66.google.com ([209.85.214.66]:40714 "EHLO
        mail-it0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727527AbeIEP7v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Sep 2018 11:59:51 -0400
Received: by mail-it0-f66.google.com with SMTP id h23-v6so8963092ita.5
        for <linux-kernel@vger.kernel.org>; Wed, 05 Sep 2018 04:30:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=android.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=7L59LY3b3bTtcH6wEuj1SCn9APRMiyCaX6WHf6zf8hA=;
        b=iaLdiUTX+759h9UPlKy5iM2X6lyRAkkB5216PHNiGyAeScyfPonq3mn7s3fblJNXgc
         3ERqz0Xwbo6NdzbPDy3zySkObfx7JESyHxkpc2ZWuqAVwAjSvAN6V7ouYKDRED7eGDOZ
         hgGVJ5Q83dNKF+QwOANZgRg6Qa3J3blJjUCqGCnMTih/hTXAklAZGVSTRVuZo9CwLWV9
         nhtMv2VD8kp4CWQwKt4S3XpEy6CjySCnFRfsGpup0BPCtbFl4RG4QLOxyfIdrb8kAEsH
         0uvyebSC8hPVhGP5MmjJ5NjAG3RWFkwQudyad5yemFYQTCF1Bp1TSeMMefBbnO0EhswX
         mVwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=7L59LY3b3bTtcH6wEuj1SCn9APRMiyCaX6WHf6zf8hA=;
        b=CUVJOLKH9yAJY5+qo/IVePr9cRaHpDuD2TrulpYtNzA5jKTL26tjLc5bBav5LQ94e1
         3kJqcP8VLFGI+4kNBU3dNKoA3L2cTodF0VS4q7R7BrMy/84HoRZJBCYi5+oytB0StTz4
         UhtKeuGg7m9dMmb5g68e57KZ/0rOln8ZZNDsxqYJPWsPWIMw825f+SPbo3VGiA2Y7eNY
         rcbt+yrUF9J/deE85NGtryu5sIxUKgruz72y4e4colS0E4l8Y1dH1b7XtJwr7Wj3pJTh
         /boXMbKI1uioxyWrG+iUqsIxqL7agZXHenFK4s1wiNOQ7KEs4THmE2PqfjSm3kLq2m12
         zz5A==
X-Gm-Message-State: APzg51CkBre8TWTRIfXgV7CS/QarCVC8QQE+OlFW/56HkhuukKrj9/0i
        0uTI/u3QLENK4RVxHCip4Keqre5QRzuc3o9dgg3XaA==
X-Google-Smtp-Source: ANB0VdZyS1sz4B6AWtZsnOwhM4IFSu4yonVfgwpDOxg3I/JGR2ablvXmAmgq3Dd831NACHE5d/XwB5dhI36I5s7Q1cc=
X-Received: by 2002:a24:9301:: with SMTP id y1-v6mr3187634itd.29.1536147001714;
 Wed, 05 Sep 2018 04:30:01 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a4f:2547:0:0:0:0:0 with HTTP; Wed, 5 Sep 2018 04:30:01 -0700 (PDT)
In-Reply-To: <20180905090925.474dugeix3ssykcz@mwanda>
References: <20180905073346.157318-1-maco@android.com> <20180905090925.474dugeix3ssykcz@mwanda>
From:   Martijn Coenen <maco@android.com>
Date:   Wed, 5 Sep 2018 13:30:01 +0200
Message-ID: <CAB0TPYGfs0g0eDPS7+BY+waK7XoAWi-cYCBVfXfV+w_8TSApgw@mail.gmail.com>
Subject: Re: [PATCH] ANDROID: binder: Add BINDER_GET_NODE_INFO_FOR_REF ioctl.
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     Greg KH <gregkh@linuxfoundation.org>, Todd Kjos <tkjos@google.com>,
        =?UTF-8?B?QXJ2ZSBIasO4bm5ldsOlZw==?= <arve@android.com>,
        Amit Pundir <amit.pundir@linaro.org>,
        "open list:ANDROID DRIVERS" <devel@driverdev.osuosl.org>,
        Steven Moreland <smoreland@google.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Robert Benea <robenea@google.com>,
        Martijn Coenen <maco@google.com>,
        John Stultz <john.stultz@linaro.org>, peskal@google.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 5, 2018 at 11:09 AM, Dan Carpenter <dan.carpenter@oracle.com> wrote:
> What's the reserved for?  On 64 bit systems there is a 4 byte struct
> hole between weak_count and reserved.

There's many more pieces of information that we hold for a node. While
we don't have a use for most of that now, we may want some of it in
the future, and so I thought it would be wise to reserve some space
here so we don't need a new ioctl when that happens. I'm actually not
sure it's common to do things this way.

> Why not just make reserved a
> __u32 and get rid of the hole?  (Not rhetorical, I have no idea).

Because I thought 8 bytes of reserved space would be nice :-) But you
have a good point re:alignment, I should make it two __u32's then.

>
> Btw, people sometimes complain about that we don't check that user input
> is zeroed in ioctls.  Like for example maybe they're passing random data
> in the the strong_count field and then later we decide that actually
> that field should mean something but we can't make it mean anything
> because we've been letting the user put whatever they want there.  These
> are just random thoughts in my head, not necessarily important.

That's a good point, I will change the code to check for that.

Thanks,
Martijn

>
> regards,
> dan carpenter
>
